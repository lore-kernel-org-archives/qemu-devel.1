Received: from eggs.gnu.org ([2001:4830:134:3::10]:43153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dCwxA-0006HO-Kn
	for qemu-devel@nongnu.org; Mon, 22 May 2017 19:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dCwx9-0001yh-Jl
	for qemu-devel@nongnu.org; Mon, 22 May 2017 19:41:32 -0400
MIME-Version: 1.0
In-Reply-To: <20170520002653.20213-3-andrew@aj.id.au>
References: <20170520002653.20213-1-andrew@aj.id.au>
	<20170520002653.20213-3-andrew@aj.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 May 2017 16:40:57 -0700
Message-ID: <CAKmqyKMcV-yD-HePHYsR5yvwt6LPv4YTSf+Eq1BNRTe6aoTVww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm: Integrate ADC model into
 Aspeed SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jeffery <andrew@aj.id.au>
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Joel Stanley <joel@jms.id.au>

On Fri, May 19, 2017 at 5:26 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

The connections look good to me. I'll have a look at V2 of your first patch.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair


> ---
>  hw/arm/aspeed_soc.c         | 15 +++++++++++++++
>  include/hw/arm/aspeed_soc.h |  2 ++
>  2 files changed, 17 insertions(+)
>
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 5c667d2c35b6..11f9588720d2 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -31,6 +31,7 @@
>  #define ASPEED_SOC_VIC_BASE         0x1E6C0000
>  #define ASPEED_SOC_SDMC_BASE        0x1E6E0000
>  #define ASPEED_SOC_SCU_BASE         0x1E6E2000
> +#define ASPEED_SOC_ADC_BASE         0x1E6E9000
>  #define ASPEED_SOC_SRAM_BASE        0x1E720000
>  #define ASPEED_SOC_TIMER_BASE       0x1E782000
>  #define ASPEED_SOC_WDT_BASE         0x1E785000
> @@ -157,6 +158,10 @@ static void aspeed_soc_init(Object *obj)
>      object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
>                                "hw-strap2", &error_abort);
>
> +    object_initialize(&s->adc, sizeof(s->adc), TYPE_ASPEED_ADC);
> +    object_property_add_child(obj, "adc", OBJECT(&s->adc), NULL);
> +    qdev_set_parent_bus(DEVICE(&s->adc), sysbus_get_default());
> +
>      object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename);
>      object_property_add_child(obj, "fmc", OBJECT(&s->fmc), NULL);
>      qdev_set_parent_bus(DEVICE(&s->fmc), sysbus_get_default());
> @@ -256,6 +261,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, ASPEED_SOC_SCU_BASE);
>
> +    /* ADC */
> +    object_property_set_bool(OBJECT(&s->adc), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->adc), 0, ASPEED_SOC_ADC_BASE);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
> +            qdev_get_gpio_in(DEVICE(&s->vic), 31));
> +
>      /* UART - attach an 8250 to the IO space as our UART5 */
>      if (serial_hds[0]) {
>          qemu_irq uart5 = qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs[4]);
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index d16205c66b5f..3b4d66d30f08 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -15,6 +15,7 @@
>  #include "hw/arm/arm.h"
>  #include "hw/intc/aspeed_vic.h"
>  #include "hw/misc/aspeed_scu.h"
> +#include "hw/adc/aspeed_adc.h"
>  #include "hw/misc/aspeed_sdmc.h"
>  #include "hw/timer/aspeed_timer.h"
>  #include "hw/i2c/aspeed_i2c.h"
> @@ -37,6 +38,7 @@ typedef struct AspeedSoCState {
>      AspeedTimerCtrlState timerctrl;
>      AspeedI2CState i2c;
>      AspeedSCUState scu;
> +    AspeedADCState adc;
>      AspeedSMCState fmc;
>      AspeedSMCState spi[ASPEED_SPIS_NUM];
>      AspeedSDMCState sdmc;
> --
> 2.9.3
>
>
