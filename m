Received: from eggs.gnu.org ([2001:4830:134:3::10]:47776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cledy-0004Kc-0v
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 11:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cledu-0007FE-R7
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 11:40:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cledu-0007Dr-IV
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 11:40:50 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68E3F369C3
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 16:40:50 +0000 (UTC)
Date: Wed, 8 Mar 2017 17:40:43 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170308174043.10c2f056@nial.brq.redhat.com>
In-Reply-To: <7594c183-6d38-3dce-75e7-62bf3be324fc@redhat.com>
References: <1488877751-13419-1-git-send-email-jasowang@redhat.com>
	<7594c183-6d38-3dce-75e7-62bf3be324fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com

On Tue, 7 Mar 2017 14:47:30 +0200
Marcel Apfelbaum <marcel@redhat.com> wrote:

> On 03/07/2017 11:09 AM, Jason Wang wrote:
> > After commit 96a8821d2141 ("virtio: unbreak virtio-pci with IOMMU
> > after caching ring translations"), IOMMU was required to be created in
> > advance. This is because we can only get the correct dma_as after pci
> > IOMMU (e.g intel_iommu) was initialized. This is suboptimal and
> > inconvenient for user. This patch releases this by:
> >
> > - introduce a bus_master_ready method for PCIDeviceClass and trigger
> >   this during pci_init_bus_master
> > - implement virtio-pci method and 1) reset the dma_as 2) re-register
> >   the memory listener to the new dma_as
> >  
> 
> Hi Jason,
> 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes from V2:
> > - delay pci_init_bus_master() after pci device is realized to make
> >   bus_master_ready a more generic method
> > ---
> >  hw/pci/pci.c               | 11 ++++++++---
> >  hw/virtio/virtio-pci.c     |  9 +++++++++
> >  hw/virtio/virtio.c         | 19 +++++++++++++++++++
> >  include/hw/pci/pci.h       |  1 +
> >  include/hw/virtio/virtio.h |  1 +
> >  5 files changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 273f1e4..22e6ad9 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -83,6 +83,7 @@ static const VMStateDescription vmstate_pcibus = {
> >  static void pci_init_bus_master(PCIDevice *pci_dev)
> >  {
> >      AddressSpace *dma_as = pci_device_iommu_address_space(pci_dev);
> > +    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
> >
> >      memory_region_init_alias(&pci_dev->bus_master_enable_region,
> >                               OBJECT(pci_dev), "bus master",
> > @@ -90,6 +91,9 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
> >      memory_region_set_enabled(&pci_dev->bus_master_enable_region, false);
> >      address_space_init(&pci_dev->bus_master_as,
> >                         &pci_dev->bus_master_enable_region, pci_dev->name);
> > +    if (pc->bus_master_ready) {
> > +        pc->bus_master_ready(pci_dev);
> > +    }
> >  }
> >
> >  static void pcibus_machine_done(Notifier *notifier, void *data)
> > @@ -995,9 +999,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
> >      pci_dev->devfn = devfn;
> >      pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
> >
> > -    if (qdev_hotplug) {
> > -        pci_init_bus_master(pci_dev);
> > -    }
> >      pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
> >      pci_dev->irq_state = 0;
> >      pci_config_alloc(pci_dev);
> > @@ -1995,6 +1996,10 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> >          }
> >      }
> >
> > +    if (qdev_hotplug) {
> > +        pci_init_bus_master(pci_dev);
> > +    }
> > +  
> 
> How does it help if we move qdev_hotplug check outside "do_pci_register_device"?
> I suppose you want the code to run after the "realize" function?
> If so, what happens if a "realize" function of another device needs the bus_master_as
> (at hotplug time)?

Conceptually,
I'm not sure that inherited device class realize
should be aware of uninitialized bus_master,
which belongs to PCI device, nor should it initialize
it by calling pci_init_bus_master() explicitly,
it's parent's class job (PCIDevice).

more close to current code:
if xen-pci-passthrough were hotplugged then it looks like
this hunk could break it:
hw/xen/xen_pt.c:
 memory_listener_register(&s->memory_listener, &s->dev.bus_master_as);
would happen with uninitialized bus_master_as
as realize is called before pci_init_bus_master();

So the same question as Marcel's but other way around,
why this hunk "has to" be moved.


> 
> Thanks,
> Marcel
> 
> >      /* rom loading */
> >      is_default_rom = false;
> >      if (pci_dev->romfile == NULL && pc->romfile != NULL) {
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index b76f3f6..21cbda2 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1845,6 +1845,14 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
> >      address_space_destroy(&proxy->modern_as);
> >  }
> >
> > +static void virtio_pci_bus_master_ready(PCIDevice *pci_dev)
> > +{
> > +    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
> > +    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> > +
> > +    virtio_device_reset_dma_as(vdev);
> > +}
> > +
> >  static void virtio_pci_reset(DeviceState *qdev)
> >  {
> >      VirtIOPCIProxy *proxy = VIRTIO_PCI(qdev);
> > @@ -1904,6 +1912,7 @@ static void virtio_pci_class_init(ObjectClass *klass, void *data)
> >      dc->props = virtio_pci_properties;
> >      k->realize = virtio_pci_realize;
> >      k->exit = virtio_pci_exit;
> > +    k->bus_master_ready = virtio_pci_bus_master_ready;
> >      k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> >      k->revision = VIRTIO_PCI_ABI_VERSION;
> >      k->class_id = PCI_CLASS_OTHERS;
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index efce4b3..09f4cf4 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2594,6 +2594,25 @@ bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
> >      return virtio_bus_ioeventfd_enabled(vbus);
> >  }
> >
> > +void virtio_device_reset_dma_as(VirtIODevice *vdev)
> > +{
> > +    DeviceState *qdev = DEVICE(vdev);
> > +    BusState *qbus = BUS(qdev_get_parent_bus(qdev));
> > +    VirtioBusState *bus = VIRTIO_BUS(qbus);
> > +    VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
> > +    bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > +
> > +    if (klass->get_dma_as != NULL && has_iommu) {
> > +        vdev->dma_as = klass->get_dma_as(qbus->parent);
> > +    } else {
> > +        vdev->dma_as = &address_space_memory;
> > +    }
> > +
> > +    memory_listener_unregister(&vdev->listener);
> > +    memory_listener_register(&vdev->listener, vdev->dma_as);
> > +}
this mostly subset of virtio_bus_device_plugged(), generalize?

> > +
> > +
> >  static const TypeInfo virtio_device_info = {
> >      .name = TYPE_VIRTIO_DEVICE,
> >      .parent = TYPE_DEVICE,
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index 9349acb..e700a58 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -207,6 +207,7 @@ typedef struct PCIDeviceClass {
> >
> >      void (*realize)(PCIDevice *dev, Error **errp);
> >      int (*init)(PCIDevice *dev);/* TODO convert to realize() and remove */
> > +    void (*bus_master_ready)(PCIDevice *dev);
> >      PCIUnregisterFunc *exit;
> >      PCIConfigReadFunc *config_read;
> >      PCIConfigWriteFunc *config_write;
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 15efcf2..21fa273 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -283,6 +283,7 @@ void virtio_device_stop_ioeventfd(VirtIODevice *vdev);
> >  int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
> >  void virtio_device_release_ioeventfd(VirtIODevice *vdev);
> >  bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
> > +void virtio_device_reset_dma_as(VirtIODevice *vdev);
> >  EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq);
> >  void virtio_queue_host_notifier_read(EventNotifier *n);
> >  void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
> >  
> 
> 
