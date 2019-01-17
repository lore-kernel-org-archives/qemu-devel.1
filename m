Received: from eggs.gnu.org ([209.51.188.92]:37712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBGw-00034F-UQ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBGv-0000zG-AW
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkBGu-0000QJ-Vq
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:05 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HHERhR000833
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:15:50 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q2tuuhkgq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:15:50 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 17 Jan 2019 17:15:47 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Jan 2019 18:15:38 +0100
In-Reply-To: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154774533865.1208625.7448594915118574500.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v3 11/19] qdev: pass an Object * to
 qbus_set_hotplug_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

Certain devices types, like memory/CPU, are now being handled using a
hotplug interface provided by a top-level MachineClass. Hotpluggable
host bridges are another such device where it makes sense to use a
machine-level hotplug handler. However, unlike those devices,
host-bridges have a parent bus (the main system bus), and devices with
a parent bus use a different mechanism for registering their hotplug
handlers: qbus_set_hotplug_handler(). This interface currently expects
a handler to be a subclass of DeviceClass, but this is not the case
for MachineClass, which derives directly from ObjectClass.

Internally, the interface only requires an ObjectClass, so expose that
in qbus_set_hotplug_handler().

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/pcihp.c               |    2 +-
 hw/acpi/piix4.c               |    2 +-
 hw/char/virtio-serial-bus.c   |    2 +-
 hw/core/bus.c                 |   11 ++---------
 hw/pci/pcie.c                 |    2 +-
 hw/pci/shpc.c                 |    2 +-
 hw/ppc/spapr_pci.c            |    2 +-
 hw/s390x/css-bridge.c         |    2 +-
 hw/s390x/s390-pci-bus.c       |    6 +++---
 hw/scsi/virtio-scsi.c         |    2 +-
 hw/scsi/vmw_pvscsi.c          |    2 +-
 hw/usb/dev-smartcard-reader.c |    2 +-
 include/hw/qdev-core.h        |    3 +--
 13 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 7bc7a723407b..942918132376 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -251,7 +251,7 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
             object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
             PCIBus *sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
 
-            qbus_set_hotplug_handler(BUS(sec), DEVICE(hotplug_dev),
+            qbus_set_hotplug_handler(BUS(sec), OBJECT(hotplug_dev),
                                      &error_abort);
             /* We don't have to overwrite any other hotplug handler yet */
             assert(QLIST_EMPTY(&sec->child));
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 88f9a9ec0912..df8c0db909ce 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -536,7 +536,7 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
 
     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
-    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), DEVICE(s), &error_abort);
+    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s), &error_abort);
 
     piix4_pm_add_propeties(s);
 }
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 04e3ebe3526a..e4310c78f2dc 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1052,7 +1052,7 @@ static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
     /* Spawn a new virtio-serial bus on which the ports will ride as devices */
     qbus_create_inplace(&vser->bus, sizeof(vser->bus), TYPE_VIRTIO_SERIAL_BUS,
                         dev, vdev->bus_name);
-    qbus_set_hotplug_handler(BUS(&vser->bus), DEVICE(vser), errp);
+    qbus_set_hotplug_handler(BUS(&vser->bus), OBJECT(vser), errp);
     vser->bus.vser = vser;
     QTAILQ_INIT(&vser->ports);
 
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 4651f244864c..e09843f6abea 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -22,22 +22,15 @@
 #include "hw/qdev.h"
 #include "qapi/error.h"
 
-static void qbus_set_hotplug_handler_internal(BusState *bus, Object *handler,
-                                              Error **errp)
+void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **errp)
 {
-
     object_property_set_link(OBJECT(bus), OBJECT(handler),
                              QDEV_HOTPLUG_HANDLER_PROPERTY, errp);
 }
 
-void qbus_set_hotplug_handler(BusState *bus, DeviceState *handler, Error **errp)
-{
-    qbus_set_hotplug_handler_internal(bus, OBJECT(handler), errp);
-}
-
 void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp)
 {
-    qbus_set_hotplug_handler_internal(bus, OBJECT(bus), errp);
+    qbus_set_hotplug_handler(bus, OBJECT(bus), errp);
 }
 
 int qbus_walk_children(BusState *bus,
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 2d3d8a047b83..a2287c3eb997 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -534,7 +534,7 @@ void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot)
     dev->exp.hpev_notified = false;
 
     qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev))),
-                             DEVICE(dev), NULL);
+                             OBJECT(dev), NULL);
 }
 
 void pcie_cap_slot_reset(PCIDevice *dev)
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 45053b39b92c..52ccdc5ae3b9 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -648,7 +648,7 @@ int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRegion *bar,
     shpc_cap_update_dword(d);
     memory_region_add_subregion(bar, offset, &shpc->mmio);
 
-    qbus_set_hotplug_handler(BUS(sec_bus), DEVICE(d), NULL);
+    qbus_set_hotplug_handler(BUS(sec_bus), OBJECT(d), NULL);
 
     d->cap_present |= QEMU_PCI_CAP_SHPC;
     return 0;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 0f6a173d5323..e8c9dcaf2250 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1745,7 +1745,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
                                 &sphb->memspace, &sphb->iospace,
                                 PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
     phb->bus = bus;
-    qbus_set_hotplug_handler(BUS(phb->bus), DEVICE(sphb), NULL);
+    qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb), NULL);
 
     /*
      * Initialize PHB address space.
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 1bd6c8b45860..7573c40badbd 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -108,7 +108,7 @@ VirtualCssBus *virtual_css_bus_init(void)
     cbus = VIRTUAL_CSS_BUS(bus);
 
     /* Enable hotplugging */
-    qbus_set_hotplug_handler(bus, dev, &error_abort);
+    qbus_set_hotplug_handler(bus, OBJECT(dev), &error_abort);
 
     css_register_io_adapters(CSS_IO_ADAPTER_VIRTIO, true, false,
                              0, &error_abort);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 15759b6514a5..c01eed2bd35b 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -708,7 +708,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     pci_setup_iommu(b, s390_pci_dma_iommu, s);
 
     bus = BUS(b);
-    qbus_set_hotplug_handler(bus, dev, &local_err);
+    qbus_set_hotplug_handler(bus, OBJECT(dev), &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -716,7 +716,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     phb->bus = b;
 
     s->bus = S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, dev, NULL));
-    qbus_set_hotplug_handler(BUS(s->bus), dev, &local_err);
+    qbus_set_hotplug_handler(BUS(s->bus), OBJECT(dev), &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -844,7 +844,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
 
         bus = BUS(&pb->sec_bus);
-        qbus_set_hotplug_handler(bus, DEVICE(s), errp);
+        qbus_set_hotplug_handler(bus, OBJECT(s), errp);
 
         if (dev->hotplugged) {
             pci_default_write_config(pdev, PCI_PRIMARY_BUS, s->bus_no, 1);
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3aa99717e235..9cf6290c2986 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -893,7 +893,7 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
     scsi_bus_new(&s->bus, sizeof(s->bus), dev,
                  &virtio_scsi_scsi_info, vdev->bus_name);
     /* override default SCSI bus hotplug-handler, with virtio-scsi's one */
-    qbus_set_hotplug_handler(BUS(&s->bus), dev, &error_abort);
+    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev), &error_abort);
 
     virtio_scsi_dataplane_setup(s, errp);
 }
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index a3a019e30a74..584b4be07e79 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1142,7 +1142,7 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
     scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(pci_dev),
                  &pvscsi_scsi_info, NULL);
     /* override default SCSI bus hotplug-handler, with pvscsi's one */
-    qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(s), &error_abort);
+    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(s), &error_abort);
     pvscsi_reset_state(s);
 }
 
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 8f716fc165a3..6b0137bb7699 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1322,7 +1322,7 @@ static void ccid_realize(USBDevice *dev, Error **errp)
     usb_desc_init(dev);
     qbus_create_inplace(&s->bus, sizeof(s->bus), TYPE_CCID_BUS, DEVICE(dev),
                         NULL);
-    qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(dev), &error_abort);
+    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev), &error_abort);
     s->intr = usb_ep_get(dev, USB_TOKEN_IN, CCID_INT_IN_EP);
     s->bulk = usb_ep_get(dev, USB_TOKEN_IN, CCID_BULK_IN_EP);
     s->card = NULL;
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index bc014c1c9fca..e11f6badcc2e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -427,8 +427,7 @@ char *qdev_get_dev_path(DeviceState *dev);
 
 GSList *qdev_build_hotpluggable_device_list(Object *peripheral);
 
-void qbus_set_hotplug_handler(BusState *bus, DeviceState *handler,
-                              Error **errp);
+void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **errp);
 
 void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp);
 
