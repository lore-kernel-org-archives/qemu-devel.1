Received: from eggs.gnu.org ([2001:4830:134:3::10]:42619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqgz-00014W-98
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqgt-0005yj-GC
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:45 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:45399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXqgt-0005yH-8T
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:39 -0400
Received: by mail-pf0-x233.google.com with SMTP id a22-v6so8308022pfo.12
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:19:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 09:19:17 -0700
Message-Id: <20180626161921.27941-10-richard.henderson@linaro.org>
In-Reply-To: <20180626161921.27941-1-richard.henderson@linaro.org>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/13] target/ppc: Split out gen_st_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Move the guts of ST_ATOMIC to a function.  Use foo_tl for the operations
instead of foo_i32 or foo_i64 specifically.  Use MO_ALIGN instead of an
explicit call to gen_check_align.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 93 +++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 361b178db8..53ca8f0114 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3151,54 +3151,55 @@ static void gen_ldat(DisasContext *ctx)
 }
 #endif
 
-#define ST_ATOMIC(name, memop, tp, op)                                  \
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
-    case 0: /* add and Store */                                         \
-        tcg_gen_atomic_add_fetch_##tp(t1, EA, t0, ctx->mem_idx, memop); \
-        break;                                                          \
-    case 1: /* xor and Store */                                         \
-        tcg_gen_atomic_xor_fetch_##tp(t1, EA, t0, ctx->mem_idx, memop); \
-        break;                                                          \
-    case 2: /* Or and Store */                                          \
-        tcg_gen_atomic_or_fetch_##tp(t1, EA, t0, ctx->mem_idx, memop);  \
-        break;                                                          \
-    case 3: /* 'and' and Store */                                       \
-        tcg_gen_atomic_and_fetch_##tp(t1, EA, t0, ctx->mem_idx, memop); \
-        break;                                                          \
-    case 4:  /* Store max unsigned */                                   \
-    case 5:  /* Store max signed */                                     \
-    case 6:  /* Store min unsigned */                                   \
-    case 7:  /* Store min signed */                                     \
-    case 24: /* Store twin  */                                          \
-        gen_invalid(ctx);                                               \
-        break;                                                          \
-    default:                                                            \
-        /* invoke data storage error handler */                         \
-        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);   \
-    }                                                                   \
-    tcg_temp_free_##tp(t0);                                             \
-    tcg_temp_free_##tp(t1);                                             \
-    tcg_temp_free(EA);                                                  \
+static void gen_st_atomic(DisasContext *ctx, TCGMemOp memop)
+{
+    uint32_t gpr_FC = FC(ctx->opcode);
+    TCGv EA = tcg_temp_new();
+    TCGv src, discard;
+
+    gen_addr_register(ctx, EA);
+    src = cpu_gpr[rD(ctx->opcode)];
+    discard = tcg_temp_new();
+
+    memop |= MO_ALIGN;
+    switch (gpr_FC) {
+    case 0: /* add and Store */
+        tcg_gen_atomic_add_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
+    case 1: /* xor and Store */
+        tcg_gen_atomic_xor_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
+    case 2: /* Or and Store */
+        tcg_gen_atomic_or_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
+    case 3: /* 'and' and Store */
+        tcg_gen_atomic_and_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
+    case 4:  /* Store max unsigned */
+    case 5:  /* Store max signed */
+    case 6:  /* Store min unsigned */
+    case 7:  /* Store min signed */
+    case 24: /* Store twin  */
+        gen_invalid(ctx);
+        break;
+    default:
+        /* invoke data storage error handler */
+        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);
+    }
+    tcg_temp_free(discard);
+    tcg_temp_free(EA);
 }
 
-ST_ATOMIC(stwat, DEF_MEMOP(MO_UL), i32, trunc_tl_i32)
-#if defined(TARGET_PPC64)
-ST_ATOMIC(stdat, DEF_MEMOP(MO_Q), i64, mov_i64)
+static void gen_stwat(DisasContext *ctx)
+{
+    gen_st_atomic(ctx, DEF_MEMOP(MO_UL));
+}
+
+#ifdef TARGET_PPC64
+static void gen_stdat(DisasContext *ctx)
+{
+    gen_st_atomic(ctx, DEF_MEMOP(MO_Q));
+}
 #endif
 
 static void gen_conditional_store(DisasContext *ctx, TCGMemOp memop)
-- 
2.17.1
