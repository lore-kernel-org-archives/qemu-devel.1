Received: from eggs.gnu.org ([2001:4830:134:3::10]:33482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fqEWr-0004HL-Bt
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fqEWn-00079Y-QN
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:25:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:21412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1fqEWn-00077o-GU
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:25:13 -0400
From: Jing Liu <jing2.liu@linux.intel.com>
Date: Thu, 16 Aug 2018 17:28:14 +0800
Message-Id: <1534411696-6454-2-git-send-email-jing2.liu@linux.intel.com>
In-Reply-To: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
References: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 1/3] hw/pci: factor PCI reserve resources to
 a separate structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com, lersek@redhat.com, pbonzini@redhat.com, Jing Liu <jing2.liu@linux.intel.com>

Factor "bus_reserve", "io_reserve", "mem_reserve", "pref32_reserve"
and "pref64_reserve" fields of the "GenPCIERootPort" structure out
to "PCIResReserve" structure, so that other PCI bridges can
reuse it to add resource reserve capability.

Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 hw/pci-bridge/gen_pcie_root_port.c | 32 ++++++++++++++++----------------
 hw/pci/pci_bridge.c                | 38 +++++++++++++++++---------------------
 include/hw/pci/pci_bridge.h        | 17 ++++++++++++-----
 3 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index d117e20..babce3c 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -29,12 +29,7 @@ typedef struct GenPCIERootPort {
 
     bool migrate_msix;
 
-    /* additional resources to reserve on firmware init */
-    uint32_t bus_reserve;
-    uint64_t io_reserve;
-    uint64_t mem_reserve;
-    uint64_t pref32_reserve;
-    uint64_t pref64_reserve;
+    PCIResReserve res_reserve;
 } GenPCIERootPort;
 
 static uint8_t gen_rp_aer_vector(const PCIDevice *d)
@@ -82,16 +77,15 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    int rc = pci_bridge_qemu_reserve_cap_init(d, 0, grp->bus_reserve,
-            grp->io_reserve, grp->mem_reserve, grp->pref32_reserve,
-            grp->pref64_reserve, errp);
+    int rc = pci_bridge_qemu_reserve_cap_init(d, 0,
+                                              grp->res_reserve, errp);
 
     if (rc < 0) {
         rpc->parent_class.exit(d);
         return;
     }
 
-    if (!grp->io_reserve) {
+    if (!grp->res_reserve.io_reserve) {
         pci_word_test_and_clear_mask(d->wmask + PCI_COMMAND,
                                      PCI_COMMAND_IO);
         d->wmask[PCI_IO_BASE] = 0;
@@ -117,12 +111,18 @@ static const VMStateDescription vmstate_rp_dev = {
 };
 
 static Property gen_rp_props[] = {
-    DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort, migrate_msix, true),
-    DEFINE_PROP_UINT32("bus-reserve", GenPCIERootPort, bus_reserve, -1),
-    DEFINE_PROP_SIZE("io-reserve", GenPCIERootPort, io_reserve, -1),
-    DEFINE_PROP_SIZE("mem-reserve", GenPCIERootPort, mem_reserve, -1),
-    DEFINE_PROP_SIZE("pref32-reserve", GenPCIERootPort, pref32_reserve, -1),
-    DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort, pref64_reserve, -1),
+    DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort,
+                     migrate_msix, true),
+    DEFINE_PROP_UINT32("bus-reserve", GenPCIERootPort,
+                       res_reserve.bus_reserve, -1),
+    DEFINE_PROP_SIZE("io-reserve", GenPCIERootPort,
+                     res_reserve.io_reserve, -1),
+    DEFINE_PROP_SIZE("mem-reserve", GenPCIERootPort,
+                     res_reserve.mem_reserve, -1),
+    DEFINE_PROP_SIZE("pref32-reserve", GenPCIERootPort,
+                     res_reserve.pref32_reserve, -1),
+    DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,
+                     res_reserve.pref64_reserve, -1),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 40a39f5..15b055e 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -411,38 +411,34 @@ void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
 
 
 int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
-                                     uint32_t bus_reserve, uint64_t io_reserve,
-                                     uint64_t mem_non_pref_reserve,
-                                     uint64_t mem_pref_32_reserve,
-                                     uint64_t mem_pref_64_reserve,
-                                     Error **errp)
+                                     PCIResReserve res, Error **errp)
 {
-    if (mem_pref_32_reserve != (uint64_t)-1 &&
-        mem_pref_64_reserve != (uint64_t)-1) {
+    if (res.pref32_reserve != (uint64_t)-1 &&
+        res.pref64_reserve != (uint64_t)-1) {
         error_setg(errp,
                    "PCI resource reserve cap: PREF32 and PREF64 conflict");
         return -EINVAL;
     }
 
-    if (mem_non_pref_reserve != (uint64_t)-1 &&
-        mem_non_pref_reserve >= (1ULL << 32)) {
+    if (res.mem_reserve != (uint64_t)-1 &&
+        res.mem_reserve >= (1ULL << 32)) {
         error_setg(errp,
                    "PCI resource reserve cap: mem-reserve must be less than 4G");
         return -EINVAL;
     }
 
-    if (mem_pref_32_reserve != (uint64_t)-1 &&
-        mem_pref_32_reserve >= (1ULL << 32)) {
+    if (res.pref32_reserve != (uint64_t)-1 &&
+        res.pref32_reserve >= (1ULL << 32)) {
         error_setg(errp,
                    "PCI resource reserve cap: pref32-reserve  must be less than 4G");
         return -EINVAL;
     }
 
-    if (bus_reserve == (uint32_t)-1 &&
-        io_reserve == (uint64_t)-1 &&
-        mem_non_pref_reserve == (uint64_t)-1 &&
-        mem_pref_32_reserve == (uint64_t)-1 &&
-        mem_pref_64_reserve == (uint64_t)-1) {
+    if (res.bus_reserve == (uint32_t)-1 &&
+        res.io_reserve == (uint64_t)-1 &&
+        res.mem_reserve == (uint64_t)-1 &&
+        res.pref32_reserve == (uint64_t)-1 &&
+        res.pref64_reserve == (uint64_t)-1) {
         return 0;
     }
 
@@ -450,11 +446,11 @@ int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
     PCIBridgeQemuCap cap = {
             .len = cap_len,
             .type = REDHAT_PCI_CAP_RESOURCE_RESERVE,
-            .bus_res = bus_reserve,
-            .io = io_reserve,
-            .mem = mem_non_pref_reserve,
-            .mem_pref_32 = mem_pref_32_reserve,
-            .mem_pref_64 = mem_pref_64_reserve
+            .bus_res = res.bus_reserve,
+            .io = res.io_reserve,
+            .mem = res.mem_reserve,
+            .mem_pref_32 = res.pref32_reserve,
+            .mem_pref_64 = res.pref64_reserve
     };
 
     int offset = pci_add_capability(dev, PCI_CAP_ID_VNDR,
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 0347da5..6186a32 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -133,11 +133,18 @@ typedef struct PCIBridgeQemuCap {
 
 #define REDHAT_PCI_CAP_RESOURCE_RESERVE 1
 
+/*
+ * additional resources to reserve on firmware init
+ */
+typedef struct PCIResReserve {
+    uint32_t bus_reserve;
+    uint64_t io_reserve;
+    uint64_t mem_reserve;
+    uint64_t pref32_reserve;
+    uint64_t pref64_reserve;
+} PCIResReserve;
+
 int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
-                              uint32_t bus_reserve, uint64_t io_reserve,
-                              uint64_t mem_non_pref_reserve,
-                              uint64_t mem_pref_32_reserve,
-                              uint64_t mem_pref_64_reserve,
-                              Error **errp);
+                               PCIResReserve res_reserve, Error **errp);
 
 #endif /* QEMU_PCI_BRIDGE_H */
-- 
1.8.3.1
