Received: from eggs.gnu.org ([209.51.188.92]:60400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvnAb-0007k6-OD
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:57:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvnAa-0005Nc-JK
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:57:33 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-5-armbru@redhat.com>
	<alpine.BSF.2.21.9999.1902181714540.17599@zero.eik.bme.hu>
Date: Mon, 18 Feb 2019 18:57:29 +0100
In-Reply-To: <alpine.BSF.2.21.9999.1902181714540.17599@zero.eik.bme.hu>
	(BALATON Zoltan's message of "Mon, 18 Feb 2019 17:36:17 +0100 (CET)")
Message-ID: <871s45569i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 04/10] sam460ex: Don't size
 flash memory to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, alex.bennee@linaro.org, qemu-devel@nongnu.org

BALATON Zoltan <balaton@eik.bme.hu> writes:

> Hello,
>
> On Mon, 18 Feb 2019, Markus Armbruster wrote:
>> Machine "sam460ex" maps its flash memory at address 0xFFF00000.  When
>> no image is supplied, its size is 1MiB (0x100000).  Else, it's the
>> size of the image rounded up to the next multiple of 64KiB.
>>
>> The rounding is actually useless: pflash_cfi01_realize() fails with
>> "failed to read the initial flash content" unless it's a no-op.
>>
>> I have no idea what happens when the pflash's size exceeds 1MiB.
>> Useful outcomes seem unlikely.
>>
>> I guess memory at the end of the address space remains unmapped when
>> it's smaller than 1MiB.  Again, useful outcomes seem unlikely.
>
> I'm not sure where this was coming from but it predates my changes so
> no idea either.
>
>> Set the flash memory size to 1MiB regardless of image size, to match
>> the physical hardware.
>
> Actually the real hardware seems to have a 512 kB flash chip:
> https://eu.mouser.com/datasheet/2/268/atmel_AT49BV040B-1180330.pdf

Fascinating.

<http://www.sam4x0.com/sam460ex.html> confirms.

> so while you're at it you could change FLASH_SIZE to match that.

Leads to more questions, below.

>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> hw/ppc/sam460ex.c | 23 ++++++++---------------
>> 1 file changed, 8 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>> index 75250d49e4..ca8d7ab9c6 100644
>> --- a/hw/ppc/sam460ex.c
>> +++ b/hw/ppc/sam460ex.c
>> @@ -92,31 +92,24 @@ struct boot_info {
>> static int sam460ex_load_uboot(void)
>> {
>>     DriveInfo *dinfo;
>> -    BlockBackend *blk = NULL;
>> -    hwaddr base = FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32);
>> -    long bios_size = FLASH_SIZE;
>> -    int fl_sectors;
>>
>>     dinfo = drive_get(IF_PFLASH, 0, 0);
>> -    if (dinfo) {
>> -        blk = blk_by_legacy_dinfo(dinfo);
>> -        bios_size = blk_getlength(blk);
>
> After this maybe the
> #include "sysemu/block-backend.h"
> can also be dropped from the includes?

I'll try.

>> -    }
>> -    fl_sectors = (bios_size + 65535) >> 16;
>> -
>> -    if (!pflash_cfi01_register(base, NULL, "sam460ex.flash", bios_size,
>> -                               blk, 64 * KiB, fl_sectors,
>> +    if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32),
>> +                               NULL, "sam460ex.flash", FLASH_SIZE,
>> +                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>> +                               65536, FLASH_SIZE / 65536,
>
> Could you keep 64 * KiB instead of 65536 here to match other places?

Sure (editing accident).

> Regards,
> BALATON Zoltan
>
>>                                1, 0x89, 0x18, 0x0000, 0x0, 1)) {
>>         error_report("Error registering flash memory");
>>         /* XXX: return an error instead? */
>>         exit(1);
>>     }
>>
>> -    if (!blk) {
>> +    if (!dinfo) {
>>         /*error_report("No flash image given with the 'pflash' parameter,"
>>                 " using default u-boot image");*/
>> -        base = UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32);
>> -        rom_add_file_fixed(UBOOT_FILENAME, base, -1);
>> +        rom_add_file_fixed(UBOOT_FILENAME,
>> +                           UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32),
>> +                           -1);
>>     }
>>
>>     return 0;

Let's have a look at the resulting function:

    static int sam460ex_load_uboot(void)
    {
        DriveInfo *dinfo;

        dinfo = drive_get(IF_PFLASH, 0, 0);
        if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32),
                                   "sam460ex.flash", FLASH_SIZE,
                                   dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                   65536,
                                   1, 0x89, 0x18, 0x0000, 0x0, 1)) {
            error_report("Error registering flash memory");
            /* XXX: return an error instead? */
            exit(1);
        }

        if (!dinfo) {
            /*error_report("No flash image given with the 'pflash' parameter,"
                    " using default u-boot image");*/
            rom_add_file_fixed(UBOOT_FILENAME,
                               UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32),
                               -1);
        }

        return 0;
    }

This first creates 1MiB of flash memory mapped at the end of the 32-bit
address space (0xFFF00000..0xFFFFFFFF).

If_PFLASH unit 0 is defined, the flash memory is initialized from that
block backend.

Else, it's initialized to zero.  And then 512KiB of ROM gets mapped on
top of its second half (0xFFF80000..0xFFFFFFFF), initialized from
u-boot-sam460-20100605.bin (which we build).

This doesn't smell right.

I propose to do the following: if IF_PFLASH unit 0 is defined, create
512KiB of flash memory mapped at the end of the 32-bit address space,
else, create 512KiB of ROM there.

Okay?
