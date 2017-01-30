Received: from eggs.gnu.org ([2001:4830:134:3::10]:51331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWV-0003La-L8
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWR-0002Lz-KR
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:51 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cYGWR-0002Kp-6T
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:47 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:16:32 +0100
Message-Id: <20170130181634.13934-15-laurent@vivier.eu>
In-Reply-To: <20170130181634.13934-1-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 14/16] target-m68k: add explicit single and
 double precision operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Add fssqrt, fdsqrt, fsabs, fdabs, fsneg, fdneg, fsadd, fdadd,
fssub, fdsub, fsmul, fdmul, fsdiv, fddiv, fsmove and fdmove.

The precision is managed using set_floatx80_rounding_precision(),
except for fsmove, fdmove, fsneg, fdneg, fsabs and fdabs:
the value is converted manually to the given precision and
converted back to floatx80.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 178 ++++++++++++++++++++++++++++++++++++++++++++++-
 target/m68k/helper.h     |  16 ++++-
 target/m68k/translate.c  |  76 +++++++++++++++++---
 3 files changed, 259 insertions(+), 11 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 8a3eed3..c69efe1 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -294,6 +294,16 @@ void HELPER(itrunc_FP0)(CPUM68KState *env)
     floatx80_to_FP0(env, res);
 }
 
+#define PREC_BEGIN(prec)                                        \
+    do {                                                        \
+        int old;                                                \
+        old = get_floatx80_rounding_precision(&env->fp_status); \
+        set_floatx80_rounding_precision(prec, &env->fp_status)  \
+
+#define PREC_END()                                              \
+        set_floatx80_rounding_precision(old, &env->fp_status);  \
+    } while (0)
+
 void HELPER(sqrt_FP0)(CPUM68KState *env)
 {
     floatx80 res;
@@ -303,6 +313,28 @@ void HELPER(sqrt_FP0)(CPUM68KState *env)
     floatx80_to_FP0(env, res);
 }
 
+void HELPER(ssqrt_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    PREC_BEGIN(32);
+    res = floatx80_sqrt(FP0_to_floatx80(env), &env->fp_status);
+    PREC_END();
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(dsqrt_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    PREC_BEGIN(64);
+    res = floatx80_sqrt(FP0_to_floatx80(env), &env->fp_status);
+    PREC_END();
+
+    floatx80_to_FP0(env, res);
+}
+
 void HELPER(abs_FP0)(CPUM68KState *env)
 {
     floatx80 res;
@@ -312,11 +344,59 @@ void HELPER(abs_FP0)(CPUM68KState *env)
     floatx80_to_FP0(env, res);
 }
 
-void HELPER(chs_FP0)(CPUM68KState *env)
+void HELPER(sabs_FP0)(CPUM68KState *env)
 {
     floatx80 res;
+    float32 f32;
+
+    res = floatx80_abs(FP0_to_floatx80(env));
+    f32 = floatx80_to_float32(res, &env->fp_status);
+    res = float32_to_floatx80(f32, &env->fp_status);
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(dabs_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    float64 f64;
+
+    res = floatx80_abs(FP0_to_floatx80(env));
+    f64 = floatx80_to_float64(res, &env->fp_status);
+    res = float64_to_floatx80(f64, &env->fp_status);
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(neg_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    res = floatx80_chs(FP0_to_floatx80(env));
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(sneg_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    float32 f32;
+
+    res = floatx80_chs(FP0_to_floatx80(env));
+    f32 = floatx80_to_float32(res, &env->fp_status);
+    res = float32_to_floatx80(f32, &env->fp_status);
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(dneg_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    float64 f64;
 
     res = floatx80_chs(FP0_to_floatx80(env));
+    f64 = floatx80_to_float64(res, &env->fp_status);
+    res = float64_to_floatx80(f64, &env->fp_status);
 
     floatx80_to_FP0(env, res);
 }
@@ -331,6 +411,30 @@ void HELPER(add_FP0_FP1)(CPUM68KState *env)
     floatx80_to_FP0(env, res);
 }
 
+void HELPER(sadd_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    PREC_BEGIN(32);
+    res = floatx80_add(FP0_to_floatx80(env), FP1_to_floatx80(env),
+                      &env->fp_status);
+    PREC_END();
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(dadd_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    PREC_BEGIN(64);
+    res = floatx80_add(FP0_to_floatx80(env), FP1_to_floatx80(env),
+                      &env->fp_status);
+    PREC_END();
+
+    floatx80_to_FP0(env, res);
+}
+
 void HELPER(sub_FP0_FP1)(CPUM68KState *env)
 {
     floatx80 res;
@@ -341,6 +445,30 @@ void HELPER(sub_FP0_FP1)(CPUM68KState *env)
     floatx80_to_FP0(env, res);
 }
 
+void HELPER(ssub_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    PREC_BEGIN(32);
+    res = floatx80_sub(FP1_to_floatx80(env), FP0_to_floatx80(env),
+                       &env->fp_status);
+    PREC_END();
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(dsub_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    PREC_BEGIN(64);
+    res = floatx80_sub(FP1_to_floatx80(env), FP0_to_floatx80(env),
+                       &env->fp_status);
+    PREC_END();
+
+    floatx80_to_FP0(env, res);
+}
+
 void HELPER(mul_FP0_FP1)(CPUM68KState *env)
 {
     floatx80 res;
@@ -351,6 +479,30 @@ void HELPER(mul_FP0_FP1)(CPUM68KState *env)
     floatx80_to_FP0(env, res);
 }
 
+void HELPER(smul_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    PREC_BEGIN(32);
+    res = floatx80_mul(FP0_to_floatx80(env), FP1_to_floatx80(env),
+                       &env->fp_status);
+    PREC_END();
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(dmul_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    PREC_BEGIN(64);
+    res = floatx80_mul(FP0_to_floatx80(env), FP1_to_floatx80(env),
+                       &env->fp_status);
+    PREC_END();
+
+    floatx80_to_FP0(env, res);
+}
+
 void HELPER(sglmul_FP0_FP1)(CPUM68KState *env)
 {
     float64 a, b, res;
@@ -372,6 +524,30 @@ void HELPER(div_FP0_FP1)(CPUM68KState *env)
     floatx80_to_FP0(env, res);
 }
 
+void HELPER(sdiv_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    PREC_BEGIN(32);
+    res = floatx80_div(FP1_to_floatx80(env), FP0_to_floatx80(env),
+                       &env->fp_status);
+    PREC_END();
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(ddiv_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    PREC_BEGIN(64);
+    res = floatx80_div(FP1_to_floatx80(env), FP0_to_floatx80(env),
+                       &env->fp_status);
+    PREC_END();
+
+    floatx80_to_FP0(env, res);
+}
+
 void HELPER(sgldiv_FP0_FP1)(CPUM68KState *env)
 {
     float64 a, b, res;
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index c30e5f7..07aa04f 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -21,13 +21,27 @@ DEF_HELPER_1(reds32_FP0, void, env)
 DEF_HELPER_1(iround_FP0, void, env)
 DEF_HELPER_1(itrunc_FP0, void, env)
 DEF_HELPER_1(sqrt_FP0, void, env)
+DEF_HELPER_1(ssqrt_FP0, void, env)
+DEF_HELPER_1(dsqrt_FP0, void, env)
 DEF_HELPER_1(abs_FP0, void, env)
-DEF_HELPER_1(chs_FP0, void, env)
+DEF_HELPER_1(sabs_FP0, void, env)
+DEF_HELPER_1(dabs_FP0, void, env)
+DEF_HELPER_1(neg_FP0, void, env)
+DEF_HELPER_1(sneg_FP0, void, env)
+DEF_HELPER_1(dneg_FP0, void, env)
 DEF_HELPER_1(add_FP0_FP1, void, env)
+DEF_HELPER_1(sadd_FP0_FP1, void, env)
+DEF_HELPER_1(dadd_FP0_FP1, void, env)
 DEF_HELPER_1(sub_FP0_FP1, void, env)
+DEF_HELPER_1(ssub_FP0_FP1, void, env)
+DEF_HELPER_1(dsub_FP0_FP1, void, env)
 DEF_HELPER_1(mul_FP0_FP1, void, env)
+DEF_HELPER_1(smul_FP0_FP1, void, env)
+DEF_HELPER_1(dmul_FP0_FP1, void, env)
 DEF_HELPER_1(sglmul_FP0_FP1, void, env)
 DEF_HELPER_1(div_FP0_FP1, void, env)
+DEF_HELPER_1(sdiv_FP0_FP1, void, env)
+DEF_HELPER_1(ddiv_FP0_FP1, void, env)
 DEF_HELPER_1(sgldiv_FP0_FP1, void, env)
 DEF_HELPER_1(cmp_FP0_FP1, void, env)
 DEF_HELPER_2(set_fpcr, void, env, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index cfdc858..f238d30 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4612,7 +4612,15 @@ DISAS_INSN(fpu)
         gen_op_load_fpr_FP0(REG(ext, 10));
     }
     switch (opmode) {
-    case 0: case 0x40: case 0x44: /* fmove */
+    case 0: /* fmove */
+        break;
+    case 0x40: /* fsmove */
+        gen_helper_redf32_FP0(cpu_env);
+        gen_helper_extf32_FP0(cpu_env);
+        break;
+    case 0x44: /* fdmove */
+        gen_helper_redf64_FP0(cpu_env);
+        gen_helper_extf64_FP0(cpu_env);
         break;
     case 1: /* fint */
         gen_helper_iround_FP0(cpu_env);
@@ -4620,14 +4628,32 @@ DISAS_INSN(fpu)
     case 3: /* fintrz */
         gen_helper_itrunc_FP0(cpu_env);
         break;
-    case 4: case 0x41: case 0x45: /* fsqrt */
+    case 4: /* fsqrt */
         gen_helper_sqrt_FP0(cpu_env);
         break;
-    case 0x18: case 0x58: case 0x5c: /* fabs */
+    case 0x41: /* fssqrt */
+        gen_helper_ssqrt_FP0(cpu_env);
+        break;
+    case 0x45: /* fdsqrt */
+        gen_helper_dsqrt_FP0(cpu_env);
+        break;
+    case 0x18: /* fabs */
         gen_helper_abs_FP0(cpu_env);
         break;
-    case 0x1a: case 0x5a: case 0x5e: /* fneg */
-        gen_helper_chs_FP0(cpu_env);
+    case 0x58: /* fsabs */
+        gen_helper_sabs_FP0(cpu_env);
+        break;
+    case 0x5c: /* fdabs */
+        gen_helper_dabs_FP0(cpu_env);
+        break;
+    case 0x1a: /* fneg */
+        gen_helper_neg_FP0(cpu_env);
+        break;
+    case 0x5a: /* fsneg */
+        gen_helper_sneg_FP0(cpu_env);
+        break;
+    case 0x5e: /* fdneg */
+        gen_helper_dneg_FP0(cpu_env);
         break;
     case 0x1e: /* fgetexp */
         gen_helper_getexp_FP0(cpu_env);
@@ -4635,22 +4661,46 @@ DISAS_INSN(fpu)
     case 0x1f: /* fgetman */
         gen_helper_getman_FP0(cpu_env);
         break;
-    case 0x20: case 0x60: case 0x64: /* fdiv */
+    case 0x20: /* fdiv */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_div_FP0_FP1(cpu_env);
         break;
+    case 0x60: /* fsdiv */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_sdiv_FP0_FP1(cpu_env);
+        break;
+    case 0x64: /* fddiv */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_ddiv_FP0_FP1(cpu_env);
+        break;
     case 0x21: /* fmod */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_mod_FP0_FP1(cpu_env);
         break;
-    case 0x22: case 0x62: case 0x66: /* fadd */
+    case 0x22: /* fadd */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_add_FP0_FP1(cpu_env);
         break;
-    case 0x23: case 0x63: case 0x67: /* fmul */
+    case 0x62: /* fsadd */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_sadd_FP0_FP1(cpu_env);
+        break;
+    case 0x66: /* fdadd */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_dadd_FP0_FP1(cpu_env);
+        break;
+    case 0x23: /* fmul */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_mul_FP0_FP1(cpu_env);
         break;
+    case 0x63: /* fsmul */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_smul_FP0_FP1(cpu_env);
+        break;
+    case 0x67: /* fdmul */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_dmul_FP0_FP1(cpu_env);
+        break;
     case 0x24: /* fsgldiv */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_sgldiv_FP0_FP1(cpu_env);
@@ -4663,10 +4713,18 @@ DISAS_INSN(fpu)
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_sglmul_FP0_FP1(cpu_env);
         break;
-    case 0x28: case 0x68: case 0x6c: /* fsub */
+    case 0x28: /* fsub */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_sub_FP0_FP1(cpu_env);
         break;
+    case 0x68: /* fssub */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_ssub_FP0_FP1(cpu_env);
+        break;
+    case 0x6c: /* fdsub */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_dsub_FP0_FP1(cpu_env);
+        break;
     case 0x38: /* fcmp */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_cmp_FP0_FP1(cpu_env);
-- 
2.9.3
