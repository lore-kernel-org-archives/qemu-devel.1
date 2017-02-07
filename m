Received: from eggs.gnu.org ([2001:4830:134:3::10]:33170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cau9D-0005JF-1L
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 20:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cau97-0006Ej-QT
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 20:00:42 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:63648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cau97-0006D3-47
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 20:00:37 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  7 Feb 2017 01:59:27 +0100
Message-Id: <20170207005930.28327-14-laurent@vivier.eu>
In-Reply-To: <20170207005930.28327-1-laurent@vivier.eu>
References: <20170207005930.28327-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3 13/16] target-m68k: add fsglmul and fsgldiv
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

fsglmul and fsgldiv truncate data to single precision before computing
results.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 22 ++++++++++++++++++++++
 target/m68k/helper.h     |  2 ++
 target/m68k/translate.c  |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 42f5b5c..8a3eed3 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -351,6 +351,17 @@ void HELPER(mul_FP0_FP1)(CPUM68KState *env)
     floatx80_to_FP0(env, res);
 }
 
+void HELPER(sglmul_FP0_FP1)(CPUM68KState *env)
+{
+    float64 a, b, res;
+
+    a = floatx80_to_float64(FP0_to_floatx80(env), &env->fp_status);
+    b = floatx80_to_float64(FP1_to_floatx80(env), &env->fp_status);
+    res = float64_mul(a, b, &env->fp_status);
+
+    floatx80_to_FP0(env, float64_to_floatx80(res, &env->fp_status));
+}
+
 void HELPER(div_FP0_FP1)(CPUM68KState *env)
 {
     floatx80 res;
@@ -361,6 +372,17 @@ void HELPER(div_FP0_FP1)(CPUM68KState *env)
     floatx80_to_FP0(env, res);
 }
 
+void HELPER(sgldiv_FP0_FP1)(CPUM68KState *env)
+{
+    float64 a, b, res;
+
+    a = floatx80_to_float64(FP1_to_floatx80(env), &env->fp_status);
+    b = floatx80_to_float64(FP0_to_floatx80(env), &env->fp_status);
+    res = float64_div(a, b, &env->fp_status);
+
+    floatx80_to_FP0(env, float64_to_floatx80(res, &env->fp_status));
+}
+
 static int float_comp_to_cc(int float_compare)
 {
     switch (float_compare) {
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 620e707..c30e5f7 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -26,7 +26,9 @@ DEF_HELPER_1(chs_FP0, void, env)
 DEF_HELPER_1(add_FP0_FP1, void, env)
 DEF_HELPER_1(sub_FP0_FP1, void, env)
 DEF_HELPER_1(mul_FP0_FP1, void, env)
+DEF_HELPER_1(sglmul_FP0_FP1, void, env)
 DEF_HELPER_1(div_FP0_FP1, void, env)
+DEF_HELPER_1(sgldiv_FP0_FP1, void, env)
 DEF_HELPER_1(cmp_FP0_FP1, void, env)
 DEF_HELPER_2(set_fpcr, void, env, i32)
 DEF_HELPER_1(tst_FP0, void, env)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index be18083..99f41d3 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4651,10 +4651,18 @@ DISAS_INSN(fpu)
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_mul_FP0_FP1(cpu_env);
         break;
+    case 0x24: /* fsgldiv */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_sgldiv_FP0_FP1(cpu_env);
+        break;
     case 0x26: /* fscale */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_scale_FP0_FP1(cpu_env);
         break;
+    case 0x27: /* fsglmul */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_sglmul_FP0_FP1(cpu_env);
+        break;
     case 0x28: case 0x68: case 0x6c: /* fsub */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_sub_FP0_FP1(cpu_env);
-- 
2.9.3
