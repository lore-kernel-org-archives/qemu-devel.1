Received: from eggs.gnu.org ([2001:4830:134:3::10]:57447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEzQd-0007QN-TA
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEzQb-00022N-Rn
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:21:11 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47342 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEzQZ-0001z5-Qq
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:21:08 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Oct 2018 18:18:29 +0200
Message-Id: <1540311509-23970-19-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540311509-23970-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540311509-23970-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 18/18] target/mips: Add emulation of MXU
 instructions S32LDD and S32LDDR
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

Add support for emulating the S32LDD and S32LDDR MXU instructions.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 54 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d53e386..61c1662 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24281,6 +24281,52 @@ static void gen_mxu_q8mul_q8mulsu(DisasContext *ctx)
     tcg_temp_free(t7);
 }
 
+/*
+ * S32LDD  XRa, Rb, S12 - Load a word from memory to XRF
+ * S32LDDR XRa, Rb, S12 - Load a word from memory to XRF, reversed byte seq.
+ */
+static void gen_mxu_s32ldd_s32lddr(DisasContext *ctx)
+{
+    TCGv t0, t1;
+    TCGLabel *l0;
+    uint32_t XRa, Rb, s12, sel;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    l0 = gen_new_label();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    s12 = extract32(ctx->opcode, 10, 10);
+    sel = extract32(ctx->opcode, 20, 1);
+    Rb = extract32(ctx->opcode, 21, 5);
+
+    gen_load_mxu_cr(t0);
+    tcg_gen_andi_tl(t0, t0, MXU_CR_MXU_EN);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXU_CR_MXU_EN, l0);
+
+    gen_load_gpr(t0, Rb);
+
+    tcg_gen_movi_tl(t1, s12);
+    tcg_gen_shli_tl(t1, t1, 2);
+    if (s12 & 0x200) {
+        tcg_gen_ori_tl(t1, t1, 0xFFFFF000);
+    }
+    tcg_gen_add_tl(t1, t0, t1);
+    tcg_gen_qemu_ld_tl(t1, t1, ctx->mem_idx, MO_SL);
+
+    if (sel == 1) {
+        /* S32LDDR */
+        tcg_gen_bswap32_tl(t1, t1);
+    }
+    gen_store_mxu_gpr(t1, XRa);
+
+    gen_set_label(l0);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
 
 /*
  * Decoding engine for MXU
@@ -24510,14 +24556,8 @@ static void decode_opc_mxu__pool04(CPUMIPSState *env, DisasContext *ctx)
 
     switch (opcode) {
     case OPC_MXU_S32LDD:
-        /* TODO: Implement emulation of S32LDD instruction. */
-        MIPS_INVAL("OPC_MXU_S32LDD");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
     case OPC_MXU_S32LDDR:
-        /* TODO: Implement emulation of S32LDDR instruction. */
-        MIPS_INVAL("OPC_MXU_S32LDDR");
-        generate_exception_end(ctx, EXCP_RI);
+        gen_mxu_s32ldd_s32lddr(ctx);
         break;
     default:
         MIPS_INVAL("decode_opc_mxu");
-- 
2.7.4
