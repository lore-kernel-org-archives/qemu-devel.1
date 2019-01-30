Received: from eggs.gnu.org ([209.51.188.92]:46774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gosFJ-00074G-Ez
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:57:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gosFH-0008Tg-Ez
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:57:49 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Jan 2019 16:57:28 +0100
Message-Id: <20190130155733.32742-2-david@redhat.com>
In-Reply-To: <20190130155733.32742-1-david@redhat.com>
References: <20190130155733.32742-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/6] s390x/pci: Fix primary bus number for
 PCI bridges
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

The primary bus number corresponds always to the bus number of the
bus the bridge is attached to.

Right now, if we have two bridges attached to the same bus (e.g. root
bus) this is however not the case. The first bridge will have primary
bus 0, the second bridge primary bus 1, which is wrong. Fix the assignment.

While at it, drop setting the PCI_SUBORDINATE_BUS temporarily to 0xff.
Setting it temporarily to that value (as discussed e.g. in [1]), is
only relevant for a running system that probes the buses. The value is
effectively unused for us just doing a DFS.

Also add a comment why we have to reassign during every reset (which I
found to be surprising.

Please note that hotplugging of bridges is in general still broken, will
be fixed next.

[1] http://www.science.unitn.it/~fiorella/guidelinux/tlk/node76.html

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index f017c1ded0..b7c4613fde 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -862,7 +862,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         qbus_set_hotplug_handler(bus, DEVICE(s), errp);
 
         if (dev->hotplugged) {
-            pci_default_write_config(pdev, PCI_PRIMARY_BUS, s->bus_no, 1);
+            pci_default_write_config(pdev, PCI_PRIMARY_BUS,
+                                     pci_dev_bus_num(pdev), 1);
             s->bus_no += 1;
             pci_default_write_config(pdev, PCI_SECONDARY_BUS, s->bus_no, 1);
             do {
@@ -1016,8 +1017,6 @@ static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
                                       void *opaque)
 {
     S390pciState *s = opaque;
-    unsigned int primary = s->bus_no;
-    unsigned int subordinate = 0xff;
     PCIBus *sec_bus = NULL;
 
     if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=
@@ -1026,7 +1025,7 @@ static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
     }
 
     (s->bus_no)++;
-    pci_default_write_config(pdev, PCI_PRIMARY_BUS, primary, 1);
+    pci_default_write_config(pdev, PCI_PRIMARY_BUS, pci_dev_bus_num(pdev), 1);
     pci_default_write_config(pdev, PCI_SECONDARY_BUS, s->bus_no, 1);
     pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, s->bus_no, 1);
 
@@ -1035,7 +1034,7 @@ static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
         return;
     }
 
-    pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, subordinate, 1);
+    /* Assign numbers to all child bridges. The last is the highest number. */
     pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
                         s390_pci_enumerate_bridge, s);
     pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, s->bus_no, 1);
@@ -1046,6 +1045,10 @@ static void s390_pcihost_reset(DeviceState *dev)
     S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
     PCIBus *bus = s->parent_obj.bus;
 
+    /*
+     * When resetting a PCI bridge, the assigned numbers are set to 0. So
+     * on every system reset, we also have to reassign numbers.
+     */
     s->bus_no = 0;
     pci_for_each_device(bus, pci_bus_num(bus), s390_pci_enumerate_bridge, s);
 }
-- 
2.17.2
