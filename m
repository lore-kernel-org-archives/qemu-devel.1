Received: from eggs.gnu.org ([2001:4830:134:3::10]:51282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clYLv-0008Vk-6t
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clYLq-0004sE-Bh
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:57:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1clYLq-0004s7-35
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:57:46 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E97BF64DA3
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 09:57:45 +0000 (UTC)
References: <1488877751-13419-1-git-send-email-jasowang@redhat.com>
	<7594c183-6d38-3dce-75e7-62bf3be324fc@redhat.com>
	<20170308024349.GC31585@pxdev.xzpeter.org>
	<9d2dd1a4-aadc-a497-3dbb-6afb6d621587@redhat.com>
	<5b388627-dcae-6c11-008d-f3c5da57b334@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <adfd30ff-2a82-073e-2a64-54897b46ecc9@redhat.com>
Date: Wed, 8 Mar 2017 17:57:40 +0800
MIME-Version: 1.0
In-Reply-To: <5b388627-dcae-6c11-008d-f3c5da57b334@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Marcel Apfelbaum <marcel@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>



On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 16:17, Marcel Apfelbaum wrote:
> On 03/08/2017 05:15 AM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 10:43, Peter Xu wrote:
>>> On Tue, Mar 07, 2017 at 02:47:30PM +0200, Marcel Apfelbaum wrote:
>>>> On 03/07/2017 11:09 AM, Jason Wang wrote:
>>>>> After commit 96a8821d2141 ("virtio: unbreak virtio-pci with IOMMU
>>>>> after caching ring translations"), IOMMU was required to be=20
>>>>> created in
>>>>> advance. This is because we can only get the correct dma_as after p=
ci
>>>>> IOMMU (e.g intel_iommu) was initialized. This is suboptimal and
>>>>> inconvenient for user. This patch releases this by:
>>>>>
>>>>> - introduce a bus_master_ready method for PCIDeviceClass and trigge=
r
>>>>>   this during pci_init_bus_master
>>>>> - implement virtio-pci method and 1) reset the dma_as 2) re-registe=
r
>>>>>   the memory listener to the new dma_as
>>>>>
>>>> Hi Jason,
>>>>
>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>> ---
>>>>> Changes from V2:
>>>>> - delay pci_init_bus_master() after pci device is realized to make
>>>>>   bus_master_ready a more generic method
>>>>> ---
>>>>> hw/pci/pci.c               | 11 ++++++++---
>>>>> hw/virtio/virtio-pci.c     |  9 +++++++++
>>>>> hw/virtio/virtio.c         | 19 +++++++++++++++++++
>>>>> include/hw/pci/pci.h       |  1 +
>>>>> include/hw/virtio/virtio.h |  1 +
>>>>> 5 files changed, 38 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>> index 273f1e4..22e6ad9 100644
>>>>> --- a/hw/pci/pci.c
>>>>> +++ b/hw/pci/pci.c
>>>>> @@ -83,6 +83,7 @@ static const VMStateDescription vmstate_pcibus =3D=
 {
>>>>> static void pci_init_bus_master(PCIDevice *pci_dev)
>>>>> {
>>>>>      AddressSpace *dma_as =3D pci_device_iommu_address_space(pci_de=
v);
>>>>> +    PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(pci_dev);
>>>>>
>>>>> memory_region_init_alias(&pci_dev->bus_master_enable_region,
>>>>>                               OBJECT(pci_dev), "bus master",
>>>>> @@ -90,6 +91,9 @@ static void pci_init_bus_master(PCIDevice *pci_de=
v)
>>>>> memory_region_set_enabled(&pci_dev->bus_master_enable_region, false=
);
>>>>>      address_space_init(&pci_dev->bus_master_as,
>>>>> &pci_dev->bus_master_enable_region, pci_dev->name);
>>>>> +    if (pc->bus_master_ready) {
>>>>> +        pc->bus_master_ready(pci_dev);
>>>>> +    }
>>>>> }
>>>>>
>>>>> static void pcibus_machine_done(Notifier *notifier, void *data)
>>>>> @@ -995,9 +999,6 @@ static PCIDevice=20
>>>>> *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>>>>>      pci_dev->devfn =3D devfn;
>>>>>      pci_dev->requester_id_cache =3D pci_req_id_cache_get(pci_dev);
>>>>>
>>>>> -    if (qdev_hotplug) {
>>>>> -        pci_init_bus_master(pci_dev);
>>>>> -    }
>>>>>      pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>>>>>      pci_dev->irq_state =3D 0;
>>>>>      pci_config_alloc(pci_dev);
>>>>> @@ -1995,6 +1996,10 @@ static void pci_qdev_realize(DeviceState=20
>>>>> *qdev, Error **errp)
>>>>>          }
>>>>>      }
>>>>>
>>>>> +    if (qdev_hotplug) {
>>>>> +        pci_init_bus_master(pci_dev);
>>>>> +    }
>>>>> +
>>>> How does it help if we move qdev_hotplug check outside=20
>>>> "do_pci_register_device"?
>>>> I suppose you want the code to run after the "realize" function?
>>
>> Yes.
>>
>>>> If so, what happens if a "realize" function of another device needs=20
>>>> the bus_master_as
>>>> (at hotplug time)?
>>
>> I'm not sure this is really needed. What kind of device need to check=20
>> hotplug during their realize? (Looks like we don't have such kind of=20
>> device now).
>
> I am sorry I was not clear enough:
> If a device is added after the system is up (hotplug), we cannot=20
> depend on the "machine_done"
> event to enable "bus master".
> This is why we have
>    if (qdev_hotplug)
>         pci_init_bus_master(pci_dev);
>
> The code you proposed changes the order, so this call is done *after*=20
> realize.
>
> My question was: What if any other device may require the bus_master_as
> at realize time (and can be hot-plugged) ?
> For example: hcd-ehci/hcd-ohci devices call pci_get_address_space()
> and caches the bus_master_as.
>
> It is possible the mentioned devices can't be hot-plugged or
> are not relevant for PCIe.
>
> I am only saying we should double check when making such a change.

Can't agree more.

For hcd-ehci/hcd-ohci, simply caching the as should be fine. But if they=20
want to more things like virito, they should delay it to bus_master_ready=
.

>
>>
>>> My unmature understanding is that, we can just call
>>> pci_device_iommu_address_space() if device realization really needs
>>> the address space, rather than using bus_master_as.
>>
>> A little issue is pci_device_iommu_address_space() can be wrong if it=20
>> was called before OMMU was created.
>>
>
> At hotplug time this is irrelevant because the iommu has already been=20
> created.
>
> Thanks,
> Marcel

Yes.

Thanks
