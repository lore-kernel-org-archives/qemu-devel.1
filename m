Received: from eggs.gnu.org ([2001:4830:134:3::10]:46217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGi5Y-0002HF-KO
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGi5W-0004VM-Ph
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:16 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fGi5W-0004Uj-FZ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:14 -0400
Received: by mail-wm0-x243.google.com with SMTP id a137-v6so26707008wme.1
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 02:42:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 May 2018 10:42:05 +0100
Message-Id: <20180510094206.15354-5-alex.bennee@linaro.org>
In-Reply-To: <20180510094206.15354-1-alex.bennee@linaro.org>
References: <20180510094206.15354-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 4/5] target/arm: convert conversion helpers
 to fpst/ahp_flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Instead of passing env and leaving it up to the helper to get the
right fpstatus we pass it explicitly. There was already a get_fpstatus
helper for neon for the 32 bit code. We also add an get_ahp_flag() for
passing the state of the alternative FP16 format flag. This leaves
scope for later tracking the AHP state in translation flags.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c        | 58 ++++++++++++-------------------
 target/arm/helper.h        | 12 +++----
 target/arm/translate-a64.c | 38 +++++++++++++++++----
 target/arm/translate.c     | 70 +++++++++++++++++++++++++++++---------
 target/arm/translate.h     | 15 ++++++++
 5 files changed, 128 insertions(+), 65 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0fef5d4d06..4dd28bb70c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11457,64 +11457,50 @@ uint32_t HELPER(set_neon_rmode)(uint32_t rmode, CPUARMState *env)
 }
 
 /* Half precision conversions.  */
-static float32 do_fcvt_f16_to_f32(uint32_t a, CPUARMState *env, float_status *s)
+static float32 do_fcvt_f16_to_f32(float16 a, float_status *s, bool ahp)
 {
-    int ieee = (env->vfp.xregs[ARM_VFP_FPSCR] & (1 << 26)) == 0;
-    float32 r = float16_to_float32(make_float16(a), ieee, s);
-    if (ieee) {
-        return float32_maybe_silence_nan(r, s);
-    }
-    return r;
+    return float16_to_float32(a, !ahp, s);
 }
 
-static uint32_t do_fcvt_f32_to_f16(float32 a, CPUARMState *env, float_status *s)
+static float16 do_fcvt_f32_to_f16(float32 a, float_status *s, bool ahp)
 {
-    int ieee = (env->vfp.xregs[ARM_VFP_FPSCR] & (1 << 26)) == 0;
-    float16 r = float32_to_float16(a, ieee, s);
-    if (ieee) {
-        r = float16_maybe_silence_nan(r, s);
-    }
-    return float16_val(r);
+    return float32_to_float16(a, !ahp, s);
 }
 
-float32 HELPER(neon_fcvt_f16_to_f32)(uint32_t a, CPUARMState *env)
+float32 HELPER(neon_fcvt_f16_to_f32)(float16 a, void *fpstp, uint32_t ahp_mode)
 {
-    return do_fcvt_f16_to_f32(a, env, &env->vfp.standard_fp_status);
+    float_status *fpst = fpstp;
+    return do_fcvt_f16_to_f32(a, fpst, ahp_mode);
 }
 
-uint32_t HELPER(neon_fcvt_f32_to_f16)(float32 a, CPUARMState *env)
+float16 HELPER(neon_fcvt_f32_to_f16)(float32 a, void *fpstp, uint32_t ahp_mode)
 {
-    return do_fcvt_f32_to_f16(a, env, &env->vfp.standard_fp_status);
+    float_status *fpst = fpstp;
+    return do_fcvt_f32_to_f16(a, fpst, ahp_mode);
 }
 
-float32 HELPER(vfp_fcvt_f16_to_f32)(uint32_t a, CPUARMState *env)
+float32 HELPER(vfp_fcvt_f16_to_f32)(float16 a, void *fpstp, uint32_t ahp_mode)
 {
-    return do_fcvt_f16_to_f32(a, env, &env->vfp.fp_status);
+    float_status *fpst = fpstp;
+    return do_fcvt_f16_to_f32(a, fpst, ahp_mode);
 }
 
-uint32_t HELPER(vfp_fcvt_f32_to_f16)(float32 a, CPUARMState *env)
+float16 HELPER(vfp_fcvt_f32_to_f16)(float32 a, void *fpstp, uint32_t ahp_mode)
 {
-    return do_fcvt_f32_to_f16(a, env, &env->vfp.fp_status);
+    float_status *fpst = fpstp;
+    return do_fcvt_f32_to_f16(a, fpst, ahp_mode);
 }
 
-float64 HELPER(vfp_fcvt_f16_to_f64)(uint32_t a, CPUARMState *env)
+float64 HELPER(vfp_fcvt_f16_to_f64)(float16 a, void *fpstp, uint32_t ahp_mode)
 {
-    int ieee = (env->vfp.xregs[ARM_VFP_FPSCR] & (1 << 26)) == 0;
-    float64 r = float16_to_float64(make_float16(a), ieee, &env->vfp.fp_status);
-    if (ieee) {
-        return float64_maybe_silence_nan(r, &env->vfp.fp_status);
-    }
-    return r;
+    float_status *fpst = fpstp;
+    return float16_to_float64(a, !ahp_mode, fpst);
 }
 
-uint32_t HELPER(vfp_fcvt_f64_to_f16)(float64 a, CPUARMState *env)
+float16 HELPER(vfp_fcvt_f64_to_f16)(float64 a, void *fpstp, uint32_t ahp_mode)
 {
-    int ieee = (env->vfp.xregs[ARM_VFP_FPSCR] & (1 << 26)) == 0;
-    float16 r = float64_to_float16(a, ieee, &env->vfp.fp_status);
-    if (ieee) {
-        r = float16_maybe_silence_nan(r, &env->vfp.fp_status);
-    }
-    return float16_val(r);
+    float_status *fpst = fpstp;
+    return float64_to_float16(a, !ahp_mode, fpst);
 }
 
 #define float32_two make_float32(0x40000000)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 34e8cc8904..288480a0e7 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -181,12 +181,12 @@ DEF_HELPER_3(vfp_ultoh, f16, i32, i32, ptr)
 DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, ptr)
 DEF_HELPER_FLAGS_2(set_neon_rmode, TCG_CALL_NO_RWG, i32, i32, env)
 
-DEF_HELPER_2(vfp_fcvt_f16_to_f32, f32, i32, env)
-DEF_HELPER_2(vfp_fcvt_f32_to_f16, i32, f32, env)
-DEF_HELPER_2(neon_fcvt_f16_to_f32, f32, i32, env)
-DEF_HELPER_2(neon_fcvt_f32_to_f16, i32, f32, env)
-DEF_HELPER_FLAGS_2(vfp_fcvt_f16_to_f64, TCG_CALL_NO_RWG, f64, i32, env)
-DEF_HELPER_FLAGS_2(vfp_fcvt_f64_to_f16, TCG_CALL_NO_RWG, i32, f64, env)
+DEF_HELPER_3(vfp_fcvt_f16_to_f32, f32, f16, ptr, i32)
+DEF_HELPER_3(vfp_fcvt_f32_to_f16, f16, f32, ptr, i32)
+DEF_HELPER_3(neon_fcvt_f16_to_f32, f32, f16, ptr, i32)
+DEF_HELPER_3(neon_fcvt_f32_to_f16, f16, f32, ptr, i32)
+DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f64, TCG_CALL_NO_RWG, f64, f16, ptr, i32)
+DEF_HELPER_FLAGS_3(vfp_fcvt_f64_to_f16, TCG_CALL_NO_RWG, f16, f64, ptr, i32)
 
 DEF_HELPER_4(vfp_muladdd, f64, f64, f64, f64, ptr)
 DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6d49f30b4a..00a7c63240 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4830,10 +4830,15 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
         } else {
             /* Single to half */
             TCGv_i32 tcg_rd = tcg_temp_new_i32();
-            gen_helper_vfp_fcvt_f32_to_f16(tcg_rd, tcg_rn, cpu_env);
+            TCGv_i32 ahp = get_ahp_flag();
+            TCGv_ptr fpst = get_fpstatus_ptr(true);
+
+            gen_helper_vfp_fcvt_f32_to_f16(tcg_rd, tcg_rn, fpst, ahp);
             /* write_fp_sreg is OK here because top half of tcg_rd is zero */
             write_fp_sreg(s, rd, tcg_rd);
             tcg_temp_free_i32(tcg_rd);
+            tcg_temp_free_i32(ahp);
+            tcg_temp_free_ptr(fpst);
         }
         tcg_temp_free_i32(tcg_rn);
         break;
@@ -4846,9 +4851,13 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
             /* Double to single */
             gen_helper_vfp_fcvtsd(tcg_rd, tcg_rn, cpu_env);
         } else {
+            TCGv_ptr fpst = get_fpstatus_ptr(true);
+            TCGv_i32 ahp = get_ahp_flag();
             /* Double to half */
-            gen_helper_vfp_fcvt_f64_to_f16(tcg_rd, tcg_rn, cpu_env);
+            gen_helper_vfp_fcvt_f64_to_f16(tcg_rd, tcg_rn, fpst, ahp);
             /* write_fp_sreg is OK here because top half of tcg_rd is zero */
+            tcg_temp_free_ptr(fpst);
+            tcg_temp_free_i32(ahp);
         }
         write_fp_sreg(s, rd, tcg_rd);
         tcg_temp_free_i32(tcg_rd);
@@ -4858,17 +4867,21 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
     case 0x3:
     {
         TCGv_i32 tcg_rn = read_fp_sreg(s, rn);
+        TCGv_ptr tcg_fpst = get_fpstatus_ptr(true);
+        TCGv_i32 tcg_ahp = get_ahp_flag();
         tcg_gen_ext16u_i32(tcg_rn, tcg_rn);
         if (dtype == 0) {
             /* Half to single */
             TCGv_i32 tcg_rd = tcg_temp_new_i32();
-            gen_helper_vfp_fcvt_f16_to_f32(tcg_rd, tcg_rn, cpu_env);
+            gen_helper_vfp_fcvt_f16_to_f32(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
             write_fp_sreg(s, rd, tcg_rd);
+            tcg_temp_free_ptr(tcg_fpst);
+            tcg_temp_free_i32(tcg_ahp);
             tcg_temp_free_i32(tcg_rd);
         } else {
             /* Half to double */
             TCGv_i64 tcg_rd = tcg_temp_new_i64();
-            gen_helper_vfp_fcvt_f16_to_f64(tcg_rd, tcg_rn, cpu_env);
+            gen_helper_vfp_fcvt_f16_to_f64(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
             write_fp_dreg(s, rd, tcg_rd);
             tcg_temp_free_i64(tcg_rd);
         }
@@ -8487,12 +8500,17 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
             } else {
                 TCGv_i32 tcg_lo = tcg_temp_new_i32();
                 TCGv_i32 tcg_hi = tcg_temp_new_i32();
+                TCGv_ptr fpst = get_fpstatus_ptr(true);
+                TCGv_i32 ahp = get_ahp_flag();
+
                 tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, tcg_op);
-                gen_helper_vfp_fcvt_f32_to_f16(tcg_lo, tcg_lo, cpu_env);
-                gen_helper_vfp_fcvt_f32_to_f16(tcg_hi, tcg_hi, cpu_env);
+                gen_helper_vfp_fcvt_f32_to_f16(tcg_lo, tcg_lo, fpst, ahp);
+                gen_helper_vfp_fcvt_f32_to_f16(tcg_hi, tcg_hi, fpst, ahp);
                 tcg_gen_deposit_i32(tcg_res[pass], tcg_lo, tcg_hi, 16, 16);
                 tcg_temp_free_i32(tcg_lo);
                 tcg_temp_free_i32(tcg_hi);
+                tcg_temp_free_ptr(fpst);
+                tcg_temp_free_i32(ahp);
             }
             break;
         case 0x56:  /* FCVTXN, FCVTXN2 */
@@ -10987,18 +11005,24 @@ static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
         /* 16 -> 32 bit fp conversion */
         int srcelt = is_q ? 4 : 0;
         TCGv_i32 tcg_res[4];
+        TCGv_ptr fpst = get_fpstatus_ptr(true);
+        TCGv_i32 ahp = get_ahp_flag();
+
 
         for (pass = 0; pass < 4; pass++) {
             tcg_res[pass] = tcg_temp_new_i32();
 
             read_vec_element_i32(s, tcg_res[pass], rn, srcelt + pass, MO_16);
             gen_helper_vfp_fcvt_f16_to_f32(tcg_res[pass], tcg_res[pass],
-                                           cpu_env);
+                                           fpst, ahp);
         }
         for (pass = 0; pass < 4; pass++) {
             write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_32);
             tcg_temp_free_i32(tcg_res[pass]);
         }
+
+        tcg_temp_free_ptr(fpst);
+        tcg_temp_free_i32(ahp);
     }
 }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ad208867a7..5eab9d585a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3824,53 +3824,75 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                         gen_vfp_sqrt(dp);
                         break;
                     case 4: /* vcvtb.f32.f16, vcvtb.f64.f16 */
+                    {
+                        TCGv_ptr fpst = get_fpstatus_ptr(false);
+                        TCGv_i32 ahp_mode = get_ahp_flag();
                         tmp = gen_vfp_mrs();
                         tcg_gen_ext16u_i32(tmp, tmp);
                         if (dp) {
                             gen_helper_vfp_fcvt_f16_to_f64(cpu_F0d, tmp,
-                                                           cpu_env);
+                                                           fpst, ahp_mode);
                         } else {
                             gen_helper_vfp_fcvt_f16_to_f32(cpu_F0s, tmp,
-                                                           cpu_env);
+                                                           fpst, ahp_mode);
                         }
+                        tcg_temp_free_i32(ahp_mode);
+                        tcg_temp_free_ptr(fpst);
                         tcg_temp_free_i32(tmp);
                         break;
+                    }
                     case 5: /* vcvtt.f32.f16, vcvtt.f64.f16 */
+                    {
+                        TCGv_ptr fpst = get_fpstatus_ptr(false);
+                        TCGv_i32 ahp = get_ahp_flag();
                         tmp = gen_vfp_mrs();
                         tcg_gen_shri_i32(tmp, tmp, 16);
                         if (dp) {
                             gen_helper_vfp_fcvt_f16_to_f64(cpu_F0d, tmp,
-                                                           cpu_env);
+                                                           fpst, ahp);
                         } else {
                             gen_helper_vfp_fcvt_f16_to_f32(cpu_F0s, tmp,
-                                                           cpu_env);
+                                                           fpst, ahp);
                         }
                         tcg_temp_free_i32(tmp);
+                        tcg_temp_free_i32(ahp);
+                        tcg_temp_free_ptr(fpst);
                         break;
+                    }
                     case 6: /* vcvtb.f16.f32, vcvtb.f16.f64 */
+                    {
+                        TCGv_ptr fpst = get_fpstatus_ptr(false);
+                        TCGv_i32 ahp = get_ahp_flag();
                         tmp = tcg_temp_new_i32();
+
                         if (dp) {
                             gen_helper_vfp_fcvt_f64_to_f16(tmp, cpu_F0d,
-                                                           cpu_env);
+                                                           fpst, ahp);
                         } else {
                             gen_helper_vfp_fcvt_f32_to_f16(tmp, cpu_F0s,
-                                                           cpu_env);
+                                                           fpst, ahp);
                         }
                         gen_mov_F0_vreg(0, rd);
                         tmp2 = gen_vfp_mrs();
                         tcg_gen_andi_i32(tmp2, tmp2, 0xffff0000);
                         tcg_gen_or_i32(tmp, tmp, tmp2);
                         tcg_temp_free_i32(tmp2);
+                        tcg_temp_free_i32(ahp);
+                        tcg_temp_free_ptr(fpst);
                         gen_vfp_msr(tmp);
                         break;
+                    }
                     case 7: /* vcvtt.f16.f32, vcvtt.f16.f64 */
+                    {
+                        TCGv_ptr fpst = get_fpstatus_ptr(true);
+                        TCGv_i32 ahp = get_ahp_flag();
                         tmp = tcg_temp_new_i32();
                         if (dp) {
                             gen_helper_vfp_fcvt_f64_to_f16(tmp, cpu_F0d,
-                                                           cpu_env);
+                                                           fpst, ahp);
                         } else {
                             gen_helper_vfp_fcvt_f32_to_f16(tmp, cpu_F0s,
-                                                           cpu_env);
+                                                           fpst, ahp);
                         }
                         tcg_gen_shli_i32(tmp, tmp, 16);
                         gen_mov_F0_vreg(0, rd);
@@ -3880,6 +3902,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                         tcg_temp_free_i32(tmp2);
                         gen_vfp_msr(tmp);
                         break;
+                    }
                     case 8: /* cmp */
                         gen_vfp_cmp(dp);
                         break;
@@ -7222,53 +7245,68 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     break;
                 case NEON_2RM_VCVT_F16_F32:
+                {
+                    TCGv_ptr fpst;
+                    TCGv_i32 ahp;
+
                     if (!arm_dc_feature(s, ARM_FEATURE_VFP_FP16) ||
                         q || (rm & 1)) {
                         return 1;
                     }
                     tmp = tcg_temp_new_i32();
                     tmp2 = tcg_temp_new_i32();
+                    fpst = get_fpstatus_ptr(true);
+                    ahp = get_ahp_flag();
                     tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 0));
-                    gen_helper_neon_fcvt_f32_to_f16(tmp, cpu_F0s, cpu_env);
+                    gen_helper_neon_fcvt_f32_to_f16(tmp, cpu_F0s, fpst, ahp);
                     tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 1));
-                    gen_helper_neon_fcvt_f32_to_f16(tmp2, cpu_F0s, cpu_env);
+                    gen_helper_neon_fcvt_f32_to_f16(tmp2, cpu_F0s, fpst, ahp);
                     tcg_gen_shli_i32(tmp2, tmp2, 16);
                     tcg_gen_or_i32(tmp2, tmp2, tmp);
                     tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 2));
-                    gen_helper_neon_fcvt_f32_to_f16(tmp, cpu_F0s, cpu_env);
+                    gen_helper_neon_fcvt_f32_to_f16(tmp, cpu_F0s, fpst, ahp);
                     tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 3));
                     neon_store_reg(rd, 0, tmp2);
                     tmp2 = tcg_temp_new_i32();
-                    gen_helper_neon_fcvt_f32_to_f16(tmp2, cpu_F0s, cpu_env);
+                    gen_helper_neon_fcvt_f32_to_f16(tmp2, cpu_F0s, fpst, ahp);
                     tcg_gen_shli_i32(tmp2, tmp2, 16);
                     tcg_gen_or_i32(tmp2, tmp2, tmp);
                     neon_store_reg(rd, 1, tmp2);
                     tcg_temp_free_i32(tmp);
+                    tcg_temp_free_i32(ahp);
+                    tcg_temp_free_ptr(fpst);
                     break;
+                }
                 case NEON_2RM_VCVT_F32_F16:
+                {
+                    TCGv_ptr fpst;
+                    TCGv_i32 ahp;
                     if (!arm_dc_feature(s, ARM_FEATURE_VFP_FP16) ||
                         q || (rd & 1)) {
                         return 1;
                     }
+                    fpst = get_fpstatus_ptr(true);
+                    ahp = get_ahp_flag();
                     tmp3 = tcg_temp_new_i32();
                     tmp = neon_load_reg(rm, 0);
                     tmp2 = neon_load_reg(rm, 1);
                     tcg_gen_ext16u_i32(tmp3, tmp);
-                    gen_helper_neon_fcvt_f16_to_f32(cpu_F0s, tmp3, cpu_env);
+                    gen_helper_neon_fcvt_f16_to_f32(cpu_F0s, tmp3, fpst, ahp);
                     tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, 0));
                     tcg_gen_shri_i32(tmp3, tmp, 16);
-                    gen_helper_neon_fcvt_f16_to_f32(cpu_F0s, tmp3, cpu_env);
+                    gen_helper_neon_fcvt_f16_to_f32(cpu_F0s, tmp3, fpst, ahp);
                     tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, 1));
                     tcg_temp_free_i32(tmp);
                     tcg_gen_ext16u_i32(tmp3, tmp2);
-                    gen_helper_neon_fcvt_f16_to_f32(cpu_F0s, tmp3, cpu_env);
+                    gen_helper_neon_fcvt_f16_to_f32(cpu_F0s, tmp3, fpst, ahp);
                     tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, 2));
                     tcg_gen_shri_i32(tmp3, tmp2, 16);
-                    gen_helper_neon_fcvt_f16_to_f32(cpu_F0s, tmp3, cpu_env);
+                    gen_helper_neon_fcvt_f16_to_f32(cpu_F0s, tmp3, fpst, ahp);
                     tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, 3));
                     tcg_temp_free_i32(tmp2);
                     tcg_temp_free_i32(tmp3);
                     break;
+                }
                 case NEON_2RM_AESE: case NEON_2RM_AESMC:
                     if (!arm_dc_feature(s, ARM_FEATURE_V8_AES)
                         || ((rm | rd) & 1)) {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 4428c98e2e..41d0b8cd9a 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -177,4 +177,19 @@ void arm_free_cc(DisasCompare *cmp);
 void arm_jump_cc(DisasCompare *cmp, TCGLabel *label);
 void arm_gen_test_cc(int cc, TCGLabel *label);
 
+/* Return state of Alternate Half-precision flag, caller frees result */
+static inline TCGv_i32 get_ahp_flag(void)
+{
+    TCGv_i32 fpscr = tcg_temp_new_i32();
+    TCGv_i32 ahp_mode = tcg_temp_new_i32();
+
+    tcg_gen_ld_i32(fpscr, cpu_env, offsetof(CPUARMState,
+                                            vfp.xregs[ARM_VFP_FPSCR]));
+    tcg_gen_extract_i32(ahp_mode, fpscr, 26, 1);
+
+    tcg_temp_free_i32(fpscr);
+
+    return ahp_mode;
+}
+
 #endif /* TARGET_ARM_TRANSLATE_H */
-- 
2.17.0
