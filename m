Received: from eggs.gnu.org ([208.118.235.92]:59970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSt3-00011E-HK
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSeD-0006pb-PL
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:30:33 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:40061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSeD-0006p4-I9
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:30:29 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Thu, 30 Aug 2018 15:30:15 -0400
Message-Id: <20180830193019.20104-6-jancraig@amazon.com>
In-Reply-To: <20180830193019.20104-1-jancraig@amazon.com>
References: <20180830193019.20104-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v4 5/9] target/mips: Add MXU instruction S8LDD
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
 v4
    -Add and use MXU_OPTN3_PTN #defines
    -Add check for MXUEN

 target/mips/translate.c | 98 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 41081ee066..cfd25c3abe 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1462,6 +1462,8 @@ static TCGv_i64 msa_wr_d[64];
 static TCGv mxu_gpr[15];
 static TCGv mxu_CR;
 
+#define MXUEN 0x01
+
 #include "exec/gen-icount.h"
 
 #define gen_helper_0e0i(name, arg) do {                           \
@@ -3837,6 +3839,16 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
 
 /* MXU Instructions */
 
+/* MXU operand getting patterns OPTN3 */
+#define MXU_OPTN3_PTN0  0
+#define MXU_OPTN3_PTN1  1
+#define MXU_OPTN3_PTN2  2
+#define MXU_OPTN3_PTN3  3
+#define MXU_OPTN3_PTN4  4
+#define MXU_OPTN3_PTN5  5
+#define MXU_OPTN3_PTN6  6
+#define MXU_OPTN3_PTN7  7
+
 /* S32I2M XRa, rb - Register move from GRF to XRF */
 static void gen_mxu_s32i2m(DisasContext *ctx, uint32_t opc)
 {
@@ -3880,6 +3892,88 @@ static void gen_mxu_s32m2i(DisasContext *ctx, uint32_t opc)
     tcg_temp_free(t0);
 }
 
+/* S8LDD XRa, rb, S8, OPTN3 - Load a byte from memory to XRF */
+static void gen_mxu_s8ldd(DisasContext *ctx, uint32_t opc)
+{
+    TCGv t0, t1;
+    TCGLabel *l0;
+    uint32_t xra, s8, optn3, rb;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    l0 = gen_new_label();
+
+    xra = extract32(ctx->opcode, 6, 4);
+    s8 = extract32(ctx->opcode, 10, 8);
+    optn3 = extract32(ctx->opcode, 18, 3);
+    rb = extract32(ctx->opcode, 21, 5);
+
+    gen_load_mxu_cr(t0);
+    tcg_gen_andi_tl(t0, t0, MXUEN);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXUEN, l0);
+
+    gen_load_gpr(t0, rb);
+    tcg_gen_addi_tl(t0, t0, (int8_t)s8);
+    switch (optn3) {
+    /*XRa[7:0] = tmp8 */
+    case MXU_OPTN3_PTN0:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        gen_load_mxu_gpr(t0, xra);
+        tcg_gen_deposit_tl(t0, t0, t1, 0, 8);
+        break;
+    /* XRa[15:8] = tmp8 */
+    case MXU_OPTN3_PTN1:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        gen_load_mxu_gpr(t0, xra);
+        tcg_gen_deposit_tl(t0, t0, t1, 8, 8);
+        break;
+    /* XRa[23:16] = tmp8 */
+    case MXU_OPTN3_PTN2:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        gen_load_mxu_gpr(t0, xra);
+        tcg_gen_deposit_tl(t0, t0, t1, 16, 8);
+        break;
+    /* XRa[31:24] = tmp8 */
+    case MXU_OPTN3_PTN3:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        gen_load_mxu_gpr(t0, xra);
+        tcg_gen_deposit_tl(t0, t0, t1, 24, 8);
+        break;
+    /* XRa = {8'b0, tmp8, 8'b0, tmp8} */
+    case MXU_OPTN3_PTN4:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+        break;
+    /* XRa = {tmp8, 8'b0, tmp8, 8'b0} */
+    case MXU_OPTN3_PTN5:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_shli_tl(t1, t1, 8);
+        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+        break;
+    /* XRa = {{8{sign of tmp8}}, tmp8, {8{sign of tmp8}}, tmp8} */
+    case MXU_OPTN3_PTN6:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_SB);
+        tcg_gen_mov_tl(t0, t1);
+        tcg_gen_andi_tl(t0, t0, 0xFF00FFFF);
+        tcg_gen_shli_tl(t1, t1, 16);
+        tcg_gen_or_tl(t0, t0, t1);
+        break;
+    /* XRa = {tmp8, tmp8, tmp8, tmp8} */
+    case MXU_OPTN3_PTN7:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_deposit_tl(t1, t1, t1, 8, 8);
+        tcg_gen_deposit_tl(t0, t1, t1, 16, 16);
+        break;
+    }
+    gen_store_mxu_gpr(t0, xra);
+
+    gen_set_label(l0);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
 /* Godson integer instructions */
 static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
                                  int rd, int rs, int rt)
@@ -17952,6 +18046,10 @@ static void decode_opc_special2_mxu(CPUMIPSState *env, DisasContext *ctx)
         gen_mxu_s32m2i(ctx, op1);
         break;
 
+    case OPC_MXU_S8LDD:
+        gen_mxu_s8ldd(ctx, op1);
+        break;
+
     default:            /* Invalid */
         MIPS_INVAL("special2_mxu");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.18.0
