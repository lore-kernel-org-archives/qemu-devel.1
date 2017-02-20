Received: from eggs.gnu.org ([2001:4830:134:3::10]:50621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfrzs-0000jO-Td
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 12:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfrzq-0001d1-7w
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 12:43:36 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
	<1487604965-23220-10-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b13702b2-44be-563b-5743-33c773a6e037@amsat.org>
Date: Mon, 20 Feb 2017 14:43:28 -0300
MIME-Version: 1.0
In-Reply-To: <1487604965-23220-10-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 09/11] armv7m: Split systick out
 from NVIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>, patches@linaro.org

Hi peter,

On 02/20/2017 12:36 PM, Peter Maydell wrote:
> The SysTick timer isn't really part of the NVIC proper;
> we just modelled it that way back when we couldn't
> easily have devices that only occupied a small chunk
> of a memory region. Split it out into its own device.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/Makefile.objs            |   1 +
>  include/hw/arm/armv7m_nvic.h      |  10 +-
>  include/hw/timer/armv7m_systick.h |  34 ++++++
>  hw/intc/armv7m_nvic.c             | 160 ++++++-------------------
>  hw/timer/armv7m_systick.c         | 239 ++++++++++++++++++++++++++++++++++++++
>  hw/timer/trace-events             |   6 +
>  6 files changed, 317 insertions(+), 133 deletions(-)
>  create mode 100644 include/hw/timer/armv7m_systick.h
>  create mode 100644 hw/timer/armv7m_systick.c
>
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index fc99668..dd6f27e 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -1,5 +1,6 @@
>  common-obj-$(CONFIG_ARM_TIMER) += arm_timer.o
>  common-obj-$(CONFIG_ARM_MPTIMER) += arm_mptimer.o
> +common-obj-$(CONFIG_ARM_V7M) += armv7m_systick.o
>  common-obj-$(CONFIG_A9_GTIMER) += a9gtimer.o
>  common-obj-$(CONFIG_CADENCE) += cadence_ttc.o
>  common-obj-$(CONFIG_DS1338) += ds1338.o
> diff --git a/include/hw/arm/armv7m_nvic.h b/include/hw/arm/armv7m_nvic.h
> index 39b94ee..1d145fb 100644
> --- a/include/hw/arm/armv7m_nvic.h
> +++ b/include/hw/arm/armv7m_nvic.h
> @@ -12,6 +12,7 @@
>
>  #include "target/arm/cpu.h"
>  #include "hw/sysbus.h"
> +#include "hw/timer/armv7m_systick.h"
>
>  #define TYPE_NVIC "armv7m_nvic"
>
> @@ -48,19 +49,14 @@ typedef struct NVICState {
>      unsigned int vectpending; /* highest prio pending enabled exception */
>      int exception_prio; /* group prio of the highest prio active exception */
>
> -    struct {
> -        uint32_t control;
> -        uint32_t reload;
> -        int64_t tick;
> -        QEMUTimer *timer;
> -    } systick;
> -
>      MemoryRegion sysregmem;
>      MemoryRegion container;
>
>      uint32_t num_irq;
>      qemu_irq excpout;
>      qemu_irq sysresetreq;
> +
> +    SysTickState systick;
>  } NVICState;
>
>  #endif
> diff --git a/include/hw/timer/armv7m_systick.h b/include/hw/timer/armv7m_systick.h
> new file mode 100644
> index 0000000..cca04de
> --- /dev/null
> +++ b/include/hw/timer/armv7m_systick.h
> @@ -0,0 +1,34 @@
> +/*
> + * ARMv7M SysTick timer
> + *
> + * Copyright (c) 2006-2007 CodeSourcery.
> + * Written by Paul Brook
> + * Copyright (c) 2017 Linaro Ltd
> + * Written by Peter Maydell
> + *
> + * This code is licensed under the GPL (version 2 or later).
> + */
> +
> +#ifndef HW_TIMER_ARMV7M_SYSTICK_H
> +#define HW_TIMER_ARMV7M_SYSTICK_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_SYSTICK "armv7m_systick"
> +
> +#define SYSTICK(obj) OBJECT_CHECK(SysTickState, (obj), TYPE_SYSTICK)
> +
> +typedef struct SysTickState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    uint32_t control;
> +    uint32_t reload;
> +    int64_t tick;
> +    QEMUTimer *timer;
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +} SysTickState;
> +
> +#endif
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index c814e16..32ffa0b 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -58,65 +58,6 @@ static const uint8_t nvic_id[] = {
>      0x00, 0xb0, 0x1b, 0x00, 0x0d, 0xe0, 0x05, 0xb1
>  };
>
> -/* qemu timers run at 1GHz.   We want something closer to 1MHz.  */
> -#define SYSTICK_SCALE 1000ULL
> -
> -#define SYSTICK_ENABLE    (1 << 0)
> -#define SYSTICK_TICKINT   (1 << 1)
> -#define SYSTICK_CLKSOURCE (1 << 2)
> -#define SYSTICK_COUNTFLAG (1 << 16)
> -
> -int system_clock_scale;
> -
> -/* Conversion factor from qemu timer to SysTick frequencies.  */
> -static inline int64_t systick_scale(NVICState *s)
> -{
> -    if (s->systick.control & SYSTICK_CLKSOURCE)
> -        return system_clock_scale;
> -    else
> -        return 1000;
> -}
> -
> -static void systick_reload(NVICState *s, int reset)
> -{
> -    /* The Cortex-M3 Devices Generic User Guide says that "When the
> -     * ENABLE bit is set to 1, the counter loads the RELOAD value from the
> -     * SYST RVR register and then counts down". So, we need to check the
> -     * ENABLE bit before reloading the value.
> -     */
> -    if ((s->systick.control & SYSTICK_ENABLE) == 0) {
> -        return;
> -    }
> -
> -    if (reset)
> -        s->systick.tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    s->systick.tick += (s->systick.reload + 1) * systick_scale(s);
> -    timer_mod(s->systick.timer, s->systick.tick);
> -}
> -
> -static void systick_timer_tick(void * opaque)
> -{
> -    NVICState *s = (NVICState *)opaque;
> -    s->systick.control |= SYSTICK_COUNTFLAG;
> -    if (s->systick.control & SYSTICK_TICKINT) {
> -        /* Trigger the interrupt.  */
> -        armv7m_nvic_set_pending(s, ARMV7M_EXCP_SYSTICK);
> -    }
> -    if (s->systick.reload == 0) {
> -        s->systick.control &= ~SYSTICK_ENABLE;
> -    } else {
> -        systick_reload(s, 0);
> -    }
> -}
> -
> -static void systick_reset(NVICState *s)
> -{
> -    s->systick.control = 0;
> -    s->systick.reload = 0;
> -    s->systick.tick = 0;
> -    timer_del(s->systick.timer);
> -}
> -
>  static int nvic_pending_prio(NVICState *s)
>  {
>      /* return the priority of the current pending interrupt,
> @@ -462,30 +403,6 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset)
>      switch (offset) {
>      case 4: /* Interrupt Control Type.  */
>          return ((s->num_irq - NVIC_FIRST_IRQ) / 32) - 1;
> -    case 0x10: /* SysTick Control and Status.  */
> -        val = s->systick.control;
> -        s->systick.control &= ~SYSTICK_COUNTFLAG;
> -        return val;
> -    case 0x14: /* SysTick Reload Value.  */
> -        return s->systick.reload;
> -    case 0x18: /* SysTick Current Value.  */
> -        {
> -            int64_t t;
> -            if ((s->systick.control & SYSTICK_ENABLE) == 0)
> -                return 0;
> -            t = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -            if (t >= s->systick.tick)
> -                return 0;
> -            val = ((s->systick.tick - (t + 1)) / systick_scale(s)) + 1;
> -            /* The interrupt in triggered when the timer reaches zero.
> -               However the counter is not reloaded until the next clock
> -               tick.  This is a hack to return zero during the first tick.  */
> -            if (val > s->systick.reload)
> -                val = 0;
> -            return val;
> -        }
> -    case 0x1c: /* SysTick Calibration Value.  */
> -        return 10000;
>      case 0xd00: /* CPUID Base.  */
>          return cpu->midr;
>      case 0xd04: /* Interrupt Control State.  */
> @@ -620,40 +537,8 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset)
>  static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
>  {
>      ARMCPU *cpu = s->cpu;
> -    uint32_t oldval;
> +
>      switch (offset) {
> -    case 0x10: /* SysTick Control and Status.  */
> -        oldval = s->systick.control;
> -        s->systick.control &= 0xfffffff8;
> -        s->systick.control |= value & 7;
> -        if ((oldval ^ value) & SYSTICK_ENABLE) {
> -            int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -            if (value & SYSTICK_ENABLE) {
> -                if (s->systick.tick) {
> -                    s->systick.tick += now;
> -                    timer_mod(s->systick.timer, s->systick.tick);
> -                } else {
> -                    systick_reload(s, 1);
> -                }
> -            } else {
> -                timer_del(s->systick.timer);
> -                s->systick.tick -= now;
> -                if (s->systick.tick < 0)
> -                  s->systick.tick = 0;
> -            }
> -        } else if ((oldval ^ value) & SYSTICK_CLKSOURCE) {
> -            /* This is a hack. Force the timer to be reloaded
> -               when the reference clock is changed.  */
> -            systick_reload(s, 1);
> -        }
> -        break;
> -    case 0x14: /* SysTick Reload Value.  */
> -        s->systick.reload = value;
> -        break;
> -    case 0x18: /* SysTick Current Value.  Writes reload the timer.  */
> -        systick_reload(s, 1);
> -        s->systick.control &= ~SYSTICK_COUNTFLAG;
> -        break;
>      case 0xd04: /* Interrupt Control State.  */
>          if (value & (1 << 31)) {
>              armv7m_nvic_set_pending(s, ARMV7M_EXCP_NMI);
> @@ -952,16 +837,12 @@ static const VMStateDescription vmstate_VecInfo = {
>
>  static const VMStateDescription vmstate_nvic = {
>      .name = "armv7m_nvic",
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> +    .version_id = 4,
> +    .minimum_version_id = 4,
>      .post_load = &nvic_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_STRUCT_ARRAY(vectors, NVICState, NVIC_MAX_VECTORS, 1,
>                               vmstate_VecInfo, VecInfo),
> -        VMSTATE_UINT32(systick.control, NVICState),
> -        VMSTATE_UINT32(systick.reload, NVICState),
> -        VMSTATE_INT64(systick.tick, NVICState),
> -        VMSTATE_TIMER_PTR(systick.timer, NVICState),
>          VMSTATE_UINT32(prigroup, NVICState),
>          VMSTATE_END_OF_LIST()
>      }
> @@ -999,13 +880,26 @@ static void armv7m_nvic_reset(DeviceState *dev)
>
>      s->exception_prio = NVIC_NOEXC_PRIO;
>      s->vectpending = 0;
> +}
>
> -    systick_reset(s);
> +static void nvic_systick_trigger(void *opaque, int n, int level)
> +{
> +    NVICState *s = opaque;
> +
> +    if (level) {
> +        /* SysTick just asked us to pend its exception.
> +         * (This is different from an external interrupt line's
> +         * behaviour.)
> +         */
> +        armv7m_nvic_set_pending(s, ARMV7M_EXCP_SYSTICK);
> +    }
>  }
>
>  static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
>  {
>      NVICState *s = NVIC(dev);
> +    SysBusDevice *systick_sbd;
> +    Error *err = NULL;
>
>      s->cpu = ARM_CPU(qemu_get_cpu(0));
>      assert(s->cpu);
> @@ -1020,10 +914,19 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
>      /* include space for internal exception vectors */
>      s->num_irq += NVIC_FIRST_IRQ;
>
> +    object_property_set_bool(OBJECT(&s->systick), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    systick_sbd = SYS_BUS_DEVICE(&s->systick);
> +    sysbus_connect_irq(systick_sbd, 0,
> +                       qdev_get_gpio_in_named(dev, "systick-trigger", 0));
> +
>      /* The NVIC and System Control Space (SCS) starts at 0xe000e000
>       * and looks like this:
>       *  0x004 - ICTR
> -     *  0x010 - 0x1c - systick
> +     *  0x010 - 0xff - systick
>       *  0x100..0x7ec - NVIC
>       *  0x7f0..0xcff - Reserved
>       *  0xd00..0xd3c - SCS registers
> @@ -1041,10 +944,11 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
>      memory_region_init_io(&s->sysregmem, OBJECT(s), &nvic_sysreg_ops, s,
>                            "nvic_sysregs", 0x1000);
>      memory_region_add_subregion(&s->container, 0, &s->sysregmem);
> +    memory_region_add_subregion_overlap(&s->container, 0x10,
> +                                        sysbus_mmio_get_region(systick_sbd, 0),
> +                                        1);
>
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container);
> -
> -    s->systick.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, systick_timer_tick, s);
>  }
>
>  static void armv7m_nvic_instance_init(Object *obj)
> @@ -1059,8 +963,12 @@ static void armv7m_nvic_instance_init(Object *obj)
>      NVICState *nvic = NVIC(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>
> +    object_initialize(&nvic->systick, sizeof(nvic->systick), TYPE_SYSTICK);
> +    qdev_set_parent_bus(DEVICE(&nvic->systick), sysbus_get_default());
> +
>      sysbus_init_irq(sbd, &nvic->excpout);
>      qdev_init_gpio_out_named(dev, &nvic->sysresetreq, "SYSRESETREQ", 1);
> +    qdev_init_gpio_in_named(dev, nvic_systick_trigger, "systick-trigger", 1);
>  }
>
>  static void armv7m_nvic_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
> new file mode 100644
> index 0000000..3fd5e72
> --- /dev/null
> +++ b/hw/timer/armv7m_systick.c
> @@ -0,0 +1,239 @@
> +/*
> + * ARMv7M SysTick timer
> + *
> + * Copyright (c) 2006-2007 CodeSourcery.
> + * Written by Paul Brook
> + * Copyright (c) 2017 Linaro Ltd
> + * Written by Peter Maydell
> + *
> + * This code is licensed under the GPL (version 2 or later).
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/timer/armv7m_systick.h"
> +#include "qemu-common.h"
> +#include "hw/sysbus.h"
> +#include "qemu/timer.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +
> +/* qemu timers run at 1GHz.   We want something closer to 1MHz.  */
> +#define SYSTICK_SCALE 1000ULL
> +
> +#define SYSTICK_ENABLE    (1 << 0)
> +#define SYSTICK_TICKINT   (1 << 1)
> +#define SYSTICK_CLKSOURCE (1 << 2)
> +#define SYSTICK_COUNTFLAG (1 << 16)
> +
> +int system_clock_scale;
> +
> +/* Conversion factor from qemu timer to SysTick frequencies.  */
> +static inline int64_t systick_scale(SysTickState *s)
> +{
> +    if (s->control & SYSTICK_CLKSOURCE) {
> +        return system_clock_scale;
> +    } else {
> +        return 1000;

this magic seems to be SYSTICK_SCALE
(Paul Brook's commit 9ee6e8bb85)

> +    }
> +}
> +
> +static void systick_reload(SysTickState *s, int reset)
> +{
> +    /* The Cortex-M3 Devices Generic User Guide says that "When the
> +     * ENABLE bit is set to 1, the counter loads the RELOAD value from the
> +     * SYST RVR register and then counts down". So, we need to check the
> +     * ENABLE bit before reloading the value.
> +     */
> +    trace_systick_reload();
> +
> +    if ((s->control & SYSTICK_ENABLE) == 0) {
> +        return;
> +    }
> +
> +    if (reset) {
> +        s->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    }
> +    s->tick += (s->reload + 1) * systick_scale(s);
> +    timer_mod(s->timer, s->tick);
> +}
> +
> +static void systick_timer_tick(void *opaque)
> +{
> +    SysTickState *s = (SysTickState *)opaque;
> +
> +    trace_systick_timer_tick();
> +
> +    s->control |= SYSTICK_COUNTFLAG;
> +    if (s->control & SYSTICK_TICKINT) {
> +        /* Tell the NVIC to pend the SysTick exception */
> +        qemu_irq_pulse(s->irq);
> +    }
> +    if (s->reload == 0) {
> +        s->control &= ~SYSTICK_ENABLE;
> +    } else {
> +        systick_reload(s, 0);
> +    }
> +}
> +
> +static uint64_t systick_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    SysTickState *s = opaque;
> +    uint32_t val;
> +
> +    switch (addr) {
> +    case 0x0: /* SysTick Control and Status.  */
> +        val = s->control;
> +        s->control &= ~SYSTICK_COUNTFLAG;
> +        break;
> +    case 0x4: /* SysTick Reload Value.  */
> +        val = s->reload;
> +        break;
> +    case 0x8: /* SysTick Current Value.  */
> +    {
> +        int64_t t;
> +
> +        if ((s->control & SYSTICK_ENABLE) == 0) {
> +            val = 0;
> +            break;
> +        }
> +        t = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        if (t >= s->tick) {
> +            val = 0;
> +            break;
> +        }
> +        val = ((s->tick - (t + 1)) / systick_scale(s)) + 1;
> +        /* The interrupt in triggered when the timer reaches zero.
> +           However the counter is not reloaded until the next clock
> +           tick.  This is a hack to return zero during the first tick.  */
> +        if (val > s->reload) {
> +            val = 0;
> +        }
> +        break;
> +    }
> +    case 0xc: /* SysTick Calibration Value.  */
> +        val = 10000;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "SysTick: Bad read offset 0x%" HWADDR_PRIx "\n", addr);
> +        break;
> +    }
> +
> +    trace_systick_read(addr, val, size);
> +    return val;
> +}
> +
> +static void systick_write(void *opaque, hwaddr addr,
> +                          uint64_t value, unsigned size)
> +{
> +    SysTickState *s = opaque;
> +
> +    trace_systick_write(addr, value, size);
> +
> +    switch (addr) {
> +    case 0x0: /* SysTick Control and Status.  */
> +    {
> +        uint32_t oldval = s->control;
> +
> +        s->control &= 0xfffffff8;
> +        s->control |= value & 7;
> +        if ((oldval ^ value) & SYSTICK_ENABLE) {
> +            int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +            if (value & SYSTICK_ENABLE) {
> +                if (s->tick) {
> +                    s->tick += now;
> +                    timer_mod(s->timer, s->tick);
> +                } else {
> +                    systick_reload(s, 1);
> +                }
> +            } else {
> +                timer_del(s->timer);
> +                s->tick -= now;
> +                if (s->tick < 0) {
> +                    s->tick = 0;
> +                }
> +            }
> +        } else if ((oldval ^ value) & SYSTICK_CLKSOURCE) {
> +            /* This is a hack. Force the timer to be reloaded
> +               when the reference clock is changed.  */
> +            systick_reload(s, 1);
> +        }
> +        break;
> +    }
> +    case 0x4: /* SysTick Reload Value.  */
> +        s->reload = value;
> +        break;
> +    case 0x8: /* SysTick Current Value.  Writes reload the timer.  */
> +        systick_reload(s, 1);
> +        s->control &= ~SYSTICK_COUNTFLAG;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "SysTick: Bad write offset 0x%" HWADDR_PRIx "\n", addr);
> +    }
> +}
> +
> +static const MemoryRegionOps systick_ops = {
> +    .read = systick_read,
> +    .write = systick_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +};
> +
> +static void systick_reset(DeviceState *dev)
> +{
> +    SysTickState *s = SYSTICK(dev);
> +
> +    s->control = 0;
> +    s->reload = 0;
> +    s->tick = 0;
> +    timer_del(s->timer);
> +}
> +
> +static void systick_instance_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    SysTickState *s = SYSTICK(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &systick_ops, s, "systick", 0xe0);

It seems to me the correct size is 0x10. The manual describes the range 
0x20-0xFF as _reserved_. This _reserved_ description is at the end of 
the 'SysTick' chapter which seems weird to me... I rather think this 
range belong to the 'Interrupt Controller'@'System Control Space'.

> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);
> +    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, systick_timer_tick, s);
> +}
> +
> +static const VMStateDescription vmstate_systick = {
> +    .name = "armv7m_systick",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(control, SysTickState),
> +        VMSTATE_UINT32(reload, SysTickState),
> +        VMSTATE_INT64(tick, SysTickState),
> +        VMSTATE_TIMER_PTR(timer, SysTickState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void systick_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_systick;
> +    dc->reset = systick_reset;
> +}
> +
> +static const TypeInfo armv7m_systick_info = {
> +    .name = TYPE_SYSTICK,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_init = systick_instance_init,
> +    .instance_size = sizeof(SysTickState),
> +    .class_init = systick_class_init,
> +};
> +
> +static void armv7m_systick_register_types(void)
> +{
> +    type_register_static(&armv7m_systick_info);
> +}
> +
> +type_init(armv7m_systick_register_types)
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 3495c41..d17cfe6 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -49,3 +49,9 @@ aspeed_timer_ctrl_pulse_enable(uint8_t i, bool enable) "Timer %" PRIu8 ": %d"
>  aspeed_timer_set_ctrl2(uint32_t value) "Value: 0x%" PRIx32
>  aspeed_timer_set_value(int timer, int reg, uint32_t value) "Timer %d register %d: 0x%" PRIx32
>  aspeed_timer_read(uint64_t offset, unsigned size, uint64_t value) "From 0x%" PRIx64 ": of size %u: 0x%" PRIx64
> +
> +# hw/timer/armv7m_systick.c
> +systick_reload(void) "systick reload"
> +systick_timer_tick(void) "systick reload"
> +systick_read(uint64_t addr, uint32_t value, unsigned size) "systick read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
> +systick_write(uint64_t addr, uint32_t value, unsigned size) "systick write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>
