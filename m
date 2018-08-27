Received: from eggs.gnu.org ([2001:4830:134:3::10]:45360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIf5-00022m-72
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIf0-0000Au-Te
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:35 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:62974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIf0-0000Ak-Lk
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:30 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Mon, 27 Aug 2018 10:38:05 -0400
Message-Id: <20180827143806.25048-6-jancraig@amazon.com>
In-Reply-To: <20180827143806.25048-1-jancraig@amazon.com>
References: <20180827143806.25048-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v2 5/6] target/mips: Add MXU instructions Q8MUL
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
 v1
    - initial patch
 v2
    - changed bitfield usage to extract32

 target/mips/translate.c | 70 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7d37567652..e2def36b03 100644
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
@@ -3774,13 +3775,17 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
 /* MXU Instructions */
 static void gen_mxu(DisasContext *ctx, uint32_t opc)
 {
-    TCGv t0, t1, t2, t3;
+    TCGv t0, t1, t2, t3, t4, t5, t6, t7;
     uint32_t rb, xra, xrb, xrc, xrd, s8, sel, optn2, optn3, aptn2;
 
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
     t2 = tcg_temp_new();
     t3 = tcg_temp_new();
+    t4 = tcg_temp_new();
+    t5 = tcg_temp_new();
+    t6 = tcg_temp_new();
+    t7 = tcg_temp_new();
 
     switch (opc) {
     case OPC_MXU_S32I2M:
@@ -3951,12 +3956,74 @@ static void gen_mxu(DisasContext *ctx, uint32_t opc)
         gen_store_mxu_gpr(t3, xra);
         gen_store_mxu_gpr(t2, xrd);
         break;
+
+    case OPC_MXU_Q8MUL:
+        xra = extract32(ctx->opcode, 6, 4);
+        xrb = extract32(ctx->opcode, 10, 4);
+        xrc = extract32(ctx->opcode, 14, 4);
+        xrd = extract32(ctx->opcode, 18, 4);
+        sel = extract32(ctx->opcode, 22, 4);
+
+        gen_load_mxu_gpr(t3, xrb);
+        gen_load_mxu_gpr(t7, xrc);
+
+        if (sel == 0x2) {
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
+        gen_store_mxu_gpr(t0, xrd);
+        gen_store_mxu_gpr(t1, xra);
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
 }
 
 /* Godson integer instructions */
@@ -18045,6 +18112,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MXU_S8LDD:
     case OPC_MXU_D16MUL:
     case OPC_MXU_D16MAC:
+    case OPC_MXU_Q8MUL:
         gen_mxu(ctx, op1);
         break;
 
-- 
2.18.0
