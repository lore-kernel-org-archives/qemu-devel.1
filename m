Received: from eggs.gnu.org ([2001:4830:134:3::10]:34378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUpyQ-0001QY-HH
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 04:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUpyN-0001pw-GC
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 04:57:18 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:54386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fUpyN-0001jS-9e
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 04:57:15 -0400
Received: from player732.ha.ovh.net (unknown [10.109.120.103])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 1F9AA139094
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 10:57:05 +0200 (CEST)
References: <20180615115303.31125-1-clg@kaod.org>
	<20180615115303.31125-4-clg@kaod.org>
	<20180615180311.6d16e506@bahia.lan>
	<c5182296-b9f5-0072-8d13-551d71560394@kaod.org>
	<20180618104208.66a9f09e@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <26b2695c-8b7e-d5f7-7069-cb234aaf5a2e@kaod.org>
Date: Mon, 18 Jun 2018 10:56:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180618104208.66a9f09e@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/3] spapr: introduce a fixed
 IRQ number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

[ ... ]

>>> This is 4 irqs per PHB, hence up to 32 PHBs. Cool, we're currently
>>> limited to 31 PHBs.
>>>   
>>>> +#define SPAPR_IRQ_MSI        0x1100  /* Offset of the dynamic range covered  
>>>
>>> We only support dynamic MSIs with PCI, maybe rename to SPAPR_IRQ_PCI_MSI ?  
>>
>> hmm, no. We could have CAPI devices there. remember ? ;)
>>
> 
> Well... OpenCAPI devices are exposed to the OS as PCI devices, so I'm not
> sure we need a CAPI specific range.

yes. so this range is common to all devices doing dynamic allocation
of IRQs. How should we call it ? 

>>>> +                                      * by the bitmap allocator */  
>>>
>>> The range size is hence 1k (XICS_IRQS_SPAPR) for the time being.  
>>
>> in fact we could this bogus limit and use spapr->irq_map_nr now.
>>
> 
> "we could *missing verb* this bogus limit"... so I'm not sure to
> understand...

oups. We could use spapr->irq_map_nr instead of XICS_IRQS_SPAPR when
defining : 

    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQS_SPAPR));

in spapr_pci.c

[ ... ]

>>>> +        if (spapr->xics_legacy) {
>>>> +            dev->irq = spapr_irq_findone(spapr, &local_err);
>>>> +            if (local_err) {
>>>> +                error_propagate(errp, local_err);
>>>> +                return;
>>>> +            }
>>>> +        } else {
>>>> +            dev->irq = SPAPR_IRQ_VIO + vio_index++;  
>>>
>>> This can overlap the next range if we have more than 64 VIO devices...  
>>
>> yes. but claim() should fail.
>>
> 
> Hmm... I have the impression claim() only fails if:
> - irq < ics->offset (ie, XICS_IRQ_BASE == 4096)
> - or irq >= ics->offset + ics->nr_irqs (ie, XICS_IRQS_SPAPR == 1024)
> - or irq is already in use
> 
> I can't find code that would prevent dev->irq to reach SPAPR_IRQ_MSI.

Ah yes. It can overlap. 

My previous proposal took care of overlaps but something simpler was 
requested. That's how I understand it at least. We can introduce 
a maximum for the VIO range or live with it. 

C.
