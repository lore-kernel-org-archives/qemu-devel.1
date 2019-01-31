Received: from eggs.gnu.org ([209.51.188.92]:39071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpFnx-0002qp-Rd
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpFnv-0005Fn-JQ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:07:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpFnv-0005F2-9V
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:07:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so3262076wmc.5
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 09:07:06 -0800 (PST)
References: <20190124203959.30875-1-lersek@redhat.com>
	<20190124203959.30875-5-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6d5868f5-70b4-71e2-3495-8d47156148c1@redhat.com>
Date: Thu, 31 Jan 2019 18:07:03 +0100
MIME-Version: 1.0
In-Reply-To: <20190124203959.30875-5-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tests/uefi-test-tools: add build
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

Hi Laszlo,

On 1/24/19 9:39 PM, Laszlo Ersek wrote:
> Introduce the following build scripts under "tests/uefi-test-tools":
> 
> * "build.sh" builds a single module (a UEFI application) from
>   UefiTestToolsPkg, for a single QEMU emulation target.
> 
>   "build.sh" relies on cross-compilers when the emulation target and the
>   build host architecture don't match. The cross-compiler prefix is
>   computed according to a fixed, Linux-specific pattern. No attempt is
>   made to copy or reimplement the GNU Make magic from "qemu/roms/Makefile"
>   for cross-compiler prefix determination. The reason is that the build
>   host OSes that are officially supported by edk2, and those that are
>   supported by QEMU, intersect only in Linux. (Note that the UNIXGCC
>   toolchain is being removed from edk2,
>   <https://bugzilla.tianocore.org/show_bug.cgi?id=1377>.)
> 
> * "Makefile" currently builds the "UefiTestToolsPkg/BiosTablesTest"
>   application, for arm, aarch64, i386, and x86_64, with the help of
>   "build.sh".
> 
>   "Makefile" turns each resultant UEFI executable into a UEFI-bootable,
>   qcow2-compressed ISO image. The ISO images are output as
>   "tests/data/uefi-boot-images/bios-tables-test.<TARGET>.iso.qcow2".
> 
>   Each ISO image should be passed to QEMU as follows:
> 
>     -drive id=boot-cd,if=none,readonly,format=qcow2,file=$ISO \
>     -device virtio-scsi-pci,id=scsi0 \
>     -device scsi-cd,drive=boot-cd,bus=scsi0.0,bootindex=0 \
> 
>   "Makefile" assumes that "mkdosfs", "mtools", and "genisoimage" are
>   present.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
> 
> Notes:
>     v2:
>     - add the .NOTPARALLEL target [Phil, help-make, edk2-devel]
> 
>  tests/uefi-test-tools/Makefile   |  97 +++++++++++++
>  tests/uefi-test-tools/.gitignore |   3 +
>  tests/uefi-test-tools/build.sh   | 145 ++++++++++++++++++++
>  3 files changed, 245 insertions(+)
> 
> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makefile
> new file mode 100644
> index 000000000000..61d263861e01
> --- /dev/null
> +++ b/tests/uefi-test-tools/Makefile
> @@ -0,0 +1,97 @@
> +# Makefile for the test helper UEFI applications that run in guests.
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
> +edk2_dir              := ../../roms/edk2
> +images_dir            := ../data/uefi-boot-images
> +emulation_targets     := arm aarch64 i386 x86_64
> +uefi_binaries         := bios-tables-test
> +intermediate_suffixes := .efi .fat .iso.raw
> +
> +images: $(foreach binary,$(uefi_binaries), \
> +		$(foreach target,$(emulation_targets), \
> +			$(images_dir)/$(binary).$(target).iso.qcow2))
> +
> +# Preserve all intermediate targets if the build succeeds.
> +# - Intermediate targets help with development & debugging.
> +# - Preserving intermediate targets also keeps spurious changes out of the
> +#   final build products, in case the user re-runs "make" without any changes
> +#   to the UEFI source code. Normally, the intermediate files would have been
> +#   removed by the last "make" invocation, hence the re-run would rebuild them
> +#   from the unchanged UEFI sources. Unfortunately, the "mkdosfs" and
> +#   "genisoimage" utilities embed timestamp-based information in their outputs,
> +#   which causes git to report differences for the tracked qcow2 ISO images.
> +.SECONDARY: $(foreach binary,$(uefi_binaries), \
> +		$(foreach target,$(emulation_targets), \
> +			$(foreach suffix,$(intermediate_suffixes), \
> +				Build/$(binary).$(target)$(suffix))))
> +
> +# In the pattern rules below, the stem (%, $*) stands for
> +# "$(binary).$(target)".
> +
> +# Convert the raw ISO image to a qcow2 one, enabling compression, and using a
> +# small cluster size. This allows for small binary files under git control,
> +# hence for small binary patches.
> +$(images_dir)/%.iso.qcow2: Build/%.iso.raw
> +	mkdir -p -- $(images_dir)
> +	$${QTEST_QEMU_IMG:-qemu-img} convert -f raw -O qcow2 -c \
> +		-o cluster_size=512 -- $< $@
> +
> +# Embed the "UEFI system partition" into an ISO9660 file system as an ElTorito
> +# boot image.
> +Build/%.iso.raw: Build/%.fat
> +	genisoimage -input-charset ASCII -efi-boot $(notdir $<) -no-emul-boot \
> +		-quiet -o $@ -- $<
> +
> +# Define chained macros in order to map QEMU system emulation targets to
> +# *short* UEFI architecture identifiers. Periods are allowed in, and ultimately
> +# stripped from, the argument.
> +map_arm_to_uefi     = $(subst arm,ARM,$(1))
> +map_aarch64_to_uefi = $(subst aarch64,AA64,$(call map_arm_to_uefi,$(1)))
> +map_i386_to_uefi    = $(subst i386,IA32,$(call map_aarch64_to_uefi,$(1)))
> +map_x86_64_to_uefi  = $(subst x86_64,X64,$(call map_i386_to_uefi,$(1)))
> +map_to_uefi         = $(subst .,,$(call map_x86_64_to_uefi,$(1)))
> +
> +# Format a "UEFI system partition", using the UEFI binary as the default boot
> +# loader. Add 10% size for filesystem metadata, round up to the next KB, and
> +# make sure the size is large enough for a FAT filesystem. Name the filesystem
> +# after the UEFI binary. (Excess characters are automatically dropped from the
> +# filesystem label.)
> +Build/%.fat: Build/%.efi
> +	rm -f -- $@
> +	uefi_bin_b=$$(stat --format=%s -- $<) && \
> +		uefi_fat_kb=$$(( (uefi_bin_b * 11 / 10 + 1023) / 1024 )) && \
> +		uefi_fat_kb=$$(( uefi_fat_kb >= 64 ? uefi_fat_kb : 64 )) && \
> +		mkdosfs -C $@ -n $(basename $(@F)) -- $$uefi_fat_kb
> +	MTOOLS_SKIP_CHECK=1 mmd -i $@ ::EFI
> +	MTOOLS_SKIP_CHECK=1 mmd -i $@ ::EFI/BOOT
> +	MTOOLS_SKIP_CHECK=1 mcopy -i $@ -- $< \
> +		::EFI/BOOT/BOOT$(call map_to_uefi,$(suffix $*)).EFI
> +
> +# In the pattern rules below, the stem (%, $*) stands for "$(target)" only. The
> +# association between the UEFI binary (such as "bios-tables-test") and the
> +# component name from the edk2 platform DSC file (such as "BiosTablesTest") is
> +# explicit in each rule.
> +
> +# "build.sh" invokes the "build" utility of edk2 BaseTools. In any given edk2
> +# workspace, at most one "build" instance may be operating at a time. Therefore
> +# we must serialize the rebuilding of targets in this Makefile.
> +.NOTPARALLEL:

Well this doesn't seem to improve my case :|

You can test with:

$ alias make='make -j8 -l7.5'

So you get:

$ make print-MAKEFLAGS
MAKEFLAGS=rR -j8 -l7.5 --jobserver-auth=3,4

and this command fails:

$ make -C tests/uefi-test-tools Build/bios-tables-test.x86_64.efi

Now, using -j1 we have:

$ make print-MAKEFLAGS -j1
MAKEFLAGS=rR -j1 -l7.5

And the builds work:

$ make -j1 -C tests/uefi-test-tools Build/bios-tables-test.x86_64.efi

Reading 'info make' section "5.7.3 Communicating Options to a
Sub-'make'" I figured we can overwrite MAKEFLAGS, and this snippet works
like charm:

-- >8 --
@@ -84,8 +84,7 @@ Build/%.fat: Build/%.efi
 # "build.sh" invokes the "build" utility of edk2 BaseTools. In any
given edk2
 # workspace, at most one "build" instance may be operating at a time.
Therefore
 # we must serialize the rebuilding of targets in this Makefile.
-.NOTPARALLEL:
-
+Build/bios-tables-test.%.efi: MAKEFLAGS=
 Build/bios-tables-test.%.efi: build-edk2-tools
        ./build.sh $(edk2_dir) BiosTablesTest $* $@

---

I tested with:

$ rm -rf tests/uefi-test-tools/Build
$ make -C tests/uefi-test-tools \
  Build/bios-tables-test.{arm,aarch64,i386,x86_64}.efi images -j42

What do you think about using this snippet? I don't know if this is the
best way to solve this, but it works...
If you test/agree, Michael could eventually apply the snippet directly.

> +
> +Build/bios-tables-test.%.efi: build-edk2-tools
> +	./build.sh $(edk2_dir) BiosTablesTest $* $@
> +
> +build-edk2-tools:
> +	$(MAKE) -C $(edk2_dir)/BaseTools
> +
> +clean:
> +	rm -rf Build Conf log
> +	$(MAKE) -C $(edk2_dir)/BaseTools clean
> diff --git a/tests/uefi-test-tools/.gitignore b/tests/uefi-test-tools/.gitignore
> new file mode 100644
> index 000000000000..9f246701dea1
> --- /dev/null
> +++ b/tests/uefi-test-tools/.gitignore
> @@ -0,0 +1,3 @@
> +Build
> +Conf
> +log
> diff --git a/tests/uefi-test-tools/build.sh b/tests/uefi-test-tools/build.sh
> new file mode 100755
> index 000000000000..155cb75c4ddb
> --- /dev/null
> +++ b/tests/uefi-test-tools/build.sh
> @@ -0,0 +1,145 @@
> +#!/bin/bash
> +
> +# Build script that determines the edk2 toolchain to use, invokes the edk2
> +# "build" utility, and copies the built UEFI binary to the requested location.
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
> +program_name=$(basename -- "$0")
> +edk2_dir=$1
> +dsc_component=$2
> +emulation_target=$3
> +uefi_binary=$4
> +shift 4
> +
> +# Set up the environment for edk2 building.
> +export PACKAGES_PATH=$(realpath -- "$edk2_dir")
> +export WORKSPACE=$PWD
> +mkdir -p Conf
> +
> +# Source "edksetup.sh" carefully.
> +set +e +u +C
> +source "$PACKAGES_PATH/edksetup.sh"
> +ret=$?
> +set -e -u -C
> +if [ $ret -ne 0 ]; then
> +  exit $ret
> +fi
> +
> +# Map the QEMU system emulation target to the following types of architecture
> +# identifiers:
> +# - edk2,
> +# - gcc cross-compilation.
> +# Cover only those targets that are supported by the UEFI spec and edk2.
> +case "$emulation_target" in
> +  (arm)
> +    edk2_arch=ARM
> +    gcc_arch=arm
> +    ;;
> +  (aarch64)
> +    edk2_arch=AARCH64
> +    gcc_arch=aarch64
> +    ;;
> +  (i386)
> +    edk2_arch=IA32
> +    gcc_arch=i686
> +    ;;
> +  (x86_64)
> +    edk2_arch=X64
> +    gcc_arch=x86_64
> +    ;;
> +  (*)
> +    printf '%s: unknown/unsupported QEMU system emulation target "%s"\n' \
> +      "$program_name" "$emulation_target" >&2
> +    exit 1
> +    ;;
> +esac
> +
> +# Check if cross-compilation is needed.
> +host_arch=$(uname -m)
> +if [ "$gcc_arch" == "$host_arch" ] ||
> +   ( [ "$gcc_arch" == i686 ] && [ "$host_arch" == x86_64 ] ); then
> +  cross_prefix=
> +else
> +  cross_prefix=${gcc_arch}-linux-gnu-
> +fi
> +
> +# Expose cross_prefix (which is possibly empty) to the edk2 tools. While at it,
> +# determine the suitable edk2 toolchain as well.
> +# - For ARM and AARCH64, edk2 only offers the GCC5 toolchain tag, which covers
> +#   the gcc-5+ releases.
> +# - For IA32 and X64, edk2 offers the GCC44 through GCC49 toolchain tags, in
> +#   addition to GCC5. Unfortunately, the mapping between the toolchain tags and
> +#   the actual gcc releases isn't entirely trivial. Run "git-blame" on
> +#   "OvmfPkg/build.sh" in edk2 for more information.
> +# And, because the above is too simple, we have to assign cross_prefix to an
> +# edk2 build variable that is specific to both the toolchain tag and the target
> +# architecture.
> +case "$edk2_arch" in
> +  (ARM)
> +    edk2_toolchain=GCC5
> +    export GCC5_ARM_PREFIX=$cross_prefix
> +    ;;
> +  (AARCH64)
> +    edk2_toolchain=GCC5
> +    export GCC5_AARCH64_PREFIX=$cross_prefix
> +    ;;
> +  (IA32|X64)
> +    gcc_version=$("${cross_prefix}gcc" -v 2>&1 | tail -1 | awk '{print $3}')
> +    case "$gcc_version" in
> +      ([1-3].*|4.[0-3].*)
> +        printf '%s: unsupported gcc version "%s"\n' \
> +          "$program_name" "$gcc_version" >&2
> +        exit 1
> +        ;;
> +      (4.4.*)
> +        edk2_toolchain=GCC44
> +        ;;
> +      (4.5.*)
> +        edk2_toolchain=GCC45
> +        ;;
> +      (4.6.*)
> +        edk2_toolchain=GCC46
> +        ;;
> +      (4.7.*)
> +        edk2_toolchain=GCC47
> +        ;;
> +      (4.8.*)
> +        edk2_toolchain=GCC48
> +        ;;
> +      (4.9.*|6.[0-2].*)
> +        edk2_toolchain=GCC49
> +        ;;
> +      (*)
> +        edk2_toolchain=GCC5
> +        ;;
> +    esac
> +    eval "export ${edk2_toolchain}_BIN=\$cross_prefix"
> +    ;;
> +esac
> +
> +# Build the UEFI binary
> +mkdir -p log
> +build \
> +  --arch="$edk2_arch" \
> +  --buildtarget=DEBUG \
> +  --platform=UefiTestToolsPkg/UefiTestToolsPkg.dsc \
> +  --tagname="$edk2_toolchain" \
> +  --module="UefiTestToolsPkg/$dsc_component/$dsc_component.inf" \
> +  --log="log/$dsc_component.$edk2_arch.log" \
> +  --report-file="log/$dsc_component.$edk2_arch.report"
> +cp -a -- \
> +  "Build/UefiTestTools/DEBUG_${edk2_toolchain}/$edk2_arch/$dsc_component.efi" \
> +  "$uefi_binary"
> 
