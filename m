Received: from eggs.gnu.org ([2001:4830:134:3::10]:33810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJv-0003j8-Gm
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJq-000853-Vn
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:19 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJq-00084T-MC
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:14 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJp-0000a7-Dg
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:13 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:34 +0000
Message-Id: <20180301112403.12487-14-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/42] target/arm/helper: pass explicit fpst to
 set_rmode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

As the rounding mode is now split between FP16 and the rest of
floating point we need to be explicit when tweaking it. Instead of
passing the CPU env we now pass the appropriate fpst pointer directly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-6-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        |  2 +-
 target/arm/helper.c        |  4 ++--
 target/arm/translate-a64.c | 26 +++++++++++++-------------
 target/arm/translate.c     | 12 ++++++------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 6383d7d09e..81ecb319b3 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -167,7 +167,7 @@ DEF_HELPER_3(vfp_uhtod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_ultod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_uqtod, f64, i64, i32, ptr)
 
-DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, env)
+DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, ptr)
 DEF_HELPER_FLAGS_2(set_neon_rmode, TCG_CALL_NO_RWG, i32, i32, env)
 
 DEF_HELPER_2(vfp_fcvt_f16_to_f32, f32, i32, env)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f450eb200f..303cd1eaf9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11393,9 +11393,9 @@ VFP_CONV_FIX_A64(uq, s, 32, 64, uint64)
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
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2c64d2b3fe..91c2b8ed11 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4628,10 +4628,10 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
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
@@ -4687,10 +4687,10 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
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
@@ -5217,7 +5217,7 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
 
         tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
 
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
 
         if (is_double) {
             TCGv_i64 tcg_double = read_fp_dreg(s, rn);
@@ -5264,7 +5264,7 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
             tcg_temp_free_i32(tcg_single);
         }
 
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
         tcg_temp_free_i32(tcg_rmode);
 
         if (!sf) {
@@ -6984,8 +6984,8 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
     assert(!(is_scalar && is_q));
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(FPROUNDING_ZERO));
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
     tcg_fpstatus = get_fpstatus_ptr(false);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
     tcg_shift = tcg_const_i32(fracbits);
 
     if (is_double) {
@@ -7029,7 +7029,7 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
 
     tcg_temp_free_ptr(tcg_fpstatus);
     tcg_temp_free_i32(tcg_shift);
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
     tcg_temp_free_i32(tcg_rmode);
 }
 
@@ -8300,8 +8300,8 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
 
     if (is_fcvt) {
         tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
         tcg_fpstatus = get_fpstatus_ptr(false);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
     } else {
         tcg_rmode = NULL;
         tcg_fpstatus = NULL;
@@ -8366,7 +8366,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 
     if (is_fcvt) {
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
         tcg_temp_free_i32(tcg_rmode);
         tcg_temp_free_ptr(tcg_fpstatus);
     }
@@ -10680,14 +10680,14 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -10929,7 +10929,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     clear_vec_high(s, is_q, rd);
 
     if (need_rmode) {
-        gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
         tcg_temp_free_i32(tcg_rmode);
     }
     if (need_fpstatus) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1270022289..aa6dcaa577 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3143,7 +3143,7 @@ static int handle_vrint(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
     TCGv_i32 tcg_rmode;
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
 
     if (dp) {
         TCGv_i64 tcg_op;
@@ -3167,7 +3167,7 @@ static int handle_vrint(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
         tcg_temp_free_i32(tcg_res);
     }
 
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
     tcg_temp_free_i32(tcg_rmode);
 
     tcg_temp_free_ptr(fpst);
@@ -3184,7 +3184,7 @@ static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
     tcg_shift = tcg_const_i32(0);
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rounding));
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
 
     if (dp) {
         TCGv_i64 tcg_double, tcg_res;
@@ -3222,7 +3222,7 @@ static int handle_vcvt(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
         tcg_temp_free_i32(tcg_single);
     }
 
-    gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
     tcg_temp_free_i32(tcg_rmode);
 
     tcg_temp_free_i32(tcg_shift);
@@ -3892,13 +3892,13 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
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
2.16.2
