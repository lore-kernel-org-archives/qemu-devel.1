Received: from eggs.gnu.org ([2001:4830:134:3::10]:37179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dKC6X-00021B-4w
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 19:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dKC6T-00081X-TV
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 19:17:09 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:53522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dKC6T-000819-HC
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 19:17:05 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Jun 2017 01:16:28 +0200
Message-Id: <20170611231633.32582-3-laurent@vivier.eu>
In-Reply-To: <20170611231633.32582-1-laurent@vivier.eu>
References: <20170611231633.32582-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v4 2/7] target-m68k: move FPU helpers to
 fpu_helper.c
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
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/m68k/Makefile.objs |   2 +-
 target/m68k/fpu_helper.c  | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.c      |  88 ------------------------------------
 3 files changed, 113 insertions(+), 89 deletions(-)
 create mode 100644 target/m68k/fpu_helper.c

diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
index 02cf616..39141ab 100644
--- a/target/m68k/Makefile.objs
+++ b/target/m68k/Makefile.objs
@@ -1,3 +1,3 @@
 obj-y += m68k-semi.o
-obj-y += translate.o op_helper.o helper.o cpu.o
+obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o
 obj-y += gdbstub.o
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
new file mode 100644
index 0000000..5bf2576
--- /dev/null
+++ b/target/m68k/fpu_helper.c
@@ -0,0 +1,112 @@
+/*
+ *  m68k FPU helpers
+ *
+ *  Copyright (c) 2006-2007 CodeSourcery
+ *  Written by Paul Brook
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/helper-proto.h"
+
+uint32_t HELPER(f64_to_i32)(CPUM68KState *env, float64 val)
+{
+    return float64_to_int32(val, &env->fp_status);
+}
+
+float32 HELPER(f64_to_f32)(CPUM68KState *env, float64 val)
+{
+    return float64_to_float32(val, &env->fp_status);
+}
+
+float64 HELPER(i32_to_f64)(CPUM68KState *env, uint32_t val)
+{
+    return int32_to_float64(val, &env->fp_status);
+}
+
+float64 HELPER(f32_to_f64)(CPUM68KState *env, float32 val)
+{
+    return float32_to_float64(val, &env->fp_status);
+}
+
+float64 HELPER(iround_f64)(CPUM68KState *env, float64 val)
+{
+    return float64_round_to_int(val, &env->fp_status);
+}
+
+float64 HELPER(itrunc_f64)(CPUM68KState *env, float64 val)
+{
+    return float64_trunc_to_int(val, &env->fp_status);
+}
+
+float64 HELPER(sqrt_f64)(CPUM68KState *env, float64 val)
+{
+    return float64_sqrt(val, &env->fp_status);
+}
+
+float64 HELPER(abs_f64)(float64 val)
+{
+    return float64_abs(val);
+}
+
+float64 HELPER(chs_f64)(float64 val)
+{
+    return float64_chs(val);
+}
+
+float64 HELPER(add_f64)(CPUM68KState *env, float64 a, float64 b)
+{
+    return float64_add(a, b, &env->fp_status);
+}
+
+float64 HELPER(sub_f64)(CPUM68KState *env, float64 a, float64 b)
+{
+    return float64_sub(a, b, &env->fp_status);
+}
+
+float64 HELPER(mul_f64)(CPUM68KState *env, float64 a, float64 b)
+{
+    return float64_mul(a, b, &env->fp_status);
+}
+
+float64 HELPER(div_f64)(CPUM68KState *env, float64 a, float64 b)
+{
+    return float64_div(a, b, &env->fp_status);
+}
+
+float64 HELPER(sub_cmp_f64)(CPUM68KState *env, float64 a, float64 b)
+{
+    /* ??? This may incorrectly raise exceptions.  */
+    /* ??? Should flush denormals to zero.  */
+    float64 res;
+    res = float64_sub(a, b, &env->fp_status);
+    if (float64_is_quiet_nan(res, &env->fp_status)) {
+        /* +/-inf compares equal against itself, but sub returns nan.  */
+        if (!float64_is_quiet_nan(a, &env->fp_status)
+            && !float64_is_quiet_nan(b, &env->fp_status)) {
+            res = float64_zero;
+            if (float64_lt_quiet(a, res, &env->fp_status)) {
+                res = float64_chs(res);
+            }
+        }
+    }
+    return res;
+}
+
+uint32_t HELPER(compare_f64)(CPUM68KState *env, float64 val)
+{
+    return float64_compare_quiet(val, float64_zero, &env->fp_status);
+}
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index f750d3d..5ca9911 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -284,94 +284,6 @@ void HELPER(set_sr)(CPUM68KState *env, uint32_t val)
     m68k_switch_sp(env);
 }
 
-/* FPU helpers.  */
-uint32_t HELPER(f64_to_i32)(CPUM68KState *env, float64 val)
-{
-    return float64_to_int32(val, &env->fp_status);
-}
-
-float32 HELPER(f64_to_f32)(CPUM68KState *env, float64 val)
-{
-    return float64_to_float32(val, &env->fp_status);
-}
-
-float64 HELPER(i32_to_f64)(CPUM68KState *env, uint32_t val)
-{
-    return int32_to_float64(val, &env->fp_status);
-}
-
-float64 HELPER(f32_to_f64)(CPUM68KState *env, float32 val)
-{
-    return float32_to_float64(val, &env->fp_status);
-}
-
-float64 HELPER(iround_f64)(CPUM68KState *env, float64 val)
-{
-    return float64_round_to_int(val, &env->fp_status);
-}
-
-float64 HELPER(itrunc_f64)(CPUM68KState *env, float64 val)
-{
-    return float64_trunc_to_int(val, &env->fp_status);
-}
-
-float64 HELPER(sqrt_f64)(CPUM68KState *env, float64 val)
-{
-    return float64_sqrt(val, &env->fp_status);
-}
-
-float64 HELPER(abs_f64)(float64 val)
-{
-    return float64_abs(val);
-}
-
-float64 HELPER(chs_f64)(float64 val)
-{
-    return float64_chs(val);
-}
-
-float64 HELPER(add_f64)(CPUM68KState *env, float64 a, float64 b)
-{
-    return float64_add(a, b, &env->fp_status);
-}
-
-float64 HELPER(sub_f64)(CPUM68KState *env, float64 a, float64 b)
-{
-    return float64_sub(a, b, &env->fp_status);
-}
-
-float64 HELPER(mul_f64)(CPUM68KState *env, float64 a, float64 b)
-{
-    return float64_mul(a, b, &env->fp_status);
-}
-
-float64 HELPER(div_f64)(CPUM68KState *env, float64 a, float64 b)
-{
-    return float64_div(a, b, &env->fp_status);
-}
-
-float64 HELPER(sub_cmp_f64)(CPUM68KState *env, float64 a, float64 b)
-{
-    /* ??? This may incorrectly raise exceptions.  */
-    /* ??? Should flush denormals to zero.  */
-    float64 res;
-    res = float64_sub(a, b, &env->fp_status);
-    if (float64_is_quiet_nan(res, &env->fp_status)) {
-        /* +/-inf compares equal against itself, but sub returns nan.  */
-        if (!float64_is_quiet_nan(a, &env->fp_status)
-            && !float64_is_quiet_nan(b, &env->fp_status)) {
-            res = float64_zero;
-            if (float64_lt_quiet(a, res, &env->fp_status))
-                res = float64_chs(res);
-        }
-    }
-    return res;
-}
-
-uint32_t HELPER(compare_f64)(CPUM68KState *env, float64 val)
-{
-    return float64_compare_quiet(val, float64_zero, &env->fp_status);
-}
 
 /* MAC unit.  */
 /* FIXME: The MAC unit implementation is a bit of a mess.  Some helpers
-- 
2.9.4
