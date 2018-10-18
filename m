Received: from eggs.gnu.org ([2001:4830:134:3::10]:53701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gDA2c-00037h-KK
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gDA2a-0001v3-Fc
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:16:50 -0400
References: <20180921081819.9203-1-eric.auger@redhat.com>
	<A2975661238FB949B60364EF0F2C257439D32CBE@SHSMSX104.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5624f123-27fd-8392-32cf-1792b52483b5@redhat.com>
Date: Thu, 18 Oct 2018 17:16:25 +0200
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D32CBE@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 00/28] vSMMUv3/pSMMUv3 2 stage VFIO
 integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "cdall@kernel.org" <cdall@kernel.org>, "mst@redhat.com" <mst@redhat.com>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Hi Yi,

On 10/18/18 12:30 PM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Eric Auger [mailto:eric.auger@redhat.com]
>> Sent: Friday, September 21, 2018 4:18 PM
>> Subject: [RFC v2 00/28] vSMMUv3/pSMMUv3 2 stage VFIO integration
>>
>> Up to now vSMMUv3 has not been integrated with VFIO. VFIO
>> integration requires to program the physical IOMMU consistently
>> with the guest mappings. However, as opposed to VTD, SMMUv3 has
>> no "Caching Mode" which allows easy trapping of guest mappings.
>> This means the vSMMUV3 cannot use the same VFIO integration as VTD.
>>
>> However SMMUv3 has 2 translation stages. This was devised with
>> virtualization use case in mind where stage 1 is "owned" by the
>> guest whereas the host uses stage 2 for VM isolation.
>>
>> This series sets up this nested translation stage. It only works
>> if there is one physical SMMUv3 used along with QEMU vSMMUv3 (in
>> other words, it does not work if there is a physical SMMUv2).
>>
>> The series uses a new kernel user API [1], still under definition.
>>
>> - We force the host to use stage 2 instead of stage 1, when we
>>   detect a vSMMUV3 is behind a VFIO device. For a VFIO device
>>   without any virtual IOMMU, we still use stage 1 as many existing
>>   SMMUs expect this behavior.
>> - We introduce new IOTLB "config" notifiers, requested to notify
>>   changes in the config of a given iommu memory region. So now
>>   we have notifiers for IOTLB changes and config changes.
>> - vSMMUv3 calls config notifiers when STE (Stream Table Entries)
>>   are updated by the guest.
>> - We implement a specific UNMAP notifier that conveys guest
>>   IOTLB invalidations to the host
>> - We implement a new MAP notifiers only used for MSI IOVAs so
>>   that the host can build a nested stage translation for MSI IOVAs
>> - As the legacy MAP notifier is not called anymore, we must make
>>   sure stage 2 mappings are set. This is achieved through another
>>   memory listener.
>> - Physical SMMUs faults are reported to the guest via en eventfd
>>   mechanism and reinjected into this latter.
>>
>> Note: some iommu memory notifier rework related patches are close
>> to those previously published by Peter and Liu. I will be pleased to
>> add their Signed-off-by if they agree/wish.
> 
> Yeah, feel free to add mine if it's originated from our previous work.
OK
> 
> BTW. Curiously, are you planning to implement all vIOMMU related
> operations through MemoryRegion notifiers? Honestly, I did it in such
> way in early RFC for vSVA work. However, we encountered two issues
> at that time. First, how to check whether the notifier should be registered.
On my side I think I resolved this by querying the iommu mr about the
new IOMMU_ATTR_VFIO_NESTED IOMMU attribute  in vfio_connect_container

See patches 5 and 6, 8

This tells me whether the nested mode must be setup and choose the right
container->iommu_type which is then used in vfio_listener_region_add()
to decide whether the specific notifiers mustd to be registered.


> Second, there are cases in which the vfio_listener_region_add is not
> triggered but vIOMMU exists. Details can be got by the link below:
> (http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00078.html)

Yes I remember this, due to the PT=1 case. On ARM we don't have this
specificity hence this integration.
> 
> As thus, we had some discussions in community. Last time, PCIPASIDOps
> was proposed. It is to add callbacks in PCIDevice. VFIO would register its
> implementations in vfio_realize(). Supposedly, pasid_table_bind,
> page_table_bind, sva_tlb_invalidation_passdown and other vIOMMU
> related operations can be done in such way. The sample patch below
> may show how it looks like. (the full patch is in my sandbox, planned to
> send out with Scalable Mode emulation patch).

To be honest, I lost track of the series and did not see this
PCIPASIDOps proposal. I will study whether this can fit my needs.

Thank you for the link!

Best Regards

Eric
> 
> Sample patch:
> include/hw/pci/pci.h:
>  +typedef struct PCIPASIDOps PCIPASIDOps;
>  +struct PCIPASIDOps {
>  +    void (*pasid_bind_table)(PCIBus *bus, int32_t devfn,
>  +                            struct pasid_table_config *ptbl_cfg);
>  +    void (*pasid_invalidate_extend_iotlb)(PCIBus *bus, int32_t devfn,
>  +                            struct tlb_invalidate_info *inv_info);
>  +};
> 
>  @@ -350,6 +359,7 @@ struct PCIDevice {
>       MSIVectorUseNotifier msix_vector_use_notifier;
>       MSIVectorReleaseNotifier msix_vector_release_notifier;
>       MSIVectorPollNotifier msix_vector_poll_notifier;
>  +    PCIPASIDOps *pasid_ops;
>   };
> 
> hw/pci/pci.c:
> +void pci_setup_pasid_ops(PCIDevice *dev, PCIPASIDOps *ops)
>  +{
>  +    assert(ops && !dev->pasid_ops);
>  +    dev->pasid_ops = ops;
>  +}
>  +
>  +void pci_device_pasid_bind_table(PCIBus *bus, int32_t devfn,
>  +                                 struct pasid_table_config *ptbl_cfg)
>  +{
>  +    PCIDevice *dev;
>  +
>  +    if (!bus) {
>  +        return;
>  +    }
>  +
>  +    dev = bus->devices[devfn];
>  +    if (dev && dev->pasid_ops) {
>  +        dev->pasid_ops->pasid_bind_table(bus, devfn, ptbl_cfg);
>  +    }
>  +}
> 
> hw/vfio/pci.c:
> +static PCIPASIDOps vfio_pci_pasid_ops = {
>  +    .pasid_bind_table = vfio_pci_device_pasid_bind_table,
>  +    .pasid_invalidate_extend_iotlb = vfio_pci_device_pasid_invalidate_eiotlb,
>  +};
>  +
>   static void vfio_realize(PCIDevice *pdev, Error **errp)
>   {
>       VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
>  @@ -3048,6 +3068,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       vfio_register_req_notifier(vdev);
>       vfio_setup_resetfn_quirk(vdev);
> 
>  +    pci_setup_pasid_ops(pdev, &vfio_pci_pasid_ops);
>  +
>       return;
> 
> Regards,
> Yi Liu
> 
> 
