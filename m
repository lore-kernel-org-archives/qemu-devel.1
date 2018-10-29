Received: from eggs.gnu.org ([2001:4830:134:3::10]:49132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5i7-0001th-1P
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5i4-0005Ke-Uu
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:27:54 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35080 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH5i4-0005BC-9u
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:27:52 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 12:25:22 +0100
Message-Id: <1540812328-16163-15-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 14/20] target/mips: Add emulation of MXU
 instruction S8LDD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, jancraig@amazon.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Craig Janeczek <jancraig@amazon.com>

Add support for emulating the S8LDD MXU instruction.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index fb3bfaf..b06571b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24087,6 +24087,92 @@ static void gen_mxu_s32m2i(DisasContext *ctx)
     tcg_temp_free(t0);
 }
 
+/*
+ * S8LDD XRa, Rb, s8, optn3 - Load a byte from memory to XRF
+ */
+static void gen_mxu_s8ldd(DisasContext *ctx)
+{
+    TCGv t0, t1;
+    TCGLabel *l0;
+    uint32_t XRa, Rb, s8, optn3;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    l0 = gen_new_label();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    s8 = extract32(ctx->opcode, 10, 8);
+    optn3 = extract32(ctx->opcode, 18, 3);
+    Rb = extract32(ctx->opcode, 21, 5);
+
+    gen_load_mxu_cr(t0);
+    tcg_gen_andi_tl(t0, t0, MXU_CR_MXU_EN);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXU_CR_MXU_EN, l0);
+
+    gen_load_gpr(t0, Rb);
+    tcg_gen_addi_tl(t0, t0, (int8_t)s8);
+
+    switch (optn3) {
+    /* XRa[7:0] = tmp8 */
+    case MXU_OPTN3_PTN0:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        gen_load_mxu_gpr(t0, XRa);
+        tcg_gen_deposit_tl(t0, t0, t1, 0, 8);
+        break;
+    /* XRa[15:8] = tmp8 */
+    case MXU_OPTN3_PTN1:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        gen_load_mxu_gpr(t0, XRa);
+        tcg_gen_deposit_tl(t0, t0, t1, 8, 8);
+        break;
+    /* XRa[23:16] = tmp8 */
+    case MXU_OPTN3_PTN2:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        gen_load_mxu_gpr(t0, XRa);
+        tcg_gen_deposit_tl(t0, t0, t1, 16, 8);
+        break;
+    /* XRa[31:24] = tmp8 */
+    case MXU_OPTN3_PTN3:
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        gen_load_mxu_gpr(t0, XRa);
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
+
+    gen_store_mxu_gpr(t0, XRa);
+
+    gen_set_label(l0);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
 
 /*
  * Decoding engine for MXU
@@ -25132,9 +25218,7 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
         generate_exception_end(ctx, EXCP_RI);
         break;
     case OPC_MXU_S8LDD:
-        /* TODO: Implement emulation of S8LDD instruction. */
-        MIPS_INVAL("OPC_MXU_S8LDD");
-        generate_exception_end(ctx, EXCP_RI);
+        gen_mxu_s8ldd(ctx);
         break;
     case OPC_MXU_S8STD:
         /* TODO: Implement emulation of S8STD instruction. */
-- 
2.7.4
