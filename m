Received: from eggs.gnu.org ([2001:4830:134:3::10]:55143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1clWty-0005SM-R3
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1clWtu-0005eB-Ro
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:24:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1clWtu-0005e4-JA
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:24:50 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CDDA4E02A
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 08:24:50 +0000 (UTC)
References: <1488877751-13419-1-git-send-email-jasowang@redhat.com>
	<7594c183-6d38-3dce-75e7-62bf3be324fc@redhat.com>
	<20170308024349.GC31585@pxdev.xzpeter.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <7da60742-566c-a1dc-0cc1-f510b6b99d5d@redhat.com>
Date: Wed, 8 Mar 2017 10:24:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170308024349.GC31585@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3] virtio: do not require IOMMU to be
 created in advance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 03/08/2017 04:43 AM, Peter Xu wrote:
> On Tue, Mar 07, 2017 at 02:47:30PM +0200, Marcel Apfelbaum wrote:
>> On 03/07/2017 11:09 AM, Jason Wang wrote:
>>> After commit 96a8821d2141 ("virtio: unbreak virtio-pci with IOMMU
>>> after caching ring translations"), IOMMU was required to be created in
>>> advance. This is because we can only get the correct dma_as after pci
>>> IOMMU (e.g intel_iommu) was initialized. This is suboptimal and
>>> inconvenient for user. This patch releases this by:
>>>
>>> - introduce a bus_master_ready method for PCIDeviceClass and trigger
>>>  this during pci_init_bus_master
>>> - implement virtio-pci method and 1) reset the dma_as 2) re-register
>>>  the memory listener to the new dma_as
>>>
>>
>> Hi Jason,
>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>> Changes from V2:
>>> - delay pci_init_bus_master() after pci device is realized to make
>>>  bus_master_ready a more generic method
>>> ---
>>> hw/pci/pci.c               | 11 ++++++++---
>>> hw/virtio/virtio-pci.c     |  9 +++++++++
>>> hw/virtio/virtio.c         | 19 +++++++++++++++++++
>>> include/hw/pci/pci.h       |  1 +
>>> include/hw/virtio/virtio.h |  1 +
>>> 5 files changed, 38 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index 273f1e4..22e6ad9 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -83,6 +83,7 @@ static const VMStateDescription vmstate_pcibus = {
>>> static void pci_init_bus_master(PCIDevice *pci_dev)
>>> {
>>>     AddressSpace *dma_as = pci_device_iommu_address_space(pci_dev);
>>> +    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
>>>
>>>     memory_region_init_alias(&pci_dev->bus_master_enable_region,
>>>                              OBJECT(pci_dev), "bus master",
>>> @@ -90,6 +91,9 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
>>>     memory_region_set_enabled(&pci_dev->bus_master_enable_region, false);
>>>     address_space_init(&pci_dev->bus_master_as,
>>>                        &pci_dev->bus_master_enable_region, pci_dev->name);
>>> +    if (pc->bus_master_ready) {
>>> +        pc->bus_master_ready(pci_dev);
>>> +    }
>>> }
>>>
>>> static void pcibus_machine_done(Notifier *notifier, void *data)
>>> @@ -995,9 +999,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>>>     pci_dev->devfn = devfn;
>>>     pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
>>>
>>> -    if (qdev_hotplug) {
>>> -        pci_init_bus_master(pci_dev);
>>> -    }
>>>     pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>>>     pci_dev->irq_state = 0;
>>>     pci_config_alloc(pci_dev);
>>> @@ -1995,6 +1996,10 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>>         }
>>>     }
>>>
>>> +    if (qdev_hotplug) {
>>> +        pci_init_bus_master(pci_dev);
>>> +    }
>>> +
>>
>> How does it help if we move qdev_hotplug check outside "do_pci_register_device"?
>> I suppose you want the code to run after the "realize" function?
>> If so, what happens if a "realize" function of another device needs the bus_master_as
>> (at hotplug time)?
>
> My unmature understanding is that, we can just call
> pci_device_iommu_address_space() if device realization really needs
> the address space, rather than using bus_master_as.
>

Yes, each device that support IOMMU needs to call it instead of bus_master_as.
As if it really needs this information at realize time is debatable.
The vfio-pci is a special case and Alex Williamson explain why it is needed
at the "realize" time.


> An example is vfio-pci device. It is using
> pci_device_iommu_address_space() in vfio_realize(). Though I _guess_
> there may be other reasons behind, e.g., VFIOAddressSpace should be
> 1:1 mapped to bus master address space, so we may want to make sure
> this address space will be the same when different devices are using
> the same address space (while bus_master_as is one per device, even if
> two devices have the same backend address space, there will be two
> distinct bus_master_as).
>

Understood

> IIUC, bus_master_as is only used to emulate the master bit in PCI
> command register. In that case, that should only be there for the
> guest operations, while imho device realization is "emulation code",
> which can directly use pci_device_iommu_address_space(). Actually, if
> it plays with bus_master_as even if it can, I guess it'll just fail
> since that region has not yet been enabled.
>
> Please kindly correct me if I made a mistake...
>

You are right the device does not need the bus master address space before the
VM is up, this is we the init process of this region is delayed until machine done.


My question was why do you need to move pci_init_bus_master after device realization
at hotplug time and how would influence the other devices.


Thanks,
Marcel

> Thanks,
>
> -- peterx
>
