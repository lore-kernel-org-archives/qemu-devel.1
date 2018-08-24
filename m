Received: from eggs.gnu.org ([2001:4830:134:3::10]:41343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI0o-0006Lf-Um
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI0k-0003vk-Sh
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:44:50 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:1250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI0k-0003td-MM
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:44:46 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Fri, 24 Aug 2018 15:44:07 -0400
Message-Id: <38ffde3b6d6eed8b8f302298474dfa992fd752a1.1535133089.git.jancraig@amazon.com>
In-Reply-To: <cover.1535133088.git.jancraig@amazon.com>
References: <cover.1535133088.git.jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH 6/7] target/mips: Add MXU instructions Q8MUL
 and Q8MULSU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, aurelien@aurel32.net, Craig Janeczek <jancraig@amazon.com>

Adds support for emulating the Q8MUL and Q8MULSU instructions.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 target/mips/translate.c | 75 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 221076711d..ae6cfc3d7c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -370,6 +370,7 @@ enum {
     OPC_MXU_S8LDD  = 0x22 | OPC_SPECIAL2,
     OPC_MXU_S32I2M = 0x2F | OPC_SPECIAL2,
     OPC_MXU_S32M2I = 0x2E | OPC_SPECIAL2,
+    OPC_MXU_Q8MUL  = 0x38 | OPC_SPECIAL2,
     /* Special */
     OPC_SDBBP    = 0x3F | OPC_SPECIAL2,
 };
@@ -3818,17 +3819,32 @@ typedef union {
         uint32_t aptn2:2;
         uint32_t special2:6;
     } D16MAC;
+
+    struct {
+        uint32_t op:6;
+        uint32_t xra:4;
+        uint32_t xrb:4;
+        uint32_t xrc:4;
+        uint32_t xrd:4;
+        uint32_t sel:2;
+        uint32_t:2;
+        uint32_t special2:6;
+    } Q8MUL;
 } MXU_OPCODE;
 
 /* MXU Instructions */
 static void gen_mxu(DisasContext *ctx, uint32_t opc)
 {
 #ifndef TARGET_MIPS64 /* Only works in 32 bit mode */
-    TCGv t0, t1, t2, t3;
+    TCGv t0, t1, t2, t3, t4, t5, t6, t7;
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
     t2 = tcg_temp_new();
     t3 = tcg_temp_new();
+    t4 = tcg_temp_new();
+    t5 = tcg_temp_new();
+    t6 = tcg_temp_new();
+    t7 = tcg_temp_new();
     MXU_OPCODE *opcode = (MXU_OPCODE *)&ctx->opcode;
 
     switch (opc) {
@@ -3997,12 +4013,68 @@ static void gen_mxu(DisasContext *ctx, uint32_t opc)
         gen_store_mxu_gpr(t3, opcode->D16MAC.xra);
         gen_store_mxu_gpr(t2, opcode->D16MAC.xrd);
         break;
+
+    case OPC_MXU_Q8MUL:
+        gen_load_mxu_gpr(t3, opcode->Q8MUL.xrb);
+        gen_load_mxu_gpr(t7, opcode->Q8MUL.xrc);
+
+        if (opcode->Q8MUL.sel == 0x2) {
+            /* Q8MULSU */
+            tcg_gen_ext8s_tl(t0, t3);
+            tcg_gen_shri_tl(t3, t3, 8);
+            tcg_gen_ext8s_tl(t1, t3);
+            tcg_gen_shri_tl(t3, t3, 8);
+            tcg_gen_ext8s_tl(t2, t3);
+            tcg_gen_shri_tl(t3, t3, 8);
+            tcg_gen_ext8s_tl(t3, t3);
+        } else {
+            /* Q8MUL */
+            tcg_gen_ext8u_tl(t0, t3);
+            tcg_gen_shri_tl(t3, t3, 8);
+            tcg_gen_ext8u_tl(t1, t3);
+            tcg_gen_shri_tl(t3, t3, 8);
+            tcg_gen_ext8u_tl(t2, t3);
+            tcg_gen_shri_tl(t3, t3, 8);
+            tcg_gen_ext8u_tl(t3, t3);
+        }
+
+        tcg_gen_ext8u_tl(t4, t7);
+        tcg_gen_shri_tl(t7, t7, 8);
+        tcg_gen_ext8u_tl(t5, t7);
+        tcg_gen_shri_tl(t7, t7, 8);
+        tcg_gen_ext8u_tl(t6, t7);
+        tcg_gen_shri_tl(t7, t7, 8);
+        tcg_gen_ext8u_tl(t7, t7);
+
+        tcg_gen_mul_tl(t0, t0, t4);
+        tcg_gen_mul_tl(t1, t1, t5);
+        tcg_gen_mul_tl(t2, t2, t6);
+        tcg_gen_mul_tl(t3, t3, t7);
+
+        tcg_gen_andi_tl(t0, t0, 0xFFFF);
+        tcg_gen_andi_tl(t1, t1, 0xFFFF);
+        tcg_gen_andi_tl(t2, t2, 0xFFFF);
+        tcg_gen_andi_tl(t3, t3, 0xFFFF);
+
+        tcg_gen_shli_tl(t1, t1, 16);
+        tcg_gen_shli_tl(t3, t3, 16);
+
+        tcg_gen_or_tl(t0, t0, t1);
+        tcg_gen_or_tl(t1, t2, t3);
+
+        gen_store_mxu_gpr(t0, opcode->Q8MUL.xrd);
+        gen_store_mxu_gpr(t1, opcode->Q8MUL.xra);
+        break;
     }
 
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
     tcg_temp_free(t3);
+    tcg_temp_free(t4);
+    tcg_temp_free(t5);
+    tcg_temp_free(t6);
+    tcg_temp_free(t7);
 #else
     generate_exception_end(ctx, EXCP_RI);
 #endif
@@ -18094,6 +18166,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MXU_S8LDD:
     case OPC_MXU_D16MUL:
     case OPC_MXU_D16MAC:
+    case OPC_MXU_Q8MUL:
         gen_mxu(ctx, op1);
         break;
 
-- 
2.18.0
