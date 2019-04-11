Received: from eggs.gnu.org ([209.51.188.92]:40400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEcnP-000828-TB
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEcnN-0003YV-Ry
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:43:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEcnK-0003Wb-26
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:43:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so7614294wmi.0
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 09:43:20 -0700 (PDT)
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-2-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0b244f3c-e941-cb2f-f830-1f60badb8bd1@redhat.com>
Date: Thu, 11 Apr 2019 18:43:18 +0200
MIME-Version: 1.0
In-Reply-To: <20190411161013.4514-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] aspeed: add a per SoC mapping for the
 interrupt space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>

Hi Cédric,

On 4/11/19 6:10 PM, Cédric Le Goater wrote:
> This will simplify the definition of new SoCs, like the AST2600 which
> should use a different CPU and a different IRQ number layout.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  include/hw/arm/aspeed_soc.h |  1 +
>  hw/arm/aspeed_soc.c         | 93 +++++++++++++++++++++++++++++++++----
>  2 files changed, 86 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 11ec0179db50..b0d266434288 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -57,6 +57,7 @@ typedef struct AspeedSoCInfo {
>      const char *fmc_typename;
>      const char **spi_typename;
>      int wdts_num;
> +    const int *irqmap;
>  } AspeedSoCInfo;
>  
>  typedef struct AspeedSoCClass {
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index a27233d4876b..5bbd1fb87d18 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -22,6 +22,42 @@
>  #include "hw/i2c/aspeed_i2c.h"
>  #include "net/net.h"
>  
> +enum {
> +    ASPEED_IOMEM,
> +    ASPEED_UART1,
> +    ASPEED_UART2,
> +    ASPEED_UART3,
> +    ASPEED_UART4,
> +    ASPEED_UART5,
> +    ASPEED_VUART,
> +    ASPEED_FMC,
> +    ASPEED_SPI1,
> +    ASPEED_SPI2,
> +    ASPEED_VIC,
> +    ASPEED_SDMC,
> +    ASPEED_SCU,
> +    ASPEED_ADC,
> +    ASPEED_SRAM,
> +    ASPEED_GPIO,
> +    ASPEED_RTC,
> +    ASPEED_TIMER1,
> +    ASPEED_TIMER2,
> +    ASPEED_TIMER3,
> +    ASPEED_TIMER4,
> +    ASPEED_TIMER5,
> +    ASPEED_TIMER6,
> +    ASPEED_TIMER7,
> +    ASPEED_TIMER8,

You use an enum to define const values. It is recommended to also define
the value, to avoid problems if someone add/remove a value in the list
(unlikely, but we never know... imagine someone wants to try this SoC
with 9 timers and add ASPEED_TIMER9) ;)

> +    ASPEED_WDT,
> +    ASPEED_PWM,
> +    ASPEED_LPC,
> +    ASPEED_IBT,
> +    ASPEED_I2C,
> +    ASPEED_ETH1,
> +    ASPEED_ETH2,
> +    ASPEED_SDRAM,
> +};
> +
>  #define ASPEED_SOC_UART_5_BASE      0x00184000
>  #define ASPEED_SOC_IOMEM_SIZE       0x00200000
>  #define ASPEED_SOC_IOMEM_BASE       0x1E600000
> @@ -38,12 +74,42 @@
>  #define ASPEED_SOC_ETH1_BASE        0x1E660000
>  #define ASPEED_SOC_ETH2_BASE        0x1E680000
>  
> -static const int uart_irqs[] = { 9, 32, 33, 34, 10 };
> -static const int timer_irqs[] = { 16, 17, 18, 35, 36, 37, 38, 39, };
> +static const int aspeed_soc_ast2400_irqmap[] = {
> +    [ASPEED_UART1]  = 9,
> +    [ASPEED_UART2]  = 32,
> +    [ASPEED_UART3]  = 33,
> +    [ASPEED_UART4]  = 34,
> +    [ASPEED_UART5]  = 10,
> +    [ASPEED_VUART]  = 8,
> +    [ASPEED_FMC]    = 19,
> +    [ASPEED_SDMC]   = 0,
> +    [ASPEED_SCU]    = 21,
> +    [ASPEED_ADC]    = 31,
> +    [ASPEED_GPIO]   = 20,
> +    [ASPEED_RTC]    = 22,
> +    [ASPEED_TIMER1] = 16,
> +    [ASPEED_TIMER2] = 17,
> +    [ASPEED_TIMER3] = 18,
> +    [ASPEED_TIMER4] = 35,
> +    [ASPEED_TIMER5] = 36,
> +    [ASPEED_TIMER6] = 37,
> +    [ASPEED_TIMER7] = 38,
> +    [ASPEED_TIMER8] = 39,
> +    [ASPEED_WDT]    = 27,
> +    [ASPEED_PWM]    = 28,
> +    [ASPEED_LPC]    = 8,
> +    [ASPEED_IBT]    = 8, /* LPC */
> +    [ASPEED_I2C]    = 12,
> +    [ASPEED_ETH1]   = 2,
> +    [ASPEED_ETH2]   = 3,
> +};
>  
>  #define AST2400_SDRAM_BASE       0x40000000
>  #define AST2500_SDRAM_BASE       0x80000000
>  
> +/* AST2500 uses the same IRQs as the AST2400 */
> +#define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
> +
>  static const hwaddr aspeed_soc_ast2400_spi_bases[] = { ASPEED_SOC_SPI_BASE };
>  static const char *aspeed_soc_ast2400_typenames[] = { "aspeed.smc.spi" };
>  
> @@ -64,6 +130,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
>          .wdts_num     = 2,
> +        .irqmap       = aspeed_soc_ast2400_irqmap,
>      }, {
>          .name         = "ast2400-a1",
>          .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
> @@ -75,6 +142,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
>          .wdts_num     = 2,
> +        .irqmap       = aspeed_soc_ast2400_irqmap,
>      }, {
>          .name         = "ast2400",
>          .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
> @@ -86,6 +154,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .fmc_typename = "aspeed.smc.fmc",
>          .spi_typename = aspeed_soc_ast2400_typenames,
>          .wdts_num     = 2,
> +        .irqmap       = aspeed_soc_ast2400_irqmap,
>      }, {
>          .name         = "ast2500-a1",
>          .cpu_type     = ARM_CPU_TYPE_NAME("arm1176"),
> @@ -97,9 +166,17 @@ static const AspeedSoCInfo aspeed_socs[] = {
>          .fmc_typename = "aspeed.smc.ast2500-fmc",
>          .spi_typename = aspeed_soc_ast2500_typenames,
>          .wdts_num     = 3,
> +        .irqmap       = aspeed_soc_ast2500_irqmap,
>      },
>  };
>  
> +static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
> +{
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +
> +    return qdev_get_gpio_in(DEVICE(&s->vic), sc->info->irqmap[ctrl]);
> +}
> +
>  static void aspeed_soc_init(Object *obj)
>  {
>      AspeedSoCState *s = ASPEED_SOC(obj);
> @@ -226,14 +303,14 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0, ASPEED_SOC_TIMER_BASE);
> -    for (i = 0; i < ARRAY_SIZE(timer_irqs); i++) {
> -        qemu_irq irq = qdev_get_gpio_in(DEVICE(&s->vic), timer_irqs[i]);
> +    for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
> +        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
>      }
>  
>      /* UART - attach an 8250 to the IO space as our UART5 */
>      if (serial_hd(0)) {
> -        qemu_irq uart5 = qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs[4]);
> +        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_UART5);
>          serial_mm_init(get_system_memory(),
>                         ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE, 2,
>                         uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> @@ -247,7 +324,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, ASPEED_SOC_I2C_BASE);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
> -                       qdev_get_gpio_in(DEVICE(&s->vic), 12));
> +                       aspeed_soc_get_irq(s, ASPEED_I2C));
>  
>      /* FMC, The number of CS is set at the board level */
>      object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
> @@ -259,7 +336,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
>                      s->fmc.ctrl->flash_window_base);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
> -                       qdev_get_gpio_in(DEVICE(&s->vic), 19));
> +                       aspeed_soc_get_irq(s, ASPEED_FMC));
>  
>      /* SPI */
>      for (i = 0; i < sc->info->spis_num; i++) {
> @@ -307,7 +384,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_BASE);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
> -                       qdev_get_gpio_in(DEVICE(&s->vic), 2));
> +                       aspeed_soc_get_irq(s, ASPEED_ETH1));
>  }
>  
>  static void aspeed_soc_class_init(ObjectClass *oc, void *data)
> 
