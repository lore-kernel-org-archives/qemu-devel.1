Received: from eggs.gnu.org ([2001:4830:134:3::10]:50683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudcV-0002k9-Rs
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudc6-0000d2-MF
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:01:00 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:64014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudc6-0000c3-Gv
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:00:54 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Tue, 28 Aug 2018 09:00:37 -0400
Message-Id: <20180828130041.26445-5-jancraig@amazon.com>
In-Reply-To: <20180828130041.26445-1-jancraig@amazon.com>
References: <20180828130041.26445-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v3 4/8] target/mips: Add MXU instruction S8LDD
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
 v3
    - Split gen_mxu function into command specific gen_mxu_<ins> functions

 target/mips/translate.c | 69 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f6991aa8ef..024e48baf6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3851,6 +3851,71 @@ static void gen_mxu_s32m2i(DisasContext *ctx, uint32_t opc)
     tcg_temp_free(t0);
 }
 
+/* S8LDD XRa, rb, S8, OPTN3 - Load a byte from memory to XRF */
+static void gen_mxu_s8ldd(DisasContext *ctx, uint32_t opc)
+{
+    TCGv t0, t1;
+    uint32_t xra, s8, optn3, rb;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    xra = extract32(ctx->opcode, 6, 4);
+    s8 = extract32(ctx->opcode, 10, 8);
+    optn3 = extract32(ctx->opcode, 18, 3);
+    rb = extract32(ctx->opcode, 21, 5);
+
+    gen_load_gpr(t0, rb);
+    tcg_gen_addi_tl(t0, t0, (int8_t)s8);
+    switch (optn3) {
+    case 0: /*XRa[7:0] = tmp8 */
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        gen_load_mxu_gpr(t0, xra);
+        tcg_gen_deposit_tl(t0, t0, t1, 0, 8);
+        break;
+    case 1: /* XRa[15:8] = tmp8 */
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        gen_load_mxu_gpr(t0, xra);
+        tcg_gen_deposit_tl(t0, t0, t1, 8, 8);
+        break;
+    case 2: /* XRa[23:16] = tmp8 */
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        gen_load_mxu_gpr(t0, xra);
+        tcg_gen_deposit_tl(t0, t0, t1, 16, 8);
+        break;
+    case 3: /* XRa[31:24] = tmp8 */
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        gen_load_mxu_gpr(t0, xra);
+        tcg_gen_deposit_tl(t0, t0, t1, 24, 8);
+        break;
+    case 4: /* XRa = {8'b0, tmp8, 8'b0, tmp8} */
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+        break;
+    case 5: /* XRa = {tmp8, 8'b0, tmp8, 8'b0} */
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_shli_tl(t1, t1, 8);
+        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+        break;
+    case 6: /* XRa = {{8{sign of tmp8}}, tmp8, {8{sign of tmp8}}, tmp8} */
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_SB);
+        tcg_gen_mov_tl(t0, t1);
+        tcg_gen_andi_tl(t0, t0, 0xFF00FFFF);
+        tcg_gen_shli_tl(t1, t1, 16);
+        tcg_gen_or_tl(t0, t0, t1);
+        break;
+    case 7: /* XRa = {tmp8, tmp8, tmp8, tmp8} */
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_deposit_tl(t1, t1, t1, 8, 8);
+        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+        break;
+    }
+    gen_store_mxu_gpr(t0, xra);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
 /* Godson integer instructions */
 static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
                                  int rd, int rs, int rt)
@@ -17956,6 +18021,10 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         gen_mxu_s32m2i(ctx, op1);
         break;
 
+    case OPC_MXU_S8LDD:
+        gen_mxu_s8ldd(ctx, op1);
+        break;
+
     case OPC_CLO:
     case OPC_CLZ:
         check_insn(ctx, ISA_MIPS32);
-- 
2.18.0
