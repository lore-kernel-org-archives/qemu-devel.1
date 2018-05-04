Received: from eggs.gnu.org ([2001:4830:134:3::10]:60577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdQA-0002UP-Vq
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdQ9-0006R4-RD
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:18:58 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525326811-3233-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e25a5a9f-9738-18b2-c30d-890bf136dd46@amsat.org>
Date: Fri, 4 May 2018 13:18:50 -0300
MIME-Version: 1.0
In-Reply-To: <1525326811-3233-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/arm: Don't fail qtest due to
 missing SD card in -nodefaults mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Markus Armbruster <armbru@redhat.com>

On 05/03/2018 02:53 AM, Thomas Huth wrote:
> When running omap1/2 or pxa2xx based ARM machines with -nodefaults,
> they bail out immediately complaining about a "missing SecureDigital
> device". That's not how the "default" devices in vl.c are meant to
> work - it should be possible for a board to also start up without
> default devices. So let's turn the error message and exit() into
> a warning instead.

Ideally we'd QOM'ify them.

> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/omap1.c  |  8 ++++----
>  hw/arm/omap2.c  |  8 ++++----
>  hw/arm/pxa2xx.c | 15 +++++++--------
>  3 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index 24673ab..e54c1f8 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -30,6 +30,7 @@
>  #include "hw/arm/soc_dma.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
> +#include "sysemu/qtest.h"
>  #include "qemu/range.h"
>  #include "hw/sysbus.h"
>  #include "qemu/cutils.h"
> @@ -3987,12 +3988,11 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
>                                  omap_findclk(s, "dpll3"));
>  
>      dinfo = drive_get(IF_SD, 0, 0);
> -    if (!dinfo) {
> -        error_report("missing SecureDigital device");
> -        exit(1);
> +    if (!dinfo && !qtest_enabled()) {
> +        warn_report("missing SecureDigital device");
>      }
>      s->mmc = omap_mmc_init(0xfffb7800, system_memory,
> -                           blk_by_legacy_dinfo(dinfo),
> +                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                             qdev_get_gpio_in(s->ih[1], OMAP_INT_OQN),
>                             &s->drq[OMAP_DMA_MMC_TX],
>                      omap_findclk(s, "mmc_ck"));
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index 8066353..b8d0910 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -25,6 +25,7 @@
>  #include "cpu.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
> +#include "sysemu/qtest.h"
>  #include "hw/boards.h"
>  #include "hw/hw.h"
>  #include "hw/arm/arm.h"
> @@ -2486,12 +2487,11 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
>                               s->drq[OMAP24XX_DMA_GPMC]);
>  
>      dinfo = drive_get(IF_SD, 0, 0);
> -    if (!dinfo) {
> -        error_report("missing SecureDigital device");
> -        exit(1);
> +    if (!dinfo && !qtest_enabled()) {
> +        warn_report("missing SecureDigital device");
>      }
>      s->mmc = omap2_mmc_init(omap_l4tao(s->l4, 9),
> -                    blk_by_legacy_dinfo(dinfo),
> +                    dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                      qdev_get_gpio_in(s->ih[0], OMAP_INT_24XX_MMC_IRQ),
>                      &s->drq[OMAP24XX_DMA_MMC1_TX],
>                      omap_findclk(s, "mmc_fclk"), omap_findclk(s, "mmc_iclk"));
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index 928a043..a2803fd 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -21,6 +21,7 @@
>  #include "chardev/char-fe.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
> +#include "sysemu/qtest.h"
>  #include "qemu/cutils.h"
>  
>  static struct {
> @@ -2095,12 +2096,11 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
>      s->gpio = pxa2xx_gpio_init(0x40e00000, s->cpu, s->pic, 121);
>  
>      dinfo = drive_get(IF_SD, 0, 0);
> -    if (!dinfo) {
> -        error_report("missing SecureDigital device");
> -        exit(1);
> +    if (!dinfo && !qtest_enabled()) {
> +        warn_report("missing SecureDigital device");
>      }
>      s->mmc = pxa2xx_mmci_init(address_space, 0x41100000,
> -                    blk_by_legacy_dinfo(dinfo),
> +                    dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                      qdev_get_gpio_in(s->pic, PXA2XX_PIC_MMC),
>                      qdev_get_gpio_in(s->dma, PXA2XX_RX_RQ_MMCI),
>                      qdev_get_gpio_in(s->dma, PXA2XX_TX_RQ_MMCI));
> @@ -2220,12 +2220,11 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
>      s->gpio = pxa2xx_gpio_init(0x40e00000, s->cpu, s->pic, 85);
>  
>      dinfo = drive_get(IF_SD, 0, 0);
> -    if (!dinfo) {
> -        error_report("missing SecureDigital device");
> -        exit(1);
> +    if (!dinfo && !qtest_enabled()) {
> +        warn_report("missing SecureDigital device");
>      }
>      s->mmc = pxa2xx_mmci_init(address_space, 0x41100000,
> -                    blk_by_legacy_dinfo(dinfo),
> +                    dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                      qdev_get_gpio_in(s->pic, PXA2XX_PIC_MMC),
>                      qdev_get_gpio_in(s->dma, PXA2XX_RX_RQ_MMCI),
>                      qdev_get_gpio_in(s->dma, PXA2XX_TX_RQ_MMCI));
> 
