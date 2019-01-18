Received: from eggs.gnu.org ([209.51.188.92]:52467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7t-0005C6-0i
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7s-0001iT-1f
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:56 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Jan 2019 13:19:22 +0100
Message-Id: <20190118121925.24468-9-cohuck@redhat.com>
In-Reply-To: <20190118121925.24468-1-cohuck@redhat.com>
References: <20190118121925.24468-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 08/11] s390x/pci: Move some hotplug checks to
 the pre_plug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's move most of the checks to the new pre_plug handler. As a PCI
bridge is just a PCI device, we can simplify the code.

Notes: We cannot yet move the MSIX check or device ID creation +
zPCI device creation to the pre_plug handler as both parts are not
fixed before actual device realization (and therefore after pre_plug and
before plug). Once that part is factored out, we can move these parts to
the pre_plug handler, too and therefore remove all possible errors from
the plug handler.

Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190114103110.10909-3-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 248e0eb295..c467cc526b 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -818,11 +818,31 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
     }
 
     pbdev->idx = idx;
-    s->next_idx = (idx + 1) & FH_MASK_INDEX;
-
     return true;
 }
 
+static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                   Error **errp)
+{
+    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        PCIDevice *pdev = PCI_DEVICE(dev);
+
+        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+            error_setg(errp, "multifunction not supported in s390");
+            return;
+        }
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
+        S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
+
+        if (!s390_pci_alloc_idx(s, pbdev)) {
+            error_setg(errp, "no slot for plugging zpci device");
+            return;
+        }
+    }
+}
+
 static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
@@ -835,11 +855,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         PCIBridge *pb = PCI_BRIDGE(dev);
         PCIDevice *pdev = PCI_DEVICE(dev);
 
-        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
-            error_setg(errp, "multifunction not supported in s390");
-            return;
-        }
-
         pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
         pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
 
@@ -859,11 +874,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         pdev = PCI_DEVICE(dev);
 
-        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
-            error_setg(errp, "multifunction not supported in s390");
-            return;
-        }
-
         if (!dev->id) {
             /* In the case the PCI device does not define an id */
             /* we generate one based on the PCI address         */
@@ -905,10 +915,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         pbdev = S390_PCI_DEVICE(dev);
 
-        if (!s390_pci_alloc_idx(s, pbdev)) {
-            error_setg(errp, "no slot for plugging zpci device");
-            return;
-        }
+        /* the allocated idx is actually getting used */
+        s->next_idx = (pbdev->idx + 1) & FH_MASK_INDEX;
         pbdev->fh = pbdev->idx;
         QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
         g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
@@ -1045,6 +1053,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
 
     dc->reset = s390_pcihost_reset;
     dc->realize = s390_pcihost_realize;
+    hc->pre_plug = s390_pcihost_pre_plug;
     hc->plug = s390_pcihost_plug;
     hc->unplug = s390_pcihost_unplug;
     msi_nonbroken = true;
-- 
2.17.2
