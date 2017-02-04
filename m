Received: from eggs.gnu.org ([2001:4830:134:3::10]:53037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1cZz6y-00074V-D5
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1cZz6t-0000Lg-E5
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:06:36 -0500
Received: from mail-cys01nam02on0083.outbound.protection.outlook.com
	([104.47.37.83]:10368
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1cZz6s-0000LN-Tz
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:06:31 -0500
Date: Sat, 4 Feb 2017 12:50:48 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20170204115048.GM12995@toto>
References: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
	<1486141597-13941-5-git-send-email-fred.konrad@greensocs.com>
	<d64a7dfd-cb55-ba59-9731-282bb98cf20e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d64a7dfd-cb55-ba59-9731-282bb98cf20e@redhat.com>
Subject: Re: [Qemu-devel] [RFC 4/5] exec: allow to get a pointer for some
 mmio memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: fred.konrad@greensocs.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair.francis@xilinx.com, clg@kaod.org, mark.burton@greensocs.com

On Fri, Feb 03, 2017 at 09:26:19AM -0800, Paolo Bonzini wrote:
> 
> 
> On 03/02/2017 09:06, fred.konrad@greensocs.com wrote:
> > +    host = mr->ops->request_ptr(mr->opaque, addr - mr->addr, &size, &offset);
> > +
> > +    if (!host || !size) {
> > +        memory_region_transaction_commit();
> > +        return false;
> > +    }
> > +
> > +    sub = g_new(MemoryRegion, 1);
> > +    memory_region_init_ram_ptr(sub, OBJECT(mr), "mmio-map", size, host);
> > +    memory_region_add_subregion(mr, offset, sub);
> > +    memory_region_transaction_commit();
> > +    return true;
> > +}
> > +
> > +void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
> > +                                       unsigned size)
> > +{
> > +    MemoryRegionSection section = memory_region_find(mr, offset, size);
> > +
> > +    if (section.mr != mr) {
> > +        memory_region_del_subregion(mr, section.mr);
> > +        /* memory_region_find add a ref on section.mr */
> > +        memory_region_unref(section.mr);
> > +        object_unparent(OBJECT(section.mr));
> 
> I think this would cause a use-after-free when using MTTCG.  In general,
> creating and dropping MemoryRegions dynamically can cause bugs that are
> nondeterministic and hard to fix without rewriting everything.
> 
> An alternative design could be:
> 
> - memory_region_request_mmio_ptr returns a MemoryRegionCache instead of
> a pointer, so that the device can map a subset of the device (e.g. a
> single page)
> 
> - memory_region_request_mmio_ptr and MemoryRegionOps.request_ptr accept
> a Notifier
> 
> - the device adds the Notifier to a NotifierList.  Before invalidating,
> it invokes the Notifier and empties the NotifierList.
> 
> - for the TLB case, the Notifier calls tlb_flush_page.

Interesting! I totally missed the MemoryRegionCache patches. Cool concept.
I few lines about it in docs/memory.txt would have been nice too :-)


> I like the general idea though!

I think it's genial. I was expecting a solution for this to get ugly...
It solves some existing issues for us (like the QSPI one addressed in this series).
It also paves the way for certain use-cases when co-simulating with SystemC.
Nice one Fred!

Cheers,
Edgar



> 
> Paolo
> 
> > +    }
> > +}
