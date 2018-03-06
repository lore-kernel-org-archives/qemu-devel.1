Received: from eggs.gnu.org ([2001:4830:134:3::10]:33880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etBQ7-0003OT-U9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etBQ3-0008Mk-U0
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:10:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etBQ3-0008MJ-NS
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:10:11 -0500
Date: Tue, 6 Mar 2018 20:09:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180306120957.GE17720@xz-mi>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-8-git-send-email-yi.l.liu@linux.intel.com>
	<20180306064436.GD3615@xz-mi>
	<A2975661238FB949B60364EF0F2C257439B87886@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257439B87886@SHSMSX104.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/12] vfio/pci: register sva notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "Tian, Kevin" <kevin.tian@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>

On Tue, Mar 06, 2018 at 08:00:41AM +0000, Liu, Yi L wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Tuesday, March 6, 2018 2:45 PM
> > Subject: Re: [PATCH v3 07/12] vfio/pci: register sva notifier
> > 
> > On Thu, Mar 01, 2018 at 06:33:30PM +0800, Liu, Yi L wrote:
> > > This patch shows how sva notifier is registered. And provided an
> > > example by registering notify func for tlb flush propagation.
> > >
> > > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > > ---
> > >  hw/vfio/pci.c | 55
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 53 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index a60a4d7..b7297cc
> > > 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -2775,6 +2775,26 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice
> > *vdev)
> > >      vdev->req_enabled = false;
> > >  }
> > >
> > > +static VFIOContainer *vfio_get_container_from_busdev(PCIBus *bus,
> > > +                                                     int32_t devfn) {
> > > +    VFIOGroup *group;
> > > +    VFIOPCIDevice *vdev_iter;
> > > +    VFIODevice *vbasedev_iter;
> > > +    PCIDevice *pdev_iter;
> > > +
> > > +    QLIST_FOREACH(group, &vfio_group_list, next) {
> > > +        QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
> > > +            vdev_iter = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
> > > +            pdev_iter = &vdev_iter->pdev;
> > > +            if (pci_get_bus(pdev_iter) == bus && pdev_iter->devfn == devfn) {
> > > +                return group->container;
> > > +            }
> > > +        }
> > > +    }
> > > +    return NULL;
> > > +}
> > > +
> > >  static void vfio_pci_device_sva_bind_pasid_table(PCIBus *bus,
> > >                   int32_t devfn, uint64_t pasidt_addr, uint32_t size)
> > > { @@ -2783,11 +2803,42 @@ static void
> > > vfio_pci_device_sva_bind_pasid_table(PCIBus *bus,
> > >      So far, Intel VT-d and AMD IOMMU requires it. */  }
> > >
> > > +static void vfio_iommu_sva_tlb_invalidate_notify(IOMMUSVANotifier *n,
> > > +                                                 IOMMUSVAEventData
> > > +*event_data) {
> > > +/*  Sample code, would be detailed in coming virt-SVA patchset.
> > > +    VFIOGuestIOMMUSVAContext *gsva_ctx;
> > > +    IOMMUSVAContext *sva_ctx;
> > > +    VFIOContainer *container;
> > > +
> > > +    gsva_ctx = container_of(n, VFIOGuestIOMMUSVAContext, n);
> > > +    container = gsva_ctx->container;
> > > +
> > > +    TODO: forward to host through VFIO IOCTL
> > 
> > IMHO if the series is not ready for merging, we can still mark it as RFC and declare
> > that so people won't need to go into details of the patches.
> 
> Thanks for the suggestion. Actually, I was hesitating it. As you may know, this is actually
> 3rd version of this effort. But yes, I would follow your suggestion in coming versions.

Yeah, it's a long way even since the first version of the work.
However IMHO it's not about which version are you working with, it's
about whether you think it's a complete work and ready to be merged.
IMHO if you are very sure it's not good for merging, we should better
provide the RFC tag, or mention that in the cover letter.  So firstly
the maintainer won't accidentaly merge your series; meanwhile
reviewers will know the state of series so they can decide on which
aspect they'll focus on during the review.

> 
> > > +*/
> > > +}
> > > +
> > >  static void vfio_pci_device_sva_register_notifier(PCIBus *bus,
> > >                            int32_t devfn, IOMMUSVAContext *sva_ctx)  {
> > > -    /* Register notifier for TLB invalidation propagation
> > > -       */
> > > +    VFIOContainer *container = vfio_get_container_from_busdev(bus,
> > > + devfn);
> > > +
> > > +    if (container != NULL) {
> > > +        VFIOGuestIOMMUSVAContext *gsva_ctx;
> > > +        gsva_ctx = g_malloc0(sizeof(*gsva_ctx));
> > > +        gsva_ctx->sva_ctx = sva_ctx;
> > > +        gsva_ctx->container = container;
> > > +        QLIST_INSERT_HEAD(&container->gsva_ctx_list,
> > > +                          gsva_ctx,
> > > +                          gsva_ctx_next);
> > > +       /* Register vfio_iommu_sva_tlb_invalidate_notify with event flag
> > > +           IOMMU_SVA_EVENT_TLB_INV */
> > > +        iommu_sva_notifier_register(sva_ctx,
> > > +                                    &gsva_ctx->n,
> > > +                                    vfio_iommu_sva_tlb_invalidate_notify,
> > > +                                    IOMMU_SVA_EVENT_TLB_INV);
> > 
> > I would squash this patch into previous one since basically this is only part of the
> > implementation to provide vfio-speicific register hook.
> 
> sure.
> 
> > But a more important question is... why this?
> > 
> > IMHO the notifier registration can be general for PCI.  Why vfio needs to provide it's
> > own register callback?  Would it be enough if it only provides its own notify callback?
> 
> The notifiers are in VFIO. However, the registration is controlled by vIOMMU emulator.
> In this series, PASID tagged Address Space is introduced. And the new notifiers are for
> such Address Space. Such Address Space is created and deleted in vIOMMU emulator.
> So the notifier registration needs to happen accordingly.
> 
> e.g. guest SVM application bind a device to a process, it programs the guest iommu
> translation structure, vIOMMU emulator captures the change, and create a PASID
> tagged Address Space for it and register notifiers.
> 
> That's why I do it in such a manner.

I agree that the things are mostly managed by vIOMMU, but I still
cannot understand why vfio must have its own register hook.

Let me try to explain a bit more on my question.  Basically I was
asking about whether we can removet the register/unregister hook in
the SVAOps, instead we can have something like (I'll start to use
pasid as prefix):

struct PCIPASIDOps {
    void (*pasid_bind_table)(PCIBus *bus, int32_t devfn, ...);
    void (*pasid_invalidate_extend_iotlb)(PCIBus *bus, int32_t devfn, ...)
};

Firstly we keep the bind_table operation, but instead of the reg/unreg
we only provide a hook that device can override to listen to extend
iotlb invalidations.

IMHO my understanding is that the vIOMMU should be able to even hide
the detailed PASID information here, and only call the
pasid_invalidate_extend_iotlb() if the device gets extended-iotlb
invalidations (then it passes it down to host IOMMU, with the same
information like domain ID, PASID, granularity).

Would that work?

-- 
Peter Xu
