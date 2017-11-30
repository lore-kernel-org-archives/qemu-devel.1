Received: from eggs.gnu.org ([2001:4830:134:3::10]:46950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKQvS-0001Mp-7O
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKQvP-0005H4-4G
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:38:58 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:60785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKQvO-0005Gb-TX
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:38:55 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 60A86125C76
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 16:38:53 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-18-clg@kaod.org>
	<20171130055542.GG3023@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f0a75998-97c0-218d-0473-78788dab1f3a@kaod.org>
Date: Thu, 30 Nov 2017 15:38:46 +0000
MIME-Version: 1.0
In-Reply-To: <20171130055542.GG3023@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/25] spapr: add a sPAPRXive object to the
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>

>> +    } else {
>> +        /* XIVE uses the full range of IRQ numbers. The CPU IPIs will
>> +         * use the range below XICS_IRQ_BASE, which is unused by XICS. */
>> +        spapr->xive = spapr_xive_create(spapr, XICS_IRQ_BASE + XICS_IRQS_SPAPR,
>> +                                        &error_fatal);
> 
> XICS_IRQ_BASE == 4096, and XICS_IRQS_SPAPR (which we should rename at
> some point) == 1024.

BTW, why XICS_IRQ_BASE == 4096 ? I could not find a reason for
this offset. 

> So we have a total irq space of 5k, which is a bit odd.  I'd be ok
> with rounding it out to 8k for newer machines if that's useful.

ok. and using a machine class value to maintain compatibility. That 
would be useful if we allocate more PHBs. 

> Sparse allocations in there might make life easier for getting
> consistent irq numbers without an "allocator" per se (because we can
> use different regions for VIO, PCI intx, MSI, etc. etc.).

So, do you think we should modify the IRQ allocator routines to be 
able to segment the IRQ number space and let devices specify the
range they want to use ? 

That would be useful for the PHB LSIs. The starting IRQ for the PHB
could be aligned on some value depending on the PHB index, first 
would come the LSI interrupts and then the MSIs which are allocated 
later on by the guest. We would have predictable values.

Thanks,

C. 
