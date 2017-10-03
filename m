Received: from eggs.gnu.org ([2001:4830:134:3::10]:37738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzJHe-0003ZB-Ec
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzJHd-0004pc-34
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:34 -0400
Received: from ozlabs.org ([103.22.144.67]:45607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dzJHc-0004ie-DQ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:33 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Oct 2017 20:14:22 +1100
Message-Id: <20171003091423.28704-5-david@gibson.dropbear.id.au>
In-Reply-To: <20171003091423.28704-1-david@gibson.dropbear.id.au>
References: <20171003091423.28704-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC 4/5] pci: Simplify pci_bus_is_root()
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

pci_bus_is_root() currently relies on a method in the PCIBusClass.
But it's always known if a PCI bus is a root bus when we create it, so
using a dynamic method is overkill.

This replaces it with an IS_ROOT bit in a new flags field, which is set on
root buses and otherwise clear.  As a bonus this removes the special
is_root logic from pci_expander_bridge, since it already creates its bus
as a root bus.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

# Conflicts:
#	include/hw/pci/pci_bus.h
---
 hw/pci-bridge/pci_expander_bridge.c |  6 ------
 hw/pci/pci.c                        | 14 ++------------
 include/hw/pci/pci.h                | 12 +++++++++++-
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 5652cf06e9..11dfa9258e 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -65,11 +65,6 @@ static int pxb_bus_num(PCIBus *bus)
     return pxb->bus_nr;
 }
 
-static bool pxb_is_root(PCIBus *bus)
-{
-    return true; /* by definition */
-}
-
 static uint16_t pxb_bus_numa_node(PCIBus *bus)
 {
     PXBDev *pxb = convert_to_pxb(bus->parent_dev);
@@ -82,7 +77,6 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
     PCIBusClass *pbc = PCI_BUS_CLASS(class);
 
     pbc->bus_num = pxb_bus_num;
-    pbc->is_root = pxb_is_root;
     pbc->numa_node = pxb_bus_numa_node;
 }
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index ffaa449ec1..4baf591562 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -126,14 +126,9 @@ static void pci_bus_unrealize(BusState *qbus, Error **errp)
     vmstate_unregister(NULL, &vmstate_pcibus, bus);
 }
 
-static bool pcibus_is_root(PCIBus *bus)
-{
-    return !bus->parent_dev;
-}
-
 static int pcibus_num(PCIBus *bus)
 {
-    if (pcibus_is_root(bus)) {
+    if (pci_bus_is_root(bus)) {
         return 0; /* pci host bridge */
     }
     return bus->parent_dev->config[PCI_SECONDARY_BUS];
@@ -156,7 +151,6 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
     k->unrealize = pci_bus_unrealize;
     k->reset = pcibus_reset;
 
-    pbc->is_root = pcibus_is_root;
     pbc->bus_num = pcibus_num;
     pbc->numa_node = pcibus_numa_node;
 }
@@ -385,6 +379,7 @@ static void pci_root_bus_init(PCIBus *bus, DeviceState *parent,
     bus->slot_reserved_mask = 0x0;
     bus->address_space_mem = address_space_mem;
     bus->address_space_io = address_space_io;
+    bus->flags |= PCI_BUS_IS_ROOT;
 
     /* host bridge */
     QLIST_INIT(&bus->child);
@@ -397,11 +392,6 @@ bool pci_bus_is_express(PCIBus *bus)
     return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
 }
 
-bool pci_bus_is_root(PCIBus *bus)
-{
-    return PCI_BUS_GET_CLASS(bus)->is_root(bus);
-}
-
 void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
                               const char *name,
                               MemoryRegion *address_space_mem,
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 77d92a3dc4..cbb3386207 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -404,6 +404,11 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
 #define PCI_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(PCIBusClass, (obj), TYPE_PCI_BUS)
 #define TYPE_PCIE_BUS "PCIE"
 
+enum PCIBusFlags {
+    /* This bus is the root of a PCI domain */
+    PCI_BUS_IS_ROOT                                         = 0x0001,
+};
+
 typedef struct PCIBusClass {
     /*< private >*/
     BusClass parent_class;
@@ -416,6 +421,7 @@ typedef struct PCIBusClass {
 
 struct PCIBus {
     BusState qbus;
+    enum PCIBusFlags flags;
     PCIIOMMUFunc iommu_fn;
     void *iommu_opaque;
     uint8_t devfn_min;
@@ -440,8 +446,12 @@ struct PCIBus {
     Notifier machine_done;
 };
 
+static inline bool pci_bus_is_root(PCIBus *bus)
+{
+    return !!(bus->flags & PCI_BUS_IS_ROOT);
+}
+
 bool pci_bus_is_express(PCIBus *bus);
-bool pci_bus_is_root(PCIBus *bus);
 void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
                               const char *name,
                               MemoryRegion *address_space_mem,
-- 
2.13.6
