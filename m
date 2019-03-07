Received: from eggs.gnu.org ([209.51.188.92]:45900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1vZH-0005Ue-4J
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1vZG-00080V-BS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:08:23 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:32912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1vZG-0007zb-3W
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:08:22 -0500
Received: by mail-ot1-x342.google.com with SMTP id q24so14607501otk.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 08:08:21 -0800 (PST)
MIME-Version: 1.0
References: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
	<CAFEAcA9UzFdyAFkAuWzcV5x1JDBCTVr=okdLN-MpiduvACt4tw@mail.gmail.com>
	<CADYoBw3yj9yuxUSFuwCqKbTZNFFDF7Je4Kgxt-Rvd71x3JusQA@mail.gmail.com>
	<CAFEAcA_N83yo8xV3hCpVPFOhQj+R95+8fVePjEXgxKZtQPUP3w@mail.gmail.com>
	<CADYoBw00Li2G4srfLvtG4pvBMfyEuDh0AU47wj5BcKOUkfWhKw@mail.gmail.com>
	<CAFEAcA9Ycm43h8ekoc1uP_K7eLT98Qg+EFqE3Lvu66cjU5c5_A@mail.gmail.com>
	<CADYoBw1QFQxicJJ9tQa2Ok7PAdWvgtD4MQncdJ0zi4E2vktVhQ@mail.gmail.com>
In-Reply-To: <CADYoBw1QFQxicJJ9tQa2Ok7PAdWvgtD4MQncdJ0zi4E2vktVhQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 16:08:09 +0000
Message-ID: <CAFEAcA-+U75+EQzcpV4kZHw+4xMSbMv3UJ0CV_Q3DVbNx5RbNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 7 Mar 2019 at 15:57, bzt <bztemail@gmail.com> wrote:
>
> Nope. I meant the second patch, sent on 4th Mar, which had all the
> things fixed you listed in your review.
>
> But here's the modification for your latest query. This one controls
> the timer depending on ENABLE bit. It sets the INTFLAG even if
> INTENABLE is not set, and only raises the IRQ if both are set.

Thanks. I've listed a couple of minor things below
which I think are not quite handling the flags right,
but the rest looks good.

> @@ -78,6 +94,17 @@ static void bcm2836_control_update(BCM2836ControlState *s)
>          s->fiqsrc[s->route_gpu_fiq] |= (uint32_t)1 << IRQ_GPU;
>      }
>
> +    /* handle THE local timer interrupt for one of the cores' IRQ/FIQ */
> +    if ((s->local_timer_control & LOCALTIMER_INTENABLE) &&
> +        (s->local_timer_control & LOCALTIMER_INTFLAG)) {
> +        if (s->route_localtimer & 4) {
> +            s->fiqsrc[(s->route_localtimer & 3)] |= (uint32_t)1 << IRQ_TIMER;
> +        } else {
> +            s->irqsrc[(s->route_localtimer & 3)] |= (uint32_t)1 << IRQ_TIMER;
> +        }
> +        s->local_timer_control &= ~LOCALTIMER_INTENABLE;

This shouldn't clear the INTENABLE flag.

> +    }
> +
>      for (i = 0; i < BCM2836_NCORES; i++) {
>          /* handle local timer interrupts for this core */
>          if (s->timerirqs[i]) {
> @@ -162,6 +189,55 @@ static void bcm2836_control_set_gpu_fiq(void
> *opaque, int irq, int level)
>      bcm2836_control_update(s);
>  }

> +static void bcm2836_control_local_timer_control(void *opaque, uint32_t val)
> +{
> +    BCM2836ControlState *s = opaque;
> +
> +    s->local_timer_control = val & ~LOCALTIMER_INTFLAG;

This will clear the LOCALTIMER_INTFLAG if it was already
set -- you want to preserve it, something like
   s->local_timer_control = (s->local_timer_control & LOCALTIMER_INTFLAG) |
     (val & ~LOCALTIMER_INTFLAG);

> +    if (val & LOCALTIMER_ENABLE) {
> +        bcm2836_control_local_timer_set_next(s);
> +    } else {
> +        timer_del(&s->timer);
> +    }
> +}
> +
> +static void bcm2836_control_local_timer_ack(void *opaque, uint32_t val)
> +{
> +    BCM2836ControlState *s = opaque;
> +
> +    if (val & LOCALTIMER_INTFLAG) {
> +        s->local_timer_control |= LOCALTIMER_INTENABLE;
> +        s->local_timer_control &= ~LOCALTIMER_INTFLAG;

This should just clear the INTFLAG, it doesn't affect INTENABLE.

> +    }
> +    if ((val & LOCALTIMER_RELOAD) &&
> +        (s->local_timer_control & LOCALTIMER_ENABLE)) {
> +            bcm2836_control_local_timer_set_next(s);
> +    }
> +}

thanks
-- PMM
