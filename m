Received: from eggs.gnu.org ([209.51.188.92]:33220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gqjBw-0001EF-VP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gqjBu-0007XE-Tf
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:42:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gqjBs-0007Rc-Sr
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:41:58 -0500
References: <20190204160325.4914-1-lersek@redhat.com>
	<20190204160325.4914-5-lersek@redhat.com>
	<20190204124613-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e9e9ed1d-0675-6a6e-1706-b6a23169719c@redhat.com>
Date: Mon, 4 Feb 2019 19:41:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190204124613-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/5] tests/uefi-test-tools: add build
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 02/04/19 18:47, Michael S. Tsirkin wrote:
> On Mon, Feb 04, 2019 at 05:03:24PM +0100, Laszlo Ersek wrote:
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
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>
>> Notes:
>>     v3:
>>     - explicitly mark the "./build.sh" recipe as recursive, with the "=
+"
>>       indicator; document it in a comment [Phil]
>>     - pick up R-b, T-b [Phil]
>>
>>     v2:
>>     - add the .NOTPARALLEL target [Phil, help-make, edk2-devel]
>>
>>  tests/uefi-test-tools/Makefile   | 106 ++++++++++++++
>>  tests/uefi-test-tools/.gitignore |   3 +
>>  tests/uefi-test-tools/build.sh   | 145 ++++++++++++++++++++
>>  3 files changed, 254 insertions(+)
>>
>> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Ma=
kefile
>> new file mode 100644
>> index 000000000000..1d78bc14d51a
>> --- /dev/null
>> +++ b/tests/uefi-test-tools/Makefile
>> @@ -0,0 +1,106 @@
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
>> +
>> +# In turn, the "build" utility of edk2 BaseTools invokes another "mak=
e".
>> +# Although the outer "make" process advertizes its job server to all =
child
>> +# processes via MAKEFLAGS in the environment, the outer "make" closes=
 the job
>> +# server file descriptors (exposed in MAKEFLAGS) before executing a r=
ecipe --
>> +# unless the recipe is recognized as a recursive "make" recipe. Recip=
es that
>> +# call $(MAKE) are classified automatically as recursive; for "build.=
sh" below,
>> +# we must mark the recipe manually as recursive, by using the "+" ind=
icator.
>> +# This way, when the inner "make" starts a parallel build of the targ=
et edk2
>> +# module, it can communicate with the outer "make"'s job server.
>> +Build/bios-tables-test.%.efi: build-edk2-tools
>> +	+./build.sh $(edk2_dir) BiosTablesTest $* $@
>
> Does this actually work with an out of tree build?

It's not supposed to.

Again, it's not something that a normal QEMU build includes. It is only
for maintainers to rebuild when there is a reason to do so. The output
binaries are tracked by git, and will be used as-is (in binary form) by
the ACPI test suite. If there are updates to the UEFI source code, the
binaries will have to be rebuilt by a maintainer (or by me, if I submit
the UEFI code changes), and the refreshed blobs are to be checked into
git. Think iPXE oproms for an analogy.

> Shouldn't this be SRC_PATH/tests/uefi-test-tools/ ?

No; nothing under roms/ is built like that, and the same applies to this
patch as well.

*Conceptually*, this patch is for roms/. However, in earlier discussion,
it was suggested that roms/ be kept dedicated to external git submodules
only, and that we not add such ROM source to roms/ whose master repo is
genuinely the QEMU repo. Please see the sub-thread at:

  Re: [PATCH 10/14] tests: acpi: ignore SMBIOS tests when UEFI firmware i=
s used
  http://mid.mail-archive.com/20190116115217.jduhqrwbjhuibmoq@sirius.home=
.kraxel.org

The last idea was that the UEFI source code should be kept in a direct
subdirectory of tests/ (rather than in roms/). And the binaries should
go under tests/data/uefi-boot-images/ (rather than pc-bios/).

Thanks
Laszlo
