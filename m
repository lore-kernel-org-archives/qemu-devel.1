Received: from eggs.gnu.org ([2001:4830:134:3::10]:45840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Tz-0003C0-31
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Tx-0001Zz-0c
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:52:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51558 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi1Tw-0001ZN-HB
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:52:20 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:31:35 +0200
Message-Id: <1532453527-22911-24-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 23/55] target/mips: Add emulation of DSP ASE
 for nanoMIPS - part 3
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

Add emulation of DSP ASE instructions for nanoMIPS - part 3.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 751 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 751 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index cbdb613..a8fbbe6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16867,13 +16867,758 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+/* dsp */
+static void gen_pool32axf_1_5_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                            int ret, int v1, int v2)
+{
+    TCGv_i32 t0;
+    TCGv v0_t;
+    TCGv v1_t;
+
+    t0 = tcg_temp_new_i32();
+
+    v0_t = tcg_temp_new();
+    v1_t = tcg_temp_new();
+
+    tcg_gen_movi_i32(t0, v2 >> 3);
+
+    gen_load_gpr(v0_t, ret);
+    gen_load_gpr(v1_t, v1);
+
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
+
+    tcg_temp_free_i32(t0);
+
+    tcg_temp_free(v0_t);
+    tcg_temp_free(v1_t);
+}
+
+
+static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                    int ret, int v1, int v2)
+{
+    int16_t imm;
+
+    TCGv t0;
+    TCGv t1;
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
+    }
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+
+    tcg_temp_free(v0_t);
+    tcg_temp_free(v1_t);
+}
+
+static void gen_pool32axf_2_multiply(DisasContext *ctx, uint32_t opc,
+                                    int ret, int v1, int v2)
+{
+    TCGv_i32 t0;
+    TCGv v0_t;
+    TCGv v1_t;
+
+    t0 = tcg_temp_new_i32();
+
+    v0_t = tcg_temp_new();
+    v1_t = tcg_temp_new();
+
+    tcg_gen_movi_i32(t0, v2 >> 3);
+
+    gen_load_gpr(v0_t, ret);
+    gen_load_gpr(v1_t, v1);
+
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
+        break;
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
+        break;
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
+        break;
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
+        break;
+    }
+
+    tcg_temp_free_i32(t0);
+
+    tcg_temp_free(v0_t);
+    tcg_temp_free(v1_t);
+}
+
+static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                          int ret, int v1, int v2)
+{
+    TCGv t0;
+    TCGv t1;
+
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
+            break;
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
+            break;
+        }
+        break;
+    case NM_POOL32AXF_2_8_15:
+        switch ((ctx->opcode >> 9) & 0x07) {
+        case NM_DPAX_W_PH:
+        case NM_DPAQ_SA_L_W:
+        case NM_DPSX_W_PH:
+        case NM_DPSQ_SA_L_W:
+            gen_pool32axf_2_multiply(ctx, opc, ret, v1, v2);
+            break;
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
+            break;
+        }
+        break;
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
+            }
+            break;
+        case NM_EXTRV_S_H:
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            gen_helper_extr_s_h(cpu_gpr[ret], t0, v1_t, cpu_env);
+            break;
+        }
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+
+    tcg_temp_free(v0_t);
+    tcg_temp_free(v1_t);
+}
+
+static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                          int ret, int v1, int v2)
+{
+    TCGv t0;
+    TCGv v0_t;
+    TCGv v1_t;
+
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
+        break;
+    case NM_ABSQ_S_PH:
+        check_dsp(ctx);
+        gen_helper_absq_s_ph(cpu_gpr[ret], v1_t, cpu_env);
+        break;
+    case NM_ABSQ_S_W:
+        check_dsp(ctx);
+        gen_helper_absq_s_w(cpu_gpr[ret], v1_t, cpu_env);
+        break;
+    case NM_PRECEQ_W_PHL:
+        check_dsp(ctx);
+        tcg_gen_andi_tl(cpu_gpr[ret], v1_t, 0xFFFF0000);
+        tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
+        break;
+    case NM_PRECEQ_W_PHR:
+        check_dsp(ctx);
+        tcg_gen_andi_tl(cpu_gpr[ret], v1_t, 0x0000FFFF);
+        tcg_gen_shli_tl(cpu_gpr[ret], cpu_gpr[ret], 16);
+        tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
+        break;
+    case NM_PRECEQU_PH_QBL:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbl(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEQU_PH_QBR:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbr(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEQU_PH_QBLA:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbla(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEQU_PH_QBRA:
+        check_dsp(ctx);
+        gen_helper_precequ_ph_qbra(cpu_gpr[ret], v1_t);
+        break;
+    case NM_PRECEU_PH_QBL:
+        check_dsp(ctx);
+        gen_helper_preceu_ph_qbl(cpu_gpr[ret], v1_t);
+        break;
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
+        {
+            TCGv val_t;
+
+            val_t = tcg_temp_new();
+            gen_load_gpr(val_t, v1);
+
+            tcg_gen_ext8u_tl(cpu_gpr[ret], val_t);
+            tcg_gen_shli_tl(t0, cpu_gpr[ret], 8);
+            tcg_gen_or_tl(cpu_gpr[ret], cpu_gpr[ret], t0);
+            tcg_gen_shli_tl(t0, cpu_gpr[ret], 16);
+            tcg_gen_or_tl(cpu_gpr[ret], cpu_gpr[ret], t0);
+            tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
+        }
+        break;
+    case NM_BITREV:
+        check_dsp(ctx);
+        gen_helper_bitrev(cpu_gpr[ret], v1_t);
+        break;
+    case NM_INSV:
+        check_dsp(ctx);
+        {
+            TCGv t0, t1;
+
+            t0 = tcg_temp_new();
+            t1 = tcg_temp_new();
+
+            gen_load_gpr(t0, ret);
+            gen_load_gpr(t1, v1);
+
+            gen_helper_insv(cpu_gpr[ret], cpu_env, t1, t0);
+
+            tcg_temp_free(t0);
+            tcg_temp_free(t1);
+        }
+        break;
+    case NM_RADDU_W_QB:
+        check_dsp(ctx);
+        gen_helper_raddu_w_qb(cpu_gpr[ret], v1_t);
+        break;
+    case NM_BITSWAP:
+        gen_bitswap(ctx, OPC_BITSWAP, ret, v1);
+        break;
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
+
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
+        break;
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
+        }
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+    tcg_temp_free(t0);
+    tcg_temp_free(v1_t);
+}
+
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
@@ -16948,6 +17693,12 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
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
-- 
2.7.4
