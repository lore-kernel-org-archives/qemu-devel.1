Received: from eggs.gnu.org ([2001:4830:134:3::10]:48278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dv6Yd-0005Ec-Gn
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 14:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dv6Ya-0000hW-6v
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 14:50:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dv6YY-0000fj-Ud
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 14:50:39 -0400
Date: Thu, 21 Sep 2017 15:50:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170921185028.GK21016@localhost.localdomain>
References: <1505811353-29151-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505811353-29151-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Marcel Apfelbaum <marcel@redhat.com>

On Tue, Sep 19, 2017 at 10:55:53AM +0200, Thomas Huth wrote:
> Historically we've marked all devices as hotpluggable by default. However,
> most devices are not hotpluggable, and you also need a HotplugHandler to
> support these devices. So if the user tries to "device_add" or "device_del"
> such a non-hotpluggable device during runtime, either nothing really usable
> happens, or QEMU even crashes/aborts unexpectedly (see for example commit
> 84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
> So let's change this dangerous default behaviour and mark the devices as
> non-hotpluggable by default. Certain parent devices classes which are known
> as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable = true",
> so that devices that are derived from these classes continue to work as
> expected.

These seem to be missing:
* TYPE_CPU (or at least TYPE_X86_CPU and TYPE_S390_CPU)
* TYPE_VIRTIO_SERIAL_PORT
* TYPE_CCID_CARD
* TYPE_XENSYSDEV

Also, I don't think we need to set it for TYPE_CPU_CORE, just for
TYPE_SPAPR_CPU_CORE.

For reference, the full list of qbus_set*hotplug_handler() callers is:

hw/acpi/piix4.c=439=static void piix4_update_bus_hotplug(PCIBus *pci_bus, void *opaque)
hw/acpi/piix4.c:445:    qbus_set_hotplug_handler(BUS(pci_bus), DEVICE(s), &error_abort);
hw/char/virtio-serial-bus.c=1015=static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
hw/char/virtio-serial-bus.c:1045:    qbus_set_hotplug_handler(BUS(&vser->bus), DEVICE(vser), errp);
hw/char/virtio-serial-bus.c=1111=static void virtio_serial_device_unrealize(DeviceState *dev, Error **errp)
hw/char/virtio-serial-bus.c:1128:    qbus_set_hotplug_handler(BUS(&vser->bus), NULL, errp);
hw/pci/pcie.c=392=void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot)
hw/pci/pcie.c:445:    qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev))),
hw/pci/shpc.c=585=int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRegion *bar,
hw/pci/shpc.c:651:    qbus_set_hotplug_handler(BUS(sec_bus), DEVICE(d), NULL);
hw/ppc/spapr_pci.c=1508=static void spapr_phb_realize(DeviceState *dev, Error **errp)
hw/ppc/spapr_pci.c:1657:    qbus_set_hotplug_handler(BUS(phb->bus), DEVICE(sphb), NULL);
hw/s390x/css-bridge.c=94=VirtualCssBus *virtual_css_bus_init(void)
hw/s390x/css-bridge.c:110:    qbus_set_hotplug_handler(bus, dev, &error_abort);
hw/s390x/s390-pci-bus.c=548=static int s390_pcihost_init(SysBusDevice *dev)
hw/s390x/s390-pci-bus.c:564:    qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
hw/s390x/s390-pci-bus.c:568:    qbus_set_hotplug_handler(BUS(s->bus), DEVICE(s), NULL);
hw/s390x/s390-pci-bus.c=660=static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
hw/s390x/s390-pci-bus.c:676:        qbus_set_hotplug_handler(bus, DEVICE(s), errp);
hw/scsi/scsi-bus.c=91=void scsi_bus_new(SCSIBus *bus, size_t bus_size, DeviceState *host,
hw/scsi/scsi-bus.c:97:    qbus_set_bus_hotplug_handler(BUS(bus), &error_abort);
hw/scsi/virtio-scsi.c=877=static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
hw/scsi/virtio-scsi.c:896:    qbus_set_hotplug_handler(BUS(&s->bus), dev, &error_abort);
hw/scsi/virtio-scsi.c=910=static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
hw/scsi/virtio-scsi.c:914:    qbus_set_hotplug_handler(BUS(&s->bus), NULL, &error_abort);
hw/scsi/vmw_pvscsi.c=1107=pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
hw/scsi/vmw_pvscsi.c:1145:    qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(s), &error_abort);
hw/usb/bus.c=88=void usb_bus_new(USBBus *bus, size_t bus_size,
hw/usb/bus.c:92:    qbus_set_bus_hotplug_handler(BUS(bus), &error_abort);
hw/usb/dev-smartcard-reader.c=1332=static void ccid_realize(USBDevice *dev, Error **errp)
hw/usb/dev-smartcard-reader.c:1340:    qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(dev), &error_abort);
hw/xen/xen_backend.c=520=int xen_be_init(void)
hw/xen/xen_backend.c:538:    qbus_set_bus_hotplug_handler(xen_sysbus, &error_abort);

The full list of machine-provided hotplug handler callbacks is:

hw/i386/pc.c:2302:    pcmc->get_hotplug_handler = mc->get_hotplug_handler;
hw/i386/pc.c:2317:    mc->get_hotplug_handler = pc_get_hotpug_handler;
hw/ppc/spapr.c:3582:    mc->get_hotplug_handler = spapr_get_hotplug_handler;
hw/s390x/s390-virtio-ccw.c:446:    mc->get_hotplug_handler = s390_get_hotplug_handler;


Details for each item:

hw/i386/pc.c:2302:    pcmc->get_hotplug_handler = mc->get_hotplug_handler;
hw/i386/pc.c:2317:    mc->get_hotplug_handler = pc_get_hotpug_handler;
pc_get_hotpug_handler accepts:
* TYPE_PC_DIMM
* TYPE_CPU

hw/ppc/spapr.c:3582:    mc->get_hotplug_handler = spapr_get_hotplug_handler;
spapr_get_hotplug_handler accepts:
* TYPE_PC_DIMM
* TYPE_SPAPR_CPU_CORE

hw/s390x/s390-virtio-ccw.c:446:    mc->get_hotplug_handler = s390_get_hotplug_handler;
s390_get_hotplug_handler accepts:
* TYPE_CPU

hw/acpi/piix4.c=439=static void piix4_update_bus_hotplug(PCIBus *pci_bus, void *opaque)
hw/acpi/piix4.c:445:    qbus_set_hotplug_handler(BUS(pci_bus), DEVICE(s), &error_abort);
* It looks like this is set only for PCI buses, but
  piix4_device_plug_cb() handles: TYPE_PC_DIMM, TYPE_NVDIMM,
  TYPE_PCI_DEVICE, and TYPE_CPU.  It isn't clear how
  piix4_device_plug_cb() ends up getting called for non-PCI
  devices.  But this patch handle all of them except TYPE_CPU,
  anyway.

hw/char/virtio-serial-bus.c=1015=static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
hw/char/virtio-serial-bus.c:1045:    qbus_set_hotplug_handler(BUS(&vser->bus), DEVICE(vser), errp);
hw/char/virtio-serial-bus.c=1111=static void virtio_serial_device_unrealize(DeviceState *dev, Error **errp)
hw/char/virtio-serial-bus.c:1128:    qbus_set_hotplug_handler(BUS(&vser->bus), NULL, errp);
* vser->bus is VirtIOSerialBus, which accepts hotplug of
  TYPE_VIRTIO_SERIAL_PORT devices.  Missing from this patch.

hw/pci/pcie.c=392=void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot)
hw/pci/pcie.c:445:    qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev))),
hw/pci/shpc.c=585=int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRegion *bar,
hw/pci/shpc.c:651:    qbus_set_hotplug_handler(BUS(sec_bus), DEVICE(d), NULL);
hw/ppc/spapr_pci.c=1508=static void spapr_phb_realize(DeviceState *dev, Error **errp)
hw/ppc/spapr_pci.c:1657:    qbus_set_hotplug_handler(BUS(phb->bus), DEVICE(sphb), NULL);
* These are a bit confusing because the actual
  TYPE_HOTPLUG_HANDLER method implementations are not at the same
  files as the qbus_set_hotplug_handler() calls, but it seems to
  work, and they only affect TYPE_PCI anyway.

hw/s390x/css-bridge.c=94=VirtualCssBus *virtual_css_bus_init(void)
hw/s390x/css-bridge.c:110:    qbus_set_hotplug_handler(bus, dev, &error_abort);
* This seems to be for TYPE_CCW_DEVICE

hw/s390x/s390-pci-bus.c=548=static int s390_pcihost_init(SysBusDevice *dev)
hw/s390x/s390-pci-bus.c:564:    qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
hw/s390x/s390-pci-bus.c:568:    qbus_set_hotplug_handler(BUS(s->bus), DEVICE(s), NULL);
hw/s390x/s390-pci-bus.c=660=static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
hw/s390x/s390-pci-bus.c:676:        qbus_set_hotplug_handler(bus, DEVICE(s), errp);
* TYPE_PCI only, it seems.

hw/scsi/scsi-bus.c=91=void scsi_bus_new(SCSIBus *bus, size_t bus_size, DeviceState *host,
hw/scsi/scsi-bus.c:97:    qbus_set_bus_hotplug_handler(BUS(bus), &error_abort);
* For TYPE_SCSI_DEVICE

hw/scsi/virtio-scsi.c=877=static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
hw/scsi/virtio-scsi.c:896:    qbus_set_hotplug_handler(BUS(&s->bus), dev, &error_abort);
hw/scsi/virtio-scsi.c=910=static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
hw/scsi/virtio-scsi.c:914:    qbus_set_hotplug_handler(BUS(&s->bus), NULL, &error_abort);
* s->bus is a SCSIBus.  TYPE_SCSI_DEVICE only, it seems.

hw/scsi/vmw_pvscsi.c=1107=pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
hw/scsi/vmw_pvscsi.c:1145:    qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(s), &error_abort);
* s->bus is a SCSIBus.  TYPE_SCSI_DEVICE only, it seems.

hw/usb/bus.c=88=void usb_bus_new(USBBus *bus, size_t bus_size,
hw/usb/bus.c:92:    qbus_set_bus_hotplug_handler(BUS(bus), &error_abort);
* For TYPE_USB_DEVICE

hw/usb/dev-smartcard-reader.c=1332=static void ccid_realize(USBDevice *dev, Error **errp)
hw/usb/dev-smartcard-reader.c:1340:    qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(dev), &error_abort);
* s->bus is a CCIDBus.  This is for TYPE_CCID_CARD.  Missing from
  this patch.

hw/xen/xen_backend.c=520=int xen_be_init(void)
hw/xen/xen_backend.c:538:    qbus_set_bus_hotplug_handler(xen_sysbus, &error_abort);
* xen_sysbus is a TYPE_XENSYSBUS, which accepts hotplug of
  TYPE_XENSYSDEV devices.  Missing from this patch.





> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: I've marked the patch as RFC since I'm not 100% sure whether I've
>  correctly identified all devices that should still be marked as hot-
>  pluggable. Feedback is welcome!
> 
>  hw/core/qdev.c        | 10 ++++------
>  hw/cpu/core.c         |  1 +
>  hw/mem/nvdimm.c       |  3 +++
>  hw/mem/pc-dimm.c      |  1 +
>  hw/pci/pci.c          |  1 +
>  hw/s390x/ccw-device.c |  1 +
>  hw/scsi/scsi-bus.c    |  1 +
>  hw/usb/bus.c          |  1 +
>  8 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 606ab53..c4f1902 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1120,13 +1120,11 @@ static void device_class_init(ObjectClass *class, void *data)
>      dc->realize = device_realize;
>      dc->unrealize = device_unrealize;
>  
> -    /* by default all devices were considered as hotpluggable,
> -     * so with intent to check it in generic qdev_unplug() /
> -     * device_set_realized() functions make every device
> -     * hotpluggable. Devices that shouldn't be hotpluggable,
> -     * should override it in their class_init()
> +    /*
> +     * All devices are considered as cold-pluggable by default. The devices
> +     * that are hotpluggable should override it in their class_init().
>       */
> -    dc->hotpluggable = true;
> +    dc->hotpluggable = false;
>      dc->user_creatable = true;
>  }
>  
> diff --git a/hw/cpu/core.c b/hw/cpu/core.c
> index bd578ab..01660aa 100644
> --- a/hw/cpu/core.c
> +++ b/hw/cpu/core.c
> @@ -82,6 +82,7 @@ static void cpu_core_class_init(ObjectClass *oc, void *data)
>      DeviceClass *dc = DEVICE_CLASS(oc);
>  
>      set_bit(DEVICE_CATEGORY_CPU, dc->categories);
> +    dc->hotpluggable = true;
>  }
>  
>  static const TypeInfo cpu_core_type_info = {
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 952fce5..02be9f3 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -148,9 +148,12 @@ static MemoryRegion *nvdimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
>  
>  static void nvdimm_class_init(ObjectClass *oc, void *data)
>  {
> +    DeviceClass *dc = DEVICE_CLASS(oc);
>      PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
>      NVDIMMClass *nvc = NVDIMM_CLASS(oc);
>  
> +    dc->hotpluggable = true;
> +
>      ddc->realize = nvdimm_realize;
>      ddc->get_memory_region = nvdimm_get_memory_region;
>      ddc->get_vmstate_memory_region = nvdimm_get_vmstate_memory_region;
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 66eace5..1f78567 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -443,6 +443,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
>      dc->unrealize = pc_dimm_unrealize;
>      dc->props = pc_dimm_properties;
>      dc->desc = "DIMM memory module";
> +    dc->hotpluggable = true;
>  
>      ddc->get_memory_region = pc_dimm_get_memory_region;
>      ddc->get_vmstate_memory_region = pc_dimm_get_vmstate_memory_region;
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1e6fb88..8db380d 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2534,6 +2534,7 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
>      k->unrealize = pci_qdev_unrealize;
>      k->bus_type = TYPE_PCI_BUS;
>      k->props = pci_props;
> +    k->hotpluggable = true;
>      pc->realize = pci_default_realize;
>  }
>  
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index f9bfa15..d1b6e6f 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -48,6 +48,7 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
>      k->realize = ccw_device_realize;
>      k->refill_ids = ccw_device_refill_ids;
>      dc->props = ccw_device_properties;
> +    dc->hotpluggable = true;
>  }
>  
>  const VMStateDescription vmstate_ccw_dev = {
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index e364410..338180d 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -2123,6 +2123,7 @@ static void scsi_device_class_init(ObjectClass *klass, void *data)
>      k->realize   = scsi_qdev_realize;
>      k->unrealize = scsi_qdev_unrealize;
>      k->props     = scsi_props;
> +    k->hotpluggable = true;
>  }
>  
>  static void scsi_dev_instance_init(Object *obj)
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index d910f84..16701aa 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -793,6 +793,7 @@ static void usb_device_class_init(ObjectClass *klass, void *data)
>      k->realize  = usb_qdev_realize;
>      k->unrealize = usb_qdev_unrealize;
>      k->props    = usb_props;
> +    k->hotpluggable = true;
>  }
>  
>  static const TypeInfo usb_device_type_info = {
> -- 
> 1.8.3.1
> 
> 

-- 
Eduardo
