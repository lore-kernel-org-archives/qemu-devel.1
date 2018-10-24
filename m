Received: from eggs.gnu.org ([2001:4830:134:3::10]:59796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFIAs-0002OP-E3
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFIAn-0004Qe-CG
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:22:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:42305 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFIAm-0004Fl-RC
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:22:05 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 14:18:46 +0200
Message-Id: <1540383527-7923-20-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 19/20] target/mips: Move MXU_EN check one
 level higher
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

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Move MXU_EN check to the main MXU decoding function, to avoid code
repetition.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 509 ++++++++++++++++++++++--------------------------
 1 file changed, 238 insertions(+), 271 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 61c1662..3620ae5 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23960,23 +23960,16 @@ static void gen_mxu_s32m2i(DisasContext *ctx)
 static void gen_mxu_s8ldd(DisasContext *ctx)
 {
     TCGv t0, t1;
-    TCGLabel *l0;
     uint32_t XRa, Rb, s8, optn3;
 
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
-    l0 = gen_new_label();
-
     XRa = extract32(ctx->opcode, 6, 4);
     s8 = extract32(ctx->opcode, 10, 8);
     optn3 = extract32(ctx->opcode, 18, 3);
     Rb = extract32(ctx->opcode, 21, 5);
 
-    gen_load_mxu_cr(t0);
-    tcg_gen_andi_tl(t0, t0, MXU_CR_MXU_EN);
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXU_CR_MXU_EN, l0);
-
     gen_load_gpr(t0, Rb);
     tcg_gen_addi_tl(t0, t0, (int8_t)s8);
 
@@ -24034,8 +24027,6 @@ static void gen_mxu_s8ldd(DisasContext *ctx)
 
     gen_store_mxu_gpr(t0, XRa);
 
-    gen_set_label(l0);
-
     tcg_temp_free(t0);
     tcg_temp_free(t1);
 }
@@ -24046,7 +24037,6 @@ static void gen_mxu_s8ldd(DisasContext *ctx)
 static void gen_mxu_d16mul(DisasContext *ctx)
 {
     TCGv t0, t1, t2, t3;
-    TCGLabel *l0;
     uint32_t XRa, XRb, XRc, XRd, optn2;
 
     t0 = tcg_temp_new();
@@ -24054,18 +24044,12 @@ static void gen_mxu_d16mul(DisasContext *ctx)
     t2 = tcg_temp_new();
     t3 = tcg_temp_new();
 
-    l0 = gen_new_label();
-
     XRa = extract32(ctx->opcode, 6, 4);
     XRb = extract32(ctx->opcode, 10, 4);
     XRc = extract32(ctx->opcode, 14, 4);
     XRd = extract32(ctx->opcode, 18, 4);
     optn2 = extract32(ctx->opcode, 22, 2);
 
-    gen_load_mxu_cr(t0);
-    tcg_gen_andi_tl(t0, t0, MXU_CR_MXU_EN);
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXU_CR_MXU_EN, l0);
-
     gen_load_mxu_gpr(t1, XRb);
     tcg_gen_sextract_tl(t0, t1, 0, 16);
     tcg_gen_sextract_tl(t1, t1, 16, 16);
@@ -24094,8 +24078,6 @@ static void gen_mxu_d16mul(DisasContext *ctx)
     gen_store_mxu_gpr(t3, XRa);
     gen_store_mxu_gpr(t2, XRd);
 
-    gen_set_label(l0);
-
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
@@ -24109,7 +24091,6 @@ static void gen_mxu_d16mul(DisasContext *ctx)
 static void gen_mxu_d16mac(DisasContext *ctx)
 {
     TCGv t0, t1, t2, t3;
-    TCGLabel *l0;
     uint32_t XRa, XRb, XRc, XRd, optn2, aptn2;
 
     t0 = tcg_temp_new();
@@ -24117,8 +24098,6 @@ static void gen_mxu_d16mac(DisasContext *ctx)
     t2 = tcg_temp_new();
     t3 = tcg_temp_new();
 
-    l0 = gen_new_label();
-
     XRa = extract32(ctx->opcode, 6, 4);
     XRb = extract32(ctx->opcode, 10, 4);
     XRc = extract32(ctx->opcode, 14, 4);
@@ -24126,10 +24105,6 @@ static void gen_mxu_d16mac(DisasContext *ctx)
     optn2 = extract32(ctx->opcode, 22, 2);
     aptn2 = extract32(ctx->opcode, 24, 2);
 
-    gen_load_mxu_cr(t0);
-    tcg_gen_andi_tl(t0, t0, MXU_CR_MXU_EN);
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXU_CR_MXU_EN, l0);
-
     gen_load_mxu_gpr(t1, XRb);
     tcg_gen_sextract_tl(t0, t1, 0, 16);
     tcg_gen_sextract_tl(t1, t1, 16, 16);
@@ -24180,8 +24155,6 @@ static void gen_mxu_d16mac(DisasContext *ctx)
     gen_store_mxu_gpr(t3, XRa);
     gen_store_mxu_gpr(t2, XRd);
 
-    gen_set_label(l0);
-
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
@@ -24195,7 +24168,6 @@ static void gen_mxu_d16mac(DisasContext *ctx)
 static void gen_mxu_q8mul_q8mulsu(DisasContext *ctx)
 {
     TCGv t0, t1, t2, t3, t4, t5, t6, t7;
-    TCGLabel *l0;
     uint32_t XRa, XRb, XRc, XRd, sel;
 
     t0 = tcg_temp_new();
@@ -24207,18 +24179,12 @@ static void gen_mxu_q8mul_q8mulsu(DisasContext *ctx)
     t6 = tcg_temp_new();
     t7 = tcg_temp_new();
 
-    l0 = gen_new_label();
-
     XRa = extract32(ctx->opcode, 6, 4);
     XRb = extract32(ctx->opcode, 10, 4);
     XRc = extract32(ctx->opcode, 14, 4);
     XRd = extract32(ctx->opcode, 18, 4);
     sel = extract32(ctx->opcode, 22, 2);
 
-    gen_load_mxu_cr(t0);
-    tcg_gen_andi_tl(t0, t0, MXU_CR_MXU_EN);
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXU_CR_MXU_EN, l0);
-
     gen_load_mxu_gpr(t3, XRb);
     gen_load_mxu_gpr(t7, XRc);
 
@@ -24269,8 +24235,6 @@ static void gen_mxu_q8mul_q8mulsu(DisasContext *ctx)
     gen_store_mxu_gpr(t0, XRd);
     gen_store_mxu_gpr(t1, XRa);
 
-    gen_set_label(l0);
-
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
@@ -24288,23 +24252,16 @@ static void gen_mxu_q8mul_q8mulsu(DisasContext *ctx)
 static void gen_mxu_s32ldd_s32lddr(DisasContext *ctx)
 {
     TCGv t0, t1;
-    TCGLabel *l0;
     uint32_t XRa, Rb, s12, sel;
 
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
-    l0 = gen_new_label();
-
     XRa = extract32(ctx->opcode, 6, 4);
     s12 = extract32(ctx->opcode, 10, 10);
     sel = extract32(ctx->opcode, 20, 1);
     Rb = extract32(ctx->opcode, 21, 5);
 
-    gen_load_mxu_cr(t0);
-    tcg_gen_andi_tl(t0, t0, MXU_CR_MXU_EN);
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXU_CR_MXU_EN, l0);
-
     gen_load_gpr(t0, Rb);
 
     tcg_gen_movi_tl(t1, s12);
@@ -24321,8 +24278,6 @@ static void gen_mxu_s32ldd_s32lddr(DisasContext *ctx)
     }
     gen_store_mxu_gpr(t1, XRa);
 
-    gen_set_label(l0);
-
     tcg_temp_free(t0);
     tcg_temp_free(t1);
 }
@@ -25243,232 +25198,244 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
         return;
     }
 
-    switch (opcode) {
-    case OPC_MXU_S32MADD:
-        /* TODO: Implement emulation of S32MADD instruction. */
-        MIPS_INVAL("OPC_MXU_S32MADD");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_S32MADDU:
-        /* TODO: Implement emulation of S32MADDU instruction. */
-        MIPS_INVAL("OPC_MXU_S32MADDU");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU__POOL00:
-        decode_opc_mxu__pool00(env, ctx);
-        break;
-    case OPC_MXU_S32MSUB:
-        /* TODO: Implement emulation of S32MSUB instruction. */
-        MIPS_INVAL("OPC_MXU_S32MSUB");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_S32MSUBU:
-        /* TODO: Implement emulation of S32MSUBU instruction. */
-        MIPS_INVAL("OPC_MXU_S32MSUBU");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU__POOL01:
-        decode_opc_mxu__pool01(env, ctx);
-        break;
-    case OPC_MXU__POOL02:
-        decode_opc_mxu__pool02(env, ctx);
-        break;
-    case OPC_MXU_D16MUL:
-        gen_mxu_d16mul(ctx);
-        break;
-    case OPC_MXU__POOL03:
-        decode_opc_mxu__pool03(env, ctx);
-        break;
-    case OPC_MXU_D16MAC:
-        gen_mxu_d16mac(ctx);
-        break;
-    case OPC_MXU_D16MACF:
-        /* TODO: Implement emulation of D16MACF instruction. */
-        MIPS_INVAL("OPC_MXU_D16MACF");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_D16MADL:
-        /* TODO: Implement emulation of D16MADL instruction. */
-        MIPS_INVAL("OPC_MXU_D16MADL");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_S16MAD:
-        /* TODO: Implement emulation of S16MAD instruction. */
-        MIPS_INVAL("OPC_MXU_S16MAD");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_Q16ADD:
-        /* TODO: Implement emulation of Q16ADD instruction. */
-        MIPS_INVAL("OPC_MXU_Q16ADD");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_D16MACE:
-        /* TODO: Implement emulation of D16MACE instruction. */
-        MIPS_INVAL("OPC_MXU_D16MACE");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU__POOL04:
-        decode_opc_mxu__pool04(env, ctx);
-        break;
-    case OPC_MXU__POOL05:
-        decode_opc_mxu__pool05(env, ctx);
-        break;
-    case OPC_MXU__POOL06:
-        decode_opc_mxu__pool06(env, ctx);
-        break;
-    case OPC_MXU__POOL07:
-        decode_opc_mxu__pool07(env, ctx);
-        break;
-    case OPC_MXU__POOL08:
-        decode_opc_mxu__pool08(env, ctx);
-        break;
-    case OPC_MXU__POOL09:
-        decode_opc_mxu__pool09(env, ctx);
-        break;
-    case OPC_MXU__POOL10:
-        decode_opc_mxu__pool10(env, ctx);
-        break;
-    case OPC_MXU__POOL11:
-        decode_opc_mxu__pool11(env, ctx);
-        break;
-    case OPC_MXU_D32ADD:
-        /* TODO: Implement emulation of D32ADD instruction. */
-        MIPS_INVAL("OPC_MXU_D32ADD");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU__POOL12:
-        decode_opc_mxu__pool12(env, ctx);
-        break;
-    case OPC_MXU__POOL13:
-        decode_opc_mxu__pool13(env, ctx);
-        break;
-    case OPC_MXU__POOL14:
-        decode_opc_mxu__pool14(env, ctx);
-        break;
-    case OPC_MXU_Q8ACCE:
-        /* TODO: Implement emulation of Q8ACCE instruction. */
-        MIPS_INVAL("OPC_MXU_Q8ACCE");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_S8LDD:
-        gen_mxu_s8ldd(ctx);
-        break;
-    case OPC_MXU_S8STD:
-        /* TODO: Implement emulation of S8STD instruction. */
-        MIPS_INVAL("OPC_MXU_S8STD");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_S8LDI:
-        /* TODO: Implement emulation of S8LDI instruction. */
-        MIPS_INVAL("OPC_MXU_S8LDI");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_S8SDI:
-        /* TODO: Implement emulation of S8SDI instruction. */
-        MIPS_INVAL("OPC_MXU_S8SDI");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU__POOL15:
-        decode_opc_mxu__pool15(env, ctx);
-        break;
-    case OPC_MXU__POOL16:
-        decode_opc_mxu__pool16(env, ctx);
-        break;
-    case OPC_MXU_LXB:
-        /* TODO: Implement emulation of LXB instruction. */
-        MIPS_INVAL("OPC_MXU_LXB");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_S16LDD:
-        /* TODO: Implement emulation of S16LDD instruction. */
-        MIPS_INVAL("OPC_MXU_S16LDD");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_S16STD:
-        /* TODO: Implement emulation of S16STD instruction. */
-        MIPS_INVAL("OPC_MXU_S16STD");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_S16LDI:
-        /* TODO: Implement emulation of S16LDI instruction. */
-        MIPS_INVAL("OPC_MXU_S16LDI");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_S16SDI:
-        /* TODO: Implement emulation of S16SDI instruction. */
-        MIPS_INVAL("OPC_MXU_S16SDI");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_D32SLL:
-        /* TODO: Implement emulation of D32SLL instruction. */
-        MIPS_INVAL("OPC_MXU_D32SLL");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_D32SLR:
-        /* TODO: Implement emulation of D32SLR instruction. */
-        MIPS_INVAL("OPC_MXU_D32SLR");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_D32SARL:
-        /* TODO: Implement emulation of D32SARL instruction. */
-        MIPS_INVAL("OPC_MXU_D32SARL");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_D32SAR:
-        /* TODO: Implement emulation of D32SAR instruction. */
-        MIPS_INVAL("OPC_MXU_D32SAR");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_Q16SLL:
-        /* TODO: Implement emulation of Q16SLL instruction. */
-        MIPS_INVAL("OPC_MXU_Q16SLL");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_Q16SLR:
-        /* TODO: Implement emulation of Q16SLR instruction. */
-        MIPS_INVAL("OPC_MXU_Q16SLR");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU__POOL17:
-        decode_opc_mxu__pool17(env, ctx);
-        break;
-    case OPC_MXU_Q16SAR:
-        /* TODO: Implement emulation of Q16SAR instruction. */
-        MIPS_INVAL("OPC_MXU_Q16SAR");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU__POOL18:
-        decode_opc_mxu__pool18(env, ctx);
-        break;
-    case OPC_MXU__POOL19:
-        decode_opc_mxu__pool19(env, ctx);
-        break;
-    case OPC_MXU__POOL20:
-        decode_opc_mxu__pool20(env, ctx);
-        break;
-    case OPC_MXU_Q16SCOP:
-        /* TODO: Implement emulation of Q16SCOP instruction. */
-        MIPS_INVAL("OPC_MXU_Q16SCOP");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_Q8MADL:
-        /* TODO: Implement emulation of Q8MADL instruction. */
-        MIPS_INVAL("OPC_MXU_Q8MADL");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_S32SFL:
-        /* TODO: Implement emulation of S32SFL instruction. */
-        MIPS_INVAL("OPC_MXU_S32SFL");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_Q8SAD:
-        /* TODO: Implement emulation of Q8SAD instruction. */
-        MIPS_INVAL("OPC_MXU_Q8SAD");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    default:
-        MIPS_INVAL("decode_opc_mxu");
-        generate_exception_end(ctx, EXCP_RI);
+    {
+        TCGv t_mxu_cr = tcg_temp_new();
+        TCGLabel *l_exit = gen_new_label();
+
+        gen_load_mxu_cr(t_mxu_cr);
+        tcg_gen_andi_tl(t_mxu_cr, t_mxu_cr, MXU_CR_MXU_EN);
+        tcg_gen_brcondi_tl(TCG_COND_NE, t_mxu_cr, MXU_CR_MXU_EN, l_exit);
+
+        switch (opcode) {
+        case OPC_MXU_S32MADD:
+            /* TODO: Implement emulation of S32MADD instruction. */
+            MIPS_INVAL("OPC_MXU_S32MADD");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_S32MADDU:
+            /* TODO: Implement emulation of S32MADDU instruction. */
+            MIPS_INVAL("OPC_MXU_S32MADDU");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU__POOL00:
+            decode_opc_mxu__pool00(env, ctx);
+            break;
+        case OPC_MXU_S32MSUB:
+            /* TODO: Implement emulation of S32MSUB instruction. */
+            MIPS_INVAL("OPC_MXU_S32MSUB");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_S32MSUBU:
+            /* TODO: Implement emulation of S32MSUBU instruction. */
+            MIPS_INVAL("OPC_MXU_S32MSUBU");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU__POOL01:
+            decode_opc_mxu__pool01(env, ctx);
+            break;
+        case OPC_MXU__POOL02:
+            decode_opc_mxu__pool02(env, ctx);
+            break;
+        case OPC_MXU_D16MUL:
+            gen_mxu_d16mul(ctx);
+            break;
+        case OPC_MXU__POOL03:
+            decode_opc_mxu__pool03(env, ctx);
+            break;
+        case OPC_MXU_D16MAC:
+            gen_mxu_d16mac(ctx);
+            break;
+        case OPC_MXU_D16MACF:
+            /* TODO: Implement emulation of D16MACF instruction. */
+            MIPS_INVAL("OPC_MXU_D16MACF");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_D16MADL:
+            /* TODO: Implement emulation of D16MADL instruction. */
+            MIPS_INVAL("OPC_MXU_D16MADL");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_S16MAD:
+            /* TODO: Implement emulation of S16MAD instruction. */
+            MIPS_INVAL("OPC_MXU_S16MAD");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_Q16ADD:
+            /* TODO: Implement emulation of Q16ADD instruction. */
+            MIPS_INVAL("OPC_MXU_Q16ADD");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_D16MACE:
+            /* TODO: Implement emulation of D16MACE instruction. */
+            MIPS_INVAL("OPC_MXU_D16MACE");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU__POOL04:
+            decode_opc_mxu__pool04(env, ctx);
+            break;
+        case OPC_MXU__POOL05:
+            decode_opc_mxu__pool05(env, ctx);
+            break;
+        case OPC_MXU__POOL06:
+            decode_opc_mxu__pool06(env, ctx);
+            break;
+        case OPC_MXU__POOL07:
+            decode_opc_mxu__pool07(env, ctx);
+            break;
+        case OPC_MXU__POOL08:
+            decode_opc_mxu__pool08(env, ctx);
+            break;
+        case OPC_MXU__POOL09:
+            decode_opc_mxu__pool09(env, ctx);
+            break;
+        case OPC_MXU__POOL10:
+            decode_opc_mxu__pool10(env, ctx);
+            break;
+        case OPC_MXU__POOL11:
+            decode_opc_mxu__pool11(env, ctx);
+            break;
+        case OPC_MXU_D32ADD:
+            /* TODO: Implement emulation of D32ADD instruction. */
+            MIPS_INVAL("OPC_MXU_D32ADD");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU__POOL12:
+            decode_opc_mxu__pool12(env, ctx);
+            break;
+        case OPC_MXU__POOL13:
+            decode_opc_mxu__pool13(env, ctx);
+            break;
+        case OPC_MXU__POOL14:
+            decode_opc_mxu__pool14(env, ctx);
+            break;
+        case OPC_MXU_Q8ACCE:
+            /* TODO: Implement emulation of Q8ACCE instruction. */
+            MIPS_INVAL("OPC_MXU_Q8ACCE");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_S8LDD:
+            gen_mxu_s8ldd(ctx);
+            break;
+        case OPC_MXU_S8STD:
+            /* TODO: Implement emulation of S8STD instruction. */
+            MIPS_INVAL("OPC_MXU_S8STD");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_S8LDI:
+            /* TODO: Implement emulation of S8LDI instruction. */
+            MIPS_INVAL("OPC_MXU_S8LDI");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_S8SDI:
+            /* TODO: Implement emulation of S8SDI instruction. */
+            MIPS_INVAL("OPC_MXU_S8SDI");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU__POOL15:
+            decode_opc_mxu__pool15(env, ctx);
+            break;
+        case OPC_MXU__POOL16:
+            decode_opc_mxu__pool16(env, ctx);
+            break;
+        case OPC_MXU_LXB:
+            /* TODO: Implement emulation of LXB instruction. */
+            MIPS_INVAL("OPC_MXU_LXB");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_S16LDD:
+            /* TODO: Implement emulation of S16LDD instruction. */
+            MIPS_INVAL("OPC_MXU_S16LDD");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_S16STD:
+            /* TODO: Implement emulation of S16STD instruction. */
+            MIPS_INVAL("OPC_MXU_S16STD");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_S16LDI:
+            /* TODO: Implement emulation of S16LDI instruction. */
+            MIPS_INVAL("OPC_MXU_S16LDI");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_S16SDI:
+            /* TODO: Implement emulation of S16SDI instruction. */
+            MIPS_INVAL("OPC_MXU_S16SDI");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_D32SLL:
+            /* TODO: Implement emulation of D32SLL instruction. */
+            MIPS_INVAL("OPC_MXU_D32SLL");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_D32SLR:
+            /* TODO: Implement emulation of D32SLR instruction. */
+            MIPS_INVAL("OPC_MXU_D32SLR");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_D32SARL:
+            /* TODO: Implement emulation of D32SARL instruction. */
+            MIPS_INVAL("OPC_MXU_D32SARL");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_D32SAR:
+            /* TODO: Implement emulation of D32SAR instruction. */
+            MIPS_INVAL("OPC_MXU_D32SAR");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_Q16SLL:
+            /* TODO: Implement emulation of Q16SLL instruction. */
+            MIPS_INVAL("OPC_MXU_Q16SLL");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_Q16SLR:
+            /* TODO: Implement emulation of Q16SLR instruction. */
+            MIPS_INVAL("OPC_MXU_Q16SLR");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU__POOL17:
+            decode_opc_mxu__pool17(env, ctx);
+            break;
+        case OPC_MXU_Q16SAR:
+            /* TODO: Implement emulation of Q16SAR instruction. */
+            MIPS_INVAL("OPC_MXU_Q16SAR");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU__POOL18:
+            decode_opc_mxu__pool18(env, ctx);
+            break;
+        case OPC_MXU__POOL19:
+            decode_opc_mxu__pool19(env, ctx);
+            break;
+        case OPC_MXU__POOL20:
+            decode_opc_mxu__pool20(env, ctx);
+            break;
+        case OPC_MXU_Q16SCOP:
+            /* TODO: Implement emulation of Q16SCOP instruction. */
+            MIPS_INVAL("OPC_MXU_Q16SCOP");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_Q8MADL:
+            /* TODO: Implement emulation of Q8MADL instruction. */
+            MIPS_INVAL("OPC_MXU_Q8MADL");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_S32SFL:
+            /* TODO: Implement emulation of S32SFL instruction. */
+            MIPS_INVAL("OPC_MXU_S32SFL");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        case OPC_MXU_Q8SAD:
+            /* TODO: Implement emulation of Q8SAD instruction. */
+            MIPS_INVAL("OPC_MXU_Q8SAD");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        default:
+            MIPS_INVAL("decode_opc_mxu");
+            generate_exception_end(ctx, EXCP_RI);
+        }
+
+        gen_set_label(l_exit);
+        tcg_temp_free(t_mxu_cr);
     }
 }
 
-- 
2.7.4
