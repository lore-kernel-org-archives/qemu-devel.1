Received: from eggs.gnu.org ([209.51.188.92]:60911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1h2QOV-0001yM-KX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1h2QOU-0006oe-Ox
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:03:19 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-+U75+EQzcpV4kZHw+4xMSbMv3UJ0CV_Q3DVbNx5RbNg@mail.gmail.com>
References: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
	<CAFEAcA9UzFdyAFkAuWzcV5x1JDBCTVr=okdLN-MpiduvACt4tw@mail.gmail.com>
	<CADYoBw3yj9yuxUSFuwCqKbTZNFFDF7Je4Kgxt-Rvd71x3JusQA@mail.gmail.com>
	<CAFEAcA_N83yo8xV3hCpVPFOhQj+R95+8fVePjEXgxKZtQPUP3w@mail.gmail.com>
	<CADYoBw00Li2G4srfLvtG4pvBMfyEuDh0AU47wj5BcKOUkfWhKw@mail.gmail.com>
	<CAFEAcA9Ycm43h8ekoc1uP_K7eLT98Qg+EFqE3Lvu66cjU5c5_A@mail.gmail.com>
	<CADYoBw1QFQxicJJ9tQa2Ok7PAdWvgtD4MQncdJ0zi4E2vktVhQ@mail.gmail.com>
	<CAFEAcA-+U75+EQzcpV4kZHw+4xMSbMv3UJ0CV_Q3DVbNx5RbNg@mail.gmail.com>
From: bzt <bztemail@gmail.com>
Date: Sat, 9 Mar 2019 02:03:13 +0100
Message-ID: <CADYoBw2XWeDUqBHVJBWxJAzQ4f0imosEeLHHoG9AfHfdavOTrA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi,

Thanks for your answers. If I don't clear the INTENABLE flag, then the
IRQ would keep firing constantly. This is not how the real hardware
works: it triggers the IRQ once, and then it inhibits. The timer won't
trigger the IRQ again until you acknowledge it by writing the INTFLAG
into the ack register. My solution emulates this behaviour. That's
what the triggered flag was for in my original patch. Should I bring
that flag back or is the current solution acceptable knowing this?

About keeping the INTFLAG on control write that's to avoid an instant
IRQ, but that's OK. I'll modify that.

Thanks,
bzt


On 3/7/19, Peter Maydell <peter.maydell@linaro.org> wrote:
> On Thu, 7 Mar 2019 at 15:57, bzt <bztemail@gmail.com> wrote:
>>
>> Nope. I meant the second patch, sent on 4th Mar, which had all the
>> things fixed you listed in your review.
>>
>> But here's the modification for your latest query. This one controls
>> the timer depending on ENABLE bit. It sets the INTFLAG even if
>> INTENABLE is not set, and only raises the IRQ if both are set.
>
> Thanks. I've listed a couple of minor things below
> which I think are not quite handling the flags right,
> but the rest looks good.
>
>> @@ -78,6 +94,17 @@ static void bcm2836_control_update(BCM2836ControlState
>> *s)
>>          s->fiqsrc[s->route_gpu_fiq] |= (uint32_t)1 << IRQ_GPU;
>>      }
>>
>> +    /* handle THE local timer interrupt for one of the cores' IRQ/FIQ */
>> +    if ((s->local_timer_control & LOCALTIMER_INTENABLE) &&
>> +        (s->local_timer_control & LOCALTIMER_INTFLAG)) {
>> +        if (s->route_localtimer & 4) {
>> +            s->fiqsrc[(s->route_localtimer & 3)] |= (uint32_t)1 <<
>> IRQ_TIMER;
>> +        } else {
>> +            s->irqsrc[(s->route_localtimer & 3)] |= (uint32_t)1 <<
>> IRQ_TIMER;
>> +        }
>> +        s->local_timer_control &= ~LOCALTIMER_INTENABLE;
>
> This shouldn't clear the INTENABLE flag.
>
>> +    }
>> +
>>      for (i = 0; i < BCM2836_NCORES; i++) {
>>          /* handle local timer interrupts for this core */
>>          if (s->timerirqs[i]) {
>> @@ -162,6 +189,55 @@ static void bcm2836_control_set_gpu_fiq(void
>> *opaque, int irq, int level)
>>      bcm2836_control_update(s);
>>  }
>
>> +static void bcm2836_control_local_timer_control(void *opaque, uint32_t
>> val)
>> +{
>> +    BCM2836ControlState *s = opaque;
>> +
>> +    s->local_timer_control = val & ~LOCALTIMER_INTFLAG;
>
> This will clear the LOCALTIMER_INTFLAG if it was already
> set -- you want to preserve it, something like
>    s->local_timer_control = (s->local_timer_control & LOCALTIMER_INTFLAG) |
>      (val & ~LOCALTIMER_INTFLAG);
>
>> +    if (val & LOCALTIMER_ENABLE) {
>> +        bcm2836_control_local_timer_set_next(s);
>> +    } else {
>> +        timer_del(&s->timer);
>> +    }
>> +}
>> +
>> +static void bcm2836_control_local_timer_ack(void *opaque, uint32_t val)
>> +{
>> +    BCM2836ControlState *s = opaque;
>> +
>> +    if (val & LOCALTIMER_INTFLAG) {
>> +        s->local_timer_control |= LOCALTIMER_INTENABLE;
>> +        s->local_timer_control &= ~LOCALTIMER_INTFLAG;
>
> This should just clear the INTFLAG, it doesn't affect INTENABLE.
>
>> +    }
>> +    if ((val & LOCALTIMER_RELOAD) &&
>> +        (s->local_timer_control & LOCALTIMER_ENABLE)) {
>> +            bcm2836_control_local_timer_set_next(s);
>> +    }
>> +}
>
> thanks
> -- PMM
>
