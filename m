Received: from eggs.gnu.org ([2001:4830:134:3::10]:57138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1esXVN-0003FA-VV
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 12:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1esXVK-0006P3-Dg
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 12:33:01 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:47141)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1esXVK-0006Mx-2j
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 12:32:58 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun,  4 Mar 2018 18:32:30 +0100
Message-Id: <20180304173232.22814-4-laurent@vivier.eu>
In-Reply-To: <20180304173232.22814-1-laurent@vivier.eu>
References: <20180304173232.22814-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 3/5] target/m68k: add fmod/frem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>

Using a local m68k floatx80_mod()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

The quotient byte of the FPSR is updated with
the result of the operation.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180224201802.911-3-laurent@vivier.eu>
---
 target/m68k/Makefile.objs |   3 +-
 target/m68k/cpu.h         |   1 +
 target/m68k/fpu_helper.c  |  35 +++++++++++++++-
 target/m68k/helper.h      |   2 +
 target/m68k/softfloat.c   | 105 ++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h   |  26 ++++++++++++
 target/m68k/translate.c   |   6 +++
 7 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100644 target/m68k/softfloat.c
 create mode 100644 target/m68k/softfloat.h

diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
index d143f20270..ac61948676 100644
--- a/target/m68k/Makefile.objs
+++ b/target/m68k/Makefile.objs
@@ -1,4 +1,5 @@
 obj-y += m68k-semi.o
-obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o
+obj-y += translate.o op_helper.o helper.o cpu.o
+obj-y += fpu_helper.o softfloat.o
 obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += monitor.o
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 65f4fb95cb..2259bf22dc 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -427,6 +427,7 @@ typedef enum {
 /* Quotient */
 
 #define FPSR_QT_MASK  0x00ff0000
+#define FPSR_QT_SHIFT 16
 
 /* Floating-Point Control Register */
 /* Rounding mode */
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 3c5a82aaa0..8286228b81 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -23,7 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
-#include "fpu/softfloat.h"
+#include "softfloat.h"
 
 /* Undefined offsets may be different on various FPU.
  * On 68040 they return 0.0 (floatx80_zero)
@@ -509,3 +509,36 @@ uint32_t HELPER(fmovemd_ld_postinc)(CPUM68KState *env, uint32_t addr,
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
index 7f400f0def..76a0590c9c 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -63,6 +63,8 @@ DEF_HELPER_3(fmovemx_ld_postinc, i32, env, i32, i32)
 DEF_HELPER_3(fmovemd_st_predec, i32, env, i32, i32)
 DEF_HELPER_3(fmovemd_st_postinc, i32, env, i32, i32)
 DEF_HELPER_3(fmovemd_ld_postinc, i32, env, i32, i32)
+DEF_HELPER_4(fmod, void, env, fp, fp, fp)
+DEF_HELPER_4(frem, void, env, fp, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
new file mode 100644
index 0000000000..8c77757b4e
--- /dev/null
+++ b/target/m68k/softfloat.c
@@ -0,0 +1,105 @@
+/*
+ * Ported from a work by Andreas Grabher for Previous, NeXT Computer Emulator,
+ * derived from NetBSD M68040 FPSP functions,
+ * derived from release 2a of the SoftFloat IEC/IEEE Floating-point Arithmetic
+ * Package. Those parts of the code (and some later contributions) are
+ * provided under that license, as detailed below.
+ * It has subsequently been modified by contributors to the QEMU Project,
+ * so some portions are provided under:
+ *  the SoftFloat-2a license
+ *  the BSD license
+ *  GPL-v2-or-later
+ *
+ * Any future contributions to this file will be taken to be licensed under
+ * the Softfloat-2a license unless specifically indicated otherwise.
+ */
+
+/* Portions of this work are licensed under the terms of the GNU GPL,
+ * version 2 or later. See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "softfloat.h"
+#include "fpu/softfloat-macros.h"
+
+/*----------------------------------------------------------------------------
+ | Returns the modulo remainder of the extended double-precision floating-point
+ | value `a' with respect to the corresponding value `b'.
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
+{
+    flag aSign, zSign;
+    int32_t aExp, bExp, expDiff;
+    uint64_t aSig0, aSig1, bSig;
+    uint64_t qTemp, term0, term1;
+
+    aSig0 = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+    bSig = extractFloatx80Frac(b);
+    bExp = extractFloatx80Exp(b);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig0 << 1)
+            || ((bExp == 0x7FFF) && (uint64_t) (bSig << 1))) {
+            return propagateFloatx80NaN(a, b, status);
+        }
+        goto invalid;
+    }
+    if (bExp == 0x7FFF) {
+        if ((uint64_t) (bSig << 1)) {
+            return propagateFloatx80NaN(a, b, status);
+        }
+        return a;
+    }
+    if (bExp == 0) {
+        if (bSig == 0) {
+        invalid:
+            float_raise(float_flag_invalid, status);
+            return floatx80_default_nan(status);
+        }
+        normalizeFloatx80Subnormal(bSig, &bExp, &bSig);
+    }
+    if (aExp == 0) {
+        if ((uint64_t) (aSig0 << 1) == 0) {
+            return a;
+        }
+        normalizeFloatx80Subnormal(aSig0, &aExp, &aSig0);
+    }
+    bSig |= LIT64(0x8000000000000000);
+    zSign = aSign;
+    expDiff = aExp - bExp;
+    aSig1 = 0;
+    if (expDiff < 0) {
+        return a;
+    }
+    qTemp = (bSig <= aSig0);
+    if (qTemp) {
+        aSig0 -= bSig;
+    }
+    expDiff -= 64;
+    while (0 < expDiff) {
+        qTemp = estimateDiv128To64(aSig0, aSig1, bSig);
+        qTemp = (2 < qTemp) ? qTemp - 2 : 0;
+        mul64To128(bSig, qTemp, &term0, &term1);
+        sub128(aSig0, aSig1, term0, term1, &aSig0, &aSig1);
+        shortShift128Left(aSig0, aSig1, 62, &aSig0, &aSig1);
+    }
+    expDiff += 64;
+    if (0 < expDiff) {
+        qTemp = estimateDiv128To64(aSig0, aSig1, bSig);
+        qTemp = (2 < qTemp) ? qTemp - 2 : 0;
+        qTemp >>= 64 - expDiff;
+        mul64To128(bSig, qTemp << (64 - expDiff), &term0, &term1);
+        sub128(aSig0, aSig1, term0, term1, &aSig0, &aSig1);
+        shortShift128Left(0, bSig, 64 - expDiff, &term0, &term1);
+        while (le128(term0, term1, aSig0, aSig1)) {
+            ++qTemp;
+            sub128(aSig0, aSig1, term0, term1, &aSig0, &aSig1);
+        }
+    }
+    return
+        normalizeRoundAndPackFloatx80(
+            80, zSign, bExp + expDiff, aSig0, aSig1, status);
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
new file mode 100644
index 0000000000..8d8ca0fc45
--- /dev/null
+++ b/target/m68k/softfloat.h
@@ -0,0 +1,26 @@
+/*
+ * Ported from a work by Andreas Grabher for Previous, NeXT Computer Emulator,
+ * derived from NetBSD M68040 FPSP functions,
+ * derived from release 2a of the SoftFloat IEC/IEEE Floating-point Arithmetic
+ * Package. Those parts of the code (and some later contributions) are
+ * provided under that license, as detailed below.
+ * It has subsequently been modified by contributors to the QEMU Project,
+ * so some portions are provided under:
+ *  the SoftFloat-2a license
+ *  the BSD license
+ *  GPL-v2-or-later
+ *
+ * Any future contributions to this file will be taken to be licensed under
+ * the Softfloat-2a license unless specifically indicated otherwise.
+ */
+
+/* Portions of this work are licensed under the terms of the GNU GPL,
+ * version 2 or later. See the COPYING file in the top-level directory.
+ */
+
+#ifndef TARGET_M68K_SOFTFLOAT_H
+#define TARGET_M68K_SOFTFLOAT_H
+#include "fpu/softfloat.h"
+
+floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status);
+#endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index a22993c7ce..f8db26fa8e 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5081,6 +5081,9 @@ DISAS_INSN(fpu)
     case 0x64: /* fddiv */
         gen_helper_fddiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
+    case 0x21: /* fmod */
+        gen_helper_fmod(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
     case 0x22: /* fadd */
         gen_helper_fadd(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
@@ -5102,6 +5105,9 @@ DISAS_INSN(fpu)
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
2.14.3
