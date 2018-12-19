Received: from eggs.gnu.org ([2001:4830:134:3::10]:44969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZhKL-0000SR-Qw
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZhKH-0007kq-Ug
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:16:17 -0500
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:59054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gZhKF-0007Yj-VQ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:16:12 -0500
Received: from player699.ha.ovh.net (unknown [10.109.159.90])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id D5CC9D7ABC
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 20:16:02 +0100 (CET)
References: <20181211223823.13770-1-clg@kaod.org>
	<20181211223823.13770-12-clg@kaod.org>
	<20181217060717.GI5597@umbus.fritz.box>
	<dcfacfb6-8fec-04b0-4f2a-c20097511559@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <602c3aab-5eca-7011-966e-3a84df5ce4b3@kaod.org>
Date: Wed, 19 Dec 2018 20:15:36 +0100
MIME-Version: 1.0
In-Reply-To: <dcfacfb6-8fec-04b0-4f2a-c20097511559@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 11/12] spapr: introduce a new sPAPR IRQ
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

>>> +static qemu_irq spapr_qirq_dual(sPAPRMachineState *spapr, int irq)
>>> +{
>>> +    return spapr_irq_current(spapr)->qirq(spapr, irq);
>>> +}
>>
>> This still makes me really nervous - I'd really prefer to have qirqs
>> independent of the backend, rather than relying on *every* irq using
>> device never looking up qirqs in advance.
> 
> I will take a look. This is a large rework I won't have time to address 
> this year. I have removed the dual machine from v9.
> 
> You would move the qirq array at the machine level ?  

I took a look today and did a few changes : 

 - move the qirq array at the machine level
 - introduced a 'set_irq' method to sPAPR IRQ
 - adapted the 'qirq' method of sPAPR IRQ. We still need to perform some
   checks and to handle the IRQ number offset.

It falls well in place, a part for the ICS source of the PnvPSI model 
which does not have any qirq anymore. For PSI, I am thinking of moving 
the qirq array under PnvPSI model, like I did for the machine. 

Would that be ok ?

I think there are a couple more possible cleanups on the different ICS 
models to do if these changes are acceptable. 

C. 
