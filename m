Received: from eggs.gnu.org ([2001:4830:134:3::10]:39064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fn11u-0001og-Ml
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fn11r-00049P-II
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:24:02 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:49287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fn11r-000498-7r
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:23:59 -0400
Received: from player731.ha.ovh.net (unknown [10.109.146.86])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B236814705F
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 14:23:56 +0200 (CEST)
References: <20180807075757.7242-1-joel@jms.id.au>
	<20180807075757.7242-8-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bdb3e130-03d5-56dc-911b-a31308846382@kaod.org>
Date: Tue, 7 Aug 2018 14:23:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180807075757.7242-8-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] aspeed: Link SCU to the watchdog
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/07/2018 09:57 AM, Joel Stanley wrote:
> The ast2500 uses the watchdog to reset the SDRAM controller. This
> operation is usually performed by u-boot's memory training procedure,
> and it is enabled by setting a bit in the SCU and then causing the
> watchdog to expire. Therefore, we need the watchdog to be able to
> acess the SCU's register space.

... access ...

> This does not cause a system reset, but only resets the SDRAM
> controller.

Well, it does nothing below :)=20

I think we should call device_reset() on all the devices that have their=20
reset bit enabled in the SCU System Reset Control Register and in the =20
Reset Mask Register of the watchdog being used.


Watchdog Reset Mask Register bits :

31:26 Reserved
   25 Enable reset Misc. SOC controller (WDT, RTC, Timer, UART, SRAM)
   24 Enable reset SPI controller
   23 Enable reset X-DMA controller
   22 Enable reset MCTP controller
   21 Enable reset GPIO controller
   20 Enable reset ADC controller
   19 Enable reset JTAG master controller
   18 Enable reset PECI controller
   17 Enable reset PWM controller
   16 Enable reset CRT mode 2D engine
   15 Enable reset MIC controller
   14 Enable reset SD/SDIO controller
   13 Enable reset LPC controller
   12 Enable reset HAC engine
   11 Enable reset Video engine
   10 Enable reset USB1.1 HID/USB2.0 Host EHCI2 controller
    9 Enable reset USB1.1 Host controller
    8 Enable reset USB2.0 Host/Hub controller
    7 Enable reset Graphics CRT controller
    6 Enable reset MAC#2 controller
    5 Enable reset MAC#1 controller
    4 Enable reset I2C controller
    3 Enable reset AHB bridges
    2 Enable reset SDRAM controller
    1 Enable reset Coprocessor
    0 Enable reset ARM

Default value is 0x23FFFF3 which means reset all devices a part from :

   SPI controller
   X-DMA controller
   MCTP controller
   AHB bridges
   SDRAM controller

SCU System Reset Control Register ( has a different layout :/)
 =20
   25 Reset X-DMA controller
   24 Reset MCTP controller
   23 Reset ADC controller
   22 Reset JTAG Master controller
   21 Reserved
   20 PEWAKE# pin output enable control
   19 PEWAKE# pin output value
   18 Reset MIC controller
   17 Reserved, must keep at value =E2=80=9D1=E2=80=9D
   16 Reset SD/SDIO card controller
   15 Reset USB1.1 Host controller
   14 Reset USB2.0 Hub/Host controller
   13 Reset CRT controller
   12 Reset MAC#2 controller
   11 Reset MAC#1 controller
   10 Reset PECI controller
    9 Reset PWM controller
    8 Disable PCI bus controller and VGA controller
    7 Reset 2D engine
    6 Reset Video engine
    5 Reset LPC controller
    4 Reset HAC engine
    3 Reset USB1.1 HID controller
    2 Reset I2C/SMBus controller
    1 Reset AHB bridges
    0 Enable reset SDRAM controller when full chip Watchdog reset occur

Default value is 0xFFCFFEDC which means reset all devices a part from :

    5 Reset LPC controller
    1 Reset AHB bridges
    0 Enable reset SDRAM controller


> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/arm/aspeed_soc.c              |  2 ++
>  hw/watchdog/wdt_aspeed.c         | 20 ++++++++++++++++++++
>  include/hw/watchdog/wdt_aspeed.h |  1 +
>  3 files changed, 23 insertions(+)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index a27233d4876b..2cbacb4430bb 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -164,6 +164,8 @@ static void aspeed_soc_init(Object *obj)
>          qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus_get_default());
>          qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
>                                      sc->info->silicon_rev);
> +        object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
> +                                       OBJECT(&s->scu), &error_abort);
>      }
> =20
>      object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC=
100);
> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> index 95f6ad186d72..f5cb30c0b584 100644
> --- a/hw/watchdog/wdt_aspeed.c
> +++ b/hw/watchdog/wdt_aspeed.c
> @@ -43,6 +43,9 @@
> =20
>  #define WDT_RESTART_MAGIC               0x4755
> =20
> +#define SCU_RESET_CONTROL1              (0x04 / 4)

Too bad that the Aspeed SCU registers are already defined in the .c file.=
 =20

> +#define    SCU_RESET_SDRAM              BIT(0)
> +
>  static bool aspeed_wdt_is_enabled(const AspeedWDTState *s)
>  {
>      return s->regs[WDT_CTRL] & WDT_CTRL_ENABLE;
> @@ -221,6 +224,13 @@ static void aspeed_wdt_timer_expired(void *dev)
>  {
>      AspeedWDTState *s =3D ASPEED_WDT(dev);
> =20
> +    /* Do not reset on SDRAM controller reset */
> +    if (s->scu->regs[SCU_RESET_CONTROL1] & SCU_RESET_SDRAM) {
> +        timer_del(s->timer);
> +        s->regs[WDT_CTRL] =3D 0;
> +        return;
> +    }
> +
>      qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
>      watchdog_perform_action();
>      timer_del(s->timer);
> @@ -232,6 +242,16 @@ static void aspeed_wdt_realize(DeviceState *dev, E=
rror **errp)
>  {
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      AspeedWDTState *s =3D ASPEED_WDT(dev);
> +    Error *err =3D NULL;
> +    Object *obj;
> +
> +    obj =3D object_property_get_link(OBJECT(dev), "scu", &err);
> +    if (!obj) {
> +        error_propagate(errp, err);
> +        error_prepend(errp, "required link 'scu' not found: ");
> +        return;
> +    }
> +    s->scu =3D ASPEED_SCU(obj);
> =20
>      if (!is_supported_silicon_rev(s->silicon_rev)) {
>          error_setg(errp, "Unknown silicon revision: 0x%" PRIx32,
> diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt=
_aspeed.h
> index 7de3e5c224fb..cc734bd7ae7b 100644
> --- a/include/hw/watchdog/wdt_aspeed.h
> +++ b/include/hw/watchdog/wdt_aspeed.h
> @@ -26,6 +26,7 @@ typedef struct AspeedWDTState {
>      MemoryRegion iomem;
>      uint32_t regs[ASPEED_WDT_REGS_MAX];
> =20
> +    AspeedSCUState *scu;
>      uint32_t pclk_freq;
>      uint32_t silicon_rev;
>      uint32_t ext_pulse_width_mask;
>=20
