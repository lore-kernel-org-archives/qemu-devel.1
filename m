Received: from eggs.gnu.org ([2001:4830:134:3::10]:43284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI3y-0000Wq-Uw
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI3r-0006uK-2N
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:48:04 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:61405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI3o-0006nX-L8
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:47:58 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Fri, 24 Aug 2018 15:44:04 -0400
Message-Id: <8c9d8af290bc2086b6d685632bc49806cfd40d0a.1535133089.git.jancraig@amazon.com>
In-Reply-To: <cover.1535133088.git.jancraig@amazon.com>
References: <cover.1535133088.git.jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH 3/7] target/mips: Add MXU instruction S8LDD
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

Adds support for emulating the S8LDD MXU instruction.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 target/mips/translate.c | 82 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 381dfad36e..4ccccd5849 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -365,6 +365,7 @@ enum {
     OPC_DCLZ     = 0x24 | OPC_SPECIAL2,
     OPC_DCLO     = 0x25 | OPC_SPECIAL2,
     /* MXU */
+    OPC_MXU_S8LDD  = 0x22 | OPC_SPECIAL2,
     OPC_MXU_S32I2M = 0x2F | OPC_SPECIAL2,
     OPC_MXU_S32M2I = 0x2E | OPC_SPECIAL2,
     /* Special */
@@ -3784,14 +3785,24 @@ typedef union {
         uint32_t:5;
         uint32_t special2:6;
     } S32M2I;
+
+    struct {
+        uint32_t op:6;
+        uint32_t xra:4;
+        uint32_t s8:8;
+        uint32_t optn3:3;
+        uint32_t rb:5;
+        uint32_t special2:6;
+    } S8LDD;
 } MXU_OPCODE;
 
 /* MXU Instructions */
 static void gen_mxu(DisasContext *ctx, uint32_t opc)
 {
 #ifndef TARGET_MIPS64 /* Only works in 32 bit mode */
-    TCGv t0;
+    TCGv t0, t1;
     t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
     MXU_OPCODE *opcode = (MXU_OPCODE *)&ctx->opcode;
 
     switch (opc) {
@@ -3804,9 +3815,77 @@ static void gen_mxu(DisasContext *ctx, uint32_t opc)
         gen_load_mxu_gpr(t0, opcode->S32M2I.xra);
         gen_store_gpr(t0, opcode->S32M2I.rb);
         break;
+
+    case OPC_MXU_S8LDD:
+        gen_load_gpr(t0, opcode->S8LDD.rb);
+        tcg_gen_movi_tl(t1, opcode->S8LDD.s8);
+        tcg_gen_ext8s_tl(t1, t1);
+        tcg_gen_add_tl(t0, t0, t1);
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_SB);
+        switch (opcode->S8LDD.optn3) {
+        case 0: /*XRa[7:0] = tmp8 */
+            tcg_gen_andi_tl(t1, t1, 0xFF);
+            gen_load_mxu_gpr(t0, opcode->S8LDD.xra);
+            tcg_gen_andi_tl(t0, t0, 0xFFFFFF00);
+            tcg_gen_or_tl(t0, t0, t1);
+            break;
+        case 1: /* XRa[15:8] = tmp8 */
+            tcg_gen_andi_tl(t1, t1, 0xFF);
+            gen_load_mxu_gpr(t0, opcode->S8LDD.xra);
+            tcg_gen_andi_tl(t0, t0, 0xFFFF00FF);
+            tcg_gen_shli_tl(t1, t1, 8);
+            tcg_gen_or_tl(t0, t0, t1);
+            break;
+        case 2: /* XRa[23:16] = tmp8 */
+            tcg_gen_andi_tl(t1, t1, 0xFF);
+            gen_load_mxu_gpr(t0, opcode->S8LDD.xra);
+            tcg_gen_andi_tl(t0, t0, 0xFF00FFFF);
+            tcg_gen_shli_tl(t1, t1, 16);
+            tcg_gen_or_tl(t0, t0, t1);
+            break;
+        case 3: /* XRa[31:24] = tmp8 */
+            tcg_gen_andi_tl(t1, t1, 0xFF);
+            gen_load_mxu_gpr(t0, opcode->S8LDD.xra);
+            tcg_gen_andi_tl(t0, t0, 0x00FFFFFF);
+            tcg_gen_shli_tl(t1, t1, 24);
+            tcg_gen_or_tl(t0, t0, t1);
+            break;
+        case 4: /* XRa = {8'b0, tmp8, 8'b0, tmp8} */
+            tcg_gen_andi_tl(t1, t1, 0xFF);
+            tcg_gen_mov_tl(t0, t1);
+            tcg_gen_shli_tl(t1, t1, 16);
+            tcg_gen_or_tl(t0, t0, t1);
+            break;
+        case 5: /* XRa = {tmp8, 8'b0, tmp8, 8'b0} */
+            tcg_gen_andi_tl(t1, t1, 0xFF);
+            tcg_gen_shli_tl(t1, t1, 8);
+            tcg_gen_mov_tl(t0, t1);
+            tcg_gen_shli_tl(t1, t1, 16);
+            tcg_gen_or_tl(t0, t0, t1);
+            break;
+        case 6: /* XRa = {{8{sign of tmp8}}, tmp8, {8{sign of tmp8}}, tmp8} */
+            tcg_gen_mov_tl(t0, t1);
+            tcg_gen_andi_tl(t0, t0, 0xFF00FFFF);
+            tcg_gen_shli_tl(t1, t1, 16);
+            tcg_gen_or_tl(t0, t0, t1);
+            break;
+        case 7: /* XRa = {tmp8, tmp8, tmp8, tmp8} */
+            tcg_gen_andi_tl(t1, t1, 0xFF);
+            tcg_gen_mov_tl(t0, t1);
+            tcg_gen_shli_tl(t1, t1, 8);
+            tcg_gen_or_tl(t0, t0, t1);
+            tcg_gen_shli_tl(t1, t1, 8);
+            tcg_gen_or_tl(t0, t0, t1);
+            tcg_gen_shli_tl(t1, t1, 8);
+            tcg_gen_or_tl(t0, t0, t1);
+            break;
+        }
+        gen_store_mxu_gpr(t0, opcode->S8LDD.xra);
+        break;
     }
 
     tcg_temp_free(t0);
+    tcg_temp_free(t1);
 #else
     generate_exception_end(ctx, EXCP_RI);
 #endif
@@ -17895,6 +17974,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     case OPC_MXU_S32I2M:
     case OPC_MXU_S32M2I:
+    case OPC_MXU_S8LDD:
         gen_mxu(ctx, op1);
         break;
 
-- 
2.18.0
