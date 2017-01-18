Received: from eggs.gnu.org ([2001:4830:134:3::10]:46540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTxQk-0002Vo-1f
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTxQg-00071e-06
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:06:05 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:62538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cTxQf-00070h-JF
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:06:01 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 18 Jan 2017 22:05:21 +0100
Message-Id: <1484773521-16530-8-git-send-email-laurent@vivier.eu>
In-Reply-To: <1484773521-16530-1-git-send-email-laurent@vivier.eu>
References: <1484773521-16530-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 7/7] target-m68k: implements more FPU
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

Add fmovecr, fsinh, flognp1, ftanh, fatan, fasin, fatanh,
fsin, ftan, fetox, ftwotox, ftentox, flogn, flog10, facos,
fcos, fgetexp, fgetman, fmod, fsgldiv, fscale, fsglmul, sin,
cos, frestore, fsave.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h        |   1 +
 target/m68k/fpu_helper.c | 348 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.h     |  22 +++
 target/m68k/translate.c  |  97 ++++++++++++-
 4 files changed, 467 insertions(+), 1 deletion(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index b2d06f5..e48fd24 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -250,6 +250,7 @@ typedef enum {
 /* Quotient */
 
 #define FPSR_QT_MASK  0x00ff0000
+#define FPSR_QT_SHIFT 16
 
 /* Floating-Point Control Register */
 /* Rounding mode */
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 126535f..3bb531b 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -25,6 +25,31 @@
 #include "exec/exec-all.h"
 #include <math.h>
 
+static const floatx80 fpu_rom[128] = {
+    [0x00] = floatx80_pi,                                   /* Pi */
+    [0x0b] = make_floatx80(0x3ffd, 0x9a209a84fbcff798ULL),  /* Log10(2) */
+    [0x0c] = make_floatx80(0x4000, 0xadf85458a2bb4a9aULL),  /* e        */
+    [0x0d] = make_floatx80(0x3fff, 0xb8aa3b295c17f0bcULL),  /* Log2(e)  */
+    [0x0e] = make_floatx80(0x3ffd, 0xde5bd8a937287195ULL),  /* Log10(e) */
+    [0x0f] = floatx80_zero,                                 /* Zero     */
+    [0x30] = floatx80_ln2,                                  /* ln(2)    */
+    [0x31] = make_floatx80(0x4000, 0x935d8dddaaa8ac17ULL),  /* ln(10)   */
+    [0x32] = floatx80_one,                                  /* 10^0     */
+    [0x33] = make_floatx80(0x4002, 0xa000000000000000ULL),  /* 10^1     */
+    [0x34] = make_floatx80(0x4005, 0xc800000000000000ULL),  /* 10^2     */
+    [0x35] = make_floatx80(0x400c, 0x9c40000000000000ULL),  /* 10^4     */
+    [0x36] = make_floatx80(0x4019, 0xbebc200000000000ULL),  /* 10^8     */
+    [0x37] = make_floatx80(0x4034, 0x8e1bc9bf04000000ULL),  /* 10^16    */
+    [0x38] = make_floatx80(0x4069, 0x9dc5ada82b70b59eULL),  /* 10^32    */
+    [0x39] = make_floatx80(0x40d3, 0xc2781f49ffcfa6d5ULL),  /* 10^64    */
+    [0x3a] = make_floatx80(0x41a8, 0x93ba47c980e98ce0ULL),  /* 10^128   */
+    [0x3b] = make_floatx80(0x4351, 0xaa7eebfb9df9de8eULL),  /* 10^256   */
+    [0x3c] = make_floatx80(0x46a3, 0xe319a0aea60e91c7ULL),  /* 10^512   */
+    [0x3d] = make_floatx80(0x4d48, 0xc976758681750c17ULL),  /* 10^1024  */
+    [0x3e] = make_floatx80(0x5a92, 0x9e8b3b5dc53d5de5ULL),  /* 10^2048  */
+    [0x3f] = make_floatx80(0x7525, 0xc46052028a20979bULL),  /* 10^4096  */
+};
+
 static floatx80 FP0_to_floatx80(CPUM68KState *env)
 {
     return (floatx80){ .low = env->fp0l, .high = env->fp0h };
@@ -70,6 +95,12 @@ static floatx80 FP1_to_floatx80(CPUM68KState *env)
     return (floatx80){ .low = env->fp1l, .high = env->fp1h };
 }
 
+static void floatx80_to_FP1(CPUM68KState *env, floatx80 res)
+{
+    env->fp1l = res.low;
+    env->fp1h = res.high;
+}
+
 void HELPER(exts32_FP0)(CPUM68KState *env)
 {
     floatx80 res;
@@ -415,3 +446,320 @@ void HELPER(fmovem)(CPUM68KState *env, uint32_t opsize,
 {
     fprintf(stderr, "MISSING HELPER fmovem\n");
 }
+
+void HELPER(const_FP0)(CPUM68KState *env, uint32_t offset)
+{
+    env->fp0l = fpu_rom[offset].low;
+    env->fp0h = fpu_rom[offset].high;
+}
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
+
+void HELPER(getexp_FP0)(CPUM68KState *env)
+{
+    int32_t exp;
+    floatx80 res;
+
+    res = FP0_to_floatx80(env);
+    if (floatx80_is_zero_or_denormal(res) || floatx80_is_any_nan(res) ||
+        floatx80_is_infinity(res)) {
+        return;
+    }
+    exp = (env->fp0h & 0x7fff) - 0x3fff;
+
+    res = int32_to_floatx80(exp, &env->fp_status);
+
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(getman_FP0)(CPUM68KState *env)
+{
+    floatx80 res;
+    res = int64_to_floatx80(env->fp0l, &env->fp_status);
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(scale_FP0_FP1)(CPUM68KState *env)
+{
+    int32_t scale;
+    int32_t exp;
+
+    scale = floatx80_to_int32(FP0_to_floatx80(env), &env->fp_status);
+
+    exp = (env->fp1h & 0x7fff) + scale;
+
+    env->fp0h = (env->fp1h & 0x8000) | (exp & 0x7fff);
+    env->fp0l = env->fp1l;
+}
+
+static void make_quotient(CPUM68KState *env, floatx80 val)
+{
+    uint32_t quotient = floatx80_to_int32(val, &env->fp_status);
+    uint32_t sign = (quotient >> 24) & 0x80;
+    quotient = sign | (quotient & 0x7f);
+    env->fpsr = (env->fpsr & ~FPSR_QT_MASK) | (quotient << FPSR_QT_SHIFT);
+}
+
+void HELPER(mod_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double src, dst;
+
+    src = floatx80_to_ldouble(FP0_to_floatx80(env));
+    dst = floatx80_to_ldouble(FP1_to_floatx80(env));
+
+    dst = fmodl(dst, src);
+
+    res = ldouble_to_floatx80(dst);
+
+    make_quotient(env, res);
+    floatx80_to_FP0(env, res);
+}
+
+void HELPER(sincos_FP0_FP1)(CPUM68KState *env)
+{
+    floatx80 res;
+    long double val, valsin, valcos;
+
+    val = floatx80_to_ldouble(FP0_to_floatx80(env));
+
+    sincosl(val, &valsin, &valcos);
+    res = ldouble_to_floatx80(valsin);
+    floatx80_to_FP0(env, res);
+    res = ldouble_to_floatx80(valcos);
+    floatx80_to_FP1(env, res);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 58bc273..3b6a443 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -32,6 +32,28 @@ DEF_HELPER_2(set_fpcr, void, env, i32)
 DEF_HELPER_1(tst_FP0, void, env)
 DEF_HELPER_1(update_fpstatus, void, env)
 DEF_HELPER_4(fmovem, void, env, i32, i32, i32)
+DEF_HELPER_2(const_FP0, void, env, i32)
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
+DEF_HELPER_1(getexp_FP0, void, env)
+DEF_HELPER_1(getman_FP0, void, env)
+DEF_HELPER_1(scale_FP0_FP1, void, env)
+DEF_HELPER_1(mod_FP0_FP1, void, env)
+DEF_HELPER_1(sincos_FP0_FP1, void, env)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 3d55f0e..044ccc5 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -923,6 +923,14 @@ static void gen_op_load_fpr_FP1(int freg)
                    offsetof(CPUM68KState, fregs[freg].l.lower));
 }
 
+static void gen_op_store_fpr_FP1(int freg)
+{
+    tcg_gen_st16_i32(QREG_FP1H, cpu_env,
+                     offsetof(CPUM68KState, fregs[freg].l.upper));
+    tcg_gen_st_i64(QREG_FP1L, cpu_env,
+                   offsetof(CPUM68KState, fregs[freg].l.lower));
+}
+
 static void gen_extend_FP0(int opsize)
 {
     switch (opsize) {
@@ -4555,16 +4563,26 @@ static void gen_op_fmovem(CPUM68KState *env, DisasContext *s,
 DISAS_INSN(fpu)
 {
     uint16_t ext;
+    uint8_t rom_offset;
     int opmode;
     int opsize;
 
     ext = read_im16(env, s);
     opmode = ext & 0x7f;
     switch ((ext >> 13) & 7) {
-    case 0: case 2:
+    case 0:
         break;
     case 1:
         goto undef;
+    case 2:
+        if (insn == 0xf200 && (ext & 0xfc00) == 0x5c00) {
+            /* fmovecr */
+            rom_offset = ext & 0x7f;
+            gen_helper_const_FP0(cpu_env, tcg_const_i32(rom_offset));
+            gen_op_store_fpr_FP0(REG(ext, 7));
+            return;
+        }
+        break;
     case 3: /* fmove out */
         gen_op_load_fpr_FP0(REG(ext, 7));
         opsize = ext_opsize(ext, 10);
@@ -4607,22 +4625,80 @@ DISAS_INSN(fpu)
     case 1: /* fint */
         gen_helper_iround_FP0(cpu_env);
         break;
+    case 2: /* fsinh */
+        gen_helper_sinh_FP0(cpu_env);
+        break;
     case 3: /* fintrz */
         gen_helper_itrunc_FP0(cpu_env);
         break;
     case 4: case 0x41: case 0x45: /* fsqrt */
         gen_helper_sqrt_FP0(cpu_env);
         break;
+    case 6:                          /* flognp1 */
+        gen_helper_lognp1_FP0(cpu_env);
+        break;
+    case 0x09:                       /* ftanh */
+        gen_helper_tanh_FP0(cpu_env);
+        break;
+    case 0x0a:                       /* fatan */
+        gen_helper_atan_FP0(cpu_env);
+        break;
+    case 0x0c:                       /* fasin */
+        gen_helper_asin_FP0(cpu_env);
+        break;
+    case 0x0d:                       /* fatanh */
+        gen_helper_atanh_FP0(cpu_env);
+        break;
+    case 0x0e:                       /* fsin */
+        gen_helper_sin_FP0(cpu_env);
+        break;
+    case 0x0f:                       /* ftan */
+        gen_helper_tan_FP0(cpu_env);
+        break;
+    case 0x10:                       /* fetox */
+        gen_helper_exp_FP0(cpu_env);
+        break;
+    case 0x11:                       /* ftwotox */
+        gen_helper_exp2_FP0(cpu_env);
+        break;
+    case 0x12:                       /* ftentox */
+        gen_helper_exp10_FP0(cpu_env);
+        break;
+    case 0x14:                       /* flogn */
+        gen_helper_ln_FP0(cpu_env);
+        break;
+    case 0x15:                       /* flog10 */
+        gen_helper_log10_FP0(cpu_env);
+        break;
     case 0x18: case 0x58: case 0x5c: /* fabs */
         gen_helper_abs_FP0(cpu_env);
         break;
+    case 0x19:
+        gen_helper_cosh_FP0(cpu_env);
+        break;
     case 0x1a: case 0x5a: case 0x5e: /* fneg */
         gen_helper_chs_FP0(cpu_env);
         break;
+    case 0x1c:                       /* facos */
+        gen_helper_acos_FP0(cpu_env);
+        break;
+    case 0x1d:                       /* fcos */
+        gen_helper_cos_FP0(cpu_env);
+        break;
+    case 0x1e:                       /* fgetexp */
+        gen_helper_getexp_FP0(cpu_env);
+        break;
+    case 0x1f:                       /* fgetman */
+        gen_helper_getman_FP0(cpu_env);
+        break;
     case 0x20: case 0x60: case 0x64: /* fdiv */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_div_FP0_FP1(cpu_env);
         break;
+    case 0x21:                       /* fmod */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_mod_FP0_FP1(cpu_env);
+        break;
     case 0x22: case 0x62: case 0x66: /* fadd */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_add_FP0_FP1(cpu_env);
@@ -4631,10 +4707,29 @@ DISAS_INSN(fpu)
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_mul_FP0_FP1(cpu_env);
         break;
+    case 0x24:                      /* fsgldiv */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_div_FP0_FP1(cpu_env);
+        break;
+    case 0x26:                       /* fscale */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_scale_FP0_FP1(cpu_env);
+        break;
+    case 0x27:                      /* fsglmul */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_mul_FP0_FP1(cpu_env);
+        break;
     case 0x28: case 0x68: case 0x6c: /* fsub */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_sub_FP0_FP1(cpu_env);
         break;
+    case 0x30: case 0x31: case 0x32:
+    case 0x33: case 0x34: case 0x35:
+    case 0x36: case 0x37:
+        gen_helper_sincos_FP0_FP1(cpu_env);
+        gen_op_store_fpr_FP0(REG(ext, 7)); /* sin */
+        gen_op_store_fpr_FP1(REG(ext, 0)); /* cos */
+        break;
     case 0x38: /* fcmp */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_cmp_FP0_FP1(cpu_env);
-- 
2.7.4
