Received: from eggs.gnu.org ([2001:4830:134:3::10]:54314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZR-0006Nb-VI
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZQ-0008Rj-99
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZQ-0008RW-2U
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:20 -0500
Date: Thu, 8 Feb 2018 21:09:17 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-23-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 22/26] hw/pci-bridge: fix pcie root port's IO
 hints capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>

From: Marcel Apfelbaum <marcel@redhat.com>

The gen_pcie_root_port mem-reserve and pref32-reserve properties are
defined as size (so uint64_t), but passed as uint32_t when building
the 'IO hints' vendor specific capability.
Passing 4G (or more) gets truncated and passed as a zero reservation.
Is not a huge issue since the guest firmware will always compare the
hints with the default value and take the maximum.

Fix it by passing the values as uint64_t and failing to init the
gen_pcie_root_port id invalid values are used.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci_bridge.h |  4 ++--
 hw/pci/pci_bridge.c         | 24 +++++++++++++++++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 9b44ffd..0347da5 100644
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
 
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index b2e50c3..40a39f5 100644
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
-- 
MST
