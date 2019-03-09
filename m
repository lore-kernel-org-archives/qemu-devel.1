Received: from eggs.gnu.org ([209.51.188.92]:40560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2f9S-0008AZ-Ew
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 11:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2f9R-0007BF-0z
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 11:48:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2f9Q-0007AW-Pk
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 11:48:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so558218wmj.0
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 08:48:44 -0800 (PST)
References: <20190309004826.9027-1-lersek@redhat.com>
	<20190309004826.9027-8-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <137d7a76-5d69-6b8c-a048-c296849fec9e@redhat.com>
Date: Sat, 9 Mar 2019 17:48:41 +0100
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
[...]

Trying on Ubuntu I get:

$ make -C roms efi
[...]
Fd File Name:QEMU_EFI
(/home/phil/source/qemu/roms/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd)
Fd File Name:QEMU_VARS
(/home/phil/source/qemu/roms/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_VARS.fd)
GUID cross reference file can be found at
/home/phil/source/qemu/roms/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/Guid.xref
- Done -
Build end time: 16:33:29, Mar.09 2019
Build total time: 00:03:35
cp edk2/Build/ArmVirtQemu-AARCH64/DEBUG_/FV/QEMU_EFI.fd \
	../pc-bios/edk2-aarch64-code.fd
cp: cannot stat 'edk2/Build/ArmVirtQemu-AARCH64/DEBUG_/FV/QEMU_EFI.fd':
No such file or directory
Makefile.edk2:45: recipe for target '../pc-bios/edk2-aarch64-code.fd' failed
make[1]: *** [../pc-bios/edk2-aarch64-code.fd] Error 1
make[1]: Leaving directory '/home/phil/source/qemu/roms'
Makefile:148: recipe for target 'efi' failed
make: *** [efi] Error 2
make: Leaving directory '/home/phil/source/qemu/roms'

The edk2-build.sh script source edksetup.sh, then you call the
'toolchain' command out of the edk2-build.sh script, but here
the edksetup.sh setup is no more effective.

Regards,

Phil.
