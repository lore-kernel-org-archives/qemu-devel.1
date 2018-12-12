Received: from eggs.gnu.org ([2001:4830:134:3::10]:59330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0dL-0001zy-Nv
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0dK-0005LA-71
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:16:47 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 12 Dec 2018 10:16:16 +0100
Message-Id: <20181212091623.16950-5-david@redhat.com>
In-Reply-To: <20181212091623.16950-1-david@redhat.com>
References: <20181212091623.16950-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/11] pci/pcie: stop plug/unplug if the
 slot is locked
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

We better stop right away. For now, errors would be partially ignored
(so the guest might get informed or the device might get unplugged),
although actual plug/unplug will be reported as failed to the user.

While at it, properly move the check to the pre_plug handler for the plug
case, as we can test the slot state before the device will be realized.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/pci/pcie.c         | 25 +++++++++++++++++--------
 hw/pci/pcie_port.c    |  1 +
 include/hw/pci/pcie.h |  2 ++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 44737cc1cd..ccba29269e 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -316,10 +316,10 @@ static void pcie_cap_slot_event(PCIDevice *dev, PCIExpressHotPlugEvent event)
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
@@ -330,14 +330,19 @@ static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceState *dev,
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
@@ -367,11 +372,15 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
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
index 73e81e5847..7982a87880 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -154,6 +154,7 @@ static void pcie_slot_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     dc->props = pcie_slot_props;
+    hc->pre_plug = pcie_cap_slot_pre_plug_cb;
     hc->plug = pcie_cap_slot_plug_cb;
     hc->unplug_request = pcie_cap_slot_unplug_request_cb;
 }
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 735f8e8154..d9fbcf4a4a 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -131,6 +131,8 @@ void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset);
 
+void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp);
 void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                            Error **errp);
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
-- 
2.17.2
