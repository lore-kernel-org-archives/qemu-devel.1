Received: from eggs.gnu.org ([209.51.188.92]:57074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyblu-0007Bs-FC
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyblr-00071o-EM
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:42 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:43264 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1gybln-0006we-M2
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:37 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Tue, 26 Feb 2019 13:23:12 +0100
Message-Id: <1551183797-13570-2-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551183797-13570-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1551183797-13570-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 1/6] target/mips: Preparing for adding MMI
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Set up MMI code to be compiled only for TARGET_MIPS64. This is
needed so that GPRs are 64 bit, and combined with MMI registers,
they will form full 128 bit registers.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 target/mips/translate.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3b17020..332ff79 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4362,6 +4362,7 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t1);
 }
 
+#if defined(TARGET_MIPS64)
 /* Copy GPR to and from TX79 HI1/LO1 register. */
 static void gen_HILO1_tx79(DisasContext *ctx, uint32_t opc, int reg)
 {
@@ -4397,6 +4398,7 @@ static void gen_HILO1_tx79(DisasContext *ctx, uint32_t opc, int reg)
         break;
     }
 }
+#endif
 
 /* Arithmetic on HI/LO registers */
 static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
@@ -4746,6 +4748,7 @@ static void gen_r6_muldiv(DisasContext *ctx, int opc, int rd, int rs, int rt)
     tcg_temp_free(t1);
 }
 
+#if defined(TARGET_MIPS64)
 static void gen_div1_tx79(DisasContext *ctx, uint32_t opc, int rs, int rt)
 {
     TCGv t0, t1;
@@ -4802,6 +4805,7 @@ static void gen_div1_tx79(DisasContext *ctx, uint32_t opc, int rs, int rt)
     tcg_temp_free(t0);
     tcg_temp_free(t1);
 }
+#endif
 
 static void gen_muldiv(DisasContext *ctx, uint32_t opc,
                        int acc, int rs, int rt)
@@ -24324,6 +24328,29 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 }
 
 
+#if defined(TARGET_MIPS64)
+
+/*
+ *
+ *           MMI (MultiMedia Interface) ASE instructions
+ *           ===========================================
+ */
+
+/*
+ *          MMI instructions category: data communication
+ *          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  PCPYH    PEXCH    PEXTLB   PINTH    PPACB    PEXT5    PREVH
+ *  PCPYLD   PEXCW    PEXTLH   PINTEH   PPACH    PPAC5    PROT3W
+ *  PCPYUD   PEXCEH   PEXTLW            PPACW
+ *           PEXCEW   PEXTUB
+ *                    PEXTUB
+ *                    PEXTUB
+ */
+
+#endif
+
+
 #if !defined(TARGET_MIPS64)
 
 /* MXU accumulate add/subtract 1-bit pattern 'aptn1' */
@@ -27247,6 +27274,9 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+
+#if defined(TARGET_MIPS64)
+
 static void decode_mmi0(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc = MASK_MMI0(ctx->opcode);
@@ -27491,6 +27521,8 @@ static void decode_mmi_sq(CPUMIPSState *env, DisasContext *ctx)
     gen_mmi_sq(ctx, base, rt, offset);
 }
 
+#endif
+
 static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
@@ -28796,10 +28828,11 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         decode_opc_special(env, ctx);
         break;
     case OPC_SPECIAL2:
+#if defined(TARGET_MIPS64)
         if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI)) {
             decode_mmi(env, ctx);
-#if !defined(TARGET_MIPS64)
-        } else if (ctx->insn_flags & ASE_MXU) {
+#else
+        if (ctx->insn_flags & ASE_MXU) {
             decode_opc_mxu(env, ctx);
 #endif
         } else {
@@ -28807,11 +28840,15 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_SPECIAL3:
+#if defined(TARGET_MIPS64)
         if (ctx->insn_flags & INSN_R5900) {
             decode_mmi_sq(env, ctx);    /* MMI_OPC_SQ */
         } else {
             decode_opc_special3(env, ctx);
         }
+#else
+        decode_opc_special3(env, ctx);
+#endif
         break;
     case OPC_REGIMM:
         op1 = MASK_REGIMM(ctx->opcode);
@@ -29483,7 +29520,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_MSA: /* OPC_MDMX */
         if (ctx->insn_flags & INSN_R5900) {
+#if defined(TARGET_MIPS64)
             gen_mmi_lq(env, ctx);    /* MMI_OPC_LQ */
+#endif
         } else {
             /* MDMX: Not implemented. */
             gen_msa(env, ctx);
-- 
2.7.4
