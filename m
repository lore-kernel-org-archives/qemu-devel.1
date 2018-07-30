Received: from eggs.gnu.org ([2001:4830:134:3::10]:53677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fk8gL-00078R-Qa
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fk8gG-0005um-Qv
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:57:53 -0400
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:46477)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fk8gG-0005ua-JA
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:57:48 -0400
Received: from player756.ha.ovh.net (unknown [10.109.146.5])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id EBE16171004
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 15:57:46 +0200 (CEST)
References: <20180726133723.17041-1-clg@kaod.org>
	<20180726133723.17041-3-clg@kaod.org>
	<20180727051601.GI3694@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7dc4a9b0-cc82-236e-269a-83854edd5456@kaod.org>
Date: Mon, 30 Jul 2018 15:57:41 +0200
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

The XIVE IRQ backend will also need to initialize the MSI allocator but 
the XIVE IRQ number space covers the full number space, it has no IRQ 
number offset. The initialization will differ slightly :

+    /* Initialize the MSI IRQ allocator */
+    spapr_irq_msi_init(spapr, nr_irqs - SPAPR_IRQ_MSI);
+

So I rather keep the call where it is today. This is really a small
duplication.

Thanks,

C. 
