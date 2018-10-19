Received: from eggs.gnu.org ([2001:4830:134:3::10]:39016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXkO-00061F-OR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXkM-00011Y-NL
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58317 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gDXkM-0000vv-7S
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:34 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Oct 2018 18:33:43 +0200
Message-Id: <1539966828-20947-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 09/14] target/mips: Add emulation of MXU
 instructions S32I2M and S32M2I
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

Add support for emulating the S32I2M and S32M2I MXU instructions.
This commit also contains utility functions for reading/writing
to MXU registers. This is required for overall MXU instruction
support.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 90 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 6 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 191aeab..c2b3463 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2149,6 +2149,35 @@ static inline void gen_store_srsgpr (int from, int to)
     }
 }
 
+/* MXU General purpose registers moves. */
+static inline void gen_load_mxu_gpr(TCGv t, unsigned int reg)
+{
+    if (reg == 0) {
+        tcg_gen_movi_tl(t, 0);
+    } else if (reg <= 15) {
+        tcg_gen_mov_tl(t, mxu_gpr[reg - 1]);
+    }
+}
+
+static inline void gen_store_mxu_gpr(TCGv t, unsigned int reg)
+{
+    if (reg > 0 && reg <= 15) {
+        tcg_gen_mov_tl(mxu_gpr[reg - 1], t);
+    }
+}
+
+/* MXU control register moves. */
+static inline void gen_load_mxu_cr(TCGv t)
+{
+    tcg_gen_mov_tl(t, mxu_CR);
+}
+
+static inline void gen_store_mxu_cr(TCGv t)
+{
+    tcg_gen_mov_tl(mxu_CR, t);
+}
+
+
 /* Tests */
 static inline void gen_save_pc(target_ulong pc)
 {
@@ -23335,6 +23364,59 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 
 
 /*
+ * S32I2M XRa, rb - Register move from GRF to XRF
+ */
+static void gen_mxu_s32i2m(DisasContext *ctx)
+{
+    TCGv t0;
+    uint32_t XRa, Rb;
+
+    t0 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode, 6, 5);
+    Rb = extract32(ctx->opcode, 16, 5);
+
+    gen_load_gpr(t0, Rb);
+    if (XRa <= 15) {
+        gen_store_mxu_gpr(t0, XRa);
+    } else if (XRa == 16) {
+        gen_store_mxu_cr(t0);
+    }
+
+    tcg_temp_free(t0);
+}
+
+/*
+ * S32M2I XRa, rb - Register move from XRF to GRF
+ */
+static void gen_mxu_s32m2i(DisasContext *ctx)
+{
+    TCGv t0;
+    uint32_t XRa, Rb;
+
+    t0 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode, 6, 5);
+    Rb = extract32(ctx->opcode, 16, 5);
+
+    if (XRa <= 15) {
+        gen_load_mxu_gpr(t0, XRa);
+    } else if (XRa == 16) {
+        gen_load_mxu_cr(t0);
+    }
+
+    gen_store_gpr(t0, Rb);
+
+    tcg_temp_free(t0);
+}
+
+
+/*
+ * Decoding engine for MXU
+ * =======================
+ */
+
+/*
  *
  * Decode MXU pool00
  *
@@ -24438,14 +24520,10 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
         generate_exception_end(ctx, EXCP_RI);
         break;
     case OPC_MXU_S32M2I:
-        /* TODO: Implement emulation of S32M2I instruction. */
-        MIPS_INVAL("OPC_MXU_S32M2I");
-        generate_exception_end(ctx, EXCP_RI);
+        gen_mxu_s32m2i(ctx);
         break;
     case OPC_MXU_S32I2M:
-        /* TODO: Implement emulation of S32I2M instruction. */
-        MIPS_INVAL("OPC_MXU_S32I2M");
-        generate_exception_end(ctx, EXCP_RI);
+        gen_mxu_s32i2m(ctx);
         break;
     case OPC_MXU_D32SLL:
         /* TODO: Implement emulation of D32SLL instruction. */
-- 
2.7.4
