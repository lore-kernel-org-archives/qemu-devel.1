Received: from eggs.gnu.org ([209.51.188.92]:35258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvu4W-0005Z8-1I
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 20:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvu4T-0007DQ-Pq
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 20:19:43 -0500
Date: Tue, 19 Feb 2019 02:19:34 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <871s45569i.fsf@dusky.pond.sub.org>
Message-ID: <alpine.BSF.2.21.9999.1902182104320.83039@zero.eik.bme.hu>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-5-armbru@redhat.com>
	<alpine.BSF.2.21.9999.1902181714540.17599@zero.eik.bme.hu>
	<871s45569i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-ID: <alpine.BSF.2.21.9999.1902190135090.14770@zero.eik.bme.hu>
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Markus Armbruster <armbru@redhat.com>
Cc: alex.bennee@linaro.org, =?ISO-8859-15?Q?Fran=E7ois_Revol?= <revol@free.fr>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 18 Feb 2019, Markus Armbruster wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> On Mon, 18 Feb 2019, Markus Armbruster wrote:
>>> Machine "sam460ex" maps its flash memory at address 0xFFF00000.  When
>>> no image is supplied, its size is 1MiB (0x100000).  Else, it's the
>>> size of the image rounded up to the next multiple of 64KiB.
>>>
>>> The rounding is actually useless: pflash_cfi01_realize() fails with
>>> "failed to read the initial flash content" unless it's a no-op.
>>>
>>> I have no idea what happens when the pflash's size exceeds 1MiB.
>>> Useful outcomes seem unlikely.
>>>
>>> I guess memory at the end of the address space remains unmapped when
>>> it's smaller than 1MiB.  Again, useful outcomes seem unlikely.
>>
>> I'm not sure where this was coming from but it predates my changes so
>> no idea either.
>>
>>> Set the flash memory size to 1MiB regardless of image size, to match
>>> the physical hardware.
>>
>> Actually the real hardware seems to have a 512 kB flash chip:
>> https://eu.mouser.com/datasheet/2/268/atmel_AT49BV040B-1180330.pdf
>
> Fascinating.
>
> <http://www.sam4x0.com/sam460ex.html> confirms.
>
>> so while you're at it you could change FLASH_SIZE to match that.
>
> Leads to more questions, below.
>
>>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>> hw/ppc/sam460ex.c | 23 ++++++++---------------
>>> 1 file changed, 8 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>>> index 75250d49e4..ca8d7ab9c6 100644
>>> --- a/hw/ppc/sam460ex.c
>>> +++ b/hw/ppc/sam460ex.c
>>> @@ -92,31 +92,24 @@ struct boot_info {
>>> static int sam460ex_load_uboot(void)
>>> {
>>>     DriveInfo *dinfo;
>>> -    BlockBackend *blk =3D NULL;
>>> -    hwaddr base =3D FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32);
>>> -    long bios_size =3D FLASH_SIZE;
>>> -    int fl_sectors;
>>>
>>>     dinfo =3D drive_get(IF_PFLASH, 0, 0);
>>> -    if (dinfo) {
>>> -        blk =3D blk_by_legacy_dinfo(dinfo);
>>> -        bios_size =3D blk_getlength(blk);
>>
>> After this maybe the
>> #include "sysemu/block-backend.h"
>> can also be dropped from the includes?
>
> I'll try.
>
>>> -    }
>>> -    fl_sectors =3D (bios_size + 65535) >> 16;
>>> -
>>> -    if (!pflash_cfi01_register(base, NULL, "sam460ex.flash", bios_si=
ze,
>>> -                               blk, 64 * KiB, fl_sectors,
>>> +    if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H <<=
 32),
>>> +                               NULL, "sam460ex.flash", FLASH_SIZE,
>>> +                               dinfo ? blk_by_legacy_dinfo(dinfo) : =
NULL,
>>> +                               65536, FLASH_SIZE / 65536,
>>
>> Could you keep 64 * KiB instead of 65536 here to match other places?
>
> Sure (editing accident).
>
>> Regards,
>> BALATON Zoltan
>>
>>>                                1, 0x89, 0x18, 0x0000, 0x0, 1)) {
>>>         error_report("Error registering flash memory");
>>>         /* XXX: return an error instead? */
>>>         exit(1);
>>>     }
>>>
>>> -    if (!blk) {
>>> +    if (!dinfo) {
>>>         /*error_report("No flash image given with the 'pflash' parame=
ter,"
>>>                 " using default u-boot image");*/
>>> -        base =3D UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32);
>>> -        rom_add_file_fixed(UBOOT_FILENAME, base, -1);
>>> +        rom_add_file_fixed(UBOOT_FILENAME,
>>> +                           UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H <=
< 32),
>>> +                           -1);
>>>     }
>>>
>>>     return 0;
>
> Let's have a look at the resulting function:
>
>    static int sam460ex_load_uboot(void)
>    {
>        DriveInfo *dinfo;
>
>        dinfo =3D drive_get(IF_PFLASH, 0, 0);
>        if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H <<=
 32),
>                                   "sam460ex.flash", FLASH_SIZE,
>                                   dinfo ? blk_by_legacy_dinfo(dinfo) : =
NULL,

There's still a blk_* function here which I did not notice so the=20
"sysemu/block-backend.h" is probably still needed.

>                                   65536,
>                                   1, 0x89, 0x18, 0x0000, 0x0, 1)) {
>            error_report("Error registering flash memory");
>            /* XXX: return an error instead? */
>            exit(1);
>        }
>
>        if (!dinfo) {
>            /*error_report("No flash image given with the 'pflash' param=
eter,"
>                    " using default u-boot image");*/
>            rom_add_file_fixed(UBOOT_FILENAME,
>                               UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H <=
< 32),
>                               -1);
>        }
>
>        return 0;
>    }
>
> This first creates 1MiB of flash memory mapped at the end of the 32-bit
> address space (0xFFF00000..0xFFFFFFFF).
>
> If_PFLASH unit 0 is defined, the flash memory is initialized from that
> block backend.
>
> Else, it's initialized to zero.  And then 512KiB of ROM gets mapped on
> top of its second half (0xFFF80000..0xFFFFFFFF), initialized from
> u-boot-sam460-20100605.bin (which we build).
>
> This doesn't smell right.

Unfortunately I don't know much about how this should work. Maybe Fran=E7=
ois=20
can remember where this comes from, this was already there when I started=
=20
working on it, but I suspect maybe he's copied it from some other board i=
n=20
QEMU as well. The sam460ex was based on ppc440_bamboo but that does not=20
seem to have flash ROM. Memory SPD EEPROM came from mips_malta (cleaned u=
p=20
since but it shows that that was also used as inspiration) but that's als=
o=20
not the same so maybe it was adapted for sam460ex or came from some other=
=20
example in QEMU. This was already there in Fran=E7ois's initial commit:

https://github.com/mmuman/qemu/commit/d10cc631645f3893d53e60cc00c618470b4=
de52c#diff-73d06ebbc1301aab78105d853097fa2fR42

and later was slightly modified (maybe to rebase for changes in QEMU):

https://github.com/mmuman/qemu/commit/768136b08a6b9b69e707af2c478b68a5935=
bb8f0#diff-73d06ebbc1301aab78105d853097fa2fL1267

The comment says these values come from U-Boot:

https://git.qemu.org/?p=3Du-boot-sam460ex.git;a=3Dblob;f=3Dinclude/config=
s/Sam460ex.h;h=3D71064a9601c89dd3ce381d07e0def6c9d5294d44;hb=3DHEAD#l123

and that indeed has flash size of 1 MB but then builds an image that's=20
exactly 512 kB which should be mapped at end of 4GB because the initial=20
program counter of the CPU is 0xfffffffc and board has a 512kB flash chip=
=20
as well.

> I propose to do the following: if IF_PFLASH unit 0 is defined, create
> 512KiB of flash memory mapped at the end of the 32-bit address space,
> else, create 512KiB of ROM there.
>
> Okay?

AFAIU the above U-Boot could handle up to 1MB of ROM but board has a 512k=
B=20
chip so probably it makes sense to use 512k here. However since this is=20
not well understood (at least by me) I'm not asking you to do that and=20
maybe just leave it as it is now. This can be revisited when NVRAM is=20
implemented later as this may be related to that (or not) this would need=
=20
understanding of some details I don't have yet. But if you feel confident=
=20
enough to clean this up feel free to go ahead.

Thank you,
BALATON Zoltan
