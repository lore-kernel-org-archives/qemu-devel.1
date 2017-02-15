Received: from eggs.gnu.org ([2001:4830:134:3::10]:57377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ce0LX-0007dY-QL
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ce0LS-0005CG-QA
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:14:15 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ce0LS-0005Bu-H5
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:14:10 -0500
Received: by mail-wm0-x22b.google.com with SMTP id v77so41340002wmv.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 06:14:10 -0800 (PST)
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-4-git-send-email-peter.maydell@linaro.org>
	<87mvdnvcxx.fsf@linaro.org>
	<CAFEAcA-PFJp_9=NOCFqiQp=xF6Y-TnmE3bfU3zDa6xH7nK2Zfg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-PFJp_9=NOCFqiQp=xF6Y-TnmE3bfU3zDa6xH7nK2Zfg@mail.gmail.com>
Date: Wed, 15 Feb 2017 14:14:07 +0000
Message-ID: <87inobv8wg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/9] armv7m: Rewrite NVIC to not use any
 GIC code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>, Liviu Ionescu <ilg@livius.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 15 February 2017 at 12:46, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> From: Michael Davidsaver <mdavidsaver@gmail.com>
>>>
>>> Despite some superficial similarities of register layout, the
>>> M-profile NVIC is really very different from the A-profile GIC.
>>> Our current attempt to reuse the GIC code means that we have
>>> significant bugs in our NVIC.
>>>
>>> Implement the NVIC as an entirely separate device, to give
>>> us somewhere we can get the behaviour correct.
>>>
>>> This initial commit does not attempt to implement exception
>>> priority escalation, since the GIC-based code didn't either.
>>> It does fix a few bugs in passing:
>>>  * ICSR.RETTOBASE polarity was wrong and didn't account for
>>>    internal exceptions
>>>  * ICSR.VECTPENDING was 16 too high if the pending exception
>>>    was for an external interrupt
>>>  * UsageFault, BusFault and MemFault were not disabled on reset
>>>    as they are supposed to be
>>>
>>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>>> [PMM: reworked, various bugs and stylistic cleanups]
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  hw/intc/armv7m_nvic.c | 721 ++++++++++++++++++++++++++++++++++++++++----------
>>>  hw/intc/trace-events  |  15 ++
>>>  2 files changed, 592 insertions(+), 144 deletions(-)
>>>
>>> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
>>> index ce22001..e319077 100644
>>> --- a/hw/intc/armv7m_nvic.c
>>> +++ b/hw/intc/armv7m_nvic.c
>>> @@ -17,48 +17,79 @@
<snip>
>>> +static bool nvic_rettobase(NVICState *s)
>>> +{
>>> +    int irq, nhand = 0;
>>> +
>>> +    for (irq = ARMV7M_EXCP_RESET; irq < s->num_irq; irq++) {
>>> +        if (s->vectors[irq].active) {
>>
>> I would expect && !what the ISPR is reporting. However looking at the
>> code it doesn't look like we ever report an exception in the IPSR
>> (assuming HELPER(v7m_mrs) is the right one).
>
> See xpsr_read() in target/arm/cpu.h -- we report
> v7m.exception in the IPSR bits.

So depending on your re-reading of the latest spec should we we count
s->vectors[irq].active && s->vect_pending != irq?

>
>>> +            nhand++;
>>> +            if (nhand == 2) {
>>> +                break;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    return nhand == 1;
>>> +}
>>> +
>>> +/* Return the value of the ISCR ISRPENDING bit:
>>> + * 1 if an external interrupt is pending
>>> + * 0 if no external interrupt is pending
>>> + */
>>> +static bool nvic_isrpending(NVICState *s)
>>> +{
>>> +    int irq;
>>> +
>>> +    /* We can shortcut if the highest priority pending interrupt
>>> +     * happens to be external or if there is nothing pending.
>>> +     */
>>> +    if (s->vectpending > NVIC_FIRST_IRQ) {
>>> +        return true;
>>> +    }
>>> +    if (s->vectpending == 0) {
>>> +        return false;
>>> +    }
>>> +
>>> +    for (irq = NVIC_FIRST_IRQ; irq < s->num_irq; irq++) {
>>
>> Should NVIC_FIRST_IRQ be renamed to NVIC_FIRST_EXTERNAL_IRQ?
>
> The internal ones aren't IRQs, they're exceptions.
> The terminology is a bit confusing, though.

Ahh ok. Maybe just a comment to that effect by the define?

>
>>> +        if (s->vectors[irq].pending) {
>>> +            return true;
>>> +        }
>>> +    }
>>> +    return false;
>>> +}
>>> +
>>> +/* Return a mask word which clears the subpriority bits from
>>> + * a priority value for an M-profile exception, leaving only
>>> + * the group priority.
>>> + */
>>> +static inline uint32_t nvic_gprio_mask(NVICState *s)
>>> +{
>>> +    return ~0U << (s->prigroup + 1);
>>
>> I wonder if it is worth adding MAKE_32BIT_MASK to bitops.h?
>
> MAKE_64BIT_MASK would work here too. This is the same way
> arm_gicv3_cpuif.c writes it, though.
>
>>> +/* caller must call nvic_irq_update() after this */
>>> +static void set_prio(NVICState *s, unsigned irq, uint8_t prio)
>>> +{
>>> +    assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios */
>>> +    assert(irq < s->num_irq);
>>> +
>>> +    s->vectors[irq].prio = prio;
>>
>> So this means the negative priorities are hardwired parts of the NVIC
>> for NMI/RESET? Maybe we should make that clearer in the comment for
>> VecInfo.
>
> Sure. (Yes, the priorities for NMI and HardFault are architecturally
> hardwired. I suspect that in hardware they are not in fact represented
> as negative numbers :-))
>
>>>  /* Make pending IRQ active.  */
>>>  int armv7m_nvic_acknowledge_irq(void *opaque)
>>>  {
>>>      NVICState *s = (NVICState *)opaque;
>>> -    uint32_t irq;
>>> -
>>> -    irq = gic_acknowledge_irq(&s->gic, 0, MEMTXATTRS_UNSPECIFIED);
>>> -    if (irq == 1023)
>>> -        hw_error("Interrupt but no vector\n");
>>> -    if (irq >= 32)
>>> -        irq -= 16;
>>> -    return irq;
>>> +    CPUARMState *env = &s->cpu->env;
>>> +    const int pending = s->vectpending;
>>> +    const int running = nvic_exec_prio(s);
>>> +    int pendgroupprio;
>>> +    VecInfo *vec;
>>> +
>>> +    assert(pending > ARMV7M_EXCP_RESET && pending < s->num_irq);
>>> +
>>> +    vec = &s->vectors[pending];
>>> +
>>> +    assert(vec->enabled);
>>> +    assert(vec->pending);
>>> +
>>> +    pendgroupprio = vec->prio & nvic_gprio_mask(s);
>>> +    assert(pendgroupprio < running);
>>
>> I'm all for asserts to declare what the API is expecting. These are
>> starting to look like being unsure of the nvic being in the correct
>> state. Are they left over from debugging?
>
> They're mostly left over from Michael's code where I didn't
> see any reason to specifically delete them. For this particular
> assert the situation is quite complicated -- we know the
> pending priority must be such that we can take this
> exception, but that is only true because the code
> in target/arm is required to only try to acknowledge
> (take) the exception if the priority permits it,
> which in turn is the result of a combination of the
> conditions that the NVIC applies to decide whether to
> assert the interrupt line and the conditions applied
> in arm_v7m_cpu_exec_interrupt() to decide whether to
> call the CPU do_interrupt hook. That's quite a lot of
> moving parts which need to all agree, which I think makes
> an assert() justified.

I guess it would be easier to remove the asserts if we had run test
cases that explicitly exercised all this code. What are you currently
running to test this code?

>
>>> @@ -428,28 +713,81 @@ static uint64_t nvic_sysreg_read(void *opaque, hwaddr addr,
>>>  {
>>>      NVICState *s = (NVICState *)opaque;
>>>      uint32_t offset = addr;
>>> -    int i;
>>> +    unsigned i, end;
>>>      uint32_t val;
>>>
>>>      switch (offset) {
>>> +    /* reads of set and clear both return the status */
>>> +    case 0x100 ... 0x13f: /* NVIC Set enable */
>>> +        offset += 0x80;
>>> +        /* fall through */
>>> +    case 0x180 ... 0x1bf: /* NVIC Clear enable */
>>> +        val = 0;
>>> +        offset = offset - 0x180 + NVIC_FIRST_IRQ; /* vector # */
>>
>> Can we not calculate a vector index rather than abusing the meaning of
>> offset while switching on it?
>
> Yeah, we could. (This is just a case where I thought "I could
> rewrite the code Michael did initially, but it doesn't quite
> reach my threshold for doing that just because it's not the
> way I'd have written it.".)
>
>
>>> +    /* include space for internal exception vectors */
>>> +    s->num_irq += NVIC_FIRST_IRQ;
>>> +
>>> +    /* The NVIC and system controller register area starts at 0xe000e000
>>> +     * and looks like this:
>>
>> s/system controller register area/System Control Space (SCS)/ to make it
>> easier to find in the ARM ARM.
>
> OK.
>
> thanks
> -- PMM


--
Alex Bennée
