Received: from eggs.gnu.org ([2001:4830:134:3::10]:36970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAxA-00089m-3i
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAx7-0000g5-9U
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:23:24 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34266 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkAx6-0000eZ-PM
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:23:21 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:12:11 +0200
Message-Id: <1532967169-22265-39-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 38/76] target/mips: Add emulation of DSP ASE
 for nanoMIPS - part 1
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

Add emulation of DSP ASE instructions for nanoMIPS - part 1.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 516 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 516 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 51d63a0..2448a39 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17526,6 +17526,516 @@ static void gen_pool32f_nanomips_insn(DisasContext *ctx)
     }
 }
 
+static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
+                                       int rd, int rs, int rt)
+{
+    int ret = rd;
+
+    TCGv t0;
+    TCGv t1;
+    TCGv v1_t;
+    TCGv v2_t;
+
+    t0 = tcg_temp_new();
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        {
+            gen_load_gpr(t0, rs);
+
+            if (rd != 0) {
+                tcg_gen_deposit_tl(cpu_gpr[rt], t0, cpu_gpr[rt], rd, 32 - rd);
+            }
+            tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
+        }
+        break;
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
+        {
+            TCGv tv0;
+            TCGv tv1;
+            tv0 = tcg_temp_new();
+            tv1 = tcg_temp_new();
+
+            int16_t imm = extract32(ctx->opcode, 16, 7);
+
+            tcg_gen_movi_tl(tv0, rd >> 3);
+            tcg_gen_movi_tl(tv1, imm);
+
+            gen_helper_shilo(tv0, tv1, cpu_env);
+        }
+        break;
+    case OPC_MULEQ_S_W_PHL:
+        check_dsp(ctx);
+        gen_helper_muleq_s_w_phl(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_MULEQ_S_W_PHR:
+        check_dsp(ctx);
+        gen_helper_muleq_s_w_phr(cpu_gpr[ret], v1_t, v2_t, cpu_env);
+        break;
+    case OPC_MUL_S_PH:
+        switch (extract32(ctx->opcode, 10, 1)) {
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
+        {
+            tcg_gen_movi_tl(t0, rd);
+
+            check_dsp(ctx);
+            gen_helper_shra_r_w(cpu_gpr[rt], t0, v1_t);
+        }
+        break;
+    case OPC_SHRA_R_PH:
+        {
+            tcg_gen_movi_tl(t0, rd >> 1);
+
+            switch (extract32(ctx->opcode, 10, 1)) {
+            case 0:
+                /* SHRA_PH */
+                check_dsp(ctx);
+                gen_helper_shra_ph(cpu_gpr[rt], t0, v1_t);
+                break;
+            case 1:
+                /* SHRA_R_PH */
+                check_dsp(ctx);
+                gen_helper_shra_r_ph(cpu_gpr[rt], t0, v1_t);
+                break;
+            }
+        }
+        break;
+    case OPC_SHLL_S_PH:
+        {
+            tcg_gen_movi_tl(t0, rd >> 1);
+
+            switch (extract32(ctx->opcode, 10, 2)) {
+            case 0:
+                /* SHLL_PH */
+                check_dsp(ctx);
+                gen_helper_shll_ph(cpu_gpr[rt], t0, v1_t, cpu_env);
+                break;
+            case 2:
+                /* SHLL_S_PH */
+                check_dsp(ctx);
+                gen_helper_shll_s_ph(cpu_gpr[rt], t0, v1_t, cpu_env);
+                break;
+            }
+        }
+        break;
+    case OPC_SHLL_S_W:
+        {
+            tcg_gen_movi_tl(t0, rd);
+
+            check_dsp(ctx);
+            gen_helper_shll_s_w(cpu_gpr[rt], t0, v1_t, cpu_env);
+            break;
+        }
+        break;
+    case OPC_REPL_PH:
+        check_dsp(ctx);
+        {
+            int16_t imm;
+            imm = extract32(ctx->opcode, 11, 11);
+            imm = (int16_t)(imm << 6) >> 6;
+            tcg_gen_movi_tl(cpu_gpr[rt], \
+                            (target_long)((int32_t)imm << 16 | \
+                            (uint16_t)imm));
+        }
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     uint16_t insn;
@@ -17595,6 +18105,12 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
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
             switch (extract32(ctx->opcode, 3, 3)) {
             case NM_P_LSX:
-- 
2.7.4
