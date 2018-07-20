Received: from eggs.gnu.org ([2001:4830:134:3::10]:41874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgWI5-0000BA-UR
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 10:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgWI4-0006Oy-Fx
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 10:21:53 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgWI4-0006Ol-7q
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 10:21:52 -0400
Received: by mail-oi0-x241.google.com with SMTP id 13-v6so21675183ois.1
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 07:21:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f2c6cd9a-0136-5a4c-64d8-854661f4278d@greensocs.com>
References: <20180714171601.5734-1-luc.michel@greensocs.com>
	<20180714171601.5734-13-luc.michel@greensocs.com>
	<CAFEAcA9dQEaONA3AkqnyY3PnkMHNcjc=MiBwoF99oHp-BJuRFA@mail.gmail.com>
	<f2c6cd9a-0136-5a4c-64d8-854661f4278d@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jul 2018 15:21:30 +0100
Message-ID: <CAFEAcA_f_X2hn26EO2ZvmUBKjAkUbL6k9u+2tAMassdoA+3O-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 12/20] intc/arm_gic: Implement
 virtualization extensions in gic_(deactivate|complete_irq)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 18 July 2018 at 14:22, Luc Michel <luc.michel@greensocs.com> wrote:
>
>
> On 07/17/2018 03:32 PM, Peter Maydell wrote:
>> On 14 July 2018 at 18:15, Luc Michel <luc.michel@greensocs.com> wrote:
>>> Implement virtualization extensions in the gic_deactivate_irq() and
>>> gic_complete_irq() functions.  When a guest tries to deactivat or end an
>>
>> "deactivate"
>>
>>> IRQ that does not exist in the LRs, the EOICount field of the virtual
>>> interface HCR register is incremented by one, and the request is
>>> ignored.
>>>
>>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>>> ---
>>>  hw/intc/arm_gic.c | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
>>> index be9e2594d9..50cbbfbe24 100644
>>> --- a/hw/intc/arm_gic.c
>>> +++ b/hw/intc/arm_gic.c
>>> @@ -590,6 +590,15 @@ static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>>>          return;
>>>      }
>>>
>>> +    if (gic_is_vcpu(cpu) && !gic_virq_is_valid(s, irq, cpu)) {
>>> +        /* This vIRQ does not have an LR entry which is either active or
>>> +         * pending and active. Increment EOICount and ignore the write.
>>> +         */
>>> +        int rcpu = gic_get_vcpu_real_id(cpu);
>>> +        s->h_hcr[rcpu] += 1 << R_GICH_HCR_EOICount_SHIFT;
>>> +        return;
>>> +    }
>>
>> It's a bit hard to tell from the amount of context in the diff,
>> but I think this check is being done too late in this function.
>> It needs to happen before we do any operations on the irq we're
>> passed (eg checking which group it is).

> For operations on the IRQ, yes. But there is also the test on the
> EOIMode bit in C_CTLR before that. Writing to C_DIR when EOIMode is 0 is
> unpredictable. I was thinking of keeping the same behaviour we had until
> then, which is to completely ignore the write.

Yes, that's a reasonable choice.

>>> +
>>>      if (gic_cpu_ns_access(s, cpu, attrs) && !group) {
>>>          DPRINTF("Non-secure DI for Group0 interrupt %d ignored\n", irq);
>>>          return;
>>> @@ -604,6 +613,15 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>>>      int group;
>>>
>>>      DPRINTF("EOI %d\n", irq);
>>> +    if (gic_is_vcpu(cpu) && !gic_virq_is_valid(s, irq, cpu)) {
>>> +        /* This vIRQ does not have an LR entry which is either active or
>>> +         * pending and active. Increment EOICount and ignore the write.
>>> +         */
>>> +        int rcpu = gic_get_vcpu_real_id(cpu);
>>> +        s->h_hcr[rcpu] += 1 << R_GICH_HCR_EOICount_SHIFT;
>>> +        return;
>>> +    }
>>
>> This isn't consistent with the deactivate code about whether we
>> do this check before the "irq >= s->num_irq" check or after.
>>
>> I think the correct answer is "before", because the number of
>> physical interrupts in the GIC shouldn't affect the valid
>> range of virtual interrupts.
>>
>> There is also an edge case here: if the VIRQ written to the
>> EOI or DIR registers is a special interrupt number (1020..1023),
>> then should we increment the EOI count or not? The GICv2 spec
>> is not entirely clear on this point, but it does say in the
>> GICH_HCR.EOICount docs that "EOIs that do not clear a bit in
>> the Active Priorities register GICH_APR do not cause an increment",
>> and the GICv3 spec is clear so my recommendation is that for
>> 1020..1023 we should ignore the write and not increment EOICount.
>>
>> That bit about "EOIs that do not clear a bit in GICH_APR do
>> not increment EOICount" also suggests that our logic for DIR
>> and EOI needs to be something like:
>>
>>   if (vcpu) {
>>       if (irq > 1020) {
>>           return;
>>       }
>>       clear GICH_HCR bit;
>>       if (no bit cleared) {
>>           return;
>>       }
>>       if (!gic_virq_is_valid()) {
>>           increment EOICount;
>>           return;
>>       }
>>       clear active bit in LR;
>>   }
>>
>> ?
> I agree for EOIR, but for DIR, it seems weird. A write to DIR never
> causes a bit to be cleared in GICH_APR. It can only change the state of
> the LR corresponding to the given vIRQ. So if we read the specification
> this way, a write to DIR should never cause a EOICount increment.

Yes, I think you're right and I was misreading the spec here,
at least where it regards DIR.

> However the part you quoted:
>
> "EOIs that do not clear a bit in the Active Priorities register GICH_APR
> do not cause an increment"
>
> seems to apply to EOIs only, not to interrupt deactivations.
>
> And in the DIR specification:
> "If the specified Interrupt does not exist in the List registers, the
> GICH_HCR.EOIcount field is incremented"
>
> So I would suggest that we apply your reasoning for EOIR. For DIR, I
> think something like this is sufficient:
>
>    if (vcpu) {
>        if (irq > 1020) {
>            return;
>        }
>        if (!gic_virq_is_valid()) {
>            increment EOICount;
>            return;
>        }
>        clear active bit in LR;
>    }
>
>
> What do you think?

Yes, I think this is right.

thanks
-- PMM
