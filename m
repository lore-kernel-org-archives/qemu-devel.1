Received: from eggs.gnu.org ([2001:4830:134:3::10]:45479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1px-0007I3-2Z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1pv-0005Cf-Ph
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1pv-0005Bi-GC
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:39 -0500
Date: Thu, 21 Dec 2017 16:28:28 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-7-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 06/25] pci: Move bridge data structures from
 pci_bus.h to pci_bridge.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>, Peter Xu <peterx@redhat.com>

From: David Gibson <david@gibson.dropbear.id.au>

include/hw/pci/pci_bus.h contains several data structures related to PCI
bridges that aren't needed by most users of pci_bus.h.  We already have
a pci_bridge.h, so move them there.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/hw/pci-host/xilinx-pcie.h |  2 +-
 include/hw/pci/pci_bridge.h       | 48 ++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci_bus.h          | 51 ++-------------------------------------
 3 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/include/hw/pci-host/xilinx-pcie.h b/include/hw/pci-host/xilinx-pcie.h
index bec66b2..74c04dc 100644
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
index 1acadc2..9b44ffd 100644
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
index bc34fd0..b7da8f5 100644
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
MST
