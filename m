Received: from eggs.gnu.org ([2001:4830:134:3::10]:37305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f0oy4-0008Lc-5I
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f0oxz-0000Ty-6W
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:48:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:44799)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f0oxy-0000SM-RV
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:48:47 -0400
Date: Tue, 27 Mar 2018 21:47:05 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180327134705.3zqzangejm2yy3ph@debian>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
	<20180319071537.28649-4-tiwei.bie@intel.com>
	<20180322164345-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180322164345-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] virtio: support adding sub-regions
 for notify region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Thu, Mar 22, 2018 at 04:57:23PM +0200, Michael S. Tsirkin wrote:
> On Mon, Mar 19, 2018 at 03:15:34PM +0800, Tiwei Bie wrote:
[...]
> > +
> > +bool virtio_pci_page_per_vq_enabled(VirtIODevice *vdev)
> > +{
> > +    VirtIOPCIProxy *proxy = virtio_device_to_virtio_pci_proxy(vdev);
> > +
> > +    if (proxy == NULL) {
> > +        return false;
> > +    }
> > +
> > +    return !!(proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ);
> > +}
> > +
> 
> VIRTIO_PCI_FLAG_PAGE_PER_VQ is not something external users
> should care about. Need to find some other way to express the
> specific requirements.
> 
> In particular do you want to use a host page per VQ?
> 
> This isn't what VIRTIO_PCI_FLAG_PAGE_PER_VQ does - it uses a 4K offset
> which does not match a memory page size on all platforms.

Yeah, right. I'll think about how to deal with this.

> 
> 
> > +int virtio_pci_notify_region_map(VirtIODevice *vdev, int queue_idx,
> > +                                 MemoryRegion *mr)
> > +{
> > +    VirtIOPCIProxy *proxy = virtio_device_to_virtio_pci_proxy(vdev);
> > +    int offset;
> > +
> > +    if (proxy == NULL || !virtio_pci_modern(proxy)) {
> > +        return -1;
> > +    }
> > +
> > +    offset = virtio_pci_queue_mem_mult(proxy) * queue_idx;
> > +    memory_region_add_subregion(&proxy->notify.mr, offset, mr);
> > +
> > +    return 0;
> > +}
> > +
> > +void virtio_pci_notify_region_unmap(VirtIODevice *vdev, MemoryRegion *mr)
> > +{
> > +    VirtIOPCIProxy *proxy = virtio_device_to_virtio_pci_proxy(vdev);
> > +
> > +    if (proxy != NULL) {
> > +        memory_region_del_subregion(&proxy->notify.mr, mr);
> > +    }
> > +}
> > +
> >  static void virtio_pci_pre_plugged(DeviceState *d, Error **errp)
> >  {
> >      VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
> > diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> > index 813082b0d7..8061133741 100644
> > --- a/hw/virtio/virtio-pci.h
> > +++ b/hw/virtio/virtio-pci.h
> > @@ -213,6 +213,11 @@ static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
> >      proxy->disable_modern = true;
> >  }
> >  
> > +bool virtio_pci_page_per_vq_enabled(VirtIODevice *vdev);
> > +int virtio_pci_notify_region_map(VirtIODevice *vdev, int queue_idx,
> > +                                 MemoryRegion *mr);
> > +void virtio_pci_notify_region_unmap(VirtIODevice *vdev, MemoryRegion *mr);
> > +
> >  /*
> >   * virtio-scsi-pci: This extends VirtioPCIProxy.
> >   */
> 
> These are not great APIs unfortunately. Need to come up with generic names.
> E.g. do we register and de-register host notifiers maybe?
> 

I like the name "host notifier". I'll try to use it. Thanks a lot!

> 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 006d3d1148..90ee72984c 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -22,6 +22,7 @@
> >  #include "qemu/atomic.h"
> >  #include "hw/virtio/virtio-bus.h"
> >  #include "hw/virtio/virtio-access.h"
> > +#include "hw/virtio/virtio-pci.h"
> >  #include "sysemu/dma.h"
> >  
> >  /*
> > @@ -2681,6 +2682,44 @@ void virtio_device_release_ioeventfd(VirtIODevice *vdev)
> >      virtio_bus_release_ioeventfd(vbus);
> >  }
> >  
> > +bool virtio_device_parent_is_pci_device(VirtIODevice *vdev)
> > +{
> > +    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> > +    const char *typename = object_get_typename(OBJECT(qbus->parent));
> > +
> > +    return strstr(typename, "pci") != NULL;
> > +}
> > +
> > +bool virtio_device_page_per_vq_enabled(VirtIODevice *vdev)
> > +{
> > +#ifdef CONFIG_VIRTIO_PCI
> > +    if (virtio_device_parent_is_pci_device(vdev)) {
> > +        return virtio_pci_page_per_vq_enabled(vdev);
> > +    }
> > +#endif
> > +    return false;
> > +}
> > +
> 
> A better way to do this is to pass a callback to the bus where each bus can
> implement its own.
> 

It's pretty neat! It helped me get rid of all the
changes to the build scripts. Thanks a lot!

Best regards,
Tiwei Bie
