Received: from eggs.gnu.org ([2001:4830:134:3::10]:37755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzJHf-0003Zm-BP
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzJHa-0004i5-C4
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:35 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dzJHZ-0004YA-Pc
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Oct 2017 20:14:20 +1100
Message-Id: <20171003091423.28704-3-david@gibson.dropbear.id.au>
In-Reply-To: <20171003091423.28704-1-david@gibson.dropbear.id.au>
References: <20171003091423.28704-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC 2/5] pci: Move bridge data structures from
 pci_bus.h to pci_bridge.h
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

include/hw/pci/pci_bus.h contains several data structures related to PCI
bridges that aren't needed by most users of pci_bus.h.  We already have
a pci_bridge.h, so move them there.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/pci-host/xilinx-pcie.h |  2 +-
 include/hw/pci/pci_bridge.h       | 48 ++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci_bus.h          | 51 ++-------------------------------------
 3 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/include/hw/pci-host/xilinx-pcie.h b/include/hw/pci-host/xilinx-pcie.h
index bec66b27c5..74c04dc9bb 100644
--- a/include/hw/pci-host/xilinx-pcie.h
+++ b/include/hw/pci-host/xilinx-pcie.h
@@ -23,7 +23,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie_host.h"
 
 #define TYPE_XILINX_PCIE_HOST "xilinx-pcie-host"
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 1acadc2c15..9b44ffd22a 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -27,6 +27,54 @@
 #define QEMU_PCI_BRIDGE_H
 
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
+
+typedef struct PCIBridgeWindows PCIBridgeWindows;
+
+/*
+ * Aliases for each of the address space windows that the bridge
+ * can forward. Mapped into the bridge's parent's address space,
+ * as subregions.
+ */
+struct PCIBridgeWindows {
+    MemoryRegion alias_pref_mem;
+    MemoryRegion alias_mem;
+    MemoryRegion alias_io;
+    /*
+     * When bridge control VGA forwarding is enabled, bridges will
+     * provide positive decode on the PCI VGA defined I/O port and
+     * MMIO ranges.  When enabled forwarding is only qualified on the
+     * I/O and memory enable bits in the bridge command register.
+     */
+    MemoryRegion alias_vga[QEMU_PCI_VGA_NUM_REGIONS];
+};
+
+#define TYPE_PCI_BRIDGE "base-pci-bridge"
+#define PCI_BRIDGE(obj) OBJECT_CHECK(PCIBridge, (obj), TYPE_PCI_BRIDGE)
+
+struct PCIBridge {
+    /*< private >*/
+    PCIDevice parent_obj;
+    /*< public >*/
+
+    /* private member */
+    PCIBus sec_bus;
+    /*
+     * Memory regions for the bridge's address spaces.  These regions are not
+     * directly added to system_memory/system_io or its descendants.
+     * Bridge's secondary bus points to these, so that devices
+     * under the bridge see these regions as its address spaces.
+     * The regions are as large as the entire address space -
+     * they don't take into account any windows.
+     */
+    MemoryRegion address_space_mem;
+    MemoryRegion address_space_io;
+
+    PCIBridgeWindows *windows;
+
+    pci_map_irq_fn map_irq;
+    const char *bus_name;
+};
 
 #define PCI_BRIDGE_DEV_PROP_CHASSIS_NR "chassis_nr"
 #define PCI_BRIDGE_DEV_PROP_MSI        "msi"
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index bc34fd0017..b7da8f555b 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -2,10 +2,10 @@
 #define QEMU_PCI_BUS_H
 
 /*
- * PCI Bus and Bridge datastructures.
+ * PCI Bus datastructures.
  *
  * Do not access the following members directly;
- * use accessor functions in pci.h, pci_bridge.h
+ * use accessor functions in pci.h
  */
 
 typedef struct PCIBusClass {
@@ -44,51 +44,4 @@ struct PCIBus {
     Notifier machine_done;
 };
 
-typedef struct PCIBridgeWindows PCIBridgeWindows;
-
-/*
- * Aliases for each of the address space windows that the bridge
- * can forward. Mapped into the bridge's parent's address space,
- * as subregions.
- */
-struct PCIBridgeWindows {
-    MemoryRegion alias_pref_mem;
-    MemoryRegion alias_mem;
-    MemoryRegion alias_io;
-    /*
-     * When bridge control VGA forwarding is enabled, bridges will
-     * provide positive decode on the PCI VGA defined I/O port and
-     * MMIO ranges.  When enabled forwarding is only qualified on the
-     * I/O and memory enable bits in the bridge command register.
-     */
-    MemoryRegion alias_vga[QEMU_PCI_VGA_NUM_REGIONS];
-};
-
-#define TYPE_PCI_BRIDGE "base-pci-bridge"
-#define PCI_BRIDGE(obj) OBJECT_CHECK(PCIBridge, (obj), TYPE_PCI_BRIDGE)
-
-struct PCIBridge {
-    /*< private >*/
-    PCIDevice parent_obj;
-    /*< public >*/
-
-    /* private member */
-    PCIBus sec_bus;
-    /*
-     * Memory regions for the bridge's address spaces.  These regions are not
-     * directly added to system_memory/system_io or its descendants.
-     * Bridge's secondary bus points to these, so that devices
-     * under the bridge see these regions as its address spaces.
-     * The regions are as large as the entire address space -
-     * they don't take into account any windows.
-     */
-    MemoryRegion address_space_mem;
-    MemoryRegion address_space_io;
-
-    PCIBridgeWindows *windows;
-
-    pci_map_irq_fn map_irq;
-    const char *bus_name;
-};
-
 #endif /* QEMU_PCI_BUS_H */
-- 
2.13.6
