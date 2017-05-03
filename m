Received: from eggs.gnu.org ([2001:4830:134:3::10]:40422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d5ma2-0001vT-SU
	for qemu-devel@nongnu.org; Wed, 03 May 2017 01:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d5ma0-0003wD-Qm
	for qemu-devel@nongnu.org; Wed, 03 May 2017 01:12:02 -0400
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNMHdsf1rra0eJK_XTb_i5F6EA677WGFqsMfWMK6385NA@mail.gmail.com>
References: <1493398313-6673-1-git-send-email-sundeep.lkml@gmail.com>
	<1493398313-6673-2-git-send-email-sundeep.lkml@gmail.com>
	<CAKmqyKNMHdsf1rra0eJK_XTb_i5F6EA677WGFqsMfWMK6385NA@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Wed, 3 May 2017 10:41:59 +0530
Message-ID: <CALHRZupcBZ5ArNKW86z=7O4NakRt_LZki6HrdDdS2O6qQ7SbpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-devel RFC v3 1/5] msf2: Add Smartfusion2
 System timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Hi Alistair,

On Wed, May 3, 2017 at 3:25 AM, Alistair Francis <alistair23@gmail.com> wrote:
> On Fri, Apr 28, 2017 at 9:51 AM, Subbaraya Sundeep
> <sundeep.lkml@gmail.com> wrote:
>> Modelled System Timer in Microsemi's Smartfusion2 Soc.
>> Timer has two 32bit down counters and two interrupts.
>>
>> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> ---
>>  hw/timer/Makefile.objs        |   1 +
>>  hw/timer/msf2_timer.c         | 250 ++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/timer/msf2_timer.h |  82 ++++++++++++++
>>  3 files changed, 333 insertions(+)
>>  create mode 100644 hw/timer/msf2_timer.c
>>  create mode 100644 include/hw/timer/msf2_timer.h
>>
>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>> index dd6f27e..0bdf1e1 100644
>> --- a/hw/timer/Makefile.objs
>> +++ b/hw/timer/Makefile.objs
>> @@ -41,3 +41,4 @@ common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
>>  common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
>>
>>  common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
>> +common-obj-$(CONFIG_MSF2) += msf2_timer.o
>> diff --git a/hw/timer/msf2_timer.c b/hw/timer/msf2_timer.c
>> new file mode 100644
>> index 0000000..d1dbde5
>> --- /dev/null
>> +++ b/hw/timer/msf2_timer.c
>
> Hey Sundeep,
>
> File names should use '-' instead of '_'.

Ok will change.
>
>> @@ -0,0 +1,250 @@
>> +/*
>> + * Timer block model of Microsemi SmartFusion2.
>> + *
>> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> + * of this software and associated documentation files (the "Software"), to deal
>> + * in the Software without restriction, including without limitation the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/timer/msf2_timer.h"
>> +#include "hw/sysbus.h"
>> +#include "qemu/log.h"
>> +#include "qemu/main-loop.h"
>
> Do you need to include the main-loop.h? This doesn't look right.
>
Ok I will remove it.

>> +
>> +#ifndef MSF2_TIMER_ERR_DEBUG
>> +#define MSF2_TIMER_ERR_DEBUG  0
>> +#endif
>> +
>> +#define DB_PRINT_L(lvl, fmt, args...) do { \
>> +    if (MSF2_TIMER_ERR_DEBUG >= lvl) { \
>> +        qemu_log("%s: " fmt, __func__, ## args); \
>> +    } \
>> +} while (0);
>> +
>> +#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
>> +
>> +static void timer_update_irq(struct Msf2Timer *st)
>> +{
>> +    bool isr, ier;
>> +
>> +    isr = !!(st->regs[R_TIM_RIS] & TIMER_RIS_ACK);
>> +    ier = !!(st->regs[R_TIM_CTRL] & TIMER_CTRL_INTR);
>> +
>> +    qemu_set_irq(st->irq, (ier && isr));
>> +}
>> +
>> +static void timer_update(struct Msf2Timer *st)
>> +{
>> +    uint64_t count;
>> +
>> +    DB_PRINT("timer=%d\n", st->nr);
>
> Maybe make this a little more explict. Something like "Updating timer: %d"?
>
Yeah will change that.
>> +
>> +    if (!(st->regs[R_TIM_CTRL] & TIMER_CTRL_ENBL)) {
>> +        ptimer_stop(st->ptimer);
>> +        return;
>> +    }
>> +
>> +    count = st->regs[R_TIM_LOADVAL];
>> +    ptimer_set_limit(st->ptimer, count, 1);
>> +    ptimer_run(st->ptimer, 1);
>> +}
>> +
>> +static uint64_t
>> +timer_read(void *opaque, hwaddr addr, unsigned int size)
>> +{
>> +    MSF2TimerState *t = opaque;
>> +    struct Msf2Timer *st;
>> +    uint32_t r = 0;
>
> Call the ret instead of r and it should be a uint64_t.
>
I will change to ret. I guess uint32_t is fine because same is used
for returning values in 32 bit registers.

>> +    unsigned int timer = 0;
>
> Isn't the timer normally an int? Try to use the same type throughout the code.
>
Ok will use int.

>> +    int isr;
>> +    int ier;
>> +
>> +    addr >>= 2;
>> +    /*
>> +     * Two independent timers has same base address.
>> +     * Based on addr passed figure out which timer is being used.
>> +     */
>> +    if (addr >= R_TIM1_MAX) {
>> +        timer = 1;
>> +        addr -= R_TIM1_MAX;
>> +    }
>> +
>> +    st = &t->timers[timer];
>> +
>> +    switch (addr) {
>> +    case R_TIM_VAL:
>> +        r = ptimer_get_count(st->ptimer);
>> +        DB_PRINT("msf2_timer t=%d read counter=%x\n", timer, r);
>
> Put a 0x in front of hex values.
>
Ok
> Also %x isn't the correct type for uint64_t, it's something similar to PRIx.
>
Yeah build test reported these errors. I will fix them.

>> +        break;
>> +
>> +    case R_TIM_MIS:
>> +        isr = !!(st->regs[R_TIM_RIS] & TIMER_RIS_ACK);
>> +        ier = !!(st->regs[R_TIM_CTRL] & TIMER_CTRL_INTR);
>> +        r = ier && isr;
>
> This should be a bitwise AND.
>
Ok
>> +        break;
>> +
>> +    default:
>> +        if (addr < ARRAY_SIZE(st->regs)) {
>> +            r = st->regs[addr];
>> +        }
>
> If the write is outside the array you should print a guest error.
>
Ok
>> +        break;
>> +    }
>> +    DB_PRINT("timer=%d %lu=%x\n", timer, addr * 4, r);
>> +    return r;
>> +}
>> +
>> +static void
>> +timer_write(void *opaque, hwaddr addr,
>> +            uint64_t val64, unsigned int size)
>> +{
>> +    MSF2TimerState *t = opaque;
>> +    struct Msf2Timer *st;
>> +    unsigned int timer = 0;
>> +    uint32_t value = val64;
>> +
>> +    addr >>= 2;
>> +    /*
>> +     * Two independent timers has same base address.
>> +     * Based on addr passed figure out which timer is being used.
>> +     */
>> +    if (addr >= R_TIM1_MAX) {
>> +        timer = 1;
>> +        addr -= R_TIM1_MAX;
>> +    }
>> +
>> +    st = &t->timers[timer];
>> +
>> +    DB_PRINT("addr=%lu val=%x (timer=%d)\n", addr * 4, value, timer);
>> +
>> +    switch (addr) {
>> +    case R_TIM_CTRL:
>> +        st->regs[R_TIM_CTRL] = value;
>> +        timer_update(st);
>> +        break;
>> +
>> +    case R_TIM_RIS:
>> +        if (value & TIMER_RIS_ACK) {
>> +            st->regs[R_TIM_RIS] &= ~TIMER_RIS_ACK;
>> +        }
>> +        break;
>> +
>> +    case R_TIM_LOADVAL:
>> +        st->regs[R_TIM_LOADVAL] = value;
>> +        if (st->regs[R_TIM_CTRL] & TIMER_CTRL_ENBL) {
>> +            timer_update(st);
>> +        }
>> +        break;
>> +
>> +    case R_TIM_BGLOADVAL:
>> +        st->regs[R_TIM_BGLOADVAL] = value;
>> +        st->regs[R_TIM_LOADVAL] = value;
>> +        break;
>> +
>> +    case R_TIM_VAL:
>> +    case R_TIM_MIS:
>> +        break;
>> +
>> +    case R_TIM_MODE:
>> +        if (value & TIMER_MODE) {
>> +            DB_PRINT("64-bit mode not supported\n");
>
> There is an unimp mask for qemu_log() which you should use here.
>
I see. I will change it.
>> +        }
>> +        break;
>> +
>> +    default:
>> +        if (addr < ARRAY_SIZE(st->regs)) {
>> +            st->regs[addr] = value;
>> +        }
>> +        break;
>> +    }
>> +    timer_update_irq(st);
>> +}
>> +
>> +static const MemoryRegionOps timer_ops = {
>> +    .read = timer_read,
>> +    .write = timer_write,
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4
>> +    }
>> +};
>> +
>> +static void timer_hit(void *opaque)
>> +{
>> +    struct Msf2Timer *st = opaque;
>> +
>> +    DB_PRINT("%d\n", st->nr);
>
> Maybe make this clearer.
>
Ok
>> +    st->regs[R_TIM_RIS] |= TIMER_RIS_ACK;
>> +
>> +    if (!(st->regs[R_TIM_CTRL] & TIMER_CTRL_ONESHOT)) {
>> +        timer_update(st);
>> +    }
>> +    timer_update_irq(st);
>> +}
>> +
>> +static void msf2_timer_init(Object *obj)
>> +{
>> +    MSF2TimerState *t = MSF2_TIMER(obj);
>> +    unsigned int i;
>
> int i;
>
Ok
>> +
>> +    /* Init all the ptimers.  */
>> +    t->timers = g_malloc0((sizeof t->timers[0]) * NUM_TIMERS);
>> +    for (i = 0; i < NUM_TIMERS; i++) {
>> +        struct Msf2Timer *st = &t->timers[i];
>> +
>> +        st->nr = i;
>> +        st->bh = qemu_bh_new(timer_hit, st);
>> +        st->ptimer = ptimer_init(st->bh, PTIMER_POLICY_DEFAULT);
>> +        ptimer_set_freq(st->ptimer, t->freq_hz);
>> +        sysbus_init_irq(SYS_BUS_DEVICE(obj), &st->irq);
>> +    }
>> +
>> +    memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t, TYPE_MSF2_TIMER,
>> +                          R_TIM_MAX * 4);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &t->mmio);
>> +}
>> +
>> +static Property msf2_timer_properties[] = {
>> +    DEFINE_PROP_UINT32("clock-frequency", MSF2TimerState, freq_hz,
>> +                       83 * 1000000),
>
> This value should be a macro.
>
Yes will add in header file.

>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void msf2_timer_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->props = msf2_timer_properties;
>> +}
>> +
>> +static const TypeInfo msf2_timer_info = {
>> +    .name          = TYPE_MSF2_TIMER,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(MSF2TimerState),
>> +    .instance_init = msf2_timer_init,
>> +    .class_init    = msf2_timer_class_init,
>> +};
>> +
>> +static void msf2_timer_register_types(void)
>> +{
>> +    type_register_static(&msf2_timer_info);
>> +}
>> +
>> +type_init(msf2_timer_register_types)
>> diff --git a/include/hw/timer/msf2_timer.h b/include/hw/timer/msf2_timer.h
>> new file mode 100644
>> index 0000000..93d9fb3
>> --- /dev/null
>> +++ b/include/hw/timer/msf2_timer.h
>> @@ -0,0 +1,82 @@
>> +/*
>> + * Microsemi SmartFusion2 Timer.
>> + *
>> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> + * of this software and associated documentation files (the "Software"), to deal
>> + * in the Software without restriction, including without limitation the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#ifndef HW_MSF2_TIMER_H
>> +#define HW_MSF2_TIMER_H
>> +
>> +#include "hw/sysbus.h"
>> +#include "hw/ptimer.h"
>> +#include "sysemu/sysemu.h"
>
> I think osdep should be included in header files as well.
>
Ok will add.
>> +
>> +#define TYPE_MSF2_TIMER     "msf2-timer"
>> +#define MSF2_TIMER(obj)     OBJECT_CHECK(MSF2TimerState, \
>> +                              (obj), TYPE_MSF2_TIMER)
>> +
>> +/*
>> + * There are two 32-bit down counting timers.
>> + * Timers 1 and 2 can be concatenated into a single 64-bit Timer
>> + * that operates either in Periodic mode or in One-shot mode.
>> + * Writing 1 to the TIM64_MODE register bit 0 sets the Timers in 64-bit mode.
>> + * In 64-bit mode, writing to the 32-bit registers has no effect.
>> + * Similarly, in 32-bit mode, writing to the 64-bit mode registers
>> + * has no effect. Only two 32-bit timers are supported currently.
>> + */
>> +#define NUM_TIMERS        2
>> +
>> +#define R_TIM_VAL         0
>> +#define R_TIM_LOADVAL     1
>> +#define R_TIM_BGLOADVAL   2
>> +#define R_TIM_CTRL        3
>> +#define R_TIM_RIS         4
>> +#define R_TIM_MIS         5
>> +#define R_TIM1_MAX        6
>> +
>> +#define R_TIM_MODE       21
>> +#define R_TIM_MAX        22 /* including 64-bit timer registers */
>> +
>> +#define TIMER_CTRL_ENBL     (1 << 0)
>> +#define TIMER_CTRL_ONESHOT  (1 << 1)
>> +#define TIMER_CTRL_INTR     (1 << 2)
>> +#define TIMER_RIS_ACK       (1 << 0)
>> +#define TIMER_RST_CLR       (1 << 6)
>> +#define TIMER_MODE          (1 << 0)
>> +
>> +struct Msf2Timer {
>> +    QEMUBH *bh;
>> +    ptimer_state *ptimer;
>> +    int nr; /* for debug. */
>
> What is this used for?
>
Just for debugging which timer is being handled.
Also can you please answer my query on SPI controller model patch.


Thanks,
Sundeep

> Thanks,
>
> Alistair
>
>> +
>> +    uint32_t regs[R_TIM_MAX];
>> +    qemu_irq irq;
>> +};
>> +
>> +typedef struct MSF2TimerState {
>> +    SysBusDevice parent_obj;
>> +
>> +    MemoryRegion mmio;
>> +    uint32_t freq_hz;
>> +    struct Msf2Timer *timers;
>> +} MSF2TimerState;
>> +
>> +#endif /* HW_MSF2_TIMER_H */
>> --
>> 2.5.0
>>
