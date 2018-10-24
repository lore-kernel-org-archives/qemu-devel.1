Received: from eggs.gnu.org ([2001:4830:134:3::10]:51658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gFGHL-0005Am-Pl
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gFGHK-0000ha-U3
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:20:43 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 24 Oct 2018 12:19:29 +0200
Message-Id: <20181024101930.20674-7-david@redhat.com>
In-Reply-To: <20181024101930.20674-1-david@redhat.com>
References: <20181024101930.20674-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 6/7] pci/shpc: route unplug via the hotplug
 handler
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

Preparation for multi-stage hotplug handlers.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/pci-bridge/pci_bridge_dev.c  | 14 ++++++++++++++
 hw/pci-bridge/pcie_pci_bridge.c | 14 ++++++++++++++
 hw/pci/shpc.c                   | 11 ++++++++++-
 include/hw/pci/shpc.h           |  2 ++
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 2362dcbc64..978ab2a896 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -225,6 +225,19 @@ static void pci_bridge_dev_hotplug_cb(HotplugHandler *hotplug_dev,
     shpc_device_hotplug_cb(hotplug_dev, dev, errp);
 }
 
+static void pci_bridge_dev_hot_unplug_cb(HotplugHandler *hotplug_dev,
+                                         DeviceState *dev, Error **errp)
+{
+    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
+
+    if (!shpc_present(pci_hotplug_dev)) {
+        error_setg(errp, "standard hotplug controller has been disabled for "
+                   "this %s", TYPE_PCI_BRIDGE_DEV);
+        return;
+    }
+    shpc_device_hot_unplug_cb(hotplug_dev, dev, errp);
+}
+
 static void pci_bridge_dev_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                                  DeviceState *dev,
                                                  Error **errp)
@@ -259,6 +272,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     hc->pre_plug = pci_bridge_dev_pre_plug_cb;
     hc->plug = pci_bridge_dev_hotplug_cb;
+    hc->unplug = pci_bridge_dev_hot_unplug_cb;
     hc->unplug_request = pci_bridge_dev_hot_unplug_request_cb;
 }
 
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index cde8af0a4e..6ca711210e 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -156,6 +156,19 @@ static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
     shpc_device_hotplug_cb(hotplug_dev, dev, errp);
 }
 
+static void pcie_pci_bridge_hot_unplug_cb(HotplugHandler *hotplug_dev,
+                                          DeviceState *dev, Error **errp)
+{
+    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
+
+    if (!shpc_present(pci_hotplug_dev)) {
+        error_setg(errp, "standard hotplug controller has been disabled for "
+                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
+        return;
+    }
+    shpc_device_hot_unplug_cb(hotplug_dev, dev, errp);
+}
+
 static void pcie_pci_bridge_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                                  DeviceState *dev,
                                                  Error **errp)
@@ -188,6 +201,7 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     hc->pre_plug = pcie_pci_bridge_pre_plug_cb;
     hc->plug = pcie_pci_bridge_hotplug_cb;
+    hc->unplug = pcie_pci_bridge_hot_unplug_cb;
     hc->unplug_request = pcie_pci_bridge_hot_unplug_request_cb;
 }
 
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 1caf4a7ee9..591f5189c5 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -238,6 +238,7 @@ static void shpc_invalid_command(SHPCDevice *shpc)
 
 static void shpc_free_devices_in_slot(SHPCDevice *shpc, int slot)
 {
+    HotplugHandler *hotplug_ctrl;
     int devfn;
     int pci_slot = SHPC_IDX_TO_PCI(slot);
     for (devfn = PCI_DEVFN(pci_slot, 0);
@@ -245,7 +246,9 @@ static void shpc_free_devices_in_slot(SHPCDevice *shpc, int slot)
          ++devfn) {
         PCIDevice *affected_dev = shpc->sec_bus->devices[devfn];
         if (affected_dev) {
-            object_unparent(OBJECT(affected_dev));
+            hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(affected_dev));
+            hotplug_handler_unplug(hotplug_ctrl, DEVICE(affected_dev),
+                                   &error_abort);
         }
     }
 }
@@ -541,6 +544,12 @@ void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     shpc_interrupt_update(pci_hotplug_dev);
 }
 
+void shpc_device_hot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp)
+{
+    object_unparent(OBJECT(dev));
+}
+
 void shpc_device_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                        DeviceState *dev, Error **errp)
 {
diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index 82eacf8e96..40c5ac9bfe 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -49,6 +49,8 @@ void shpc_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                              Error **errp);
 void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp);
+void shpc_device_hot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp);
 void shpc_device_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                        DeviceState *dev, Error **errp);
 
-- 
2.17.2
