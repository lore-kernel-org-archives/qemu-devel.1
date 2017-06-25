Received: from eggs.gnu.org ([2001:4830:134:3::10]:46768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPD6l-0005wl-A4
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPD6g-0003nJ-JF
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:22:07 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:61575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dPD6g-0003my-6r
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:22:02 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 25 Jun 2017 21:21:24 +0200
Message-Id: <20170625192125.9992-7-laurent@vivier.eu>
In-Reply-To: <20170625192125.9992-1-laurent@vivier.eu>
References: <20170625192125.9992-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 6/7] target/m68k: add explicit single and
 double precision operations (part 2)
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

Add fsabs, fdabs, fsneg, fdneg, fsmove and fdmove.

The value is converted using the new floatx80_round() function.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 target/m68k/helper.h     |  8 +++++++-
 target/m68k/translate.c  | 26 ++++++++++++++++++++++----
 3 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 3518863..38370d0 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -163,6 +163,20 @@ void HELPER(set_fpcr)(CPUM68KState *env, uint32_t val)
         set_floatx80_rounding_precision(old, &env->fp_status);  \
     } while (0)
 
+void HELPER(fsround)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    PREC_BEGIN(32);
+    res->d = floatx80_round(val->d, &env->fp_status);
+    PREC_END();
+}
+
+void HELPER(fdround)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    PREC_BEGIN(64);
+    res->d = floatx80_round(val->d, &env->fp_status);
+    PREC_END();
+}
+
 void HELPER(fsqrt)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_sqrt(val->d, &env->fp_status);
@@ -184,12 +198,40 @@ void HELPER(fdsqrt)(CPUM68KState *env, FPReg *res, FPReg *val)
 
 void HELPER(fabs)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
-    res->d = floatx80_abs(val->d);
+    res->d = floatx80_round(floatx80_abs(val->d), &env->fp_status);
+}
+
+void HELPER(fsabs)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    PREC_BEGIN(32);
+    res->d = floatx80_round(floatx80_abs(val->d), &env->fp_status);
+    PREC_END();
+}
+
+void HELPER(fdabs)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    PREC_BEGIN(64);
+    res->d = floatx80_round(floatx80_abs(val->d), &env->fp_status);
+    PREC_END();
+}
+
+void HELPER(fneg)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_round(floatx80_chs(val->d), &env->fp_status);
 }
 
-void HELPER(fchs)(CPUM68KState *env, FPReg *res, FPReg *val)
+void HELPER(fsneg)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
-    res->d = floatx80_chs(val->d);
+    PREC_BEGIN(32);
+    res->d = floatx80_round(floatx80_chs(val->d), &env->fp_status);
+    PREC_END();
+}
+
+void HELPER(fdneg)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    PREC_BEGIN(64);
+    res->d = floatx80_round(floatx80_chs(val->d), &env->fp_status);
+    PREC_END();
 }
 
 void HELPER(fadd)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index f05191b..b396899 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -23,13 +23,19 @@ DEF_HELPER_2(redf32, f32, env, fp)
 DEF_HELPER_2(redf64, f64, env, fp)
 DEF_HELPER_2(reds32, s32, env, fp)
 
+DEF_HELPER_3(fsround, void, env, fp, fp)
+DEF_HELPER_3(fdround, void, env, fp, fp)
 DEF_HELPER_3(firound, void, env, fp, fp)
 DEF_HELPER_3(fitrunc, void, env, fp, fp)
 DEF_HELPER_3(fsqrt, void, env, fp, fp)
 DEF_HELPER_3(fssqrt, void, env, fp, fp)
 DEF_HELPER_3(fdsqrt, void, env, fp, fp)
 DEF_HELPER_3(fabs, void, env, fp, fp)
-DEF_HELPER_3(fchs, void, env, fp, fp)
+DEF_HELPER_3(fsabs, void, env, fp, fp)
+DEF_HELPER_3(fdabs, void, env, fp, fp)
+DEF_HELPER_3(fneg, void, env, fp, fp)
+DEF_HELPER_3(fsneg, void, env, fp, fp)
+DEF_HELPER_3(fdneg, void, env, fp, fp)
 DEF_HELPER_4(fadd, void, env, fp, fp, fp)
 DEF_HELPER_4(fsadd, void, env, fp, fp, fp)
 DEF_HELPER_4(fdadd, void, env, fp, fp, fp)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 22d499f..3a1bdc1 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4595,9 +4595,15 @@ DISAS_INSN(fpu)
     }
     cpu_dest = gen_fp_ptr(REG(ext, 7));
     switch (opmode) {
-    case 0: case 0x40: case 0x44: /* fmove */
+    case 0: /* fmove */
         gen_fp_move(cpu_dest, cpu_src);
         break;
+    case 0x40: /* fsmove */
+        gen_helper_fsround(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x44: /* fdmove */
+        gen_helper_fdround(cpu_env, cpu_dest, cpu_src);
+        break;
     case 1: /* fint */
         gen_helper_firound(cpu_env, cpu_dest, cpu_src);
         break;
@@ -4613,11 +4619,23 @@ DISAS_INSN(fpu)
     case 0x45: /* fdsqrt */
         gen_helper_fdsqrt(cpu_env, cpu_dest, cpu_src);
         break;
-    case 0x18: case 0x58: case 0x5c: /* fabs */
+    case 0x18: /* fabs */
         gen_helper_fabs(cpu_env, cpu_dest, cpu_src);
         break;
-    case 0x1a: case 0x5a: case 0x5e: /* fneg */
-        gen_helper_fchs(cpu_env, cpu_dest, cpu_src);
+    case 0x58: /* fsabs */
+        gen_helper_fsabs(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x5c: /* fdabs */
+        gen_helper_fdabs(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x1a: /* fneg */
+        gen_helper_fneg(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x5a: /* fsneg */
+        gen_helper_fsneg(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x5e: /* fdneg */
+        gen_helper_fdneg(cpu_env, cpu_dest, cpu_src);
         break;
     case 0x20: /* fdiv */
         gen_helper_fdiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
-- 
2.9.4
