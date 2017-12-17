Received: from eggs.gnu.org ([2001:4830:134:3::10]:58822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eQYTI-0006S1-8x
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 07:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eQYTF-0005vl-SB
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 07:55:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eQYTF-0005v2-Le
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 07:55:09 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Sun, 17 Dec 2017 14:54:53 +0200
Message-Id: <20171217125457.3429-2-marcel@redhat.com>
In-Reply-To: <20171217125457.3429-1-marcel@redhat.com>
References: <20171217125457.3429-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2 1/5] pci/shpc: Move function to generic
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
Cc: ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, pbonzini@redhat.com, mst@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

This function should be declared in generic header file so we can
utilize it.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci/shpc.c         | 11 +----------
 include/qemu/cutils.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 69fc14b218..3d22424fd2 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
+#include "qemu/cutils.h"
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
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index f0878eaafa..4895334645 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -164,4 +164,14 @@ bool test_buffer_is_zero_next_accel(void);
 int uleb128_encode_small(uint8_t *out, uint32_t n);
 int uleb128_decode_small(const uint8_t *in, uint32_t *n);
 
+static inline int roundup_pow_of_two(int x)
+{
+    x |= (x >> 1);
+    x |= (x >> 2);
+    x |= (x >> 4);
+    x |= (x >> 8);
+    x |= (x >> 16);
+    return x + 1;
+}
+
 #endif
-- 
2.13.5
