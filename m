Received: from eggs.gnu.org ([209.51.188.92]:38640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gleuY-0007jA-EN
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gletg-0002MY-1v
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:06:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gletf-0002MC-OZ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:06:12 -0500
References: <20190118223400.24311-1-lersek@redhat.com>
	<20190118223400.24311-5-lersek@redhat.com>
	<fd79f085-f3d8-dc06-9d43-9c4fcea69317@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8d4dc6b0-d4d9-2919-194f-c27cb40699b3@redhat.com>
Date: Mon, 21 Jan 2019 20:05:57 +0100
MIME-Version: 1.0
In-Reply-To: <fd79f085-f3d8-dc06-9d43-9c4fcea69317@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 01/21/19 13:17, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Laszlo,
>=20
> On 1/18/19 11:33 PM, Laszlo Ersek wrote:
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
>>  tests/uefi-test-tools/Makefile   |  92 +++++++++++++
>>  tests/uefi-test-tools/.gitignore |   3 +
>>  tests/uefi-test-tools/build.sh   | 145 ++++++++++++++++++++
>>  3 files changed, 240 insertions(+)
>>
>> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Ma=
kefile
>> new file mode 100644
>> index 000000000000..7b6dd227e433
>> --- /dev/null
>> +++ b/tests/uefi-test-tools/Makefile
>> @@ -0,0 +1,92 @@
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
>> +Build/bios-tables-test.%.efi: build-edk2-tools
>> +	./build.sh $(edk2_dir) BiosTablesTest $* $@
>> +
>> +build-edk2-tools:
>> +	$(MAKE) -C $(edk2_dir)/BaseTools
>> +
> [...]
>=20
> I got errors [1] and [2] I couldn't figure out while running 'make -j4'=
.
>=20
> The following patch didn't help, any idea?
>=20
> -- >8 --
> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Mak=
efile
> index 7b6dd227e4..798c55c823 100644
> --- a/tests/uefi-test-tools/Makefile
> +++ b/tests/uefi-test-tools/Makefile
> @@ -81,6 +81,8 @@ Build/%.fat: Build/%.efi
>  # component name from the edk2 platform DSC file (such as
> "BiosTablesTest") is
>  # explicit in each rule.
>=20
> +.NOTPARALLEL: $(foreach
> target,$(emulation_targets),Build/bios-tables-test.$(target).efi)
> +
>  Build/bios-tables-test.%.efi: build-edk2-tools
>         ./build.sh $(edk2_dir) BiosTablesTest $* $@
>=20
> diff --git a/tests/uefi-test-tools/build.sh b/tests/uefi-test-tools/bui=
ld.sh
> index 155cb75c4d..13891a7385 100755
> --- a/tests/uefi-test-tools/build.sh
> +++ b/tests/uefi-test-tools/build.sh
> @@ -133,6 +133,7 @@ esac
>  # Build the UEFI binary
>  mkdir -p log
>  build \
> +  -n 1 \
>    --arch=3D"$edk2_arch" \
>    --buildtarget=3DDEBUG \
>    --platform=3DUefiTestToolsPkg/UefiTestToolsPkg.dsc \
> ---

It wasn't clear to me whether and how multi-threaded builds were
supposed to be used by maintainers, whenever they'd update
"tests/data/uefi-boot-images/*".

I saw that "make" was invoked everywhere as $(MAKE), but that didn't
clarify any intent around "-j". So I didn't test "-j" at all, and in
fact I wouldn't have expected it to work:

- At any point in time, there shouldn't be more than one instance of the
"build" base tool working.

- the "build" base tool itself contains some level of support (although
not complete) for parallelizing edk2 module builds: it does not
parallelize the compilation of source files between each other *within*
a single edk2 module (=3D INF file). It parallelizes modules (INF files)
between each other.

- This means if you build only one module at a time, passing the "-m"
switch (plus an INF file) to the "build" base tool, then there's nothing
to parallelize.

- "build.sh" does pass the "-m" switch to the "build" tool, because I
wanted the build output to be granular. That is, it should be possible
for someone to build just a given uefi-test-tools image for just a given
architecture, if they specify the corresponding pathname (as target)
when they invoke "make". This usage requires the "-m" flag, which in
turn precludes the parallelism built into the "build" base tool itself.
And, invoking multiple "build" instances in parallel is not supposed to
work.


Regarding why ".NOTPARALLEL" doesn't work -- the GNU Make documentation
writes:

  [...]  Any recursively invoked make command will still run recipes in
  parallel (unless its makefile also contains this target). [...]

The "build" base tool in edk2 implements part of the job with generated
makefiles and invoking "make" itself, thus, despite .NOTPARALLEL, it
likely inherits the outermost -j<N> setting -- and it doesn't expect such=
.

So the best I can offer here is to check $MAKEFLAGS in "build.sh", and
exit with an early, explicit error if $MAKEFLAGS contains "-j", "-l", or
their long variants (--jobs, --load-average).

I realize this would not be acceptable for building QEMU itself, but
"tests/uefi-test-tools/Makefile" should be run by some subsystem
maintainers only, interactively (or in their on custom scripts).

Thanks
Laszlo
