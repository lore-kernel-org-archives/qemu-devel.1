Received: from eggs.gnu.org ([2001:4830:134:3::10]:60483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3F0-0005aZ-Ct
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Ew-0001fI-VW
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ga3Ew-0001Y8-J8
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:10 -0500
Date: Thu, 20 Dec 2018 13:40:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181220183059.20726-39-mst@redhat.com>
References: <20181220183059.20726-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220183059.20726-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 38/44] pci: Reuse pci-bridge hotplug handler
 handlers for pcie-pci-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: David Hildenbrand <david@redhat.com>

These functions are essentially the same, we only have to use
object_get_typename() for reporting errors. So let's share the
implementation of hotplug handler callbacks.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci_bridge.h     |  4 ++++
 hw/pci-bridge/pci_bridge_dev.c  | 12 ++++++------
 hw/pci-bridge/pcie_pci_bridge.c | 30 ++----------------------------
 3 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index cdff7edfd1..6e37c7551a 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -99,6 +99,10 @@ void pci_bridge_reset(DeviceState *qdev);
 void pci_bridge_initfn(PCIDevice *pci_dev, const char *typename);
 void pci_bridge_exitfn(PCIDevice *pci_dev);
 
+void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                            Error **errp);
+void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp);
 
 /*
  * before qdev initialization(qdev_init()), this function sets bus_name and
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index e1df9a52ac..fa0be13ac4 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -206,27 +206,27 @@ static const VMStateDescription pci_bridge_dev_vmstate = {
     }
 };
 
-static void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev,
-                                   DeviceState *dev, Error **errp)
+void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                            Error **errp)
 {
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
 
     if (!shpc_present(pci_hotplug_dev)) {
         error_setg(errp, "standard hotplug controller has been disabled for "
-                   "this %s", TYPE_PCI_BRIDGE_DEV);
+                   "this %s", object_get_typename(OBJECT(hotplug_dev)));
         return;
     }
     shpc_device_plug_cb(hotplug_dev, dev, errp);
 }
 
-static void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
-                                             DeviceState *dev, Error **errp)
+void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
 {
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
 
     if (!shpc_present(pci_hotplug_dev)) {
         error_setg(errp, "standard hotplug controller has been disabled for "
-                   "this %s", TYPE_PCI_BRIDGE_DEV);
+                   "this %s", object_get_typename(OBJECT(hotplug_dev)));
         return;
     }
     shpc_device_unplug_request_cb(hotplug_dev, dev, errp);
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index c634353b06..0ffea680d5 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -137,32 +137,6 @@ static const VMStateDescription pcie_pci_bridge_dev_vmstate = {
         }
 };
 
-static void pcie_pci_bridge_plug_cb(HotplugHandler *hotplug_dev,
-                                    DeviceState *dev, Error **errp)
-{
-    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
-
-    if (!shpc_present(pci_hotplug_dev)) {
-        error_setg(errp, "standard hotplug controller has been disabled for "
-                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
-        return;
-    }
-    shpc_device_plug_cb(hotplug_dev, dev, errp);
-}
-
-static void pcie_pci_bridge_unplug_request_cb(HotplugHandler *hotplug_dev,
-                                              DeviceState *dev, Error **errp)
-{
-    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
-
-    if (!shpc_present(pci_hotplug_dev)) {
-        error_setg(errp, "standard hotplug controller has been disabled for "
-                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
-        return;
-    }
-    shpc_device_unplug_request_cb(hotplug_dev, dev, errp);
-}
-
 static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -179,8 +153,8 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
     dc->props = pcie_pci_bridge_dev_properties;
     dc->reset = &pcie_pci_bridge_reset;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    hc->plug = pcie_pci_bridge_plug_cb;
-    hc->unplug_request = pcie_pci_bridge_unplug_request_cb;
+    hc->plug = pci_bridge_dev_plug_cb;
+    hc->unplug_request = pci_bridge_dev_unplug_request_cb;
 }
 
 static const TypeInfo pcie_pci_bridge_info = {
-- 
MST
