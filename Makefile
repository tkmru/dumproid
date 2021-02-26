GOCMD=go
GOTEST=$(GOCMD) test -v
GOBUILD=$(GOCMD) build
BINARY_NAME=dumproid
DEVICES:=$(shell adb devices | grep -c 'device$$')
# Choose the architecture for your device
ARCH=arm
#ARCH=arm64

all: build deploy

test:
	$(GOTEST) ./pkg/*

build:
	GOOS=linux GOARCH=$(ARCH) GOARM=7 $(GOBUILD) -o $(BINARY_NAME)

clean:
	rm $(BINARY_NAME)

deploy:
ifeq ($(DEVICES), 1)
	$(SHELL) -c "adb push $(BINARY_NAME) /data/local/tmp/$(BINARY_NAME)"
else
	@echo 'Android device is not connected....'
endif
