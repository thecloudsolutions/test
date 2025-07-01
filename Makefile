##-----------------------------------------------------------------------------------
# Create a README.md
#-----------------------------------------------------------------------------------
SHELL := /bin/bash

# List of targets the `readme` target should call before generating the readme
export README_INCLUDES ?= $(file://$(shell pwd)/?type=text/plain)

export README_FILE ?= README.md
export README_YAML ?= README.yaml
export README_TEMPLATE_FILE ?= README.md.gotmpl

## Install gomplate if not already installed
install-gomplate:
	@if ! command -v gomplate &> /dev/null; then \
		echo "gomplate could not be found, installing..."; \
		curl -Lo /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/v3.10.0/gomplate_linux-amd64; \
		chmod +x /usr/local/bin/gomplate; \
	fi;

## Create README.md by building it from README.yaml
readme: install-gomplate
	@gomplate --file $(README_TEMPLATE_FILE) --out $(README_FILE)
	@echo "Generated $(README_FILE) from $(README_TEMPLATE_FILE) using data from $(README_YAML)"
