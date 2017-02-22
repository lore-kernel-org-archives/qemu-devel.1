Received: from eggs.gnu.org ([2001:4830:134:3::10]:37677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV3-0002yX-Sg
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV2-0007yQ-8Z
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:19 +1100
Message-Id: <20170222063348.32176-15-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/43] target-ppc: generate exception for
 copy/paste
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 255735a..80f9f15 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6132,6 +6132,19 @@ static inline void gen_cp_abort(DisasContext *ctx)
     // Do Nothing
 }
 
+#define GEN_CP_PASTE_NOOP(name)                           \
+static inline void gen_##name(DisasContext *ctx)          \
+{                                                         \
+    /* Generate invalid exception until                   \
+     * we have an implementation of the copy              \
+     * paste facility                                     \
+     */                                                   \
+    gen_invalid(ctx);                                     \
+}
+
+GEN_CP_PASTE_NOOP(copy)
+GEN_CP_PASTE_NOOP(paste)
+
 static void gen_tcheck(DisasContext *ctx)
 {
     if (unlikely(!ctx->tm_enabled)) {
@@ -6281,7 +6294,9 @@ GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
 GEN_HANDLER_E(cnttzw, 0x1F, 0x1A, 0x10, 0x00000000, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(copy, 0x1F, 0x06, 0x18, 0x03C00001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(cp_abort, 0x1F, 0x06, 0x1A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(or, 0x1F, 0x1C, 0x0D, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(xor, 0x1F, 0x1C, 0x09, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(ori, 0x18, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-- 
2.9.3
