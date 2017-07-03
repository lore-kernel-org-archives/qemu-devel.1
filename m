Received: from eggs.gnu.org ([2001:4830:134:3::10]:48914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dS48q-0002ko-Ms
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dS48p-00010S-HR
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:04 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58773)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dS48p-0000zr-4h
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:24:03 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  3 Jul 2017 18:23:28 +0200
Message-Id: <20170703162328.24474-5-laurent@vivier.eu>
In-Reply-To: <20170703162328.24474-1-laurent@vivier.eu>
References: <20170703162328.24474-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 4/4] target-m68k: add fscale,
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.h     |   3 ++
 target/m68k/translate.c  |   9 ++++
 3 files changed, 118 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 715b9be..88957fa 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -771,3 +771,109 @@ void HELPER(frem)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
     make_quotient(env, dst, sign);
     res->d = ldouble_to_floatx80(dst, &env->fp_status);
 }
+
+void HELPER(fgetexp)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    int32_t exp;
+
+    if (floatx80_is_infinity(val->d)) {
+        res->d = floatx80_default_nan(NULL);
+        /* FIXME: set the OPERR bit int he FPSR */
+        return;
+    }
+    if (floatx80_is_zero(val->d)) {
+        *res = *val;
+        return;
+    }
+    if (floatx80_is_zero_or_denormal(val->d)) {
+        res->d = int32_to_floatx80(-16384, &env->fp_status);
+        return;
+    }
+
+    if (floatx80_is_any_nan(val->d)) {
+        res->d = floatx80_default_nan(NULL);
+        return;
+    }
+
+    exp = (val->l.upper & 0x7fff) - 0x3fff;
+
+    res->d = int32_to_floatx80(exp, &env->fp_status);
+}
+
+void HELPER(fgetman)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    if (floatx80_is_infinity(val->d)) {
+        res->d = floatx80_default_nan(NULL);
+        /* FIXME: set the OPERR bit int he FPSR */
+        return;
+    }
+    if (floatx80_is_zero(val->d) ||
+        floatx80_is_any_nan(val->d)) {
+        *res = *val;
+        return;
+    }
+
+    res->l.upper = (val->l.upper & 0x8000) | 0x3fff;
+    if (floatx80_is_zero_or_denormal(val->d)) {
+        res->l.lower = val->l.lower << 1;
+    } else {
+        res->l.lower = val->l.lower;
+    }
+}
+
+void HELPER(fscale)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    int rounding_mode;
+    int32_t scale;
+    int32_t exp;
+
+    if (floatx80_is_infinity(val0->d)) {
+        res->d = floatx80_default_nan(NULL);
+        /* FIXME: set the OPERR bit in the FPSR */
+        return;
+    }
+    if (floatx80_is_any_nan(val0->d)) {
+        res->d = floatx80_default_nan(NULL);
+        return;
+    }
+    if (floatx80_is_infinity(val1->d) ||
+        floatx80_is_zero_or_denormal(val1->d)) {
+        *res = *val1;
+        return;
+    }
+    if (floatx80_is_zero(val0->d)) {
+        res->d = floatx80_round(val1->d, &env->fp_status);
+        return;
+    }
+
+    rounding_mode = get_float_rounding_mode(&env->fp_status);
+    set_float_rounding_mode(float_round_to_zero, &env->fp_status);
+    scale = floatx80_to_int32(val0->d, &env->fp_status);
+    set_float_rounding_mode(rounding_mode, &env->fp_status);
+
+    if (scale >= 16384) {
+        if (floatx80_is_neg(val1->d)) {
+            res->d = floatx80_chs(floatx80_infinity);
+        } else {
+            res->d = floatx80_infinity;
+        }
+        /* FIXME: set OVFL in FPSR */
+        return;
+    }
+    if (scale <= -16384) {
+        if (floatx80_is_neg(val1->d)) {
+            res->d = floatx80_chs(floatx80_zero);
+        } else {
+            res->d = floatx80_zero;
+        }
+        /* FIXME: set UNFL in FPSR */
+        return;
+    }
+
+    exp = (val1->l.upper & 0x7fff) + scale;
+
+    res->l.upper = (val1->l.upper & 0x8000) | (exp & 0x7fff);
+    res->l.lower = val1->l.lower;
+
+    res->d = floatx80_round(res->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 889978e..a6be815 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -79,6 +79,9 @@ DEF_HELPER_3(fcos, void, env, fp, fp)
 DEF_HELPER_4(fsincos, void, env, fp, fp, fp)
 DEF_HELPER_4(fmod, void, env, fp, fp, fp)
 DEF_HELPER_4(frem, void, env, fp, fp, fp)
+DEF_HELPER_3(fgetexp, void, env, fp, fp)
+DEF_HELPER_3(fgetman, void, env, fp, fp)
+DEF_HELPER_4(fscale, void, env, fp, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index fe9e0bf..348f4fb 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4718,6 +4718,12 @@ DISAS_INSN(fpu)
     case 0x1d: /* fcos */
         gen_helper_fcos(cpu_env, cpu_dest, cpu_src);
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
@@ -4754,6 +4760,9 @@ DISAS_INSN(fpu)
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
2.9.4
