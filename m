Received: from eggs.gnu.org ([2001:4830:134:3::10]:59556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxYXD-0004Q3-K7
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxYX9-0000V1-Gy
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:07:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxYX9-0000UN-7S
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:07:19 -0400
Date: Thu, 28 Sep 2017 10:06:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170928130644.GO4115@localhost.localdomain>
References: <20170927195635.16014-1-ehabkost@redhat.com>
	<20170927195635.16014-3-ehabkost@redhat.com>
	<20170928040809.GA12504@umbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170928040809.GA12504@umbus>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] pci: Add interface names to hybrid
 PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, David Gibson <dgibson@redhat.com>, Alistair Francis <alistair23@gmail.com>, Laine Stump <laine@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Sep 28, 2017 at 02:08:09PM +1000, David Gibson wrote:
> On Wed, Sep 27, 2017 at 04:56:32PM -0300, Eduardo Habkost wrote:
> > The following devices support both PCI Express and Conventional
> > PCI, by including special code to handle the QEMU_PCI_CAP_EXPRESS
> > flag and/or conditional pcie_endpoint_cap_init() calls:
> > 
> > * vfio-pci (is_express=1, but legacy PCI handled by
> >   vfio_populate_device())
> 
> In the case of VFIO, won't this depend on the capabilities of the
> device on the host?

Yes.  But the interface names are static data about the device
type, which really supports both cases.

Deciding where exactly a VFIO device can be plugged before
running the VM will require additional data about the host, and
that can't be provided by QEMU (because it's not running yet).

> 
> > * vmxnet3 (is_express=0, but PCIe handled by vmxnet3_realize())
> > * pvscsi (is_express=0, but PCIe handled by pvscsi_realize())
> > * virtio-pci (is_express=0, but PCIe handled by
> >   virtio_pci_dc_realize(), and additional legacy PCI code at
> >   virtio_pci_realize())
> > * base-xhci (is_express=1, but pcie_endpoint_cap_init() call
> >   is conditional on pci_bus_is_express(dev->bus)
> >   * Note that xhci does not clear QEMU_PCI_CAP_EXPRESS like the
> >     other hybrid devices
> > 
> > Cc: Dmitry Fleytman <dmitry@daynix.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Except for the query above,
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> > ---
> > Changes v1 -> v2:
> > * s/legacy/conventional/
> >   * Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > * Mark base-xhci as hybrid too
> > ---
> >  hw/net/vmxnet3.c       | 5 +++++
> >  hw/scsi/vmw_pvscsi.c   | 2 ++
> >  hw/usb/hcd-xhci.c      | 5 +++++
> >  hw/vfio/pci.c          | 5 +++++
> >  hw/virtio/virtio-pci.c | 5 +++++
> >  5 files changed, 22 insertions(+)
> > 
> > diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> > index a19a7a31dd..f99d9a69ec 100644
> > --- a/hw/net/vmxnet3.c
> > +++ b/hw/net/vmxnet3.c
> > @@ -2651,6 +2651,11 @@ static const TypeInfo vmxnet3_info = {
> >      .instance_size = sizeof(VMXNET3State),
> >      .class_init    = vmxnet3_class_init,
> >      .instance_init = vmxnet3_instance_init,
> > +    .interfaces = (InterfaceInfo[]) {
> > +        { INTERFACE_PCIE_DEVICE },
> > +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> > +        { }
> > +    },
> >  };
> >  
> >  static void vmxnet3_register_types(void)
> > diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> > index 6d3f0bf11d..d6b315f8b2 100644
> > --- a/hw/scsi/vmw_pvscsi.c
> > +++ b/hw/scsi/vmw_pvscsi.c
> > @@ -1300,6 +1300,8 @@ static const TypeInfo pvscsi_info = {
> >      .class_init    = pvscsi_class_init,
> >      .interfaces = (InterfaceInfo[]) {
> >          { TYPE_HOTPLUG_HANDLER },
> > +        { INTERFACE_PCIE_DEVICE },
> > +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> >          { }
> >      }
> >  };
> > diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> > index d75c085d94..af3a9d88de 100644
> > --- a/hw/usb/hcd-xhci.c
> > +++ b/hw/usb/hcd-xhci.c
> > @@ -3670,6 +3670,11 @@ static const TypeInfo xhci_info = {
> >      .instance_size = sizeof(XHCIState),
> >      .class_init    = xhci_class_init,
> >      .abstract      = true,
> > +    .interfaces = (InterfaceInfo[]) {
> > +        { INTERFACE_PCIE_DEVICE },
> > +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> > +        { }
> > +    },
> >  };
> >  
> >  static void qemu_xhci_class_init(ObjectClass *klass, void *data)
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 31e1edf447..913433d6ba 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -3023,6 +3023,11 @@ static const TypeInfo vfio_pci_dev_info = {
> >      .class_init = vfio_pci_dev_class_init,
> >      .instance_init = vfio_instance_init,
> >      .instance_finalize = vfio_instance_finalize,
> > +    .interfaces = (InterfaceInfo[]) {
> > +        { INTERFACE_PCIE_DEVICE },
> > +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> > +        { }
> > +    },
> >  };
> >  
> >  static void register_vfio_pci_dev_type(void)
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 8b0d6b69cd..67c8ab63ad 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1958,6 +1958,11 @@ static const TypeInfo virtio_pci_info = {
> >      .class_init    = virtio_pci_class_init,
> >      .class_size    = sizeof(VirtioPCIClass),
> >      .abstract      = true,
> > +    .interfaces = (InterfaceInfo[]) {
> > +        { INTERFACE_PCIE_DEVICE },
> > +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> > +        { }
> > +    },
> >  };
> >  
> >  /* virtio-blk-pci */
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



-- 
Eduardo
