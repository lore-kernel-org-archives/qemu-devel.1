Received: from eggs.gnu.org ([2001:4830:134:3::10]:54492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8YI-0004FZ-IB
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8VX-0006Qd-J3
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:01:02 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57460 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8VW-0006Ow-7o
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:58:11 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:54:53 +0200
Message-Id: <1532004912-13899-22-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 21/40] target/mips: Implement DSP ASE
 support for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of DSP ASE instructions for nanoMIPS.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 2072 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 1681 insertions(+), 391 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index c8a9ba0..d7454a6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -14064,6 +14064,527 @@ static void gen_pool32fxf(DisasContext *ctx, int rt, int rs)
     }
 }
 
+
+static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
+                                       int rd, int rs, int rt)
+{
+    int ret = rd;
+
+    TCGv t1;
+    TCGv v1_t;
+    TCGv v2_t;
+
+    t1 = tcg_temp_new();
+    v1_t = tcg_temp_new();
+    v2_t = tcg_temp_new();
+
+    gen_load_gpr(v1_t, rs);
+    gen_load_gpr(v2_t, rt);
+
+    switch (opc) {
+    case OPC_CMP_EQ_PH:
+        check_dsp(ctx);
+        gen_helper_cmp_eq_ph(v1_t, v2_t, cpu_env);
+        break;
+    case OPC_CMP_LT_PH:
+        check_dsp(ctx);
+        gen_helper_cmp_lt_ph(v1_t, v2_t, cpu_env);
+        break;
+    case OPC_CMP_LE_PH:
+        check_dsp(ctx);
+        gen_helper_cmp_le_ph(v1_t, v2_t, cpu_env);
+        break;
+    case OPC_CMPU_EQ_QB:
+        check_dsp(ctx);
+        gen_helper_cmpu_eq_qb(v1_t, v2_t, cpu_env);
+        break;
+    case OPC_CMPU_LT_QB:
+        check_dsp(ctx);
+        gen_helper_cmpu_lt_qb(v1_t, v2_t, cpu_env);
+        break;
+    case OPC_CMPU_LE_QB:
+        check_dsp(ctx);
+        gen_helper_cmpu_le_qb(v1_t, v2_t, cpu_env);
+        break;
+    case OPC_CMPGU_EQ_QB:
+        check_dsp(ctx);
+        gen_helper_cmpgu_eq_qb(cpu_gpr[ret], v1_t, v2_t);
+        break;
+    case OPC_CMPGU_LT_QB:
+        check_dsp(ctx);
+        gen_helper_cmpgu_lt_qb(cpu_gpr[ret], v1_t, v2_t);
+        break;
+    case OPC_CMPGU_LE_QB:
+        check_dsp(ctx);
+        gen_helper_cmpgu_le_qb(cpu_gpr[ret], v1_t, v2_t);
+        break;
+    case OPC_CMPGDU_EQ_QB:
+        check_dspr2(ctx);
+        gen_helper_cmpgu_eq_qb(t1, v1_t, v2_t);
+        tcg_gen_mov_tl(cpu_gpr[ret], t1);
+        tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
+        tcg_gen_shli_tl(t1, t1, 24);
+        tcg_gen_or_tl(cpu_dspctrl, cpu_dspctrl, t1);
+        break;
+    case OPC_CMPGDU_LT_QB:
+        check_dspr2(ctx);
+        gen_helper_cmpgu_lt_qb(t1, v1_t, v2_t);
+        tcg_gen_mov_tl(cpu_gpr[ret], t1);
+        tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
+        tcg_gen_shli_tl(t1, t1, 24);
+        tcg_gen_or_tl(cpu_dspctrl, cpu_dspctrl, t1);
+        break;
+    case OPC_CMPGDU_LE_QB:
+        check_dspr2(ctx);
+        gen_helper_cmpgu_le_qb(t1, v1_t, v2_t);
+        tcg_gen_mov_tl(cpu_gpr[ret], t1);
+        tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
+        tcg_gen_shli_tl(t1, t1, 24);
+        tcg_gen_or_tl(cpu_dspctrl, cpu_dspctrl, t1);
+        break;
+    case OPC_PACKRL_PH:
+        check_dsp(ctx);
+        gen_helper_packrl_ph(cpu_gpr[ret], v1_t, v2_t);
+        break;
+    case OPC_PICK_QB:
+        check_dsp(ctx);
+        gen_helper_pick_qb(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_PICK_PH:
+        check_dsp(ctx);
+        gen_helper_pick_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_ADDQ_S_W:
+        check_dsp(ctx);
+        gen_helper_addq_s_w(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_SUBQ_S_W:
+        check_dsp(ctx);
+        gen_helper_subq_s_w(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_ADDSC:
+        check_dsp(ctx);
+        gen_helper_addsc(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_ADDWC:
+        check_dsp(ctx);
+        gen_helper_addwc(cpu_gpr[rd], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_ADDQ_S_PH:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* ADDQ_PH */
+            check_dsp(ctx);
+            gen_helper_addq_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        case 1:
+            /* ADDQ_S_PH */
+            check_dsp(ctx);
+            gen_helper_addq_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        }
+        break;
+    case OPC_ADDQH_R_PH:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* ADDQH_PH */
+            gen_helper_addqh_ph(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        case 1:
+            /* ADDQH_R_PH */
+            gen_helper_addqh_r_ph(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        }
+        break;
+    case OPC_ADDQH_R_W:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* ADDQH_W */
+            gen_helper_addqh_w(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        case 1:
+            /* ADDQH_R_W */
+            gen_helper_addqh_r_w(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        }
+        break;
+    case OPC_ADDU_S_QB:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* ADDU_QB */
+            check_dsp(ctx);
+            gen_helper_addu_qb(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        case 1:
+            /* ADDU_S_QB */
+            check_dsp(ctx);
+            gen_helper_addu_s_qb(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        }
+        break;
+    case OPC_ADDU_S_PH:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* ADDU_PH */
+            check_dspr2(ctx);
+            gen_helper_addu_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        case 1:
+            /* ADDU_S_PH */
+            check_dspr2(ctx);
+            gen_helper_addu_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        }
+        break;
+    case OPC_ADDUH_R_QB:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* ADDUH_QB */
+            gen_helper_adduh_qb(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        case 1:
+            /* ADDUH_R_QB */
+            gen_helper_adduh_r_qb(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        }
+        break;
+    case OPC_SHRAV_R_PH:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* SHRAV_PH */
+            check_dsp(ctx);
+            gen_helper_shra_ph(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        case 1:
+            /* SHRAV_R_PH */
+            check_dsp(ctx);
+            gen_helper_shra_r_ph(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        }
+        break;
+    case OPC_SHRAV_R_QB:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* SHRAV_QB */
+            check_dspr2(ctx);
+            gen_helper_shra_qb(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        case 1:
+            /* SHRAV_R_QB */
+            check_dspr2(ctx);
+            gen_helper_shra_r_qb(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        }
+        break;
+    case OPC_SUBQ_S_PH:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* SUBQ_PH */
+            check_dsp(ctx);
+            gen_helper_subq_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        case 1:
+            /* SUBQ_S_PH */
+            check_dsp(ctx);
+            gen_helper_subq_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        }
+        break;
+    case OPC_SUBQH_R_PH:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* SUBQH_PH */
+            gen_helper_subqh_ph(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        case 1:
+            /* SUBQH_R_PH */
+            gen_helper_subqh_r_ph(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        }
+        break;
+    case OPC_SUBQH_R_W:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* SUBQH_W */
+            gen_helper_subqh_w(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        case 1:
+            /* SUBQH_R_W */
+            gen_helper_subqh_r_w(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        }
+        break;
+    case OPC_SUBU_S_QB:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* SUBU_QB */
+            check_dsp(ctx);
+            gen_helper_subu_qb(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        case 1:
+            /* SUBU_S_QB */
+            check_dsp(ctx);
+            gen_helper_subu_s_qb(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        }
+        break;
+    case OPC_SUBU_S_PH:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* SUBU_PH */
+            check_dspr2(ctx);
+            gen_helper_subu_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        case 1:
+            /* SUBU_S_PH */
+            check_dspr2(ctx);
+            gen_helper_subu_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        }
+        break;
+    case OPC_SUBUH_R_QB:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* SUBUH_QB */
+            gen_helper_subuh_qb(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        case 1:
+            /* SUBUH_R_QB */
+            gen_helper_subuh_r_qb(cpu_gpr[ret], v1_t, v2_t);
+            break;
+        }
+        break;
+    case OPC_SHLLV_S_PH:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* SHLLV_PH */
+            check_dsp(ctx);
+            gen_helper_shll_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        case 1:
+            /* SHLLV_S_PH */
+            check_dsp(ctx);
+            gen_helper_shll_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        }
+        break;
+    case OPC_PRECR_SRA_R_PH_W:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* PRECR_SRA_PH_W */
+            check_dspr2(ctx);
+            {
+                TCGv_i32 sa_t = tcg_const_i32(rd);
+                gen_helper_precr_sra_ph_w(cpu_gpr[rt], sa_t, v1_t,
+                                          cpu_gpr[rt]);
+                tcg_temp_free_i32(sa_t);
+            }
+            break;
+        case 1:
+            /* PRECR_SRA_R_PH_W */
+            check_dspr2(ctx);
+            {
+                TCGv_i32 sa_t = tcg_const_i32(rd);
+                gen_helper_precr_sra_r_ph_w(cpu_gpr[rt], sa_t, v1_t,
+                                            cpu_gpr[rt]);
+                tcg_temp_free_i32(sa_t);
+            }
+            break;
+        }
+        break;
+    case OPC_MULEU_S_PH_QBL:
+        check_dsp(ctx);
+        gen_helper_muleu_s_ph_qbl(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_MULEU_S_PH_QBR:
+        check_dsp(ctx);
+        gen_helper_muleu_s_ph_qbr(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_MULQ_RS_PH:
+        check_dsp(ctx);
+        gen_helper_mulq_rs_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_MULQ_S_PH:
+        check_dspr2(ctx);
+        gen_helper_mulq_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_MULQ_RS_W:
+        gen_helper_mulq_rs_w(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_MULQ_S_W:
+        gen_helper_mulq_s_w(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_APPEND:
+    {
+        TCGv t0;
+
+        t0 = tcg_temp_new();
+        gen_load_gpr(t0, rs);
+
+        if (rd != 0) {
+            tcg_gen_deposit_tl(cpu_gpr[rt], t0, cpu_gpr[rt], rd, 32 - rd);
+        }
+        tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
+    }
+    break;
+    case OPC_MODSUB:
+        check_dsp(ctx);
+        gen_helper_modsub(cpu_gpr[ret], v1_t, v2_t);
+        break;
+    case OPC_SHRAV_R_W:
+        check_dsp(ctx);
+        gen_helper_shra_r_w(cpu_gpr[ret], v1_t, v2_t);
+        break;
+    case OPC_SHRLV_PH:
+        check_dspr2(ctx);
+        gen_helper_shrl_ph(cpu_gpr[ret], v1_t, v2_t);
+        break;
+    case OPC_SHRLV_QB:
+        check_dsp(ctx);
+        gen_helper_shrl_qb(cpu_gpr[ret], v1_t, v2_t);
+        break;
+    case OPC_SHLLV_QB:
+        check_dsp(ctx);
+        gen_helper_shll_qb(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_SHLLV_S_W:
+        check_dsp(ctx);
+        gen_helper_shll_s_w(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_SHILO:
+    {
+        TCGv t0;
+        TCGv t1;
+        t0 = tcg_temp_new();
+        t1 = tcg_temp_new();
+
+        int16_t imm = (ctx->opcode >> 16) & 0x3F;
+
+        tcg_gen_movi_tl(t0, rd >> 3);
+        tcg_gen_movi_tl(t1, imm);
+
+        gen_helper_shilo(t0, t1, cpu_env);
+    }
+    break;
+    case OPC_MULEQ_S_W_PHL:
+        check_dsp(ctx);
+        gen_helper_muleq_s_w_phl(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_MULEQ_S_W_PHR:
+        check_dsp(ctx);
+        gen_helper_muleq_s_w_phr(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_MUL_S_PH:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* MUL_PH */
+            gen_helper_mul_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        case 1:
+            /* MUL_S_PH */
+            gen_helper_mul_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+            break;
+        }
+        break;
+    case OPC_PRECR_QB_PH:
+        check_dspr2(ctx);
+        gen_helper_precr_qb_ph(cpu_gpr[ret], v1_t, v2_t);
+        break;
+    case OPC_PRECRQ_QB_PH:
+        check_dsp(ctx);
+        gen_helper_precrq_qb_ph(cpu_gpr[ret], v1_t, v2_t);
+        break;
+    case OPC_PRECRQ_PH_W:
+        check_dsp(ctx);
+        gen_helper_precrq_ph_w(cpu_gpr[ret], v1_t, v2_t);
+        break;
+    case OPC_PRECRQ_RS_PH_W:
+        check_dsp(ctx);
+        gen_helper_precrq_rs_ph_w(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_PRECRQU_S_QB_PH:
+        check_dsp(ctx);
+        gen_helper_precrqu_s_qb_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_SHRA_R_W:
+    {
+        TCGv t0;
+        t0 = tcg_temp_new();
+        tcg_gen_movi_tl(t0, rd);
+
+        check_dsp(ctx);
+        gen_helper_shra_r_w(cpu_gpr[rt], t0, v1_t);
+        break;
+    }
+    case OPC_SHRA_R_PH:
+    {
+        TCGv t0;
+        t0 = tcg_temp_new();
+        tcg_gen_movi_tl(t0, rd >> 1);
+
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case 0:
+            /* SHRA_PH */
+            check_dsp(ctx);
+            gen_helper_shra_ph(cpu_gpr[rt], t0, v1_t);
+            break;
+        case 1:
+            /* SHRA_R_PH */
+            check_dsp(ctx);
+            gen_helper_shra_r_ph(cpu_gpr[rt], t0, v1_t);
+            break;
+        }
+    }
+    break;
+    case OPC_SHLL_S_PH:
+    {
+        TCGv t0;
+        t0 = tcg_temp_new();
+        tcg_gen_movi_tl(t0, rd >> 1);
+
+        switch ((ctx->opcode >> 10) & 0x3) {
+        case 0:
+            /* SHLL_PH */
+            check_dsp(ctx);
+            gen_helper_shll_ph(cpu_gpr[rt], t0, v1_t, cpu_env);
+            break;
+        case 2:
+            /* SHLL_S_PH */
+            check_dsp(ctx);
+            gen_helper_shll_s_ph(cpu_gpr[rt], t0, v1_t, cpu_env);
+            break;
+        }
+    }
+    break;
+    case OPC_SHLL_S_W:
+    {
+        TCGv t0;
+        t0 = tcg_temp_new();
+        tcg_gen_movi_tl(t0, rd);
+
+        check_dsp(ctx);
+        gen_helper_shll_s_w(cpu_gpr[rt], t0, v1_t, cpu_env);
+        break;
+    }
+    break;
+    case OPC_REPL_PH:
+    check_dsp(ctx);
+    {
+        int16_t imm;
+        imm = (ctx->opcode >> 11) & 0x03FF;
+        imm = (int16_t)(imm << 6) >> 6;
+        tcg_gen_movi_tl(cpu_gpr[rt], \
+                        (target_long)((int32_t)imm << 16 | \
+                        (uint16_t)imm));
+    }
+    break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+
 static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     int32_t offset;
@@ -16370,508 +16891,1253 @@ enum {
     NM_LWC1X    = 0x0a,
     NM_LDC1X    = 0x0e,
 
-    NM_LWUX     = 0x07,
-    NM_SWC1X    = 0x0b,
-    NM_SDC1X    = 0x0f,
+    NM_LWUX     = 0x07,
+    NM_SWC1X    = 0x0b,
+    NM_SDC1X    = 0x0f,
+
+    NM_LHXS     = 0x04,
+    NM_LWXS     = 0x08,
+    NM_LDXS     = 0x0c,
+
+    NM_SHXS     = 0x05,
+    NM_SWXS     = 0x09,
+    NM_SDXS     = 0x0d,
+
+    NM_LHUXS    = 0x06,
+    NM_LWC1XS   = 0x0a,
+    NM_LDC1XS   = 0x0e,
+
+    NM_LWUXS    = 0x07,
+    NM_SWC1XS   = 0x0b,
+    NM_SDC1XS   = 0x0f,
+};
+
+/* ERETx instruction pool */
+enum {
+    NM_ERET     = 0x00,
+    NM_ERETNC   = 0x01,
+};
+
+/* POOL32FxF_{0, 1} insturction pool */
+enum {
+    NM_CFC1     = 0x40,
+    NM_CTC1     = 0x60,
+    NM_MFC1     = 0x80,
+    NM_MTC1     = 0xa0,
+    NM_MFHC1    = 0xc0,
+    NM_MTHC1    = 0xe0,
+
+    NM_CVT_S_PL = 0x84,
+    NM_CVT_S_PU = 0xa4,
+
+    NM_CVT_L_S     = 0x004,
+    NM_CVT_L_D     = 0x104,
+    NM_CVT_W_S     = 0x024,
+    NM_CVT_W_D     = 0x124,
+
+    NM_RSQRT_S     = 0x008,
+    NM_RSQRT_D     = 0x108,
+
+    NM_SQRT_S      = 0x028,
+    NM_SQRT_D      = 0x128,
+
+    NM_RECIP_S     = 0x048,
+    NM_RECIP_D     = 0x148,
+
+    NM_FLOOR_L_S   = 0x00c,
+    NM_FLOOR_L_D   = 0x10c,
+
+    NM_FLOOR_W_S   = 0x02c,
+    NM_FLOOR_W_D   = 0x12c,
+
+    NM_CEIL_L_S    = 0x04c,
+    NM_CEIL_L_D    = 0x14c,
+    NM_CEIL_W_S    = 0x06c,
+    NM_CEIL_W_D    = 0x16c,
+    NM_TRUNC_L_S   = 0x08c,
+    NM_TRUNC_L_D   = 0x18c,
+    NM_TRUNC_W_S   = 0x0ac,
+    NM_TRUNC_W_D   = 0x1ac,
+    NM_ROUND_L_S   = 0x0cc,
+    NM_ROUND_L_D   = 0x1cc,
+    NM_ROUND_W_S   = 0x0ec,
+    NM_ROUND_W_D   = 0x1ec,
+
+    NM_MOV_S       = 0x01,
+    NM_MOV_D       = 0x81,
+    NM_ABS_S       = 0x0d,
+    NM_ABS_D       = 0x8d,
+    NM_NEG_S       = 0x2d,
+    NM_NEG_D       = 0xad,
+    NM_CVT_D_S     = 0x04d,
+    NM_CVT_D_W     = 0x0cd,
+    NM_CVT_D_L     = 0x14d,
+    NM_CVT_S_D     = 0x06d,
+    NM_CVT_S_W     = 0x0ed,
+    NM_CVT_S_L     = 0x16d,
+};
+
+/* P.LL instruction pool */
+enum {
+    NM_LL       = 0x00,
+    NM_LLWP     = 0x01,
+};
+
+/* P.SC instruction pool */
+enum {
+    NM_SC       = 0x00,
+    NM_SCWP     = 0x01,
+};
+
+/* P.DVP instruction pool */
+enum {
+    NM_DVP      = 0x00,
+    NM_EVP      = 0x01,
+};
+
+
+/*
+ *
+ * nanoMIPS decoding engine
+ *
+ */
+
+static int decode_gpr_gpr3(int r)
+{
+    static const int map[] = { 16, 17, 18, 19, 4, 5, 6, 7 };
+
+    return map[r & 0x7];
+}
+
+/* Used for 16-bit store instructions.  */
+static int decode_gpr_gpr3_src_store(int r)
+{
+    static const int map[] = { 0, 17, 18, 19, 4, 5, 6, 7 };
+
+    return map[r & 0x7];
+}
+
+static int decode_gpr_gpr4(int r)
+{
+    static const int map[] = { 8, 9, 10, 11, 4, 5, 6, 7,
+                            16, 17, 18, 19, 20, 21, 22, 23 };
+
+    return map[r & 0xf];
+}
+
+/* Used for 16-bit store instructions.  */
+static int decode_gpr_gpr4_zero(int r)
+{
+    static const int map[] = { 8, 9, 10, 0, 4, 5, 6, 7,
+                            16, 17, 18, 19, 20, 21, 22, 23 };
+
+    return map[r & 0xf];
+}
+
+
+/* extraction utilities */
+
+#define NANOMIPS_EXTRACT_RD(op) ((op >> 7) & 0x7)
+#define NANOMIPS_EXTRACT_RS(op) ((op >> 4) & 0x7)
+#define NANOMIPS_EXTRACT_RS2(op) uMIPS_RS(op)
+#define NANOMIPS_EXTRACT_RS1(op) ((op >> 1) & 0x7)
+#define NANOMIPS_EXTRACT_RD5(op) ((op >> 5) & 0x1f)
+#define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
+
+
+static void gen_adjust_sp(DisasContext *ctx, int u)
+{
+    TCGv tsp = tcg_temp_new();
+    gen_base_offset_addr(ctx, tsp, 29, u);
+    gen_store_gpr(tsp, 29);
+    tcg_temp_free(tsp);
+}
+
+static void gen_save(DisasContext *ctx, uint8_t rt, uint8_t count,
+                     uint8_t gp, uint16_t u)
+{
+    int counter = 0;
+    TCGv va = tcg_temp_new();
+    TCGv t0 = tcg_temp_new();
+
+    while (counter != count) {
+        bool use_gp = gp && (counter == count - 1);
+        int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
+        int this_offset = -((counter + 1) << 2);
+        gen_base_offset_addr(ctx, va, 29, this_offset);
+        gen_load_gpr(t0, this_rt);
+        tcg_gen_qemu_st_tl(t0, va, ctx->mem_idx,
+                           MO_TEUL | ctx->default_tcg_memop_mask);
+        counter++;
+    }
 
-    NM_LHXS     = 0x04,
-    NM_LWXS     = 0x08,
-    NM_LDXS     = 0x0c,
+    /* adjust stack pointer */
+    gen_adjust_sp(ctx, -u);
 
-    NM_SHXS     = 0x05,
-    NM_SWXS     = 0x09,
-    NM_SDXS     = 0x0d,
+    tcg_temp_free(t0);
+    tcg_temp_free(va);
+}
 
-    NM_LHUXS    = 0x06,
-    NM_LWC1XS   = 0x0a,
-    NM_LDC1XS   = 0x0e,
+static void gen_restore(DisasContext *ctx, uint8_t rt, uint8_t count,
+                        uint8_t gp, uint16_t u)
+{
+    int counter = 0;
+    TCGv va = tcg_temp_new();
+    TCGv t0 = tcg_temp_new();
 
-    NM_LWUXS    = 0x07,
-    NM_SWC1XS   = 0x0b,
-    NM_SDC1XS   = 0x0f,
-};
+    while (counter != count) {
+        bool use_gp = gp && (counter == count - 1);
+        int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
+        int this_offset = u - ((counter + 1) << 2);
+        gen_base_offset_addr(ctx, va, 29, this_offset);
+        tcg_gen_qemu_ld_tl(t0, va, ctx->mem_idx, MO_TESL |
+                        ctx->default_tcg_memop_mask);
+        tcg_gen_ext32s_tl(t0, t0);
+        gen_store_gpr(t0, this_rt);
+        counter++;
+    }
 
-/* ERETx instruction pool */
-enum {
-    NM_ERET     = 0x00,
-    NM_ERETNC   = 0x01,
-};
+    /* adjust stack pointer */
+    gen_adjust_sp(ctx, u);
 
-/* POOL32FxF_{0, 1} insturction pool */
-enum {
-    NM_CFC1     = 0x40,
-    NM_CTC1     = 0x60,
-    NM_MFC1     = 0x80,
-    NM_MTC1     = 0xa0,
-    NM_MFHC1    = 0xc0,
-    NM_MTHC1    = 0xe0,
+    tcg_temp_free(t0);
+    tcg_temp_free(va);
+}
 
-    NM_CVT_S_PL = 0x84,
-    NM_CVT_S_PU = 0xa4,
+static void gen_pool16c_nanomips_insn(DisasContext *ctx)
+{
+    int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD(ctx->opcode));
+    int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
 
-    NM_CVT_L_S     = 0x004,
-    NM_CVT_L_D     = 0x104,
-    NM_CVT_W_S     = 0x024,
-    NM_CVT_W_D     = 0x124,
+    switch ((ctx->opcode >> 2) & 0x3) {
+    case NM_NOT16:
+        gen_logic(ctx, OPC_NOR, rt, rs, 0);
+        break;
+    case NM_AND16:
+        gen_logic(ctx, OPC_AND, rt, rt, rs);
+        break;
+    case NM_XOR16:
+        gen_logic(ctx, OPC_XOR, rt, rt, rs);
+        break;
+    case NM_OR16:
+        gen_logic(ctx, OPC_OR, rt, rt, rs);
+        break;
+    }
+}
 
-    NM_RSQRT_S     = 0x008,
-    NM_RSQRT_D     = 0x108,
+static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
+{
+    int rt = (ctx->opcode >> 21) & 0x1f;
+    int rs = (ctx->opcode >> 16) & 0x1f;
+    int rd = (ctx->opcode >> 11) & 0x1f;
 
-    NM_SQRT_S      = 0x028,
-    NM_SQRT_D      = 0x128,
+    switch ((ctx->opcode >> 3) & 0x7f) {
+    case NM_P_TRAP:
+        switch ((ctx->opcode >> 10) & 0x1) {
+        case NM_TEQ:
+            gen_trap(ctx, OPC_TEQ, rs, rt, -1);
+            break;
+        case NM_TNE:
+            gen_trap(ctx, OPC_TNE, rs, rt, -1);
+            break;
+        }
+        break;
+    case NM_RDHWR:
+        gen_rdhwr(ctx, rt, rs, extract32(ctx->opcode, 11, 3));
+        break;
+    case NM_SEB:
+        gen_bshfl(ctx, OPC_SEB, rs, rt);
+        break;
+    case NM_SEH:
+        gen_bshfl(ctx, OPC_SEH, rs, rt);
+        break;
+    case NM_SLLV:
+        gen_shift(ctx, OPC_SLLV, rd, rt, rs);
+        break;
+    case NM_SRLV:
+        gen_shift(ctx, OPC_SRLV, rd, rt, rs);
+        break;
+    case NM_SRAV:
+        gen_shift(ctx, OPC_SRAV, rd, rt, rs);
+        break;
+    case NM_ROTRV:
+        gen_shift(ctx, OPC_ROTRV, rd, rt, rs);
+        break;
+    case NM_ADD:
+        gen_arith(ctx, OPC_ADD, rd, rs, rt);
+        break;
+    case NM_ADDU:
+        gen_arith(ctx, OPC_ADDU, rd, rs, rt);
+        break;
+    case NM_SUB:
+        gen_arith(ctx, OPC_SUB, rd, rs, rt);
+        break;
+    case NM_SUBU:
+        gen_arith(ctx, OPC_SUBU, rd, rs, rt);
+        break;
+    case NM_P_CMOVE:
+        switch ((ctx->opcode >> 10) & 1) {
+        case NM_MOVZ:
+            gen_cond_move(ctx, OPC_MOVZ, rd, rs, rt);
+            break;
+        case NM_MOVN:
+            gen_cond_move(ctx, OPC_MOVN, rd, rs, rt);
+            break;
+        }
+        break;
+    case NM_AND:
+        gen_logic(ctx, OPC_AND, rd, rs, rt);
+        break;
+    case NM_OR:
+        gen_logic(ctx, OPC_OR, rd, rs, rt);
+        break;
+    case NM_NOR:
+        gen_logic(ctx, OPC_NOR, rd, rs, rt);
+        break;
+    case NM_XOR:
+        gen_logic(ctx, OPC_XOR, rd, rs, rt);
+        break;
+    case NM_SLT:
+        gen_slt(ctx, OPC_SLT, rd, rs, rt);
+        break;
+    case NM_P_SLTU:
+        if (rd == 0) {
+            /* P_DVP */
+#ifndef CONFIG_USER_ONLY
+            TCGv t0 = tcg_temp_new();
+            switch ((ctx->opcode >> 10) & 1) {
+            case NM_DVP:
+                if (ctx->vp) {
+                    check_cp0_enabled(ctx);
+                    gen_helper_dvp(t0, cpu_env);
+                    gen_store_gpr(t0, rt);
+                }
+                break;
+            case NM_EVP:
+                if (ctx->vp) {
+                    check_cp0_enabled(ctx);
+                    gen_helper_evp(t0, cpu_env);
+                    gen_store_gpr(t0, rt);
+                }
+                break;
+            }
+            tcg_temp_free(t0);
+#endif
+        } else {
+            gen_slt(ctx, OPC_SLTU, rd, rs, rt);
+        }
+        break;
+    case NM_SOV:
+    {
+        TCGv t0 = tcg_temp_local_new();
+        TCGv t1 = tcg_temp_new();
+        TCGv t2 = tcg_temp_new();
+        TCGLabel *l1 = gen_new_label();
 
-    NM_RECIP_S     = 0x048,
-    NM_RECIP_D     = 0x148,
+        gen_load_gpr(t1, rs);
+        gen_load_gpr(t2, rt);
+        tcg_gen_add_tl(t0, t1, t2);
+        tcg_gen_ext32s_tl(t0, t0);
+        tcg_gen_xor_tl(t1, t1, t2);
+        tcg_gen_xor_tl(t2, t0, t2);
+        tcg_gen_andc_tl(t1, t2, t1);
 
-    NM_FLOOR_L_S   = 0x00c,
-    NM_FLOOR_L_D   = 0x10c,
+        tcg_gen_movi_tl(t0, 0);
+        tcg_gen_brcondi_tl(TCG_COND_GE, t1, 0, l1);
+        /* operands of same sign, result different sign */
 
-    NM_FLOOR_W_S   = 0x02c,
-    NM_FLOOR_W_D   = 0x12c,
+        tcg_gen_movi_tl(t0, 1);
+        gen_set_label(l1);
+        gen_store_gpr(t0, rd);
 
-    NM_CEIL_L_S    = 0x04c,
-    NM_CEIL_L_D    = 0x14c,
-    NM_CEIL_W_S    = 0x06c,
-    NM_CEIL_W_D    = 0x16c,
-    NM_TRUNC_L_S   = 0x08c,
-    NM_TRUNC_L_D   = 0x18c,
-    NM_TRUNC_W_S   = 0x0ac,
-    NM_TRUNC_W_D   = 0x1ac,
-    NM_ROUND_L_S   = 0x0cc,
-    NM_ROUND_L_D   = 0x1cc,
-    NM_ROUND_W_S   = 0x0ec,
-    NM_ROUND_W_D   = 0x1ec,
+        tcg_temp_free(t0);
+        tcg_temp_free(t1);
+        tcg_temp_free(t2);
+    }
+        break;
+    case NM_MUL:
+        gen_r6_muldiv(ctx, R6_OPC_MUL, rd, rs, rt);
+        break;
+    case NM_MUH:
+        gen_r6_muldiv(ctx, R6_OPC_MUH, rd, rs, rt);
+        break;
+    case NM_MULU:
+        gen_r6_muldiv(ctx, R6_OPC_MULU, rd, rs, rt);
+        break;
+    case NM_MUHU:
+        gen_r6_muldiv(ctx, R6_OPC_MUHU, rd, rs, rt);
+        break;
+    case NM_DIV:
+        gen_r6_muldiv(ctx, R6_OPC_DIV, rd, rs, rt);
+        break;
+    case NM_MOD:
+        gen_r6_muldiv(ctx, R6_OPC_MOD, rd, rs, rt);
+        break;
+    case NM_DIVU:
+        gen_r6_muldiv(ctx, R6_OPC_DIVU, rd, rs, rt);
+        break;
+    case NM_MODU:
+        gen_r6_muldiv(ctx, R6_OPC_MODU, rd, rs, rt);
+        break;
+#ifndef CONFIG_USER_ONLY
+    case NM_MFC0:
+        check_cp0_enabled(ctx);
+        if (rt == 0) {
+            /* Treat as NOP. */
+            break;
+        }
+        gen_mfc0(ctx, cpu_gpr[rt], rs, (ctx->opcode >> 11) & 0x7);
+        break;
+    case NM_MTC0:
+        check_cp0_enabled(ctx);
+        {
+            TCGv t0 = tcg_temp_new();
 
-    NM_MOV_S       = 0x01,
-    NM_MOV_D       = 0x81,
-    NM_ABS_S       = 0x0d,
-    NM_ABS_D       = 0x8d,
-    NM_NEG_S       = 0x2d,
-    NM_NEG_D       = 0xad,
-    NM_CVT_D_S     = 0x04d,
-    NM_CVT_D_W     = 0x0cd,
-    NM_CVT_D_L     = 0x14d,
-    NM_CVT_S_D     = 0x06d,
-    NM_CVT_S_W     = 0x0ed,
-    NM_CVT_S_L     = 0x16d,
-};
+            gen_load_gpr(t0, rt);
+            gen_mtc0(ctx, t0, rs, (ctx->opcode >> 11) & 0x7);
+            tcg_temp_free(t0);
+        }
+        break;
+    case NM_D_E_MT_VPE:
+        {
+            uint8_t sc = (ctx->opcode >> 10) & 1;
+            TCGv t0 = tcg_temp_new();
 
-/* P.LL instruction pool */
-enum {
-    NM_LL       = 0x00,
-    NM_LLWP     = 0x01,
-};
+            switch (sc) {
+            case 0:
+                if (rs == 1) {
+                    /* DMT */
+                    check_insn(ctx, ASE_MT);
+                    gen_helper_dmt(t0);
+                    gen_store_gpr(t0, rt);
+                } else if (rs == 0) {
+                    /* DVPE */
+                    check_insn(ctx, ASE_MT);
+                    gen_helper_dvpe(t0, cpu_env);
+                    gen_store_gpr(t0, rt);
+                } else {
+                    generate_exception_end(ctx, EXCP_RI);
+                }
+                break;
+            case 1:
+                if (rs == 1) {
+                    /* EMT */
+                    check_insn(ctx, ASE_MT);
+                    gen_helper_emt(t0);
+                    gen_store_gpr(t0, rt);
+                } else if (rs == 0) {
+                    /* EVPE */
+                    check_insn(ctx, ASE_MT);
+                    gen_helper_evpe(t0, cpu_env);
+                    gen_store_gpr(t0, rt);
+                } else {
+                    generate_exception_end(ctx, EXCP_RI);
+                }
+                break;
+            }
 
-/* P.SC instruction pool */
-enum {
-    NM_SC       = 0x00,
-    NM_SCWP     = 0x01,
-};
+            tcg_temp_free(t0);
+        }
+    break;
+    case NM_FORK:
+        check_insn(ctx, ASE_MT);
+        {
+            TCGv t0 = tcg_temp_new();
+            TCGv t1 = tcg_temp_new();
 
-/* P.DVP instruction pool */
-enum {
-    NM_DVP      = 0x00,
-    NM_EVP      = 0x01,
-};
+            gen_load_gpr(t0, rt);
+            gen_load_gpr(t1, rs);
+            gen_helper_fork(t0, t1);
+            tcg_temp_free(t0);
+            tcg_temp_free(t1);
+        }
+        break;
+    case NM_MFTR:
+    case NM_MFHTR:
+        check_insn(ctx, ASE_MT);
+        if (rd == 0) {
+            /* Treat as NOP. */
+            return;
+        }
+        gen_mftr(env, ctx, rs, rt, (ctx->opcode >> 10) & 1,
+                 (ctx->opcode >> 11) & 0x1f, (ctx->opcode >> 3) & 1);
+        break;
+    case NM_MTTR:
+    case NM_MTHTR:
+        check_insn(ctx, ASE_MT);
+        gen_mttr(env, ctx, rs, rt, (ctx->opcode >> 10) & 1,
+                 (ctx->opcode >> 11) & 0x1f, (ctx->opcode >> 3) & 1);
+        break;
+    case NM_YIELD:
+        check_insn(ctx, ASE_MT);
+        {
+            TCGv t0 = tcg_temp_new();
 
+            gen_load_gpr(t0, rs);
+            gen_helper_yield(t0, cpu_env, t0);
+            gen_store_gpr(t0, rt);
+            tcg_temp_free(t0);
+        }
+        break;
+#endif
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
 
-/*
- *
- * nanoMIPS decoding engine
- *
- */
 
-static int decode_gpr_gpr3(int r)
+static void gen_pool32axf_1_5_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                            int ret, int v1, int v2)
 {
-    static const int map[] = { 16, 17, 18, 19, 4, 5, 6, 7 };
+    TCGv_i32 t0;
+    TCGv v0_t;
+    TCGv v1_t;
 
-    return map[r & 0x7];
-}
+    t0 = tcg_temp_new_i32();
 
-/* Used for 16-bit store instructions.  */
-static int decode_gpr_gpr3_src_store(int r)
-{
-    static const int map[] = { 0, 17, 18, 19, 4, 5, 6, 7 };
+    v0_t = tcg_temp_new();
+    v1_t = tcg_temp_new();
 
-    return map[r & 0x7];
-}
+    tcg_gen_movi_i32(t0, v2 >> 3);
 
-static int decode_gpr_gpr4(int r)
-{
-    static const int map[] = { 8, 9, 10, 11, 4, 5, 6, 7,
-                            16, 17, 18, 19, 20, 21, 22, 23 };
+    gen_load_gpr(v0_t, ret);
+    gen_load_gpr(v1_t, v1);
 
-    return map[r & 0xf];
-}
+    switch (opc) {
+    case NM_MAQ_S_W_PHR:
+        check_dsp(ctx);
+        gen_helper_maq_s_w_phr(t0, v1_t, v0_t, cpu_env);
+        break;
+    case NM_MAQ_S_W_PHL:
+        check_dsp(ctx);
+        gen_helper_maq_s_w_phl(t0, v1_t, v0_t, cpu_env);
+        break;
+    case NM_MAQ_SA_W_PHR:
+        check_dsp(ctx);
+        gen_helper_maq_sa_w_phr(t0, v1_t, v0_t, cpu_env);
+        break;
+    case NM_MAQ_SA_W_PHL:
+        check_dsp(ctx);
+        gen_helper_maq_sa_w_phl(t0, v1_t, v0_t, cpu_env);
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
 
-/* Used for 16-bit store instructions.  */
-static int decode_gpr_gpr4_zero(int r)
-{
-    static const int map[] = { 8, 9, 10, 0, 4, 5, 6, 7,
-                            16, 17, 18, 19, 20, 21, 22, 23 };
+    tcg_temp_free_i32(t0);
 
-    return map[r & 0xf];
+    tcg_temp_free(v0_t);
+    tcg_temp_free(v1_t);
 }
 
 
-/* extraction utilities */
+static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                    int ret, int v1, int v2)
+{
+    int16_t imm;
 
-#define NANOMIPS_EXTRACT_RD(op) ((op >> 7) & 0x7)
-#define NANOMIPS_EXTRACT_RS(op) ((op >> 4) & 0x7)
-#define NANOMIPS_EXTRACT_RS2(op) uMIPS_RS(op)
-#define NANOMIPS_EXTRACT_RS1(op) ((op >> 1) & 0x7)
-#define NANOMIPS_EXTRACT_RD5(op) ((op >> 5) & 0x1f)
-#define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
+    TCGv t0;
+    TCGv t1;
+    TCGv v0_t;
+    TCGv v1_t;
 
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
 
-static void gen_adjust_sp(DisasContext *ctx, int u)
-{
-    TCGv tsp = tcg_temp_new();
-    gen_base_offset_addr(ctx, tsp, 29, u);
-    gen_store_gpr(tsp, 29);
-    tcg_temp_free(tsp);
-}
+    v0_t = tcg_temp_new();
+    v1_t = tcg_temp_new();
 
-static void gen_save(DisasContext *ctx, uint8_t rt, uint8_t count,
-                     uint8_t gp, uint16_t u)
-{
-    int counter = 0;
-    TCGv va = tcg_temp_new();
-    TCGv t0 = tcg_temp_new();
+    gen_load_gpr(v0_t, ret);
+    gen_load_gpr(v1_t, v1);
 
-    while (counter != count) {
-        bool use_gp = gp && (counter == count - 1);
-        int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
-        int this_offset = -((counter + 1) << 2);
-        gen_base_offset_addr(ctx, va, 29, this_offset);
-        gen_load_gpr(t0, this_rt);
-        tcg_gen_qemu_st_tl(t0, va, ctx->mem_idx,
-                           (MO_TEUL | ctx->default_tcg_memop_mask));
-        counter++;
+    switch (opc) {
+    case NM_POOL32AXF_1_0:
+        switch ((ctx->opcode >> 12) & 0x03) {
+        case NM_MFHI:
+            gen_HILO(ctx, OPC_MFHI, v2 >> 3, ret);
+            break;
+        case NM_MFLO:
+            gen_HILO(ctx, OPC_MFLO, v2 >> 3, ret);
+            break;
+        case NM_MTHI:
+            gen_HILO(ctx, OPC_MTHI, v2 >> 3, v1);
+            break;
+        case NM_MTLO:
+            gen_HILO(ctx, OPC_MTLO, v2 >> 3, v1);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_1_1:
+        switch ((ctx->opcode >> 12) & 0x03) {
+        case NM_MTHLIP:
+            tcg_gen_movi_tl(t0, v2);
+            gen_helper_mthlip(t0, v1_t, cpu_env);
+            break;
+        case NM_SHILOV:
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            gen_helper_shilo(t0, v1_t, cpu_env);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_1_3:
+        imm = (ctx->opcode >> 14) & 0x07F;
+        switch ((ctx->opcode >> 12) & 0x03) {
+        case NM_RDDSP:
+            tcg_gen_movi_tl(t0, imm);
+            gen_helper_rddsp(cpu_gpr[ret], t0, cpu_env);
+            break;
+        case NM_WRDSP:
+            tcg_gen_movi_tl(t0, imm);
+            gen_helper_wrdsp(v0_t, t0, cpu_env);
+            break;
+        case NM_EXTP:
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            tcg_gen_movi_tl(t1, v1);
+            gen_helper_extp(cpu_gpr[ret], t0, t1, cpu_env);
+            break;
+        case NM_EXTPDP:
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            tcg_gen_movi_tl(t1, v1);
+            gen_helper_extpdp(cpu_gpr[ret], t0, t1, cpu_env);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_1_4:
+        tcg_gen_movi_tl(t0, v2 >> 2);
+        switch ((ctx->opcode >> 12) & 0x01) {
+        case NM_SHLL_QB:
+            check_dsp(ctx);
+            gen_helper_shll_qb(cpu_gpr[ret], t0, v1_t, cpu_env);
+            break;
+        case NM_SHRL_QB:
+            check_dsp(ctx);
+            gen_helper_shrl_qb(cpu_gpr[ret], t0, v1_t);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_1_5:
+        {
+            uint32_t opc = (ctx->opcode >> 12) & 0x03;
+            gen_pool32axf_1_5_nanomips_insn(ctx, opc, ret, v1, v2);
+        }
+        break;
+    case NM_POOL32AXF_1_7:
+        tcg_gen_movi_tl(t0, v2 >> 3);
+        tcg_gen_movi_tl(t1, v1);
+        switch ((ctx->opcode >> 12) & 0x03) {
+        case NM_EXTR_W:
+            gen_helper_extr_w(cpu_gpr[ret], t0, t1, cpu_env);
+            break;
+        case NM_EXTR_R_W:
+            gen_helper_extr_r_w(cpu_gpr[ret], t0, t1, cpu_env);
+            break;
+        case NM_EXTR_RS_W:
+            gen_helper_extr_rs_w(cpu_gpr[ret], t0, t1, cpu_env);
+            break;
+        case NM_EXTR_S_H:
+            gen_helper_extr_s_h(cpu_gpr[ret], t0, t1, cpu_env);
+            break;
+        }
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
     }
 
-    /* adjust stack pointer */
-    gen_adjust_sp(ctx, -u);
-
     tcg_temp_free(t0);
-    tcg_temp_free(va);
+    tcg_temp_free(t1);
+
+    tcg_temp_free(v0_t);
+    tcg_temp_free(v1_t);
 }
 
-static void gen_restore(DisasContext *ctx, uint8_t rt, uint8_t count,
-                        uint8_t gp, uint16_t u)
+static void gen_pool32axf_2_multiply(DisasContext *ctx, uint32_t opc,
+                                    int ret, int v1, int v2)
 {
-    int counter = 0;
-    TCGv va = tcg_temp_new();
-    TCGv t0 = tcg_temp_new();
+    TCGv_i32 t0;
+    TCGv v0_t;
+    TCGv v1_t;
 
-    while (counter != count) {
-        bool use_gp = gp && (counter == count - 1);
-        int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
-        int this_offset = u - ((counter + 1) << 2);
-        gen_base_offset_addr(ctx, va, 29, this_offset);
-        tcg_gen_qemu_ld_tl(t0, va, ctx->mem_idx, MO_TESL |
-                        ctx->default_tcg_memop_mask);
-        tcg_gen_ext32s_tl(t0, t0);
-        gen_store_gpr(t0, this_rt);
-        counter++;
-    }
+    t0 = tcg_temp_new_i32();
 
-    /* adjust stack pointer */
-    gen_adjust_sp(ctx, u);
+    v0_t = tcg_temp_new();
+    v1_t = tcg_temp_new();
 
-    tcg_temp_free(t0);
-    tcg_temp_free(va);
-}
+    tcg_gen_movi_i32(t0, v2 >> 3);
 
-static void gen_pool16c_nanomips_insn(DisasContext *ctx)
-{
-    int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD(ctx->opcode));
-    int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
+    gen_load_gpr(v0_t, ret);
+    gen_load_gpr(v1_t, v1);
 
-    switch ((ctx->opcode >> 2) & 0x3) {
-    case NM_NOT16:
-        gen_logic(ctx, OPC_NOR, rt, rs, 0);
+    switch (opc) {
+    case NM_POOL32AXF_2_0_7:
+        switch ((ctx->opcode >> 9) & 0x07) {
+        case NM_DPA_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpa_w_ph(t0, v1_t, v0_t, cpu_env);
+            break;
+        case NM_DPAQ_S_W_PH:
+            check_dsp(ctx);
+            gen_helper_dpaq_s_w_ph(t0, v1_t, v0_t, cpu_env);
+            break;
+        case NM_DPS_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dps_w_ph(t0, v1_t, v0_t, cpu_env);
+            break;
+        case NM_DPSQ_S_W_PH:
+            check_dsp(ctx);
+            gen_helper_dpsq_s_w_ph(t0, v1_t, v0_t, cpu_env);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
         break;
-    case NM_AND16:
-        gen_logic(ctx, OPC_AND, rt, rt, rs);
+    case NM_POOL32AXF_2_8_15:
+        switch ((ctx->opcode >> 9) & 0x07) {
+        case NM_DPAX_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpax_w_ph(t0, v0_t, v1_t, cpu_env);
+            break;
+        case NM_DPAQ_SA_L_W:
+            check_dsp(ctx);
+            gen_helper_dpaq_sa_l_w(t0, v0_t, v1_t, cpu_env);
+            break;
+        case NM_DPSX_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpsx_w_ph(t0, v0_t, v1_t, cpu_env);
+            break;
+        case NM_DPSQ_SA_L_W:
+            check_dsp(ctx);
+            gen_helper_dpsq_sa_l_w(t0, v0_t, v1_t, cpu_env);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
         break;
-    case NM_XOR16:
-        gen_logic(ctx, OPC_XOR, rt, rt, rs);
+    case NM_POOL32AXF_2_16_23:
+        switch ((ctx->opcode >> 9) & 0x07) {
+        case NM_DPAU_H_QBL:
+            check_dsp(ctx);
+            gen_helper_dpau_h_qbl(t0, v0_t, v1_t, cpu_env);
+            break;
+        case NM_DPAQX_S_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpaqx_s_w_ph(t0, v0_t, v1_t, cpu_env);
+            break;
+        case NM_DPSU_H_QBL:
+            check_dsp(ctx);
+            gen_helper_dpsu_h_qbl(t0, v0_t, v1_t, cpu_env);
+            break;
+        case NM_DPSQX_S_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpsqx_s_w_ph(t0, v0_t, v1_t, cpu_env);
+            break;
+        case NM_MULSA_W_PH:
+            check_dspr2(ctx);
+            gen_helper_mulsa_w_ph(t0, v0_t, v1_t, cpu_env);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
         break;
-    case NM_OR16:
-        gen_logic(ctx, OPC_OR, rt, rt, rs);
+    case NM_POOL32AXF_2_24_31:
+        switch ((ctx->opcode >> 9) & 0x07) {
+        case NM_DPAU_H_QBR:
+            check_dsp(ctx);
+            gen_helper_dpau_h_qbr(t0, v1_t, v0_t, cpu_env);
+            break;
+        case NM_DPAQX_SA_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpaqx_sa_w_ph(t0, v1_t, v0_t, cpu_env);
+            break;
+        case NM_DPSU_H_QBR:
+            check_dsp(ctx);
+            gen_helper_dpsu_h_qbr(t0, v1_t, v0_t, cpu_env);
+            break;
+        case NM_DPSQX_SA_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpsqx_sa_w_ph(t0, v1_t, v0_t, cpu_env);
+            break;
+        case NM_MULSAQ_S_W_PH:
+            check_dsp(ctx);
+            gen_helper_mulsaq_s_w_ph(t0, v1_t, v0_t, cpu_env);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
         break;
     }
+
+    tcg_temp_free_i32(t0);
+
+    tcg_temp_free(v0_t);
+    tcg_temp_free(v1_t);
 }
 
-static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
+static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                          int ret, int v1, int v2)
 {
-    int rt = (ctx->opcode >> 21) & 0x1f;
-    int rs = (ctx->opcode >> 16) & 0x1f;
-    int rd = (ctx->opcode >> 11) & 0x1f;
+    TCGv t0;
+    TCGv t1;
 
-    switch ((ctx->opcode >> 3) & 0x7f) {
-    case NM_P_TRAP:
-        switch ((ctx->opcode >> 10) & 0x1) {
-        case NM_TEQ:
-            gen_trap(ctx, OPC_TEQ, rs, rt, -1);
+    TCGv v0_t;
+    TCGv v1_t;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    v0_t = tcg_temp_new();
+    v1_t = tcg_temp_new();
+
+    gen_load_gpr(v0_t, ret);
+    gen_load_gpr(v1_t, v1);
+
+    switch (opc) {
+    case NM_POOL32AXF_2_0_7:
+        switch ((ctx->opcode >> 9) & 0x07) {
+        case NM_DPA_W_PH:
+        case NM_DPAQ_S_W_PH:
+        case NM_DPS_W_PH:
+        case NM_DPSQ_S_W_PH:
+            gen_pool32axf_2_multiply(ctx, opc, ret, v1, v2);
+            break;
+        case NM_BALIGN:
+            gen_load_gpr(t0, v1);
+            v2 &= 3;
+            if (v2 != 0 && v2 != 2) {
+                tcg_gen_shli_tl(cpu_gpr[ret], cpu_gpr[ret], 8 * v2);
+                tcg_gen_ext32u_tl(t0, t0);
+                tcg_gen_shri_tl(t0, t0, 8 * (4 - v2));
+                tcg_gen_or_tl(cpu_gpr[ret], cpu_gpr[ret], t0);
+            }
+            tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
             break;
-        case NM_TNE:
-            gen_trap(ctx, OPC_TNE, rs, rt, -1);
+        case NM_MADD:
+            {
+                int acc = (ctx->opcode >> 14) & 3;
+
+                gen_load_gpr(t0, ret);
+                gen_load_gpr(t1, v1);
+                TCGv_i64 t2 = tcg_temp_new_i64();
+                TCGv_i64 t3 = tcg_temp_new_i64();
+
+                tcg_gen_ext_tl_i64(t2, t0);
+                tcg_gen_ext_tl_i64(t3, t1);
+                tcg_gen_mul_i64(t2, t2, t3);
+                tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
+                tcg_gen_add_i64(t2, t2, t3);
+                tcg_temp_free_i64(t3);
+                gen_move_low32(cpu_LO[acc], t2);
+                gen_move_high32(cpu_HI[acc], t2);
+                tcg_temp_free_i64(t2);
+            }
+            break;
+        case NM_MULT:
+            {
+                int acc = (ctx->opcode >> 14) & 3;
+
+                gen_load_gpr(t0, v1);
+                gen_load_gpr(t1, ret);
+
+                TCGv_i32 t2 = tcg_temp_new_i32();
+                TCGv_i32 t3 = tcg_temp_new_i32();
+                tcg_gen_trunc_tl_i32(t2, t0);
+                tcg_gen_trunc_tl_i32(t3, t1);
+                tcg_gen_muls2_i32(t2, t3, t2, t3);
+                tcg_gen_ext_i32_tl(cpu_LO[acc], t2);
+                tcg_gen_ext_i32_tl(cpu_HI[acc], t3);
+                tcg_temp_free_i32(t2);
+                tcg_temp_free_i32(t3);
+            }
+            break;
+        case NM_EXTRV_W:
+            gen_load_gpr(v1_t, v1);
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            gen_helper_extr_w(cpu_gpr[ret], t0, v1_t, cpu_env);
             break;
         }
         break;
-    case NM_RDHWR:
-        gen_rdhwr(ctx, rt, rs, extract32(ctx->opcode, 11, 3));
-        break;
-    case NM_SEB:
-        gen_bshfl(ctx, OPC_SEB, rs, rt);
-        break;
-    case NM_SEH:
-        gen_bshfl(ctx, OPC_SEH, rs, rt);
-        break;
-    case NM_SLLV:
-        gen_shift(ctx, OPC_SLLV, rd, rt, rs);
-        break;
-    case NM_SRLV:
-        gen_shift(ctx, OPC_SRLV, rd, rt, rs);
-        break;
-    case NM_SRAV:
-        gen_shift(ctx, OPC_SRAV, rd, rt, rs);
-        break;
-    case NM_ROTRV:
-        gen_shift(ctx, OPC_ROTRV, rd, rt, rs);
-        break;
-    case NM_ADD:
-        gen_arith(ctx, OPC_ADD, rd, rs, rt);
-        break;
-    case NM_ADDU:
-        gen_arith(ctx, OPC_ADDU, rd, rs, rt);
-        break;
-    case NM_SUB:
-        gen_arith(ctx, OPC_SUB, rd, rs, rt);
-        break;
-    case NM_SUBU:
-        gen_arith(ctx, OPC_SUBU, rd, rs, rt);
-        break;
-    case NM_P_CMOVE:
-        switch ((ctx->opcode >> 10) & 1) {
-        case NM_MOVZ:
-            gen_cond_move(ctx, OPC_MOVZ, rd, rs, rt);
+    case NM_POOL32AXF_2_8_15:
+        switch ((ctx->opcode >> 9) & 0x07) {
+        case NM_DPAX_W_PH:
+        case NM_DPAQ_SA_L_W:
+        case NM_DPSX_W_PH:
+        case NM_DPSQ_SA_L_W:
+            gen_pool32axf_2_multiply(ctx, opc, ret, v1, v2);
             break;
-        case NM_MOVN:
-            gen_cond_move(ctx, OPC_MOVN, rd, rs, rt);
+        case NM_MADDU:
+            {
+                int acc = (ctx->opcode >> 14) & 3;
+
+                TCGv_i64 t2 = tcg_temp_new_i64();
+                TCGv_i64 t3 = tcg_temp_new_i64();
+
+                gen_load_gpr(t0, v1);
+                gen_load_gpr(t1, ret);
+
+                tcg_gen_ext32u_tl(t0, t0);
+                tcg_gen_ext32u_tl(t1, t1);
+                tcg_gen_extu_tl_i64(t2, t0);
+                tcg_gen_extu_tl_i64(t3, t1);
+                tcg_gen_mul_i64(t2, t2, t3);
+                tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
+                tcg_gen_add_i64(t2, t2, t3);
+                tcg_temp_free_i64(t3);
+                gen_move_low32(cpu_LO[acc], t2);
+                gen_move_high32(cpu_HI[acc], t2);
+                tcg_temp_free_i64(t2);
+            }
+            break;
+        case NM_MULTU:
+            {
+                int acc = (ctx->opcode >> 14) & 3;
+
+                TCGv_i32 t2 = tcg_temp_new_i32();
+                TCGv_i32 t3 = tcg_temp_new_i32();
+
+                gen_load_gpr(t0, v1);
+                gen_load_gpr(t1, ret);
+
+                tcg_gen_trunc_tl_i32(t2, t0);
+                tcg_gen_trunc_tl_i32(t3, t1);
+                tcg_gen_mulu2_i32(t2, t3, t2, t3);
+                tcg_gen_ext_i32_tl(cpu_LO[acc], t2);
+                tcg_gen_ext_i32_tl(cpu_HI[acc], t3);
+                tcg_temp_free_i32(t2);
+                tcg_temp_free_i32(t3);
+            }
+            break;
+        case NM_EXTRV_R_W:
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            gen_helper_extr_r_w(cpu_gpr[ret], t0, v1_t, cpu_env);
             break;
         }
         break;
-    case NM_AND:
-        gen_logic(ctx, OPC_AND, rd, rs, rt);
-        break;
-    case NM_OR:
-        gen_logic(ctx, OPC_OR, rd, rs, rt);
-        break;
-    case NM_NOR:
-        gen_logic(ctx, OPC_NOR, rd, rs, rt);
-        break;
-    case NM_XOR:
-        gen_logic(ctx, OPC_XOR, rd, rs, rt);
-        break;
-    case NM_SLT:
-        gen_slt(ctx, OPC_SLT, rd, rs, rt);
-        break;
-    case NM_P_SLTU:
-        if (rd == 0) {
-            /* P_DVP */
-#ifndef CONFIG_USER_ONLY
-            TCGv t0 = tcg_temp_new();
-            switch ((ctx->opcode >> 10) & 1) {
-            case NM_DVP:
-                if (ctx->vp) {
-                    check_cp0_enabled(ctx);
-                    gen_helper_dvp(t0, cpu_env);
-                    gen_store_gpr(t0, rt);
-                }
-                break;
-            case NM_EVP:
-                if (ctx->vp) {
-                    check_cp0_enabled(ctx);
-                    gen_helper_evp(t0, cpu_env);
-                    gen_store_gpr(t0, rt);
-                }
-                break;
+    case NM_POOL32AXF_2_16_23:
+        switch ((ctx->opcode >> 9) & 0x07) {
+        case NM_DPAU_H_QBL:
+        case NM_DPAQX_S_W_PH:
+        case NM_DPSU_H_QBL:
+        case NM_DPSQX_S_W_PH:
+        case NM_MULSA_W_PH:
+            gen_pool32axf_2_multiply(ctx, opc, ret, v1, v2);
+            break;
+        case NM_EXTPV:
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            gen_helper_extp(cpu_gpr[ret], t0, v1_t, cpu_env);
+            break;
+        case NM_MSUB:
+            {
+                int acc = (ctx->opcode >> 14) & 3;
+
+                TCGv_i64 t2 = tcg_temp_new_i64();
+                TCGv_i64 t3 = tcg_temp_new_i64();
+
+                gen_load_gpr(t0, v1);
+                gen_load_gpr(t1, ret);
+
+                tcg_gen_ext_tl_i64(t2, t0);
+                tcg_gen_ext_tl_i64(t3, t1);
+                tcg_gen_mul_i64(t2, t2, t3);
+                tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
+                tcg_gen_sub_i64(t2, t3, t2);
+                tcg_temp_free_i64(t3);
+                gen_move_low32(cpu_LO[acc], t2);
+                gen_move_high32(cpu_HI[acc], t2);
+                tcg_temp_free_i64(t2);
+            }
+            break;
+        case NM_EXTRV_RS_W:
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            gen_helper_extr_rs_w(cpu_gpr[ret], t0, v1_t, cpu_env);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_2_24_31:
+        switch ((ctx->opcode >> 9) & 0x07) {
+        case NM_DPAU_H_QBR:
+        case NM_DPAQX_SA_W_PH:
+        case NM_DPSU_H_QBR:
+        case NM_DPSQX_SA_W_PH:
+        case NM_MULSAQ_S_W_PH:
+            gen_pool32axf_2_multiply(ctx, opc, ret, v1, v2);
+            break;
+        case NM_EXTPDPV:
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            gen_helper_extpdp(cpu_gpr[ret], t0, v1_t, cpu_env);
+            break;
+        case NM_MSUBU:
+            {
+                int acc = (ctx->opcode >> 14) & 3;
+
+                TCGv_i64 t2 = tcg_temp_new_i64();
+                TCGv_i64 t3 = tcg_temp_new_i64();
+
+                gen_load_gpr(t0, v1);
+                gen_load_gpr(t1, ret);
+
+                tcg_gen_ext32u_tl(t0, t0);
+                tcg_gen_ext32u_tl(t1, t1);
+                tcg_gen_extu_tl_i64(t2, t0);
+                tcg_gen_extu_tl_i64(t3, t1);
+                tcg_gen_mul_i64(t2, t2, t3);
+                tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
+                tcg_gen_sub_i64(t2, t3, t2);
+                tcg_temp_free_i64(t3);
+                gen_move_low32(cpu_LO[acc], t2);
+                gen_move_high32(cpu_HI[acc], t2);
+                tcg_temp_free_i64(t2);
             }
-            tcg_temp_free(t0);
-#endif
-        } else {
-            gen_slt(ctx, OPC_SLTU, rd, rs, rt);
+            break;
+        case NM_EXTRV_S_H:
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            gen_helper_extr_s_h(cpu_gpr[ret], t0, v1_t, cpu_env);
+            break;
         }
         break;
-    case NM_SOV:
-    {
-        TCGv t0 = tcg_temp_local_new();
-        TCGv t1 = tcg_temp_new();
-        TCGv t2 = tcg_temp_new();
-        TCGLabel *l1 = gen_new_label();
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
 
-        gen_load_gpr(t1, rs);
-        gen_load_gpr(t2, rt);
-        tcg_gen_add_tl(t0, t1, t2);
-        tcg_gen_ext32s_tl(t0, t0);
-        tcg_gen_xor_tl(t1, t1, t2);
-        tcg_gen_xor_tl(t2, t0, t2);
-        tcg_gen_andc_tl(t1, t2, t1);
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
 
-        tcg_gen_movi_tl(t0, 0);
-        tcg_gen_brcondi_tl(TCG_COND_GE, t1, 0, l1);
-        /* operands of same sign, result different sign */
+    tcg_temp_free(v0_t);
+    tcg_temp_free(v1_t);
+}
 
-        tcg_gen_movi_tl(t0, 1);
-        gen_set_label(l1);
-        gen_store_gpr(t0, rd);
+static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                          int ret, int v1, int v2)
+{
+    TCGv t0;
+    TCGv v0_t;
+    TCGv v1_t;
 
-        tcg_temp_free(t0);
-        tcg_temp_free(t1);
-        tcg_temp_free(t2);
-    }
+    t0 = tcg_temp_new();
+
+    v0_t = tcg_temp_new();
+    v1_t = tcg_temp_new();
+
+    gen_load_gpr(v0_t, ret);
+    gen_load_gpr(v1_t, v1);
+
+    switch (opc) {
+    case NM_ABSQ_S_QB:
+        check_dspr2(ctx);
+        gen_helper_absq_s_qb(cpu_gpr[ret], v0_t, cpu_env);
         break;
-    case NM_MUL:
-        gen_r6_muldiv(ctx, R6_OPC_MUL, rd, rs, rt);
+    case NM_ABSQ_S_PH:
+        check_dsp(ctx);
+        gen_helper_absq_s_ph(cpu_gpr[ret], v1_t, cpu_env);
         break;
-    case NM_MUH:
-        gen_r6_muldiv(ctx, R6_OPC_MUH, rd, rs, rt);
+    case NM_ABSQ_S_W:
+        check_dsp(ctx);
+        gen_helper_absq_s_w(cpu_gpr[ret], v1_t, cpu_env);
         break;
-    case NM_MULU:
-        gen_r6_muldiv(ctx, R6_OPC_MULU, rd, rs, rt);
+    case NM_PRECEQ_W_PHL:
+        check_dsp(ctx);
+        tcg_gen_andi_tl(cpu_gpr[ret], v1_t, 0xFFFF0000);
+        tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
         break;
-    case NM_MUHU:
-        gen_r6_muldiv(ctx, R6_OPC_MUHU, rd, rs, rt);
+    case NM_PRECEQ_W_PHR:
+        check_dsp(ctx);
+        tcg_gen_andi_tl(cpu_gpr[ret], v1_t, 0x0000FFFF);
+        tcg_gen_shli_tl(cpu_gpr[ret], cpu_gpr[ret], 16);
+        tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
         break;
-    case NM_DIV:
-        gen_r6_muldiv(ctx, R6_OPC_DIV, rd, rs, rt);
+    case NM_PRECEQU_PH_QBL:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbl(cpu_gpr[ret], v1_t);
         break;
-    case NM_MOD:
-        gen_r6_muldiv(ctx, R6_OPC_MOD, rd, rs, rt);
+    case NM_PRECEQU_PH_QBR:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbr(cpu_gpr[ret], v1_t);
         break;
-    case NM_DIVU:
-        gen_r6_muldiv(ctx, R6_OPC_DIVU, rd, rs, rt);
+    case NM_PRECEQU_PH_QBLA:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbla(cpu_gpr[ret], v1_t);
         break;
-    case NM_MODU:
-        gen_r6_muldiv(ctx, R6_OPC_MODU, rd, rs, rt);
+    case NM_PRECEQU_PH_QBRA:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbra(cpu_gpr[ret], v1_t);
         break;
-#ifndef CONFIG_USER_ONLY
-    case NM_MFC0:
-        check_cp0_enabled(ctx);
-        if (rt == 0) {
-            /* Treat as NOP. */
-            break;
-        }
-        gen_mfc0(ctx, cpu_gpr[rt], rs, (ctx->opcode >> 11) & 0x7);
+    case NM_PRECEU_PH_QBL:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbl(cpu_gpr[ret], v1_t);
         break;
-    case NM_MTC0:
-        check_cp0_enabled(ctx);
+    case NM_PRECEU_PH_QBR:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbr(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEU_PH_QBLA:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbla(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEU_PH_QBRA:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbra(cpu_gpr[ret], v1_t);
+        break;
+    case NM_REPLV_PH:
+        check_dsp(ctx);
+        tcg_gen_ext16u_tl(cpu_gpr[ret], v1_t);
+        tcg_gen_shli_tl(t0, cpu_gpr[ret], 16);
+        tcg_gen_or_tl(cpu_gpr[ret], cpu_gpr[ret], t0);
+        tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
+        break;
+    case NM_REPLV_QB:
+        check_dsp(ctx);
         {
-            TCGv t0 = tcg_temp_new();
+            TCGv val_t;
 
-            gen_load_gpr(t0, rt);
-            gen_mtc0(ctx, t0, rs, (ctx->opcode >> 11) & 0x7);
-            tcg_temp_free(t0);
+            val_t = tcg_temp_new();
+            gen_load_gpr(val_t, v1);
+
+            tcg_gen_ext8u_tl(cpu_gpr[ret], val_t);
+            tcg_gen_shli_tl(t0, cpu_gpr[ret], 8);
+            tcg_gen_or_tl(cpu_gpr[ret], cpu_gpr[ret], t0);
+            tcg_gen_shli_tl(t0, cpu_gpr[ret], 16);
+            tcg_gen_or_tl(cpu_gpr[ret], cpu_gpr[ret], t0);
+            tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
         }
         break;
-    case NM_D_E_MT_VPE:
+    case NM_BITREV:
+        check_dsp(ctx);
+        gen_helper_bitrev(cpu_gpr[ret], v1_t);
+        break;
+    case NM_INSV:
+        check_dsp(ctx);
         {
-            uint8_t sc = (ctx->opcode >> 10) & 1;
-            TCGv t0 = tcg_temp_new();
+            TCGv t0, t1;
 
-            switch (sc) {
-            case 0:
-                if (rs == 1) {
-                    /* DMT */
-                    check_insn(ctx, ASE_MT);
-                    gen_helper_dmt(t0);
-                    gen_store_gpr(t0, rt);
-                } else if (rs == 0) {
-                    /* DVPE */
-                    check_insn(ctx, ASE_MT);
-                    gen_helper_dvpe(t0, cpu_env);
-                    gen_store_gpr(t0, rt);
-                } else {
-                    generate_exception_end(ctx, EXCP_RI);
-                }
-                break;
-            case 1:
-                if (rs == 1) {
-                    /* EMT */
-                    check_insn(ctx, ASE_MT);
-                    gen_helper_emt(t0);
-                    gen_store_gpr(t0, rt);
-                } else if (rs == 0) {
-                    /* EVPE */
-                    check_insn(ctx, ASE_MT);
-                    gen_helper_evpe(t0, cpu_env);
-                    gen_store_gpr(t0, rt);
-                } else {
-                    generate_exception_end(ctx, EXCP_RI);
-                }
-                break;
-            }
+            t0 = tcg_temp_new();
+            t1 = tcg_temp_new();
 
-            tcg_temp_free(t0);
-        }
-    break;
-    case NM_FORK:
-        check_insn(ctx, ASE_MT);
-        {
-            TCGv t0 = tcg_temp_new();
-            TCGv t1 = tcg_temp_new();
+            gen_load_gpr(t0, ret);
+            gen_load_gpr(t1, v1);
+
+            gen_helper_insv(cpu_gpr[ret], cpu_env, t1, t0);
 
-            gen_load_gpr(t0, rt);
-            gen_load_gpr(t1, rs);
-            gen_helper_fork(t0, t1);
             tcg_temp_free(t0);
             tcg_temp_free(t1);
         }
         break;
-    case NM_MFTR:
-    case NM_MFHTR:
-        check_insn(ctx, ASE_MT);
-        if (rd == 0) {
-            /* Treat as NOP. */
-            return;
-        }
-        gen_mftr(env, ctx, rs, rt, (ctx->opcode >> 10) & 1,
-                 (ctx->opcode >> 11) & 0x1f, (ctx->opcode >> 3) & 1);
+    case NM_RADDU_W_QB:
+        check_dsp(ctx);
+        gen_helper_raddu_w_qb(cpu_gpr[ret], v1_t);
         break;
-    case NM_MTTR:
-    case NM_MTHTR:
-        check_insn(ctx, ASE_MT);
-        gen_mttr(env, ctx, rs, rt, (ctx->opcode >> 10) & 1,
-                 (ctx->opcode >> 11) & 0x1f, (ctx->opcode >> 3) & 1);
+    case NM_BITSWAP:
+        gen_bitswap(ctx, OPC_BITSWAP, ret, v1);
         break;
-    case NM_YIELD:
-        check_insn(ctx, ASE_MT);
-        {
-            TCGv t0 = tcg_temp_new();
+    case NM_CLO:
+        gen_cl(ctx, OPC_CLO, ret, v1);
+        break;
+    case NM_CLZ:
+        gen_cl(ctx, OPC_CLZ, ret, v1);
+        break;
+    case NM_WSBH:
+        gen_bshfl(ctx, OPC_WSBH, ret, v1);
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
 
-            gen_load_gpr(t0, rs);
-            gen_helper_yield(t0, cpu_env, t0);
-            gen_store_gpr(t0, rt);
-            tcg_temp_free(t0);
+    tcg_temp_free(t0);
+
+    tcg_temp_free(v0_t);
+    tcg_temp_free(v1_t);
+}
+
+static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                          int ret, int v1, int v2)
+{
+    int16_t imm;
+
+    TCGv t0;
+    TCGv v1_t;
+
+    t0 = tcg_temp_new();
+    v1_t = tcg_temp_new();
+
+    gen_load_gpr(v1_t, v1);
+
+    switch (opc) {
+    case NM_SHRA_R_QB:
+        tcg_gen_movi_tl(t0, v2 >> 2);
+        switch ((ctx->opcode >> 12) & 0x01) {
+        case 0:
+            /* NM_SHRA_QB */
+            check_dspr2(ctx);
+            gen_helper_shra_qb(cpu_gpr[ret], t0, v1_t);
+            break;
+        case 1:
+            /* NM_SHRA_R_QB */
+            check_dspr2(ctx);
+            gen_helper_shra_r_qb(cpu_gpr[ret], t0, v1_t);
+            break;
+        }
+    break;
+    case NM_SHRL_PH:
+        check_dspr2(ctx);
+        tcg_gen_movi_tl(t0, v2 >> 1);
+        gen_helper_shrl_ph(cpu_gpr[ret], t0, v1_t);
+        break;
+    case NM_REPL_QB:
+        {
+            check_dsp(ctx);
+            target_long result;
+            imm = (ctx->opcode >> 13) & 0xFF;
+            result = (uint32_t)imm << 24 |
+                     (uint32_t)imm << 16 |
+                    (uint32_t)imm << 8  |
+                     (uint32_t)imm;
+            result = (int32_t)result;
+            tcg_gen_movi_tl(cpu_gpr[ret], result);
         }
         break;
-#endif
     default:
         generate_exception_end(ctx, EXCP_RI);
         break;
-    }
+   }
+    tcg_temp_free(t0);
+    tcg_temp_free(v1_t);
 }
 
+
 static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 {
     int rt = (ctx->opcode >> 21) & 0x1f;
     int rs = (ctx->opcode >> 16) & 0x1f;
+    int rd = (ctx->opcode >> 11) & 0x1f;
 
     switch ((ctx->opcode >> 6) & 0x07) {
+    case NM_POOL32AXF_1:
+        {
+            int32_t op1 = (ctx->opcode >> 9) & 0x07;
+            gen_pool32axf_1_nanomips_insn(ctx, op1, rt, rs, rd);
+        }
+        break;
+    case NM_POOL32AXF_2:
+        {
+            int32_t op1 = (ctx->opcode >> 12) & 0x03;
+            gen_pool32axf_2_nanomips_insn(ctx, op1, rt, rs, rd);
+        }
+        break;
     case NM_POOL32AXF_4:
+        {
+            int32_t op1 = (ctx->opcode >> 9) & 0x7f;
+            gen_pool32axf_4_nanomips_insn(ctx, op1, rt, rs, rd);
+        }
+        break;
     case NM_POOL32AXF_5:
         switch ((ctx->opcode >> 9) & 0x7f) {
         case NM_CLO:
@@ -16946,6 +18212,12 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
+    case NM_POOL32AXF_7:
+        {
+            int32_t op1 = (ctx->opcode >> 9) & 0x7;
+            gen_pool32axf_7_nanomips_insn(ctx, op1, rt, rs, rd);
+        }
+        break;
     default:
         generate_exception_end(ctx, EXCP_RI);
         break;
@@ -17609,6 +18881,12 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         case NM_POOL32A0:
             gen_pool32a0_nanomips_insn(env, ctx);
             break;
+        case NM_POOL32A5:
+            {
+                int32_t op1 = (ctx->opcode >> 3) & 0x7F;
+                gen_pool32a5_nanomips_insn(ctx, op1, rd, rs, rt);
+            }
+            break;
         case NM_POOL32A7:
         {
             switch ((ctx->opcode >> 3) & 0x07) {
@@ -18249,6 +19527,18 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             case NM_BC1NEZC:
                 gen_compute_branch1_r6(ctx, OPC_BC1NEZ, rt, s, 0);
                 break;
+            case NM_BPOSGE32C:
+                check_dsp(ctx);
+                {
+                    int32_t imm = ctx->opcode;
+                    imm >>= 1;
+                    imm &= 0x1fff;
+                    imm |= (ctx->opcode & 1) << 13;
+
+                    gen_compute_branch(ctx, OPC_BPOSGE32, 4, -1, -2,
+                                       (int32_t)imm, 4);
+                }
+                break;
             default:
                 generate_exception_end(ctx, EXCP_RI);
                 break;
-- 
2.7.4
