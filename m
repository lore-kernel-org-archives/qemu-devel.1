Received: from eggs.gnu.org ([2001:4830:134:3::10]:33281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQv4g-00088C-97
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQv4b-0005vl-7u
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:31:02 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dQv4a-0005s4-T8
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:30:57 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 30 Jun 2017 14:30:46 +0200
Message-Id: <20170630123050.19834-4-laurent@vivier.eu>
In-Reply-To: <20170630123050.19834-1-laurent@vivier.eu>
References: <20170630123050.19834-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 3/7] target/m68k: add explicit single and double
 precision operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Add fssqrt, fdsqrt, fsadd, fdadd, fssub, fdsub, fsmul, fdmul,
fsdiv, fddiv.

The precision is managed using set_floatx80_rounding_precision().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170628204241.32106-4-laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.h     | 10 ++++++
 target/m68k/translate.c  | 40 +++++++++++++++++++++---
 3 files changed, 125 insertions(+), 5 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 4c14a1f..3b53554 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -157,11 +157,35 @@ void HELPER(set_fpcr)(CPUM68KState *env, uint32_t val)
     cpu_m68k_set_fpcr(env, val);
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
 void HELPER(fsqrt)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_sqrt(val->d, &env->fp_status);
 }
 
+void HELPER(fssqrt)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    PREC_BEGIN(32);
+    res->d = floatx80_sqrt(val->d, &env->fp_status);
+    PREC_END();
+}
+
+void HELPER(fdsqrt)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    PREC_BEGIN(64);
+    res->d = floatx80_sqrt(val->d, &env->fp_status);
+    PREC_END();
+}
+
 void HELPER(fabs)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_abs(val->d);
@@ -177,21 +201,77 @@ void HELPER(fadd)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
     res->d = floatx80_add(val0->d, val1->d, &env->fp_status);
 }
 
+void HELPER(fsadd)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    PREC_BEGIN(32);
+    res->d = floatx80_add(val0->d, val1->d, &env->fp_status);
+    PREC_END();
+}
+
+void HELPER(fdadd)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    PREC_BEGIN(64);
+    res->d = floatx80_add(val0->d, val1->d, &env->fp_status);
+    PREC_END();
+}
+
 void HELPER(fsub)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 {
     res->d = floatx80_sub(val1->d, val0->d, &env->fp_status);
 }
 
+void HELPER(fssub)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    PREC_BEGIN(32);
+    res->d = floatx80_sub(val1->d, val0->d, &env->fp_status);
+    PREC_END();
+}
+
+void HELPER(fdsub)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    PREC_BEGIN(64);
+    res->d = floatx80_sub(val1->d, val0->d, &env->fp_status);
+    PREC_END();
+}
+
 void HELPER(fmul)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 {
     res->d = floatx80_mul(val0->d, val1->d, &env->fp_status);
 }
 
+void HELPER(fsmul)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    PREC_BEGIN(32);
+    res->d = floatx80_mul(val0->d, val1->d, &env->fp_status);
+    PREC_END();
+}
+
+void HELPER(fdmul)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    PREC_BEGIN(64);
+    res->d = floatx80_mul(val0->d, val1->d, &env->fp_status);
+    PREC_END();
+}
+
 void HELPER(fdiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 {
     res->d = floatx80_div(val1->d, val0->d, &env->fp_status);
 }
 
+void HELPER(fsdiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    PREC_BEGIN(32);
+    res->d = floatx80_div(val1->d, val0->d, &env->fp_status);
+    PREC_END();
+}
+
+void HELPER(fddiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    PREC_BEGIN(64);
+    res->d = floatx80_div(val1->d, val0->d, &env->fp_status);
+    PREC_END();
+}
+
 static int float_comp_to_cc(int float_compare)
 {
     switch (float_compare) {
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index d6e80e4..0c7f06f 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -26,12 +26,22 @@ DEF_HELPER_2(reds32, s32, env, fp)
 DEF_HELPER_3(firound, void, env, fp, fp)
 DEF_HELPER_3(fitrunc, void, env, fp, fp)
 DEF_HELPER_3(fsqrt, void, env, fp, fp)
+DEF_HELPER_3(fssqrt, void, env, fp, fp)
+DEF_HELPER_3(fdsqrt, void, env, fp, fp)
 DEF_HELPER_3(fabs, void, env, fp, fp)
 DEF_HELPER_3(fchs, void, env, fp, fp)
 DEF_HELPER_4(fadd, void, env, fp, fp, fp)
+DEF_HELPER_4(fsadd, void, env, fp, fp, fp)
+DEF_HELPER_4(fdadd, void, env, fp, fp, fp)
 DEF_HELPER_4(fsub, void, env, fp, fp, fp)
+DEF_HELPER_4(fssub, void, env, fp, fp, fp)
+DEF_HELPER_4(fdsub, void, env, fp, fp, fp)
 DEF_HELPER_4(fmul, void, env, fp, fp, fp)
+DEF_HELPER_4(fsmul, void, env, fp, fp, fp)
+DEF_HELPER_4(fdmul, void, env, fp, fp, fp)
 DEF_HELPER_4(fdiv, void, env, fp, fp, fp)
+DEF_HELPER_4(fsdiv, void, env, fp, fp, fp)
+DEF_HELPER_4(fddiv, void, env, fp, fp, fp)
 DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
 DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 5b93d3f..618abf6 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4604,27 +4604,57 @@ DISAS_INSN(fpu)
     case 3: /* fintrz */
         gen_helper_fitrunc(cpu_env, cpu_dest, cpu_src);
         break;
-    case 4: case 0x41: case 0x45: /* fsqrt */
+    case 4: /* fsqrt */
         gen_helper_fsqrt(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x41: /* fssqrt */
+        gen_helper_fssqrt(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x45: /* fdsqrt */
+        gen_helper_fdsqrt(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x18: case 0x58: case 0x5c: /* fabs */
         gen_helper_fabs(cpu_env, cpu_dest, cpu_src);
         break;
     case 0x1a: case 0x5a: case 0x5e: /* fneg */
         gen_helper_fchs(cpu_env, cpu_dest, cpu_src);
         break;
-    case 0x20: case 0x60: case 0x64: /* fdiv */
+    case 0x20: /* fdiv */
         gen_helper_fdiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
-    case 0x22: case 0x62: case 0x66: /* fadd */
+    case 0x60: /* fsdiv */
+        gen_helper_fsdiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
+    case 0x64: /* fddiv */
+        gen_helper_fddiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
+    case 0x22: /* fadd */
         gen_helper_fadd(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
-    case 0x23: case 0x63: case 0x67: /* fmul */
+    case 0x62: /* fsadd */
+        gen_helper_fsadd(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
+    case 0x66: /* fdadd */
+        gen_helper_fdadd(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
+    case 0x23: /* fmul */
         gen_helper_fmul(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
-    case 0x28: case 0x68: case 0x6c: /* fsub */
+    case 0x63: /* fsmul */
+        gen_helper_fsmul(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
+    case 0x67: /* fdmul */
+        gen_helper_fdmul(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
+    case 0x28: /* fsub */
         gen_helper_fsub(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
+    case 0x68: /* fssub */
+        gen_helper_fssub(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
+    case 0x6c: /* fdsub */
+        gen_helper_fdsub(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
     case 0x38: /* fcmp */
         gen_helper_fcmp(cpu_env, cpu_src, cpu_dest);
         return;
-- 
2.9.4
