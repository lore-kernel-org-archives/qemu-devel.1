Received: from eggs.gnu.org ([2001:4830:134:3::10]:58557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euCw9-0007N1-1F
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 02:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euCw4-0005AH-8H
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 02:59:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37762 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euCw4-0005AC-1H
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 02:59:28 -0500
Date: Fri, 9 Mar 2018 15:59:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180309075901.GJ32252@xz-mi>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-13-git-send-email-yi.l.liu@linux.intel.com>
	<20180306114353.GD17720@xz-mi>
	<A2975661238FB949B60364EF0F2C257439B8A933@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257439B8A933@SHSMSX104.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 12/12] intel_iommu: bind device to PASID
 tagged AddressSpace
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

On Thu, Mar 08, 2018 at 09:39:18AM +0000, Liu, Yi L wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Tuesday, March 6, 2018 7:44 PM
> > Subject: Re: [PATCH v3 12/12] intel_iommu: bind device to PASID tagged
> > AddressSpace
> > 
> > On Thu, Mar 01, 2018 at 06:33:35PM +0800, Liu, Yi L wrote:
> > > This patch shows the idea of how a device is binded to a PASID tagged
> > > AddressSpace.
> > >
> > > when Intel vIOMMU emulator detected a pasid table entry programming
> > > from guest. Intel vIOMMU emulator firstly finds a VTDPASIDAddressSpace
> > > with the pasid field of pasid cache invalidate request.
> > >
> > > * If it is to bind a device to a guest process, needs add the device
> > >   to the device list behind the VTDPASIDAddressSpace. And if the device
> > >   is assigned device, need to register sva_notfier for future tlb
> > >   flushing if any mapping changed to the process address space.
> > >
> > > * If it is to unbind a device from a guest process, then need to remove
> > >   the device from the device list behind the VTDPASIDAddressSpace.
> > >   And also needs to unregister the sva_notfier if the device is assigned
> > >   device.
> > >
> > > This patch hasn't added the unbind logic. It depends on guest pasid
> > > table entry parsing which requires further emulation. Here just want
> > > to show the idea for the PASID tagged AddressSpace management framework.
> > > Full unregister logic would be included in future virt-SVA patchset.
> > >
> > > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > > ---
> > >  hw/i386/intel_iommu.c          | 119
> > +++++++++++++++++++++++++++++++++++++++++
> > >  hw/i386/intel_iommu_internal.h |  10 ++++
> > >  2 files changed, 129 insertions(+)
> > >
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index b8e8dbb..ed07035 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -1801,6 +1801,118 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState
> > *s, VTDInvDesc *inv_desc)
> > >      return true;
> > >  }
> > >
> > > +static VTDPASIDAddressSpace *vtd_get_pasid_as(IntelIOMMUState *s,
> > > +                                              uint32_t pasid)
> > > +{
> > > +    VTDPASIDAddressSpace *vtd_pasid_as = NULL;
> > > +    IntelPASIDNode *node;
> > > +    char name[128];
> > > +
> > > +    QLIST_FOREACH(node, &(s->pasid_as_list), next) {
> > > +        vtd_pasid_as = node->pasid_as;
> > > +        if (pasid == vtd_pasid_as->sva_ctx.pasid) {
> > > +            return vtd_pasid_as;
> > > +        }
> > > +    }
> > 
> > This seems to be a per-iommu pasid table.  However from the spec it
> > looks more like that should be per-domain (I'm seeing figure 3-8).
> > For example, each domain should be able to have its own pasid table.
> > Then IIUC a pasid context will need a (domain, pasid) tuple to
> > identify, not only the pasid itself?
> 
> Yes, this is a per-iommu table here. Actually, how we assemble the
> table here depends on the PASID namespace. You may refer to the
> iommu driver code. intel-svm.c, it's actually per-iommu.
> 
> 		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
> 		ret = idr_alloc(&iommu->pasid_idr, svm,
> 				!!cap_caching_mode(iommu->cap),
> 				pasid_max - 1, GFP_KERNEL);

Thanks for the pointer.

However from the spec, I see that PASID table pointer is per-context,
IMHO which means that the spec will allow the PASID table to be
different from one device to another.  Even if current Linux is
sharing a single PASID table now, I don't know whether that can be
expanded in the future.  Also, what if we run a guest with another OS
besides Linux?

After all we are emulating the device, so IIUC the only thing we
should follow is the spec.

> 
> > 
> > And, do we need to destroy the pasid context after it's freed by the
> > guest?  Here it seems that we'll cache it forever.
> 
> If we need to do it. A PASID can be bind to multiple devices. If there
> is no device binding on it, then needs to destroy it. This may be done
> by refcount. As I mentioned in the description, that requires further
> vIOMMU emulation, so I didn't include it. But it should be covered
> in final version. Good catch.
> 
> > 
> > > +
> > > +    vtd_pasid_as = g_malloc0(sizeof(*vtd_pasid_as));
> > > +    vtd_pasid_as->iommu_state = s;
> > > +    snprintf(name, sizeof(name), "intel_iommu_pasid_%d", pasid);
> > > +    address_space_init(&vtd_pasid_as->as, NULL, "pasid");
> > 
> > I saw that this is only inited and never used.  Could I ask when this
> > will be used?
> 
> AddressSpace is actually introduced for future support of emulated
> SVA capable devices and possible 1st level paging shadowing(similar
> to the 2nd level page table shadowing you upstreamed).

I am not sure whether that can be useful even if there will be such a
device.  The reason is that if you see current with-IOMMU guests, they
are actually "somehow" bypassing the address space framework by
calling the IOMMU MR's translate() to do the page walking. If there
will be an emulated device that (for example) supports PASID, and with
the 1st page table enabled, I think it'll also work naturally with
current translate() interface, just that in the VT-d code we'll find
that we'll need to walk a process page table this time rather than the
IOMMU device page table.

And no matter what, I would prefer you drop this address space until
it'll be firstly used.

> 
> > 
> > > +    QLIST_INIT(&vtd_pasid_as->device_list);
> > > +
> > > +    node = g_malloc0(sizeof(*node));
> > > +    node->pasid_as = vtd_pasid_as;
> > > +    QLIST_INSERT_HEAD(&s->pasid_as_list, node, next);
> > > +
> > > +    return vtd_pasid_as;
> > > +}
> > > +
> > > +static void vtd_bind_device_to_pasid_as(VTDPASIDAddressSpace *vtd_pasid_as,
> > > +                                        PCIBus *bus, uint8_t devfn)
> > > +{
> > > +    VTDDeviceNode *node = NULL;
> > > +
> > > +    QLIST_FOREACH(node, &(vtd_pasid_as->device_list), next) {
> > > +        if (node->bus == bus && node->devfn == devfn) {
> > > +            return;
> > > +        }
> > > +    }
> > > +
> > > +    node = g_malloc0(sizeof(*node));
> > > +    node->bus = bus;
> > > +    node->devfn = devfn;
> > > +    QLIST_INSERT_HEAD(&(vtd_pasid_as->device_list), node, next);
> > 
> > So here I have the same confusion - IIUC according to the spec two
> > devices can have differnet pasid tables, however they can be sharing
> > the same PASID number (e.g., pasid=1) in the table.  
> 
> Do you mean the pasid table in iommu driver? I can not say it is impossible,
> but you may notice that in current iommu driver, the devices behind a single
> iommu unit shared pasid table.
> 
> > Here since
> > vtd_pasid_as is only per-IOMMU, could it possible that we put multiple
> > devices under same PASID context while actually they are not sharing
> > the same process page table?  Problematic?
> 
> You are correct, two devices may under same PASID context. For the case
> you described, I don't think it is allowed as it breaks the PASID concept.
> Software should avoid it.

Yeh, so here my question would be the same as above: is it following
the spec that all devices _must_ share a PASID table between devices,
or it is just that we _can_ share it as a first version of Linux SVA
implementation?

Thanks,

-- 
Peter Xu
