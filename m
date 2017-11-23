Received: from eggs.gnu.org ([2001:4830:134:3::10]:46761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eHuTx-0007ow-IY
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eHuTu-0003NE-3b
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:09 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:61899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eHuTt-0003Lj-PJ
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:06 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 23 Nov 2017 17:35:35 +0100
Message-Id: <20171123163538.31411-3-laurent@vivier.eu>
In-Reply-To: <20171123163538.31411-1-laurent@vivier.eu>
References: <20171123163538.31411-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 2/5] target/m68k: add fmod/frem
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

Use floatx80_mod() and floatx80_rem()

The quotient byte of the FPSR is updated with
the result of the operation.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h        |  1 +
 target/m68k/fpu_helper.c | 33 +++++++++++++++++++++++++++++++++
 target/m68k/helper.h     |  2 ++
 target/m68k/translate.c  |  6 ++++++
 4 files changed, 42 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index afae5f68ac..4ba613dfbe 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -234,6 +234,7 @@ typedef enum {
 /* Quotient */
 
 #define FPSR_QT_MASK  0x00ff0000
+#define FPSR_QT_SHIFT 16
 
 /* Floating-Point Control Register */
 /* Rounding mode */
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 665e7609af..dd8b6950d6 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -508,3 +508,36 @@ uint32_t HELPER(fmovemd_ld_postinc)(CPUM68KState *env, uint32_t addr,
 {
     return fmovem_postinc(env, addr, mask, cpu_ld_float64_ra);
 }
+
+static void make_quotient(CPUM68KState *env, floatx80 val)
+{
+    int32_t quotient;
+    int sign;
+
+    if (floatx80_is_any_nan(val)) {
+        return;
+    }
+
+    quotient = floatx80_to_int32(val, &env->fp_status);
+    sign = quotient < 0;
+    if (sign) {
+        quotient = -quotient;
+    }
+
+    quotient = (sign << 7) | (quotient & 0x7f);
+    env->fpsr = (env->fpsr & ~FPSR_QT_MASK) | (quotient << FPSR_QT_SHIFT);
+}
+
+void HELPER(fmod)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    res->d = floatx80_mod(val1->d, val0->d, &env->fp_status);
+
+    make_quotient(env, res->d);
+}
+
+void HELPER(frem)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    res->d = floatx80_rem(val1->d, val0->d, &env->fp_status);
+
+    make_quotient(env, res->d);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index eebe52dae5..ff9d99ae27 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -61,6 +61,8 @@ DEF_HELPER_3(fmovemx_ld_postinc, i32, env, i32, i32)
 DEF_HELPER_3(fmovemd_st_predec, i32, env, i32, i32)
 DEF_HELPER_3(fmovemd_st_postinc, i32, env, i32, i32)
 DEF_HELPER_3(fmovemd_ld_postinc, i32, env, i32, i32)
+DEF_HELPER_4(fmod, void, env, fp, fp, fp)
+DEF_HELPER_4(frem, void, env, fp, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index b60909222c..66f873899f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4686,6 +4686,9 @@ DISAS_INSN(fpu)
     case 0x64: /* fddiv */
         gen_helper_fddiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
+    case 0x21: /* fmod */
+        gen_helper_fmod(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
     case 0x22: /* fadd */
         gen_helper_fadd(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
@@ -4707,6 +4710,9 @@ DISAS_INSN(fpu)
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
2.13.6
