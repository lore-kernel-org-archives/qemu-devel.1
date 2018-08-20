Received: from eggs.gnu.org ([2001:4830:134:3::10]:44784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1froxq-0000mL-Mj
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1frol4-0001lz-ER
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:34 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51302 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1frol1-0001e7-3U
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:28 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 20 Aug 2018 20:16:37 +0200
Message-Id: <1534789014-8310-30-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v11 29/46] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, dnikolic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of DSP ASE instructions for nanoMIPS - part 1.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 554 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 554 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2ef6dfa..877821c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -18058,6 +18058,554 @@ static void gen_pool32f_nanomips_insn(DisasContext *ctx)
     }
 }
 
+static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
+                                       int rd, int rs, int rt)
+{
+    int ret = rd;
+    TCGv t0 = tcg_temp_new();
+    TCGv v1_t = tcg_temp_new();
+    TCGv v2_t = tcg_temp_new();
+
+    gen_load_gpr(v1_t, rs);
+    gen_load_gpr(v2_t, rt);
+
+    switch (opc) {
+    case NM_CMP_EQ_PH:
+        check_dsp(ctx);
+        gen_helper_cmp_eq_ph(v1_t, v2_t, cpu_env);
+        break;
+    case NM_CMP_LT_PH:
+        check_dsp(ctx);
+        gen_helper_cmp_lt_ph(v1_t, v2_t, cpu_env);
+        break;
+    case NM_CMP_LE_PH:
+        check_dsp(ctx);
+        gen_helper_cmp_le_ph(v1_t, v2_t, cpu_env);
+        break;
+    case NM_CMPU_EQ_QB:
+        check_dsp(ctx);
+        gen_helper_cmpu_eq_qb(v1_t, v2_t, cpu_env);
+        break;
+    case NM_CMPU_LT_QB:
+        check_dsp(ctx);
+        gen_helper_cmpu_lt_qb(v1_t, v2_t, cpu_env);
+        break;
+    case NM_CMPU_LE_QB:
+        check_dsp(ctx);
+        gen_helper_cmpu_le_qb(v1_t, v2_t, cpu_env);
+        break;
+    case NM_CMPGU_EQ_QB:
+        check_dsp(ctx);
+        gen_helper_cmpgu_eq_qb(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_CMPGU_LT_QB:
+        check_dsp(ctx);
+        gen_helper_cmpgu_lt_qb(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_CMPGU_LE_QB:
+        check_dsp(ctx);
+        gen_helper_cmpgu_le_qb(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_CMPGDU_EQ_QB:
+        check_dspr2(ctx);
+        gen_helper_cmpgu_eq_qb(v1_t, v1_t, v2_t);
+        tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_CMPGDU_LT_QB:
+        check_dspr2(ctx);
+        gen_helper_cmpgu_lt_qb(v1_t, v1_t, v2_t);
+        tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_CMPGDU_LE_QB:
+        check_dspr2(ctx);
+        gen_helper_cmpgu_le_qb(v1_t, v1_t, v2_t);
+        tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PACKRL_PH:
+        check_dsp(ctx);
+        gen_helper_packrl_ph(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PICK_QB:
+        check_dsp(ctx);
+        gen_helper_pick_qb(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PICK_PH:
+        check_dsp(ctx);
+        gen_helper_pick_ph(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_ADDQ_S_W:
+        check_dsp(ctx);
+        gen_helper_addq_s_w(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SUBQ_S_W:
+        check_dsp(ctx);
+        gen_helper_subq_s_w(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_ADDSC:
+        check_dsp(ctx);
+        gen_helper_addsc(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_ADDWC:
+        check_dsp(ctx);
+        gen_helper_addwc(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_ADDQ_S_PH:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* ADDQ_PH */
+            gen_helper_addq_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* ADDQ_S_PH */
+            gen_helper_addq_s_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_ADDQH_R_PH:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* ADDQH_PH */
+            gen_helper_addqh_ph(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* ADDQH_R_PH */
+            gen_helper_addqh_r_ph(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_ADDQH_R_W:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* ADDQH_W */
+            gen_helper_addqh_w(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* ADDQH_R_W */
+            gen_helper_addqh_r_w(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_ADDU_S_QB:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* ADDU_QB */
+            gen_helper_addu_qb(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* ADDU_S_QB */
+            gen_helper_addu_s_qb(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_ADDU_S_PH:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* ADDU_PH */
+            gen_helper_addu_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* ADDU_S_PH */
+            gen_helper_addu_s_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_ADDUH_R_QB:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* ADDUH_QB */
+            gen_helper_adduh_qb(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* ADDUH_R_QB */
+            gen_helper_adduh_r_qb(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_SHRAV_R_PH:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SHRAV_PH */
+            gen_helper_shra_ph(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SHRAV_R_PH */
+            gen_helper_shra_r_ph(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_SHRAV_R_QB:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SHRAV_QB */
+            gen_helper_shra_qb(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SHRAV_R_QB */
+            gen_helper_shra_r_qb(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_SUBQ_S_PH:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SUBQ_PH */
+            gen_helper_subq_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SUBQ_S_PH */
+            gen_helper_subq_s_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_SUBQH_R_PH:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SUBQH_PH */
+            gen_helper_subqh_ph(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SUBQH_R_PH */
+            gen_helper_subqh_r_ph(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_SUBQH_R_W:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SUBQH_W */
+            gen_helper_subqh_w(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SUBQH_R_W */
+            gen_helper_subqh_r_w(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_SUBU_S_QB:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SUBU_QB */
+            gen_helper_subu_qb(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SUBU_S_QB */
+            gen_helper_subu_s_qb(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_SUBU_S_PH:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SUBU_PH */
+            gen_helper_subu_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SUBU_S_PH */
+            gen_helper_subu_s_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_SUBUH_R_QB:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SUBUH_QB */
+            gen_helper_subuh_qb(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SUBUH_R_QB */
+            gen_helper_subuh_r_qb(v1_t, v1_t, v2_t);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_SHLLV_S_PH:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SHLLV_PH */
+            gen_helper_shll_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* SHLLV_S_PH */
+            gen_helper_shll_s_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_PRECR_SRA_R_PH_W:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* PRECR_SRA_PH_W */
+            {
+                TCGv_i32 sa_t = tcg_const_i32(rd);
+                gen_helper_precr_sra_ph_w(v1_t, sa_t, v1_t,
+                                          cpu_gpr[rt]);
+                gen_store_gpr(v1_t, rt);
+                tcg_temp_free_i32(sa_t);
+            }
+            break;
+        case 1:
+            /* PRECR_SRA_R_PH_W */
+            {
+                TCGv_i32 sa_t = tcg_const_i32(rd);
+                gen_helper_precr_sra_r_ph_w(v1_t, sa_t, v1_t,
+                                            cpu_gpr[rt]);
+                gen_store_gpr(v1_t, rt);
+                tcg_temp_free_i32(sa_t);
+            }
+            break;
+       }
+        break;
+    case NM_MULEU_S_PH_QBL:
+        check_dsp(ctx);
+        gen_helper_muleu_s_ph_qbl(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MULEU_S_PH_QBR:
+        check_dsp(ctx);
+        gen_helper_muleu_s_ph_qbr(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MULQ_RS_PH:
+        check_dsp(ctx);
+        gen_helper_mulq_rs_ph(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MULQ_S_PH:
+        check_dspr2(ctx);
+        gen_helper_mulq_s_ph(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MULQ_RS_W:
+        check_dspr2(ctx);
+        gen_helper_mulq_rs_w(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MULQ_S_W:
+        check_dspr2(ctx);
+        gen_helper_mulq_s_w(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_APPEND:
+        check_dspr2(ctx);
+        gen_load_gpr(t0, rs);
+        if (rd != 0) {
+            tcg_gen_deposit_tl(cpu_gpr[rt], t0, cpu_gpr[rt], rd, 32 - rd);
+        }
+        tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
+        break;
+    case NM_MODSUB:
+        check_dsp(ctx);
+        gen_helper_modsub(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHRAV_R_W:
+        check_dsp(ctx);
+        gen_helper_shra_r_w(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHRLV_PH:
+        check_dspr2(ctx);
+        gen_helper_shrl_ph(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHRLV_QB:
+        check_dsp(ctx);
+        gen_helper_shrl_qb(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHLLV_QB:
+        check_dsp(ctx);
+        gen_helper_shll_qb(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHLLV_S_W:
+        check_dsp(ctx);
+        gen_helper_shll_s_w(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHILO:
+        check_dsp(ctx);
+        {
+            TCGv tv0 = tcg_temp_new();
+            TCGv tv1 = tcg_temp_new();
+            int16_t imm = extract32(ctx->opcode, 16, 7);
+
+            tcg_gen_movi_tl(tv0, rd >> 3);
+            tcg_gen_movi_tl(tv1, imm);
+            gen_helper_shilo(tv0, tv1, cpu_env);
+        }
+        break;
+    case NM_MULEQ_S_W_PHL:
+        check_dsp(ctx);
+        gen_helper_muleq_s_w_phl(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MULEQ_S_W_PHR:
+        check_dsp(ctx);
+        gen_helper_muleq_s_w_phr(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_MUL_S_PH:
+        check_dspr2(ctx);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* MUL_PH */
+            gen_helper_mul_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        case 1:
+            /* MUL_S_PH */
+            gen_helper_mul_s_ph(v1_t, v1_t, v2_t, cpu_env);
+            gen_store_gpr(v1_t, ret);
+            break;
+        }
+        break;
+    case NM_PRECR_QB_PH:
+        check_dspr2(ctx);
+        gen_helper_precr_qb_ph(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PRECRQ_QB_PH:
+        check_dsp(ctx);
+        gen_helper_precrq_qb_ph(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PRECRQ_PH_W:
+        check_dsp(ctx);
+        gen_helper_precrq_ph_w(v1_t, v1_t, v2_t);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PRECRQ_RS_PH_W:
+        check_dsp(ctx);
+        gen_helper_precrq_rs_ph_w(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_PRECRQU_S_QB_PH:
+        check_dsp(ctx);
+        gen_helper_precrqu_s_qb_ph(v1_t, v1_t, v2_t, cpu_env);
+        gen_store_gpr(v1_t, ret);
+        break;
+    case NM_SHRA_R_W:
+        check_dsp(ctx);
+        tcg_gen_movi_tl(t0, rd);
+        gen_helper_shra_r_w(v1_t, t0, v1_t);
+        gen_store_gpr(v1_t, rt);
+        break;
+    case NM_SHRA_R_PH:
+        check_dsp(ctx);
+        tcg_gen_movi_tl(t0, rd >> 1);
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case 0:
+            /* SHRA_PH */
+            gen_helper_shra_ph(v1_t, t0, v1_t);
+            break;
+            gen_store_gpr(v1_t, rt);
+        case 1:
+            /* SHRA_R_PH */
+            gen_helper_shra_r_ph(v1_t, t0, v1_t);
+            gen_store_gpr(v1_t, rt);
+            break;
+        }
+        break;
+    case NM_SHLL_S_PH:
+        check_dsp(ctx);
+        tcg_gen_movi_tl(t0, rd >> 1);
+        switch (extract32(ctx->opcode, 10, 2)) {
+        case 0:
+            /* SHLL_PH */
+            gen_helper_shll_ph(v1_t, t0, v1_t, cpu_env);
+            gen_store_gpr(v1_t, rt);
+            break;
+        case 2:
+            /* SHLL_S_PH */
+            gen_helper_shll_s_ph(v1_t, t0, v1_t, cpu_env);
+            gen_store_gpr(v1_t, rt);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_SHLL_S_W:
+        check_dsp(ctx);
+        tcg_gen_movi_tl(t0, rd);
+        gen_helper_shll_s_w(v1_t, t0, v1_t, cpu_env);
+        gen_store_gpr(v1_t, rt);
+        break;
+    case NM_REPL_PH:
+        check_dsp(ctx);
+        {
+            int16_t imm;
+            imm = sextract32(ctx->opcode, 11, 11);
+            imm = (int16_t)(imm << 6) >> 6;
+            if (rt != 0) {
+                tcg_gen_movi_tl(cpu_gpr[rt], dup_const(MO_16, imm));
+            }
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
@@ -18129,6 +18677,12 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         case NM_POOL32A0:
             gen_pool32a0_nanomips_insn(env, ctx);
             break;
+        case NM_POOL32A5:
+            {
+                int32_t op1 = extract32(ctx->opcode, 3, 7);
+                gen_pool32a5_nanomips_insn(ctx, op1, rd, rs, rt);
+            }
+            break;
         case NM_POOL32A7:
             switch (extract32(ctx->opcode, 3, 3)) {
             case NM_P_LSX:
-- 
2.7.4
