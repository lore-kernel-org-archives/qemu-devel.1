Received: from eggs.gnu.org ([209.51.188.92]:54775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3nG-0001Th-Ij
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:41:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3nD-00084G-HG
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:41:53 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  5 Feb 2019 17:41:06 +0100
Message-Id: <20190205164109.25413-8-cohuck@redhat.com>
In-Reply-To: <20190205164109.25413-1-cohuck@redhat.com>
References: <20190205164109.25413-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 07/10] s390x/pci: Fix primary bus number for PCI
 bridges
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
Message-Id: <20190130155733.32742-2-david@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 96c7c18f3f..4200e48fb9 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -896,7 +896,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         qbus_set_hotplug_handler(bus, DEVICE(s), errp);
 
         if (dev->hotplugged) {
-            pci_default_write_config(pdev, PCI_PRIMARY_BUS, s->bus_no, 1);
+            pci_default_write_config(pdev, PCI_PRIMARY_BUS,
+                                     pci_dev_bus_num(pdev), 1);
             s->bus_no += 1;
             pci_default_write_config(pdev, PCI_SECONDARY_BUS, s->bus_no, 1);
             do {
@@ -1049,8 +1050,6 @@ static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
                                       void *opaque)
 {
     S390pciState *s = opaque;
-    unsigned int primary = s->bus_no;
-    unsigned int subordinate = 0xff;
     PCIBus *sec_bus = NULL;
 
     if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=
@@ -1059,7 +1058,7 @@ static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
     }
 
     (s->bus_no)++;
-    pci_default_write_config(pdev, PCI_PRIMARY_BUS, primary, 1);
+    pci_default_write_config(pdev, PCI_PRIMARY_BUS, pci_dev_bus_num(pdev), 1);
     pci_default_write_config(pdev, PCI_SECONDARY_BUS, s->bus_no, 1);
     pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, s->bus_no, 1);
 
@@ -1068,7 +1067,7 @@ static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
         return;
     }
 
-    pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, subordinate, 1);
+    /* Assign numbers to all child bridges. The last is the highest number. */
     pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
                         s390_pci_enumerate_bridge, s);
     pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, s->bus_no, 1);
@@ -1079,6 +1078,10 @@ static void s390_pcihost_reset(DeviceState *dev)
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
