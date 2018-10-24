Received: from eggs.gnu.org ([2001:4830:134:3::10]:51490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gFGH1-0004wp-RA
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gFGGw-0000JQ-CV
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:20:22 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 24 Oct 2018 12:19:28 +0200
Message-Id: <20181024101930.20674-6-david@redhat.com>
In-Reply-To: <20181024101930.20674-1-david@redhat.com>
References: <20181024101930.20674-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 5/7] pci/shpc: move hotplug checks to
 preplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>

Move the checks to the pre_plug handler. I don't see a reason to check
for the PCI slot when unplugging.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/pci-bridge/pci_bridge_dev.c  | 11 ++++++++--
 hw/pci-bridge/pcie_pci_bridge.c | 11 ++++++++--
 hw/pci/shpc.c                   | 36 ++++++++++++++-------------------
 include/hw/pci/shpc.h           |  2 ++
 4 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 97a8e8b6a4..2362dcbc64 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -206,8 +206,8 @@ static const VMStateDescription pci_bridge_dev_vmstate = {
     }
 };
 
-static void pci_bridge_dev_hotplug_cb(HotplugHandler *hotplug_dev,
-                                      DeviceState *dev, Error **errp)
+static void pci_bridge_dev_pre_plug_cb(HotplugHandler *hotplug_dev,
+                                       DeviceState *dev, Error **errp)
 {
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
 
@@ -216,6 +216,12 @@ static void pci_bridge_dev_hotplug_cb(HotplugHandler *hotplug_dev,
                    "this %s", TYPE_PCI_BRIDGE_DEV);
         return;
     }
+    shpc_device_pre_plug_cb(hotplug_dev, dev, errp);
+}
+
+static void pci_bridge_dev_hotplug_cb(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
+{
     shpc_device_hotplug_cb(hotplug_dev, dev, errp);
 }
 
@@ -251,6 +257,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
     dc->props = pci_bridge_dev_properties;
     dc->vmsd = &pci_bridge_dev_vmstate;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    hc->pre_plug = pci_bridge_dev_pre_plug_cb;
     hc->plug = pci_bridge_dev_hotplug_cb;
     hc->unplug_request = pci_bridge_dev_hot_unplug_request_cb;
 }
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 04cf5a6a92..cde8af0a4e 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -137,8 +137,8 @@ static const VMStateDescription pcie_pci_bridge_dev_vmstate = {
         }
 };
 
-static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
-                                      DeviceState *dev, Error **errp)
+static void pcie_pci_bridge_pre_plug_cb(HotplugHandler *hotplug_dev,
+                                        DeviceState *dev, Error **errp)
 {
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
 
@@ -147,6 +147,12 @@ static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
                    "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
         return;
     }
+    shpc_device_pre_plug_cb(hotplug_dev, dev, errp);
+}
+
+static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
+{
     shpc_device_hotplug_cb(hotplug_dev, dev, errp);
 }
 
@@ -180,6 +186,7 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
     dc->props = pcie_pci_bridge_dev_properties;
     dc->reset = &pcie_pci_bridge_reset;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    hc->pre_plug = pcie_pci_bridge_pre_plug_cb;
     hc->plug = pcie_pci_bridge_hotplug_cb;
     hc->unplug_request = pcie_pci_bridge_hot_unplug_request_cb;
 }
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index a8462d48bb..1caf4a7ee9 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -482,13 +482,21 @@ static const MemoryRegionOps shpc_mmio_ops = {
         .max_access_size = 4,
     },
 };
-static void shpc_device_hotplug_common(PCIDevice *affected_dev, int *slot,
-                                       SHPCDevice *shpc, Error **errp)
+
+static inline int shpc_device_get_slot(PCIDevice *dev)
+{
+    return SHPC_PCI_TO_IDX(dev->devfn);
+}
+
+void shpc_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                             Error **errp)
 {
-    int pci_slot = PCI_SLOT(affected_dev->devfn);
-    *slot = SHPC_PCI_TO_IDX(pci_slot);
+    SHPCDevice *shpc = PCI_DEVICE(hotplug_dev)->shpc;
+    PCIDevice *pdev = PCI_DEVICE(dev);
+    int pci_slot = PCI_SLOT(pdev->devfn);
+    int slot = shpc_device_get_slot(pdev);
 
-    if (pci_slot < SHPC_IDX_TO_PCI(0) || *slot >= shpc->nslots) {
+    if (pci_slot < SHPC_IDX_TO_PCI(0) || slot >= shpc->nslots) {
         error_setg(errp, "Unsupported PCI slot %d for standard hotplug "
                    "controller. Valid slots are between %d and %d.",
                    pci_slot, SHPC_IDX_TO_PCI(0),
@@ -500,16 +508,9 @@ static void shpc_device_hotplug_common(PCIDevice *affected_dev, int *slot,
 void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp)
 {
-    Error *local_err = NULL;
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
     SHPCDevice *shpc = pci_hotplug_dev->shpc;
-    int slot;
-
-    shpc_device_hotplug_common(PCI_DEVICE(dev), &slot, shpc, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    int slot = shpc_device_get_slot(PCI_DEVICE(dev));
 
     /* Don't send event when device is enabled during qemu machine creation:
      * it is present on boot, no hotplug event is necessary. We do send an
@@ -543,18 +544,11 @@ void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 void shpc_device_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                        DeviceState *dev, Error **errp)
 {
-    Error *local_err = NULL;
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
     SHPCDevice *shpc = pci_hotplug_dev->shpc;
+    int slot = shpc_device_get_slot(PCI_DEVICE(dev));
     uint8_t state;
     uint8_t led;
-    int slot;
-
-    shpc_device_hotplug_common(PCI_DEVICE(dev), &slot, shpc, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
 
     shpc->config[SHPC_SLOT_EVENT_LATCH(slot)] |= SHPC_SLOT_EVENT_BUTTON;
     state = shpc_get_status(shpc, slot, SHPC_SLOT_STATE_MASK);
diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index ee19fecf61..82eacf8e96 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -45,6 +45,8 @@ void shpc_free(PCIDevice *dev);
 void shpc_cap_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int len);
 
 
+void shpc_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                             Error **errp);
 void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp);
 void shpc_device_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
-- 
2.17.2
