#!/bin/bash

set -e

cd $(dirname ${0})
PAWPAW_ROOT="${PWD}"

# ---------------------------------------------------------------------------------------------------------------------
# check target

target="${1}"

if [ -z "${target}" ]; then
    echo "usage: ${0} <target>"
    exit 1
fi

# ---------------------------------------------------------------------------------------------------------------------
# run bootstrap dependencies

export PAWPAW_SKIP_GLIB=1
export PAWPAW_SKIP_LV2=1
export PAWPAW_SKIP_SAMPLERATE=1

# we just build the whole thing on Windows
if [ "${target}" != "win32" ] && [ "${target}" != "win64" ]; then
    export PAWPAW_SKIP_QT=1
fi

./bootstrap-common.sh "${target}"
./bootstrap-plugins.sh "${target}"
./bootstrap-carla.sh "${target}"

# ---------------------------------------------------------------------------------------------------------------------
