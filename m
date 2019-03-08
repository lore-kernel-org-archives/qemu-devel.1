Received: from eggs.gnu.org ([209.51.188.92]:60703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2F7r-0001rt-M6
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2F7m-0001g4-FV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:01:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2F7m-0001LB-7B
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:01:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so12343039wmg.4
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 05:01:16 -0800 (PST)
References: <20190308094610.21210-1-armbru@redhat.com>
	<20190308094610.21210-10-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4572a1aa-ae70-54f3-eda7-64c086d7def0@redhat.com>
Date: Fri, 8 Mar 2019 14:01:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190308094610.21210-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 09/15] r2d: Fix flash memory size,
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

On 3/8/19 10:46 AM, Markus Armbruster wrote:
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
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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

~# dmesg
[    0.000000] Linux version 2.6.32-5-sh7751r (Debian 2.6.32-30)
(ben@decadent.org.uk) (gcc version 4.3.5 (Debian 4.3.5-4) ) #1 Thu Jan
13 08:23:18 UTC 2011
[    0.000000] Booting machvec: RTS7751R2D
[    0.000000] Renesas Technology Sales RTS7751R2D support.
[    0.000000] FPGA version:1 (revision:0)
[    0.008000] CPU: SH7751R
[    0.456000] console [ttySC0] enabled
[    0.600000] physmap platform flash device: 02000001 at 00000000
[    0.604000] physmap-flash: Found 1 x16 devices at 0x0 in 16-bit bank
[    0.604000]  Amd/Fujitsu Extended Query Table at 0x0031
[    0.604000] number of CFI chips: 1
[    0.608000] cfi_cmdset_0002: Disabling erase-suspend-program due to
code brokenness.
[    0.692000] cmdlinepart partition parsing not available
[    0.724000] RedBoot partition parsing not available
[    0.724000] Using physmap partition information
[    0.724000] Creating 4 MTD partitions on "physmap-flash":
[    0.724000] 0x000000000000-0x000000040000 : "U-Boot"
[    0.732000] 0x000000040000-0x000000080000 : "Environment"
[    0.732000] 0x000000080000-0x000000240000 : "Kernel"
[    0.732000] 0x000000240000-0x000001000000 : "Flash_FS"

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
