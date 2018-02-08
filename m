Received: from eggs.gnu.org ([2001:4830:134:3::10]:54157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3L-0003Hk-7J
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3J-0006V2-Fe
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:07 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:40756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejq3J-0006TJ-5l
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:05 -0500
Received: by mail-wr0-x243.google.com with SMTP id o76so2442999wrb.7
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:32:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:31 +0000
Message-Id: <20180208173157.24705-7-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/32] target/arm/helper: pass explicit fpst
 to set_rmode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

As the rounding mode is now split between FP16 and the rest of
floating point we need to be explicit when tweaking it. Instead of
passing the CPU env we now pass the appropriate fpst pointer directly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c        |  4 ++--
 target/arm/helper.h        |  2 +-
 target/arm/translate-a64.c | 26 +++++++++++++-------------
 target/arm/translate.c     | 12 ++++++------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1cc3d43a9f..72522c125c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10974,9 +10974,9 @@ VFP_CONV_FIX_A64(uq, s, 32, 64, uint64)
 /* Set the current fp rounding mode and return the old one.
  * The argument is a softfloat float_round_ value.
  */
-uint32_t HELPER(set_rmode)(uint32_t rmode, CPUARMState *env)
+uint32_t HELPER(set_rmode)(uint32_t rmode, void *fpstp)
 {
-    float_status *fp_status = &env->vfp.fp_status;
+    float_status *fp_status = fpstp;
 
     uint32_t prev_rmode = get_float_rounding_mode(fp_status);
     set_float_rounding_mode(rmode, fp_status);
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 5dec2e6262..40dcd74cfd 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -167,7 +167,7 @@ DEF_HELPER_3(vfp_uhtod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_ultod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_uqtod, f64, i64, i32, ptr)
 
-DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, env)
+DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, ptr)
 DEF_HELPER_FLAGS_2(set_neon_rmode, TCG_CALL_NO_RWG, i32, i32, env)
 
 DEF_HELPER_2(vfp_fcvt_f16_to_f32, f32, i32, env)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1afa669e6e..531ac5999c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4540,10 +4540,10 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     {
         TCGv_i32 tcg_rmode = tcg_const_i32(arm_rmode_to_sf(opcode & 7));
 
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
         gen_helper_rints(tcg_res, tcg_op, fpst);
 
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
         tcg_temp_free_i32(tcg_rmode);
         break;
     }
@@ -4596,10 +4596,10 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     {
         TCGv_i32 tcg_rmode = tcg_const_i32(arm_rmode_to_sf(opcode & 7));
 
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
         gen_helper_rintd(tcg_res, tcg_op, fpst);
 
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
         tcg_temp_free_i32(tcg_rmode);
         break;
     }
@@ -5126,7 +5126,7 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
 
         tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
 
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
 
         if (is_double) {
             TCGv_i64 tcg_double = read_fp_dreg(s, rn);
@@ -5173,7 +5173,7 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
             tcg_temp_free_i32(tcg_single);
         }
 
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
         tcg_temp_free_i32(tcg_rmode);
 
         if (!sf) {
@@ -6946,8 +6946,8 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
     assert(!(is_scalar && is_q));
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(FPROUNDING_ZERO));
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
     tcg_fpstatus = get_fpstatus_ptr(false);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
     tcg_shift = tcg_const_i32(fracbits);
 
     if (is_double) {
@@ -6993,7 +6993,7 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
 
     tcg_temp_free_ptr(tcg_fpstatus);
     tcg_temp_free_i32(tcg_shift);
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
     tcg_temp_free_i32(tcg_rmode);
 }
 
@@ -8262,8 +8262,8 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
 
     if (is_fcvt) {
         tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
         tcg_fpstatus = get_fpstatus_ptr(false);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
     } else {
         tcg_rmode = NULL;
         tcg_fpstatus = NULL;
@@ -8328,7 +8328,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 
     if (is_fcvt) {
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
         tcg_temp_free_i32(tcg_rmode);
         tcg_temp_free_ptr(tcg_fpstatus);
     }
@@ -10249,14 +10249,14 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         return;
     }
 
-    if (need_fpstatus) {
+    if (need_fpstatus || need_rmode) {
         tcg_fpstatus = get_fpstatus_ptr(false);
     } else {
         tcg_fpstatus = NULL;
     }
     if (need_rmode) {
         tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
     } else {
         tcg_rmode = NULL;
     }
@@ -10485,7 +10485,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 
     if (need_rmode) {
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
         tcg_temp_free_i32(tcg_rmode);
     }
     if (need_fpstatus) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 55826b7e5a..9aee67f067 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3144,7 +3144,7 @@ static int handle_vrint(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
     TCGv_i32 tcg_rmode;
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
 
     if (dp) {
         TCGv_i64 tcg_op;
@@ -3168,7 +3168,7 @@ static int handle_vrint(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
         tcg_temp_free_i32(tcg_res);
     }
 
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
     tcg_temp_free_i32(tcg_rmode);
 
     tcg_temp_free_ptr(fpst);
@@ -3185,7 +3185,7 @@ static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
     tcg_shift = tcg_const_i32(0);
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
 
     if (dp) {
         TCGv_i64 tcg_double, tcg_res;
@@ -3223,7 +3223,7 @@ static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
         tcg_temp_free_i32(tcg_single);
     }
 
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
     tcg_temp_free_i32(tcg_rmode);
 
     tcg_temp_free_i32(tcg_shift);
@@ -3893,13 +3893,13 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                         TCGv_ptr fpst = get_fpstatus_ptr(0);
                         TCGv_i32 tcg_rmode;
                         tcg_rmode = tcg_const_i32(float_round_to_zero);
-                        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+                        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
                         if (dp) {
                             gen_helper_rintd(cpu_F0d, cpu_F0d, fpst);
                         } else {
                             gen_helper_rints(cpu_F0s, cpu_F0s, fpst);
                         }
-                        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+                        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
                         tcg_temp_free_i32(tcg_rmode);
                         tcg_temp_free_ptr(fpst);
                         break;
-- 
2.15.1
