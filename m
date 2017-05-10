Received: from eggs.gnu.org ([2001:4830:134:3::10]:56095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d8Qrw-0004W9-4x
	for qemu-devel@nongnu.org; Wed, 10 May 2017 08:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d8Qrs-0008TP-Ut
	for qemu-devel@nongnu.org; Wed, 10 May 2017 08:37:28 -0400
MIME-Version: 1.0
In-Reply-To: <e87597ba-4759-76a5-7b0d-3297d2eb8f79@amsat.org>
References: <1494348286-10253-1-git-send-email-sundeep.lkml@gmail.com>
	<1494348286-10253-2-git-send-email-sundeep.lkml@gmail.com>
	<e87597ba-4759-76a5-7b0d-3297d2eb8f79@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Wed, 10 May 2017 18:07:23 +0530
Message-ID: <CALHRZuqfqjEWszkvVQSWAKR5zVbhD36=+Qt_DsVykk41cihO1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [Qemu-devel PATCH 1/5] msf2: Add
 Smartfusion2 System timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair23@gmail.com>

Hi Phil,

On Wed, May 10, 2017 at 3:11 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:
> Hi Subbaraya, nice work!
>
> The timer you are modeling is the mss_timer, which is in particular used
in
> the smartfusion2, I'd rather name it mss_timer.c so it can be reused by
> other SoC models.
>
Ok I will change all other file names also to mss. Do I need to change type
names
also to mss?

> I added few comments.
>
>
> On 05/09/2017 01:44 PM, Subbaraya Sundeep wrote:
>>
>> Modelled System Timer in Microsemi's Smartfusion2 Soc.
>> Timer has two 32bit down counters and two interrupts.
>>
>> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> ---
>>  hw/timer/Makefile.objs        |   1 +
>>  hw/timer/msf2-timer.c         | 252
>> ++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/timer/msf2-timer.h |  85 ++++++++++++++
>>  3 files changed, 338 insertions(+)
>>  create mode 100644 hw/timer/msf2-timer.c
>>  create mode 100644 include/hw/timer/msf2-timer.h
>>
>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>> index dd6f27e..bd1ff15 100644
>> --- a/hw/timer/Makefile.objs
>> +++ b/hw/timer/Makefile.objs
>> @@ -41,3 +41,4 @@ common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D
>> stm32f2xx_timer.o
>>  common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o
>>
>>  common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
>> +common-obj-$(CONFIG_MSF2) +=3D msf2-timer.o
>> diff --git a/hw/timer/msf2-timer.c b/hw/timer/msf2-timer.c
>> new file mode 100644
>> index 0000000..466faa6
>> --- /dev/null
>> +++ b/hw/timer/msf2-timer.c
>> @@ -0,0 +1,252 @@
>> +/*
>> + * Timer block model of Microsemi SmartFusion2.
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
DEALINGS
>> IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "hw/timer/msf2-timer.h"
>> +
>> +#ifndef MSF2_TIMER_ERR_DEBUG
>> +#define MSF2_TIMER_ERR_DEBUG  0
>> +#endif
>> +
>> +#define DB_PRINT_L(lvl, fmt, args...) do { \
>> +    if (MSF2_TIMER_ERR_DEBUG >=3D lvl) { \
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
>> +timer_read(void *opaque, hwaddr addr, unsigned int size)
>> +{
>> +    MSF2TimerState *t =3D opaque;
>> +    struct Msf2Timer *st;
>> +    uint32_t ret =3D 0;
>> +    int timer =3D 0;
>> +    int isr;
>> +    int ier;
>> +
>> +    addr >>=3D 2;
>> +    /*
>> +     * Two independent timers has same base address.
>> +     * Based on addr passed figure out which timer is being used.
>> +     */
>> +    if (addr >=3D R_TIM1_MAX) {
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
>> +        if (addr < ARRAY_SIZE(st->regs)) {
>> +            ret =3D st->regs[addr];
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                         "%s: Bad offset 0x%" HWADDR_PRIx "\n",
__func__,
>> +                         addr * 4);
>> +        }
>> +        break;
>> +    }
>> +
>> +    DB_PRINT("timer=3D%d 0x%" HWADDR_PRIx "=3D0x%" PRIx32 "\n", timer, =
addr
*
>> 4,
>> +            ret);
>> +    return ret;
>> +}
>> +
>> +static void
>> +timer_write(void *opaque, hwaddr addr,
>> +            uint64_t val64, unsigned int size)
>> +{
>> +    MSF2TimerState *t =3D opaque;
>> +    struct Msf2Timer *st;
>> +    int timer =3D 0;
>> +    uint32_t value =3D val64;
>> +
>> +    addr >>=3D 2;
>> +    /*
>> +     * Two independent timers has same base address.
>> +     * Based on addr passed figure out which timer is being used.
>> +     */
>> +    if (addr >=3D R_TIM1_MAX) {
>> +        timer =3D 1;
>> +        addr -=3D R_TIM1_MAX;
>
>
> This is only valid if addr < (NUM_TIMERS * R_TIM1_MAX).
>
>
Yes you are right. My intention was to treat any address greater than
R_TIM1_MAX as timer 2 and below default case in switch would take care of
addresses which are greater than 2 *  R_TIM1_MAX. As you mentioned there
is problem with 12..20. If guest sends more than 20 say 24 then 24 - 6 =3D =
18
which will be treated as valid but it is not. Thanks for pointing it.

>> +    }
>> +
>> +    st =3D &t->timers[timer];
>> +
>> +    DB_PRINT("addr=3D0x%" HWADDR_PRIx " val=3D0x%" PRIx32 " (timer=3D%d=
)\n",
>> addr * 4,
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
>> +    case R_TIM_MODE:
>
>
> This case is never reached, if the guest wanted to access register 21,
since
> 21 >=3D R_TIM1_MAX you have now addr =3D 21 - R_TIM1_MAX =3D 15.
>
Yes. I overlooked it. Will change it.

>> +        if (value & TIMER_MODE) {
>> +            qemu_log_mask(LOG_UNIMP, "64-bit mode not supported\n");
>
>
> No need of trailing '\n', be more specific, something like:
>
>     qemu_log_mask(LOG_UNIMP, TYPE_MSF2_TIMER ": 64-bit mode not
supported");
>
Ok. Will change it.
>> +        }
>> +        break;
>> +
>> +    default:
>
>
> Once the issue "addr -=3D R_TIM1_MAX" is fixed, this default will catch
> registers 12 .. 20 silently while there are unimplemented!
> I'd rather catch them altogether and log some "64-bit mode not supported"=
.
>
Ok. I will change it.

>> +        if (addr < ARRAY_SIZE(st->regs)) {
>> +            st->regs[addr] =3D value;
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                         "%s: Bad offset 0x%" HWADDR_PRIx "\n",
__func__,
>> +                         addr * 4);
>> +        }
>> +        break;
>> +    }
>> +    timer_update_irq(st);
>
>
> Here if addr >=3D (NUM_TIMERS * R_TIM1_MAX) you still update Timer1 IRQ,
while
> this is unharmful right now this is likely to be break later.
>
As long as Interrupt status register and Interrupt enable register are not
modified calling timer_update_irq will not harm. Am I missing something
here?
>> +}
>> +
>> +static const MemoryRegionOps timer_ops =3D {
>> +    .read =3D timer_read,
>> +    .write =3D timer_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 4,
>
>
> I believe min_access_size =3D 1 is valid for any APB device.
>
>
Ok. I followed Xilinx soft IP models while writing this. I am really not
sure it is mandatory to put access_size. Can i remove it?

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
>> +static void msf2_timer_init(Object *obj)
>> +{
>> +    MSF2TimerState *t =3D MSF2_TIMER(obj);
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
>> TYPE_MSF2_TIMER,
>> +                          R_TIM_MAX * 4);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &t->mmio);
>> +}
>> +
>> +static Property msf2_timer_properties[] =3D {
>> +    DEFINE_PROP_UINT32("clock-frequency", MSF2TimerState, freq_hz,
>> +                       MSF2_TIMER_FREQ),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void msf2_timer_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->props =3D msf2_timer_properties;
>> +}
>> +
>> +static const TypeInfo msf2_timer_info =3D {
>> +    .name          =3D TYPE_MSF2_TIMER,
>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(MSF2TimerState),
>> +    .instance_init =3D msf2_timer_init,
>> +    .class_init    =3D msf2_timer_class_init,
>> +};
>> +
>> +static void msf2_timer_register_types(void)
>> +{
>> +    type_register_static(&msf2_timer_info);
>> +}
>> +
>> +type_init(msf2_timer_register_types)
>> diff --git a/include/hw/timer/msf2-timer.h
b/include/hw/timer/msf2-timer.h
>> new file mode 100644
>> index 0000000..10eb2f8
>> --- /dev/null
>> +++ b/include/hw/timer/msf2-timer.h
>> @@ -0,0 +1,85 @@
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
DEALINGS
>> IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#ifndef HW_MSF2_TIMER_H
>> +#define HW_MSF2_TIMER_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/ptimer.h"
>> +#include "sysemu/sysemu.h"
>> +#include "qemu/log.h"
>> +
>> +#define TYPE_MSF2_TIMER     "msf2-timer"
>> +#define MSF2_TIMER(obj)     OBJECT_CHECK(MSF2TimerState, \
>> +                              (obj), TYPE_MSF2_TIMER)
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
>> +#define MSF2_TIMER_FREQ   (83 * 1000000)
>
>
> I can not find this value, can you point me to the datasheet? It seems So=
C
> specific to me.
>
It is configured in Microsemi Libero. The SOM kit from Emcraft comes with
this default setting.
I guess this property should be set and passed from board file and not from
SoC.
Am I correct?
Can I attach the datasheet to this thread?

Thank you,
Sundeep
>
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
>
>
> Regards,
>
> Phil.
