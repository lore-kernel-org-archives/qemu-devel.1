Received: from eggs.gnu.org ([2001:4830:134:3::10]:49464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cnN3l-0003g0-8Q
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cnN3g-00006Y-8n
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cnN3f-00006T-VO
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:18:32 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22AF085547
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 10:18:32 +0000 (UTC)
References: <1489375798-19518-1-git-send-email-jasowang@redhat.com>
	<1489375798-19518-2-git-send-email-jasowang@redhat.com>
	<821914c4-f97e-aae3-7408-03c9684effe7@redhat.com>
	<1c3729b4-447d-a025-c202-656076dfcf10@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <df15ef85-6a74-3a28-5e3c-cc64145410c0@redhat.com>
Date: Mon, 13 Mar 2017 12:18:24 +0200
MIME-Version: 1.0
In-Reply-To: <1c3729b4-447d-a025-c202-656076dfcf10@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] pci: introduce a bus master container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com

On 03/13/2017 11:52 AM, Paolo Bonzini wrote:
>
>
> On 13/03/2017 10:38, Marcel Apfelbaum wrote:
>> On 03/13/2017 05:29 AM, Jason Wang wrote:
>>> 96a8821d2141 ("virtio: unbreak virtio-pci with IOMMU after caching ring
>>> translations") tries to make IOMMU works with virtio memory region
>>> cache, but it requires IOMMU to be created before any virtio
>>> devices. This is sub optimal, fixing this by introduce a bus master
>>> container to make sure address space can be initialized during device
>>> registering, and then we can safely set alias and make
>>> bus_master_enable_region as its subregion during bus master
>>> initialization.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>>  hw/pci/pci.c         | 9 +++++++--
>>>  include/hw/pci/pci.h | 1 +
>>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index 273f1e4..ad46390 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -88,8 +88,8 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
>>>                               OBJECT(pci_dev), "bus master",
>>>                               dma_as->root, 0,
>>> memory_region_size(dma_as->root));
>>>      memory_region_set_enabled(&pci_dev->bus_master_enable_region,
>>> false);
>>> -    address_space_init(&pci_dev->bus_master_as,
>>> -                       &pci_dev->bus_master_enable_region,
>>> pci_dev->name);
>>> +
>>> memory_region_add_subregion(&pci_dev->bus_master_container_region, 0,
>>> +                                &pci_dev->bus_master_enable_region);
>>
>> Hi Jason,
>>
>> The patch looks good to me, I only have one question:
>> On hot-unplug, shouldn't we remove the "new" sub-region ?
>
> It should be done automatically:
>
>     /* We know the region is not visible in any address space (it
>      * does not have a container and cannot be a root either because
>      * it has no references, so we can blindly clear mr->enabled.
>      * memory_region_set_enabled instead could trigger a transaction
>      * and cause an infinite loop.
>      */
>     mr->enabled = false;
>     memory_region_transaction_begin();
>     while (!QTAILQ_EMPTY(&mr->subregions)) {
>         MemoryRegion *subregion = QTAILQ_FIRST(&mr->subregions);
>         memory_region_del_subregion(mr, subregion);
>     }
>     memory_region_transaction_commit();
>
> It's relatively new though (QEMU v2.5+).
>

Nice! Not that new, but new to me :)

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel

> Paolo
>
>> Thanks,
>> Marcel
>>
>>>  }
>>>
>>>  static void pcibus_machine_done(Notifier *notifier, void *data)
>>> @@ -995,6 +995,11 @@ static PCIDevice
>>> *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>>>      pci_dev->devfn = devfn;
>>>      pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
>>>
>>> +    memory_region_init(&pci_dev->bus_master_container_region,
>>> OBJECT(pci_dev),
>>> +                       "bus master container", UINT64_MAX);
>>> +    address_space_init(&pci_dev->bus_master_as,
>>> +                       &pci_dev->bus_master_container_region,
>>> pci_dev->name);
>>> +
>>>      if (qdev_hotplug) {
>>>          pci_init_bus_master(pci_dev);
>>>      }
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>> index 9349acb..713ede0 100644
>>> --- a/include/hw/pci/pci.h
>>> +++ b/include/hw/pci/pci.h
>>> @@ -284,6 +284,7 @@ struct PCIDevice {
>>>      char name[64];
>>>      PCIIORegion io_regions[PCI_NUM_REGIONS];
>>>      AddressSpace bus_master_as;
>>> +    MemoryRegion bus_master_container_region;
>>>      MemoryRegion bus_master_enable_region;
>>>
>>>      /* do not access the following fields */
>>>
>>
