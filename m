Received: from eggs.gnu.org ([2001:4830:134:3::10]:33300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQv4h-0008C6-GC
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQv4a-0005th-Fz
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:31:03 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dQv4a-0005sN-3G
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:30:56 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 30 Jun 2017 14:30:48 +0200
Message-Id: <20170630123050.19834-6-laurent@vivier.eu>
In-Reply-To: <20170630123050.19834-1-laurent@vivier.eu>
References: <20170630123050.19834-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 5/7] target/m68k: add fsglmul and fsgldiv
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

fsglmul and fsgldiv truncate data to single precision before computing
results.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170628204241.32106-6-laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 28 ++++++++++++++++++++++++++++
 target/m68k/helper.h     |  2 ++
 target/m68k/translate.c  |  6 ++++++
 3 files changed, 36 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 3b53554..600ae8a 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -253,6 +253,20 @@ void HELPER(fdmul)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
     PREC_END();
 }
 
+void HELPER(fsglmul)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    int rounding_mode = get_float_rounding_mode(&env->fp_status);
+    floatx80 a, b;
+
+    PREC_BEGIN(32);
+    set_float_rounding_mode(float_round_to_zero, &env->fp_status);
+    a = floatx80_round(val0->d, &env->fp_status);
+    b = floatx80_round(val1->d, &env->fp_status);
+    set_float_rounding_mode(rounding_mode, &env->fp_status);
+    res->d = floatx80_mul(a, b, &env->fp_status);
+    PREC_END();
+}
+
 void HELPER(fdiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 {
     res->d = floatx80_div(val1->d, val0->d, &env->fp_status);
@@ -272,6 +286,20 @@ void HELPER(fddiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
     PREC_END();
 }
 
+void HELPER(fsgldiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    int rounding_mode = get_float_rounding_mode(&env->fp_status);
+    floatx80 a, b;
+
+    PREC_BEGIN(32);
+    set_float_rounding_mode(float_round_to_zero, &env->fp_status);
+    a = floatx80_round(val1->d, &env->fp_status);
+    b = floatx80_round(val0->d, &env->fp_status);
+    set_float_rounding_mode(rounding_mode, &env->fp_status);
+    res->d = floatx80_div(a, b, &env->fp_status);
+    PREC_END();
+}
+
 static int float_comp_to_cc(int float_compare)
 {
     switch (float_compare) {
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 0c7f06f..f05191b 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -39,9 +39,11 @@ DEF_HELPER_4(fdsub, void, env, fp, fp, fp)
 DEF_HELPER_4(fmul, void, env, fp, fp, fp)
 DEF_HELPER_4(fsmul, void, env, fp, fp, fp)
 DEF_HELPER_4(fdmul, void, env, fp, fp, fp)
+DEF_HELPER_4(fsglmul, void, env, fp, fp, fp)
 DEF_HELPER_4(fdiv, void, env, fp, fp, fp)
 DEF_HELPER_4(fsdiv, void, env, fp, fp, fp)
 DEF_HELPER_4(fddiv, void, env, fp, fp, fp)
+DEF_HELPER_4(fsgldiv, void, env, fp, fp, fp)
 DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
 DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 618abf6..72c45de 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4646,6 +4646,12 @@ DISAS_INSN(fpu)
     case 0x67: /* fdmul */
         gen_helper_fdmul(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
+    case 0x24: /* fsgldiv */
+        gen_helper_fsgldiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
+    case 0x27: /* fsglmul */
+        gen_helper_fsglmul(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
     case 0x28: /* fsub */
         gen_helper_fsub(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
-- 
2.9.4
