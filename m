Received: from eggs.gnu.org ([2001:4830:134:3::10]:44659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clnsu-0007NI-Qh
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 21:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clnsq-0005pQ-SA
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 21:32:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1clnsq-0005p5-KV
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 21:32:52 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 814968FD0A
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 02:32:52 +0000 (UTC)
References: <1488877751-13419-1-git-send-email-jasowang@redhat.com>
	<7594c183-6d38-3dce-75e7-62bf3be324fc@redhat.com>
	<20170308174043.10c2f056@nial.brq.redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <322da7ca-793c-fe83-9b9b-aded87742c18@redhat.com>
Date: Thu, 9 Mar 2017 10:32:44 +0800
MIME-Version: 1.0
In-Reply-To: <20170308174043.10c2f056@nial.brq.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com



On 2017=E5=B9=B403=E6=9C=8809=E6=97=A5 00:40, Igor Mammedov wrote:
> On Tue, 7 Mar 2017 14:47:30 +0200
> Marcel Apfelbaum<marcel@redhat.com>  wrote:
>
>> On 03/07/2017 11:09 AM, Jason Wang wrote:
>>> After commit 96a8821d2141 ("virtio: unbreak virtio-pci with IOMMU
>>> after caching ring translations"), IOMMU was required to be created i=
n
>>> advance. This is because we can only get the correct dma_as after pci
>>> IOMMU (e.g intel_iommu) was initialized. This is suboptimal and
>>> inconvenient for user. This patch releases this by:
>>>
>>> - introduce a bus_master_ready method for PCIDeviceClass and trigger
>>>    this during pci_init_bus_master
>>> - implement virtio-pci method and 1) reset the dma_as 2) re-register
>>>    the memory listener to the new dma_as
>>>  =20
>> Hi Jason,
>>
>>> Cc: Paolo Bonzini<pbonzini@redhat.com>
>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>> ---
>>> Changes from V2:
>>> - delay pci_init_bus_master() after pci device is realized to make
>>>    bus_master_ready a more generic method
>>> ---
>>>   hw/pci/pci.c               | 11 ++++++++---
>>>   hw/virtio/virtio-pci.c     |  9 +++++++++
>>>   hw/virtio/virtio.c         | 19 +++++++++++++++++++
>>>   include/hw/pci/pci.h       |  1 +
>>>   include/hw/virtio/virtio.h |  1 +
>>>   5 files changed, 38 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index 273f1e4..22e6ad9 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -83,6 +83,7 @@ static const VMStateDescription vmstate_pcibus =3D =
{
>>>   static void pci_init_bus_master(PCIDevice *pci_dev)
>>>   {
>>>       AddressSpace *dma_as =3D pci_device_iommu_address_space(pci_dev=
);
>>> +    PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(pci_dev);
>>>
>>>       memory_region_init_alias(&pci_dev->bus_master_enable_region,
>>>                                OBJECT(pci_dev), "bus master",
>>> @@ -90,6 +91,9 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
>>>       memory_region_set_enabled(&pci_dev->bus_master_enable_region, f=
alse);
>>>       address_space_init(&pci_dev->bus_master_as,
>>>                          &pci_dev->bus_master_enable_region, pci_dev-=
>name);
>>> +    if (pc->bus_master_ready) {
>>> +        pc->bus_master_ready(pci_dev);
>>> +    }
>>>   }
>>>
>>>   static void pcibus_machine_done(Notifier *notifier, void *data)
>>> @@ -995,9 +999,6 @@ static PCIDevice *do_pci_register_device(PCIDevic=
e *pci_dev, PCIBus *bus,
>>>       pci_dev->devfn =3D devfn;
>>>       pci_dev->requester_id_cache =3D pci_req_id_cache_get(pci_dev);
>>>
>>> -    if (qdev_hotplug) {
>>> -        pci_init_bus_master(pci_dev);
>>> -    }
>>>       pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>>>       pci_dev->irq_state =3D 0;
>>>       pci_config_alloc(pci_dev);
>>> @@ -1995,6 +1996,10 @@ static void pci_qdev_realize(DeviceState *qdev=
, Error **errp)
>>>           }
>>>       }
>>>
>>> +    if (qdev_hotplug) {
>>> +        pci_init_bus_master(pci_dev);
>>> +    }
>>> +
>> How does it help if we move qdev_hotplug check outside "do_pci_registe=
r_device"?
>> I suppose you want the code to run after the "realize" function?
>> If so, what happens if a "realize" function of another device needs th=
e bus_master_as
>> (at hotplug time)?
> Conceptually,
> I'm not sure that inherited device class realize
> should be aware of uninitialized bus_master,
> which belongs to PCI device, nor should it initialize
> it by calling pci_init_bus_master() explicitly,
> it's parent's class job (PCIDevice).

Yes, I was trying to propose a workaround for 2.9. I'm sure we will=20
refine the ordering in 2.10. And consider we have asked libvirt to=20
create IOMMU first, I think I will withdraw the patch.

>
> more close to current code:
> if xen-pci-passthrough were hotplugged then it looks like
> this hunk could break it:
> hw/xen/xen_pt.c:
>   memory_listener_register(&s->memory_listener, &s->dev.bus_master_as);
> would happen with uninitialized bus_master_as
> as realize is called before pci_init_bus_master();

Yes, this won't work. This is exactly the same issue as virtio, but this=20
will also break if it was created before an IOMMU.

>
> So the same question as Marcel's but other way around,
> why this hunk "has to" be moved.
>
>

Right.

Thanks
