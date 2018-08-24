Received: from eggs.gnu.org ([2001:4830:134:3::10]:41387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI0r-0006Ww-LH
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI0m-0003xH-Ig
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:44:53 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:59543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI0l-0003vd-0W
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:44:47 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Fri, 24 Aug 2018 15:44:05 -0400
Message-Id: <20819a8ef4216527bccc346de4a50ce14386034c.1535133089.git.jancraig@amazon.com>
In-Reply-To: <cover.1535133088.git.jancraig@amazon.com>
References: <cover.1535133088.git.jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH 4/7] target/mips: Add MXU instruction D16MUL
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

Adds support for emulating the D16MUL instruction.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 target/mips/translate.c | 55 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4ccccd5849..64fc6089bb 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -365,6 +365,7 @@ enum {
     OPC_DCLZ     = 0x24 | OPC_SPECIAL2,
     OPC_DCLO     = 0x25 | OPC_SPECIAL2,
     /* MXU */
+    OPC_MXU_D16MUL = 0x08 | OPC_SPECIAL2,
     OPC_MXU_S8LDD  = 0x22 | OPC_SPECIAL2,
     OPC_MXU_S32I2M = 0x2F | OPC_SPECIAL2,
     OPC_MXU_S32M2I = 0x2E | OPC_SPECIAL2,
@@ -3794,15 +3795,28 @@ typedef union {
         uint32_t rb:5;
         uint32_t special2:6;
     } S8LDD;
+
+    struct {
+        uint32_t op:6;
+        uint32_t xra:4;
+        uint32_t xrb:4;
+        uint32_t xrc:4;
+        uint32_t xrd:4;
+        uint32_t optn2:2;
+        uint32_t sel:2;
+        uint32_t special2:6;
+    } D16MUL;
 } MXU_OPCODE;
 
 /* MXU Instructions */
 static void gen_mxu(DisasContext *ctx, uint32_t opc)
 {
 #ifndef TARGET_MIPS64 /* Only works in 32 bit mode */
-    TCGv t0, t1;
+    TCGv t0, t1, t2, t3;
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
     MXU_OPCODE *opcode = (MXU_OPCODE *)&ctx->opcode;
 
     switch (opc) {
@@ -3882,10 +3896,48 @@ static void gen_mxu(DisasContext *ctx, uint32_t opc)
         }
         gen_store_mxu_gpr(t0, opcode->S8LDD.xra);
         break;
+
+    case OPC_MXU_D16MUL:
+        if (opcode->D16MUL.sel == 1) {
+            /* D16MULE is not supported */
+            generate_exception_end(ctx, EXCP_RI);
+        }
+        gen_load_mxu_gpr(t1, opcode->D16MUL.xrb);
+        tcg_gen_ext16s_tl(t0, t1);
+        tcg_gen_shri_tl(t1, t1, 16);
+        tcg_gen_ext16s_tl(t1, t1);
+        gen_load_mxu_gpr(t3, opcode->D16MUL.xrc);
+        tcg_gen_ext16s_tl(t2, t3);
+        tcg_gen_shri_tl(t3, t3, 16);
+        tcg_gen_ext16s_tl(t3, t3);
+
+        switch (opcode->D16MUL.optn2) {
+        case 0: /* XRB.H*XRC.H == lop, XRB.L*XRC.L == rop */
+            tcg_gen_mul_tl(t3, t1, t3);
+            tcg_gen_mul_tl(t2, t0, t2);
+            break;
+        case 1: /* XRB.L*XRC.H == lop, XRB.L*XRC.L == rop */
+            tcg_gen_mul_tl(t3, t0, t3);
+            tcg_gen_mul_tl(t2, t0, t2);
+            break;
+        case 2: /* XRB.H*XRC.H == lop, XRB.H*XRC.L == rop */
+            tcg_gen_mul_tl(t3, t1, t3);
+            tcg_gen_mul_tl(t2, t1, t2);
+            break;
+        case 3: /* XRB.L*XRC.H == lop, XRB.H*XRC.L == rop */
+            tcg_gen_mul_tl(t3, t0, t3);
+            tcg_gen_mul_tl(t2, t1, t2);
+            break;
+        }
+        gen_store_mxu_gpr(t3, opcode->D16MUL.xra);
+        gen_store_mxu_gpr(t2, opcode->D16MUL.xrd);
+        break;
     }
 
     tcg_temp_free(t0);
     tcg_temp_free(t1);
+    tcg_temp_free(t2);
+    tcg_temp_free(t3);
 #else
     generate_exception_end(ctx, EXCP_RI);
 #endif
@@ -17975,6 +18027,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MXU_S32I2M:
     case OPC_MXU_S32M2I:
     case OPC_MXU_S8LDD:
+    case OPC_MXU_D16MUL:
         gen_mxu(ctx, op1);
         break;
 
-- 
2.18.0
