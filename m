Received: from eggs.gnu.org ([2001:4830:134:3::10]:34076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6lY-0000tZ-CG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6lV-00073S-7J
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:12 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49411 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs6lU-0006zH-KY
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:09 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 15:31:41 +0200
Message-Id: <1534858316-12945-32-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v3 31/46] target/mips: Add emulation of DSP ASE
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
Cc: peter.maydell@linaro.org

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of DSP ASE instructions for nanoMIPS - part 3.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 183 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ea6bd8d..9c2ee67 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17244,13 +17244,194 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
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
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv v0_t = tcg_temp_new();
+
+    gen_load_gpr(v0_t, v1);
+
+    switch (opc) {
+    case NM_POOL32AXF_1_0:
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 12, 2)) {
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
+        check_dsp(ctx);
+        switch (extract32(ctx->opcode, 12, 2)) {
+        case NM_MTHLIP:
+            tcg_gen_movi_tl(t0, v2);
+            gen_helper_mthlip(t0, v0_t, cpu_env);
+            break;
+        case NM_SHILOV:
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            gen_helper_shilo(t0, v0_t, cpu_env);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_1_3:
+        check_dsp(ctx);
+        imm = extract32(ctx->opcode, 14, 7);
+        switch (extract32(ctx->opcode, 12, 2)) {
+        case NM_RDDSP:
+            tcg_gen_movi_tl(t0, imm);
+            gen_helper_rddsp(t0, t0, cpu_env);
+            gen_store_gpr(t0, ret);
+            break;
+        case NM_WRDSP:
+            gen_load_gpr(t0, ret);
+            tcg_gen_movi_tl(t1, imm);
+            gen_helper_wrdsp(t0, t1, cpu_env);
+            break;
+        case NM_EXTP:
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            tcg_gen_movi_tl(t1, v1);
+            gen_helper_extp(t0, t0, t1, cpu_env);
+            gen_store_gpr(t0, ret);
+            break;
+        case NM_EXTPDP:
+            tcg_gen_movi_tl(t0, v2 >> 3);
+            tcg_gen_movi_tl(t1, v1);
+            gen_helper_extpdp(t0, t0, t1, cpu_env);
+            gen_store_gpr(t0, ret);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_1_4:
+        check_dsp(ctx);
+        tcg_gen_movi_tl(t0, v2 >> 2);
+        switch (extract32(ctx->opcode, 12, 1)) {
+        case NM_SHLL_QB:
+            gen_helper_shll_qb(t0, t0, v0_t, cpu_env);
+            gen_store_gpr(t0, ret);
+            break;
+        case NM_SHRL_QB:
+            gen_helper_shrl_qb(t0, t0, v0_t);
+            gen_store_gpr(t0, ret);
+            break;
+        }
+        break;
+    case NM_POOL32AXF_1_5:
+        opc = extract32(ctx->opcode, 12, 2);
+        gen_pool32axf_1_5_nanomips_insn(ctx, opc, ret, v1, v2);
+        break;
+    case NM_POOL32AXF_1_7:
+        check_dsp(ctx);
+        tcg_gen_movi_tl(t0, v2 >> 3);
+        tcg_gen_movi_tl(t1, v1);
+        switch (extract32(ctx->opcode, 12, 2)) {
+        case NM_EXTR_W:
+            gen_helper_extr_w(t0, t0, t1, cpu_env);
+            gen_store_gpr(t0, ret);
+            break;
+        case NM_EXTR_R_W:
+            gen_helper_extr_r_w(t0, t0, t1, cpu_env);
+            gen_store_gpr(t0, ret);
+            break;
+        case NM_EXTR_RS_W:
+            gen_helper_extr_rs_w(t0, t0, t1, cpu_env);
+            gen_store_gpr(t0, ret);
+            break;
+        case NM_EXTR_S_H:
+            gen_helper_extr_s_h(t0, t0, t1, cpu_env);
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
+    tcg_temp_free(v0_t);
+}
+
+
 static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 {
     int rt = extract32(ctx->opcode, 21, 5);
     int rs = extract32(ctx->opcode, 16, 5);
+    int rd = extract32(ctx->opcode, 11, 5);
 
     switch (extract32(ctx->opcode, 6, 3)) {
+    case NM_POOL32AXF_1:
+        {
+            int32_t op1 = extract32(ctx->opcode, 9, 3);
+            gen_pool32axf_1_nanomips_insn(ctx, op1, rt, rs, rd);
+        }
+        break;
+    case NM_POOL32AXF_2:
+        break;
     case NM_POOL32AXF_4:
+        break;
     case NM_POOL32AXF_5:
         switch (extract32(ctx->opcode, 9, 7)) {
 #ifndef CONFIG_USER_ONLY
@@ -17319,6 +17500,8 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
+    case NM_POOL32AXF_7:
+        break;
     default:
         generate_exception_end(ctx, EXCP_RI);
         break;
-- 
2.7.4
