Received: from eggs.gnu.org ([2001:4830:134:3::10]:49350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ebtFx-0008HO-4s
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ebtFs-0000mx-78
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:20:17 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 17 Jan 2018 21:19:47 +0200
Message-Id: <20180117191947.14082-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/pci-bridge: fix pcie root port's IO hints
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, zuban32s@gmail.com, qemu-stable@nongnu.org

The gen_pcie_root_port mem-reserve and pref32-reserve properties are
defined as size (so uint64_t), but passed as uint32_t when building
the 'IO hints' vendor specific capability.
Passing 4G (or more) gets truncated and passed as a zero reservation.
Is not a huge issue since the guest firmware will always compare the
hints with the default value and take the maximum.

Fix it by passing the values as uint64_t and failing to init the
gen_pcie_root_port id invalid values are used.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci/pci_bridge.c         | 24 +++++++++++++++++++-----
 include/hw/pci/pci_bridge.h |  4 ++--
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index b2e50c36a0..40a39f57cb 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -412,22 +412,36 @@ void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
 
 int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
                                      uint32_t bus_reserve, uint64_t io_reserve,
-                                     uint32_t mem_non_pref_reserve,
-                                     uint32_t mem_pref_32_reserve,
+                                     uint64_t mem_non_pref_reserve,
+                                     uint64_t mem_pref_32_reserve,
                                      uint64_t mem_pref_64_reserve,
                                      Error **errp)
 {
-    if (mem_pref_32_reserve != (uint32_t)-1 &&
+    if (mem_pref_32_reserve != (uint64_t)-1 &&
         mem_pref_64_reserve != (uint64_t)-1) {
         error_setg(errp,
                    "PCI resource reserve cap: PREF32 and PREF64 conflict");
         return -EINVAL;
     }
 
+    if (mem_non_pref_reserve != (uint64_t)-1 &&
+        mem_non_pref_reserve >= (1ULL << 32)) {
+        error_setg(errp,
+                   "PCI resource reserve cap: mem-reserve must be less than 4G");
+        return -EINVAL;
+    }
+
+    if (mem_pref_32_reserve != (uint64_t)-1 &&
+        mem_pref_32_reserve >= (1ULL << 32)) {
+        error_setg(errp,
+                   "PCI resource reserve cap: pref32-reserve  must be less than 4G");
+        return -EINVAL;
+    }
+
     if (bus_reserve == (uint32_t)-1 &&
         io_reserve == (uint64_t)-1 &&
-        mem_non_pref_reserve == (uint32_t)-1 &&
-        mem_pref_32_reserve == (uint32_t)-1 &&
+        mem_non_pref_reserve == (uint64_t)-1 &&
+        mem_pref_32_reserve == (uint64_t)-1 &&
         mem_pref_64_reserve == (uint64_t)-1) {
         return 0;
     }
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 9b44ffd22a..0347da52d2 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -135,8 +135,8 @@ typedef struct PCIBridgeQemuCap {
 
 int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
                               uint32_t bus_reserve, uint64_t io_reserve,
-                              uint32_t mem_non_pref_reserve,
-                              uint32_t mem_pref_32_reserve,
+                              uint64_t mem_non_pref_reserve,
+                              uint64_t mem_pref_32_reserve,
                               uint64_t mem_pref_64_reserve,
                               Error **errp);
 
-- 
2.13.5
