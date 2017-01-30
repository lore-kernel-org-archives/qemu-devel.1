Received: from eggs.gnu.org ([2001:4830:134:3::10]:51359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWY-0003NX-BS
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWU-0002Nv-87
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:54 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:54641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cYGWT-0002NR-S0
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:50 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:16:33 +0100
Message-Id: <20170130181634.13934-16-laurent@vivier.eu>
In-Reply-To: <20170130181634.13934-1-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 15/16] target-m68k: add more FPU instructions
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
fcos.

As softfloat library does not provide these functions,
we us the libm of the host.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 237 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.h     |  16 ++++
 target/m68k/translate.c  |  48 ++++++++++
 3 files changed, 301 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index c69efe1..95d5cc4 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include <math.h>
 
 static const floatx80 fpu_rom[128] = {
     [0x00] = floatx80_pi,                                   /* Pi */
@@ -712,3 +713,239 @@ void HELPER(mod_FP0_FP1)(CPUM68KState *env)
 
     floatx80_to_FP0(env, res);
 }
+
+static long double floatx80_to_ldouble(floatx80 val)
+{
+    if (floatx80_is_infinity(val)) {
+            if (floatx80_is_neg(val)) {
+                    return -__builtin_infl();
+            }
+            return __builtin_infl();
+    }
+    if (floatx80_is_any_nan(val)) {
+            char low[20];
+            sprintf(low, "0x%016"PRIx64, val.low);
+
+            return nanl(low);
+    }
+
+    return *(long double *)&val;
+}
+
+static floatx80 ldouble_to_floatx80(long double val)
+{
+    floatx80 res;
+
+    if (isinf(val)) {
+            res.high = floatx80_default_nan(NULL).high;
+            res.low = 0;
+    }
+    if (isinf(val) < 0) {
+            res.high |= 0x8000;
+    }
+    if (isnan(val)) {
+            res.high = floatx80_default_nan(NULL).high;
+            res.low = *(uint64_t *)((char *)&val + 4);
+    }
+    return *(floatx80 *)&val;
+}
+
+void HELPER(sinh_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val;
+
+    val = sinhl(floatx80_to_ldouble(FP0_to_floatx80(env)));
+    res = ldouble_to_floatx80(val);
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(lognp1_FP0)(CPUM68KState *env)
+{
+    floatx80 val;
+    long double res;
+
+    val = FP0_to_floatx80(env);
+    res = logl(floatx80_to_ldouble(val) + 1.0);
+
+    floatx80_to_FP0(env, ldouble_to_floatx80(res));
+}
+
+void HELPER(ln_FP0)(CPUM68KState *env)
+{
+    floatx80 val;
+    long double res;
+
+    val = FP0_to_floatx80(env);
+    res = logl(floatx80_to_ldouble(val));
+
+    floatx80_to_FP0(env, ldouble_to_floatx80(res));
+}
+
+void HELPER(log10_FP0)(CPUM68KState *env)
+{
+    floatx80 val;
+    long double res;
+
+    val = FP0_to_floatx80(env);
+    res = log10l(floatx80_to_ldouble(val));
+
+    floatx80_to_FP0(env, ldouble_to_floatx80(res));
+}
+
+void HELPER(atan_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val;
+
+    val = floatx80_to_ldouble(FP0_to_floatx80(env));
+
+    val = atanl(val);
+    res = ldouble_to_floatx80(val);
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(asin_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val;
+
+    val = floatx80_to_ldouble(FP0_to_floatx80(env));
+    if (val < -1.0 || val > 1.0) {
+        floatx80_to_FP0(env, floatx80_default_nan(NULL));
+        return;
+    }
+
+    val = asinl(val);
+    res = ldouble_to_floatx80(val);
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(atanh_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val;
+
+    val = floatx80_to_ldouble(FP0_to_floatx80(env));
+    if (val < -1.0 || val > 1.0) {
+        floatx80_to_FP0(env, floatx80_default_nan(NULL));
+        return;
+    }
+
+    val = atanhl(val);
+    res = ldouble_to_floatx80(val);
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(sin_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val;
+
+    val = floatx80_to_ldouble(FP0_to_floatx80(env));
+
+    val = sinl(val);
+    res = ldouble_to_floatx80(val);
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(tanh_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val;
+
+    val = floatx80_to_ldouble(FP0_to_floatx80(env));
+
+    val = tanhl(val);
+    res = ldouble_to_floatx80(val);
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(tan_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val;
+
+    val = floatx80_to_ldouble(FP0_to_floatx80(env));
+
+    val = tanl(val);
+    res = ldouble_to_floatx80(val);
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(exp_FP0)(CPUM68KState *env)
+{
+    floatx80 f;
+    long double res;
+
+    f = FP0_to_floatx80(env);
+
+    res = expl(floatx80_to_ldouble(f));
+
+    floatx80_to_FP0(env, ldouble_to_floatx80(res));
+}
+
+void HELPER(exp2_FP0)(CPUM68KState *env)
+{
+    floatx80 f;
+    long double res;
+
+    f = FP0_to_floatx80(env);
+
+    res = exp2l(floatx80_to_ldouble(f));
+
+    floatx80_to_FP0(env, ldouble_to_floatx80(res));
+}
+
+void HELPER(exp10_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val;
+
+    val = floatx80_to_ldouble(FP0_to_floatx80(env));
+
+    val = exp10l(val);
+    res = ldouble_to_floatx80(val);
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(cosh_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val;
+
+    val = floatx80_to_ldouble(FP0_to_floatx80(env));
+
+    val = coshl(val);
+    res = ldouble_to_floatx80(val);
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(acos_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val;
+
+    val = floatx80_to_ldouble(FP0_to_floatx80(env));
+    if (val < -1.0 || val > 1.0) {
+        floatx80_to_FP0(env, floatx80_default_nan(NULL));
+        return;
+    }
+
+    val = acosl(val);
+    res = ldouble_to_floatx80(val);
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(cos_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val;
+
+    val = floatx80_to_ldouble(FP0_to_floatx80(env));
+
+    val = cosl(val);
+    res = ldouble_to_floatx80(val);
+    floatx80_to_FP0(env, res);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 07aa04f..600a9a6 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -53,6 +53,22 @@ DEF_HELPER_1(getexp_FP0, void, env)
 DEF_HELPER_1(getman_FP0, void, env)
 DEF_HELPER_1(scale_FP0_FP1, void, env)
 DEF_HELPER_1(mod_FP0_FP1, void, env)
+DEF_HELPER_1(sinh_FP0, void, env)
+DEF_HELPER_1(lognp1_FP0, void, env)
+DEF_HELPER_1(atan_FP0, void, env)
+DEF_HELPER_1(asin_FP0, void, env)
+DEF_HELPER_1(atanh_FP0, void, env)
+DEF_HELPER_1(sin_FP0, void, env)
+DEF_HELPER_1(tanh_FP0, void, env)
+DEF_HELPER_1(tan_FP0, void, env)
+DEF_HELPER_1(exp_FP0, void, env)
+DEF_HELPER_1(exp2_FP0, void, env)
+DEF_HELPER_1(exp10_FP0, void, env)
+DEF_HELPER_1(ln_FP0, void, env)
+DEF_HELPER_1(log10_FP0, void, env)
+DEF_HELPER_1(cosh_FP0, void, env)
+DEF_HELPER_1(acos_FP0, void, env)
+DEF_HELPER_1(cos_FP0, void, env)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f238d30..4af6a98 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4625,6 +4625,9 @@ DISAS_INSN(fpu)
     case 1: /* fint */
         gen_helper_iround_FP0(cpu_env);
         break;
+    case 2: /* fsinh */
+        gen_helper_sinh_FP0(cpu_env);
+        break;
     case 3: /* fintrz */
         gen_helper_itrunc_FP0(cpu_env);
         break;
@@ -4637,6 +4640,42 @@ DISAS_INSN(fpu)
     case 0x45: /* fdsqrt */
         gen_helper_dsqrt_FP0(cpu_env);
         break;
+    case 0x06: /* flognp1 */
+        gen_helper_lognp1_FP0(cpu_env);
+        break;
+    case 0x09: /* ftanh */
+        gen_helper_tanh_FP0(cpu_env);
+        break;
+    case 0x0a: /* fatan */
+        gen_helper_atan_FP0(cpu_env);
+        break;
+    case 0x0c: /* fasin */
+        gen_helper_asin_FP0(cpu_env);
+        break;
+    case 0x0d: /* fatanh */
+        gen_helper_atanh_FP0(cpu_env);
+        break;
+    case 0x0e: /* fsin */
+        gen_helper_sin_FP0(cpu_env);
+        break;
+    case 0x0f: /* ftan */
+        gen_helper_tan_FP0(cpu_env);
+        break;
+    case 0x10: /* fetox */
+        gen_helper_exp_FP0(cpu_env);
+        break;
+    case 0x11: /* ftwotox */
+        gen_helper_exp2_FP0(cpu_env);
+        break;
+    case 0x12: /* ftentox */
+        gen_helper_exp10_FP0(cpu_env);
+        break;
+    case 0x14: /* flogn */
+        gen_helper_ln_FP0(cpu_env);
+        break;
+    case 0x15: /* flog10 */
+        gen_helper_log10_FP0(cpu_env);
+        break;
     case 0x18: /* fabs */
         gen_helper_abs_FP0(cpu_env);
         break;
@@ -4646,6 +4685,9 @@ DISAS_INSN(fpu)
     case 0x5c: /* fdabs */
         gen_helper_dabs_FP0(cpu_env);
         break;
+    case 0x19: /* fcosh */
+        gen_helper_cosh_FP0(cpu_env);
+        break;
     case 0x1a: /* fneg */
         gen_helper_neg_FP0(cpu_env);
         break;
@@ -4655,6 +4697,12 @@ DISAS_INSN(fpu)
     case 0x5e: /* fdneg */
         gen_helper_dneg_FP0(cpu_env);
         break;
+    case 0x1c: /* facos */
+        gen_helper_acos_FP0(cpu_env);
+        break;
+    case 0x1d: /* fcos */
+        gen_helper_cos_FP0(cpu_env);
+        break;
     case 0x1e: /* fgetexp */
         gen_helper_getexp_FP0(cpu_env);
         break;
-- 
2.9.3
