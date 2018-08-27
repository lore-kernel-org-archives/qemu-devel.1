Received: from eggs.gnu.org ([2001:4830:134:3::10]:46896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIis-0006YU-Do
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIio-0002rM-4T
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:42:30 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:30192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIin-0002q8-Gw
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:42:25 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Mon, 27 Aug 2018 10:38:04 -0400
Message-Id: <20180827143806.25048-5-jancraig@amazon.com>
In-Reply-To: <20180827143806.25048-1-jancraig@amazon.com>
References: <20180827143806.25048-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v2 4/6] target/mips: Add MXU instruction D16MAC
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

Adds support for emulating the D16MAC instruction.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 v1
    - initial patch
 v2
    - changed bitfield usage to extract32
    - used sextract_tl instructions instead of shift and ext

 target/mips/translate.c | 62 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8a6b4f2899..7d37567652 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -366,6 +366,7 @@ enum {
     OPC_DCLO     = 0x25 | OPC_SPECIAL2,
     /* MXU */
     OPC_MXU_D16MUL = 0x08 | OPC_SPECIAL2,
+    OPC_MXU_D16MAC = 0x0A | OPC_SPECIAL2,
     OPC_MXU_S8LDD  = 0x22 | OPC_SPECIAL2,
     OPC_MXU_S32I2M = 0x2F | OPC_SPECIAL2,
     OPC_MXU_S32M2I = 0x2E | OPC_SPECIAL2,
@@ -3774,7 +3775,7 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
 static void gen_mxu(DisasContext *ctx, uint32_t opc)
 {
     TCGv t0, t1, t2, t3;
-    uint32_t rb, xra, xrb, xrc, xrd, s8, sel, optn2, optn3;
+    uint32_t rb, xra, xrb, xrc, xrd, s8, sel, optn2, optn3, aptn2;
 
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
@@ -3892,6 +3893,64 @@ static void gen_mxu(DisasContext *ctx, uint32_t opc)
         gen_store_mxu_gpr(t3, xra);
         gen_store_mxu_gpr(t2, xrd);
         break;
+
+    case OPC_MXU_D16MAC:
+        xra = extract32(ctx->opcode, 6, 4);
+        xrb = extract32(ctx->opcode, 10, 4);
+        xrc = extract32(ctx->opcode, 14, 4);
+        xrd = extract32(ctx->opcode, 18, 4);
+        optn2 = extract32(ctx->opcode, 22, 2);
+        aptn2 = extract32(ctx->opcode, 24, 2);
+
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
+        gen_load_mxu_gpr(t0, xra);
+        gen_load_mxu_gpr(t1, xrd);
+
+        switch (aptn2) {
+        case 0:
+            tcg_gen_add_tl(t3, t0, t3);
+            tcg_gen_add_tl(t2, t1, t2);
+            break;
+        case 1:
+            tcg_gen_add_tl(t3, t0, t3);
+            tcg_gen_sub_tl(t2, t1, t2);
+            break;
+        case 2:
+            tcg_gen_sub_tl(t3, t0, t3);
+            tcg_gen_add_tl(t2, t1, t2);
+            break;
+        case 3:
+            tcg_gen_sub_tl(t3, t0, t3);
+            tcg_gen_sub_tl(t2, t1, t2);
+            break;
+        }
+        gen_store_mxu_gpr(t3, xra);
+        gen_store_mxu_gpr(t2, xrd);
+        break;
     }
 
     tcg_temp_free(t0);
@@ -17985,6 +18044,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MXU_S32M2I:
     case OPC_MXU_S8LDD:
     case OPC_MXU_D16MUL:
+    case OPC_MXU_D16MAC:
         gen_mxu(ctx, op1);
         break;
 
-- 
2.18.0
