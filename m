Received: from eggs.gnu.org ([2001:4830:134:3::10]:45329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIf0-0001zt-14
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIev-00006w-Qj
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:29 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIev-00006I-G5
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:25 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Mon, 27 Aug 2018 10:38:02 -0400
Message-Id: <20180827143806.25048-3-jancraig@amazon.com>
In-Reply-To: <20180827143806.25048-1-jancraig@amazon.com>
References: <20180827143806.25048-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v2 2/6] target/mips: Add MXU instruction S8LDD
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
 v1
    - initial patch
 v2
    - changed bitfield usage to extract32
    - used deposit_tl instructions instead of shift and bitmask

 target/mips/translate.c | 62 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ef819d67e0..f5725d8eda 100644
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
@@ -3771,10 +3772,11 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
 /* MXU Instructions */
 static void gen_mxu(DisasContext *ctx, uint32_t opc)
 {
-    TCGv t0;
-    uint32_t xra, rb;
+    TCGv t0, t1;
+    uint32_t xra, rb, s8, optn3;
 
     t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
 
     switch (opc) {
     case OPC_MXU_S32I2M:
@@ -3792,9 +3794,64 @@ static void gen_mxu(DisasContext *ctx, uint32_t opc)
         gen_load_mxu_gpr(t0, xra);
         gen_store_gpr(t0, rb);
         break;
+
+    case OPC_MXU_S8LDD:
+        xra = extract32(ctx->opcode, 6, 4);
+        s8 = extract32(ctx->opcode, 10, 8);
+        optn3 = extract32(ctx->opcode, 18, 3);
+        rb = extract32(ctx->opcode, 21, 5);
+
+        gen_load_gpr(t0, rb);
+        tcg_gen_addi_tl(t0, t0, (int8_t)s8);
+        switch (optn3) {
+        case 0: /*XRa[7:0] = tmp8 */
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            gen_load_mxu_gpr(t0, xra);
+            tcg_gen_deposit_tl(t0, t0, t1, 0, 8);
+            break;
+        case 1: /* XRa[15:8] = tmp8 */
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            gen_load_mxu_gpr(t0, xra);
+            tcg_gen_deposit_tl(t0, t0, t1, 8, 8);
+            break;
+        case 2: /* XRa[23:16] = tmp8 */
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            gen_load_mxu_gpr(t0, xra);
+            tcg_gen_deposit_tl(t0, t0, t1, 16, 8);
+            break;
+        case 3: /* XRa[31:24] = tmp8 */
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            gen_load_mxu_gpr(t0, xra);
+            tcg_gen_deposit_tl(t0, t0, t1, 24, 8);
+            break;
+        case 4: /* XRa = {8'b0, tmp8, 8'b0, tmp8} */
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+            break;
+        case 5: /* XRa = {tmp8, 8'b0, tmp8, 8'b0} */
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            tcg_gen_shli_tl(t1, t1, 8);
+            tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+            break;
+        case 6: /* XRa = {{8{sign of tmp8}}, tmp8, {8{sign of tmp8}}, tmp8} */
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_SB);
+            tcg_gen_mov_tl(t0, t1);
+            tcg_gen_andi_tl(t0, t0, 0xFF00FFFF);
+            tcg_gen_shli_tl(t1, t1, 16);
+            tcg_gen_or_tl(t0, t0, t1);
+            break;
+        case 7: /* XRa = {tmp8, tmp8, tmp8, tmp8} */
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            tcg_gen_deposit_tl(t1, t1, t1, 8, 8);
+            tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+            break;
+        }
+        gen_store_mxu_gpr(t0, xra);
+        break;
     }
 
     tcg_temp_free(t0);
+    tcg_temp_free(t1);
 }
 
 /* Godson integer instructions */
@@ -17880,6 +17937,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     case OPC_MXU_S32I2M:
     case OPC_MXU_S32M2I:
+    case OPC_MXU_S8LDD:
         gen_mxu(ctx, op1);
         break;
 
-- 
2.18.0
