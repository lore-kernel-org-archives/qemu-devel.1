Received: from eggs.gnu.org ([209.51.188.92]:39154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0pw1-0006di-Aq
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:55:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0pvz-0004zJ-Ai
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:55:21 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0pvx-0004xJ-Nh
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:55:18 -0500
Received: by mail-oi1-x242.google.com with SMTP id a81so4188215oii.11
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 07:55:17 -0800 (PST)
MIME-Version: 1.0
References: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
In-Reply-To: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2019 15:55:05 +0000
Message-ID: <CAFEAcA9UzFdyAFkAuWzcV5x1JDBCTVr=okdLN-MpiduvACt4tw@mail.gmail.com>
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
To: bzt <bztemail@gmail.com>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 26 Feb 2019 at 11:38, bzt <bztemail@gmail.com> wrote:
>
> Dear qemu developers,
>
> Honestly SubmitAPatch is a bit complicated for me, so I'm hoping I've
> done everything right. To be sure, you can find my patch here:
> https://github.com/bztsrc/qemu-local-timer and diff against the latest
> github repo here:
> https://github.com/bztsrc/qemu-local-timer/blob/patches/3.1.50.diff
>
> Currently the IRQ_TIMER in bcm2836_control is defined, but not
> implemented. This patch adds the basic functionality to qemu by
> implementing 3 new registers in bcm2836_control. You can route the
> interrupt to one of the cores' IRQ or FIQ line by writing 0x40000024,
> and you can set up a periodic interrupt with 38.4MHz frequency by
> writing the divider into 0x40000034. Prescaler are not taken into
> account. When the IRQ fired, you'll see it in 0x40000040+4*N bit 11
> with the rest of the local IRQs, and you can acknowledge it by writing
> 1<<31 to 0x40000038.
>
> The patch is pretty simple, should be easy to review: it does not
> create new classes, does not delete anything, does not change class
> interface, and only two files modified, the bcm2836_control.c and it's
> header.
>
> Sign-off-by: Zolt=C3=A1n Baldaszti <bztemail@gmail.com>
> Subject: [PATCH] Added periodic IRQ support for bcm2836_control local tim=
er

OK, here are my substantive review comments.

> diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
> index cfa5bc7365..fbd31de0f1 100644
> --- a/hw/intc/bcm2836_control.c
> +++ b/hw/intc/bcm2836_control.c
> @@ -7,7 +7,11 @@
>   * This code is licensed under the GNU GPLv2 and later.
>   *
>   * At present, only implements interrupt routing, and mailboxes (i.e.,
> - * not local timer, PMU interrupt, or AXI counters).
> + * not PMU interrupt, or AXI counters).
> + *
> + * 64-bit ARM Local Timer Copyright (c) 2019. Zolt=C3=A1n Baldaszti
> + * The IRQ_TIMER support is still very basic, does not handle timer acce=
ss,
> + * and such there's no point in enabling it without the interrupt flag s=
et.

Can you be more precise about what's missing here? I didn't
see anything in the spec that looked like a register for
reading the current timer value (though it would certainly
be usual to provide one).

>   *
>   * Ref:
>   * https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm283=
6/QA7_rev3.4.pdf
> @@ -18,6 +22,9 @@
>  #include "qemu/log.h"
>
>  #define REG_GPU_ROUTE           0x0c
> +#define REG_LOCALTIMERROUTING   0x24
> +#define REG_LOCALTIMERCONTROL   0x34
> +#define REG_LOCALTIMERACK       0x38
>  #define REG_TIMERCONTROL        0x40
>  #define REG_MBOXCONTROL         0x50
>  #define REG_IRQSRC              0x60
> @@ -43,6 +50,13 @@
>  #define IRQ_TIMER       11
>  #define IRQ_MAX         IRQ_TIMER
>
> +#define LOCALTIMER_FREQ      38400000
> +#define LOCALTIMER_INTFLAG   (1 << 31)
> +#define LOCALTIMER_RELOAD    (1 << 30)
> +#define LOCALTIMER_INTENABLE (1 << 29)
> +#define LOCALTIMER_ENABLE    (1 << 28)
> +#define LOCALTIMER_VALUE(x)  ((x) & 0xfffffff)
> +
>  static void deliver_local(BCM2836ControlState *s, uint8_t core, uint8_t =
irq,
>                            uint32_t controlreg, uint8_t controlidx)
>  {
> @@ -78,6 +92,15 @@ static void bcm2836_control_update(BCM2836ControlState=
 *s)
>          s->fiqsrc[s->route_gpu_fiq] |=3D (uint32_t)1 << IRQ_GPU;
>      }
>
> +    /* handle THE local timer interrupt for one of the cores' IRQ/FIQ */
> +    if (s->triggered) {
> +        if (s->route_localtimer & 4) {
> +            s->fiqsrc[(s->route_localtimer & 3)] |=3D (uint32_t)1 << IRQ=
_TIMER;
> +        } else {
> +            s->irqsrc[(s->route_localtimer & 3)] |=3D (uint32_t)1 << IRQ=
_TIMER;
> +        }
> +    }
> +
>      for (i =3D 0; i < BCM2836_NCORES; i++) {
>          /* handle local timer interrupts for this core */
>          if (s->timerirqs[i]) {
> @@ -162,6 +185,62 @@ static void bcm2836_control_set_gpu_fiq(void
> *opaque, int irq, int level)
>      bcm2836_control_update(s);
>  }
>
> +static void bcm2836_control_local_timer_set_next(void *opaque)
> +{
> +    BCM2836ControlState *s =3D opaque;
> +    uint64_t next_event;
> +
> +    assert(s->period > 0);
> +
> +    next_event =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +        (NANOSECONDS_PER_SECOND * s->period / LOCALTIMER_FREQ);

This sort of X * Y / Z calculation for timers should
be done with muldiv64() which uses a larger intermediate
result to avoid overflow problems:

       next_event =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
          muldiv64(s->period, NANOSECONDS_PER_SECOND, LOCALTIMER_FREQ);

> +    timer_mod(s->timer, next_event);
> +}
> +
> +static void bcm2836_control_local_timer_tick(void *opaque)
> +{
> +    BCM2836ControlState *s =3D opaque;
> +
> +    bcm2836_control_local_timer_set_next(s);
> +
> +    if (!s->triggered) {
> +        s->triggered =3D 1;
> +        bcm2836_control_update(s);
> +    }
> +}
> +
> +static void bcm2836_control_local_timer_control(void *opaque, uint32_t v=
al)
> +{
> +    BCM2836ControlState *s =3D opaque;
> +
> +    s->period =3D LOCALTIMER_VALUE(val);
> +    if (val & LOCALTIMER_INTENABLE) {
> +        if (!s->timer) {
> +            s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                bcm2836_control_local_timer_tick, s);

You should just create the timer once, at device initialization,
not every time the guest enables it. Enabling the timer
can be done with timer_mod().

> +        }
> +        bcm2836_control_local_timer_set_next(s);
> +    } else {
> +        if (s->timer) {
> +            timer_del(s->timer);
> +            s->timer =3D NULL;

This leaks the timer, because timer_del() is just "turn
off the timer", not "deinitialize and free the timer memory".
You just want to use timer_del() here, and leave s->timer
set so that when it's enabled you can use timer_mod() to
restart it.

> +        }
> +        s->triggered =3D 0;
> +    }
> +}
> +
> +static void bcm2836_control_local_timer_ack(void *opaque, uint32_t val)
> +{
> +    BCM2836ControlState *s =3D opaque;
> +
> +    if (val & LOCALTIMER_INTFLAG) {
> +        s->triggered =3D 0;
> +    }
> +    if (val & LOCALTIMER_RELOAD) {
> +        bcm2836_control_local_timer_set_next(s);
> +    }
> +}
> +
>  static uint64_t bcm2836_control_read(void *opaque, hwaddr offset,
> unsigned size)
>  {
>      BCM2836ControlState *s =3D opaque;
> @@ -170,6 +249,14 @@ static uint64_t bcm2836_control_read(void
> *opaque, hwaddr offset, unsigned size)
>          assert(s->route_gpu_fiq < BCM2836_NCORES
>                 && s->route_gpu_irq < BCM2836_NCORES);
>          return ((uint32_t)s->route_gpu_fiq << 2) | s->route_gpu_irq;
> +    } else if (offset =3D=3D REG_LOCALTIMERROUTING) {
> +        return s->route_localtimer;
> +    } else if (offset =3D=3D REG_LOCALTIMERCONTROL) {
> +        return s->period |
> +            (s->timer ? LOCALTIMER_ENABLE | LOCALTIMER_INTENABLE : 0) |

This looks odd - the timer enable and interrupt enable bits
should be independent, not always either both set or both cleared.

I suspect this register will be simpler to model if you
have the state struct have a
  uint32_t local_timer_control;
which just stores the whole register value (so no
separate s->triggered and s->period -- just pull
the fields out of the s->local_timer_control with
extract32() or masking when you need them).

> +            (s->triggered ? LOCALTIMER_INTFLAG : 0);
> +    } else if (offset =3D=3D REG_LOCALTIMERACK) {
> +        return 0;
>      } else if (offset >=3D REG_TIMERCONTROL && offset < REG_MBOXCONTROL)=
 {
>          return s->timercontrol[(offset - REG_TIMERCONTROL) >> 2];
>      } else if (offset >=3D REG_MBOXCONTROL && offset < REG_IRQSRC) {
> @@ -195,6 +282,12 @@ static void bcm2836_control_write(void *opaque,
> hwaddr offset,
>      if (offset =3D=3D REG_GPU_ROUTE) {
>          s->route_gpu_irq =3D val & 0x3;
>          s->route_gpu_fiq =3D (val >> 2) & 0x3;
> +    } else if (offset =3D=3D REG_LOCALTIMERROUTING) {
> +        s->route_localtimer =3D val & 7;
> +    } else if (offset =3D=3D REG_LOCALTIMERCONTROL) {
> +        bcm2836_control_local_timer_control(s, val);
> +    } else if (offset =3D=3D REG_LOCALTIMERACK) {
> +        bcm2836_control_local_timer_ack(s, val);
>      } else if (offset >=3D REG_TIMERCONTROL && offset < REG_MBOXCONTROL)=
 {
>          s->timercontrol[(offset - REG_TIMERCONTROL) >> 2] =3D val & 0xff=
;
>      } else if (offset >=3D REG_MBOXCONTROL && offset < REG_IRQSRC) {
> @@ -227,6 +320,13 @@ static void bcm2836_control_reset(DeviceState *d)
>
>      s->route_gpu_irq =3D s->route_gpu_fiq =3D 0;
>
> +    s->route_localtimer =3D s->triggered =3D 0;
> +    s->period =3D 0;
> +    if(s->timer) {
> +        timer_del(s->timer);
> +        s->timer =3D NULL;

As above, this shouldn't be NULLing out s->timer; you can just
unconditionally call timer_del().

> +    }
> +
>      for (i =3D 0; i < BCM2836_NCORES; i++) {
>          s->timercontrol[i] =3D 0;
>          s->mailboxcontrol[i] =3D 0;
> diff --git a/include/hw/intc/bcm2836_control.h
> b/include/hw/intc/bcm2836_control.h
> index 613f3c4186..873bd52253 100644
> --- a/include/hw/intc/bcm2836_control.h
> +++ b/include/hw/intc/bcm2836_control.h
> @@ -5,6 +5,9 @@
>   * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
>   * Written by Andrew Baumann
>   *
> + * 64-bit ARM Local Timer Copyright (c) 2019. Zolt=C3=A1n Baldaszti
> + * Added basic IRQ_TIMER interrupt support
> + *
>   * This code is licensed under the GNU GPLv2 and later.
>   */
>
> @@ -12,6 +15,7 @@
>  #define BCM2836_CONTROL_H
>
>  #include "hw/sysbus.h"
> +#include "qemu/timer.h"
>
>  /* 4 mailboxes per core, for 16 total */
>  #define BCM2836_NCORES 4
> @@ -39,6 +43,12 @@ typedef struct BCM2836ControlState {
>      bool gpu_irq, gpu_fiq;
>      uint8_t timerirqs[BCM2836_NCORES];
>
> +    /* local timer */
> +    uint8_t route_localtimer;
> +    uint32_t period;
> +    bool triggered;
> +    QEMUTimer *timer;

Slightly nicer to just embed the QEMUTimer struct (and
then initialize it with timer_init_ns() rather than using
timer_new_ns(), which does 'allocate and init'.)

> +
>      /* interrupt source registers, post-routing (also input-derived;
> visible) */
>      uint32_t irqsrc[BCM2836_NCORES];
>      uint32_t fiqsrc[BCM2836_NCORES];

New fields in this struct require new entries in the
vmstate_bcm2836_control struct so the data is migrated.
In this case we don't care about maintaining migration
compatibility between QEMU versions, so the easiest thing
is to bump the .version_id field to 2, and use
VMSTATE_*_V(..., 2) macros to mark the new fields as
being only present in version 2.

If you take my suggestion about using a single uint32_t
local_timer_control and an embedded QEMUTimer struct,
that works out at
   VMSTATE_TIMER_V(timer, BCM2836ControlState, 2),
   VMSTATE_UINT32_V(local_timer_control, BCM2836ControlState, 2),
   VMSTATE_UINT8_V(route_localtimer, BCM2836ControlState, 2),

thanks
-- PMM
