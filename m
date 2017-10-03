Received: from eggs.gnu.org ([2001:4830:134:3::10]:37736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzJHe-0003Z8-Cx
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzJHa-0004hx-Bb
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:34 -0400
Received: from ozlabs.org ([103.22.144.67]:37217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dzJHZ-0004Zi-RZ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Oct 2017 20:14:23 +1100
Message-Id: <20171003091423.28704-6-david@gibson.dropbear.id.au>
In-Reply-To: <20171003091423.28704-1-david@gibson.dropbear.id.au>
References: <20171003091423.28704-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC 5/5] pcie: Don't allow extended config space
 access via conventional PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, ehabkost@redhat.com, marcel@redhat.com
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, David Gibson <david@gibson.dropbear.id.au>

In hardware it's possible, if odd, to have a configuration like:

PCIe host bridge
\- PCIe to PCI bridge
   \- PCI to PCIe bridge
      \- PCIe device

The PCIe extended configuration space on the device won't be accessible to
the host, because the cycles can't traverse the conventional PCI bus on the
way there.

However, if we attempt to model that configuration under qemu, extended
config access on the device *will* work, because pci_config_size() depends
only on whether the device itself is PCIe capable.

This patch fixes that modelling error by adding a flag to each PCI/PCIe bus
instance indicating whether extended config space accesses are possible on
it.  It will always be false for conventional PCI buses, for PCIe buses it
will be true if and only if the parent bus also has the flag set.

AIUI earlier attempts to correct this have been rejected, because they
involved expensively traversing the whole bus heirarchy on each config
access.  This approach avoids that by computing the value as the bus
heirarchy is contructed, meaning we only need a single bit check when we
actually attempt the config access.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci/pci.c         | 12 ++++++++++++
 include/hw/pci/pci.h | 10 +++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4baf591562..b0a757ffd0 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -115,6 +115,18 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
     qemu_add_machine_init_done_notifier(&bus->machine_done);
 
     vmstate_register(NULL, -1, &vmstate_pcibus, bus);
+
+    /* a PCI-E bus can supported extended config space if it's the
+     * root bus, or if the bus/bridge above it does as well */
+    if (pci_bus_is_root(bus)) {
+        bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
+    } else {
+        PCIBus *parent_bus = bus->parent_dev->bus;
+
+        if (pci_bus_extended_config_space(parent_bus)) {
+            bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
+        }
+    }
 }
 
 static void pci_bus_unrealize(BusState *qbus, Error **errp)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index cbb3386207..471c13b50a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -407,6 +407,8 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
 enum PCIBusFlags {
     /* This bus is the root of a PCI domain */
     PCI_BUS_IS_ROOT                                         = 0x0001,
+    /* PCIe extended configuration space is accessible on this bus */
+    PCI_BUS_EXTENDED_CONFIG_SPACE                           = 0x0002,
 };
 
 typedef struct PCIBusClass {
@@ -451,6 +453,11 @@ static inline bool pci_bus_is_root(PCIBus *bus)
     return !!(bus->flags & PCI_BUS_IS_ROOT);
 }
 
+static inline bool pci_bus_extended_config_space(PCIBus *bus)
+{
+    return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
+}
+
 bool pci_bus_is_express(PCIBus *bus);
 void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
                               const char *name,
@@ -785,7 +792,8 @@ static inline int pci_is_express(const PCIDevice *d)
 
 static inline uint32_t pci_config_size(const PCIDevice *d)
 {
-    return pci_is_express(d) ? PCIE_CONFIG_SPACE_SIZE : PCI_CONFIG_SPACE_SIZE;
+    return (pci_is_express(d) && pci_bus_extended_config_space(d->bus))
+        ? PCIE_CONFIG_SPACE_SIZE : PCI_CONFIG_SPACE_SIZE;
 }
 
 static inline uint16_t pci_get_bdf(PCIDevice *dev)
-- 
2.13.6
