Received: from eggs.gnu.org ([2001:4830:134:3::10]:58260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da4AM-000471-TC
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da4AI-00047q-88
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:02:42 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:46073)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da4AH-00045q-Rc
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:02:38 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 86DE6113EF1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:02:36 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:02:28 +0200
Message-ID: <150100574883.27487.14886260798861983416.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 21/26] qdev: pass an Object * to
 qbus_set_hotplug_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

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
---
Changes since RFC:
- rebased against ppc-for-2.10
- changed qbus_set_hotplug_handler() declaration and dropped
  qbus_set_hotplug_handler_internal() (Paolo)
- updated title and changelog accordingly
---
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
 12 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index f276967365c4..f99c7438235e 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -447,7 +447,7 @@ static void piix4_update_bus_hotplug(PCIBus *pci_bus, void *opaque)
 
     /* pci_bus cannot outlive PIIX4PMState, because /machine keeps it alive
      * and it's not hot-unpluggable */
-    qbus_set_hotplug_handler(BUS(pci_bus), DEVICE(s), &error_abort);
+    qbus_set_hotplug_handler(BUS(pci_bus), OBJECT(s), &error_abort);
 }
 
 static void piix4_pm_machine_ready(Notifier *n, void *opaque)
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index f5bc173844e4..4880236f4258 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1042,7 +1042,7 @@ static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
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
index 32191f2a55f7..52d9ff947f7c 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -443,7 +443,7 @@ void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot)
     dev->exp.hpev_notified = false;
 
     qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev))),
-                             DEVICE(dev), NULL);
+                             OBJECT(dev), NULL);
 }
 
 void pcie_cap_slot_reset(PCIDevice *dev)
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 69fc14b218d8..feed8a45e535 100644
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
index 54533d8a3841..b73e099e0285 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1714,7 +1714,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
                            &sphb->memspace, &sphb->iospace,
                            PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
     phb->bus = bus;
-    qbus_set_hotplug_handler(BUS(phb->bus), DEVICE(sphb), NULL);
+    qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb), NULL);
 
     /*
      * Initialize PHB address space.
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index c4a9735d7108..19eda77979d1 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -107,7 +107,7 @@ VirtualCssBus *virtual_css_bus_init(void)
     cbus->squash_mcss = s390_get_squash_mcss();
 
     /* Enable hotplugging */
-    qbus_set_hotplug_handler(bus, dev, &error_abort);
+    qbus_set_hotplug_handler(bus, OBJECT(dev), &error_abort);
 
     css_register_io_adapters(CSS_IO_ADAPTER_VIRTIO, true, false,
                              0, &error_abort);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 61cfd2138f68..503b7ae05abb 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -566,11 +566,11 @@ static int s390_pcihost_init(SysBusDevice *dev)
     pci_setup_iommu(b, s390_pci_dma_iommu, s);
 
     bus = BUS(b);
-    qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
+    qbus_set_hotplug_handler(bus, OBJECT(dev), NULL);
     phb->bus = b;
 
     s->bus = S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, DEVICE(s), NULL));
-    qbus_set_hotplug_handler(BUS(s->bus), DEVICE(s), NULL);
+    qbus_set_hotplug_handler(BUS(s->bus), OBJECT(s), NULL);
 
     s->iommu_table = g_hash_table_new_full(g_int64_hash, g_int64_equal,
                                            NULL, g_free);
@@ -678,7 +678,7 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
         pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
 
         bus = BUS(&pb->sec_bus);
-        qbus_set_hotplug_handler(bus, DEVICE(s), errp);
+        qbus_set_hotplug_handler(bus, OBJECT(s), errp);
 
         if (dev->hotplugged) {
             pci_default_write_config(pdev, PCI_PRIMARY_BUS, s->bus_no, 1);
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index eb639442d192..b4c26d4862b5 100644
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
index 4a106da85646..036e44caca42 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1146,7 +1146,7 @@ pvscsi_init(PCIDevice *pci_dev)
     scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(pci_dev),
                  &pvscsi_scsi_info, NULL);
     /* override default SCSI bus hotplug-handler, with pvscsi's one */
-    qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(s), &error_abort);
+    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(s), &error_abort);
     pvscsi_reset_state(s);
 
     return 0;
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index bef1f03c426b..f2a86de6c556 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1337,7 +1337,7 @@ static void ccid_realize(USBDevice *dev, Error **errp)
     usb_desc_init(dev);
     qbus_create_inplace(&s->bus, sizeof(s->bus), TYPE_CCID_BUS, DEVICE(dev),
                         NULL);
-    qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(dev), &error_abort);
+    qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev), &error_abort);
     s->intr = usb_ep_get(dev, USB_TOKEN_IN, CCID_INT_IN_EP);
     s->bulk = usb_ep_get(dev, USB_TOKEN_IN, CCID_BULK_IN_EP);
     s->card = NULL;
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9237b6849ff3..ce01ff42850b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -397,8 +397,7 @@ char *qdev_get_dev_path(DeviceState *dev);
 
 GSList *qdev_build_hotpluggable_device_list(Object *peripheral);
 
-void qbus_set_hotplug_handler(BusState *bus, DeviceState *handler,
-                              Error **errp);
+void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **errp);
 
 void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp);
 
