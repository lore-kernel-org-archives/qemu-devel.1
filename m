Received: from eggs.gnu.org ([209.51.188.92]:46812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gosFK-00074w-Hq
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gosFJ-0008VC-Dv
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:57:50 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Jan 2019 16:57:29 +0100
Message-Id: <20190130155733.32742-3-david@redhat.com>
In-Reply-To: <20190130155733.32742-1-david@redhat.com>
References: <20190130155733.32742-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/6] s390x/pci: Fix hotplugging of PCI
 bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>

When hotplugging a PCI bridge right now to the root port, we resolve
pci_get_bus(pdev)->parent_dev, which results in a SEGFAULT. Hotplugging
really only works right now when hotplugging to another bridge.

Instead, we have to properly check if we are already at the root.

Let's cleanup the code while at it a bit and factor out updating the
subordiante bus number into a separate function. The check for
"old_nr < nr" is right now not strictly necessary, but makes it more
obvious what is actually going on.

Most probably fixing up the topology is not our responsibility when
hotplugging. The guest has to sort this out. But let's keep it for now
and only fix current code to not crash.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b7c4613fde..9b5c5fff60 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -843,6 +843,21 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 }
 
+static void s390_pci_update_subordinate(PCIDevice *dev, uint32_t nr)
+{
+    uint32_t old_nr;
+
+    pci_default_write_config(dev, PCI_SUBORDINATE_BUS, nr, 1);
+    while (!pci_bus_is_root(pci_get_bus(dev))) {
+        dev = pci_get_bus(dev)->parent_dev;
+
+        old_nr = pci_default_read_config(dev, PCI_SUBORDINATE_BUS, 1);
+        if (old_nr < nr) {
+            pci_default_write_config(dev, PCI_SUBORDINATE_BUS, nr, 1);
+        }
+    }
+}
+
 static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
@@ -851,26 +866,21 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     S390PCIBusDevice *pbdev = NULL;
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
-        BusState *bus;
         PCIBridge *pb = PCI_BRIDGE(dev);
-        PCIDevice *pdev = PCI_DEVICE(dev);
 
+        pdev = PCI_DEVICE(dev);
         pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
         pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
 
-        bus = BUS(&pb->sec_bus);
-        qbus_set_hotplug_handler(bus, DEVICE(s), errp);
+        qbus_set_hotplug_handler(BUS(&pb->sec_bus), DEVICE(s), errp);
 
         if (dev->hotplugged) {
             pci_default_write_config(pdev, PCI_PRIMARY_BUS,
                                      pci_dev_bus_num(pdev), 1);
             s->bus_no += 1;
             pci_default_write_config(pdev, PCI_SECONDARY_BUS, s->bus_no, 1);
-            do {
-                pdev = pci_get_bus(pdev)->parent_dev;
-                pci_default_write_config(pdev, PCI_SUBORDINATE_BUS,
-                                         s->bus_no, 1);
-            } while (pci_get_bus(pdev) && pci_dev_bus_num(pdev));
+
+            s390_pci_update_subordinate(pdev, s->bus_no);
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         pdev = PCI_DEVICE(dev);
-- 
2.17.2
