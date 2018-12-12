Received: from eggs.gnu.org ([2001:4830:134:3::10]:58437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gX0aM-0007yC-MD
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gX0aJ-0003uw-H5
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:13:42 -0500
Received: from 2.mo7.mail-out.ovh.net ([87.98.143.68]:33957)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gX0aJ-0003u3-9B
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:13:39 -0500
Received: from player714.ha.ovh.net (unknown [10.109.146.168])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 49837EFB4F
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:13:37 +0100 (CET)
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-17-clg@kaod.org>
	<20181211020350.GF4261@umbus.fritz.box>
	<771f030d-b69f-78e4-ac0c-9f37e3ab9c17@kaod.org>
	<20181212005418.GG2719@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d5a33faf-cd68-861e-e795-d587b1b49bc7@kaod.org>
Date: Wed, 12 Dec 2018 10:13:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181212005418.GG2719@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 16/19] spapr: introduce a new sPAPR IRQ
 backend supporting XIVE and XICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

[ ... ] 


>>>> +
>>>> +static qemu_irq spapr_qirq_dual(sPAPRMachineState *spapr, int irq)
>>>> +{
>>>> +    return spapr_irq_current(spapr)->qirq(spapr, irq);
>>>
>>> Urgh... I don't think this is going to work.  IIRC the various devices
>>> (PHB, VIO, etc.)  are wired up to their qirqs at realize() time, so if
>>> you reboot from a XIVE guest to XICS guest (or maybe the other way
>>> around) the peripherals won't be able to signal irqs in the new
>>> scheme.
>>
>> It does. The IRQ numbers are claimed in both backends.
> 
> Yes, I realize that, but the two backends still have their own set of
> qirqs, which have their own set_irq routines associated with them.
> 
>> This is the problem since the very beginning. For reset and migration
>> to work, we need to keep in sync the IRQ number space of the machine 
>> and the different interrupt controllers.
> 
> Sure, we have the numbers in sync, but that won't help if when the
> peripherals do a qemu_irq_pulse() it goes to the wrong backend's
> trigger routine.

Ah. You mean that the devices could bypass the sPAPR IRQ layer and 
trigger the IRQ directly from the IRQ controller model ? it's not 
the case today. 

I agree that having a common set of qirqs and a qemu_irq handler 
doing the dispatch on the selected interrupt contoller model is 
good idea. I didn't go in that direction because KVM brings additional 
head aches.

Where would put the qirqs ? at the machine level I suppose.

Thanks,

C.    
 
> 
>>
>> C. 
>>
>>
>>> I think instead we need a common set of qirqs, whose set_irq routine
>>> looks at whether to signal XICS or XIVE.  FOr now I think the easiest
>>> approach is to layer those on top of the existing XICS or XIVE
>>> specific qirqs.  Later we might want to remove the (input) qirqs
>>> entirely from the XICS and XIVE subsystems, instead having just
>>> explicit trigger functions.  Then spapr will always supply the qirqs
>>> which call into one or the other.
>>>
>>>> +}
>>>> +
>>>> +static void spapr_irq_print_info_dual(sPAPRMachineState *spapr, Monitor *mon)
>>>> +{
>>>> +    spapr_irq_current(spapr)->print_info(spapr, mon);
>>>> +}
>>>> +
>>>> +static void spapr_irq_dt_populate_dual(sPAPRMachineState *spapr,
>>>> +                                       uint32_t nr_servers, void *fdt,
>>>> +                                       uint32_t phandle)
>>>> +{
>>>> +    spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phandle);
>>>> +}
>>>> +
>>>> +static Object *spapr_irq_cpu_intc_create_dual(sPAPRMachineState *spapr,
>>>> +                                              Object *cpu, Error **errp)
>>>> +{
>>>> +    Error *local_err = NULL;
>>>> +
>>>> +    spapr_irq_xive.cpu_intc_create(spapr, cpu, &local_err);
>>>> +    if (local_err) {
>>>> +        error_propagate(errp, local_err);
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    /* Default to XICS interrupt mode */
>>>> +    return spapr_irq_xics.cpu_intc_create(spapr, cpu, errp);
>>>> +}
>>>> +
>>>> +static int spapr_irq_post_load_dual(sPAPRMachineState *spapr, int version_id)
>>>> +{
>>>> +    /*
>>>> +     * Force a reset of the XIVE backend after migration. The machine
>>>> +     * defaults to XICS at startup.
>>>> +     */
>>>> +    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
>>>> +        spapr_irq_xive.reset(spapr, &error_fatal);
>>>> +    }
>>>> +
>>>> +    return spapr_irq_current(spapr)->post_load(spapr, version_id);
>>>> +}
>>>> +
>>>> +static void spapr_irq_reset_dual(sPAPRMachineState *spapr, Error **errp)
>>>> +{
>>>> +    /*
>>>> +     * Reset the interrupt mode selected by CAS.
>>>> +     */
>>>> +    spapr_irq_current(spapr)->reset(spapr, errp);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Define values in sync with the XIVE and XICS backend
>>>> + */
>>>> +#define SPAPR_IRQ_DUAL_NR_IRQS     0x2000
>>>> +#define SPAPR_IRQ_DUAL_NR_MSIS     (SPAPR_IRQ_DUAL_NR_IRQS - SPAPR_IRQ_MSI)
>>>> +
>>>> +sPAPRIrq spapr_irq_dual = {
>>>> +    .nr_irqs     = SPAPR_IRQ_DUAL_NR_IRQS,
>>>> +    .nr_msis     = SPAPR_IRQ_DUAL_NR_MSIS,
>>>> +    .ov5         = SPAPR_OV5_XIVE_BOTH,
>>>> +
>>>> +    .init        = spapr_irq_init_dual,
>>>> +    .claim       = spapr_irq_claim_dual,
>>>> +    .free        = spapr_irq_free_dual,
>>>> +    .qirq        = spapr_qirq_dual,
>>>> +    .print_info  = spapr_irq_print_info_dual,
>>>> +    .dt_populate = spapr_irq_dt_populate_dual,
>>>> +    .cpu_intc_create = spapr_irq_cpu_intc_create_dual,
>>>> +    .post_load   = spapr_irq_post_load_dual,
>>>> +    .reset       = spapr_irq_reset_dual,
>>>> +};
>>>> +
>>>>  /*
>>>>   * sPAPR IRQ frontend routines for devices
>>>>   */
>>>
>>
> 
