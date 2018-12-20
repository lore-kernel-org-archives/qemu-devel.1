Received: from eggs.gnu.org ([2001:4830:134:3::10]:60323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Et-0005PD-MU
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Et-0001UV-0x
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ga3Es-0001SX-Oo
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:06 -0500
Date: Thu, 20 Dec 2018 13:40:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181220183059.20726-38-mst@redhat.com>
References: <20181220183059.20726-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220183059.20726-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 37/44] pci/pcie: perform unplug via the
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
Cc: Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: David Hildenbrand <david@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie.h |  2 ++
 hw/pci/pcie.c         | 10 +++++++++-
 hw/pci/pcie_port.c    |  1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index d51ca23f07..cd318646a2 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -134,6 +134,8 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset);
 
 void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                            Error **errp);
+void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                             Error **errp);
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp);
 #endif /* QEMU_PCIE_H */
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index ec3b1145f3..2d3d8a047b 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -442,11 +442,19 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
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
index 73e81e5847..bc07abc31b 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -155,6 +155,7 @@ static void pcie_slot_class_init(ObjectClass *oc, void *data)
 
     dc->props = pcie_slot_props;
     hc->plug = pcie_cap_slot_plug_cb;
+    hc->unplug = pcie_cap_slot_unplug_cb;
     hc->unplug_request = pcie_cap_slot_unplug_request_cb;
 }
 
-- 
MST
