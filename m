Received: from eggs.gnu.org ([209.51.188.92]:51649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guIgl-0002W1-KF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guIgj-0003Og-I8
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:12:35 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guIgj-0003Co-9S
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:12:33 -0500
Received: by mail-ot1-x344.google.com with SMTP id z19so11058110otm.2
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 07:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20190210165735.GA23862@nyan>
In-Reply-To: <20190210165735.GA23862@nyan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 15:12:07 +0000
Message-ID: <CAFEAcA-ZkJAnm____o4zGUv_X547otB8_N8dWFUeQR2vSaMXQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [v3 PATCH] hw/arm/bcm2835_peripherals: add bcm283x
 sp804-alike timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark <alnyan@airmail.cc>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "open list:Raspberry Pi" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On Sun, 10 Feb 2019 at 16:57, Mark <alnyan@airmail.cc> wrote:
>
> Signed-off-by: Mark <alnyan@airmail.cc>

Hi; thanks for submitting this patch! I have some review
comments below. As Andrew suggests, it's probably also a good
idea to look at Gregory Estrade's implementation of the timer,
to see which is the best basis for a patchset to push upstream.

> ---
>  hw/arm/bcm2835_peripherals.c         |  20 ++
>  hw/timer/Makefile.objs               |   2 +
>  hw/timer/bcm283x_timer.c             | 299 +++++++++++++++++++++++++++
>  include/hw/arm/bcm2835_peripherals.h |   2 +
>  include/hw/timer/bcm283x_timer.h     |  38 ++++
>  5 files changed, 361 insertions(+)
>  create mode 100644 hw/timer/bcm283x_timer.c
>  create mode 100644 include/hw/timer/bcm283x_timer.h
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 6be7660e8c..60fa359887 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -117,6 +117,13 @@ static void bcm2835_peripherals_init(Object *obj)
>                                     OBJECT(&s->sdhci.sdbus), &error_abort);
>      object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
>                                     OBJECT(&s->sdhost.sdbus), &error_abort);
> +
> +    /* SP804-alike ARM Timer */
> +    object_initialize(&s->bcm283xsp804, sizeof(s->bcm283xsp804),
> +            TYPE_BCM283xSP804);
> +    object_property_add_child(obj, "bcm283xsp804", OBJECT(&s->bcm283xsp804),
> +            NULL);
> +    qdev_set_parent_bus(DEVICE(&s->bcm283xsp804), sysbus_get_default());

Rather than these three calls, you can do it in one line with
    sysbus-init_child_obj(obj, "bcm283xsp804", &s->bcm283xsp804,
                          sizeof(s->bcm283xsp804), TYPE_BCM283xSP804);


> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 0e9a4530f8..09a3706701 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -47,3 +47,5 @@ common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
>  common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
>  common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
>  common-obj-$(CONFIG_MSF2) += mss-timer.o
> +

Stray blank line.

> +common-obj-$(CONFIG_RASPI) += bcm283x_timer.o
> diff --git a/hw/timer/bcm283x_timer.c b/hw/timer/bcm283x_timer.c
> new file mode 100644
> index 0000000000..55e8a68807
> --- /dev/null
> +++ b/hw/timer/bcm283x_timer.c
> @@ -0,0 +1,299 @@

All new source files in QEMU need to start with a comment that has:
 * a brief statement of what the source code is
 * a copyright line
 * the license that the code is under

> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "qemu/timer.h"
> +#include "qemu-common.h"
> +#include "hw/qdev.h"
> +#include "hw/ptimer.h"
> +#include "hw/timer/bcm283x_timer.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/log.h"
> +
> +/* TODO: implement free-running timer as per BCM283x peripheral specification */
> +
> +#define TIMER_CTRL_32BIT    (1 << 1)
> +#define TIMER_CTRL_DIV1     (0 << 2)
> +#define TIMER_CTRL_DIV16    (1 << 2)
> +#define TIMER_CTRL_DIV256   (2 << 2)
> +#define TIMER_CTRL_IE       (1 << 5)
> +#define TIMER_CTRL_ENABLE   (1 << 7)
> +
> +struct bcm283x_timer_state {
> +    ptimer_state *timer;
> +    uint32_t control;
> +    uint32_t limit;
> +    int freq;
> +    int int_level;

In device state structures, types like 'int' don't usually
work very well with the VMSTATE_ macros that are used to
save and restore state. It's better to use the fixed-width
types like uint32_t and int32_t.

> +    qemu_irq irq;
> +    /* Not implemented */
> +    int prev_div;
> +    /* Not implemented */
> +    int free_run_cnt;
> +};

Unlike the SP804, this device has only one timer in it.
So I think you'll find it simpler to just drop this struct
and put the members directly into the BCM283xSP804State struct.


> +
> +static void bcm283x_timer_update(bcm283x_timer_state *s)
> +{
> +    if (s->int_level && (s->control & TIMER_CTRL_IE)) {
> +        qemu_irq_raise(s->irq);
> +    } else {
> +        qemu_irq_lower(s->irq);
> +    }
> +}
> +
> +static uint32_t bcm283x_timer_read(void *opaque, hwaddr offset)
> +{
> +    bcm283x_timer_state *s = (bcm283x_timer_state *) opaque;
> +
> +    switch (offset >> 2) {
> +    case 0: /* Load register */
> +    case 6: /* Reload register */
> +        return s->limit;
> +    case 1: /* Value register */
> +        return ptimer_get_count(s->timer);
> +    case 2: /* Control register */
> +        return s->control;
> +    case 3: /* IRQ clear/ACK register */
> +        /*
> +         * The register is write-only,
> +         * but returns reverse "ARMT" string bytes
> +         */

I was surprised to find that this is actually what the hardware
is documented as doing !

> +        return 0x544D5241;
> +    case 4: /* RAW IRQ register */
> +        return s->int_level;
> +    case 5: /* Masked IRQ register */
> +        if ((s->control & TIMER_CTRL_IE) == 0) {
> +            return 0;
> +        }
> +        return s->int_level;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset %x\n", __func__, (int) offset);
> +        return 0;
> +    }
> +}
> +
> +static void bcm283x_timer_recalibrate(bcm283x_timer_state *s, int reload)
> +{
> +    uint32_t limit;
> +
> +    /* Consider timer periodic */
> +    limit = s->limit;
> +
> +    ptimer_set_limit(s->timer, limit, reload);

You could just pass s->limit to the function call rather
than having a local variable here.

> +}
> +
> +static void bcm283x_timer_write(void *opaque, hwaddr offset, uint32_t value)
> +{
> +    bcm283x_timer_state *s = (bcm283x_timer_state *) opaque;
> +    int freq;
> +
> +    switch (offset >> 2) {
> +    case 0: /* Load register */
> +        s->limit = value;
> +        bcm283x_timer_recalibrate(s, 1);
> +        break;
> +    case 1: /* Value register */
> +        /* Read only */
> +        break;
> +    case 2: /* Control register */
> +        if (s->control & TIMER_CTRL_ENABLE) {
> +            ptimer_stop(s->timer);
> +        }
> +
> +        s->control = value;
> +        freq = s->freq;
> +
> +        /* Set pre-scaler */
> +        switch ((value >> 2) & 3) {
> +        case 1: /* 16 */
> +            freq >>= 4;
> +            break;
> +        case 2: /* 256 */
> +            freq >>= 8;
> +            break;
> +        }
> +
> +        bcm283x_timer_recalibrate(s, s->control & TIMER_CTRL_ENABLE);
> +        ptimer_set_freq(s->timer, freq);
> +        if (s->control & TIMER_CTRL_ENABLE) {
> +            ptimer_run(s->timer, 0);
> +        }
> +        break;
> +    case 3: /* IRQ clear/ACK register */
> +        s->int_level = 0;
> +        break;
> +    case 6: /* Reload register */
> +        s->limit = value;
> +        bcm283x_timer_recalibrate(s, 0);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset %x\n", __func__, (int) offset);
> +        break;
> +    }
> +
> +    bcm283x_timer_update(s);
> +}
> +
> +static void bcm283x_timer_tick(void *opaque)
> +{
> +    bcm283x_timer_state *s = (bcm283x_timer_state *) opaque;
> +    s->int_level = 1;
> +    bcm283x_timer_update(s);
> +}
> +
> +static const VMStateDescription vmstate_bcm283x_timer = {
> +    .name = "bcm283x_timer",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(control, bcm283x_timer_state),
> +        VMSTATE_UINT32(limit, bcm283x_timer_state),
> +        VMSTATE_INT32(int_level, bcm283x_timer_state),
> +        VMSTATE_PTIMER(timer, bcm283x_timer_state),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bcm283x_timer_state *bcm283x_timer_init(uint32_t freq)
> +{
> +    bcm283x_timer_state *s;
> +    QEMUBH *bh;
> +
> +    s = g_new0(bcm283x_timer_state, 1);
> +    s->freq = freq;
> +    s->control = TIMER_CTRL_IE;
> +
> +    bh = qemu_bh_new(bcm283x_timer_tick, s);
> +    s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
> +    vmstate_register(NULL, -1, &vmstate_bcm283x_timer, s);
> +
> +    return s;
> +}
> +
> +/* BCM283x's implementation of SP804 ARM timer */
> +
> +/*
> + * XXX: BCM's datasheet does not seem to
> + * provide these values and they may differ
> + */

These ID registers I think do not exist at all. You can
tell because the space in the address map for the timer
is only 0x400 bytes (the following device, the "SBM",
comes after that). So there's no space for the IDs.

> +static const uint8_t bcm283xsp803_ids[] = {
> +    /* Timer ID */
> +    0x04, 0x18, 0x14, 0x00,
> +    /* PrimeCell ID */
> +    0x0D, 0xF0, 0x05, 0xB1
> +};
> +
> +static void bcm283xsp804_set_irq(void *opaque, int irq, int level)
> +{
> +    BCM283xSP804State *s = (BCM283xSP804State *) opaque;
> +
> +    s->level = level;
> +    qemu_set_irq(s->irq, s->level);
> +}

I don't think you need this 'level' field in the struct or
this function.

> +
> +static uint64_t bcm283xsp804_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    BCM283xSP804State *s = (BCM283xSP804State *) opaque;
> +
> +    if (offset < 0x20) {
> +        return bcm283x_timer_read(s->timer, offset);
> +    }
> +    /* No second timer (0x20 < offset < 0x40) */
> +
> +    if (offset >= 0xFE0 && offset <= 0xFFC) {
> +        return bcm283xsp803_ids[(offset - 0xFE0) >> 2];
> +    }
> +
> +    switch (offset) {
> +    /* Unimplemented: integration test control registers */
> +    case 0xF00:
> +    case 0xF04:

Similarly, these registers can't exist in the bcm2835 timer,
because they're off the end of the space available for the
device. (So this whole function collapses down to just calling
bcm283x_timer_read(), which you can then just put inline in
this function, rather than having a separate function. The
sp804 code only has the split like this because the sp804
has two identical timer modules in one device.)

> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: integration test registers unimplemented\n",
> +                      __func__);
> +        return 0;
> +    }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "%s: Bad offset %x\n", __func__, (int) offset);
> +    return 0;
> +}
> +
> +static void bcm283xsp803_write(void *opaque, hwaddr offset, uint64_t value,
> +        unsigned size)

Typo in the function name ('3' instead of '4').

> +{
> +    BCM283xSP804State *s = (BCM283xSP804State *) opaque;
> +
> +    if (offset < 0x20) {
> +        bcm283x_timer_write(s->timer, offset, value);
> +    }
> +    /* No second timer (0x20 < offset < 0x40) */
> +
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "%s: Bad offset %x\n", __func__, (int) offset);
> +}
> +
> +static const MemoryRegionOps bcm283xsp804_ops = {
> +    .read = bcm283xsp804_read,
> +    .write = bcm283xsp803_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN
> +};
> +
> +static const VMStateDescription vmstate_bcm283xsp804 = {
> +    .name = "bcm283xsp804",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT32(level, BCM283xSP804State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void bcm283xsp804_init(Object *obj)
> +{
> +    BCM283xSP804State *s = BCM283xSP804(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +    memory_region_init_io(&s->iomem, obj, &bcm283xsp804_ops, s,
> +            "bcm283xsp804", 0x1000);
> +
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static void bcm283xsp804_realize(DeviceState *dev, Error **errp)
> +{
> +    BCM283xSP804State *s = BCM283xSP804(dev);
> +
> +    s->timer = bcm283x_timer_init(s->freq0);
> +    s->timer->irq = qemu_allocate_irq(bcm283xsp804_set_irq, s, 0);
> +}
> +
> +static Property bcm283xsp804_properties[] = {
> +    DEFINE_PROP_UINT32("freq0", BCM283xSP804State, freq0, 1000000),

The only user of this device doesn't specify the freq0 property,
so you might as well not put it in at all. Just use a #define
for the frequency. (We can wire it up properly later if we need to.)

> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static void bcm283xsp804_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *k = DEVICE_CLASS(klass);
> +
> +    k->realize = bcm283xsp804_realize;
> +    k->props = bcm283xsp804_properties;
> +    k->vmsd = &vmstate_bcm283xsp804;

You also want a reset function, which should be hooked in via
k->reset here.

> +}
> +
> +static const TypeInfo bcm283xsp804_info = {
> +    .name           = TYPE_BCM283xSP804,
> +    .parent         = TYPE_SYS_BUS_DEVICE,
> +    .instance_size  = sizeof(BCM283xSP804State),
> +    .instance_init  = bcm283xsp804_init,
> +    .class_init     = bcm283xsp804_class_init
> +};
> +
> +static void bcm283x_timer_register_types(void)
> +{
> +    type_register_static(&bcm283xsp804_info);
> +}
> +
> +type_init(bcm283x_timer_register_types)
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
> index f5b193f670..d13aad43cb 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -23,6 +23,7 @@
>  #include "hw/sd/sdhci.h"
>  #include "hw/sd/bcm2835_sdhost.h"
>  #include "hw/gpio/bcm2835_gpio.h"
> +#include "hw/timer/bcm283x_timer.h"
>
>  #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
>  #define BCM2835_PERIPHERALS(obj) \
> @@ -48,6 +49,7 @@ typedef struct BCM2835PeripheralState {
>      SDHCIState sdhci;
>      BCM2835SDHostState sdhost;
>      BCM2835GpioState gpio;
> +    BCM283xSP804State bcm283xsp804;
>  } BCM2835PeripheralState;
>
>  #endif /* BCM2835_PERIPHERALS_H */
> diff --git a/include/hw/timer/bcm283x_timer.h b/include/hw/timer/bcm283x_timer.h
> new file mode 100644
> index 0000000000..c43b4d3776
> --- /dev/null
> +++ b/include/hw/timer/bcm283x_timer.h
> @@ -0,0 +1,38 @@
> +/*
> + * Broadcom BCM283x ARM timer variant based on ARM SP804
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

You should put a copyright line in here too.

> +#ifndef HW_TIMER_BCM2835_TIMER_H
> +#define HW_TIMER_BCM2835_TIMER_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_BCM283xSP804 "bcm283xsp804"
> +#define BCM283xSP804(obj) \
> +    OBJECT_CHECK(BCM283xSP804State, (obj), TYPE_BCM283xSP804)

I would suggest dropping "SP804" from the name entirely.
Then you can have "BCM283xTimerState" for the struct name,
TYPE_BCM283x_TIMER for the type name, and so on. This
matches better with how we've named the other devices
in the SoC.


> +
> +typedef struct bcm283x_timer_state bcm283x_timer_state;
> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    bcm283x_timer_state *timer;
> +    uint32_t freq0;
> +    int level;
> +    qemu_irq irq;
> +} BCM283xSP804State;

thanks
-- PMM
