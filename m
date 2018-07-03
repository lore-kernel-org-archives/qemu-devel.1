Received: from eggs.gnu.org ([2001:4830:134:3::10]:39829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKW-0002rG-Mu
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKT-0006yn-PD
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:24 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:47 +1000
Message-Id: <20180703055804.13449-19-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/35] target/ppc: Split out gen_ld_atomic
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

Move the guts of LD_ATOMIC to a function.  Use foo_tl for the operations
instead of foo_i32 or foo_i64 specifically.  Use MO_ALIGN instead of an
explicit call to gen_check_align.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 105 ++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 53 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f48fcbeefb..361b178db8 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3095,61 +3095,60 @@ LARX(lbarx, DEF_MEMOP(MO_UB))
 LARX(lharx, DEF_MEMOP(MO_UW))
 LARX(lwarx, DEF_MEMOP(MO_UL))
 
-#define LD_ATOMIC(name, memop, tp, op, eop)                             \
-static void gen_##name(DisasContext *ctx)                               \
-{                                                                       \
-    int len = MEMOP_GET_SIZE(memop);                                    \
-    uint32_t gpr_FC = FC(ctx->opcode);                                  \
-    TCGv EA = tcg_temp_local_new();                                     \
-    TCGv_##tp t0, t1;                                                   \
-                                                                        \
-    gen_addr_register(ctx, EA);                                         \
-    if (len > 1) {                                                      \
-        gen_check_align(ctx, EA, len - 1);                              \
-    }                                                                   \
-    t0 = tcg_temp_new_##tp();                                           \
-    t1 = tcg_temp_new_##tp();                                           \
-    tcg_gen_##op(t0, cpu_gpr[rD(ctx->opcode) + 1]);                     \
-                                                                        \
-    switch (gpr_FC) {                                                   \
-    case 0: /* Fetch and add */                                         \
-        tcg_gen_atomic_fetch_add_##tp(t1, EA, t0, ctx->mem_idx, memop); \
-        break;                                                          \
-    case 1: /* Fetch and xor */                                         \
-        tcg_gen_atomic_fetch_xor_##tp(t1, EA, t0, ctx->mem_idx, memop); \
-        break;                                                          \
-    case 2: /* Fetch and or */                                          \
-        tcg_gen_atomic_fetch_or_##tp(t1, EA, t0, ctx->mem_idx, memop);  \
-        break;                                                          \
-    case 3: /* Fetch and 'and' */                                       \
-        tcg_gen_atomic_fetch_and_##tp(t1, EA, t0, ctx->mem_idx, memop); \
-        break;                                                          \
-    case 8: /* Swap */                                                  \
-        tcg_gen_atomic_xchg_##tp(t1, EA, t0, ctx->mem_idx, memop);      \
-        break;                                                          \
-    case 4:  /* Fetch and max unsigned */                               \
-    case 5:  /* Fetch and max signed */                                 \
-    case 6:  /* Fetch and min unsigned */                               \
-    case 7:  /* Fetch and min signed */                                 \
-    case 16: /* compare and swap not equal */                           \
-    case 24: /* Fetch and increment bounded */                          \
-    case 25: /* Fetch and increment equal */                            \
-    case 28: /* Fetch and decrement bounded */                          \
-        gen_invalid(ctx);                                               \
-        break;                                                          \
-    default:                                                            \
-        /* invoke data storage error handler */                         \
-        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);   \
-    }                                                                   \
-    tcg_gen_##eop(cpu_gpr[rD(ctx->opcode)], t1);                        \
-    tcg_temp_free_##tp(t0);                                             \
-    tcg_temp_free_##tp(t1);                                             \
-    tcg_temp_free(EA);                                                  \
+static void gen_ld_atomic(DisasContext *ctx, TCGMemOp memop)
+{
+    uint32_t gpr_FC = FC(ctx->opcode);
+    TCGv EA = tcg_temp_new();
+    TCGv src, dst;
+
+    gen_addr_register(ctx, EA);
+    dst = cpu_gpr[rD(ctx->opcode)];
+    src = cpu_gpr[rD(ctx->opcode) + 1];
+
+    memop |= MO_ALIGN;
+    switch (gpr_FC) {
+    case 0: /* Fetch and add */
+        tcg_gen_atomic_fetch_add_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 1: /* Fetch and xor */
+        tcg_gen_atomic_fetch_xor_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 2: /* Fetch and or */
+        tcg_gen_atomic_fetch_or_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 3: /* Fetch and 'and' */
+        tcg_gen_atomic_fetch_and_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 8: /* Swap */
+        tcg_gen_atomic_xchg_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 4:  /* Fetch and max unsigned */
+    case 5:  /* Fetch and max signed */
+    case 6:  /* Fetch and min unsigned */
+    case 7:  /* Fetch and min signed */
+    case 16: /* compare and swap not equal */
+    case 24: /* Fetch and increment bounded */
+    case 25: /* Fetch and increment equal */
+    case 28: /* Fetch and decrement bounded */
+        gen_invalid(ctx);
+        break;
+    default:
+        /* invoke data storage error handler */
+        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);
+    }
+    tcg_temp_free(EA);
 }
 
-LD_ATOMIC(lwat, DEF_MEMOP(MO_UL), i32, trunc_tl_i32, extu_i32_tl)
-#if defined(TARGET_PPC64)
-LD_ATOMIC(ldat, DEF_MEMOP(MO_Q), i64, mov_i64, mov_i64)
+static void gen_lwat(DisasContext *ctx)
+{
+    gen_ld_atomic(ctx, DEF_MEMOP(MO_UL));
+}
+
+#ifdef TARGET_PPC64
+static void gen_ldat(DisasContext *ctx)
+{
+    gen_ld_atomic(ctx, DEF_MEMOP(MO_Q));
+}
 #endif
 
 #define ST_ATOMIC(name, memop, tp, op)                                  \
-- 
2.17.1
