Received: from eggs.gnu.org ([2001:4830:134:3::10]:39713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKT-0002pS-Md
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKS-0006x1-0q
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:21 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:46 +1000
Message-Id: <20180703055804.13449-18-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/35] target/ppc: Split out gen_load_locked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

Leave only the minimal amount of code within the LDAR macro,
moving the rest of the code into gen_load_locked.  Use MO_ALIGN
and remove the explicit call to gen_check_align.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e751072404..f48fcbeefb 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3070,23 +3070,24 @@ static void gen_isync(DisasContext *ctx)
 
 #define MEMOP_GET_SIZE(x)  (1 << ((x) & MO_SIZE))
 
-#define LARX(name, memop)                                            \
-static void gen_##name(DisasContext *ctx)                            \
-{                                                                    \
-    TCGv t0;                                                         \
-    TCGv gpr = cpu_gpr[rD(ctx->opcode)];                             \
-    int len = MEMOP_GET_SIZE(memop);                                 \
-    gen_set_access_type(ctx, ACCESS_RES);                            \
-    t0 = tcg_temp_local_new();                                       \
-    gen_addr_reg_index(ctx, t0);                                     \
-    if ((len) > 1) {                                                 \
-        gen_check_align(ctx, t0, (len)-1);                           \
-    }                                                                \
-    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop);                \
-    tcg_gen_mov_tl(cpu_reserve, t0);                                 \
-    tcg_gen_mov_tl(cpu_reserve_val, gpr);                            \
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);                           \
-    tcg_temp_free(t0);                                               \
+static void gen_load_locked(DisasContext *ctx, TCGMemOp memop)
+{
+    TCGv gpr = cpu_gpr[rD(ctx->opcode)];
+    TCGv t0 = tcg_temp_new();
+
+    gen_set_access_type(ctx, ACCESS_RES);
+    gen_addr_reg_index(ctx, t0);
+    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
+    tcg_gen_mov_tl(cpu_reserve, t0);
+    tcg_gen_mov_tl(cpu_reserve_val, gpr);
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    tcg_temp_free(t0);
+}
+
+#define LARX(name, memop)                  \
+static void gen_##name(DisasContext *ctx)  \
+{                                          \
+    gen_load_locked(ctx, memop);           \
 }
 
 /* lwarx */
-- 
2.17.1
