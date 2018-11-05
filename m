Received: from eggs.gnu.org ([2001:4830:134:3::10]:53811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJc4N-0007eo-EG
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJc0Z-0001Km-9s
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:21:29 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon,  5 Nov 2018 11:20:42 +0100
Message-Id: <20181105102044.20547-9-david@redhat.com>
In-Reply-To: <20181105102044.20547-1-david@redhat.com>
References: <20181105102044.20547-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/10] pci/pcie: perform unplug via the
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>

Introduce and use the "unplug" callback.

This is a preparation for multi-stage hotplug handlers, whereby the bus
hotplug handler is overwritten by the machine hotplug handler. This handler
will then pass control to the bus hotplug handler. So to get this running
cleanly, we also have to make sure to go via the hotplug handler chain when
actually unplugging a device after an unplug request. Lookup the hotplug
handler and call "unplug".

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
