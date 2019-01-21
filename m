Received: from eggs.gnu.org ([209.51.188.92]:60587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glYWI-0000d2-9f
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glYWG-0003tq-8Y
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:17:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glYWE-0003oK-5t
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:17:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so23014458wrt.13
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 04:17:30 -0800 (PST)
References: <20190118223400.24311-1-lersek@redhat.com>
	<20190118223400.24311-5-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fd79f085-f3d8-dc06-9d43-9c4fcea69317@redhat.com>
Date: Mon, 21 Jan 2019 13:17:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190118223400.24311-5-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/5] tests/uefi-test-tools: add build
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

Hi Laszlo,

On 1/18/19 11:33 PM, Laszlo Ersek wrote:
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
>  tests/uefi-test-tools/Makefile   |  92 +++++++++++++
>  tests/uefi-test-tools/.gitignore |   3 +
>  tests/uefi-test-tools/build.sh   | 145 ++++++++++++++++++++
>  3 files changed, 240 insertions(+)
> 
> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makefile
> new file mode 100644
> index 000000000000..7b6dd227e433
> --- /dev/null
> +++ b/tests/uefi-test-tools/Makefile
> @@ -0,0 +1,92 @@
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
> +Build/bios-tables-test.%.efi: build-edk2-tools
> +	./build.sh $(edk2_dir) BiosTablesTest $* $@
> +
> +build-edk2-tools:
> +	$(MAKE) -C $(edk2_dir)/BaseTools
> +
[...]

I got errors [1] and [2] I couldn't figure out while running 'make -j4'.

The following patch didn't help, any idea?

-- >8 --
diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makefile
index 7b6dd227e4..798c55c823 100644
--- a/tests/uefi-test-tools/Makefile
+++ b/tests/uefi-test-tools/Makefile
@@ -81,6 +81,8 @@ Build/%.fat: Build/%.efi
 # component name from the edk2 platform DSC file (such as
"BiosTablesTest") is
 # explicit in each rule.

+.NOTPARALLEL: $(foreach
target,$(emulation_targets),Build/bios-tables-test.$(target).efi)
+
 Build/bios-tables-test.%.efi: build-edk2-tools
        ./build.sh $(edk2_dir) BiosTablesTest $* $@

diff --git a/tests/uefi-test-tools/build.sh b/tests/uefi-test-tools/build.sh
index 155cb75c4d..13891a7385 100755
--- a/tests/uefi-test-tools/build.sh
+++ b/tests/uefi-test-tools/build.sh
@@ -133,6 +133,7 @@ esac
 # Build the UEFI binary
 mkdir -p log
 build \
+  -n 1 \
   --arch="$edk2_arch" \
   --buildtarget=DEBUG \
   --platform=UefiTestToolsPkg/UefiTestToolsPkg.dsc \
---

Anyway building using "make -j1" works.

[1]:

    Building ...
qemu/roms/edk2/ArmPkg/Library/CompilerIntrinsicsLib/CompilerIntrinsicsLib.inf
[ARM]
    make[1]: Entering directory
'qemu/tests/uefi-test-tools/Build/UefiTestTools/DEBUG_GCC5/ARM/ArmPkg/Library/CompilerIntrinsicsLib/CompilerIntrinsicsLib'
    "arm-linux-gnu-gcc" -mthumb -march=armv7-a -E -x assembler-with-cpp
-include
qemu/tests/uefi-test-tools/Build/UefiTestTools/DEBUG_GCC5/ARM/ArmPkg/Library/CompilerIntrinsicsLib/CompilerIntrinsicsLib/DEBUG/AutoGen.h
-Iqemu/roms/edk2/ArmPkg/Library/CompilerIntrinsicsLib/Arm
-Iqemu/roms/edk2/ArmPkg/Library/CompilerIntrinsicsLib
-Iqemu/tests/uefi-test-tools/Build/UefiTestTools/DEBUG_GCC5/ARM/ArmPkg/Library/CompilerIntrinsicsLib/CompilerIntrinsicsLib/DEBUG
-Iqemu/roms/edk2/MdePkg -Iqemu/roms/edk2/MdePkg/Include
-Iqemu/roms/edk2/MdePkg/Include/Arm -Iqemu/roms/edk2/ArmPkg
-Iqemu/roms/edk2/ArmPkg/Include
qemu/roms/edk2/ArmPkg/Library/CompilerIntrinsicsLib/Arm/divsi3.S >
qemu/tests/uefi-test-tools/Build/UefiTestTools/DEBUG_GCC5/ARM/ArmPkg/Library/CompilerIntrinsicsLib/CompilerIntrinsicsLib/OUTPUT/Arm/divsi3.i
    make[1]: *** read jobs pipe: Bad file descriptor.  Stop.
    make[1]: *** Waiting for unfinished jobs....
    build.py...
     : error 7000: Failed to execute command
        make tbuild
[qemu/tests/uefi-test-tools/Build/UefiTestTools/DEBUG_GCC5/ARM/ArmPkg/Library/CompilerIntrinsicsLib/CompilerIntrinsicsLib]


    build.py...
     : error F002: Failed to build module

qemu/roms/edk2/ArmPkg/Library/CompilerIntrinsicsLib/CompilerIntrinsicsLib.inf
[ARM, GCC5, DEBUG]

    - Failed -
    Build end time: 13:08:01, Jan.21 2019
    Build total time: 00:00:02

[2]:

    Active Platform          =
qemu/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
    Active Module            =
qemu/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf

    Processing meta-data .

    build.py...
     : error C0DE: Unknown fatal error when processing
[qemu/roms/edk2/MdePkg/MdePkg.dec]

    (Please send email to edk2-devel@lists.01.org for help, attaching
following call stack trace!)

    (Python 2.7.15 on linux2) Traceback (most recent call last):
      File
"qemu/roms/edk2/BaseTools/BinWrappers/PosixLike/../../Source/Python/build/build.py",
line 2494, in Main
        MyBuild.Launch()
      File
"qemu/roms/edk2/BaseTools/BinWrappers/PosixLike/../../Source/Python/build/build.py",
line 2231, in Launch
        self._BuildModule()
      File
"qemu/roms/edk2/BaseTools/BinWrappers/PosixLike/../../Source/Python/build/build.py",
line 1837, in _BuildModule
        self.ModuleFile
      File "qemu/roms/edk2/BaseTools/Source/Python/AutoGen/AutoGen.py",
line 241, in __init__
        self._InitWorker(Workspace, MetaFile, Target, Toolchain, Arch,
*args, **kwargs)
      File "qemu/roms/edk2/BaseTools/Source/Python/AutoGen/AutoGen.py",
line 405, in _InitWorker
        PlatformPcds = Platform.Pcds
      File
"qemu/roms/edk2/BaseTools/Source/Python/Workspace/DscBuildData.py", line
1176, in Pcds
        self._Pcds.update(self._GetPcd(MODEL_PCD_FIXED_AT_BUILD))
      File
"qemu/roms/edk2/BaseTools/Source/Python/Workspace/DscBuildData.py", line
1601, in _GetPcd
        PcdValue, DatumType, MaxDatumSize = self._ValidatePcd(PcdCName,
TokenSpaceGuid, Setting, Type, Dummy4)
      File
"qemu/roms/edk2/BaseTools/Source/Python/Workspace/DscBuildData.py", line
897, in _ValidatePcd
        self._DecPcds, self._GuidDict = GetDeclaredPcd(self, self._Bdb,
self._Arch, self._Target, self._Toolchain, PkgSet)
      File
"qemu/roms/edk2/BaseTools/Source/Python/Workspace/WorkspaceCommon.py",
line 68, in GetDeclaredPcd
        Guids = Pkg.Guids
      File
"qemu/roms/edk2/BaseTools/Source/Python/Workspace/DecBuildData.py", line
262, in Guids
        RecordList = self._RawData[MODEL_EFI_GUID, self._Arch]
      File
"qemu/roms/edk2/BaseTools/Source/Python/Workspace/MetaFileParser.py",
line 249, in __getitem__
        self.Start()
      File
"qemu/roms/edk2/BaseTools/Source/Python/Workspace/MetaFileParser.py",
line 1788, in Start
        0
      File
"qemu/roms/edk2/BaseTools/Source/Python/Workspace/MetaFileParser.py",
line 195, in _Store
        return self._Table.Insert(*Args)
      File
"qemu/roms/edk2/BaseTools/Source/Python/Workspace/MetaFileTable.py",
line 211, in Insert
        Enabled
      File
"qemu/roms/edk2/BaseTools/Source/Python/Workspace/MetaDataTable.py",
line 79, in Insert
        self.Cur.execute(SqlCommand)
    IntegrityError: UNIQUE constraint failed: _1012_3.ID

    - Failed -
    Build end time: 12:44:27, Jan.21 2019
    Build total time: 00:00:02

    make: *** [Makefile:85: Build/bios-tables-test.x86_64.efi] Error 1
    make: *** Waiting for unfinished jobs....
