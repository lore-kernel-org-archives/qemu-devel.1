Received: from eggs.gnu.org ([2001:4830:134:3::10]:45909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIho-0005n1-6D
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIhk-0001lg-3o
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:41:24 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:5115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIhj-0001lW-Uq
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:41:20 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Mon, 27 Aug 2018 10:38:03 -0400
Message-Id: <20180827143806.25048-4-jancraig@amazon.com>
In-Reply-To: <20180827143806.25048-1-jancraig@amazon.com>
References: <20180827143806.25048-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v2 3/6] target/mips: Add MXU instruction D16MUL
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
 v1
    - initial patch
 v2
    - changed bitfield usage to extract32
    - used sextract_tl instructions instead of shift and ext

 target/mips/translate.c | 51 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f5725d8eda..8a6b4f2899 100644
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
@@ -3772,11 +3773,13 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
 /* MXU Instructions */
 static void gen_mxu(DisasContext *ctx, uint32_t opc)
 {
-    TCGv t0, t1;
-    uint32_t xra, rb, s8, optn3;
+    TCGv t0, t1, t2, t3;
+    uint32_t rb, xra, xrb, xrc, xrd, s8, sel, optn2, optn3;
 
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
 
     switch (opc) {
     case OPC_MXU_S32I2M:
@@ -3848,10 +3851,53 @@ static void gen_mxu(DisasContext *ctx, uint32_t opc)
         }
         gen_store_mxu_gpr(t0, xra);
         break;
+
+    case OPC_MXU_D16MUL:
+        xra = extract32(ctx->opcode, 6, 4);
+        xrb = extract32(ctx->opcode, 10, 4);
+        xrc = extract32(ctx->opcode, 14, 4);
+        xrd = extract32(ctx->opcode, 18, 4);
+        optn2 = extract32(ctx->opcode, 22, 2);
+        sel = extract32(ctx->opcode, 24, 2);
+
+        if (sel == 1) {
+            /* D16MULE is not supported */
+            generate_exception_end(ctx, EXCP_RI);
+        }
+        gen_load_mxu_gpr(t1, xrb);
+        tcg_gen_sextract_tl(t0, t1, 0, 16);
+        tcg_gen_sextract_tl(t1, t1, 16, 16);
+        gen_load_mxu_gpr(t3, xrc);
+        tcg_gen_sextract_tl(t2, t3, 0, 16);
+        tcg_gen_sextract_tl(t3, t3, 16, 16);
+
+        switch (optn2) {
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
+        gen_store_mxu_gpr(t3, xra);
+        gen_store_mxu_gpr(t2, xrd);
+        break;
     }
 
     tcg_temp_free(t0);
     tcg_temp_free(t1);
+    tcg_temp_free(t2);
+    tcg_temp_free(t3);
 }
 
 /* Godson integer instructions */
@@ -17938,6 +17984,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MXU_S32I2M:
     case OPC_MXU_S32M2I:
     case OPC_MXU_S8LDD:
+    case OPC_MXU_D16MUL:
         gen_mxu(ctx, op1);
         break;
 
-- 
2.18.0
