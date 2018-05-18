Received: from eggs.gnu.org ([2001:4830:134:3::10]:58027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJYKT-0000J0-Js
	for qemu-devel@nongnu.org; Fri, 18 May 2018 01:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJYKO-0000MR-Nb
	for qemu-devel@nongnu.org; Fri, 18 May 2018 01:53:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35266 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJYKO-0000M3-Hm
	for qemu-devel@nongnu.org; Fri, 18 May 2018 01:53:20 -0400
Date: Fri, 18 May 2018 13:53:07 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180518055307.GD2569@xz-mi>
References: <20180504030811.28111-1-peterx@redhat.com>
	<20180504030811.28111-5-peterx@redhat.com>
	<5f5b6f33-12fc-1bd1-a60f-035196270b23@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f5b6f33-12fc-1bd1-a60f-035196270b23@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/10] intel-iommu: only do page walk
 for MAP notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On Thu, May 17, 2018 at 03:39:50PM +0200, Auger Eric wrote:
> Hi Peter,
> 
> On 05/04/2018 05:08 AM, Peter Xu wrote:
> > For UNMAP-only IOMMU notifiers, we don't really need to walk the page
> s/really// ;-)

Ok.

> > tables.  Fasten that procedure by skipping the page table walk.  That
> > should boost performance for UNMAP-only notifiers like vhost.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/hw/i386/intel_iommu.h |  2 ++
> >  hw/i386/intel_iommu.c         | 43 +++++++++++++++++++++++++++++++----
> >  2 files changed, 40 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> > index ee517704e7..9e0a6c1c6a 100644
> > --- a/include/hw/i386/intel_iommu.h
> > +++ b/include/hw/i386/intel_iommu.h
> > @@ -93,6 +93,8 @@ struct VTDAddressSpace {
> >      IntelIOMMUState *iommu_state;
> >      VTDContextCacheEntry context_cache_entry;
> >      QLIST_ENTRY(VTDAddressSpace) next;
> > +    /* Superset of notifier flags that this address space has */
> > +    IOMMUNotifierFlag notifier_flags;
> >  };
> >  
> >  struct VTDBus {
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 112971638d..9a418abfb6 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -138,6 +138,12 @@ static inline void vtd_iommu_unlock(IntelIOMMUState *s)
> >      qemu_mutex_unlock(&s->iommu_lock);
> >  }
> >  
> > +/* Whether the address space needs to notify new mappings */
> > +static inline gboolean vtd_as_notify_mappings(VTDAddressSpace *as)
> would suggest vtd_as_has_map_notifier()? But tastes & colours ;-)

Yeah it is.  But okay, I can switch to that especially it's only used
in this patch and it's new.

> > +{
> > +    return as->notifier_flags & IOMMU_NOTIFIER_MAP;
> > +}
> > +
> >  /* GHashTable functions */
> >  static gboolean vtd_uint64_equal(gconstpointer v1, gconstpointer v2)
> >  {
> > @@ -1433,14 +1439,35 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
> >      VTDAddressSpace *vtd_as;
> >      VTDContextEntry ce;
> >      int ret;
> > +    hwaddr size = (1 << am) * VTD_PAGE_SIZE;
> >  
> >      QLIST_FOREACH(vtd_as, &(s->notifiers_list), next) {
> >          ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> >                                         vtd_as->devfn, &ce);
> >          if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
> > -            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SIZE,
> > -                          vtd_page_invalidate_notify_hook,
> > -                          (void *)&vtd_as->iommu, true, s->aw_bits);
> > +            if (vtd_as_notify_mappings(vtd_as)) {
> > +                /*
> > +                 * For MAP-inclusive notifiers, we need to walk the
> > +                 * page table to sync the shadow page table.
> > +                 */
> Potentially we may have several notifiers attached to the IOMMU MR ~
> vtd_as, each of them having different flags. Those flags are OR'ed in
> memory_region_update_iommu_notify_flags and this is the one you now
> store in the vtd_as. So maybe your comment may rather state:
> as soon as we have at least one MAP notifier, we need to do the PTW?

Actually this is not 100% clear too, since all the "MAP notifiers" are
actually both MAP+UNMAP notifiers...  Maybe:

  As long as we have MAP notifications registered in any of our IOMMU
  notifiers, we need to sync the shadow page table.

> 
> nit: not related to this patch: vtd_page_walk kerneldoc comments misses
> @notify_unmap param comment
> side note: the name of the hook is a bit misleading as it suggests we
> invalidate the entry, whereas we update any valid entry and invalidate
> stale ones (if notify_unmap=true)?
> > +                vtd_page_walk(&ce, addr, addr + size,
> > +                              vtd_page_invalidate_notify_hook,
> > +                              (void *)&vtd_as->iommu, true, s->aw_bits);
> > +            } else {
> > +                /*
> > +                 * For UNMAP-only notifiers, we don't need to walk the
> > +                 * page tables.  We just deliver the PSI down to
> > +                 * invalidate caches.
> 
> We just unmap the range?

Isn't it the same thing? :)

If to be explicit, here we know we only registered UNMAP
notifications, it's not really "unmap", it's really cache
invalidations only.

> > +                 */
> > +                IOMMUTLBEntry entry = {
> > +                    .target_as = &address_space_memory,
> > +                    .iova = addr,
> > +                    .translated_addr = 0,
> > +                    .addr_mask = size - 1,
> > +                    .perm = IOMMU_NONE,
> > +                };
> > +                memory_region_notify_iommu(&vtd_as->iommu, entry);
> > +            }
> >          }
> >      }
> >  }
> > @@ -2380,6 +2407,9 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
> >          exit(1);
> >      }
> >  
> > +    /* Update per-address-space notifier flags */
> > +    vtd_as->notifier_flags = new;
> > +
> >      if (old == IOMMU_NOTIFIER_NONE) {
> >          /* Insert new ones */
> >          QLIST_INSERT_HEAD(&s->notifiers_list, vtd_as, next);
> > @@ -2890,8 +2920,11 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
> >                                    PCI_FUNC(vtd_as->devfn),
> >                                    VTD_CONTEXT_ENTRY_DID(ce.hi),
> >                                    ce.hi, ce.lo);
> > -        vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false,
> > -                      s->aw_bits);
> > +        if (vtd_as_notify_mappings(vtd_as)) {
> > +            /* This is required only for MAP typed notifiers */
> > +            vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false,
> > +                          s->aw_bits);
> > +        }
> >      } else {
> >          trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
> >                                      PCI_FUNC(vtd_as->devfn));
> > 
> A worthwhile improvement indeed!

I hope so. :) Thanks,

-- 
Peter Xu
