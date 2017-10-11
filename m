Received: from eggs.gnu.org ([2001:4830:134:3::10]:54958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2INj-0001Jt-1D
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2INh-0005bV-LN
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:53:11 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:56179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2INh-0005b8-C0
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:53:09 -0400
Received: by mail-wm0-x22d.google.com with SMTP id u138so5595098wmu.4
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 07:53:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507728290-6062-1-git-send-email-thomas.venries@gmail.com>
References: <150771862388.288.7275764832812347655@b58463cdfd5f>
	<1507728290-6062-1-git-send-email-thomas.venries@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Oct 2017 15:52:47 +0100
Message-ID: <CAFEAcA_qyyr2tJ4MOTwdeH=bs9eAAgznPox4yCAX7n2p+7ipFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] bcm2835_armtimer: add bcm2835 ARM timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Thomas_Venri=C3=A8s?= <thomas.venries@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 11 October 2017 at 14:24, Thomas Venri=C3=A8s <thomas.venries@gmail.com>=
 wrote:
> The ARM Timer is based on a ARM AP804, but it has
> a number of differences with the standard SP804.
> There is only one timer which runs in continuous
> mode with an extra clock pre-divider register
> and a 32-bit free running counter.
>
> The extra stop-in-debug-mode control bit is not
> implemented.
>
> Signed-off-by: Thomas Venri=C3=A8s <thomas.venries@gmail.com>
> ---
>  hw/arm/bcm2835_peripherals.c         |  18 +++
>  hw/timer/Makefile.objs               |   1 +
>  hw/timer/bcm2835_armtimer.c          | 273 +++++++++++++++++++++++++++++=
++++++
>  hw/timer/trace-events                |   4 +
>  include/hw/arm/bcm2835_peripherals.h |   2 +
>  include/hw/timer/bcm2835_armtimer.h  |  35 +++++
>  6 files changed, 333 insertions(+)
>  create mode 100644 hw/timer/bcm2835_armtimer.c
>  create mode 100644 include/hw/timer/bcm2835_armtimer.h
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 12e0dd1..73deb2e 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -90,6 +90,11 @@ static void bcm2835_peripherals_init(Object *obj)
>      object_property_add_child(obj, "rng", OBJECT(&s->rng), NULL);
>      qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());
>
> +    /* ARM Timer */
> +    object_initialize(&s->armtimer, sizeof(s->armtimer), TYPE_BCM2835_AR=
MTIMER);
> +    object_property_add_child(obj, "armtimer", OBJECT(&s->armtimer), NUL=
L);
> +    qdev_set_parent_bus(DEVICE(&s->armtimer), sysbus_get_default());
> +
>      /* Extended Mass Media Controller */
>      object_initialize(&s->sdhci, sizeof(s->sdhci), TYPE_SYSBUS_SDHCI);
>      object_property_add_child(obj, "sdhci", OBJECT(&s->sdhci), NULL);
> @@ -254,6 +259,19 @@ static void bcm2835_peripherals_realize(DeviceState =
*dev, Error **errp)
>      memory_region_add_subregion(&s->peri_mr, RNG_OFFSET,
>                  sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0));
>
> +    /* ARM Timer */
> +    object_property_set_bool(OBJECT(&s->armtimer), true, "realized", &er=
r);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    memory_region_add_subregion(&s->peri_mr, ARMCTRL_TIMER0_1_OFFSET,
> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->armtimer), 0))=
;
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->armtimer), 0,
> +        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_ARM_IRQ,
> +                               INTERRUPT_ARM_TIMER));
> +
>      /* Extended Mass Media Controller */
>      object_property_set_int(OBJECT(&s->sdhci), BCM2835_SDHC_CAPAREG, "ca=
pareg",
>                              &err);
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 8c19eac..268d485 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -29,6 +29,7 @@ obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
>  obj-$(CONFIG_OMAP) +=3D omap_gptimer.o
>  obj-$(CONFIG_OMAP) +=3D omap_synctimer.o
>  obj-$(CONFIG_PXA2XX) +=3D pxa2xx_timer.o
> +obj-$(CONFIG_RASPI) +=3D bcm2835_armtimer.o
>  obj-$(CONFIG_SH4) +=3D sh_timer.o
>  obj-$(CONFIG_DIGIC) +=3D digic-timer.o
>  obj-$(CONFIG_MIPS_CPS) +=3D mips_gictimer.o
> diff --git a/hw/timer/bcm2835_armtimer.c b/hw/timer/bcm2835_armtimer.c
> new file mode 100644
> index 0000000..39ff213
> --- /dev/null
> +++ b/hw/timer/bcm2835_armtimer.c
> @@ -0,0 +1,273 @@
> +/*
> + * BCM2835 ARM Timer
> + *
> + * Copyright (C) 2017 Thomas Venri=C3=A8s <thomas.venries@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "qemu/timer.h"
> +#include "qemu/main-loop.h"
> +#include "hw/ptimer.h"
> +#include "hw/timer/bcm2835_armtimer.h"
> +#include "trace.h"
> +
> +#define ARM_TIMER_REG_SIZE      0x24
> +
> +/* Register offsets */
> +#define ARM_TIMER_LOAD          0x00
> +#define ARM_TIMER_VALUE         0x04
> +#define ARM_TIMER_CTRL          0x08
> +#define ARM_TIMER_INTCLR        0x0C
> +#define ARM_TIMER_RAW_IRQ       0x10
> +#define ARM_TIMER_MASK_IRQ      0x14
> +#define ARM_TIMER_RELOAD        0x18
> +#define ARM_TIMER_PREDIVIDER    0x1C
> +#define ARM_TIMER_COUNTER       0x20
> +
> +/* Control register masks */
> +#define CTRL_CNT_PRESCALE       (0xFF << 16)
> +#define CTRL_CNT_ENABLE         (1 << 9)
> +#define CTRL_TIMER_ENABLE       (1 << 7)
> +#define CTRL_INT_ENABLE         (1 << 5)
> +#define CTRL_TIMER_PRESCALE     (3 << 2)
> +#define CTRL_TIMER_SIZE_32BIT   (1 << 1)
> +
> +#define CTRL_TIMER_WRAP_MODE    0
> +
> +/* Register reset values */
> +#define CTRL_CNT_PRESCALE_RESET     (0x3E << 16)
> +#define ARM_TIMER_CTRL_RESET        (CTRL_CNT_PRESCALE_RESET | CTRL_INT_=
ENABLE)
> +#define ARM_TIMER_IE_READ_VALUE     0x544D5241  /* ASCII "ARMT" */
> +/*
> +   The system clock refers to a 250 MHz frequency by default.
> +   This frequency can be changed by setting `core_freq` the `config.txt`=
 file.

What config.txt is this referring to?

> +   APB clock runs at half the speed of the system clock also called ARM =
clock.
> +
> +   The ARM timer's predivider register is 10 bits wide and can be writte=
n
> +   or read from. This register has been added as the SP804 expects a 1MH=
z clock
> +   which they do not have. Instead the predivider takes the APB clock
> +   and divides it down according to:
> +
> +       timer_clock =3D apb_clock / (prediv + 1)
> +
> +   The need is a 1MHz timer clock frequency and BCM2835 ARM Peripherals
> +   documentation mentions the predivider reset value is 0x7D (or 125), s=
o
> +   the APB clock refers to a 126MHz frequency.
> +
> +   Also the additional free-running counter runs from the APB clock and =
has
> +   its own clock predivider controlled by buts 16-23 of the timer contro=
l reg:
> +
> +       frc_clock =3D apb_clock / (prediv + 1)
> +
> +   The predivider reset value is 0x3E (or 62), knowing APB clock frequen=
cy,
> +   the FRN clock refers to a 2MHz frequency by default.
> +*/
> +#define ARM_APB_FREQ                126000000UL /* Hz */
> +#define ARM_TIMER_PREDIVIDER_RESET  125         /* MHz */
> +
> +static const uint16_t ctrl_prescale[] =3D { 1, 16, 256, 1 };
> +
> +static void bcm2835_armtimer_recalibrate(BCM2835ARMTimerState *s, int re=
load)
> +{
> +    uint32_t limit;
> +
> +    /* ARM Dual-Timer Module SP804, section 3.2.1:
> +       If the Load Register is set to 0 then an interrupt is generated
> +       immediately. */
> +    if (reload =3D=3D 2) {
> +        limit =3D s->reload;
> +    } else {
> +        limit =3D (s->ctrl & CTRL_TIMER_SIZE_32BIT) ? 0xFFFFFFFF : 0XFFF=
F;
> +    }
> +
> +    ptimer_set_limit(s->timer, limit, reload);
> +}

This whole file is very duplicative of code with arm-timer.c. Can
we implement it by adding a property to the arm_timer device that
says "behave like the bcm2835 variant" ?

thanks
-- PMM
