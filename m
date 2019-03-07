Received: from eggs.gnu.org ([209.51.188.92]:36782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1tQQ-000540-Te
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1tQP-0006y7-O7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:51:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1tQP-0006tc-Hs
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:51:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so17510238wrg.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 05:51:03 -0800 (PST)
References: <20190307130323.9353-1-armbru@redhat.com>
	<20190307130323.9353-9-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1edc609b-78cc-e031-0b10-986b6a633e51@redhat.com>
Date: Thu, 7 Mar 2019 14:51:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190307130323.9353-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 08/14] r2d: Fix flash memory size,
 sector size, width, device ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, balaton@eik.bme.hu, Magnus Damm <magnus.damm@gmail.com>

On 3/7/19 2:03 PM, Markus Armbruster wrote:
> pflash_cfi02_register() takes a size in bytes, a block size in bytes
> and a number of blocks.  r2d_init() passes FLASH_SIZE, 16 * KiB,
> FLASH_SIZE >> 16.  Does not compute: size doesn't match block size *
> number of blocks.  The latter happens to win: FLASH_SIZE / 4,
> i.e. 8MiB.
> 
> The best information we have on the physical hardware lists a Cypress
> S29PL127J60TFI130 128MiBit NOR flash addressable in words of 16 bits,
> in sectors of 4 and 32 Kibiwords.  We don't model multiple sector
> sizes.
> 
> Fix the flash size from 8 to 16MiB, and adjust the sector size from 16
> to 64KiB.  Fix the width from 4 to 2.  While there, supply the real
> device IDs 0x0001, 0x227e, 0x2220, 0x2200 instead of zeros.
> 
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/sh4/r2d.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> index dcdb3728cb..cd23c60b86 100644
> --- a/hw/sh4/r2d.c
> +++ b/hw/sh4/r2d.c
> @@ -44,7 +44,7 @@
>  #include "exec/address-spaces.h"
>  
>  #define FLASH_BASE 0x00000000
> -#define FLASH_SIZE 0x02000000
> +#define FLASH_SIZE (16 * MiB)
>  
>  #define SDRAM_BASE 0x0c000000 /* Physical location of SDRAM: Area 3 */
>  #define SDRAM_SIZE 0x04000000
> @@ -288,12 +288,20 @@ static void r2d_init(MachineState *machine)
>      sysbus_mmio_map(busdev, 1, 0x1400080c);
>      mmio_ide_init_drives(dev, dinfo, NULL);
>  
> -    /* onboard flash memory */
> +    /*
> +     * Onboard flash memory
> +     * According to the old board user document in Japanese (under
> +     * NDA) what is referred to as FROM (Area0) is connected via a
> +     * 32-bit bus and CS0 to CN8. The docs mention a Cypress
> +     * S29PL127J60TFI130 chipsset.  Per the 'S29PL-J 002-00615
> +     * Rev. *E' datasheet, it is a 128Mbit NOR parallel flash
> +     * addressable in words of 16bit.
> +     */
>      dinfo = drive_get(IF_PFLASH, 0, 0);
>      pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE,
>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                          16 * KiB, FLASH_SIZE >> 16,
> -                          1, 4, 0x0000, 0x0000, 0x0000, 0x0000,
> +                          64 * KiB, FLASH_SIZE >> 16,
> +                          1, 2, 0x0001, 0x227e, 0x2220, 0x2200,
>                            0x555, 0x2aa, 0);
>  
>      /* NIC: rtl8139 on-board, and 2 slots. */
> 
