Received: from eggs.gnu.org ([2001:4830:134:3::10]:33724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fsqSM-0005IZ-PP
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fsqSG-0004qx-IQ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:26 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57109 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fsqSF-0004nz-Rz
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:20 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 23 Aug 2018 16:18:47 +0200
Message-Id: <1535033941-861-33-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v5 32/46] target/mips: Add emulation of DSP ASE
 for nanoMIPS - part 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of DSP ASE instructions for nanoMIPS - part 4.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 363 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 363 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1db8e82..24476a5 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17415,6 +17415,365 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(v0_t);
 }
 
+static void gen_pool32axf_2_multiply(DisasContext *ctx, uint32_t opc,
+                                    TCGv v0, TCGv v1, int rd)
+{
+    TCGv_i32 t0;
+
+    t0 = tcg_temp_new_i32();
+
+    tcg_gen_movi_i32(t0, rd >> 3);
+
+    switch (opc) {
+    case NM_POOL32AXF_2_0_7:
+        switch (extract32(ctx->opcode, 9, 3)) {
+        case NM_DPA_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpa_w_ph(t0, v1, v0, cpu_env);
+            break;
+        case NM_DPAQ_S_W_PH:
+            check_dsp(ctx);
+            gen_helper_dpaq_s_w_ph(t0, v1, v0, cpu_env);
+            break;
+        case NM_DPS_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dps_w_ph(t0, v1, v0, cpu_env);
+            break;
+        case NM_DPSQ_S_W_PH:
+            check_dsp(ctx);
+            gen_helper_dpsq_s_w_ph(t0, v1, v0, cpu_env);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_2_8_15:
+        switch (extract32(ctx->opcode, 9, 3)) {
+        case NM_DPAX_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpax_w_ph(t0, v0, v1, cpu_env);
+            break;
+        case NM_DPAQ_SA_L_W:
+            check_dsp(ctx);
+            gen_helper_dpaq_sa_l_w(t0, v0, v1, cpu_env);
+            break;
+        case NM_DPSX_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpsx_w_ph(t0, v0, v1, cpu_env);
+            break;
+        case NM_DPSQ_SA_L_W:
+            check_dsp(ctx);
+            gen_helper_dpsq_sa_l_w(t0, v0, v1, cpu_env);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_2_16_23:
+        switch (extract32(ctx->opcode, 9, 3)) {
+        case NM_DPAU_H_QBL:
+            check_dsp(ctx);
+            gen_helper_dpau_h_qbl(t0, v0, v1, cpu_env);
+            break;
+        case NM_DPAQX_S_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpaqx_s_w_ph(t0, v0, v1, cpu_env);
+            break;
+        case NM_DPSU_H_QBL:
+            check_dsp(ctx);
+            gen_helper_dpsu_h_qbl(t0, v0, v1, cpu_env);
+            break;
+        case NM_DPSQX_S_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpsqx_s_w_ph(t0, v0, v1, cpu_env);
+            break;
+        case NM_MULSA_W_PH:
+            check_dspr2(ctx);
+            gen_helper_mulsa_w_ph(t0, v0, v1, cpu_env);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_2_24_31:
+        switch (extract32(ctx->opcode, 9, 3)) {
+        case NM_DPAU_H_QBR:
+            check_dsp(ctx);
+            gen_helper_dpau_h_qbr(t0, v1, v0, cpu_env);
+            break;
+        case NM_DPAQX_SA_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpaqx_sa_w_ph(t0, v1, v0, cpu_env);
+            break;
+        case NM_DPSU_H_QBR:
+            check_dsp(ctx);
+            gen_helper_dpsu_h_qbr(t0, v1, v0, cpu_env);
+            break;
+        case NM_DPSQX_SA_W_PH:
+            check_dspr2(ctx);
+            gen_helper_dpsqx_sa_w_ph(t0, v1, v0, cpu_env);
+            break;
+        case NM_MULSAQ_S_W_PH:
+            check_dsp(ctx);
+            gen_helper_mulsaq_s_w_ph(t0, v1, v0, cpu_env);
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
+}
+
+static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
+                                          int rt, int rs, int rd)
+{
+    int ret = rt;
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv v0_t = tcg_temp_new();
+    TCGv v1_t = tcg_temp_new();
+
+    gen_load_gpr(v0_t, rt);
+    gen_load_gpr(v1_t, rs);
+
+    switch (opc) {
+    case NM_POOL32AXF_2_0_7:
+        switch (extract32(ctx->opcode, 9, 3)) {
+        case NM_DPA_W_PH:
+        case NM_DPAQ_S_W_PH:
+        case NM_DPS_W_PH:
+        case NM_DPSQ_S_W_PH:
+            gen_pool32axf_2_multiply(ctx, opc, v0_t, v1_t, rd);
+            break;
+        case NM_BALIGN:
+            check_dspr2(ctx);
+            if (rt != 0) {
+                gen_load_gpr(t0, rs);
+                rd &= 3;
+                if (rd != 0 && rd != 2) {
+                    tcg_gen_shli_tl(cpu_gpr[ret], cpu_gpr[ret], 8 * rd);
+                    tcg_gen_ext32u_tl(t0, t0);
+                    tcg_gen_shri_tl(t0, t0, 8 * (4 - rd));
+                    tcg_gen_or_tl(cpu_gpr[ret], cpu_gpr[ret], t0);
+                }
+                tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
+            }
+            break;
+        case NM_MADD:
+            check_dsp(ctx);
+            {
+                int acc = extract32(ctx->opcode, 14, 2);
+                TCGv_i64 t2 = tcg_temp_new_i64();
+                TCGv_i64 t3 = tcg_temp_new_i64();
+
+                gen_load_gpr(t0, rt);
+                gen_load_gpr(t1, rs);
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
+            check_dsp(ctx);
+            {
+                int acc = extract32(ctx->opcode, 14, 2);
+                TCGv_i32 t2 = tcg_temp_new_i32();
+                TCGv_i32 t3 = tcg_temp_new_i32();
+
+                gen_load_gpr(t0, rs);
+                gen_load_gpr(t1, rt);
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
+            check_dsp(ctx);
+            gen_load_gpr(v1_t, rs);
+            tcg_gen_movi_tl(t0, rd >> 3);
+            gen_helper_extr_w(t0, t0, v1_t, cpu_env);
+            gen_store_gpr(t0, ret);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_2_8_15:
+        switch (extract32(ctx->opcode, 9, 3)) {
+        case NM_DPAX_W_PH:
+        case NM_DPAQ_SA_L_W:
+        case NM_DPSX_W_PH:
+        case NM_DPSQ_SA_L_W:
+            gen_pool32axf_2_multiply(ctx, opc, v0_t, v1_t, rd);
+            break;
+        case NM_MADDU:
+            check_dsp(ctx);
+            {
+                int acc = extract32(ctx->opcode, 14, 2);
+                TCGv_i64 t2 = tcg_temp_new_i64();
+                TCGv_i64 t3 = tcg_temp_new_i64();
+
+                gen_load_gpr(t0, rs);
+                gen_load_gpr(t1, rt);
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
+            check_dsp(ctx);
+            {
+                int acc = extract32(ctx->opcode, 14, 2);
+                TCGv_i32 t2 = tcg_temp_new_i32();
+                TCGv_i32 t3 = tcg_temp_new_i32();
+
+                gen_load_gpr(t0, rs);
+                gen_load_gpr(t1, rt);
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
+            check_dsp(ctx);
+            tcg_gen_movi_tl(t0, rd >> 3);
+            gen_helper_extr_r_w(t0, t0, v1_t, cpu_env);
+            gen_store_gpr(t0, ret);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_2_16_23:
+        switch (extract32(ctx->opcode, 9, 3)) {
+        case NM_DPAU_H_QBL:
+        case NM_DPAQX_S_W_PH:
+        case NM_DPSU_H_QBL:
+        case NM_DPSQX_S_W_PH:
+        case NM_MULSA_W_PH:
+            gen_pool32axf_2_multiply(ctx, opc, v0_t, v1_t, rd);
+            break;
+        case NM_EXTPV:
+            check_dsp(ctx);
+            tcg_gen_movi_tl(t0, rd >> 3);
+            gen_helper_extp(t0, t0, v1_t, cpu_env);
+            gen_store_gpr(t0, ret);
+            break;
+        case NM_MSUB:
+            check_dsp(ctx);
+            {
+                int acc = extract32(ctx->opcode, 14, 2);
+                TCGv_i64 t2 = tcg_temp_new_i64();
+                TCGv_i64 t3 = tcg_temp_new_i64();
+
+                gen_load_gpr(t0, rs);
+                gen_load_gpr(t1, rt);
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
+            check_dsp(ctx);
+            tcg_gen_movi_tl(t0, rd >> 3);
+            gen_helper_extr_rs_w(t0, t0, v1_t, cpu_env);
+            gen_store_gpr(t0, ret);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_2_24_31:
+        switch (extract32(ctx->opcode, 9, 3)) {
+        case NM_DPAU_H_QBR:
+        case NM_DPAQX_SA_W_PH:
+        case NM_DPSU_H_QBR:
+        case NM_DPSQX_SA_W_PH:
+        case NM_MULSAQ_S_W_PH:
+            gen_pool32axf_2_multiply(ctx, opc, v0_t, v1_t, rd);
+            break;
+        case NM_EXTPDPV:
+            check_dsp(ctx);
+            tcg_gen_movi_tl(t0, rd >> 3);
+            gen_helper_extpdp(t0, t0, v1_t, cpu_env);
+            gen_store_gpr(t0, ret);
+            break;
+        case NM_MSUBU:
+            check_dsp(ctx);
+            {
+                int acc = extract32(ctx->opcode, 14, 2);
+                TCGv_i64 t2 = tcg_temp_new_i64();
+                TCGv_i64 t3 = tcg_temp_new_i64();
+
+                gen_load_gpr(t0, rs);
+                gen_load_gpr(t1, rt);
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
+            check_dsp(ctx);
+            tcg_gen_movi_tl(t0, rd >> 3);
+            gen_helper_extr_s_h(t0, t0, v0_t, cpu_env);
+            gen_store_gpr(t0, ret);
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
 
 static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 {
@@ -17430,6 +17789,10 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_POOL32AXF_2:
+        {
+            int32_t op1 = extract32(ctx->opcode, 12, 2);
+            gen_pool32axf_2_nanomips_insn(ctx, op1, rt, rs, rd);
+        }
         break;
     case NM_POOL32AXF_4:
         break;
-- 
2.7.4
