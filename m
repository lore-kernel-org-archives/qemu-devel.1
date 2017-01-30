Received: from eggs.gnu.org ([2001:4830:134:3::10]:51264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWP-0003HR-EW
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWL-0002I9-8O
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:45 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:60074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cYGWK-0002HX-SN
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:41 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:16:30 +0100
Message-Id: <20170130181634.13934-13-laurent@vivier.eu>
In-Reply-To: <20170130181634.13934-1-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 12/16] target-m68k: add fscale, fgetman,
 fgetexp and fmod
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

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h        |  1 +
 target/m68k/fpu_helper.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.h     |  4 ++++
 target/m68k/translate.c  | 14 ++++++++++++
 4 files changed, 75 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7985dc3..3042ab7 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -253,6 +253,7 @@ typedef enum {
 /* Quotient */
 
 #define FPSR_QT_MASK  0x00ff0000
+#define FPSR_QT_SHIFT 16
 
 /* Floating-Point Control Register */
 /* Rounding mode */
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index d8145e0..42f5b5c 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -458,3 +458,59 @@ void HELPER(const_FP0)(CPUM68KState *env, uint32_t offset)
     env->fp0l = fpu_rom[offset].low;
     env->fp0h = fpu_rom[offset].high;
 }
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
+
+    res = floatx80_rem(FP1_to_floatx80(env), FP0_to_floatx80(env),
+                       &env->fp_status);
+    make_quotient(env, res);
+
+    floatx80_to_FP0(env, res);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 4927324..620e707 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -33,6 +33,10 @@ DEF_HELPER_1(tst_FP0, void, env)
 DEF_HELPER_1(update_fpstatus, void, env)
 DEF_HELPER_4(fmovem, void, env, i32, i32, i32)
 DEF_HELPER_2(const_FP0, void, env, i32)
+DEF_HELPER_1(getexp_FP0, void, env)
+DEF_HELPER_1(getman_FP0, void, env)
+DEF_HELPER_1(scale_FP0_FP1, void, env)
+DEF_HELPER_1(mod_FP0_FP1, void, env)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 26160a3..d954d82 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4629,10 +4629,20 @@ DISAS_INSN(fpu)
     case 0x1a: case 0x5a: case 0x5e: /* fneg */
         gen_helper_chs_FP0(cpu_env);
         break;
+    case 0x1e: /* fgetexp */
+        gen_helper_getexp_FP0(cpu_env);
+        break;
+    case 0x1f: /* fgetman */
+        gen_helper_getman_FP0(cpu_env);
+        break;
     case 0x20: case 0x60: case 0x64: /* fdiv */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_div_FP0_FP1(cpu_env);
         break;
+    case 0x21: /* fmod */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_mod_FP0_FP1(cpu_env);
+        break;
     case 0x22: case 0x62: case 0x66: /* fadd */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_add_FP0_FP1(cpu_env);
@@ -4641,6 +4651,10 @@ DISAS_INSN(fpu)
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_mul_FP0_FP1(cpu_env);
         break;
+    case 0x26: /* fscale */
+        gen_op_load_fpr_FP1(REG(ext, 7));
+        gen_helper_scale_FP0_FP1(cpu_env);
+        break;
     case 0x28: case 0x68: case 0x6c: /* fsub */
         gen_op_load_fpr_FP1(REG(ext, 7));
         gen_helper_sub_FP0_FP1(cpu_env);
-- 
2.9.3
