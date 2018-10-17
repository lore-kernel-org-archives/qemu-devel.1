Received: from eggs.gnu.org ([2001:4830:134:3::10]:44825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2y-000216-3w
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2t-0006ub-2G
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:31 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39468 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2s-0006f2-Bs
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:26 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:45 +0200
Message-Id: <1539779635-15445-18-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 17/27] target/mips: Improve DSP R2/R3-related
 naming
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

Do following replacements:

ASE_DSPR2 -> ASE_DSP_R2
ASE_DSPR3 -> ASE_DSP_R3
MIPS_HFLAG_DSPR2 -> MIPS_HFLAG_DSP_R2
MIPS_HFLAG_DSPR3 -> MIPS_HFLAG_DSP_R3
check_dspr2() -> check_dsp_r2()
check_dspr3() -> check_dsp_r3()

and several other similar minor replacements.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h                |   6 +-
 target/mips/internal.h           |  30 ++++---
 target/mips/mips-defs.h          |   4 +-
 target/mips/translate.c          | 184 +++++++++++++++++++--------------------
 target/mips/translate_init.inc.c |   8 +-
 5 files changed, 120 insertions(+), 112 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7f4e6d0..953643b 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -793,9 +793,9 @@ struct CPUMIPSState {
 #define MIPS_HFLAG_BX     0x40000 /* branch exchanges execution mode    */
 #define MIPS_HFLAG_BMASK  (MIPS_HFLAG_BMASK_BASE | MIPS_HFLAG_BMASK_EXT)
     /* MIPS DSP resources access. */
-#define MIPS_HFLAG_DSP   0x080000  /* Enable access to MIPS DSP resources. */
-#define MIPS_HFLAG_DSPR2 0x100000  /* Enable access to MIPS DSPR2 resources. */
-#define MIPS_HFLAG_DSPR3 0x20000000 /* Enable access to MIPS DSPR3 resources.*/
+#define MIPS_HFLAG_DSP    0x080000   /* Enable access to DSP resources.    */
+#define MIPS_HFLAG_DSP_R2 0x100000   /* Enable access to DSP R2 resources. */
+#define MIPS_HFLAG_DSP_R3 0x20000000 /* Enable access to DSP R3 resources. */
     /* Extra flag about HWREna register. */
 #define MIPS_HFLAG_HWRENA_ULR 0x200000 /* ULR bit from HWREna is set. */
 #define MIPS_HFLAG_SBRI  0x400000 /* R6 SDBBP causes RI excpt. in user mode */
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 4490bd1..96f9d8b 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -306,8 +306,8 @@ static inline void compute_hflags(CPUMIPSState *env)
 {
     env->hflags &= ~(MIPS_HFLAG_COP1X | MIPS_HFLAG_64 | MIPS_HFLAG_CP0 |
                      MIPS_HFLAG_F64 | MIPS_HFLAG_FPU | MIPS_HFLAG_KSU |
-                     MIPS_HFLAG_AWRAP | MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2 |
-                     MIPS_HFLAG_DSPR3 | MIPS_HFLAG_SBRI | MIPS_HFLAG_MSA |
+                     MIPS_HFLAG_AWRAP | MIPS_HFLAG_DSP | MIPS_HFLAG_DSP_R2 |
+                     MIPS_HFLAG_DSP_R3 | MIPS_HFLAG_SBRI | MIPS_HFLAG_MSA |
                      MIPS_HFLAG_FRE | MIPS_HFLAG_ELPA | MIPS_HFLAG_ERL);
     if (env->CP0_Status & (1 << CP0St_ERL)) {
         env->hflags |= MIPS_HFLAG_ERL;
@@ -355,21 +355,29 @@ static inline void compute_hflags(CPUMIPSState *env)
         (env->CP0_Config5 & (1 << CP0C5_SBRI))) {
         env->hflags |= MIPS_HFLAG_SBRI;
     }
-    if (env->insn_flags & ASE_DSPR3) {
+    if (env->insn_flags & ASE_DSP_R3) {
+        /*
+         * Our cpu supports DSP R3 ASE, so enable
+         * access to DSP R3 resources.
+         */
         if (env->CP0_Status & (1 << CP0St_MX)) {
-            env->hflags |= MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2 |
-                           MIPS_HFLAG_DSPR3;
+            env->hflags |= MIPS_HFLAG_DSP | MIPS_HFLAG_DSP_R2 |
+                           MIPS_HFLAG_DSP_R3;
         }
-    } else if (env->insn_flags & ASE_DSPR2) {
-        /* Enables access MIPS DSP resources, now our cpu is DSP ASER2,
-           so enable to access DSPR2 resources. */
+    } else if (env->insn_flags & ASE_DSP_R2) {
+        /*
+         * Our cpu supports DSP R2 ASE, so enable
+         * access to DSP R2 resources.
+         */
         if (env->CP0_Status & (1 << CP0St_MX)) {
-            env->hflags |= MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2;
+            env->hflags |= MIPS_HFLAG_DSP | MIPS_HFLAG_DSP_R2;
         }
 
     } else if (env->insn_flags & ASE_DSP) {
-        /* Enables access MIPS DSP resources, now our cpu is DSP ASE,
-           so enable to access DSP resources. */
+        /*
+         * Our cpu supports DSP ASE, so enable
+         * access to DSP resources.
+         */
         if (env->CP0_Status & (1 << CP0St_MX)) {
             env->hflags |= MIPS_HFLAG_DSP;
         }
diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index a23c4ed..71ea4ef 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -52,8 +52,8 @@
 #define ASE_MIPS3D        0x0000000200000000ULL
 #define ASE_MDMX          0x0000000400000000ULL
 #define ASE_DSP           0x0000000800000000ULL
-#define ASE_DSPR2         0x0000001000000000ULL
-#define ASE_DSPR3         0x0000002000000000ULL
+#define ASE_DSP_R2        0x0000001000000000ULL
+#define ASE_DSP_R3        0x0000002000000000ULL
 #define ASE_MT            0x0000004000000000ULL
 #define ASE_SMARTMIPS     0x0000008000000000ULL
 #define ASE_MICROMIPS     0x0000010000000000ULL
diff --git a/target/mips/translate.c b/target/mips/translate.c
index f7e861b..6fa7617 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2397,9 +2397,9 @@ static inline void check_dsp(DisasContext *ctx)
     }
 }
 
-static inline void check_dspr2(DisasContext *ctx)
+static inline void check_dsp_r2(DisasContext *ctx)
 {
-    if (unlikely(!(ctx->hflags & MIPS_HFLAG_DSPR2))) {
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_DSP_R2))) {
         if (ctx->insn_flags & ASE_DSP) {
             generate_exception_end(ctx, EXCP_DSPDIS);
         } else {
@@ -2408,9 +2408,9 @@ static inline void check_dspr2(DisasContext *ctx)
     }
 }
 
-static inline void check_dspr3(DisasContext *ctx)
+static inline void check_dsp_r3(DisasContext *ctx)
 {
-    if (unlikely(!(ctx->hflags & MIPS_HFLAG_DSPR3))) {
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_DSP_R3))) {
         if (ctx->insn_flags & ASE_DSP) {
             generate_exception_end(ctx, EXCP_DSPDIS);
         } else {
@@ -17995,7 +17995,7 @@ static void gen_pool32axf_2_multiply(DisasContext *ctx, uint32_t opc,
     case NM_POOL32AXF_2_0_7:
         switch (extract32(ctx->opcode, 9, 3)) {
         case NM_DPA_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpa_w_ph(t0, v1, v0, cpu_env);
             break;
         case NM_DPAQ_S_W_PH:
@@ -18003,7 +18003,7 @@ static void gen_pool32axf_2_multiply(DisasContext *ctx, uint32_t opc,
             gen_helper_dpaq_s_w_ph(t0, v1, v0, cpu_env);
             break;
         case NM_DPS_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dps_w_ph(t0, v1, v0, cpu_env);
             break;
         case NM_DPSQ_S_W_PH:
@@ -18018,7 +18018,7 @@ static void gen_pool32axf_2_multiply(DisasContext *ctx, uint32_t opc,
     case NM_POOL32AXF_2_8_15:
         switch (extract32(ctx->opcode, 9, 3)) {
         case NM_DPAX_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpax_w_ph(t0, v0, v1, cpu_env);
             break;
         case NM_DPAQ_SA_L_W:
@@ -18026,7 +18026,7 @@ static void gen_pool32axf_2_multiply(DisasContext *ctx, uint32_t opc,
             gen_helper_dpaq_sa_l_w(t0, v0, v1, cpu_env);
             break;
         case NM_DPSX_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpsx_w_ph(t0, v0, v1, cpu_env);
             break;
         case NM_DPSQ_SA_L_W:
@@ -18045,7 +18045,7 @@ static void gen_pool32axf_2_multiply(DisasContext *ctx, uint32_t opc,
             gen_helper_dpau_h_qbl(t0, v0, v1, cpu_env);
             break;
         case NM_DPAQX_S_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpaqx_s_w_ph(t0, v0, v1, cpu_env);
             break;
         case NM_DPSU_H_QBL:
@@ -18053,11 +18053,11 @@ static void gen_pool32axf_2_multiply(DisasContext *ctx, uint32_t opc,
             gen_helper_dpsu_h_qbl(t0, v0, v1, cpu_env);
             break;
         case NM_DPSQX_S_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpsqx_s_w_ph(t0, v0, v1, cpu_env);
             break;
         case NM_MULSA_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_mulsa_w_ph(t0, v0, v1, cpu_env);
             break;
         default:
@@ -18072,7 +18072,7 @@ static void gen_pool32axf_2_multiply(DisasContext *ctx, uint32_t opc,
             gen_helper_dpau_h_qbr(t0, v1, v0, cpu_env);
             break;
         case NM_DPAQX_SA_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpaqx_sa_w_ph(t0, v1, v0, cpu_env);
             break;
         case NM_DPSU_H_QBR:
@@ -18080,7 +18080,7 @@ static void gen_pool32axf_2_multiply(DisasContext *ctx, uint32_t opc,
             gen_helper_dpsu_h_qbr(t0, v1, v0, cpu_env);
             break;
         case NM_DPSQX_SA_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpsqx_sa_w_ph(t0, v1, v0, cpu_env);
             break;
         case NM_MULSAQ_S_W_PH:
@@ -18122,7 +18122,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             gen_pool32axf_2_multiply(ctx, opc, v0_t, v1_t, rd);
             break;
         case NM_BALIGN:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             if (rt != 0) {
                 gen_load_gpr(t0, rs);
                 rd &= 3;
@@ -18352,7 +18352,7 @@ static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
 
     switch (opc) {
     case NM_ABSQ_S_QB:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         gen_helper_absq_s_qb(v0_t, v0_t, cpu_env);
         gen_store_gpr(v0_t, ret);
         break;
@@ -18491,7 +18491,7 @@ static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
 
     switch (opc) {
     case NM_SHRA_R_QB:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         tcg_gen_movi_tl(t0, rd >> 2);
         switch (extract32(ctx->opcode, 12, 1)) {
         case 0:
@@ -18507,7 +18507,7 @@ static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
         }
         break;
     case NM_SHRL_PH:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         tcg_gen_movi_tl(t0, rd >> 1);
         gen_helper_shrl_ph(t0, t0, rs_t);
         gen_store_gpr(t0, rt);
@@ -19432,19 +19432,19 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         gen_store_gpr(v1_t, ret);
         break;
     case NM_CMPGDU_EQ_QB:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         gen_helper_cmpgu_eq_qb(v1_t, v1_t, v2_t);
         tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
         gen_store_gpr(v1_t, ret);
         break;
     case NM_CMPGDU_LT_QB:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         gen_helper_cmpgu_lt_qb(v1_t, v1_t, v2_t);
         tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
         gen_store_gpr(v1_t, ret);
         break;
     case NM_CMPGDU_LE_QB:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         gen_helper_cmpgu_le_qb(v1_t, v1_t, v2_t);
         tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
         gen_store_gpr(v1_t, ret);
@@ -19500,7 +19500,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         }
         break;
     case NM_ADDQH_R_PH:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (extract32(ctx->opcode, 10, 1)) {
         case 0:
             /* ADDQH_PH */
@@ -19515,7 +19515,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         }
         break;
     case NM_ADDQH_R_W:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (extract32(ctx->opcode, 10, 1)) {
         case 0:
             /* ADDQH_W */
@@ -19545,7 +19545,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         }
         break;
     case NM_ADDU_S_PH:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (extract32(ctx->opcode, 10, 1)) {
         case 0:
             /* ADDU_PH */
@@ -19560,7 +19560,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         }
         break;
     case NM_ADDUH_R_QB:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (extract32(ctx->opcode, 10, 1)) {
         case 0:
             /* ADDUH_QB */
@@ -19590,7 +19590,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         }
         break;
     case NM_SHRAV_R_QB:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (extract32(ctx->opcode, 10, 1)) {
         case 0:
             /* SHRAV_QB */
@@ -19620,7 +19620,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         }
         break;
     case NM_SUBQH_R_PH:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (extract32(ctx->opcode, 10, 1)) {
         case 0:
             /* SUBQH_PH */
@@ -19635,7 +19635,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         }
         break;
     case NM_SUBQH_R_W:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (extract32(ctx->opcode, 10, 1)) {
         case 0:
             /* SUBQH_W */
@@ -19665,7 +19665,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         }
         break;
     case NM_SUBU_S_PH:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (extract32(ctx->opcode, 10, 1)) {
         case 0:
             /* SUBU_PH */
@@ -19680,7 +19680,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         }
         break;
     case NM_SUBUH_R_QB:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (extract32(ctx->opcode, 10, 1)) {
         case 0:
             /* SUBUH_QB */
@@ -19710,7 +19710,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         }
         break;
     case NM_PRECR_SRA_R_PH_W:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (extract32(ctx->opcode, 10, 1)) {
         case 0:
             /* PRECR_SRA_PH_W */
@@ -19750,22 +19750,22 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         gen_store_gpr(v1_t, ret);
         break;
     case NM_MULQ_S_PH:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         gen_helper_mulq_s_ph(v1_t, v1_t, v2_t, cpu_env);
         gen_store_gpr(v1_t, ret);
         break;
     case NM_MULQ_RS_W:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         gen_helper_mulq_rs_w(v1_t, v1_t, v2_t, cpu_env);
         gen_store_gpr(v1_t, ret);
         break;
     case NM_MULQ_S_W:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         gen_helper_mulq_s_w(v1_t, v1_t, v2_t, cpu_env);
         gen_store_gpr(v1_t, ret);
         break;
     case NM_APPEND:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         gen_load_gpr(t0, rs);
         if (rd != 0) {
             tcg_gen_deposit_tl(cpu_gpr[rt], t0, cpu_gpr[rt], rd, 32 - rd);
@@ -19783,7 +19783,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         gen_store_gpr(v1_t, ret);
         break;
     case NM_SHRLV_PH:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         gen_helper_shrl_ph(v1_t, v1_t, v2_t);
         gen_store_gpr(v1_t, ret);
         break;
@@ -19825,7 +19825,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         gen_store_gpr(v1_t, ret);
         break;
     case NM_MUL_S_PH:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (extract32(ctx->opcode, 10, 1)) {
         case 0:
             /* MUL_PH */
@@ -19840,7 +19840,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         }
         break;
     case NM_PRECR_QB_PH:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         gen_helper_precr_qb_ph(v1_t, v1_t, v2_t);
         gen_store_gpr(v1_t, ret);
         break;
@@ -20649,7 +20649,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                     gen_compute_branch_cp1_nm(ctx, OPC_BC1NEZ, rt, s);
                     break;
                 case NM_BPOSGE32C:
-                    check_dspr3(ctx);
+                    check_dsp_r3(ctx);
                     {
                         int32_t imm = extract32(ctx->opcode, 1, 13) |
                                       extract32(ctx->opcode, 0, 1) << 13;
@@ -21158,7 +21158,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
     switch (op1) {
     /* OPC_MULT_G_2E is equal OPC_ADDUH_QB_DSP */
     case OPC_MULT_G_2E:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (op2) {
         case OPC_ADDUH_QB:
             gen_helper_adduh_qb(cpu_gpr[ret], v1_t, v2_t);
@@ -21201,7 +21201,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
     case OPC_ABSQ_S_PH_DSP:
         switch (op2) {
         case OPC_ABSQ_S_QB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_absq_s_qb(cpu_gpr[ret], v2_t, cpu_env);
             break;
         case OPC_ABSQ_S_PH:
@@ -21280,11 +21280,11 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
             gen_helper_addu_s_qb(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_ADDU_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_addu_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_ADDU_S_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_addu_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_SUBQ_PH:
@@ -21308,11 +21308,11 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
             gen_helper_subu_s_qb(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_SUBU_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_subu_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_SUBU_S_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_subu_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_ADDSC:
@@ -21336,7 +21336,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
     case OPC_CMPU_EQ_QB_DSP:
         switch (op2) {
         case OPC_PRECR_QB_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_precr_qb_ph(cpu_gpr[ret], v1_t, v2_t);
             break;
         case OPC_PRECRQ_QB_PH:
@@ -21344,7 +21344,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
             gen_helper_precrq_qb_ph(cpu_gpr[ret], v1_t, v2_t);
             break;
         case OPC_PRECR_SRA_PH_W:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             {
                 TCGv_i32 sa_t = tcg_const_i32(v2);
                 gen_helper_precr_sra_ph_w(cpu_gpr[ret], sa_t, v1_t,
@@ -21353,7 +21353,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
                 break;
             }
         case OPC_PRECR_SRA_R_PH_W:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             {
                 TCGv_i32 sa_t = tcg_const_i32(v2);
                 gen_helper_precr_sra_r_ph_w(cpu_gpr[ret], sa_t, v1_t,
@@ -21435,7 +21435,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
             gen_helper_preceu_qh_obra(cpu_gpr[ret], v2_t);
             break;
         case OPC_ABSQ_S_OB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_absq_s_ob(cpu_gpr[ret], v2_t, cpu_env);
             break;
         case OPC_ABSQ_S_PW:
@@ -21479,19 +21479,19 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
             gen_helper_subu_s_ob(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_SUBU_QH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_subu_qh(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_SUBU_S_QH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_subu_s_qh(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_SUBUH_OB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_subuh_ob(cpu_gpr[ret], v1_t, v2_t);
             break;
         case OPC_SUBUH_R_OB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_subuh_r_ob(cpu_gpr[ret], v1_t, v2_t);
             break;
         case OPC_ADDQ_PW:
@@ -21519,19 +21519,19 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
             gen_helper_addu_s_ob(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_ADDU_QH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_addu_qh(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_ADDU_S_QH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_addu_s_qh(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_ADDUH_OB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_adduh_ob(cpu_gpr[ret], v1_t, v2_t);
             break;
         case OPC_ADDUH_R_OB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_adduh_r_ob(cpu_gpr[ret], v1_t, v2_t);
             break;
         }
@@ -21539,11 +21539,11 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
     case OPC_CMPU_EQ_OB_DSP:
         switch (op2) {
         case OPC_PRECR_OB_QH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_precr_ob_qh(cpu_gpr[ret], v1_t, v2_t);
             break;
         case OPC_PRECR_SRA_QH_PW:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             {
                 TCGv_i32 ret_t = tcg_const_i32(ret);
                 gen_helper_precr_sra_qh_pw(v2_t, v1_t, v2_t, ret_t);
@@ -21551,7 +21551,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
                 break;
             }
         case OPC_PRECR_SRA_R_QH_PW:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             {
                 TCGv_i32 sa_v = tcg_const_i32(ret);
                 gen_helper_precr_sra_r_qh_pw(v2_t, v1_t, v2_t, sa_v);
@@ -21654,27 +21654,27 @@ static void gen_mipsdsp_shift(DisasContext *ctx, uint32_t opc,
                 gen_helper_shrl_qb(cpu_gpr[ret], v1_t, v2_t);
                 break;
             case OPC_SHRL_PH:
-                check_dspr2(ctx);
+                check_dsp_r2(ctx);
                 gen_helper_shrl_ph(cpu_gpr[ret], t0, v2_t);
                 break;
             case OPC_SHRLV_PH:
-                check_dspr2(ctx);
+                check_dsp_r2(ctx);
                 gen_helper_shrl_ph(cpu_gpr[ret], v1_t, v2_t);
                 break;
             case OPC_SHRA_QB:
-                check_dspr2(ctx);
+                check_dsp_r2(ctx);
                 gen_helper_shra_qb(cpu_gpr[ret], t0, v2_t);
                 break;
             case OPC_SHRA_R_QB:
-                check_dspr2(ctx);
+                check_dsp_r2(ctx);
                 gen_helper_shra_r_qb(cpu_gpr[ret], t0, v2_t);
                 break;
             case OPC_SHRAV_QB:
-                check_dspr2(ctx);
+                check_dsp_r2(ctx);
                 gen_helper_shra_qb(cpu_gpr[ret], v1_t, v2_t);
                 break;
             case OPC_SHRAV_R_QB:
-                check_dspr2(ctx);
+                check_dsp_r2(ctx);
                 gen_helper_shra_r_qb(cpu_gpr[ret], v1_t, v2_t);
                 break;
             case OPC_SHRA_PH:
@@ -21753,19 +21753,19 @@ static void gen_mipsdsp_shift(DisasContext *ctx, uint32_t opc,
             gen_helper_shll_s_qh(cpu_gpr[ret], v2_t, v1_t, cpu_env);
             break;
         case OPC_SHRA_OB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_shra_ob(cpu_gpr[ret], v2_t, t0);
             break;
         case OPC_SHRAV_OB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_shra_ob(cpu_gpr[ret], v2_t, v1_t);
             break;
         case OPC_SHRA_R_OB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_shra_r_ob(cpu_gpr[ret], v2_t, t0);
             break;
         case OPC_SHRAV_R_OB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_shra_r_ob(cpu_gpr[ret], v2_t, v1_t);
             break;
         case OPC_SHRA_PW:
@@ -21809,11 +21809,11 @@ static void gen_mipsdsp_shift(DisasContext *ctx, uint32_t opc,
             gen_helper_shrl_ob(cpu_gpr[ret], v2_t, v1_t);
             break;
         case OPC_SHRL_QH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_shrl_qh(cpu_gpr[ret], v2_t, t0);
             break;
         case OPC_SHRLV_QH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_shrl_qh(cpu_gpr[ret], v2_t, v1_t);
             break;
         default:            /* Invalid */
@@ -21854,7 +21854,7 @@ static void gen_mipsdsp_multiply(DisasContext *ctx, uint32_t op1, uint32_t op2,
     /* OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
      * the same mask and op1. */
     case OPC_MULT_G_2E:
-        check_dspr2(ctx);
+        check_dsp_r2(ctx);
         switch (op2) {
         case  OPC_MUL_PH:
             gen_helper_mul_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
@@ -21889,11 +21889,11 @@ static void gen_mipsdsp_multiply(DisasContext *ctx, uint32_t op1, uint32_t op2,
             gen_helper_dpsu_h_qbr(t0, v1_t, v2_t, cpu_env);
             break;
         case OPC_DPA_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpa_w_ph(t0, v1_t, v2_t, cpu_env);
             break;
         case OPC_DPAX_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpax_w_ph(t0, v1_t, v2_t, cpu_env);
             break;
         case OPC_DPAQ_S_W_PH:
@@ -21901,19 +21901,19 @@ static void gen_mipsdsp_multiply(DisasContext *ctx, uint32_t op1, uint32_t op2,
             gen_helper_dpaq_s_w_ph(t0, v1_t, v2_t, cpu_env);
             break;
         case OPC_DPAQX_S_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpaqx_s_w_ph(t0, v1_t, v2_t, cpu_env);
             break;
         case OPC_DPAQX_SA_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpaqx_sa_w_ph(t0, v1_t, v2_t, cpu_env);
             break;
         case OPC_DPS_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dps_w_ph(t0, v1_t, v2_t, cpu_env);
             break;
         case OPC_DPSX_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpsx_w_ph(t0, v1_t, v2_t, cpu_env);
             break;
         case OPC_DPSQ_S_W_PH:
@@ -21921,11 +21921,11 @@ static void gen_mipsdsp_multiply(DisasContext *ctx, uint32_t op1, uint32_t op2,
             gen_helper_dpsq_s_w_ph(t0, v1_t, v2_t, cpu_env);
             break;
         case OPC_DPSQX_S_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpsqx_s_w_ph(t0, v1_t, v2_t, cpu_env);
             break;
         case OPC_DPSQX_SA_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_dpsqx_sa_w_ph(t0, v1_t, v2_t, cpu_env);
             break;
         case OPC_MULSAQ_S_W_PH:
@@ -21957,7 +21957,7 @@ static void gen_mipsdsp_multiply(DisasContext *ctx, uint32_t op1, uint32_t op2,
             gen_helper_maq_sa_w_phr(t0, v1_t, v2_t, cpu_env);
             break;
         case OPC_MULSA_W_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_mulsa_w_ph(t0, v1_t, v2_t, cpu_env);
             break;
         }
@@ -21986,7 +21986,7 @@ static void gen_mipsdsp_multiply(DisasContext *ctx, uint32_t op1, uint32_t op2,
                 gen_helper_dmsubu(v1_t, v2_t, t0, cpu_env);
                 break;
             case OPC_DPA_W_QH:
-                check_dspr2(ctx);
+                check_dsp_r2(ctx);
                 gen_helper_dpa_w_qh(v1_t, v2_t, t0, cpu_env);
                 break;
             case OPC_DPAQ_S_W_QH:
@@ -22006,7 +22006,7 @@ static void gen_mipsdsp_multiply(DisasContext *ctx, uint32_t op1, uint32_t op2,
                 gen_helper_dpau_h_obr(v1_t, v2_t, t0, cpu_env);
                 break;
             case OPC_DPS_W_QH:
-                check_dspr2(ctx);
+                check_dsp_r2(ctx);
                 gen_helper_dps_w_qh(v1_t, v2_t, t0, cpu_env);
                 break;
             case OPC_DPSQ_S_W_QH:
@@ -22100,7 +22100,7 @@ static void gen_mipsdsp_multiply(DisasContext *ctx, uint32_t op1, uint32_t op2,
             gen_helper_muleq_s_w_phr(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_MULQ_S_PH:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_mulq_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         }
@@ -22324,7 +22324,7 @@ static void gen_mipsdsp_add_cmp_pick(DisasContext *ctx,
             gen_helper_cmpgu_le_qb(cpu_gpr[ret], v1_t, v2_t);
             break;
         case OPC_CMPGDU_EQ_QB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_cmpgu_eq_qb(t1, v1_t, v2_t);
             tcg_gen_mov_tl(cpu_gpr[ret], t1);
             tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
@@ -22332,7 +22332,7 @@ static void gen_mipsdsp_add_cmp_pick(DisasContext *ctx,
             tcg_gen_or_tl(cpu_dspctrl, cpu_dspctrl, t1);
             break;
         case OPC_CMPGDU_LT_QB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_cmpgu_lt_qb(t1, v1_t, v2_t);
             tcg_gen_mov_tl(cpu_gpr[ret], t1);
             tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
@@ -22340,7 +22340,7 @@ static void gen_mipsdsp_add_cmp_pick(DisasContext *ctx,
             tcg_gen_or_tl(cpu_dspctrl, cpu_dspctrl, t1);
             break;
         case OPC_CMPGDU_LE_QB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_cmpgu_le_qb(t1, v1_t, v2_t);
             tcg_gen_mov_tl(cpu_gpr[ret], t1);
             tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
@@ -22401,15 +22401,15 @@ static void gen_mipsdsp_add_cmp_pick(DisasContext *ctx,
             gen_helper_cmp_le_qh(v1_t, v2_t, cpu_env);
             break;
         case OPC_CMPGDU_EQ_OB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_cmpgdu_eq_ob(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_CMPGDU_LT_OB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_cmpgdu_lt_ob(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_CMPGDU_LE_OB:
-            check_dspr2(ctx);
+            check_dsp_r2(ctx);
             gen_helper_cmpgdu_le_ob(cpu_gpr[ret], v1_t, v2_t, cpu_env);
             break;
         case OPC_CMPGU_EQ_OB:
@@ -22467,7 +22467,7 @@ static void gen_mipsdsp_append(CPUMIPSState *env, DisasContext *ctx,
 {
     TCGv t0;
 
-    check_dspr2(ctx);
+    check_dsp_r2(ctx);
 
     if (rt == 0) {
         /* Treat as NOP. */
@@ -23352,7 +23352,7 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MULTU_G_2E:
         /* OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
          * the same mask and op1. */
-        if ((ctx->insn_flags & ASE_DSPR2) && (op1 == OPC_MULT_G_2E)) {
+        if ((ctx->insn_flags & ASE_DSP_R2) && (op1 == OPC_MULT_G_2E)) {
             op2 = MASK_ADDUH_QB(ctx->opcode);
             switch (op2) {
             case OPC_ADDUH_QB:
diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index d7cd4ee..acab097 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -320,7 +320,7 @@ const mips_def_t mips_defs[] =
         .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 32,
         .PABITS = 32,
-        .insn_flags = CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP | ASE_DSPR2,
+        .insn_flags = CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP | ASE_DSP_R2,
         .mmu_type = MMU_TYPE_R4000,
     },
     {
@@ -485,7 +485,7 @@ const mips_def_t mips_defs[] =
         .CP1_fcr31 = (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
         .SEGBITS = 32,
         .PABITS = 32,
-        .insn_flags = CPU_NANOMIPS32 | ASE_DSP | ASE_DSPR2 | ASE_DSPR3 |
+        .insn_flags = CPU_NANOMIPS32 | ASE_DSP | ASE_DSP_R2 | ASE_DSP_R3 |
                       ASE_MT,
         .mmu_type = MMU_TYPE_R4000,
     },
@@ -762,7 +762,7 @@ const mips_def_t mips_defs[] =
         .mmu_type = MMU_TYPE_R4000,
     },
     {
-        /* A generic CPU providing MIPS64 ASE DSP 2 features.
+        /* A generic CPU providing MIPS64 DSP R2 ASE features.
            FIXME: Eventually this should be replaced by a real CPU model. */
         .name = "mips64dspr2",
         .CP0_PRid = 0x00010000,
@@ -787,7 +787,7 @@ const mips_def_t mips_defs[] =
         .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 36,
-        .insn_flags = CPU_MIPS64R2 | ASE_DSP | ASE_DSPR2,
+        .insn_flags = CPU_MIPS64R2 | ASE_DSP | ASE_DSP_R2,
         .mmu_type = MMU_TYPE_R4000,
     },
 
-- 
2.7.4
