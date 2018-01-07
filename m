Received: from eggs.gnu.org ([2001:4830:134:3::10]:46007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYA7y-00079t-H8
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYA7x-0003Pw-JK
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:32:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eYA7x-0003PU-E2
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:32:37 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Sun,  7 Jan 2018 14:32:20 +0200
Message-Id: <20180107123224.100877-2-marcel@redhat.com>
In-Reply-To: <20180107123224.100877-1-marcel@redhat.com>
References: <20180107123224.100877-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V6 1/5] pci/shpc: Move function to generic
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, pbonzini@redhat.com, mst@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

This function should be declared in generic header file so we can
utilize it.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci/shpc.c             | 13 ++-----------
 include/qemu/host-utils.h | 10 ++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 69fc14b218..a8462d48bb 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
+#include "qemu/host-utils.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "hw/pci/shpc.h"
@@ -122,16 +123,6 @@
 #define SHPC_PCI_TO_IDX(pci_slot) ((pci_slot) - 1)
 #define SHPC_IDX_TO_PHYSICAL(slot) ((slot) + 1)
 
-static int roundup_pow_of_two(int x)
-{
-    x |= (x >> 1);
-    x |= (x >> 2);
-    x |= (x >> 4);
-    x |= (x >> 8);
-    x |= (x >> 16);
-    return x + 1;
-}
-
 static uint16_t shpc_get_status(SHPCDevice *shpc, int slot, uint16_t msk)
 {
     uint8_t *status = shpc->config + SHPC_SLOT_STATUS(slot);
@@ -656,7 +647,7 @@ int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRegion *bar,
 
 int shpc_bar_size(PCIDevice *d)
 {
-    return roundup_pow_of_two(SHPC_SLOT_REG(SHPC_MAX_SLOTS));
+    return pow2roundup32(SHPC_SLOT_REG(SHPC_MAX_SLOTS));
 }
 
 void shpc_cleanup(PCIDevice *d, MemoryRegion *bar)
diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 5ac621cf1f..9fadb3f1ba 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -400,6 +400,16 @@ static inline uint64_t pow2ceil(uint64_t value)
     return 0x8000000000000000ull >> (n - 1);
 }
 
+static inline int pow2roundup32(int x)
+{
+    x |= (x >> 1);
+    x |= (x >> 2);
+    x |= (x >> 4);
+    x |= (x >> 8);
+    x |= (x >> 16);
+    return x + 1;
+}
+
 /**
  * urshift - 128-bit Unsigned Right Shift.
  * @plow: in/out - lower 64-bit integer.
-- 
2.13.5
