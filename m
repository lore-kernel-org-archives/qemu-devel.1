Received: from eggs.gnu.org ([2001:4830:134:3::10]:46953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eHuU3-0007sr-N1
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eHuTz-0003Vb-UW
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:15 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:50277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eHuTz-0003UH-JK
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:11 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 23 Nov 2017 17:35:38 +0100
Message-Id: <20171123163538.31411-6-laurent@vivier.eu>
In-Reply-To: <20171123163538.31411-1-laurent@vivier.eu>
References: <20171123163538.31411-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 5/5] target-m68k: add fscale,
 fgetman and fgetexp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

using floatx80_scale(), floatx80_getman() and
floatx80_getexp()

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 15 +++++++++++++++
 target/m68k/helper.h     |  3 +++
 target/m68k/translate.c  |  9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index dd8b6950d6..6be2b90eba 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -541,3 +541,18 @@ void HELPER(frem)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 
     make_quotient(env, res->d);
 }
+
+void HELPER(fgetexp)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_getexp(val->d, &env->fp_status);
+}
+
+void HELPER(fgetman)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_getman(val->d, &env->fp_status);
+}
+
+void HELPER(fscale)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    res->d = floatx80_scale(val1->d, val0->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index ff9d99ae27..ccdda73187 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -63,6 +63,9 @@ DEF_HELPER_3(fmovemd_st_postinc, i32, env, i32, i32)
 DEF_HELPER_3(fmovemd_ld_postinc, i32, env, i32, i32)
 DEF_HELPER_4(fmod, void, env, fp, fp, fp)
 DEF_HELPER_4(frem, void, env, fp, fp, fp)
+DEF_HELPER_3(fgetexp, void, env, fp, fp)
+DEF_HELPER_3(fgetman, void, env, fp, fp)
+DEF_HELPER_4(fscale, void, env, fp, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 66f873899f..c0c2e8c757 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4677,6 +4677,12 @@ DISAS_INSN(fpu)
     case 0x5e: /* fdneg */
         gen_helper_fdneg(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x1e: /* fgetexp */
+        gen_helper_fgetexp(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x1f: /* fgetman */
+        gen_helper_fgetman(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x20: /* fdiv */
         gen_helper_fdiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
@@ -4713,6 +4719,9 @@ DISAS_INSN(fpu)
     case 0x25: /* frem */
         gen_helper_frem(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
+    case 0x26: /* fscale */
+        gen_helper_fscale(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
     case 0x27: /* fsglmul */
         gen_helper_fsglmul(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
-- 
2.13.6
