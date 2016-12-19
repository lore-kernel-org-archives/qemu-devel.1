Received: from eggs.gnu.org ([2001:4830:134:3::10]:43696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIukh-00076N-MF
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 05:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIuke-0004vA-LI
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 05:01:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cIuke-0004uN-E4
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 05:01:00 -0500
Date: Mon, 19 Dec 2016 18:00:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161219100053.GD4155@pxdev.xzpeter.org>
References: <A2975661238FB949B60364EF0F2C257438FD8042@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257438FD8042@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/5] IOMMU: enable intel_iommu map and
 unmap notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "bd.aviv@gmail.com" <bd.aviv@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, ", Jan Kiszka" <jan.kiszka@siemens.com>, ", Alex Williamson" <alex.williamson@redhat.com>, ", Jason Wang" <jasowang@redhat.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>

On Fri, Dec 16, 2016 at 09:12:05AM +0000, Liu, Yi L wrote:
> > From: "Aviv Ben-David" <address@hidden>
> > 
> > Adds a list of registered vtd_as's to intel iommu state to save
> > iteration over each PCI device in a search of the corrosponding domain.
> > 
> > Signed-off-by: Aviv Ben-David <address@hidden>
> > ---
> >  hw/i386/intel_iommu.c          | 94 ++++++++++++++++++++++++++++++++++++++----
> >  hw/i386/intel_iommu_internal.h |  2 +
> >  include/hw/i386/intel_iommu.h  |  9 ++++
> >  3 files changed, 98 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 05973b9..d872969 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -679,7 +679,7 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t 
> > gpa,
> >          }
> >          *reads = (*reads) && (slpte & VTD_SL_R);
> >          *writes = (*writes) && (slpte & VTD_SL_W);
> > -        if (!(slpte & access_right_check)) {
> > +        if (!(slpte & access_right_check) && !(flags & IOMMU_NO_FAIL)) {
> >              VTD_DPRINTF(GENERAL, "error: lack of %s permission for "
> >                          "gpa 0x%"PRIx64 " slpte 0x%"PRIx64,
> >                          (flags & IOMMU_WO ? "write" : "read"), gpa, slpte);
> > @@ -978,6 +978,23 @@ static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState 
> > *s, uint8_t bus_num)
> >      return vtd_bus;
> >  }
> >  
> > +static int vtd_get_did_dev(IntelIOMMUState *s, uint8_t bus_num, uint8_t devfn,
> > +                           uint16_t *domain_id)
> > +{
> > +    VTDContextEntry ce;
> > +    int ret_fr;
> > +
> > +    assert(domain_id);
> > +
> > +    ret_fr = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
> > +    if (ret_fr) {
> > +        return -1;
> > +    }
> > +
> > +    *domain_id =  VTD_CONTEXT_ENTRY_DID(ce.hi);
> > +    return 0;
> > +}
> > +
> >  /* Do a context-cache device-selective invalidation.
> >   * @func_mask: FM field after shifting
> >   */
> > @@ -1064,6 +1081,45 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState 
> > *s, uint16_t domain_id)
> >                                  &domain_id);
> >  }
> >  
> > +static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
> > +                                           uint16_t domain_id, hwaddr addr,
> > +                                           uint8_t am)
> > +{
> > +    IntelIOMMUNotifierNode *node;
> > +
> > +    QLIST_FOREACH(node, &(s->notifiers_list), next) {
> Aviv,
> 
> Regards to the s->notifiers_list, I didn't see the init op to it. Does it happen
> in another patch? If so, it may be better to move it in this patch since this 
> patch introduces both the definition and usage of notifiers_list.
> 
> If it is already clarified, then ignore it.

I think it was missing. It IMHO accidentally worked since QLIST_INIT()
just set the head to NULL and that's what we did when we create the
IntelIOMMUState object.

And what's worse - I found this approach may not work if we do
QLIST_INSERT() in the changed() hook, since if we have more than one
assigned devices we will only register the first one not the rest. A
better approach may be traversing the vt-d buses via
IntelIOMMUState.vtd_as_by_busptr.

Thanks,

-- peterx
