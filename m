Received: from eggs.gnu.org ([2001:4830:134:3::10]:56678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etB0t-0001Bo-7z
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etB0m-0008HF-Rr
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:44:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etB0m-0008Gy-M8
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:44:04 -0500
Date: Tue, 6 Mar 2018 19:43:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180306114353.GD17720@xz-mi>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-13-git-send-email-yi.l.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519900415-30314-13-git-send-email-yi.l.liu@linux.intel.com>
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
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, kevin.tian@intel.com, jasowang@redhat.com

On Thu, Mar 01, 2018 at 06:33:35PM +0800, Liu, Yi L wrote:
> This patch shows the idea of how a device is binded to a PASID tagged
> AddressSpace.
> 
> when Intel vIOMMU emulator detected a pasid table entry programming
> from guest. Intel vIOMMU emulator firstly finds a VTDPASIDAddressSpace
> with the pasid field of pasid cache invalidate request.
> 
> * If it is to bind a device to a guest process, needs add the device
>   to the device list behind the VTDPASIDAddressSpace. And if the device
>   is assigned device, need to register sva_notfier for future tlb
>   flushing if any mapping changed to the process address space.
> 
> * If it is to unbind a device from a guest process, then need to remove
>   the device from the device list behind the VTDPASIDAddressSpace.
>   And also needs to unregister the sva_notfier if the device is assigned
>   device.
> 
> This patch hasn't added the unbind logic. It depends on guest pasid
> table entry parsing which requires further emulation. Here just want
> to show the idea for the PASID tagged AddressSpace management framework.
> Full unregister logic would be included in future virt-SVA patchset.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  hw/i386/intel_iommu.c          | 119 +++++++++++++++++++++++++++++++++++++++++
>  hw/i386/intel_iommu_internal.h |  10 ++++
>  2 files changed, 129 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b8e8dbb..ed07035 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1801,6 +1801,118 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>      return true;
>  }
>  
> +static VTDPASIDAddressSpace *vtd_get_pasid_as(IntelIOMMUState *s,
> +                                              uint32_t pasid)
> +{
> +    VTDPASIDAddressSpace *vtd_pasid_as = NULL;
> +    IntelPASIDNode *node;
> +    char name[128];
> +
> +    QLIST_FOREACH(node, &(s->pasid_as_list), next) {
> +        vtd_pasid_as = node->pasid_as;
> +        if (pasid == vtd_pasid_as->sva_ctx.pasid) {
> +            return vtd_pasid_as;
> +        }
> +    }

This seems to be a per-iommu pasid table.  However from the spec it
looks more like that should be per-domain (I'm seeing figure 3-8).
For example, each domain should be able to have its own pasid table.
Then IIUC a pasid context will need a (domain, pasid) tuple to
identify, not only the pasid itself?

And, do we need to destroy the pasid context after it's freed by the
guest?  Here it seems that we'll cache it forever.

> +
> +    vtd_pasid_as = g_malloc0(sizeof(*vtd_pasid_as));
> +    vtd_pasid_as->iommu_state = s;
> +    snprintf(name, sizeof(name), "intel_iommu_pasid_%d", pasid);
> +    address_space_init(&vtd_pasid_as->as, NULL, "pasid");

I saw that this is only inited and never used.  Could I ask when this
will be used?

> +    QLIST_INIT(&vtd_pasid_as->device_list);
> +
> +    node = g_malloc0(sizeof(*node));
> +    node->pasid_as = vtd_pasid_as;
> +    QLIST_INSERT_HEAD(&s->pasid_as_list, node, next);
> +
> +    return vtd_pasid_as;
> +}
> +
> +static void vtd_bind_device_to_pasid_as(VTDPASIDAddressSpace *vtd_pasid_as,
> +                                        PCIBus *bus, uint8_t devfn)
> +{
> +    VTDDeviceNode *node = NULL;
> +
> +    QLIST_FOREACH(node, &(vtd_pasid_as->device_list), next) {
> +        if (node->bus == bus && node->devfn == devfn) {
> +            return;
> +        }
> +    }
> +
> +    node = g_malloc0(sizeof(*node));
> +    node->bus = bus;
> +    node->devfn = devfn;
> +    QLIST_INSERT_HEAD(&(vtd_pasid_as->device_list), node, next);

So here I have the same confusion - IIUC according to the spec two
devices can have differnet pasid tables, however they can be sharing
the same PASID number (e.g., pasid=1) in the table.  Here since
vtd_pasid_as is only per-IOMMU, could it possible that we put multiple
devices under same PASID context while actually they are not sharing
the same process page table?  Problematic?

Please correct me if needed.

> +
> +    pci_device_sva_register_notifier(bus, devfn, &vtd_pasid_as->sva_ctx);
> +
> +    return;
> +}
> +
> +static bool vtd_process_pc_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
> +{
> +
> +    IntelIOMMUAssignedDeviceNode *node = NULL;
> +    int ret = 0;
> +
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +    VTDPASIDAddressSpace *vtd_pasid_as;
> +
> +    if ((inv_desc->lo & VTD_INV_DESC_PASIDC_RSVD_LO) ||
> +        (inv_desc->hi & VTD_INV_DESC_PASIDC_RSVD_HI)) {
> +        return false;
> +    }
> +
> +    domain_id = VTD_INV_DESC_PASIDC_DID(inv_desc->lo);
> +
> +    switch (inv_desc->lo & VTD_INV_DESC_PASIDC_G) {
> +    case VTD_INV_DESC_PASIDC_ALL_ALL:
> +        /* TODO: invalidate all pasid related cache */

I think it's fine as RFC, but we'd better have this in the final
version?

IIUC you'll need caching-mode too for virt-sva, and here you'll
possibly need to walk and scan every context entry that has the same
domain ID specified in the invalidation request.  Maybe further you'll
need to scan the pasid entries too, register notifiers when needed.

Thanks,

> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_PASID_SI:
> +        pasid = VTD_INV_DESC_PASIDC_PASID(inv_desc->lo);
> +        vtd_pasid_as = vtd_get_pasid_as(s, pasid);
> +        QLIST_FOREACH(node, &(s->assigned_device_list), next) {
> +            VTDAddressSpace *vtd_as = node->vtd_as;
> +            VTDContextEntry ce;
> +            uint16_t did;
> +            uint8_t bus = pci_bus_num(vtd_as->bus);
> +            ret = vtd_dev_to_context_entry(s, bus,
> +                                   vtd_as->devfn, &ce);
> +            if (ret != 0) {
> +                continue;
> +            }
> +
> +            did = VTD_CONTEXT_ENTRY_DID(ce.hi);
> +            /*
> +             * If did field equals to the domain_id field of inv_descriptor,
> +             * then the device is affect by this invalidate request, need to
> +             * bind or unbind the device to the pasid tagged address space.
> +             * a) If it is bind, need to add the device to the device list,
> +             *    add register tlb flush notifier for it
> +             * b) If it is unbind, need to remove the device from the device
> +             *    list, and unregister the tlb flush notifier
> +             * TODO: add unbind logic accordingly, depends on the parsing of
> +             *       guest pasid table entry pasrsing, here has no parsing to
> +             *       pasid table entry.
> +             *
> +             */
> +            if (did == domain_id) {
> +                vtd_bind_device_to_pasid_as(vtd_pasid_as,
> +                                  vtd_as->bus, vtd_as->devfn);
> +            }
> +        }
> +        break;
> +
> +    default:
> +        return false;
> +    }
> +
> +    return true;
> +}
> +

-- 
Peter Xu
