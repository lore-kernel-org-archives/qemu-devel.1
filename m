Received: from eggs.gnu.org ([209.51.188.92]:40481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gpHVA-0006Xg-DO
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gpHV8-0004KA-CQ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:55:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gpHV8-0004Jg-3k
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:55:50 -0500
References: <20190124203959.30875-1-lersek@redhat.com>
	<20190124203959.30875-5-lersek@redhat.com>
	<6d5868f5-70b4-71e2-3495-8d47156148c1@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f39b4b89-bd10-de9c-d3d2-c38411594f70@redhat.com>
Date: Thu, 31 Jan 2019 19:55:38 +0100
MIME-Version: 1.0
In-Reply-To: <6d5868f5-70b4-71e2-3495-8d47156148c1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 01/31/19 18:07, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Laszlo,
>=20
> On 1/24/19 9:39 PM, Laszlo Ersek wrote:
>> Introduce the following build scripts under "tests/uefi-test-tools":
>>
>> * "build.sh" builds a single module (a UEFI application) from
>>   UefiTestToolsPkg, for a single QEMU emulation target.
>>
>>   "build.sh" relies on cross-compilers when the emulation target and t=
he
>>   build host architecture don't match. The cross-compiler prefix is
>>   computed according to a fixed, Linux-specific pattern. No attempt is
>>   made to copy or reimplement the GNU Make magic from "qemu/roms/Makef=
ile"
>>   for cross-compiler prefix determination. The reason is that the buil=
d
>>   host OSes that are officially supported by edk2, and those that are
>>   supported by QEMU, intersect only in Linux. (Note that the UNIXGCC
>>   toolchain is being removed from edk2,
>>   <https://bugzilla.tianocore.org/show_bug.cgi?id=3D1377>.)
>>
>> * "Makefile" currently builds the "UefiTestToolsPkg/BiosTablesTest"
>>   application, for arm, aarch64, i386, and x86_64, with the help of
>>   "build.sh".
>>
>>   "Makefile" turns each resultant UEFI executable into a UEFI-bootable=
,
>>   qcow2-compressed ISO image. The ISO images are output as
>>   "tests/data/uefi-boot-images/bios-tables-test.<TARGET>.iso.qcow2".
>>
>>   Each ISO image should be passed to QEMU as follows:
>>
>>     -drive id=3Dboot-cd,if=3Dnone,readonly,format=3Dqcow2,file=3D$ISO =
\
>>     -device virtio-scsi-pci,id=3Dscsi0 \
>>     -device scsi-cd,drive=3Dboot-cd,bus=3Dscsi0.0,bootindex=3D0 \
>>
>>   "Makefile" assumes that "mkdosfs", "mtools", and "genisoimage" are
>>   present.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>
>> Notes:
>>     v2:
>>     - add the .NOTPARALLEL target [Phil, help-make, edk2-devel]
>>
>>  tests/uefi-test-tools/Makefile   |  97 +++++++++++++
>>  tests/uefi-test-tools/.gitignore |   3 +
>>  tests/uefi-test-tools/build.sh   | 145 ++++++++++++++++++++
>>  3 files changed, 245 insertions(+)
>>
>> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Ma=
kefile
>> new file mode 100644
>> index 000000000000..61d263861e01
>> --- /dev/null
>> +++ b/tests/uefi-test-tools/Makefile
>> @@ -0,0 +1,97 @@
>> +# Makefile for the test helper UEFI applications that run in guests.
>> +#
>> +# Copyright (C) 2019, Red Hat, Inc.
>> +#
>> +# This program and the accompanying materials are licensed and made a=
vailable
>> +# under the terms and conditions of the BSD License that accompanies =
this
>> +# distribution. The full text of the license may be found at
>> +# <http://opensource.org/licenses/bsd-license.php>.
>> +#
>> +# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASI=
S, WITHOUT
>> +# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIE=
D.
>> +
>> +edk2_dir              :=3D ../../roms/edk2
>> +images_dir            :=3D ../data/uefi-boot-images
>> +emulation_targets     :=3D arm aarch64 i386 x86_64
>> +uefi_binaries         :=3D bios-tables-test
>> +intermediate_suffixes :=3D .efi .fat .iso.raw
>> +
>> +images: $(foreach binary,$(uefi_binaries), \
>> +		$(foreach target,$(emulation_targets), \
>> +			$(images_dir)/$(binary).$(target).iso.qcow2))
>> +
>> +# Preserve all intermediate targets if the build succeeds.
>> +# - Intermediate targets help with development & debugging.
>> +# - Preserving intermediate targets also keeps spurious changes out o=
f the
>> +#   final build products, in case the user re-runs "make" without any=
 changes
>> +#   to the UEFI source code. Normally, the intermediate files would h=
ave been
>> +#   removed by the last "make" invocation, hence the re-run would reb=
uild them
>> +#   from the unchanged UEFI sources. Unfortunately, the "mkdosfs" and
>> +#   "genisoimage" utilities embed timestamp-based information in thei=
r outputs,
>> +#   which causes git to report differences for the tracked qcow2 ISO =
images.
>> +.SECONDARY: $(foreach binary,$(uefi_binaries), \
>> +		$(foreach target,$(emulation_targets), \
>> +			$(foreach suffix,$(intermediate_suffixes), \
>> +				Build/$(binary).$(target)$(suffix))))
>> +
>> +# In the pattern rules below, the stem (%, $*) stands for
>> +# "$(binary).$(target)".
>> +
>> +# Convert the raw ISO image to a qcow2 one, enabling compression, and=
 using a
>> +# small cluster size. This allows for small binary files under git co=
ntrol,
>> +# hence for small binary patches.
>> +$(images_dir)/%.iso.qcow2: Build/%.iso.raw
>> +	mkdir -p -- $(images_dir)
>> +	$${QTEST_QEMU_IMG:-qemu-img} convert -f raw -O qcow2 -c \
>> +		-o cluster_size=3D512 -- $< $@
>> +
>> +# Embed the "UEFI system partition" into an ISO9660 file system as an=
 ElTorito
>> +# boot image.
>> +Build/%.iso.raw: Build/%.fat
>> +	genisoimage -input-charset ASCII -efi-boot $(notdir $<) -no-emul-boo=
t \
>> +		-quiet -o $@ -- $<
>> +
>> +# Define chained macros in order to map QEMU system emulation targets=
 to
>> +# *short* UEFI architecture identifiers. Periods are allowed in, and =
ultimately
>> +# stripped from, the argument.
>> +map_arm_to_uefi     =3D $(subst arm,ARM,$(1))
>> +map_aarch64_to_uefi =3D $(subst aarch64,AA64,$(call map_arm_to_uefi,$=
(1)))
>> +map_i386_to_uefi    =3D $(subst i386,IA32,$(call map_aarch64_to_uefi,=
$(1)))
>> +map_x86_64_to_uefi  =3D $(subst x86_64,X64,$(call map_i386_to_uefi,$(=
1)))
>> +map_to_uefi         =3D $(subst .,,$(call map_x86_64_to_uefi,$(1)))
>> +
>> +# Format a "UEFI system partition", using the UEFI binary as the defa=
ult boot
>> +# loader. Add 10% size for filesystem metadata, round up to the next =
KB, and
>> +# make sure the size is large enough for a FAT filesystem. Name the f=
ilesystem
>> +# after the UEFI binary. (Excess characters are automatically dropped=
 from the
>> +# filesystem label.)
>> +Build/%.fat: Build/%.efi
>> +	rm -f -- $@
>> +	uefi_bin_b=3D$$(stat --format=3D%s -- $<) && \
>> +		uefi_fat_kb=3D$$(( (uefi_bin_b * 11 / 10 + 1023) / 1024 )) && \
>> +		uefi_fat_kb=3D$$(( uefi_fat_kb >=3D 64 ? uefi_fat_kb : 64 )) && \
>> +		mkdosfs -C $@ -n $(basename $(@F)) -- $$uefi_fat_kb
>> +	MTOOLS_SKIP_CHECK=3D1 mmd -i $@ ::EFI
>> +	MTOOLS_SKIP_CHECK=3D1 mmd -i $@ ::EFI/BOOT
>> +	MTOOLS_SKIP_CHECK=3D1 mcopy -i $@ -- $< \
>> +		::EFI/BOOT/BOOT$(call map_to_uefi,$(suffix $*)).EFI
>> +
>> +# In the pattern rules below, the stem (%, $*) stands for "$(target)"=
 only. The
>> +# association between the UEFI binary (such as "bios-tables-test") an=
d the
>> +# component name from the edk2 platform DSC file (such as "BiosTables=
Test") is
>> +# explicit in each rule.
>> +
>> +# "build.sh" invokes the "build" utility of edk2 BaseTools. In any gi=
ven edk2
>> +# workspace, at most one "build" instance may be operating at a time.=
 Therefore
>> +# we must serialize the rebuilding of targets in this Makefile.
>> +.NOTPARALLEL:
>=20
> Well this doesn't seem to improve my case :|
>=20
> You can test with:
>=20
> $ alias make=3D'make -j8 -l7.5'
>=20
> So you get:
>=20
> $ make print-MAKEFLAGS
> MAKEFLAGS=3DrR -j8 -l7.5 --jobserver-auth=3D3,4

I get something different (with make-3.82-23.el7.x86_64):

MAKEFLAGS=3DRrl 7.5 - --jobserver-fds=3D3,4 -j

Notably, the argument 8 of "-j" is dropped.

Anyway, I think this is a side topic.


> and this command fails:
>=20
> $ make -C tests/uefi-test-tools Build/bios-tables-test.x86_64.efi

(1) How *exactly* does it fail for you?

(2) What operating system and "make" are you using?

Because, the command completes perfectly fine for me. (Just for this
test, I rebased the v2 branch on top of current master, i.e. commit
aefcd2836620, and re-tested there.)

(3) Also, did you update all submodules first? (git submodule update
--init --force)

(4) IMPORTANT: did you make sure you didn't have an earlier *mis-built*
BaseTools directory in the submodule? For that, run "make clean" in the
QEMU project root. Note that "git clean -ffdx" will *not* clean
submodules, when issued from the QEMU project root.


> Now, using -j1 we have:
>=20
> $ make print-MAKEFLAGS -j1
> MAKEFLAGS=3DrR -j1 -l7.5
>=20
> And the builds work:
>=20
> $ make -j1 -C tests/uefi-test-tools Build/bios-tables-test.x86_64.efi
>=20
> Reading 'info make' section "5.7.3 Communicating Options to a
> Sub-'make'" I figured we can overwrite MAKEFLAGS, and this snippet work=
s
> like charm:
>=20
> -- >8 --
> @@ -84,8 +84,7 @@ Build/%.fat: Build/%.efi
>  # "build.sh" invokes the "build" utility of edk2 BaseTools. In any
> given edk2
>  # workspace, at most one "build" instance may be operating at a time.
> Therefore
>  # we must serialize the rebuilding of targets in this Makefile.
> -.NOTPARALLEL:
> -
> +Build/bios-tables-test.%.efi: MAKEFLAGS=3D
>  Build/bios-tables-test.%.efi: build-edk2-tools
>         ./build.sh $(edk2_dir) BiosTablesTest $* $@
>=20
> ---

No, this is wrong. First, it removes other make flags that are not
related to parallelized building. Second, I was advised on the help-make
mailing list that if we really want to manipulate make options (as
opposed to setting .NOTPARALLEL), then we should explicitly append a
"-j1" to the invocation of the inner make. Please see this thread:
<http://lists.gnu.org/archive/html/help-make/2019-01/msg00004.html>.

That would mean modifying edk2 build code (because that's where the
inner make is invoked from), and I started researching that, but it
wasn't necessary in the end.


> I tested with:
>=20
> $ rm -rf tests/uefi-test-tools/Build
> $ make -C tests/uefi-test-tools \
>   Build/bios-tables-test.{arm,aarch64,i386,x86_64}.efi images -j42

This command works for me flawlessly already, with my tree as-is.


> What do you think about using this snippet? I don't know if this is the
> best way to solve this, but it works...
> If you test/agree, Michael could eventually apply the snippet directly.

Again, I disagree with wiping MAKEFLAGS (or messing with it in any way);
*if* we need to modify the inner make's command line, that should be
done differently. However, my main point is that we need not modify the
inner make's invocation.

Can you please answer questions (1) through (4)? If it still fails for
you afterwards, I could attempt reproducing the issue in an environment
that's similar to yours.

Thanks,
Laszlo

>=20
>> +
>> +Build/bios-tables-test.%.efi: build-edk2-tools
>> +	./build.sh $(edk2_dir) BiosTablesTest $* $@
>> +
>> +build-edk2-tools:
>> +	$(MAKE) -C $(edk2_dir)/BaseTools
>> +
>> +clean:
>> +	rm -rf Build Conf log
>> +	$(MAKE) -C $(edk2_dir)/BaseTools clean
>> diff --git a/tests/uefi-test-tools/.gitignore b/tests/uefi-test-tools/=
.gitignore
>> new file mode 100644
>> index 000000000000..9f246701dea1
>> --- /dev/null
>> +++ b/tests/uefi-test-tools/.gitignore
>> @@ -0,0 +1,3 @@
>> +Build
>> +Conf
>> +log
>> diff --git a/tests/uefi-test-tools/build.sh b/tests/uefi-test-tools/bu=
ild.sh
>> new file mode 100755
>> index 000000000000..155cb75c4ddb
>> --- /dev/null
>> +++ b/tests/uefi-test-tools/build.sh
>> @@ -0,0 +1,145 @@
>> +#!/bin/bash
>> +
>> +# Build script that determines the edk2 toolchain to use, invokes the=
 edk2
>> +# "build" utility, and copies the built UEFI binary to the requested =
location.
>> +#
>> +# Copyright (C) 2019, Red Hat, Inc.
>> +#
>> +# This program and the accompanying materials are licensed and made a=
vailable
>> +# under the terms and conditions of the BSD License that accompanies =
this
>> +# distribution. The full text of the license may be found at
>> +# <http://opensource.org/licenses/bsd-license.php>.
>> +#
>> +# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASI=
S, WITHOUT
>> +# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIE=
D.
>> +
>> +set -e -u -C
>> +
>> +# Save the command line arguments. We need to reset $# to 0 before so=
urcing
>> +# "edksetup.sh", as it will inherit $@.
>> +program_name=3D$(basename -- "$0")
>> +edk2_dir=3D$1
>> +dsc_component=3D$2
>> +emulation_target=3D$3
>> +uefi_binary=3D$4
>> +shift 4
>> +
>> +# Set up the environment for edk2 building.
>> +export PACKAGES_PATH=3D$(realpath -- "$edk2_dir")
>> +export WORKSPACE=3D$PWD
>> +mkdir -p Conf
>> +
>> +# Source "edksetup.sh" carefully.
>> +set +e +u +C
>> +source "$PACKAGES_PATH/edksetup.sh"
>> +ret=3D$?
>> +set -e -u -C
>> +if [ $ret -ne 0 ]; then
>> +  exit $ret
>> +fi
>> +
>> +# Map the QEMU system emulation target to the following types of arch=
itecture
>> +# identifiers:
>> +# - edk2,
>> +# - gcc cross-compilation.
>> +# Cover only those targets that are supported by the UEFI spec and ed=
k2.
>> +case "$emulation_target" in
>> +  (arm)
>> +    edk2_arch=3DARM
>> +    gcc_arch=3Darm
>> +    ;;
>> +  (aarch64)
>> +    edk2_arch=3DAARCH64
>> +    gcc_arch=3Daarch64
>> +    ;;
>> +  (i386)
>> +    edk2_arch=3DIA32
>> +    gcc_arch=3Di686
>> +    ;;
>> +  (x86_64)
>> +    edk2_arch=3DX64
>> +    gcc_arch=3Dx86_64
>> +    ;;
>> +  (*)
>> +    printf '%s: unknown/unsupported QEMU system emulation target "%s"=
\n' \
>> +      "$program_name" "$emulation_target" >&2
>> +    exit 1
>> +    ;;
>> +esac
>> +
>> +# Check if cross-compilation is needed.
>> +host_arch=3D$(uname -m)
>> +if [ "$gcc_arch" =3D=3D "$host_arch" ] ||
>> +   ( [ "$gcc_arch" =3D=3D i686 ] && [ "$host_arch" =3D=3D x86_64 ] );=
 then
>> +  cross_prefix=3D
>> +else
>> +  cross_prefix=3D${gcc_arch}-linux-gnu-
>> +fi
>> +
>> +# Expose cross_prefix (which is possibly empty) to the edk2 tools. Wh=
ile at it,
>> +# determine the suitable edk2 toolchain as well.
>> +# - For ARM and AARCH64, edk2 only offers the GCC5 toolchain tag, whi=
ch covers
>> +#   the gcc-5+ releases.
>> +# - For IA32 and X64, edk2 offers the GCC44 through GCC49 toolchain t=
ags, in
>> +#   addition to GCC5. Unfortunately, the mapping between the toolchai=
n tags and
>> +#   the actual gcc releases isn't entirely trivial. Run "git-blame" o=
n
>> +#   "OvmfPkg/build.sh" in edk2 for more information.
>> +# And, because the above is too simple, we have to assign cross_prefi=
x to an
>> +# edk2 build variable that is specific to both the toolchain tag and =
the target
>> +# architecture.
>> +case "$edk2_arch" in
>> +  (ARM)
>> +    edk2_toolchain=3DGCC5
>> +    export GCC5_ARM_PREFIX=3D$cross_prefix
>> +    ;;
>> +  (AARCH64)
>> +    edk2_toolchain=3DGCC5
>> +    export GCC5_AARCH64_PREFIX=3D$cross_prefix
>> +    ;;
>> +  (IA32|X64)
>> +    gcc_version=3D$("${cross_prefix}gcc" -v 2>&1 | tail -1 | awk '{pr=
int $3}')
>> +    case "$gcc_version" in
>> +      ([1-3].*|4.[0-3].*)
>> +        printf '%s: unsupported gcc version "%s"\n' \
>> +          "$program_name" "$gcc_version" >&2
>> +        exit 1
>> +        ;;
>> +      (4.4.*)
>> +        edk2_toolchain=3DGCC44
>> +        ;;
>> +      (4.5.*)
>> +        edk2_toolchain=3DGCC45
>> +        ;;
>> +      (4.6.*)
>> +        edk2_toolchain=3DGCC46
>> +        ;;
>> +      (4.7.*)
>> +        edk2_toolchain=3DGCC47
>> +        ;;
>> +      (4.8.*)
>> +        edk2_toolchain=3DGCC48
>> +        ;;
>> +      (4.9.*|6.[0-2].*)
>> +        edk2_toolchain=3DGCC49
>> +        ;;
>> +      (*)
>> +        edk2_toolchain=3DGCC5
>> +        ;;
>> +    esac
>> +    eval "export ${edk2_toolchain}_BIN=3D\$cross_prefix"
>> +    ;;
>> +esac
>> +
>> +# Build the UEFI binary
>> +mkdir -p log
>> +build \
>> +  --arch=3D"$edk2_arch" \
>> +  --buildtarget=3DDEBUG \
>> +  --platform=3DUefiTestToolsPkg/UefiTestToolsPkg.dsc \
>> +  --tagname=3D"$edk2_toolchain" \
>> +  --module=3D"UefiTestToolsPkg/$dsc_component/$dsc_component.inf" \
>> +  --log=3D"log/$dsc_component.$edk2_arch.log" \
>> +  --report-file=3D"log/$dsc_component.$edk2_arch.report"
>> +cp -a -- \
>> +  "Build/UefiTestTools/DEBUG_${edk2_toolchain}/$edk2_arch/$dsc_compon=
ent.efi" \
>> +  "$uefi_binary"
>>
