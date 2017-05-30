Received: from eggs.gnu.org ([2001:4830:134:3::10]:57660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFgV0-0006tL-VC
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFgUz-0003jf-6f
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:43:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <1494949133-2202-1-git-send-email-sundeep.lkml@gmail.com>
	<1494949133-2202-2-git-send-email-sundeep.lkml@gmail.com>
Message-ID: <791b5dbc-4a5d-71c7-cd4b-1609b164e648@amsat.org>
Date: Tue, 30 May 2017 09:43:36 -0300
MIME-Version: 1.0
In-Reply-To: <1494949133-2202-2-git-send-email-sundeep.lkml@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu devel v5 PATCH 1/5] msf2: Add Smartfusion2
 System timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, crosthwaite.peter@gmail.com, alistair23@gmail.com

Hi Subbaraya,

I have some comments, see inlined.

On 05/16/2017 12:38 PM, Subbaraya Sundeep wrote:
> Modelled System Timer in Microsemi's Smartfusion2 Soc.
> Timer has two 32bit down counters and two interrupts.
>
> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> ---
>  hw/timer/Makefile.objs       |   1 +
>  hw/timer/mss-timer.c         | 249 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/timer/mss-timer.h |  80 ++++++++++++++
>  3 files changed, 330 insertions(+)
>  create mode 100644 hw/timer/mss-timer.c
>  create mode 100644 include/hw/timer/mss-timer.h
>
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index dd6f27e..fc4d2da 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -41,3 +41,4 @@ common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
>  common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
>
>  common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
> +common-obj-$(CONFIG_MSF2) += mss-timer.o
> diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
> new file mode 100644
> index 0000000..7041965
> --- /dev/null
> +++ b/hw/timer/mss-timer.c
> @@ -0,0 +1,249 @@
> +/*
> + * Block model of System timer present in
> + * Microsemi's SmartFusion2 and SmartFusion SoCs.
> + *
> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "hw/timer/mss-timer.h"
> +
> +#ifndef MSS_TIMER_ERR_DEBUG
> +#define MSS_TIMER_ERR_DEBUG  0
> +#endif
> +
> +#define DB_PRINT_L(lvl, fmt, args...) do { \
> +    if (MSS_TIMER_ERR_DEBUG >= lvl) { \
> +        qemu_log("%s: " fmt, __func__, ## args); \
> +    } \
> +} while (0);
> +
> +#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
> +
> +static void timer_update_irq(struct Msf2Timer *st)
> +{
> +    bool isr, ier;
> +
> +    isr = !!(st->regs[R_TIM_RIS] & TIMER_RIS_ACK);
> +    ier = !!(st->regs[R_TIM_CTRL] & TIMER_CTRL_INTR);
> +
> +    qemu_set_irq(st->irq, (ier && isr));
> +}
> +
> +static void timer_update(struct Msf2Timer *st)
> +{
> +    uint64_t count;
> +
> +    if (!(st->regs[R_TIM_CTRL] & TIMER_CTRL_ENBL)) {
> +        ptimer_stop(st->ptimer);
> +        return;
> +    }
> +
> +    count = st->regs[R_TIM_LOADVAL];
> +    ptimer_set_limit(st->ptimer, count, 1);
> +    ptimer_run(st->ptimer, 1);
> +}
> +
> +static uint64_t
> +timer_read(void *opaque, hwaddr offset, unsigned int size)
> +{
> +    MSSTimerState *t = opaque;
> +    hwaddr addr;
> +    struct Msf2Timer *st;
> +    uint32_t ret = 0;
> +    int timer = 0;
> +    int isr;
> +    int ier;
> +
> +    addr = offset >> 2;
> +    /*
> +     * Two independent timers has same base address.
> +     * Based on address passed figure out which timer is being used.
> +     */
> +    if ((addr >= R_TIM1_MAX) && (addr < NUM_TIMERS * R_TIM1_MAX)) {
> +        timer = 1;
> +        addr -= R_TIM1_MAX;
> +    }
> +
> +    st = &t->timers[timer];
> +
> +    switch (addr) {
> +    case R_TIM_VAL:
> +        ret = ptimer_get_count(st->ptimer);
> +        break;
> +
> +    case R_TIM_MIS:
> +        isr = !!(st->regs[R_TIM_RIS] & TIMER_RIS_ACK);
> +        ier = !!(st->regs[R_TIM_CTRL] & TIMER_CTRL_INTR);
> +        ret = ier & isr;
> +        break;
> +
> +    default:
> +        if (addr < NUM_TIMERS * R_TIM1_MAX) {
> +            ret = st->regs[addr];
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                        TYPE_MSS_TIMER": 64-bit mode not supported\n");
> +        }
> +        break;
> +    }
> +
> +    DB_PRINT("timer=%d 0x%" HWADDR_PRIx "=0x%" PRIx32 "\n", timer, offset,
> +            ret);
> +    return ret;
> +}
> +
> +static void
> +timer_write(void *opaque, hwaddr offset,
> +            uint64_t val64, unsigned int size)
> +{
> +    MSSTimerState *t = opaque;
> +    hwaddr addr;
> +    struct Msf2Timer *st;
> +    int timer = 0;
> +    uint32_t value = val64;
> +
> +    addr = offset >> 2;
> +    /*
> +     * Two independent timers has same base address.
> +     * Based on addr passed figure out which timer is being used.
> +     */
> +    if ((addr >= R_TIM1_MAX) && (addr < NUM_TIMERS * R_TIM1_MAX)) {
> +        timer = 1;
> +        addr -= R_TIM1_MAX;
> +    }
> +
> +    st = &t->timers[timer];
> +
> +    DB_PRINT("addr=0x%" HWADDR_PRIx " val=0x%" PRIx32 " (timer=%d)\n", offset,
> +            value, timer);
> +
> +    switch (addr) {
> +    case R_TIM_CTRL:
> +        st->regs[R_TIM_CTRL] = value;
> +        timer_update(st);
> +        break;
> +
> +    case R_TIM_RIS:
> +        if (value & TIMER_RIS_ACK) {
> +            st->regs[R_TIM_RIS] &= ~TIMER_RIS_ACK;
> +        }
> +        break;
> +
> +    case R_TIM_LOADVAL:
> +        st->regs[R_TIM_LOADVAL] = value;
> +        if (st->regs[R_TIM_CTRL] & TIMER_CTRL_ENBL) {
> +            timer_update(st);
> +        }
> +        break;
> +
> +    case R_TIM_BGLOADVAL:
> +        st->regs[R_TIM_BGLOADVAL] = value;
> +        st->regs[R_TIM_LOADVAL] = value;
> +        break;
> +
> +    case R_TIM_VAL:
> +    case R_TIM_MIS:
> +        break;
> +
> +    default:
> +        if (addr < NUM_TIMERS * R_TIM1_MAX) {
> +            st->regs[addr] = value;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                        TYPE_MSS_TIMER": 64-bit mode not supported\n");
> +            return;
> +        }
> +        break;
> +    }
> +    timer_update_irq(st);
> +}
> +
> +static const MemoryRegionOps timer_ops = {
> +    .read = timer_read,
> +    .write = timer_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4
> +    }
> +};
> +
> +static void timer_hit(void *opaque)
> +{
> +    struct Msf2Timer *st = opaque;
> +
> +    st->regs[R_TIM_RIS] |= TIMER_RIS_ACK;
> +
> +    if (!(st->regs[R_TIM_CTRL] & TIMER_CTRL_ONESHOT)) {
> +        timer_update(st);
> +    }
> +    timer_update_irq(st);
> +}
> +
> +static void mss_timer_init(Object *obj)
> +{
> +    MSSTimerState *t = MSS_TIMER(obj);
> +    int i;
> +
> +    /* Init all the ptimers.  */
> +    t->timers = g_malloc0((sizeof t->timers[0]) * NUM_TIMERS);
> +    for (i = 0; i < NUM_TIMERS; i++) {
> +        struct Msf2Timer *st = &t->timers[i];
> +
> +        st->bh = qemu_bh_new(timer_hit, st);
> +        st->ptimer = ptimer_init(st->bh, PTIMER_POLICY_DEFAULT);
> +        ptimer_set_freq(st->ptimer, t->freq_hz);
> +        sysbus_init_irq(SYS_BUS_DEVICE(obj), &st->irq);
> +    }
> +
> +    memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t, TYPE_MSS_TIMER,
> +                          NUM_TIMERS * R_TIM1_MAX * 4);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &t->mmio);
> +}
> +
> +static Property mss_timer_properties[] = {
> +    /* Libero GUI shows 100Mhz as default for clocks */
> +    DEFINE_PROP_UINT32("clock-frequency", MSSTimerState, freq_hz,
> +                      100 * 1000000),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void mss_timer_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->props = mss_timer_properties;
> +}
> +
> +static const TypeInfo mss_timer_info = {
> +    .name          = TYPE_MSS_TIMER,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(MSSTimerState),
> +    .instance_init = mss_timer_init,
> +    .class_init    = mss_timer_class_init,
> +};
> +
> +static void mss_timer_register_types(void)
> +{
> +    type_register_static(&mss_timer_info);
> +}
> +
> +type_init(mss_timer_register_types)
> diff --git a/include/hw/timer/mss-timer.h b/include/hw/timer/mss-timer.h
> new file mode 100644
> index 0000000..4caacfd
> --- /dev/null
> +++ b/include/hw/timer/mss-timer.h
> @@ -0,0 +1,80 @@
> +/*
> + * Microsemi SmartFusion2 Timer.
> + *
> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_MSS_TIMER_H
> +#define HW_MSS_TIMER_H
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "hw/ptimer.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/log.h"
> +
> +#define TYPE_MSS_TIMER     "mss-timer"
> +#define MSS_TIMER(obj)     OBJECT_CHECK(MSSTimerState, \
> +                              (obj), TYPE_MSS_TIMER)
> +
> +/*
> + * There are two 32-bit down counting timers.
> + * Timers 1 and 2 can be concatenated into a single 64-bit Timer
> + * that operates either in Periodic mode or in One-shot mode.
> + * Writing 1 to the TIM64_MODE register bit 0 sets the Timers in 64-bit mode.
> + * In 64-bit mode, writing to the 32-bit registers has no effect.
> + * Similarly, in 32-bit mode, writing to the 64-bit mode registers
> + * has no effect. Only two 32-bit timers are supported currently.
> + */
> +#define NUM_TIMERS        2
> +
> +#define R_TIM_VAL         0
> +#define R_TIM_LOADVAL     1
> +#define R_TIM_BGLOADVAL   2
> +#define R_TIM_CTRL        3
> +#define R_TIM_RIS         4
> +#define R_TIM_MIS         5
> +#define R_TIM1_MAX        6
> +

 From here ...

> +#define TIMER_CTRL_ENBL     (1 << 0)
> +#define TIMER_CTRL_ONESHOT  (1 << 1)
> +#define TIMER_CTRL_INTR     (1 << 2)
> +#define TIMER_RIS_ACK       (1 << 0)
> +#define TIMER_RST_CLR       (1 << 6)
> +#define TIMER_MODE          (1 << 0)

.. to here, can go in the .c source file.

I'd also move R_TIM_* to the source, only keeping R_TIM_MAX in this 
header, or also moving it and exposing some TIMER_IO_SIZE of 0x30 instead.

> +
> +struct Msf2Timer {
> +    QEMUBH *bh;
> +    ptimer_state *ptimer;
> +
> +    uint32_t regs[NUM_TIMERS * R_TIM1_MAX];

Beware, you are declaring 2 sets of register for each timer. I think 
it'd be safer to declare these registers once in MSSTimerState, the code 
would get easier.

> +    qemu_irq irq;
> +};
> +
> +typedef struct MSSTimerState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    uint32_t freq_hz;
> +    struct Msf2Timer *timers;

The number of timers is fixed (NUM_TIMERS), so you can declare it here 
and avoid to use g_malloc0() in mss_timer_init(), this will get 
allocated before mss_timer_init() using mss_timer_info.instance_size.

This should simplify a bit.

> +} MSSTimerState;
> +
> +#endif /* HW_MSS_TIMER_H */
>
