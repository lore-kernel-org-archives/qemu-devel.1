Received: from eggs.gnu.org ([2001:4830:134:3::10]:59645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0e6-0002dg-KN
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0e0-0005bo-LR
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:17:34 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 12 Dec 2018 10:16:20 +0100
Message-Id: <20181212091623.16950-9-david@redhat.com>
In-Reply-To: <20181212091623.16950-1-david@redhat.com>
References: <20181212091623.16950-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 08/11] pci/pcie: perform unplug via the
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/pci/pcie.c         | 10 +++++++++-
 hw/pci/pcie_port.c    |  1 +
 include/hw/pci/pcie.h |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index ccba29269e..ba3ea925e9 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -364,11 +364,19 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 }
 
-static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
+void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                             Error **errp)
 {
     object_unparent(OBJECT(dev));
 }
 
+static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
+{
+    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(dev));
+
+    hotplug_handler_unplug(hotplug_ctrl, DEVICE(dev), &error_abort);
+}
+
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index 7982a87880..a30291ef54 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -156,6 +156,7 @@ static void pcie_slot_class_init(ObjectClass *oc, void *data)
     dc->props = pcie_slot_props;
     hc->pre_plug = pcie_cap_slot_pre_plug_cb;
     hc->plug = pcie_cap_slot_plug_cb;
+    hc->unplug = pcie_cap_slot_unplug_cb;
     hc->unplug_request = pcie_cap_slot_unplug_request_cb;
 }
 
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index d9fbcf4a4a..9ae6482658 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -135,6 +135,8 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp);
 void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                            Error **errp);
+void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                             Error **errp);
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp);
 #endif /* QEMU_PCIE_H */
-- 
2.17.2
