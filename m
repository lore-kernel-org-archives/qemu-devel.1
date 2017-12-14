Received: from eggs.gnu.org ([2001:4830:134:3::10]:47133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ePVN1-00049d-TJ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ePVMx-0004IG-O5
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:24:23 -0500
Received: from 13.mo7.mail-out.ovh.net ([87.98.150.175]:37676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ePVMx-0004H8-GO
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:24:19 -0500
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 2D2BD83CB8
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 16:24:16 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-4-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0876c4bd-676f-276d-3cf6-aef4a2a562e5@kaod.org>
Date: Thu, 14 Dec 2017 16:24:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171209084338.29395-4-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/19] spapr: introduce the XIVE
 interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>

> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 5b1f78e06a1e..ecc15d889b74 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -24,8 +24,17 @@ struct sPAPRXive {
>      /* Properties */
>      uint32_t     nr_irqs;
>  
> +    /* IRQ */
> +    qemu_irq     *qirqs;
> +
>      /* XIVE internal tables */
>      XiveIVE      *ivt;
> +    uint8_t      *sbe;
> +    uint32_t     sbe_size;
> +
> +    /* ESB memory region */
> +    hwaddr       esb_base;
> +    MemoryRegion esb_iomem;
>  };
>  
>  bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn);
> 

The addition of the XIVE source fields directly under the sPAPRXive 
object is really a design choice. But I am starting to think that 
having multiple XIVE source objects would be a good idea.

Roughly speaking, a XIVE source is a bunch of PQ bits plus a MMIO 
region to manipulate them and, in the QEMU model, a set of associated 
qemu_irqs to do the same from the handlers. 

In real HW, the PSI host bridge controller on the P9 for instance, 
a register holds all the P bits of the IRQs (no Q bits because the 
IRQs are only LSIs) and there is a specific MMIO region for them. 
PSIHB also has a register to store the assertion level of each IRQ.   
So this is quite similar to what we are adding above and in the
next patch for the LSI support. 

The source triggering only depends on the PQ bits (plus the LSI 
level) and the result is a simple forward of the event notification 
to the central XIVE engine : the IVRE, doing the routing. The IVRE
is really our sPAPRXive object. 

The API between the source and the IVRE is extremely simple :

  static void spapr_xive_irq(sPAPRXive *xive, int lisn)

The IVRE then scans its IVT, finds the EQ, and moves on to the 
presenter.

So, we can keep the IVRE engine (sPAPRXive) attached directly to 
the machine like we have today, this is good, and introduce multiple 
XIVE source objects. The sPAPR machine would have : 

 - one for the IPIs [ 0 - nr_servers ]
 - one generic for the devices [ 4096 -  ]
 - one for each phb ? 

The source address in the overall ESB MMIO region would be calculated 
from the offset of the source IRQ numbers in the IRQ number space. 
The offset could very well be hardcoded for each device. I don't see 
any XICS compatibility problems as we are sharing correctly the IRQ 
number space already.


I am starting this discussion because the support for XIVE in the 
QEMU PowerNV machine will need multiple sources, just like for 
POWER8. PnvXive will be a bit different because the IVRE tables 
(IVT and EQDT) are in the virtual machine memory. Most of the settings 
are done in the VM. The QEMU PowerNV machine will still have to 
implement the triggering and the routing logic using the guest tables. 


Regards,

C. 
