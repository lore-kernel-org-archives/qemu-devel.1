Received: from eggs.gnu.org ([2001:4830:134:3::10]:60337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2gv-0003Ib-Vp
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2gu-0008JX-QN
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:05 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZ2gu-0008Id-Eg
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:04 -0400
Received: by mail-lf0-x242.google.com with SMTP id p11so5151583lfd.1
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 15:16:04 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 01:15:40 +0300
Message-Id: <1500761743-1669-4-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH v2 3/6] hw/pci: enable SHPC for PCIE-PCI
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel@redhat.com, kraxel@redhat.com, seabios@seabios.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 hw/pci-bridge/pcie_pci_bridge.c | 63 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 0991a7b..38f665f 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -28,6 +28,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/msi.h"
+#include "hw/pci/shpc.h"
 #include "hw/pci/slotid_cap.h"
 
 typedef struct PCIEPCIBridge {
@@ -35,6 +36,7 @@ typedef struct PCIEPCIBridge {
     PCIBridge parent_obj;
     uint32_t flags;
 
+    MemoryRegion bar;
     /*< public >*/
 } PCIEPCIBridge;
 
@@ -44,11 +46,22 @@ typedef struct PCIEPCIBridge {
 
 static void pciepci_bridge_realize(PCIDevice *d, Error **errp)
 {
+    PCIBridge *br = PCI_BRIDGE(d);
+    PCIEPCIBridge *bridge_dev = PCIE_PCI_BRIDGE_DEV(d);
     int rc, pos;
     Error *local_err = NULL;
 
     pci_bridge_initfn(d, TYPE_PCI_BUS);
 
+    d->config[PCI_INTERRUPT_PIN] = 0x1;
+    memory_region_init(&bridge_dev->bar, OBJECT(d), "shpc-bar",
+                       shpc_bar_size(d));
+    rc = shpc_init(d, &br->sec_bus, &bridge_dev->bar, 0, &local_err);
+    if (rc) {
+        error_propagate(errp, local_err);
+        goto error;
+    }
+
     rc = pcie_cap_init(d, 0, PCI_EXP_TYPE_PCI_BRIDGE, 0, &local_err);
     if (rc < 0) {
         error_propagate(errp, local_err);
@@ -78,6 +91,9 @@ static void pciepci_bridge_realize(PCIDevice *d, Error **errp)
         goto error;
     }
 
+    pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64, &bridge_dev->bar);
+
     return;
 
     error:
@@ -86,7 +102,9 @@ static void pciepci_bridge_realize(PCIDevice *d, Error **errp)
 
 static void pciepci_bridge_exit(PCIDevice *d)
 {
+    PCIEPCIBridge *bridge_dev = PCIE_PCI_BRIDGE_DEV(d);
     pcie_cap_exit(d);
+    shpc_cleanup(d, &bridge_dev->bar);
     pci_bridge_exitfn(d);
 }
 
@@ -95,6 +113,7 @@ static void pciepci_bridge_reset(DeviceState *qdev)
     PCIDevice *d = PCI_DEVICE(qdev);
     pci_bridge_reset(qdev);
     msi_reset(d);
+    shpc_reset(d);
 }
 
 static void pcie_pci_bridge_write_config(PCIDevice *d,
@@ -102,8 +121,15 @@ static void pcie_pci_bridge_write_config(PCIDevice *d,
 {
     pci_bridge_write_config(d, address, val, len);
     msi_write_config(d, address, val, len);
+    shpc_cap_write_config(d, address, val, len);
 }
 
+static bool pci_device_shpc_present(void *opaque, int version_id)
+{
+    PCIDevice *dev = opaque;
+
+    return shpc_present(dev);
+}
 
 static Property pcie_pci_bridge_dev_properties[] = {
         DEFINE_PROP_END_OF_LIST(),
@@ -113,14 +139,43 @@ static const VMStateDescription pciepci_bridge_dev_vmstate = {
         .name = TYPE_PCIE_PCI_BRIDGE_DEV,
         .fields = (VMStateField[]) {
             VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
+            SHPC_VMSTATE(shpc, PCIDevice, pci_device_shpc_present),
             VMSTATE_END_OF_LIST()
         }
 };
 
+static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
+{
+    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
+
+    if (!shpc_present(pci_hotplug_dev)) {
+        error_setg(errp, "standard hotplug controller has been disabled for "
+                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
+        return;
+    }
+    shpc_device_hotplug_cb(hotplug_dev, dev, errp);
+}
+
+static void pcie_pci_bridge_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
+                                                 DeviceState *dev,
+                                                 Error **errp)
+{
+    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
+
+    if (!shpc_present(pci_hotplug_dev)) {
+        error_setg(errp, "standard hotplug controller has been disabled for "
+                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
+        return;
+    }
+    shpc_device_hot_unplug_request_cb(hotplug_dev, dev, errp);
+}
+
 static void pciepci_bridge_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
     k->is_express = 1;
     k->is_bridge = 1;
@@ -134,13 +189,19 @@ static void pciepci_bridge_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &pciepci_bridge_dev_vmstate;
     dc->reset = &pciepci_bridge_reset;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    hc->plug = pcie_pci_bridge_hotplug_cb;
+    hc->unplug_request = pcie_pci_bridge_hot_unplug_request_cb;
 }
 
 static const TypeInfo pciepci_bridge_info = {
         .name = TYPE_PCIE_PCI_BRIDGE_DEV,
         .parent = TYPE_PCI_BRIDGE,
         .instance_size = sizeof(PCIEPCIBridge),
-        .class_init = pciepci_bridge_class_init
+        .class_init = pciepci_bridge_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_HOTPLUG_HANDLER },
+            { },
+        }
 };
 
 static void pciepci_register(void)
-- 
2.7.4
