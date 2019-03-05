Received: from eggs.gnu.org ([209.51.188.92]:56688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1It0-0007VQ-UL
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1Isz-0001D0-Gw
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:50:10 -0500
Date: Tue, 5 Mar 2019 23:49:56 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <a6d6c528-69c8-5e09-02a6-4c7cef0c8891@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1903052325280.40521@zero.eik.bme.hu>
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-7-armbru@redhat.com>
	<a6d6c528-69c8-5e09-02a6-4c7cef0c8891@redhat.com>
MIME-Version: 1.0
Content-ID: <alpine.BSF.2.21.9999.1903052342530.40521@zero.eik.bme.hu>
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 06/11] sam460ex: Don't size
 flash memory to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, alex.bennee@linaro.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org

Hello,

On Tue, 5 Mar 2019, Philippe Mathieu-Daud=E9 wrote:
> On 2/26/19 8:34 PM, Markus Armbruster wrote:
>> Machine "sam460ex" maps its flash memory at address 0xFFF00000.  When
>> no image is supplied, its size is 1MiB (0x100000), and 512KiB of ROM
>> get mapped on top of its second half.  Else, it's the size of the
>> image rounded up to the next multiple of 64KiB.
>>
>> The rounding is actually useless: pflash_cfi01_realize() fails with
>> "failed to read the initial flash content" unless it's a no-op.
>>
>> I have no idea what happens when the pflash's size exceeds 1MiB.
>> Useful outcomes seem unlikely.
>
> With PFlashCFI02, it depends of the @nb_mappings parameter, which tries
> to emulates how the bus connects the pflash (which address lines are
> connected).
>
> PFlashCFI01 doesn't support the feature to remap its content in aliases
> (which might look unfortunate, because boards end doing it, in differen=
t
> ways).

I think this is all theoretical at the moment since we don't actually=20
model the flash functions of this board (at least I haven't tested that a=
t=20
all) and unless it somehow uses it in ways I'm unaware of I think=20
currently only the ROM is used.

> For this device we have:
>
>  (qemu) info mtree
>  0000000000000000-ffffffffffffffff (prio 0, i/o): system
>  00000004fff00000-00000004ffffffff (prio 0, romd): sam460ex.flash
>
> I'm not familiar with this arch/machine, let's assume the system bus is
> 32bit, and the flash has a 8bit word (we have 8 data lines connected to
> the pflash).

Maybe this can help:
https://datasheet.octopart.com/PPC460EX-NUB800T-AMCC-datasheet-11553412.p=
df
http://www.acube-systems.biz/index.php?page=3Dhardware&pid=3D5

Unfortunately I don't have any more detailed docs where it's explained=20
more but according to the above and in my limited understanding the SoC=20
could handle larger flash chips but this board has 512 MB. We have not=20
changed it now because I'm not sure if it would break anything and I don'=
t=20
have time to test it so Marcus just added a comment to remind about this=20
and we're happy with that for now and could come back to it separately.

> The 'no image' is 1MiB.
>
> 1 MiB =3D 8 Mbit
> 8 Mbit / 32 =3D 2 ^ 18
> We need 18 address lines to reach the whole flash.
>
> What happens if we connect a 2MiB flash? We need 19 addr lines.
>
> If we only have 18 lines to connect our flash, we can hardwire our last
> line as 0 or 1.
>
> - line #17 hardwired as 0:
> Only the bottom part of the flash is accessible (range 0x000000..0x0fff=
ff).
> CPU reading 0x4fff00000 read flash offset 0x0.
> Using CFI it is still a announced as 2MiB.
>
> - line #17 hardwired as 1:
> Only the top part of the flash is accessible (range 0x100000..0x1fffff)=
.
> Can we trigger any operation from the internal state machine (writing t=
o
> address 0x555, named @unlock_addr0 in QEMU) since all access are
> hardwardwired on top of 1MiB...?
> Yes we can, because the pflash only uses 11 bits for it's I/O, so all
> writes are masked and hit the I/O internal unit.
> CPU reading 0x4fff00000 read flash offset 0x100000
>
> If we do have 19 lines dedicated to our chip and connect a 512KiB flash=
,
> we 'll use 17 lines and let 2 lines unused.
> Regardless the values on the lines #17 and #18, the flash will answer t=
o
> the value on lines #0..#16. This might be called MMIO aliasing, and is
> what setup the @nb_mappings argument.
> This example with nb_mappings=3D4 would mean:
> "I have a 2MiB I/O space and a 512KiB flash, map it and create 3 aliase=
s".
>
> Back to the architecture, what matters here is that the CPU reset vecto=
r
> is always user-controlled (mapped on a flash device).
> This arch has reset_vector @0x4fffffffc.
> You could also map a 256KiB pflash at 0x4fffc0000, as long as the reset
> vector is covered. If you map it at 0x4fff00000 or 0x4fff80000 it won't=
!
>
> This explanation is not arch-specific (adapting the reset vector to eac=
h
> arch).
>
>>
>> I guess memory at the end of the address space remains unmapped when
>> it's smaller than 1MiB.  Again, useful outcomes seem unlikely.
>
> If you map a 512KiB flash at 0x4fff00000, then the reset vector is not
> covered. At 0x4fff80000 it is.

Yes, I said the same before but this would be a separate patch and would=20
need more testing so it wasn't included in this series. Since it works as=
=20
it is now this can wait until later when it can be cleaned up. If we want=
=20
to model the actual board we don't have to consider different flash sizes=
=20
than the 512 MB that the board has so everything else is probably=20
"overthinking" it.

Regards,
BALATON Zoltan

>
>> The physical hardware appears to have 512KiB of flash memory:
>> https://eu.mouser.com/datasheet/2/268/atmel_AT49BV040B-1180330.pdf
>>
>> For now, just set the flash memory size to 1MiB regardless of image
>> size, and document the mess.
>>
>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/ppc/sam460ex.c | 41 ++++++++++++++++++++++++++---------------
>>  1 file changed, 26 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>> index 75250d49e4..0c919529f8 100644
>> --- a/hw/ppc/sam460ex.c
>> +++ b/hw/ppc/sam460ex.c
>> @@ -91,32 +91,43 @@ struct boot_info {
>>
>>  static int sam460ex_load_uboot(void)
>>  {
>> +    /*
>> +     * This first creates 1MiB of flash memory mapped at the end of
>> +     * the 32-bit address space (0xFFF00000..0xFFFFFFFF).
>> +     *
>> +     * If_PFLASH unit 0 is defined, the flash memory is initialized
>> +     * from that block backend.
>> +     *
>> +     * Else, it's initialized to zero.  And then 512KiB of ROM get
>> +     * mapped on top of its second half (0xFFF80000..0xFFFFFFFF),
>> +     * initialized from u-boot-sam460-20100605.bin.
>
> I think the correct check is:
>
>    if (! something_mapped_at(0x4fffffffc)) {
>        rom_map("u-boot-sam460.bin",
>                0x500000000 - sizeof("u-boot-sam460.bin"));
>    }
>
> Maybe:
>
>    if (!memory_region_present(get_system_memory(), 0x4fffffffc)) {
>        /* Current uboot ROM is 512KiB */
>        /* TODO check [0x500000000 - 512KiB,0x500000000 - 1] unmapped */
>        rom_add_file_fixed(UBOOT_FILENAME,
>                           UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32=
),
>                           -1);
>    }
>
> Regards,
>
> Phil.
>
>> +     *
>> +     * This doesn't smell right.
>> +     *
>> +     * The physical hardware appears to have 512KiB flash memory.
>> +     *
>> +     * TODO Figure out what we really need here, and clean this up.
>> +     */
>> +
>>      DriveInfo *dinfo;
>> -    BlockBackend *blk =3D NULL;
>> -    hwaddr base =3D FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32);
>> -    long bios_size =3D FLASH_SIZE;
>> -    int fl_sectors;
>>
>>      dinfo =3D drive_get(IF_PFLASH, 0, 0);
>> -    if (dinfo) {
>> -        blk =3D blk_by_legacy_dinfo(dinfo);
>> -        bios_size =3D blk_getlength(blk);
>> -    }
>> -    fl_sectors =3D (bios_size + 65535) >> 16;
>> -
>> -    if (!pflash_cfi01_register(base, NULL, "sam460ex.flash", bios_siz=
e,
>> -                               blk, 64 * KiB, fl_sectors,
>> +    if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H << =
32),
>> +                               NULL, "sam460ex.flash", FLASH_SIZE,
>> +                               dinfo ? blk_by_legacy_dinfo(dinfo) : N=
ULL,
>> +                               64 * KiB, FLASH_SIZE / (64 * KiB),
>>                                 1, 0x89, 0x18, 0x0000, 0x0, 1)) {
>>          error_report("Error registering flash memory");
>>          /* XXX: return an error instead? */
>>          exit(1);
>>      }
>>
>> -    if (!blk) {
>> +    if (!dinfo) {
>>          /*error_report("No flash image given with the 'pflash' parame=
ter,"
>>                  " using default u-boot image");*/
>> -        base =3D UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32);
>> -        rom_add_file_fixed(UBOOT_FILENAME, base, -1);
>> +        rom_add_file_fixed(UBOOT_FILENAME,
>> +                           UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H <<=
 32),
>> +                           -1);
>>      }
>>
>>      return 0;
>>
>
>
