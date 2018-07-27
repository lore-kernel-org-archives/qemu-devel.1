Received: from eggs.gnu.org ([2001:4830:134:3::10]:57486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fiwne-0004p4-0D
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 03:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fiwnZ-0003z1-2S
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 03:04:30 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:50089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fiwnY-0003yH-RF
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 03:04:25 -0400
Received: from player734.ha.ovh.net (unknown [10.109.159.90])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 04424C9CAD
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 09:04:22 +0200 (CEST)
References: <20180726133723.17041-1-clg@kaod.org>
	<20180726133723.17041-3-clg@kaod.org>
	<20180727051601.GI3694@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cd9597a3-7f25-769d-b77d-0b0b04916501@kaod.org>
Date: Fri, 27 Jul 2018 09:04:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180727051601.GI3694@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/3] spapr: introduce a IRQ controller
 backend to the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

[ ... ] 

>> +static void spapr_irq_init_xics(sPAPRMachineState *spapr, Error **errp)
>> +{
>> +    MachineState *machine = MACHINE(spapr);
>> +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>> +    int nr_irqs = smc->irq->nr_irqs;
>> +    Error *local_err = NULL;
>> +
>> +    /* Initialize the MSI IRQ allocator. */
>> +    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> +        spapr_irq_msi_init(spapr, XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ_MSI);
>> +    }
> 
> I think this belongs in common code, rather than xics specific.

yes.
 
>> +
>> +    if (kvm_enabled()) {
>> +        if (machine_kernel_irqchip_allowed(machine) &&
>> +            !xics_kvm_init(spapr, &local_err)) {
>> +            spapr->icp_type = TYPE_KVM_ICP;
>> +            spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
>> +                                          &local_err);
>> +        }
>> +        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
>> +            error_prepend(&local_err,
>> +                          "kernel_irqchip requested but unavailable: ");
>> +            goto error;
>> +        }
>> +        error_free(local_err);
>> +        local_err = NULL;
>> +    }
>> +
>> +    if (!spapr->ics) {
> 
> When could this get called with spapr->ics already initialized?

if the code above succeeds when running with the KVM accel. 

What are thinking about ? introducing a xics-kvm backend ?   

C.

>> +        xics_spapr_init(spapr);
>> +        spapr->icp_type = TYPE_ICP;
>> +        spapr->ics = spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
>> +                                      &local_err);
>> +    }
>> +
>> +error:
>> +    error_propagate(errp, local_err);
>> +}
>> +
