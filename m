Received: from eggs.gnu.org ([2001:4830:134:3::10]:33848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dOk7e-0002CX-2e
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 08:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dOk7b-0003JA-AI
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 08:25:06 -0400
MIME-Version: 1.0
In-Reply-To: <791b5dbc-4a5d-71c7-cd4b-1609b164e648@amsat.org>
References: <1494949133-2202-1-git-send-email-sundeep.lkml@gmail.com>
	<1494949133-2202-2-git-send-email-sundeep.lkml@gmail.com>
	<791b5dbc-4a5d-71c7-cd4b-1609b164e648@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Sat, 24 Jun 2017 17:55:01 +0530
Message-ID: <CALHRZuqdmhxOeMvN=y46t19c+muY18cN=s4-+L2uiWWBvUh=PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

Hi Philippe,

On Tue, May 30, 2017 at 6:13 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Subbaraya,
>
> I have some comments, see inlined.
>
>
> On 05/16/2017 12:38 PM, Subbaraya Sundeep wrote:
>
>> Modelled System Timer in Microsemi's Smartfusion2 Soc.
>> Timer has two 32bit down counters and two interrupts.
>>
>> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> ---
>>  hw/timer/Makefile.objs       |   1 +
>>  hw/timer/mss-timer.c         | 249 ++++++++++++++++++++++++++++++
>> +++++++++++++
>>  include/hw/timer/mss-timer.h |  80 ++++++++++++++
>>  3 files changed, 330 insertions(+)
>>  create mode 100644 hw/timer/mss-timer.c
>>  create mode 100644 include/hw/timer/mss-timer.h
>>
>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>> index dd6f27e..fc4d2da 100644
>> --- a/hw/timer/Makefile.objs
>> +++ b/hw/timer/Makefile.objs
>> @@ -41,3 +41,4 @@ common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D
>> stm32f2xx_timer.o
>>  common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o
>>
>>  common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
>> +common-obj-$(CONFIG_MSF2) +=3D mss-timer.o
>> diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
>> new file mode 100644
>> index 0000000..7041965
>> --- /dev/null
>> +++ b/hw/timer/mss-timer.c
>> @@ -0,0 +1,249 @@
>> +/*
>> + * Block model of System timer present in
>> + * Microsemi's SmartFusion2 and SmartFusion SoCs.
>> + *
>> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g
>> a copy
>> + * of this software and associated documentation files (the "Software")=
,
>> to deal
>> + * in the Software without restriction, including without limitation th=
e
>> rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
>> sell
>> + * copies of the Software, and to permit persons to whom the Software i=
s
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>> SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "hw/timer/mss-timer.h"
>> +
>> +#ifndef MSS_TIMER_ERR_DEBUG
>> +#define MSS_TIMER_ERR_DEBUG  0
>> +#endif
>> +
>> +#define DB_PRINT_L(lvl, fmt, args...) do { \
>> +    if (MSS_TIMER_ERR_DEBUG >=3D lvl) { \
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
>> +    isr =3D !!(st->regs[R_TIM_RIS] & TIMER_RIS_ACK);
>> +    ier =3D !!(st->regs[R_TIM_CTRL] & TIMER_CTRL_INTR);
>> +
>> +    qemu_set_irq(st->irq, (ier && isr));
>> +}
>> +
>> +static void timer_update(struct Msf2Timer *st)
>> +{
>> +    uint64_t count;
>> +
>> +    if (!(st->regs[R_TIM_CTRL] & TIMER_CTRL_ENBL)) {
>> +        ptimer_stop(st->ptimer);
>> +        return;
>> +    }
>> +
>> +    count =3D st->regs[R_TIM_LOADVAL];
>> +    ptimer_set_limit(st->ptimer, count, 1);
>> +    ptimer_run(st->ptimer, 1);
>> +}
>> +
>> +static uint64_t
>> +timer_read(void *opaque, hwaddr offset, unsigned int size)
>> +{
>> +    MSSTimerState *t =3D opaque;
>> +    hwaddr addr;
>> +    struct Msf2Timer *st;
>> +    uint32_t ret =3D 0;
>> +    int timer =3D 0;
>> +    int isr;
>> +    int ier;
>> +
>> +    addr =3D offset >> 2;
>> +    /*
>> +     * Two independent timers has same base address.
>> +     * Based on address passed figure out which timer is being used.
>> +     */
>> +    if ((addr >=3D R_TIM1_MAX) && (addr < NUM_TIMERS * R_TIM1_MAX)) {
>> +        timer =3D 1;
>> +        addr -=3D R_TIM1_MAX;
>> +    }
>> +
>> +    st =3D &t->timers[timer];
>> +
>> +    switch (addr) {
>> +    case R_TIM_VAL:
>> +        ret =3D ptimer_get_count(st->ptimer);
>> +        break;
>> +
>> +    case R_TIM_MIS:
>> +        isr =3D !!(st->regs[R_TIM_RIS] & TIMER_RIS_ACK);
>> +        ier =3D !!(st->regs[R_TIM_CTRL] & TIMER_CTRL_INTR);
>> +        ret =3D ier & isr;
>> +        break;
>> +
>> +    default:
>> +        if (addr < NUM_TIMERS * R_TIM1_MAX) {
>> +            ret =3D st->regs[addr];
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                        TYPE_MSS_TIMER": 64-bit mode not supported\n");
>> +        }
>> +        break;
>> +    }
>> +
>> +    DB_PRINT("timer=3D%d 0x%" HWADDR_PRIx "=3D0x%" PRIx32 "\n", timer,
>> offset,
>> +            ret);
>> +    return ret;
>> +}
>> +
>> +static void
>> +timer_write(void *opaque, hwaddr offset,
>> +            uint64_t val64, unsigned int size)
>> +{
>> +    MSSTimerState *t =3D opaque;
>> +    hwaddr addr;
>> +    struct Msf2Timer *st;
>> +    int timer =3D 0;
>> +    uint32_t value =3D val64;
>> +
>> +    addr =3D offset >> 2;
>> +    /*
>> +     * Two independent timers has same base address.
>> +     * Based on addr passed figure out which timer is being used.
>> +     */
>> +    if ((addr >=3D R_TIM1_MAX) && (addr < NUM_TIMERS * R_TIM1_MAX)) {
>> +        timer =3D 1;
>> +        addr -=3D R_TIM1_MAX;
>> +    }
>> +
>> +    st =3D &t->timers[timer];
>> +
>> +    DB_PRINT("addr=3D0x%" HWADDR_PRIx " val=3D0x%" PRIx32 " (timer=3D%d=
)\n",
>> offset,
>> +            value, timer);
>> +
>> +    switch (addr) {
>> +    case R_TIM_CTRL:
>> +        st->regs[R_TIM_CTRL] =3D value;
>> +        timer_update(st);
>> +        break;
>> +
>> +    case R_TIM_RIS:
>> +        if (value & TIMER_RIS_ACK) {
>> +            st->regs[R_TIM_RIS] &=3D ~TIMER_RIS_ACK;
>> +        }
>> +        break;
>> +
>> +    case R_TIM_LOADVAL:
>> +        st->regs[R_TIM_LOADVAL] =3D value;
>> +        if (st->regs[R_TIM_CTRL] & TIMER_CTRL_ENBL) {
>> +            timer_update(st);
>> +        }
>> +        break;
>> +
>> +    case R_TIM_BGLOADVAL:
>> +        st->regs[R_TIM_BGLOADVAL] =3D value;
>> +        st->regs[R_TIM_LOADVAL] =3D value;
>> +        break;
>> +
>> +    case R_TIM_VAL:
>> +    case R_TIM_MIS:
>> +        break;
>> +
>> +    default:
>> +        if (addr < NUM_TIMERS * R_TIM1_MAX) {
>> +            st->regs[addr] =3D value;
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                        TYPE_MSS_TIMER": 64-bit mode not supported\n");
>> +            return;
>> +        }
>> +        break;
>> +    }
>> +    timer_update_irq(st);
>> +}
>> +
>> +static const MemoryRegionOps timer_ops =3D {
>> +    .read =3D timer_read,
>> +    .write =3D timer_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 1,
>> +        .max_access_size =3D 4
>> +    }
>> +};
>> +
>> +static void timer_hit(void *opaque)
>> +{
>> +    struct Msf2Timer *st =3D opaque;
>> +
>> +    st->regs[R_TIM_RIS] |=3D TIMER_RIS_ACK;
>> +
>> +    if (!(st->regs[R_TIM_CTRL] & TIMER_CTRL_ONESHOT)) {
>> +        timer_update(st);
>> +    }
>> +    timer_update_irq(st);
>> +}
>> +
>> +static void mss_timer_init(Object *obj)
>> +{
>> +    MSSTimerState *t =3D MSS_TIMER(obj);
>> +    int i;
>> +
>> +    /* Init all the ptimers.  */
>> +    t->timers =3D g_malloc0((sizeof t->timers[0]) * NUM_TIMERS);
>> +    for (i =3D 0; i < NUM_TIMERS; i++) {
>> +        struct Msf2Timer *st =3D &t->timers[i];
>> +
>> +        st->bh =3D qemu_bh_new(timer_hit, st);
>> +        st->ptimer =3D ptimer_init(st->bh, PTIMER_POLICY_DEFAULT);
>> +        ptimer_set_freq(st->ptimer, t->freq_hz);
>> +        sysbus_init_irq(SYS_BUS_DEVICE(obj), &st->irq);
>> +    }
>> +
>> +    memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t,
>> TYPE_MSS_TIMER,
>> +                          NUM_TIMERS * R_TIM1_MAX * 4);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &t->mmio);
>> +}
>> +
>> +static Property mss_timer_properties[] =3D {
>> +    /* Libero GUI shows 100Mhz as default for clocks */
>> +    DEFINE_PROP_UINT32("clock-frequency", MSSTimerState, freq_hz,
>> +                      100 * 1000000),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void mss_timer_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->props =3D mss_timer_properties;
>> +}
>> +
>> +static const TypeInfo mss_timer_info =3D {
>> +    .name          =3D TYPE_MSS_TIMER,
>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(MSSTimerState),
>> +    .instance_init =3D mss_timer_init,
>> +    .class_init    =3D mss_timer_class_init,
>> +};
>> +
>> +static void mss_timer_register_types(void)
>> +{
>> +    type_register_static(&mss_timer_info);
>> +}
>> +
>> +type_init(mss_timer_register_types)
>> diff --git a/include/hw/timer/mss-timer.h b/include/hw/timer/mss-timer.h
>> new file mode 100644
>> index 0000000..4caacfd
>> --- /dev/null
>> +++ b/include/hw/timer/mss-timer.h
>> @@ -0,0 +1,80 @@
>> +/*
>> + * Microsemi SmartFusion2 Timer.
>> + *
>> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g
>> a copy
>> + * of this software and associated documentation files (the "Software")=
,
>> to deal
>> + * in the Software without restriction, including without limitation th=
e
>> rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
>> sell
>> + * copies of the Software, and to permit persons to whom the Software i=
s
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>> SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#ifndef HW_MSS_TIMER_H
>> +#define HW_MSS_TIMER_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/ptimer.h"
>> +#include "sysemu/sysemu.h"
>> +#include "qemu/log.h"
>> +
>> +#define TYPE_MSS_TIMER     "mss-timer"
>> +#define MSS_TIMER(obj)     OBJECT_CHECK(MSSTimerState, \
>> +                              (obj), TYPE_MSS_TIMER)
>> +
>> +/*
>> + * There are two 32-bit down counting timers.
>> + * Timers 1 and 2 can be concatenated into a single 64-bit Timer
>> + * that operates either in Periodic mode or in One-shot mode.
>> + * Writing 1 to the TIM64_MODE register bit 0 sets the Timers in 64-bit
>> mode.
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
>>
>
> From here ...
>
> +#define TIMER_CTRL_ENBL     (1 << 0)
>> +#define TIMER_CTRL_ONESHOT  (1 << 1)
>> +#define TIMER_CTRL_INTR     (1 << 2)
>> +#define TIMER_RIS_ACK       (1 << 0)
>> +#define TIMER_RST_CLR       (1 << 6)
>> +#define TIMER_MODE          (1 << 0)
>>
>
> .. to here, can go in the .c source file.
>
> I'd also move R_TIM_* to the source, only keeping R_TIM_MAX in this
> header, or also moving it and exposing some TIMER_IO_SIZE of 0x30 instead=
.
>

Ok will move to .c source file.

>
> +
>> +struct Msf2Timer {
>> +    QEMUBH *bh;
>> +    ptimer_state *ptimer;
>> +
>> +    uint32_t regs[NUM_TIMERS * R_TIM1_MAX];
>>
>
> Beware, you are declaring 2 sets of register for each timer. I think it'd
> be safer to declare these registers once in MSSTimerState, the code would
> get easier.
>

Thanks for catching this. I will use regs[R_TIM1_MAX] so that Msf2Timer
represents
one timer block.

>
> +    qemu_irq irq;
>> +};
>> +
>> +typedef struct MSSTimerState {
>> +    SysBusDevice parent_obj;
>> +
>> +    MemoryRegion mmio;
>> +    uint32_t freq_hz;
>> +    struct Msf2Timer *timers;
>>
>
> The number of timers is fixed (NUM_TIMERS), so you can declare it here an=
d
> avoid to use g_malloc0() in mss_timer_init(), this will get allocated
> before mss_timer_init() using mss_timer_info.instance_size.
>
> This should simplify a bit.


Yes will remove g_malloc and declare here in MSSTimerState.

Thanks,
Sundeep

>
>
> +} MSSTimerState;
>> +
>> +#endif /* HW_MSS_TIMER_H */
>>
>>
