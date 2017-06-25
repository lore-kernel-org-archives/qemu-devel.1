Received: from eggs.gnu.org ([2001:4830:134:3::10]:46683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPD6X-0005os-P3
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPD6S-0003ji-Rh
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:21:53 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:65436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dPD6S-0003jH-HK
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:21:48 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 25 Jun 2017 21:21:21 +0200
Message-Id: <20170625192125.9992-4-laurent@vivier.eu>
In-Reply-To: <20170625192125.9992-1-laurent@vivier.eu>
References: <20170625192125.9992-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 3/7] target/m68k: add fsglmul and fsgldiv
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
 target/m68k/translate.c  |  6 ++++++
 3 files changed, 30 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 912c0b7..0d83925 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -183,11 +183,33 @@ void HELPER(fmul)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
     res->d = floatx80_mul(val0->d, val1->d, &env->fp_status);
 }
 
+void HELPER(fsglmul)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    float32 a, b, c;
+
+    a = floatx80_to_float32(val0->d, &env->fp_status);
+    b = floatx80_to_float32(val1->d, &env->fp_status);
+    c = float32_mul(a, b, &env->fp_status);
+
+    res->d = float32_to_floatx80(c, &env->fp_status);
+}
+
 void HELPER(fdiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 {
     res->d = floatx80_div(val1->d, val0->d, &env->fp_status);
 }
 
+void HELPER(fsgldiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    float32 a, b, c;
+
+    a = floatx80_to_float32(val1->d, &env->fp_status);
+    b = floatx80_to_float32(val0->d, &env->fp_status);
+    c = float32_div(a, b, &env->fp_status);
+
+    res->d = float32_to_floatx80(c, &env->fp_status);
+}
+
 static int float_comp_to_cc(int float_compare)
 {
     switch (float_compare) {
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index d6e80e4..5a006de 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -31,7 +31,9 @@ DEF_HELPER_3(fchs, void, env, fp, fp)
 DEF_HELPER_4(fadd, void, env, fp, fp, fp)
 DEF_HELPER_4(fsub, void, env, fp, fp, fp)
 DEF_HELPER_4(fmul, void, env, fp, fp, fp)
+DEF_HELPER_4(fsglmul, void, env, fp, fp, fp)
 DEF_HELPER_4(fdiv, void, env, fp, fp, fp)
+DEF_HELPER_4(fsgldiv, void, env, fp, fp, fp)
 DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
 DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index a54da87..a50bf5f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4622,6 +4622,12 @@ DISAS_INSN(fpu)
     case 0x23: case 0x63: case 0x67: /* fmul */
         gen_helper_fmul(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
+    case 0x24: /* fsgldiv */
+        gen_helper_fsgldiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
+    case 0x27: /* fsglmul */
+        gen_helper_fsglmul(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
     case 0x28: case 0x68: case 0x6c: /* fsub */
         gen_helper_fsub(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
-- 
2.9.4
