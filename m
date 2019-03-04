Received: from eggs.gnu.org ([209.51.188.92]:37133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1h0tFL-00086y-Tv
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1h0tF9-0006hY-6i
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:27:24 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9UzFdyAFkAuWzcV5x1JDBCTVr=okdLN-MpiduvACt4tw@mail.gmail.com>
References: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
	<CAFEAcA9UzFdyAFkAuWzcV5x1JDBCTVr=okdLN-MpiduvACt4tw@mail.gmail.com>
From: bzt <bztemail@gmail.com>
Date: Mon, 4 Mar 2019 20:27:09 +0100
Message-ID: <CADYoBw3yj9yuxUSFuwCqKbTZNFFDF7Je4Kgxt-Rvd71x3JusQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Added periodic IRQ support for
 bcm2836_control local timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi,

Thanks for the review! Most of it makes sense, and I'll modify the
patch accordingly. There are few things though, mostly related to
emulating this unique timer.

On 3/4/19, Peter Maydell <peter.maydell@linaro.org> wrote:
> OK, here are my substantive review comments.
>
>> diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
>> index cfa5bc7365..fbd31de0f1 100644
>> --- a/hw/intc/bcm2836_control.c
>> +++ b/hw/intc/bcm2836_control.c
>> @@ -7,7 +7,11 @@
>>   * This code is licensed under the GNU GPLv2 and later.
>>   *
>>   * At present, only implements interrupt routing, and mailboxes (i.e.,
>> - * not local timer, PMU interrupt, or AXI counters).
>> + * not PMU interrupt, or AXI counters).
>> + *
>> + * 64-bit ARM Local Timer Copyright (c) 2019. Zolt=C3=A1n Baldaszti
>> + * The IRQ_TIMER support is still very basic, does not handle timer
>> access,
>> + * and such there's no point in enabling it without the interrupt flag
>> set.
>
> Can you be more precise about what's missing here? I didn't

The local timer (as per the referenced QA7 doc calls it, section
4.11), means 3 registers in the ARM Control MMIO, at addresses 0x24,
0x34, 0x38. Please note that I haven't named IRQ_TIMER bit in the
irqsrc and fiqsrc fields, that was already defined. This patch
implements that one.

> see anything in the spec that looked like a register for
> reading the current timer value (though it would certainly
> be usual to provide one).

Those are registers 0x1C and 0x20, called "Core timer access LS/MS",
section 4.3. I'll make the comment more clear. Those are not local
timer IRQ related, because they could use a different frequency than
the IRQ, just happen to be enabled with a bit in the local timer's
control register (and not in the core timer control register at 0x0),
and on real hardware triggering an IRQ requires both the timer enable
and interrupt enable bits to be set. The timer counter is a 64 bits
one, while the IRQ's counter is only 28 bit wide, which cannot be
directly read, does not use the prescaler, and it's reload value
stored in the local timer control register itself (unusal, but that's
how it is).

As I've said, this patch only provides the IRQ, and not the timer
part. That's a whole different story, specially beacuse of the
counters (calculating correct value for the selected clocksource
(crystal/APB), using divisor and prescaler value, the 32 bit register
locking mechanism etc.), that's for another patch.

On a real hardware the interrupt has to be implemented using the
timer. On qemu, we don't need to emulate the whole timer circuit and
counter, we can use QEMUTimer to calculate when to trigger a periodic
IRQ (which is always at fixed 38.4Mhz not using any divisor or
prescaler). But I think regadless we should emulate the control
register in that timer enable bit should be set when we generate local
timer IRQs. I hope this makes sense to you.

>
>>   *
>>   * Ref:
>>   *
>> https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/Q=
A7_rev3.4.pdf
>> @@ -18,6 +22,9 @@
>>  #include "qemu/log.h"
>>
>>  #define REG_GPU_ROUTE           0x0c
>> +#define REG_LOCALTIMERROUTING   0x24
>> +#define REG_LOCALTIMERCONTROL   0x34
>> +#define REG_LOCALTIMERACK       0x38
>>  #define REG_TIMERCONTROL        0x40
>>  #define REG_MBOXCONTROL         0x50
>>  #define REG_IRQSRC              0x60
>> @@ -43,6 +50,13 @@
>>  #define IRQ_TIMER       11
>>  #define IRQ_MAX         IRQ_TIMER
>>
>> +#define LOCALTIMER_FREQ      38400000
>> +#define LOCALTIMER_INTFLAG   (1 << 31)
>> +#define LOCALTIMER_RELOAD    (1 << 30)
>> +#define LOCALTIMER_INTENABLE (1 << 29)
>> +#define LOCALTIMER_ENABLE    (1 << 28)
>> +#define LOCALTIMER_VALUE(x)  ((x) & 0xfffffff)
>> +
>>  static void deliver_local(BCM2836ControlState *s, uint8_t core, uint8_t
>> irq,
>>                            uint32_t controlreg, uint8_t controlidx)
>>  {
>> @@ -78,6 +92,15 @@ static void bcm2836_control_update(BCM2836ControlStat=
e
>> *s)
>>          s->fiqsrc[s->route_gpu_fiq] |=3D (uint32_t)1 << IRQ_GPU;
>>      }
>>
>> +    /* handle THE local timer interrupt for one of the cores' IRQ/FIQ *=
/
>> +    if (s->triggered) {
>> +        if (s->route_localtimer & 4) {
>> +            s->fiqsrc[(s->route_localtimer & 3)] |=3D (uint32_t)1 <<
>> IRQ_TIMER;
>> +        } else {
>> +            s->irqsrc[(s->route_localtimer & 3)] |=3D (uint32_t)1 <<
>> IRQ_TIMER;
>> +        }
>> +    }
>> +
>>      for (i =3D 0; i < BCM2836_NCORES; i++) {
>>          /* handle local timer interrupts for this core */
>>          if (s->timerirqs[i]) {
>> @@ -162,6 +185,62 @@ static void bcm2836_control_set_gpu_fiq(void
>> *opaque, int irq, int level)
>>      bcm2836_control_update(s);
>>  }
>>
>> +static void bcm2836_control_local_timer_set_next(void *opaque)
>> +{
>> +    BCM2836ControlState *s =3D opaque;
>> +    uint64_t next_event;
>> +
>> +    assert(s->period > 0);
>> +
>> +    next_event =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>> +        (NANOSECONDS_PER_SECOND * s->period / LOCALTIMER_FREQ);
>
> This sort of X * Y / Z calculation for timers should
> be done with muldiv64() which uses a larger intermediate
> result to avoid overflow problems:
>
>        next_event =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>           muldiv64(s->period, NANOSECONDS_PER_SECOND, LOCALTIMER_FREQ);
>

OK!

>> +    timer_mod(s->timer, next_event);
>> +}
>> +
>> +static void bcm2836_control_local_timer_tick(void *opaque)
>> +{
>> +    BCM2836ControlState *s =3D opaque;
>> +
>> +    bcm2836_control_local_timer_set_next(s);
>> +
>> +    if (!s->triggered) {
>> +        s->triggered =3D 1;
>> +        bcm2836_control_update(s);
>> +    }
>> +}
>> +
>> +static void bcm2836_control_local_timer_control(void *opaque, uint32_t
>> val)
>> +{
>> +    BCM2836ControlState *s =3D opaque;
>> +
>> +    s->period =3D LOCALTIMER_VALUE(val);
>> +    if (val & LOCALTIMER_INTENABLE) {
>> +        if (!s->timer) {
>> +            s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>> +                bcm2836_control_local_timer_tick, s);
>
> You should just create the timer once, at device initialization,
> not every time the guest enables it. Enabling the timer
> can be done with timer_mod().

OK!

>
>> +        }
>> +        bcm2836_control_local_timer_set_next(s);
>> +    } else {
>> +        if (s->timer) {
>> +            timer_del(s->timer);
>> +            s->timer =3D NULL;
>
> This leaks the timer, because timer_del() is just "turn
> off the timer", not "deinitialize and free the timer memory".
> You just want to use timer_del() here, and leave s->timer
> set so that when it's enabled you can use timer_mod() to
> restart it.

OK!

>
>> +        }
>> +        s->triggered =3D 0;
>> +    }
>> +}
>> +
>> +static void bcm2836_control_local_timer_ack(void *opaque, uint32_t val)
>> +{
>> +    BCM2836ControlState *s =3D opaque;
>> +
>> +    if (val & LOCALTIMER_INTFLAG) {
>> +        s->triggered =3D 0;
>> +    }
>> +    if (val & LOCALTIMER_RELOAD) {
>> +        bcm2836_control_local_timer_set_next(s);
>> +    }
>> +}
>> +
>>  static uint64_t bcm2836_control_read(void *opaque, hwaddr offset,
>> unsigned size)
>>  {
>>      BCM2836ControlState *s =3D opaque;
>> @@ -170,6 +249,14 @@ static uint64_t bcm2836_control_read(void
>> *opaque, hwaddr offset, unsigned size)
>>          assert(s->route_gpu_fiq < BCM2836_NCORES
>>                 && s->route_gpu_irq < BCM2836_NCORES);
>>          return ((uint32_t)s->route_gpu_fiq << 2) | s->route_gpu_irq;
>> +    } else if (offset =3D=3D REG_LOCALTIMERROUTING) {
>> +        return s->route_localtimer;
>> +    } else if (offset =3D=3D REG_LOCALTIMERCONTROL) {
>> +        return s->period |
>> +            (s->timer ? LOCALTIMER_ENABLE | LOCALTIMER_INTENABLE : 0) |
>
> This looks odd - the timer enable and interrupt enable bits
> should be independent, not always either both set or both cleared.

That's emulation of the real hardware, see my comment above. On a real
hardware you can't enable interrupts without the timer enabled.

>
> I suspect this register will be simpler to model if you
> have the state struct have a
>   uint32_t local_timer_control;
> which just stores the whole register value (so no
> separate s->triggered and s->period -- just pull
> the fields out of the s->local_timer_control with
> extract32() or masking when you need them).

OK!

>
>> +            (s->triggered ? LOCALTIMER_INTFLAG : 0);
>> +    } else if (offset =3D=3D REG_LOCALTIMERACK) {
>> +        return 0;
>>      } else if (offset >=3D REG_TIMERCONTROL && offset < REG_MBOXCONTROL=
) {
>>          return s->timercontrol[(offset - REG_TIMERCONTROL) >> 2];
>>      } else if (offset >=3D REG_MBOXCONTROL && offset < REG_IRQSRC) {
>> @@ -195,6 +282,12 @@ static void bcm2836_control_write(void *opaque,
>> hwaddr offset,
>>      if (offset =3D=3D REG_GPU_ROUTE) {
>>          s->route_gpu_irq =3D val & 0x3;
>>          s->route_gpu_fiq =3D (val >> 2) & 0x3;
>> +    } else if (offset =3D=3D REG_LOCALTIMERROUTING) {
>> +        s->route_localtimer =3D val & 7;
>> +    } else if (offset =3D=3D REG_LOCALTIMERCONTROL) {
>> +        bcm2836_control_local_timer_control(s, val);
>> +    } else if (offset =3D=3D REG_LOCALTIMERACK) {
>> +        bcm2836_control_local_timer_ack(s, val);
>>      } else if (offset >=3D REG_TIMERCONTROL && offset < REG_MBOXCONTROL=
) {
>>          s->timercontrol[(offset - REG_TIMERCONTROL) >> 2] =3D val & 0xf=
f;
>>      } else if (offset >=3D REG_MBOXCONTROL && offset < REG_IRQSRC) {
>> @@ -227,6 +320,13 @@ static void bcm2836_control_reset(DeviceState *d)
>>
>>      s->route_gpu_irq =3D s->route_gpu_fiq =3D 0;
>>
>> +    s->route_localtimer =3D s->triggered =3D 0;
>> +    s->period =3D 0;
>> +    if(s->timer) {
>> +        timer_del(s->timer);
>> +        s->timer =3D NULL;
>
> As above, this shouldn't be NULLing out s->timer; you can just
> unconditionally call timer_del().

OK!

>
>> +    }
>> +
>>      for (i =3D 0; i < BCM2836_NCORES; i++) {
>>          s->timercontrol[i] =3D 0;
>>          s->mailboxcontrol[i] =3D 0;
>> diff --git a/include/hw/intc/bcm2836_control.h
>> b/include/hw/intc/bcm2836_control.h
>> index 613f3c4186..873bd52253 100644
>> --- a/include/hw/intc/bcm2836_control.h
>> +++ b/include/hw/intc/bcm2836_control.h
>> @@ -5,6 +5,9 @@
>>   * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsof=
t
>>   * Written by Andrew Baumann
>>   *
>> + * 64-bit ARM Local Timer Copyright (c) 2019. Zolt=C3=A1n Baldaszti
>> + * Added basic IRQ_TIMER interrupt support
>> + *
>>   * This code is licensed under the GNU GPLv2 and later.
>>   */
>>
>> @@ -12,6 +15,7 @@
>>  #define BCM2836_CONTROL_H
>>
>>  #include "hw/sysbus.h"
>> +#include "qemu/timer.h"
>>
>>  /* 4 mailboxes per core, for 16 total */
>>  #define BCM2836_NCORES 4
>> @@ -39,6 +43,12 @@ typedef struct BCM2836ControlState {
>>      bool gpu_irq, gpu_fiq;
>>      uint8_t timerirqs[BCM2836_NCORES];
>>
>> +    /* local timer */
>> +    uint8_t route_localtimer;
>> +    uint32_t period;
>> +    bool triggered;
>> +    QEMUTimer *timer;
>
> Slightly nicer to just embed the QEMUTimer struct (and
> then initialize it with timer_init_ns() rather than using
> timer_new_ns(), which does 'allocate and init'.)

What do you mean by embed? Statically include the QEMUTimer struct?
That would require more memory even if a guest never turns the local
timer IRQ on. Is that acceptable? Otherwise OK!

>
>> +
>>      /* interrupt source registers, post-routing (also input-derived;
>> visible) */
>>      uint32_t irqsrc[BCM2836_NCORES];
>>      uint32_t fiqsrc[BCM2836_NCORES];
>
> New fields in this struct require new entries in the
> vmstate_bcm2836_control struct so the data is migrated.
> In this case we don't care about maintaining migration
> compatibility between QEMU versions, so the easiest thing
> is to bump the .version_id field to 2, and use
> VMSTATE_*_V(..., 2) macros to mark the new fields as
> being only present in version 2.
>
> If you take my suggestion about using a single uint32_t
> local_timer_control and an embedded QEMUTimer struct,
> that works out at
>    VMSTATE_TIMER_V(timer, BCM2836ControlState, 2),
>    VMSTATE_UINT32_V(local_timer_control, BCM2836ControlState, 2),
>    VMSTATE_UINT8_V(route_localtimer, BCM2836ControlState, 2),

OK!

>
> thanks
> -- PMM
>

Thanks for the review again, I'll modify the patch accordingly.

bzt
