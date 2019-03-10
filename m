Received: from eggs.gnu.org ([209.51.188.92]:44540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2wmV-00077S-BI
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2waq-0003Tz-RM
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:26:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2wan-0003Sl-QZ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:26:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id o9so1989209wrv.9
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 04:26:09 -0700 (PDT)
References: <20190309004826.9027-1-lersek@redhat.com>
	<20190309004826.9027-8-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <24ecfe4a-69ab-8cd5-95dc-8614a3720dbf@redhat.com>
Date: Sun, 10 Mar 2019 12:26:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190309004826.9027-8-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/10] roms: build edk2 firmware binaries
 and variable store templates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

Hi Laszlo,

On 3/9/19 1:48 AM, Laszlo Ersek wrote:
> Add the "efi" target to "Makefile".
> 
> Introduce "Makefile.edk2" for building and cleaning the firmware images
> and varstore templates.
> 
> Collect the common bits from the recipes in the helper script
> "edk2-build.sh".
> 
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  roms/Makefile      |   5 +
>  roms/Makefile.edk2 | 138 ++++++++++++++++++++
>  roms/edk2-build.sh |  55 ++++++++
>  3 files changed, 198 insertions(+)
> 
> diff --git a/roms/Makefile b/roms/Makefile
> index 2e83ececa25a..054b432834ba 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -61,6 +61,7 @@ default:
>  	@echo "  skiboot        -- update skiboot.lid"
>  	@echo "  u-boot.e500    -- update u-boot.e500"
>  	@echo "  u-boot.sam460  -- update u-boot.sam460"
> +	@echo "  efi            -- update UEFI (edk2) platform firmware"
>  
>  bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
>  	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
> @@ -143,6 +144,9 @@ skiboot:
>  	$(MAKE) -C skiboot CROSS=$(powerpc64_cross_prefix)
>  	cp skiboot/skiboot.lid ../pc-bios/skiboot.lid
>  
> +efi: edk2-basetools
> +	$(MAKE) -f Makefile.edk2
> +
>  clean:
>  	rm -rf seabios/.config seabios/out seabios/builds
>  	$(MAKE) -C sgabios clean
> @@ -153,3 +157,4 @@ clean:
>  	rm -rf u-boot/build.e500
>  	$(MAKE) -C u-boot-sam460ex distclean
>  	$(MAKE) -C skiboot clean
> +	$(MAKE) -f Makefile.edk2 clean
> diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
> new file mode 100644
> index 000000000000..ad6fff044cd6
> --- /dev/null
> +++ b/roms/Makefile.edk2
> @@ -0,0 +1,138 @@
> +# Makefile for building firmware binaries and variable store templates for a
> +# number of virtual platforms in edk2.
> +#
> +# Copyright (C) 2019, Red Hat, Inc.
> +#
> +# This program and the accompanying materials are licensed and made available
> +# under the terms and conditions of the BSD License that accompanies this
> +# distribution. The full text of the license may be found at
> +# <http://opensource.org/licenses/bsd-license.php>.
> +#
> +# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
> +# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
> +
> +toolchain = $(shell source ./edk2-funcs.sh && qemu_edk2_get_toolchain $(1))
> +
> +licenses := \
> +	edk2/License.txt \
> +	edk2/OvmfPkg/License.txt \
> +	edk2/CryptoPkg/Library/OpensslLib/openssl/LICENSE
> +
> +# The "edk2-arm-vars.fd" varstore template is suitable for aarch64 as well.
> +# Similarly, the "edk2-i386-vars.fd" varstore template is suitable for x86_64
> +# as well, independently of "secure" too.
> +all: \
> +	../pc-bios/edk2-aarch64-code.fd \
> +	../pc-bios/edk2-arm-code.fd \
> +	../pc-bios/edk2-i386-code.fd \
> +	../pc-bios/edk2-i386-secure-code.fd \
> +	../pc-bios/edk2-x86_64-code.fd \
> +	../pc-bios/edk2-x86_64-secure-code.fd \
> +	\
> +	../pc-bios/edk2-arm-vars.fd \
> +	../pc-bios/edk2-i386-vars.fd \
> +	\
> +	../pc-bios/edk2-licenses.txt
> +
> +submodules:
> +	cd edk2 && git submodule update --init --force
> +
> +# See notes on the ".NOTPARALLEL" target and the "+" indicator in
> +# "tests/uefi-test-tools/Makefile".
> +.NOTPARALLEL:
> +
> +../pc-bios/edk2-aarch64-code.fd: submodules
> +	+./edk2-build.sh \
> +		aarch64 \
> +		--arch=AARCH64 \
> +		--platform=ArmVirtPkg/ArmVirtQemu.dsc \
> +		-D NETWORK_IP6_ENABLE \
> +		-D HTTP_BOOT_ENABLE
> +	cp edk2/Build/ArmVirtQemu-AARCH64/DEBUG_$(call toolchain,aarch64)/FV/QEMU_EFI.fd \
> +		$@
> +	truncate --size=64M $@
> +
> +../pc-bios/edk2-arm-code.fd: submodules
> +	+./edk2-build.sh \
> +		arm \
> +		--arch=ARM \
> +		--platform=ArmVirtPkg/ArmVirtQemu.dsc \
> +		-D NETWORK_IP6_ENABLE \
> +		-D HTTP_BOOT_ENABLE
> +	cp edk2/Build/ArmVirtQemu-ARM/DEBUG_$(call toolchain,arm)/FV/QEMU_EFI.fd \
> +		$@
> +	truncate --size=64M $@
> +
> +../pc-bios/edk2-i386-code.fd: submodules
> +	+./edk2-build.sh \
> +		i386 \
> +		--arch=IA32 \
> +		--platform=OvmfPkg/OvmfPkgIa32.dsc \
> +		-D NETWORK_IP6_ENABLE \
> +		-D HTTP_BOOT_ENABLE \
> +		-D TLS_ENABLE \
> +		-D TPM2_ENABLE \
> +		-D TPM2_CONFIG_ENABLE
> +	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
> +
> +../pc-bios/edk2-i386-secure-code.fd: submodules
> +	+./edk2-build.sh \
> +		i386 \
> +		--arch=IA32 \
> +		--platform=OvmfPkg/OvmfPkgIa32.dsc \
> +		-D NETWORK_IP6_ENABLE \
> +		-D HTTP_BOOT_ENABLE \
> +		-D TLS_ENABLE \
> +		-D TPM2_ENABLE \
> +		-D TPM2_CONFIG_ENABLE \
> +		-D SECURE_BOOT_ENABLE \
> +		-D SMM_REQUIRE
> +	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
> +
> +../pc-bios/edk2-x86_64-code.fd: submodules
> +	+./edk2-build.sh \
> +		x86_64 \
> +		--arch=X64 \
> +		--platform=OvmfPkg/OvmfPkgX64.dsc \
> +		-D NETWORK_IP6_ENABLE \
> +		-D HTTP_BOOT_ENABLE \
> +		-D TLS_ENABLE \
> +		-D TPM2_ENABLE \
> +		-D TPM2_CONFIG_ENABLE
> +	cp edk2/Build/OvmfX64/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $@
> +
> +../pc-bios/edk2-x86_64-secure-code.fd: submodules
> +	+./edk2-build.sh \
> +		x86_64 \
> +		--arch=IA32 \
> +		--arch=X64 \
> +		--platform=OvmfPkg/OvmfPkgIa32X64.dsc \
> +		-D NETWORK_IP6_ENABLE \
> +		-D HTTP_BOOT_ENABLE \
> +		-D TLS_ENABLE \
> +		-D TPM2_ENABLE \
> +		-D TPM2_CONFIG_ENABLE \
> +		-D SECURE_BOOT_ENABLE \
> +		-D SMM_REQUIRE
> +	cp edk2/Build/Ovmf3264/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $@

Do you mind adding a $EDK2_BUILD_OPTIONS variable to optionally add
arguments from the environment? I figured it is useful for CI
integration to quiet the build output, else the CI stdout limit is
reached quickly.

I'll suggest a patch you can amend or improve :)

> +
> +../pc-bios/edk2-arm-vars.fd: ../pc-bios/edk2-arm-code.fd
> +	cp edk2/Build/ArmVirtQemu-ARM/DEBUG_$(call toolchain,arm)/FV/QEMU_VARS.fd \
> +		$@
> +	truncate --size=64M $@
> +
> +../pc-bios/edk2-i386-vars.fd: ../pc-bios/edk2-i386-code.fd
> +	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_VARS.fd $@
> +
> +# The license file accumulates several individual licenses from under edk2,
> +# prefixing each individual license with a header (generated by "tail") that
> +# states its pathname.
> +../pc-bios/edk2-licenses.txt: submodules
> +	tail -n $(shell cat $(licenses) | wc -l) $(licenses) > $@
> +	dos2unix $@
> +
> +clean:
> +	rm -rf edk2/Build
> +	cd edk2/Conf && \
> +		rm -rf .cache BuildEnv.sh build_rule.txt target.txt \
> +			tools_def.txt
> diff --git a/roms/edk2-build.sh b/roms/edk2-build.sh
> new file mode 100755
> index 000000000000..936d2c874a22
> --- /dev/null
> +++ b/roms/edk2-build.sh
> @@ -0,0 +1,55 @@
> +#!/bin/bash
> +
> +# Wrapper shell script for building a  virtual platform firmware in edk2.
> +#
> +# Copyright (C) 2019, Red Hat, Inc.
> +#
> +# This program and the accompanying materials are licensed and made available
> +# under the terms and conditions of the BSD License that accompanies this
> +# distribution. The full text of the license may be found at
> +# <http://opensource.org/licenses/bsd-license.php>.
> +#
> +# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
> +# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
> +
> +set -e -u -C
> +
> +# Save the command line arguments. We need to reset $# to 0 before sourcing
> +# "edksetup.sh", as it will inherit $@.
> +emulation_target=$1
> +shift
> +num_args=0
> +args=()
> +for arg in "$@"; do
> +  args[num_args++]="$arg"
> +done
> +shift $num_args
> +
> +cd edk2
> +
> +# Work around <https://bugzilla.tianocore.org/show_bug.cgi?id=1607>.
> +export PYTHON_COMMAND=python2
> +
> +# Source "edksetup.sh" carefully.
> +set +e +u +C
> +source ./edksetup.sh
> +ret=$?
> +set -e -u -C
> +if [ $ret -ne 0 ]; then
> +  exit $ret
> +fi
> +
> +# Fetch some option arguments, and set the cross-compilation environment (if
> +# any), for the edk2 "build" utility.
> +source ../edk2-funcs.sh
> +edk2_toolchain=$(qemu_edk2_get_toolchain "$emulation_target")
> +edk2_thread_count=$(qemu_edk2_get_thread_count "$MAKEFLAGS")
> +qemu_edk2_set_cross_env "$emulation_target"
> +
> +# Build the platform firmware.
> +build \
> +  --cmd-len=65536 \
> +  -n "$edk2_thread_count" \
> +  --buildtarget=DEBUG \
> +  --tagname="$edk2_toolchain" \
> +  "${args[@]}"
> 
