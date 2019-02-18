Received: from eggs.gnu.org ([209.51.188.92]:39336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvlu3-0000lw-9O
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvlu0-0006Jt-Or
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:36:23 -0500
Date: Mon, 18 Feb 2019 17:36:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190218125615.18970-5-armbru@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1902181714540.17599@zero.eik.bme.hu>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, qemu-ppc@nongnu.org

Hello,

On Mon, 18 Feb 2019, Markus Armbruster wrote:
> Machine "sam460ex" maps its flash memory at address 0xFFF00000.  When
> no image is supplied, its size is 1MiB (0x100000).  Else, it's the
> size of the image rounded up to the next multiple of 64KiB.
>
> The rounding is actually useless: pflash_cfi01_realize() fails with
> "failed to read the initial flash content" unless it's a no-op.
>
> I have no idea what happens when the pflash's size exceeds 1MiB.
> Useful outcomes seem unlikely.
>
> I guess memory at the end of the address space remains unmapped when
> it's smaller than 1MiB.  Again, useful outcomes seem unlikely.

I'm not sure where this was coming from but it predates my changes so no 
idea either.

> Set the flash memory size to 1MiB regardless of image size, to match
> the physical hardware.

Actually the real hardware seems to have a 512 kB flash chip:
https://eu.mouser.com/datasheet/2/268/atmel_AT49BV040B-1180330.pdf
so while you're at it you could change FLASH_SIZE to match that.

> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> hw/ppc/sam460ex.c | 23 ++++++++---------------
> 1 file changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 75250d49e4..ca8d7ab9c6 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -92,31 +92,24 @@ struct boot_info {
> static int sam460ex_load_uboot(void)
> {
>     DriveInfo *dinfo;
> -    BlockBackend *blk = NULL;
> -    hwaddr base = FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32);
> -    long bios_size = FLASH_SIZE;
> -    int fl_sectors;
>
>     dinfo = drive_get(IF_PFLASH, 0, 0);
> -    if (dinfo) {
> -        blk = blk_by_legacy_dinfo(dinfo);
> -        bios_size = blk_getlength(blk);

After this maybe the
#include "sysemu/block-backend.h"
can also be dropped from the includes?

> -    }
> -    fl_sectors = (bios_size + 65535) >> 16;
> -
> -    if (!pflash_cfi01_register(base, NULL, "sam460ex.flash", bios_size,
> -                               blk, 64 * KiB, fl_sectors,
> +    if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32),
> +                               NULL, "sam460ex.flash", FLASH_SIZE,
> +                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                               65536, FLASH_SIZE / 65536,

Could you keep 64 * KiB instead of 65536 here to match other places?

Regards,
BALATON Zoltan

>                                1, 0x89, 0x18, 0x0000, 0x0, 1)) {
>         error_report("Error registering flash memory");
>         /* XXX: return an error instead? */
>         exit(1);
>     }
>
> -    if (!blk) {
> +    if (!dinfo) {
>         /*error_report("No flash image given with the 'pflash' parameter,"
>                 " using default u-boot image");*/
> -        base = UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32);
> -        rom_add_file_fixed(UBOOT_FILENAME, base, -1);
> +        rom_add_file_fixed(UBOOT_FILENAME,
> +                           UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32),
> +                           -1);
>     }
>
>     return 0;
>
