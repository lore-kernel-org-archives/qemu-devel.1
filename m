Received: from eggs.gnu.org ([2001:4830:134:3::10]:50005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyPmX-00082u-2L
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyPmV-0002zB-3l
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:03:16 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180831103816.13479-1-clg@kaod.org>
	<20180831111555.15008-1-clg@kaod.org>
	<20180831111555.15008-2-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8f6e17c3-6c4d-fa44-234b-a385fe65830b@amsat.org>
Date: Fri, 7 Sep 2018 20:02:53 -0300
MIME-Version: 1.0
In-Reply-To: <20180831111555.15008-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 11/11] aspeed/smc: Add dummy
 data register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>

On 8/31/18 8:15 AM, Cédric Le Goater wrote:
> The SMC controllers have a register containing the byte that will be
> used as dummy output. It can be modified by software.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/ssi/aspeed_smc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index da2fedfcd3cd..f31bbc895caa 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -102,8 +102,8 @@
>  /* Misc Control Register #1 */
>  #define R_MISC_CTRL1      (0x50 / 4)
>  
> -/* Misc Control Register #2 */
> -#define R_MISC_CTRL2      (0x54 / 4)
> +/* SPI dummy cycle data */
> +#define R_DUMMY_DATA      (0x54 / 4)
>  
>  /* DMA Control/Status Register */
>  #define R_DMA_CTRL        (0x80 / 4)
> @@ -548,7 +548,7 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
>       */
>      if (aspeed_smc_flash_mode(fl) == CTRL_FREADMODE) {
>          for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
> -            ssi_transfer(fl->controller->spi, 0xFF);
> +            ssi_transfer(fl->controller->spi, s->regs[R_DUMMY_DATA] & 0xff);

The DUMMY_DATA register always contains a 8-bit value, so this AND
shouldn't be necessary. Regardless:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


>          }
>      }
>  }
> @@ -680,6 +680,7 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
>          addr == s->r_timings ||
>          addr == s->r_ce_ctrl ||
>          addr == R_INTR_CTRL ||
> +        addr == R_DUMMY_DATA ||
>          (s->ctrl->has_dma && addr == R_DMA_CTRL) ||
>          (s->ctrl->has_dma && addr == R_DMA_FLASH_ADDR) ||
>          (s->ctrl->has_dma && addr == R_DMA_DRAM_ADDR) ||
> @@ -912,6 +913,8 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
>          }
>      } else if (addr == R_INTR_CTRL) {
>          s->regs[addr] = value;
> +    } else if (addr == R_DUMMY_DATA) {
> +        s->regs[addr] = value & 0xff ;
>      } else if (s->ctrl->has_dma && addr == R_DMA_CTRL) {
>          aspeed_smc_dma_ctrl(s, value);
>      } else if (s->ctrl->has_dma && addr == R_DMA_DRAM_ADDR) {
> 
