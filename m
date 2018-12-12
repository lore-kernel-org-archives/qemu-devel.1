Received: from eggs.gnu.org ([2001:4830:134:3::10]:59665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0e9-0002g7-43
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0e6-0005gk-Je
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:17:37 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 12 Dec 2018 10:16:22 +0100
Message-Id: <20181212091623.16950-11-david@redhat.com>
In-Reply-To: <20181212091623.16950-1-david@redhat.com>
References: <20181212091623.16950-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 10/11] pci/shpc: perform unplug via the
 hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>

Introduce and use the "unplug" callback.

This is a preparation for multi-stage hotplug handlers, whereby the bus
hotplug handler is overwritten by the machine hotplug handler. This handler
will then pass control to the bus hotplug handler. So to get this running
cleanly, we also have to make sure to go via the hotplug handler chain when
actually unplugging a device after an unplug request. Lookup the hotplug
handler and call "unplug".

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/pci-bridge/pci_bridge_dev.c  | 10 ++++++++++
 hw/pci-bridge/pcie_pci_bridge.c |  1 +
 hw/pci/shpc.c                   | 11 ++++++++++-
 include/hw/pci/pci_bridge.h     |  2 ++
 include/hw/pci/shpc.h           |  2 ++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index fa0be13ac4..ff6b8323da 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -219,6 +219,15 @@ void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     shpc_device_plug_cb(hotplug_dev, dev, errp);
 }
 
+void pci_bridge_dev_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                              Error **errp)
+{
+    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
+
+    g_assert(shpc_present(pci_hotplug_dev));
+    shpc_device_unplug_cb(hotplug_dev, dev, errp);
+}
+
 void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
@@ -251,6 +260,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &pci_bridge_dev_vmstate;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     hc->plug = pci_bridge_dev_plug_cb;
+    hc->unplug = pci_bridge_dev_unplug_cb;
     hc->unplug_request = pci_bridge_dev_unplug_request_cb;
 }
 
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 0ffea680d5..d491b40d04 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -154,6 +154,7 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
     dc->reset = &pcie_pci_bridge_reset;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     hc->plug = pci_bridge_dev_plug_cb;
+    hc->unplug = pci_bridge_dev_unplug_cb;
     hc->unplug_request = pci_bridge_dev_unplug_request_cb;
 }
 
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 7851bfa8ad..45053b39b9 100644
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
@@ -540,6 +543,12 @@ void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     shpc_interrupt_update(pci_hotplug_dev);
 }
 
+void shpc_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                           Error **errp)
+{
+    object_unparent(OBJECT(dev));
+}
+
 void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp)
 {
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 6e37c7551a..ba488818d2 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -101,6 +101,8 @@ void pci_bridge_exitfn(PCIDevice *pci_dev);
 
 void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp);
+void pci_bridge_dev_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                              Error **errp);
 void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp);
 
diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index 71293aca58..18f6ec1cd5 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -47,6 +47,8 @@ void shpc_cap_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int len);
 
 void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                          Error **errp);
+void shpc_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                           Error **errp);
 void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp);
 
-- 
2.17.2
