Received: from eggs.gnu.org ([2001:4830:134:3::10]:51342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWW-0003Lc-CC
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWR-0002M9-Nt
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:52 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:50728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cYGWR-0002Kh-3v
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:47 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:16:23 +0100
Message-Id: <20170130181634.13934-6-laurent@vivier.eu>
In-Reply-To: <20170130181634.13934-1-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 05/16] target-m68k: use floatx80 internally
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

Coldfire uses float64, but 680x0 use floatx80.
This patch introduces the use of floatx80 internally
and enables 680x0 80bits FPU.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.c        |  13 +-
 target/m68k/cpu.h        |  10 +-
 target/m68k/fpu_helper.c | 202 +++++++++++++---
 target/m68k/helper.c     |  12 +-
 target/m68k/helper.h     |  32 +--
 target/m68k/qregs.def    |   3 +-
 target/m68k/translate.c  | 615 +++++++++++++++++++++++++++++++----------------
 7 files changed, 615 insertions(+), 272 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index fa10b6e..cedc272 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -49,6 +49,8 @@ static void m68k_cpu_reset(CPUState *s)
     M68kCPU *cpu = M68K_CPU(s);
     M68kCPUClass *mcc = M68K_CPU_GET_CLASS(cpu);
     CPUM68KState *env = &cpu->env;
+    floatx80 nan = floatx80_default_nan(NULL);
+    int i;
 
     mcc->parent_reset(s);
 
@@ -57,7 +59,16 @@ static void m68k_cpu_reset(CPUState *s)
     env->sr = 0x2700;
 #endif
     m68k_switch_sp(env);
-    /* ??? FP regs should be initialized to NaN.  */
+    for (i = 0; i < 8; i++) {
+        env->fregs[i].d = nan;
+    }
+    env->fp0h = nan.high;
+    env->fp0l = nan.low;
+    env->fp1h = nan.high;
+    env->fp1l = nan.low;
+    env->fpcr = 0;
+    env->fpsr = 0;
+
     cpu_m68k_set_ccr(env, 0);
     /* TODO: We should set PC from the interrupt vector.  */
     env->pc = 0;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 8095822..192a877 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -64,6 +64,8 @@
 #define NB_MMU_MODES 2
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
+typedef CPU_LDoubleU FPReg;
+
 typedef struct CPUM68KState {
     uint32_t dregs[8];
     uint32_t aregs[8];
@@ -82,12 +84,16 @@ typedef struct CPUM68KState {
     uint32_t cc_c; /* either 0/1, unused, or computed from cc_n and cc_v */
     uint32_t cc_z; /* == 0 or unused */
 
-    float64 fregs[8];
-    float64 fp_result;
+    FPReg fregs[8];
     uint32_t fpcr;
     uint32_t fpsr;
     float_status fp_status;
 
+    uint32_t fp0h;
+    uint64_t fp0l;
+    uint32_t fp1h;
+    uint64_t fp1l;
+
     uint64_t mactmp;
     /* EMAC Hardware deals with 48-bit values composed of one 32-bit and
        two 8-bit parts.  We store a single 64-bit value and
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 5bf2576..9260e7b 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (c) 2006-2007 CodeSourcery
  *  Written by Paul Brook
+ *  Copyright (c) 2011-2016 Laurent Vivier
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -21,92 +22,215 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "exec/exec-all.h"
 
-uint32_t HELPER(f64_to_i32)(CPUM68KState *env, float64 val)
+static floatx80 FP0_to_floatx80(CPUM68KState *env)
 {
-    return float64_to_int32(val, &env->fp_status);
+    return (floatx80){ .low = env->fp0l, .high = env->fp0h };
 }
 
-float32 HELPER(f64_to_f32)(CPUM68KState *env, float64 val)
+static void floatx80_to_FP0(CPUM68KState *env, floatx80 res)
 {
-    return float64_to_float32(val, &env->fp_status);
+    env->fp0l = res.low;
+    env->fp0h = res.high;
 }
 
-float64 HELPER(i32_to_f64)(CPUM68KState *env, uint32_t val)
+static int32_t FP0_to_int32(CPUM68KState *env)
 {
-    return int32_to_float64(val, &env->fp_status);
+    return env->fp0h;
 }
 
-float64 HELPER(f32_to_f64)(CPUM68KState *env, float32 val)
+static void int32_to_FP0(CPUM68KState *env, int32_t val)
 {
-    return float32_to_float64(val, &env->fp_status);
+    env->fp0h = val;
 }
 
-float64 HELPER(iround_f64)(CPUM68KState *env, float64 val)
+static float32 FP0_to_float32(CPUM68KState *env)
 {
-    return float64_round_to_int(val, &env->fp_status);
+    return *(float32 *)&env->fp0h;
 }
 
-float64 HELPER(itrunc_f64)(CPUM68KState *env, float64 val)
+static void float32_to_FP0(CPUM68KState *env, float32 val)
 {
-    return float64_trunc_to_int(val, &env->fp_status);
+    env->fp0h = *(uint32_t *)&val;
 }
 
-float64 HELPER(sqrt_f64)(CPUM68KState *env, float64 val)
+static float64 FP0_to_float64(CPUM68KState *env)
 {
-    return float64_sqrt(val, &env->fp_status);
+    return *(float64 *)&env->fp0l;
+}
+static void float64_to_FP0(CPUM68KState *env, float64 val)
+{
+    env->fp0l = *(uint64_t *)&val;
 }
 
-float64 HELPER(abs_f64)(float64 val)
+static floatx80 FP1_to_floatx80(CPUM68KState *env)
 {
-    return float64_abs(val);
+    return (floatx80){ .low = env->fp1l, .high = env->fp1h };
 }
 
-float64 HELPER(chs_f64)(float64 val)
+void HELPER(exts32_FP0)(CPUM68KState *env)
 {
-    return float64_chs(val);
+    floatx80 res;
+
+    res = int32_to_floatx80(FP0_to_int32(env), &env->fp_status);
+
+    floatx80_to_FP0(env, res);
 }
 
-float64 HELPER(add_f64)(CPUM68KState *env, float64 a, float64 b)
+void HELPER(extf32_FP0)(CPUM68KState *env)
 {
-    return float64_add(a, b, &env->fp_status);
+    floatx80 res;
+
+    res = float32_to_floatx80(FP0_to_float32(env), &env->fp_status);
+
+    floatx80_to_FP0(env, res);
 }
 
-float64 HELPER(sub_f64)(CPUM68KState *env, float64 a, float64 b)
+void HELPER(extf64_FP0)(CPUM68KState *env)
 {
-    return float64_sub(a, b, &env->fp_status);
+    floatx80 res;
+
+    res = float64_to_floatx80(FP0_to_float64(env), &env->fp_status);
+
+    floatx80_to_FP0(env, res);
 }
 
-float64 HELPER(mul_f64)(CPUM68KState *env, float64 a, float64 b)
+void HELPER(reds32_FP0)(CPUM68KState *env)
 {
-    return float64_mul(a, b, &env->fp_status);
+    int32_t res;
+
+    res = floatx80_to_int32(FP0_to_floatx80(env), &env->fp_status);
+
+    int32_to_FP0(env, res);
 }
 
-float64 HELPER(div_f64)(CPUM68KState *env, float64 a, float64 b)
+void HELPER(redf32_FP0)(CPUM68KState *env)
 {
-    return float64_div(a, b, &env->fp_status);
+    float32 res;
+
+    res = floatx80_to_float32(FP0_to_floatx80(env), &env->fp_status);
+
+    float32_to_FP0(env, res);
 }
 
-float64 HELPER(sub_cmp_f64)(CPUM68KState *env, float64 a, float64 b)
+void HELPER(redf64_FP0)(CPUM68KState *env)
 {
-    /* ??? This may incorrectly raise exceptions.  */
-    /* ??? Should flush denormals to zero.  */
     float64 res;
-    res = float64_sub(a, b, &env->fp_status);
-    if (float64_is_quiet_nan(res, &env->fp_status)) {
+
+    res = floatx80_to_float64(FP0_to_floatx80(env), &env->fp_status);
+
+    float64_to_FP0(env, res);
+}
+
+void HELPER(iround_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    res = floatx80_round_to_int(FP0_to_floatx80(env), &env->fp_status);
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(itrunc_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    res = floatx80_round_to_int(FP0_to_floatx80(env), &env->fp_status);
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(sqrt_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    res = floatx80_sqrt(FP0_to_floatx80(env), &env->fp_status);
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(abs_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    res = floatx80_abs(FP0_to_floatx80(env));
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(chs_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    res = floatx80_chs(FP0_to_floatx80(env));
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(add_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    res = floatx80_add(FP0_to_floatx80(env), FP1_to_floatx80(env),
+                      &env->fp_status);
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(sub_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    res = floatx80_sub(FP1_to_floatx80(env), FP0_to_floatx80(env),
+                       &env->fp_status);
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(mul_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    res = floatx80_mul(FP0_to_floatx80(env), FP1_to_floatx80(env),
+                       &env->fp_status);
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(div_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+
+    res = floatx80_div(FP1_to_floatx80(env), FP0_to_floatx80(env),
+                       &env->fp_status);
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(cmp_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 fp0 = FP0_to_floatx80(env);
+    floatx80 fp1 = FP1_to_floatx80(env);
+    floatx80 res;
+
+    res = floatx80_sub(fp0, fp1, &env->fp_status);
+    if (floatx80_is_quiet_nan(res, &env->fp_status)) {
         /* +/-inf compares equal against itself, but sub returns nan.  */
-        if (!float64_is_quiet_nan(a, &env->fp_status)
-            && !float64_is_quiet_nan(b, &env->fp_status)) {
-            res = float64_zero;
-            if (float64_lt_quiet(a, res, &env->fp_status)) {
-                res = float64_chs(res);
+        if (!floatx80_is_quiet_nan(fp0, &env->fp_status)
+            && !floatx80_is_quiet_nan(fp1, &env->fp_status)) {
+            res = floatx80_zero;
+            if (floatx80_lt_quiet(fp0, res, &env->fp_status)) {
+                res = floatx80_chs(res);
             }
         }
     }
-    return res;
+
+    floatx80_to_FP0(env, res);
 }
 
-uint32_t HELPER(compare_f64)(CPUM68KState *env, float64 val)
+uint32_t HELPER(compare_FP0)(CPUM68KState *env)
 {
-    return float64_compare_quiet(val, float64_zero, &env->fp_status);
+    floatx80 fp0 = FP0_to_floatx80(env);
+    return floatx80_compare_quiet(fp0, floatx80_zero, &env->fp_status);
 }
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 5ca9911..8bfc881 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -73,10 +73,11 @@ void m68k_cpu_list(FILE *f, fprintf_function cpu_fprintf)
     g_slist_free(list);
 }
 
-static int fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
+static int cf_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 {
     if (n < 8) {
-        stfq_p(mem_buf, env->fregs[n]);
+        float_status s;
+        stfq_p(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
         return 8;
     }
     if (n < 11) {
@@ -87,10 +88,11 @@ static int fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
+static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 {
     if (n < 8) {
-        env->fregs[n] = ldfq_p(mem_buf);
+        float_status s;
+        env->fregs[n].d = float64_to_floatx80(ldfq_p(mem_buf), &s);
         return 8;
     }
     if (n < 11) {
@@ -126,7 +128,7 @@ void m68k_cpu_init_gdb(M68kCPU *cpu)
     CPUM68KState *env = &cpu->env;
 
     if (m68k_feature(env, M68K_FEATURE_CF_FPU)) {
-        gdb_register_coprocessor(cs, fpu_gdb_get_reg, fpu_gdb_set_reg,
+        gdb_register_coprocessor(cs, cf_fpu_gdb_get_reg, cf_fpu_gdb_set_reg,
                                  11, "cf-fp.xml", 18);
     }
     /* TODO: Add [E]MAC registers.  */
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index d7a4bf1..d52689b 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -12,21 +12,23 @@ DEF_HELPER_3(movec, void, env, i32, i32)
 DEF_HELPER_4(cas2w, void, env, i32, i32, i32)
 DEF_HELPER_4(cas2l, void, env, i32, i32, i32)
 
-DEF_HELPER_2(f64_to_i32, f32, env, f64)
-DEF_HELPER_2(f64_to_f32, f32, env, f64)
-DEF_HELPER_2(i32_to_f64, f64, env, i32)
-DEF_HELPER_2(f32_to_f64, f64, env, f32)
-DEF_HELPER_2(iround_f64, f64, env, f64)
-DEF_HELPER_2(itrunc_f64, f64, env, f64)
-DEF_HELPER_2(sqrt_f64, f64, env, f64)
-DEF_HELPER_1(abs_f64, f64, f64)
-DEF_HELPER_1(chs_f64, f64, f64)
-DEF_HELPER_3(add_f64, f64, env, f64, f64)
-DEF_HELPER_3(sub_f64, f64, env, f64, f64)
-DEF_HELPER_3(mul_f64, f64, env, f64, f64)
-DEF_HELPER_3(div_f64, f64, env, f64, f64)
-DEF_HELPER_3(sub_cmp_f64, f64, env, f64, f64)
-DEF_HELPER_2(compare_f64, i32, env, f64)
+DEF_HELPER_1(exts32_FP0, void, env)
+DEF_HELPER_1(extf32_FP0, void, env)
+DEF_HELPER_1(extf64_FP0, void, env)
+DEF_HELPER_1(redf32_FP0, void, env)
+DEF_HELPER_1(redf64_FP0, void, env)
+DEF_HELPER_1(reds32_FP0, void, env)
+DEF_HELPER_1(iround_FP0, void, env)
+DEF_HELPER_1(itrunc_FP0, void, env)
+DEF_HELPER_1(sqrt_FP0, void, env)
+DEF_HELPER_1(abs_FP0, void, env)
+DEF_HELPER_1(chs_FP0, void, env)
+DEF_HELPER_1(add_FP0_FP1, void, env)
+DEF_HELPER_1(sub_FP0_FP1, void, env)
+DEF_HELPER_1(mul_FP0_FP1, void, env)
+DEF_HELPER_1(div_FP0_FP1, void, env)
+DEF_HELPER_1(cmp_FP0_FP1, void, env)
+DEF_HELPER_1(compare_FP0, i32, env)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/qregs.def b/target/m68k/qregs.def
index 51ff43b..b6441d9 100644
--- a/target/m68k/qregs.def
+++ b/target/m68k/qregs.def
@@ -1,4 +1,5 @@
-DEFF64(FP_RESULT, fp_result)
+DEFF96(FP0, fp0)
+DEFF96(FP1, fp1)
 DEFO32(PC, pc)
 DEFO32(SR, sr)
 DEFO32(CC_OP, cc_op)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d9ba735..5ca8a9e 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -32,37 +32,30 @@
 #include "trace-tcg.h"
 #include "exec/log.h"
 
-
 //#define DEBUG_DISPATCH 1
 
-/* Fake floating point.  */
-#define tcg_gen_mov_f64 tcg_gen_mov_i64
-#define tcg_gen_qemu_ldf64 tcg_gen_qemu_ld64
-#define tcg_gen_qemu_stf64 tcg_gen_qemu_st64
-
 #define DEFO32(name, offset) static TCGv QREG_##name;
 #define DEFO64(name, offset) static TCGv_i64 QREG_##name;
-#define DEFF64(name, offset) static TCGv_i64 QREG_##name;
+#define DEFF96(name, offset) static TCGv_i32 QREG_##name##H; \
+                             static TCGv_i64 QREG_##name##L;
 #include "qregs.def"
 #undef DEFO32
 #undef DEFO64
-#undef DEFF64
+#undef DEFF96
 
 static TCGv_i32 cpu_halted;
 static TCGv_i32 cpu_exception_index;
 
 static TCGv_env cpu_env;
 
-static char cpu_reg_names[3*8*3 + 5*4];
+static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
 static TCGv cpu_dregs[8];
 static TCGv cpu_aregs[8];
-static TCGv_i64 cpu_fregs[8];
 static TCGv_i64 cpu_macc[4];
 
 #define REG(insn, pos)  (((insn) >> (pos)) & 7)
 #define DREG(insn, pos) cpu_dregs[REG(insn, pos)]
 #define AREG(insn, pos) get_areg(s, REG(insn, pos))
-#define FREG(insn, pos) cpu_fregs[REG(insn, pos)]
 #define MACREG(acc)     cpu_macc[acc]
 #define QREG_SP         get_areg(s, 7)
 
@@ -87,11 +80,16 @@ void m68k_tcg_init(void)
 #define DEFO64(name, offset) \
     QREG_##name = tcg_global_mem_new_i64(cpu_env, \
         offsetof(CPUM68KState, offset), #name);
-#define DEFF64(name, offset) DEFO64(name, offset)
+#define DEFF96(name,  offset) do { \
+    QREG_##name##H = tcg_global_mem_new_i32(cpu_env,    \
+        offsetof(CPUM68KState, offset##h), #name); \
+    QREG_##name##L = tcg_global_mem_new_i64(cpu_env,    \
+        offsetof(CPUM68KState, offset##l), #name); \
+} while (0);
 #include "qregs.def"
 #undef DEFO32
 #undef DEFO64
-#undef DEFF64
+#undef DEFF96
 
     cpu_halted = tcg_global_mem_new_i32(cpu_env,
                                         -offsetof(M68kCPU, env) +
@@ -111,10 +109,6 @@ void m68k_tcg_init(void)
         cpu_aregs[i] = tcg_global_mem_new(cpu_env,
                                           offsetof(CPUM68KState, aregs[i]), p);
         p += 3;
-        sprintf(p, "F%d", i);
-        cpu_fregs[i] = tcg_global_mem_new_i64(cpu_env,
-                                          offsetof(CPUM68KState, fregs[i]), p);
-        p += 3;
     }
     for (i = 0; i < 4; i++) {
         sprintf(p, "ACC%d", i);
@@ -286,7 +280,6 @@ static inline TCGv gen_load(DisasContext * s, int opsize, TCGv addr, int sign)
             tcg_gen_qemu_ld16u(tmp, addr, index);
         break;
     case OS_LONG:
-    case OS_SINGLE:
         tcg_gen_qemu_ld32u(tmp, addr, index);
         break;
     default:
@@ -296,16 +289,6 @@ static inline TCGv gen_load(DisasContext * s, int opsize, TCGv addr, int sign)
     return tmp;
 }
 
-static inline TCGv_i64 gen_load64(DisasContext * s, TCGv addr)
-{
-    TCGv_i64 tmp;
-    int index = IS_USER(s);
-    tmp = tcg_temp_new_i64();
-    tcg_gen_qemu_ldf64(tmp, addr, index);
-    gen_throws_exception = gen_last_qop;
-    return tmp;
-}
-
 /* Generate a store.  */
 static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val)
 {
@@ -318,7 +301,6 @@ static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val)
         tcg_gen_qemu_st16(val, addr, index);
         break;
     case OS_LONG:
-    case OS_SINGLE:
         tcg_gen_qemu_st32(val, addr, index);
         break;
     default:
@@ -327,13 +309,6 @@ static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val)
     gen_throws_exception = gen_last_qop;
 }
 
-static inline void gen_store64(DisasContext *s, TCGv addr, TCGv_i64 val)
-{
-    int index = IS_USER(s);
-    tcg_gen_qemu_stf64(val, addr, index);
-    gen_throws_exception = gen_last_qop;
-}
-
 typedef enum {
     EA_STORE,
     EA_LOADU,
@@ -377,6 +352,15 @@ static inline uint32_t read_im32(CPUM68KState *env, DisasContext *s)
     return im;
 }
 
+/* Read a 64-bit immediate constant.  */
+static inline uint64_t read_im64(CPUM68KState *env, DisasContext *s)
+{
+    uint64_t im;
+    im = (uint64_t)read_im32(env, s) << 32;
+    im |= (uint64_t)read_im32(env, s);
+    return im;
+}
+
 /* Calculate and address index.  */
 static TCGv gen_addr_index(DisasContext *s, uint16_t ext, TCGv tmp)
 {
@@ -909,6 +893,291 @@ static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
     return gen_ea_mode(env, s, mode, reg0, opsize, val, addrp, what);
 }
 
+static void gen_op_load_fpr_FP0(int freg)
+{
+    tcg_gen_ld16u_i32(QREG_FP0H, cpu_env,
+                      offsetof(CPUM68KState, fregs[freg].l.upper));
+    tcg_gen_ld_i64(QREG_FP0L, cpu_env,
+                   offsetof(CPUM68KState, fregs[freg].l.lower));
+}
+
+static void gen_op_store_fpr_FP0(int freg)
+{
+    tcg_gen_st16_i32(QREG_FP0H, cpu_env,
+                     offsetof(CPUM68KState, fregs[freg].l.upper));
+    tcg_gen_st_i64(QREG_FP0L, cpu_env,
+                   offsetof(CPUM68KState, fregs[freg].l.lower));
+}
+
+static void gen_op_load_fpr_FP1(int freg)
+{
+    tcg_gen_ld16u_i32(QREG_FP1H, cpu_env,
+                      offsetof(CPUM68KState, fregs[freg].l.upper));
+    tcg_gen_ld_i64(QREG_FP1L, cpu_env,
+                   offsetof(CPUM68KState, fregs[freg].l.lower));
+}
+
+static void gen_extend_FP0(int opsize)
+{
+    switch (opsize) {
+    case OS_BYTE:
+        tcg_gen_ext8s_i32(QREG_FP0H, QREG_FP0H);
+        gen_helper_exts32_FP0(cpu_env);
+        break;
+    case OS_WORD:
+        tcg_gen_ext16s_i32(QREG_FP0H, QREG_FP0H);
+        gen_helper_exts32_FP0(cpu_env);
+        break;
+    case OS_LONG:
+        gen_helper_exts32_FP0(cpu_env);
+        break;
+    case OS_SINGLE:
+        gen_helper_extf32_FP0(cpu_env);
+        break;
+    case OS_DOUBLE:
+        gen_helper_extf64_FP0(cpu_env);
+        break;
+    case OS_EXTENDED:
+        tcg_gen_shri_i32(QREG_FP0H, QREG_FP0H, 16);
+        break;
+    case OS_PACKED:
+        /* nothing to do */
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void gen_reduce_FP0(int opsize)
+{
+    switch (opsize) {
+    case OS_BYTE:
+    case OS_WORD:
+    case OS_LONG:
+        gen_helper_reds32_FP0(cpu_env);
+        break;
+    case OS_SINGLE:
+        gen_helper_redf32_FP0(cpu_env);
+        break;
+    case OS_DOUBLE:
+        gen_helper_redf64_FP0(cpu_env);
+        break;
+    case OS_EXTENDED:
+        tcg_gen_shli_i32(QREG_FP0H, QREG_FP0H, 16);
+        break;
+    case OS_PACKED:
+        /* nothing to do */
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void gen_load_FP0(DisasContext *s, int opsize, TCGv addr)
+{
+    TCGv tmp;
+    int index = IS_USER(s);
+    switch (opsize) {
+    case OS_BYTE:
+        tcg_gen_qemu_ld8s(QREG_FP0H, addr, index);
+        gen_helper_exts32_FP0(cpu_env);
+        break;
+    case OS_WORD:
+        tcg_gen_qemu_ld16s(QREG_FP0H, addr, index);
+        gen_helper_exts32_FP0(cpu_env);
+        break;
+    case OS_LONG:
+        tcg_gen_qemu_ld32u(QREG_FP0H, addr, index);
+        gen_helper_exts32_FP0(cpu_env);
+        break;
+    case OS_SINGLE:
+        tcg_gen_qemu_ld32u(QREG_FP0H, addr, index);
+        gen_helper_extf32_FP0(cpu_env);
+        break;
+    case OS_DOUBLE:
+        tcg_gen_qemu_ld64(QREG_FP0L, addr, index);
+        gen_helper_extf64_FP0(cpu_env);
+        break;
+    case OS_EXTENDED:
+        tcg_gen_qemu_ld32u(QREG_FP0H, addr, index);
+        tcg_gen_shri_i32(QREG_FP0H, QREG_FP0H, 16);
+        tmp = tcg_temp_new();
+        tcg_gen_addi_i32(tmp, addr, 4);
+        tcg_gen_qemu_ld64(QREG_FP0L, tmp, index);
+        tcg_temp_free(tmp);
+        break;
+    case OS_PACKED:
+        tcg_gen_qemu_ld32u(QREG_FP0H, addr, index);
+        tmp = tcg_temp_new();
+        tcg_gen_addi_i32(tmp, addr, 4);
+        tcg_gen_qemu_ld64(QREG_FP0L, tmp, index);
+        tcg_temp_free(tmp);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    gen_throws_exception = gen_last_qop;
+}
+
+static void gen_store_FP0(DisasContext *s, int opsize, TCGv addr)
+{
+    TCGv tmp;
+    int index = IS_USER(s);
+    switch (opsize) {
+    case OS_BYTE:
+        gen_helper_reds32_FP0(cpu_env);
+        tcg_gen_qemu_st8(QREG_FP0H, addr, index);
+        break;
+    case OS_WORD:
+        gen_helper_reds32_FP0(cpu_env);
+        tcg_gen_qemu_st16(QREG_FP0H, addr, index);
+        break;
+    case OS_LONG:
+        gen_helper_reds32_FP0(cpu_env);
+        tcg_gen_qemu_st32(QREG_FP0H, addr, index);
+        break;
+    case OS_SINGLE:
+        gen_helper_redf32_FP0(cpu_env);
+        tcg_gen_qemu_st32(QREG_FP0H, addr, index);
+        break;
+    case OS_DOUBLE:
+        gen_helper_redf64_FP0(cpu_env);
+        tcg_gen_qemu_st64(QREG_FP0L, addr, index);
+        break;
+    case OS_EXTENDED:
+        tcg_gen_shli_i32(QREG_FP0H, QREG_FP0H, 16);
+        tcg_gen_qemu_st32(QREG_FP0H, addr, index);
+        tmp = tcg_temp_new();
+        tcg_gen_addi_i32(tmp, addr, 4);
+        tcg_gen_qemu_st64(QREG_FP0L, tmp, index);
+        tcg_temp_free(tmp);
+        break;
+    case OS_PACKED:
+        tcg_gen_qemu_st32(QREG_FP0H, addr, index);
+        tmp = tcg_temp_new();
+        tcg_gen_addi_i32(tmp, addr, 4);
+        tcg_gen_qemu_st64(QREG_FP0L, tmp, index);
+        tcg_temp_free(tmp);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    gen_throws_exception = gen_last_qop;
+}
+
+static void gen_ldst_FP0(DisasContext *s, int opsize, TCGv addr, ea_what what)
+{
+    if (what == EA_STORE) {
+        gen_store_FP0(s, opsize, addr);
+    } else {
+        gen_load_FP0(s, opsize, addr);
+    }
+}
+
+static int gen_ea_mode_FP0(CPUM68KState *env, DisasContext *s, int mode,
+                           int reg0, int opsize, ea_what what)
+{
+    TCGv reg, addr;
+    uint64_t val64;
+    uint32_t val32;
+
+    switch (mode) {
+    case 0: /* Data register direct.  */
+        reg = cpu_dregs[reg0];
+        if (what == EA_STORE) {
+            gen_reduce_FP0(opsize);
+            tcg_gen_mov_i32(reg, QREG_FP0H);
+            return 0;
+        } else {
+            tcg_gen_mov_i32(QREG_FP0H, reg);
+            gen_extend_FP0(opsize);
+            return 0;
+        }
+    case 1: /* Address register direct.  */
+        return -1;
+    case 2: /* Indirect register */
+        reg = get_areg(s, reg0);
+        gen_ldst_FP0(s, opsize, reg, what);
+        return 0;
+    case 3: /* Indirect postincrement.  */
+        reg = cpu_aregs[reg0];
+        gen_ldst_FP0(s, opsize, reg, what);
+        tcg_gen_addi_i32(reg, reg, opsize_bytes(opsize));
+        return 0;
+    case 4: /* Indirect predecrememnt.  */
+        addr = gen_lea_mode(env, s, mode, reg0, opsize);
+        if (IS_NULL_QREG(addr)) {
+            return -1;
+        }
+        gen_ldst_FP0(s, opsize, addr, what);
+        tcg_gen_mov_i32(cpu_aregs[reg0], addr);
+        return 0;
+    case 5: /* Indirect displacement.  */
+    case 6: /* Indirect index + displacement.  */
+    do_indirect:
+        addr = gen_lea_mode(env, s, mode, reg0, opsize);
+        if (IS_NULL_QREG(addr)) {
+            return -1;
+        }
+        gen_ldst_FP0(s, opsize, addr, what);
+        return 0;
+    case 7: /* Other */
+        switch (reg0) {
+        case 0: /* Absolute short.  */
+        case 1: /* Absolute long.  */
+        case 2: /* pc displacement  */
+        case 3: /* pc index+displacement.  */
+            goto do_indirect;
+        case 4: /* Immediate.  */
+            if (what == EA_STORE) {
+                return -1;
+            }
+            val32 = 0;
+            val64 = 0;
+            switch (opsize) {
+            case OS_BYTE:
+                val32 = read_im8(env, s);
+                break;
+            case OS_WORD:
+                val32 = read_im16(env, s);
+                break;
+            case OS_LONG:
+            case OS_SINGLE:
+                val32 = read_im32(env, s);
+                break;
+            case OS_DOUBLE:
+                val64 = read_im64(env, s);
+                break;
+            case OS_EXTENDED:
+                val32 = read_im32(env, s);
+                val64 = read_im64(env, s);
+                break;
+            case OS_PACKED:
+                val32 = read_im32(env, s);
+                val64 = read_im64(env, s);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            tcg_gen_movi_i32(QREG_FP0H, val32);
+            tcg_gen_movi_i64(QREG_FP0L, val64);
+            gen_extend_FP0(opsize);
+            return 0;
+        default:
+            return -1;
+        }
+    }
+    return -1;
+}
+
+static int gen_ea_FP0(CPUM68KState *env, DisasContext *s, uint16_t insn,
+                       int opsize, ea_what what)
+{
+    int mode = extract32(insn, 3, 3);
+    int reg0 = REG(insn, 0);
+    return gen_ea_mode_FP0(env, s, mode, reg0, opsize, what);
+}
+
 typedef struct {
     TCGCond tcond;
     bool g1;
@@ -4089,16 +4358,53 @@ DISAS_INSN(trap)
     gen_exception(s, s->pc - 2, EXCP_TRAP0 + (insn & 0xf));
 }
 
+static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
+                             uint32_t insn, uint32_t ext)
+{
+    int mask = (ext >> 10) & 7;
+    int is_write = (ext >> 13) & 1;
+    TCGv tmp;
+
+    tmp = gen_lea(env, s, insn, OS_LONG);
+    if (IS_NULL_QREG(tmp)) {
+        TCGv val;
+
+        if (is_write) {
+            switch (mask) {
+            case 1: /* FPIAR */
+            case 2: /* FPSR */
+            default:
+                cpu_abort(NULL, "Unimplemented: fmove from control %d", mask);
+                break;
+            case 4: /* FPCR */
+                val = tcg_const_i32(0);
+                DEST_EA(env, insn, OS_LONG, val, NULL);
+                tcg_temp_free(val);
+                break;
+            }
+            return;
+        }
+        switch (mask) {
+        case 1: /* FPIAR */
+        case 2: /* FPSR */
+        default:
+            cpu_abort(NULL, "Unimplemented: fmove to control %d",
+                      mask);
+            break;
+        case 4: /* FPCR */
+            /* Not implemented.  Ignore writes.  */
+            break;
+        }
+        return;
+    }
+}
+
 /* ??? FP exceptions are not implemented.  Most exceptions are deferred until
    immediately before the next FP instruction is executed.  */
 DISAS_INSN(fpu)
 {
     uint16_t ext;
-    int32_t offset;
     int opmode;
-    TCGv_i64 src;
-    TCGv_i64 dest;
-    TCGv_i64 res;
     TCGv tmp32;
     int round;
     int set_dest;
@@ -4112,87 +4418,17 @@ DISAS_INSN(fpu)
     case 1:
         goto undef;
     case 3: /* fmove out */
-        src = FREG(ext, 7);
-        tmp32 = tcg_temp_new_i32();
-        /* fmove */
-        /* ??? TODO: Proper behavior on overflow.  */
-
+        gen_op_load_fpr_FP0(REG(ext, 7));
         opsize = ext_opsize(ext, 10);
-        switch (opsize) {
-        case OS_LONG:
-            gen_helper_f64_to_i32(tmp32, cpu_env, src);
-            break;
-        case OS_SINGLE:
-            gen_helper_f64_to_f32(tmp32, cpu_env, src);
-            break;
-        case OS_WORD:
-            gen_helper_f64_to_i32(tmp32, cpu_env, src);
-            break;
-        case OS_DOUBLE:
-            tcg_gen_mov_i32(tmp32, AREG(insn, 0));
-            switch ((insn >> 3) & 7) {
-            case 2:
-            case 3:
-                break;
-            case 4:
-                tcg_gen_addi_i32(tmp32, tmp32, -8);
-                break;
-            case 5:
-                offset = cpu_ldsw_code(env, s->pc);
-                s->pc += 2;
-                tcg_gen_addi_i32(tmp32, tmp32, offset);
-                break;
-            default:
-                goto undef;
-            }
-            gen_store64(s, tmp32, src);
-            switch ((insn >> 3) & 7) {
-            case 3:
-                tcg_gen_addi_i32(tmp32, tmp32, 8);
-                tcg_gen_mov_i32(AREG(insn, 0), tmp32);
-                break;
-            case 4:
-                tcg_gen_mov_i32(AREG(insn, 0), tmp32);
-                break;
-            }
-            tcg_temp_free_i32(tmp32);
+        if (gen_ea_FP0(env, s, insn, opsize, EA_STORE) == -1) {
+            gen_addr_fault(s);
             return;
-        case OS_BYTE:
-            gen_helper_f64_to_i32(tmp32, cpu_env, src);
-            break;
-        default:
-            goto undef;
         }
-        DEST_EA(env, insn, opsize, tmp32, NULL);
-        tcg_temp_free_i32(tmp32);
         return;
     case 4: /* fmove to control register.  */
-        switch ((ext >> 10) & 7) {
-        case 4: /* FPCR */
-            /* Not implemented.  Ignore writes.  */
-            break;
-        case 1: /* FPIAR */
-        case 2: /* FPSR */
-        default:
-            cpu_abort(NULL, "Unimplemented: fmove to control %d",
-                      (ext >> 10) & 7);
-        }
-        break;
     case 5: /* fmove from control register.  */
-        switch ((ext >> 10) & 7) {
-        case 4: /* FPCR */
-            /* Not implemented.  Always return zero.  */
-            tmp32 = tcg_const_i32(0);
-            break;
-        case 1: /* FPIAR */
-        case 2: /* FPSR */
-        default:
-            cpu_abort(NULL, "Unimplemented: fmove from control %d",
-                      (ext >> 10) & 7);
-            goto undef;
-        }
-        DEST_EA(env, insn, OS_LONG, tmp32, NULL);
-        break;
+        gen_op_fmove_fcr(env, s, insn, ext);
+        return;
     case 6: /* fmovem */
     case 7:
         {
@@ -4211,14 +4447,9 @@ DISAS_INSN(fpu)
             mask = 0x80;
             for (i = 0; i < 8; i++) {
                 if (ext & mask) {
-                    dest = FREG(i, 0);
-                    if (ext & (1 << 13)) {
-                        /* store */
-                        tcg_gen_qemu_stf64(dest, addr, IS_USER(s));
-                    } else {
-                        /* load */
-                        tcg_gen_qemu_ldf64(dest, addr, IS_USER(s));
-                    }
+                    gen_op_load_fpr_FP0(REG(i, 0));
+                    gen_ldst_FP0(s, OS_DOUBLE, addr, (ext & (1 << 13)) ?
+                                                     EA_STORE : EA_LOADS);
                     if (ext & (mask - 1))
                         tcg_gen_addi_i32(addr, addr, 8);
                 }
@@ -4231,114 +4462,66 @@ DISAS_INSN(fpu)
     if (ext & (1 << 14)) {
         /* Source effective address.  */
         opsize = ext_opsize(ext, 10);
-        if (opsize == OS_DOUBLE) {
-            tmp32 = tcg_temp_new_i32();
-            tcg_gen_mov_i32(tmp32, AREG(insn, 0));
-            switch ((insn >> 3) & 7) {
-            case 2:
-            case 3:
-                break;
-            case 4:
-                tcg_gen_addi_i32(tmp32, tmp32, -8);
-                break;
-            case 5:
-                offset = cpu_ldsw_code(env, s->pc);
-                s->pc += 2;
-                tcg_gen_addi_i32(tmp32, tmp32, offset);
-                break;
-            case 7:
-                offset = cpu_ldsw_code(env, s->pc);
-                offset += s->pc - 2;
-                s->pc += 2;
-                tcg_gen_addi_i32(tmp32, tmp32, offset);
-                break;
-            default:
-                goto undef;
-            }
-            src = gen_load64(s, tmp32);
-            switch ((insn >> 3) & 7) {
-            case 3:
-                tcg_gen_addi_i32(tmp32, tmp32, 8);
-                tcg_gen_mov_i32(AREG(insn, 0), tmp32);
-                break;
-            case 4:
-                tcg_gen_mov_i32(AREG(insn, 0), tmp32);
-                break;
-            }
-            tcg_temp_free_i32(tmp32);
-        } else {
-            SRC_EA(env, tmp32, opsize, 1, NULL);
-            src = tcg_temp_new_i64();
-            switch (opsize) {
-            case OS_LONG:
-            case OS_WORD:
-            case OS_BYTE:
-                gen_helper_i32_to_f64(src, cpu_env, tmp32);
-                break;
-            case OS_SINGLE:
-                gen_helper_f32_to_f64(src, cpu_env, tmp32);
-                break;
-            }
+        if (gen_ea_FP0(env, s, insn, opsize, EA_LOADS) == -1) {
+            gen_addr_fault(s);
+            return;
         }
     } else {
         /* Source register.  */
-        src = FREG(ext, 10);
+        opsize = OS_EXTENDED;
+        gen_op_load_fpr_FP0(REG(ext, 10));
     }
-    dest = FREG(ext, 7);
-    res = tcg_temp_new_i64();
-    if (opmode != 0x3a)
-        tcg_gen_mov_f64(res, dest);
     round = 1;
     set_dest = 1;
     switch (opmode) {
     case 0: case 0x40: case 0x44: /* fmove */
-        tcg_gen_mov_f64(res, src);
         break;
     case 1: /* fint */
-        gen_helper_iround_f64(res, cpu_env, src);
+        gen_helper_iround_FP0(cpu_env);
         round = 0;
         break;
     case 3: /* fintrz */
-        gen_helper_itrunc_f64(res, cpu_env, src);
+        gen_helper_itrunc_FP0(cpu_env);
         round = 0;
         break;
     case 4: case 0x41: case 0x45: /* fsqrt */
-        gen_helper_sqrt_f64(res, cpu_env, src);
+        gen_helper_sqrt_FP0(cpu_env);
         break;
     case 0x18: case 0x58: case 0x5c: /* fabs */
-        gen_helper_abs_f64(res, src);
+        gen_helper_abs_FP0(cpu_env);
         break;
     case 0x1a: case 0x5a: case 0x5e: /* fneg */
-        gen_helper_chs_f64(res, src);
+        gen_helper_chs_FP0(cpu_env);
         break;
     case 0x20: case 0x60: case 0x64: /* fdiv */
-        gen_helper_div_f64(res, cpu_env, res, src);
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_div_FP0_FP1(cpu_env);
         break;
     case 0x22: case 0x62: case 0x66: /* fadd */
-        gen_helper_add_f64(res, cpu_env, res, src);
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_add_FP0_FP1(cpu_env);
         break;
     case 0x23: case 0x63: case 0x67: /* fmul */
-        gen_helper_mul_f64(res, cpu_env, res, src);
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_mul_FP0_FP1(cpu_env);
         break;
     case 0x28: case 0x68: case 0x6c: /* fsub */
-        gen_helper_sub_f64(res, cpu_env, res, src);
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_sub_FP0_FP1(cpu_env);
         break;
     case 0x38: /* fcmp */
-        gen_helper_sub_cmp_f64(res, cpu_env, res, src);
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_cmp_FP0_FP1(cpu_env);
         set_dest = 0;
         round = 0;
         break;
     case 0x3a: /* ftst */
-        tcg_gen_mov_f64(res, src);
         set_dest = 0;
         round = 0;
         break;
     default:
         goto undef;
     }
-    if (ext & (1 << 14)) {
-        tcg_temp_free_i64(src);
-    }
     if (round) {
         if (opmode & 0x40) {
             if ((opmode & 0x4) != 0)
@@ -4348,16 +4531,15 @@ DISAS_INSN(fpu)
         }
     }
     if (round) {
-        TCGv tmp = tcg_temp_new_i32();
-        gen_helper_f64_to_f32(tmp, cpu_env, res);
-        gen_helper_f32_to_f64(res, cpu_env, tmp);
-        tcg_temp_free_i32(tmp);
+        gen_helper_redf32_FP0(cpu_env);
+        gen_helper_extf32_FP0(cpu_env);
+    } else {
+        gen_helper_redf64_FP0(cpu_env);
+        gen_helper_extf64_FP0(cpu_env);
     }
-    tcg_gen_mov_f64(QREG_FP_RESULT, res);
     if (set_dest) {
-        tcg_gen_mov_f64(dest, res);
+        gen_op_store_fpr_FP0(REG(ext, 7));
     }
-    tcg_temp_free_i64(res);
     return;
 undef:
     /* FIXME: Is this right for offset addressing modes?  */
@@ -4382,10 +4564,10 @@ DISAS_INSN(fbcc)
     l1 = gen_new_label();
     /* TODO: Raise BSUN exception.  */
     flag = tcg_temp_new();
-    gen_helper_compare_f64(flag, cpu_env, QREG_FP_RESULT);
+    gen_helper_compare_FP0(flag, cpu_env);
     /* Jump to l1 if condition is true.  */
     switch (insn & 0xf) {
-    case 0: /* f */
+    case 0:  /* False */
         break;
     case 1: /* eq (=0) */
         tcg_gen_brcond_i32(TCG_COND_EQ, flag, tcg_const_i32(0), l1);
@@ -5011,11 +5193,15 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(bfop_reg, eec0, fff8, BITFIELD);   /* bfset */
     INSN(bfop_mem, e8c0, ffc0, BITFIELD);   /* bftst */
     INSN(bfop_reg, e8c0, fff8, BITFIELD);   /* bftst */
-    INSN(undef_fpu, f000, f000, CF_ISA_A);
+    BASE(undef_fpu, f000, f000);
     INSN(fpu,       f200, ffc0, CF_FPU);
     INSN(fbcc,      f280, ffc0, CF_FPU);
     INSN(frestore,  f340, ffc0, CF_FPU);
     INSN(fsave,     f340, ffc0, CF_FPU);
+    INSN(fpu,       f200, ffc0, FPU);
+    INSN(fbcc,      f280, ff80, FPU);
+    INSN(frestore,  f340, ffc0, FPU);
+    INSN(fsave,     f340, ffc0, FPU);
     INSN(intouch,   f340, ffc0, CF_ISA_A);
     INSN(cpushl,    f428, ff38, CF_ISA_A);
     INSN(wddata,    fb00, ff00, CF_ISA_A);
@@ -5141,6 +5327,18 @@ void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
     tb->icount = num_insns;
 }
 
+static double floatx80_to_double(CPUM68KState *env, uint16_t high, uint64_t low)
+{
+    floatx80 a = { .high = high, .low = low };
+    union {
+        float64 f64;
+        double d;
+    } u;
+
+    u.f64 = floatx80_to_float64(a, &env->fp_status);
+    return u.d;
+}
+
 void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                          int flags)
 {
@@ -5148,20 +5346,19 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     CPUM68KState *env = &cpu->env;
     int i;
     uint16_t sr;
-    CPU_DoubleU u;
-    for (i = 0; i < 8; i++)
-      {
-        u.d = env->fregs[i];
-        cpu_fprintf(f, "D%d = %08x   A%d = %08x   F%d = %08x%08x (%12g)\n",
+    for (i = 0; i < 8; i++) {
+        cpu_fprintf(f, "D%d = %08x   A%d = %08x   "
+                    "F%d = %04x %016"PRIx64"  (%12g)\n",
                     i, env->dregs[i], i, env->aregs[i],
-                    i, u.l.upper, u.l.lower, *(double *)&u.d);
-      }
+                    i, env->fregs[i].l.upper, env->fregs[i].l.lower,
+                    floatx80_to_double(env, env->fregs[i].l.upper,
+                                       env->fregs[i].l.lower));
+    }
     cpu_fprintf (f, "PC = %08x   ", env->pc);
     sr = env->sr | cpu_m68k_get_ccr(env);
     cpu_fprintf(f, "SR = %04x %c%c%c%c%c ", sr, (sr & CCF_X) ? 'X' : '-',
                 (sr & CCF_N) ? 'N' : '-', (sr & CCF_Z) ? 'Z' : '-',
                 (sr & CCF_V) ? 'V' : '-', (sr & CCF_C) ? 'C' : '-');
-    cpu_fprintf (f, "FPRESULT = %12g\n", *(double *)&env->fp_result);
 }
 
 void restore_state_to_opc(CPUM68KState *env, TranslationBlock *tb,
-- 
2.9.3
