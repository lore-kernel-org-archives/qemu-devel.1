Received: from eggs.gnu.org ([2001:4830:134:3::10]:57614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cluOl-0002o3-VS
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cluOi-00017D-QP
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:30:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cluOi-00016d-HM
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:30:12 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B73780470
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 09:30:12 +0000 (UTC)
References: <1488877751-13419-1-git-send-email-jasowang@redhat.com>
	<7594c183-6d38-3dce-75e7-62bf3be324fc@redhat.com>
	<20170308174043.10c2f056@nial.brq.redhat.com>
	<322da7ca-793c-fe83-9b9b-aded87742c18@redhat.com>
	<20170309102849.1db72ad5@nial.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8b861c9a-dd9d-7eb3-dce8-4cf32b6cee8c@redhat.com>
Date: Thu, 9 Mar 2017 10:30:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170309102849.1db72ad5@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com



On 09/03/2017 10:28, Igor Mammedov wrote:
> On Thu, 9 Mar 2017 10:32:44 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>=20
>> On 2017=E5=B9=B403=E6=9C=8809=E6=97=A5 00:40, Igor Mammedov wrote:
>>> On Tue, 7 Mar 2017 14:47:30 +0200
>>> Marcel Apfelbaum<marcel@redhat.com>  wrote:
>>> =20
>>>> On 03/07/2017 11:09 AM, Jason Wang wrote: =20
>>>>> After commit 96a8821d2141 ("virtio: unbreak virtio-pci with IOMMU
>>>>> after caching ring translations"), IOMMU was required to be created=
 in
>>>>> advance. This is because we can only get the correct dma_as after p=
ci
>>>>> IOMMU (e.g intel_iommu) was initialized. This is suboptimal and
>>>>> inconvenient for user. This patch releases this by:
>>>>>
>>>>> - introduce a bus_master_ready method for PCIDeviceClass and trigge=
r
>>>>>    this during pci_init_bus_master
>>>>> - implement virtio-pci method and 1) reset the dma_as 2) re-registe=
r
>>>>>    the memory listener to the new dma_as
>=20
> Instead of trying to fix up later it's possible to refuse
> adding iommu device if other devices has been added before
> it with -device/device_add.
> That would match current CLI semantics where device that
> others depend on should be listed on CLI before that others
> are listed.

I like this a lot.  Can we add it to "Future incompatible changes" in
the 2.9 changelog?

Paolo

> A bit hackish but something along this lines:
>=20
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 9349acb..9d8ecc6 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -460,7 +460,7 @@ void pci_device_deassert_intx(PCIDevice *dev);
>  typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
> =20
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
> -void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
> +void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque, Error=
 **errp);
> =20
>  static inline void
>  pci_set_byte(uint8_t *config, uint8_t val)
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index e0732cc..9d9a76b 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1160,7 +1160,7 @@ static void amdvi_realize(DeviceState *dev, Error=
 **err)
> =20
>      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
>      sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, AMDVI_BASE_ADDR);
> -    pci_setup_iommu(bus, amdvi_host_dma_iommu, s);
> +    pci_setup_iommu(bus, amdvi_host_dma_iommu, s, err);
>      s->devid =3D object_property_get_int(OBJECT(&s->pci), "addr", err)=
;
>      msi_init(&s->pci.dev, 0, 1, true, false, err);
>      amdvi_init(s);
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 22d8226..f4f208c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2585,7 +2585,7 @@ static void vtd_realize(DeviceState *dev, Error *=
*errp)
>                                                g_free, g_free);
>      vtd_init(s);
>      sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, Q35_HOST_BRIDGE_IOMMU_ADDR);
> -    pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
> +    pci_setup_iommu(bus, vtd_host_dma_iommu, dev, errp);
>      /* Pseudo address space under root PCI bus. */
>      pcms->ioapic_as =3D vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IO=
APIC);
>  }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 273f1e4..2d01589 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -317,6 +317,21 @@ static void pci_host_bus_register(DeviceState *hos=
t)
>      QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
>  }
> =20
> +static bool pcibus_has_devices(PCIBus *bus)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(bus->devices); ++i) {
> +        if (bus->devices[i]) {
> +            DeviceState *dev =3D DEVICE(bus->devices[i]);
> +            if (dev->opts) {
> +                return true;
> +            }
> +        }
> +    }
> +    return false;
> +}
> +
>  PCIBus *pci_find_primary_bus(void)
>  {
>      PCIBus *primary_bus =3D NULL;
> @@ -2534,8 +2549,12 @@ AddressSpace *pci_device_iommu_address_space(PCI=
Device *dev)
>      return &address_space_memory;
>  }
> =20
> -void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
> +void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque, Error=
 **errp)
>  {
> +    if (pcibus_has_devices(bus)) {
> +        error_setg(errp, "IOMMU must be created before any other PCI d=
evices");
> +        return;
> +    }
>      bus->iommu_fn =3D fn;
>      bus->iommu_opaque =3D opaque;
>  }
>=20
>=20
>=20
>>>>>    =20
>>>> Hi Jason,
>>>> =20
>>>>> Cc: Paolo Bonzini<pbonzini@redhat.com>
>>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>>>> ---
>>>>> Changes from V2:
>>>>> - delay pci_init_bus_master() after pci device is realized to make
>>>>>    bus_master_ready a more generic method
>>>>> ---
>>>>>   hw/pci/pci.c               | 11 ++++++++---
>>>>>   hw/virtio/virtio-pci.c     |  9 +++++++++
>>>>>   hw/virtio/virtio.c         | 19 +++++++++++++++++++
>>>>>   include/hw/pci/pci.h       |  1 +
>>>>>   include/hw/virtio/virtio.h |  1 +
>>>>>   5 files changed, 38 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>> index 273f1e4..22e6ad9 100644
>>>>> --- a/hw/pci/pci.c
>>>>> +++ b/hw/pci/pci.c
>>>>> @@ -83,6 +83,7 @@ static const VMStateDescription vmstate_pcibus =3D=
 {
>>>>>   static void pci_init_bus_master(PCIDevice *pci_dev)
>>>>>   {
>>>>>       AddressSpace *dma_as =3D pci_device_iommu_address_space(pci_d=
ev);
>>>>> +    PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(pci_dev);
>>>>>
>>>>>       memory_region_init_alias(&pci_dev->bus_master_enable_region,
>>>>>                                OBJECT(pci_dev), "bus master",
>>>>> @@ -90,6 +91,9 @@ static void pci_init_bus_master(PCIDevice *pci_de=
v)
>>>>>       memory_region_set_enabled(&pci_dev->bus_master_enable_region,=
 false);
>>>>>       address_space_init(&pci_dev->bus_master_as,
>>>>>                          &pci_dev->bus_master_enable_region, pci_de=
v->name);
>>>>> +    if (pc->bus_master_ready) {
>>>>> +        pc->bus_master_ready(pci_dev);
>>>>> +    }
>>>>>   }
>>>>>
>>>>>   static void pcibus_machine_done(Notifier *notifier, void *data)
>>>>> @@ -995,9 +999,6 @@ static PCIDevice *do_pci_register_device(PCIDev=
ice *pci_dev, PCIBus *bus,
>>>>>       pci_dev->devfn =3D devfn;
>>>>>       pci_dev->requester_id_cache =3D pci_req_id_cache_get(pci_dev)=
;
>>>>>
>>>>> -    if (qdev_hotplug) {
>>>>> -        pci_init_bus_master(pci_dev);
>>>>> -    }
>>>>>       pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>>>>>       pci_dev->irq_state =3D 0;
>>>>>       pci_config_alloc(pci_dev);
>>>>> @@ -1995,6 +1996,10 @@ static void pci_qdev_realize(DeviceState *qd=
ev, Error **errp)
>>>>>           }
>>>>>       }
>>>>>
>>>>> +    if (qdev_hotplug) {
>>>>> +        pci_init_bus_master(pci_dev);
>>>>> +    }
>>>>> + =20
>>>> How does it help if we move qdev_hotplug check outside "do_pci_regis=
ter_device"?
>>>> I suppose you want the code to run after the "realize" function?
>>>> If so, what happens if a "realize" function of another device needs =
the bus_master_as
>>>> (at hotplug time)? =20
>>> Conceptually,
>>> I'm not sure that inherited device class realize
>>> should be aware of uninitialized bus_master,
>>> which belongs to PCI device, nor should it initialize
>>> it by calling pci_init_bus_master() explicitly,
>>> it's parent's class job (PCIDevice). =20
>>
>> Yes, I was trying to propose a workaround for 2.9. I'm sure we will=20
>> refine the ordering in 2.10. And consider we have asked libvirt to=20
>> create IOMMU first, I think I will withdraw the patch.
>>
>>>
>>> more close to current code:
>>> if xen-pci-passthrough were hotplugged then it looks like
>>> this hunk could break it:
>>> hw/xen/xen_pt.c:
>>>   memory_listener_register(&s->memory_listener, &s->dev.bus_master_as=
);
>>> would happen with uninitialized bus_master_as
>>> as realize is called before pci_init_bus_master(); =20
>>
>> Yes, this won't work. This is exactly the same issue as virtio, but th=
is=20
>> will also break if it was created before an IOMMU.
>>
>>>
>>> So the same question as Marcel's but other way around,
>>> why this hunk "has to" be moved.
>>>
>>> =20
>>
>> Right.
>>
>> Thanks
>=20
