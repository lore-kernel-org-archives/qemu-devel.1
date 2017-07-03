Received: from eggs.gnu.org ([2001:4830:134:3::10]:48887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dS48m-0002ij-4R
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dS48i-0000wQ-QW
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:00 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dS48i-0000vJ-Fc
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:23:56 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  3 Jul 2017 18:23:27 +0200
Message-Id: <20170703162328.24474-4-laurent@vivier.eu>
In-Reply-To: <20170703162328.24474-1-laurent@vivier.eu>
References: <20170703162328.24474-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 3/4] target/m68k: add fmod/frem
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

Use libm functions fmodl() and remainderl().
The quotient byte of the FPSR is updated with
the result of the operation.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h        |  1 +
 target/m68k/fpu_helper.c | 35 +++++++++++++++++++++++++++++++++++
 target/m68k/helper.h     |  2 ++
 target/m68k/translate.c  |  6 ++++++
 4 files changed, 44 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index f8f4dd5..84794a9 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -236,6 +236,7 @@ typedef enum {
 /* Quotient */
 
 #define FPSR_QT_MASK  0x00ff0000
+#define FPSR_QT_SHIFT 16
 
 /* Floating-Point Control Register */
 /* Rounding mode */
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 2b07cb9..715b9be 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -736,3 +736,38 @@ void HELPER(fsincos)(CPUM68KState *env, FPReg *res0, FPReg *res1, FPReg *val)
     res1->d = ldouble_to_floatx80(dcos, &env->fp_status);
     res0->d = ldouble_to_floatx80(dsin, &env->fp_status);
 }
+
+static void make_quotient(CPUM68KState *env, long double val, uint32_t sign)
+{
+    uint32_t quotient = (uint32_t)fabsl(val);
+    quotient = (sign << 7) | (quotient & 0x7f);
+    env->fpsr = (env->fpsr & ~FPSR_QT_MASK) | (quotient << FPSR_QT_SHIFT);
+}
+
+void HELPER(fmod)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    long double src, dst;
+    uint32_t sign = floatx80_is_neg(val0->d) ^  floatx80_is_neg(val1->d);
+
+    src = floatx80_to_ldouble(val0->d);
+    dst = floatx80_to_ldouble(val1->d);
+
+    dst = fmodl(dst, src);
+
+    make_quotient(env, dst, sign);
+    res->d = ldouble_to_floatx80(dst, &env->fp_status);
+}
+
+void HELPER(frem)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    long double src, dst;
+    uint32_t sign = floatx80_is_neg(val0->d) ^  floatx80_is_neg(val1->d);
+
+    src = floatx80_to_ldouble(val0->d);
+    dst = floatx80_to_ldouble(val1->d);
+
+    dst = remainderl(dst, src);
+
+    make_quotient(env, dst, sign);
+    res->d = ldouble_to_floatx80(dst, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 302b6c0..889978e 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -77,6 +77,8 @@ DEF_HELPER_3(fcosh, void, env, fp, fp)
 DEF_HELPER_3(facos, void, env, fp, fp)
 DEF_HELPER_3(fcos, void, env, fp, fp)
 DEF_HELPER_4(fsincos, void, env, fp, fp, fp)
+DEF_HELPER_4(fmod, void, env, fp, fp, fp)
+DEF_HELPER_4(frem, void, env, fp, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 8a712b3..fe9e0bf 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4727,6 +4727,9 @@ DISAS_INSN(fpu)
     case 0x64: /* fddiv */
         gen_helper_fddiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
+    case 0x21: /* fmod */
+        gen_helper_fmod(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
     case 0x22: /* fadd */
         gen_helper_fadd(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
@@ -4748,6 +4751,9 @@ DISAS_INSN(fpu)
     case 0x24: /* fsgldiv */
         gen_helper_fsgldiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
+    case 0x25: /* frem */
+        gen_helper_frem(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
     case 0x27: /* fsglmul */
         gen_helper_fsglmul(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
-- 
2.9.4
