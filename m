Received: from eggs.gnu.org ([209.51.188.92]:32874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUwO-0005ln-P2
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUwN-0001xL-DU
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUwM-0001tV-JE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:03 -0500
Date: Tue, 15 Jan 2019 15:03:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-2-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 01/49] pci/pcie: stop plug/unplug if the slot
 is locked
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

We better stop right away. For now, errors would be partially ignored
(so the guest might get informed or the device might get unplugged),
although actual plug/unplug will be reported as failed to the user.

While at it, properly move the check to the pre_plug handler for the plug
case, as we can test the slot state before the device will be realized.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie.h |  2 ++
 hw/pci/pcie.c         | 25 +++++++++++++++++--------
 hw/pci/pcie_port.c    |  1 +
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index cd318646a2..5b82a0d244 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -132,6 +132,8 @@ void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset);
 
+void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp);
 void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                            Error **errp);
 void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 2d3d8a047b..230478faab 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -391,10 +391,10 @@ static void pcie_cap_slot_event(PCIDevice *dev, PCIExpressHotPlugEvent event)
 }
 
 static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceState *dev,
-                                      uint8_t **exp_cap, Error **errp)
+                                      Error **errp)
 {
-    *exp_cap = hotplug_dev->config + hotplug_dev->exp.exp_cap;
-    uint16_t sltsta = pci_get_word(*exp_cap + PCI_EXP_SLTSTA);
+    uint8_t *exp_cap = hotplug_dev->config + hotplug_dev->exp.exp_cap;
+    uint16_t sltsta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
 
     PCIE_DEV_PRINTF(PCI_DEVICE(dev), "hotplug state: 0x%x\n", sltsta);
     if (sltsta & PCI_EXP_SLTSTA_EIS) {
@@ -405,14 +405,19 @@ static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceState *dev,
     }
 }
 
+void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp)
+{
+    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, errp);
+}
+
 void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                            Error **errp)
 {
-    uint8_t *exp_cap;
+    PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
+    uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
     PCIDevice *pci_dev = PCI_DEVICE(dev);
 
-    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap, errp);
-
     /* Don't send event when device is enabled during qemu machine creation:
      * it is present on boot, no hotplug event is necessary. We do send an
      * event when the device is disabled later. */
@@ -458,11 +463,15 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
-    uint8_t *exp_cap;
+    Error *local_err = NULL;
     PCIDevice *pci_dev = PCI_DEVICE(dev);
     PCIBus *bus = pci_get_bus(pci_dev);
 
-    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap, errp);
+    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     /* In case user cancel the operation of multi-function hot-add,
      * remove the function that is unexposed to guest individually,
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index bc07abc31b..a30291ef54 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -154,6 +154,7 @@ static void pcie_slot_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     dc->props = pcie_slot_props;
+    hc->pre_plug = pcie_cap_slot_pre_plug_cb;
     hc->plug = pcie_cap_slot_plug_cb;
     hc->unplug = pcie_cap_slot_unplug_cb;
     hc->unplug_request = pcie_cap_slot_unplug_request_cb;
-- 
MST
