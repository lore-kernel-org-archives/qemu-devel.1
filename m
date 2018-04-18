Received: from eggs.gnu.org ([2001:4830:134:3::10]:40734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f8gXy-0007JB-QR
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f8gXu-0008T6-Qc
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:26:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f8gXu-0008St-KY
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:26:22 -0400
Date: Wed, 18 Apr 2018 14:26:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180418062601.GB14841@xz-mi>
References: <20180418045121.14233-1-peterx@redhat.com>
	<A2975661238FB949B60364EF0F2C257439BDD8EC@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257439BDD8EC@SHSMSX104.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH] intel-iommu: send PSI always when
 notify_unmap set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Alexander Witte <alexander.witte@baicanada.com>, Jintack Lim <jintack@cs.columbia.edu>

On Wed, Apr 18, 2018 at 05:29:56AM +0000, Liu, Yi L wrote:
> > Sent: Wednesday, April 18, 2018 12:51 PM
> > Subject: [Qemu-devel] [PATCH] intel-iommu: send PSI always when notify_unmap
> > set
> > 
> > During IOVA page table walk, there is a special case when:
> > 
> > - notify_unmap is set, meanwhile
> > - entry is invalid
> 
> This is very brief description, would you mind talk a little bit more.

It means the case when the program reaches [1] below.

>  
> > In the past, we skip the entry always.  This is not correct.  We should send UNMAP
> > notification to registered notifiers in this case.  Otherwise some stall pages will still
> > be mapped in the host even if L1 guest unmapped them already.
> >
> > Without this patch, nested device assignment to L2 guests might dump some errors
> > like:
> 
> Should it be physical device assigned from L0 host? Or emulated devices could also
> trigger this problem?

If using emulated devices, we possibly need three levels, so I think
we can also see this warning if you assign a emulated device from L1
guest to L2 then to L3, and you should be able to see this warning
dumped from the QEMU that runs L2.

> 
> > qemu-system-x86_64: VFIO_MAP_DMA: -17
> > qemu-system-x86_64: vfio_dma_map(0x557305420c30, 0xad000, 0x1000,
> >                     0x7f89a920d000) = -17 (File exists)
> > 
> > To fix this, we need to apply this patch to L1 QEMU (L2 QEMU is not affected by this
> > problem).
> 
> Does this fix also apply to L0 QEMU?

Sorry I wasn't clear.  When I say L1 QEMU I did mean the QEMU that
runs as L1.  I believe it means your "L0 QEMU" here.

And yes, this fix should also be valid even if without nesting,
however we can hardly trigger this (that's why I just found it
recently when people reported nested breakage, since it is hardly seen
without nested), but AFAIU it's still possible.

>  
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > 
> > To test nested assignment, one also needs to apply below patchset:
> > https://lkml.org/lkml/2018/4/18/5
> > ---
> >  hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++------------
> >  1 file changed, 30 insertions(+), 12 deletions(-)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> > fb31de9416..b359efd6f9 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -722,6 +722,15 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t
> > iova, bool is_write,
> > 
> >  typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
> > 
> > +static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
> > +                             vtd_page_walk_hook hook_fn, void *private)
> > +{
> > +    assert(hook_fn);
> > +    trace_vtd_page_walk_one(level, entry->iova, entry->translated_addr,
> > +                            entry->addr_mask, entry->perm);
> > +    return hook_fn(entry, private);
> > +}
> > +
> >  /**
> >   * vtd_page_walk_level - walk over specific level for IOVA range
> >   *
> > @@ -781,28 +790,37 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t
> > start,
> >           */
> >          entry_valid = read_cur | write_cur;
> > 
> > +        entry.target_as = &address_space_memory;
> > +        entry.iova = iova & subpage_mask;
> > +        entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
> > +        entry.addr_mask = ~subpage_mask;
> > +
> >          if (vtd_is_last_slpte(slpte, level)) {
> > -            entry.target_as = &address_space_memory;
> > -            entry.iova = iova & subpage_mask;
> >              /* NOTE: this is only meaningful if entry_valid == true */
> >              entry.translated_addr = vtd_get_slpte_addr(slpte, aw);
> > -            entry.addr_mask = ~subpage_mask;
> > -            entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
> >              if (!entry_valid && !notify_unmap) {
> >                  trace_vtd_page_walk_skip_perm(iova, iova_next);
> >                  goto next;
> >              }
> > -            trace_vtd_page_walk_one(level, entry.iova, entry.translated_addr,
> > -                                    entry.addr_mask, entry.perm);
> > -            if (hook_fn) {
> > -                ret = hook_fn(&entry, private);
> > -                if (ret < 0) {
> > -                    return ret;
> > -                }
> > +            ret = vtd_page_walk_one(&entry, level, hook_fn, private);
> > +            if (ret < 0) {
> > +                return ret;
> >              }
> >          } else {
> >              if (!entry_valid) {

[1]

> > -                trace_vtd_page_walk_skip_perm(iova, iova_next);
> > +                if (notify_unmap) {
> > +                    /*
> > +                     * The whole entry is invalid; unmap it all.
> > +                     * Translated address is meaningless, zero it.
> > +                     */
> > +                    entry.translated_addr = 0x0;
> > +                    ret = vtd_page_walk_one(&entry, level, hook_fn, private);
> > +                    if (ret < 0) {
> > +                        return ret;
> > +                    }
> > +                } else {
> > +                    trace_vtd_page_walk_skip_perm(iova, iova_next);
> > +                }
> >                  goto next;
> >              }
> >              ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, aw), iova,
> > --
> > 2.14.3
> > 
> 
> Thanks,
> Yi Liu

-- 
Peter Xu
