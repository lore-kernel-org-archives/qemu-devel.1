Received: from eggs.gnu.org ([2001:4830:134:3::10]:58052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9Oj5-00052G-Jv
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9Ogi-0001ob-LG
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:06:43 -0400
Date: Mon, 8 Oct 2018 14:06:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181008060620.GF18728@xz-x1>
References: <20180913075517.11140-1-peterx@redhat.com>
	<e7cc5dbe-d577-2b41-517d-0d32e9d6ebd7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7cc5dbe-d577-2b41-517d-0d32e9d6ebd7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: handle invalid ce for shadow
 sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Pei Zhang <pezhang@redhat.com>

On Mon, Oct 08, 2018 at 11:08:31AM +0800, Jason Wang wrote:

[...]

> > +static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
> > +{
> >       int ret;
> > +    VTDContextEntry ce;
> > +    IOMMUNotifier *n;
> > -    if (ce) {
> > -        /* If the caller provided context entry, use it */
> > -        ce_cache = *ce;
> > -    } else {
> > -        /* If the caller didn't provide ce, try to fetch */
> > -        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> > -                                       vtd_as->devfn, &ce_cache);
> > -        if (ret) {
> > +    ret = vtd_dev_to_context_entry(vtd_as->iommu_state,
> > +                                   pci_bus_num(vtd_as->bus),
> > +                                   vtd_as->devfn, &ce);
> > +    if (ret) {
> > +        if (ret == -VTD_FR_CONTEXT_ENTRY_P) {
> > +            /*
> > +             * It's a valid scenario to have a context entry that is
> > +             * not present.  For example, when a device is removed
> > +             * from an existing domain then the context entry will be
> > +             * zeroed by the guest before it was put into another
> > +             * domain.  When this happens, instead of synchronizing
> > +             * the shadow pages we should invalidate all existing
> > +             * mappings and notify the backends.
> > +             */
> > +            IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
> > +                vtd_address_space_unmap(vtd_as, n);
> > +            }
> > +        } else {
> >               /*
> >                * This should not really happen, but in case it happens,
> >                * we just skip the sync for this time.  After all we even
> >                * don't have the root table pointer!
> >                */
> 
> It looks to me the comment is not accurate, no root pointer is not the only
> reason for the failure of vtd_dev_to_context_entry().
> 
> >               error_report_once("%s: invalid context entry for bus 0x%x"
> > -                              " devfn 0x%x",
> > -                              __func__, pci_bus_num(vtd_as->bus),
> > -                              vtd_as->devfn);
> > -            return 0;
> 
> I'm not quite sure error_report_once() is really needed here since all
> failures has been traced.

True; I'll then consider have all of them to be error_report_once()
and drop the one here.

> 
> > +                              " devfn 0x%x", __func__,
> > +                              pci_bus_num(vtd_as->bus), vtd_as->devfn);
> >           }
> > +        return 0;
> >       }
> > -    info.domain_id = VTD_CONTEXT_ENTRY_DID(ce_cache.hi);
> > -
> > -    return vtd_page_walk(&ce_cache, addr, addr + size, &info);
> > -}
> > -
> > -static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
> > -{
> > -    return vtd_sync_shadow_page_table_range(vtd_as, NULL, 0, UINT64_MAX);
> > +    return vtd_sync_shadow_page_table_range(vtd_as, &ce, 0, UINT64_MAX);
> >   }
> 
> As has been discussed, this will left addr UINT64_MAX, it's better to have
> [start, end] instead of (start, range).

Hmm, this size is inclusive, so we should be fine.  Though I'll take
your advise to use start/end pair to be clearer.

Thanks!

-- 
Peter Xu
