Received: from eggs.gnu.org ([2001:4830:134:3::10]:48927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dS48s-0002mK-8u
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dS48n-0000z4-Hd
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:06 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dS48n-0000xT-2L
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:01 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  3 Jul 2017 18:23:26 +0200
Message-Id: <20170703162328.24474-3-laurent@vivier.eu>
In-Reply-To: <20170703162328.24474-1-laurent@vivier.eu>
References: <20170703162328.24474-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/4] target/m68k: add FPU trigonometric
 instructions
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

Add fsinh, flognp1, ftanh, fatan, fasin, fatanh,
fsin, ftan, fetox, ftwotox, ftentox, flogn, flog10, facos,
fcos, fsincos.

As softfloat library does not provide these functions,
we use the libm of the host.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h        |   1 +
 target/m68k/fpu_helper.c | 228 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.h     |  17 ++++
 target/m68k/translate.c  |  73 +++++++++++----
 4 files changed, 304 insertions(+), 15 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 38a7e11..f8f4dd5 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -173,6 +173,7 @@ uint32_t cpu_m68k_get_ccr(CPUM68KState *env);
 void cpu_m68k_set_ccr(CPUM68KState *env, uint32_t);
 void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val);
 
+long double floatx80_to_ldouble(floatx80 val);
 
 /* Instead of computing the condition codes after each m68k instruction,
  * QEMU just stores one operand (called CC_SRC), the result
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index bdfc537..2b07cb9 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include <math.h>
 
 /* Undefined offsets may be different on various FPU.
  * On 68040 they return 0.0 (floatx80_zero)
@@ -508,3 +509,230 @@ uint32_t HELPER(fmovemd_ld_postinc)(CPUM68KState *env, uint32_t addr,
 {
     return fmovem_postinc(env, addr, mask, cpu_ld_float64_ra);
 }
+
+long double floatx80_to_ldouble(floatx80 val)
+{
+    long double mantissa;
+    int32_t exp;
+    uint8_t sign;
+
+    if (floatx80_is_infinity(val)) {
+        if (floatx80_is_neg(val)) {
+            return -__builtin_infl();
+        }
+        return __builtin_infl();
+    }
+    if (floatx80_is_any_nan(val)) {
+        char low[20];
+        sprintf(low, "0x%016"PRIx64, val.low);
+        return nanl(low);
+    }
+
+    exp = (val.high & 0x7fff) - (0x3ffe + 64);
+    sign = val.high >> 15;
+    mantissa = (long double)val.low;
+    if (sign) {
+        mantissa = -mantissa;
+    }
+
+    return ldexpl(mantissa, exp);
+}
+
+static floatx80 ldouble_to_floatx80(long double val, float_status *status)
+{
+    floatx80 res;
+    long double mantissa;
+    int exp;
+
+    if (isinf(val)) {
+        res = floatx80_infinity;
+        if (isinf(val) < 0) {
+            res = floatx80_chs(res);
+        }
+        return res;
+    }
+    if (isnan(val)) {
+        res.high = floatx80_default_nan(NULL).high;
+        res.low = *(uint64_t *)&val; /* FIXME */
+        return res;
+    }
+
+    mantissa = frexpl(val, &exp);
+    res.high = exp + 0x3ffe;
+    if (mantissa < 0) {
+        res = floatx80_chs(res);
+        mantissa = -mantissa;
+    }
+    res.low = (uint64_t)ldexpl(mantissa, 64);
+
+    return floatx80_round(res, status);
+}
+
+void HELPER(fsinh)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = sinhl(floatx80_to_ldouble(val->d));
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(flognp1)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = logl(floatx80_to_ldouble(val->d) + 1.0);
+
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(fln)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = logl(floatx80_to_ldouble(val->d));
+
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(flog10)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = log10l(floatx80_to_ldouble(val->d));
+
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(fatan)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = atanl(floatx80_to_ldouble(val->d));
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(fasin)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = floatx80_to_ldouble(val->d);
+    if (d < -1.0 || d > 1.0) {
+        res->d = floatx80_default_nan(NULL);
+        return;
+    }
+
+    res->d = ldouble_to_floatx80(asinl(d), &env->fp_status);
+}
+
+void HELPER(fatanh)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = floatx80_to_ldouble(val->d);
+    if (d < -1.0 || d > 1.0) {
+        res->d = floatx80_default_nan(NULL);
+        return;
+    }
+
+    d = atanhl(d);
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(fsin)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = sinl(floatx80_to_ldouble(val->d));
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(ftanh)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = tanhl(floatx80_to_ldouble(val->d));
+
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(ftan)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = tanl(floatx80_to_ldouble(val->d));
+
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(fexp)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = expl(floatx80_to_ldouble(val->d));
+
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(fexp2)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = exp2l(floatx80_to_ldouble(val->d));
+
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(fexp10)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = exp10l(floatx80_to_ldouble(val->d));
+
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(fcosh)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = coshl(floatx80_to_ldouble(val->d));
+
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(facos)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = floatx80_to_ldouble(val->d);
+    if (d < -1.0 || d > 1.0) {
+        res->d = floatx80_default_nan(NULL);
+        return;
+    }
+
+    d = acosl(d);
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(fcos)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    long double d;
+
+    d = cosl(floatx80_to_ldouble(val->d));
+
+    res->d = ldouble_to_floatx80(d, &env->fp_status);
+}
+
+void HELPER(fsincos)(CPUM68KState *env, FPReg *res0, FPReg *res1, FPReg *val)
+{
+    long double dsin, dcos;
+
+    sincosl(floatx80_to_ldouble(val->d), &dsin, &dcos);
+
+    /* If res0 and res1 specify the same floating-point data register,
+     * the sine result is stored in the register, and the cosine
+     * result is discarded.
+     */
+    res1->d = ldouble_to_floatx80(dcos, &env->fp_status);
+    res0->d = ldouble_to_floatx80(dsin, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 475a1f2..302b6c0 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -60,6 +60,23 @@ DEF_HELPER_3(fmovemx_ld_postinc, i32, env, i32, i32)
 DEF_HELPER_3(fmovemd_st_predec, i32, env, i32, i32)
 DEF_HELPER_3(fmovemd_st_postinc, i32, env, i32, i32)
 DEF_HELPER_3(fmovemd_ld_postinc, i32, env, i32, i32)
+DEF_HELPER_3(fsinh, void, env, fp, fp)
+DEF_HELPER_3(flognp1, void, env, fp, fp)
+DEF_HELPER_3(fatan, void, env, fp, fp)
+DEF_HELPER_3(fasin, void, env, fp, fp)
+DEF_HELPER_3(fatanh, void, env, fp, fp)
+DEF_HELPER_3(fsin, void, env, fp, fp)
+DEF_HELPER_3(ftanh, void, env, fp, fp)
+DEF_HELPER_3(ftan, void, env, fp, fp)
+DEF_HELPER_3(fexp, void, env, fp, fp)
+DEF_HELPER_3(fexp2, void, env, fp, fp)
+DEF_HELPER_3(fexp10, void, env, fp, fp)
+DEF_HELPER_3(fln, void, env, fp, fp)
+DEF_HELPER_3(flog10, void, env, fp, fp)
+DEF_HELPER_3(fcosh, void, env, fp, fp)
+DEF_HELPER_3(facos, void, env, fp, fp)
+DEF_HELPER_3(fcos, void, env, fp, fp)
+DEF_HELPER_4(fsincos, void, env, fp, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 3a519b7..8a712b3 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4640,6 +4640,9 @@ DISAS_INSN(fpu)
     case 1: /* fint */
         gen_helper_firound(cpu_env, cpu_dest, cpu_src);
         break;
+    case 2: /* fsinh */
+        gen_helper_fsinh(cpu_env, cpu_dest, cpu_src);
+        break;
     case 3: /* fintrz */
         gen_helper_fitrunc(cpu_env, cpu_dest, cpu_src);
         break;
@@ -4652,6 +4655,42 @@ DISAS_INSN(fpu)
     case 0x45: /* fdsqrt */
         gen_helper_fdsqrt(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x06: /* flognp1 */
+        gen_helper_flognp1(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x09: /* ftanh */
+        gen_helper_ftanh(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x0a: /* fatan */
+        gen_helper_fatan(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x0c: /* fasin */
+        gen_helper_fasin(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x0d: /* fatanh */
+        gen_helper_fatanh(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x0e: /* fsin */
+        gen_helper_fsin(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x0f: /* ftan */
+        gen_helper_ftan(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x10: /* fetox */
+        gen_helper_fexp(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x11: /* ftwotox */
+        gen_helper_fexp2(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x12: /* ftentox */
+        gen_helper_fexp10(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x14: /* flogn */
+        gen_helper_fln(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x15: /* flog10 */
+        gen_helper_flog10(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x18: /* fabs */
         gen_helper_fabs(cpu_env, cpu_dest, cpu_src);
         break;
@@ -4661,6 +4700,9 @@ DISAS_INSN(fpu)
     case 0x5c: /* fdabs */
         gen_helper_fdabs(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x19: /* fcosh */
+        gen_helper_fcosh(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x1a: /* fneg */
         gen_helper_fneg(cpu_env, cpu_dest, cpu_src);
         break;
@@ -4670,6 +4712,12 @@ DISAS_INSN(fpu)
     case 0x5e: /* fdneg */
         gen_helper_fdneg(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x1c: /* facos */
+        gen_helper_facos(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x1d: /* fcos */
+        gen_helper_fcos(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x20: /* fdiv */
         gen_helper_fdiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
@@ -4712,6 +4760,14 @@ DISAS_INSN(fpu)
     case 0x6c: /* fdsub */
         gen_helper_fdsub(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
+    case 0x30: case 0x31: case 0x32:
+    case 0x33: case 0x34: case 0x35:
+    case 0x36: case 0x37: {
+            TCGv_ptr cpu_dest2 = gen_fp_ptr(REG(ext, 0));
+            gen_helper_fsincos(cpu_env, cpu_dest, cpu_dest2, cpu_src);
+            tcg_temp_free_ptr(cpu_dest2);
+        }
+        break;
     case 0x38: /* fcmp */
         gen_helper_fcmp(cpu_env, cpu_src, cpu_dest);
         return;
@@ -5626,18 +5682,6 @@ void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
     tb->icount = num_insns;
 }
 
-static double floatx80_to_double(CPUM68KState *env, uint16_t high, uint64_t low)
-{
-    floatx80 a = { .high = high, .low = low };
-    union {
-        float64 f64;
-        double d;
-    } u;
-
-    u.f64 = floatx80_to_float64(a, &env->fp_status);
-    return u.d;
-}
-
 void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                          int flags)
 {
@@ -5647,11 +5691,10 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     uint16_t sr;
     for (i = 0; i < 8; i++) {
         cpu_fprintf(f, "D%d = %08x   A%d = %08x   "
-                    "F%d = %04x %016"PRIx64"  (%12g)\n",
+                    "F%d = %04x %016"PRIx64"  (%12Lg)\n",
                     i, env->dregs[i], i, env->aregs[i],
                     i, env->fregs[i].l.upper, env->fregs[i].l.lower,
-                    floatx80_to_double(env, env->fregs[i].l.upper,
-                                       env->fregs[i].l.lower));
+                    floatx80_to_ldouble(env->fregs[i].d));
     }
     cpu_fprintf (f, "PC = %08x   ", env->pc);
     sr = env->sr | cpu_m68k_get_ccr(env);
-- 
2.9.4
