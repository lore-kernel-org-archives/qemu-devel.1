Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqbU-0002Y7-Fl
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:58:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqa5-0000A5-5w
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:57:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gYqa4-00009Y-QQ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:57:01 -0500
Received: by mail-wm1-x335.google.com with SMTP id m22so12133724wml.3
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 02:57:00 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Dec 2018 10:56:44 +0000
Message-Id: <20181217105650.27361-10-alex.bennee@linaro.org>
In-Reply-To: <20181217105650.27361-1-alex.bennee@linaro.org>
References: <20181217105650.27361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 09/15] fpu: introduce hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: "Emilio G. Cota" <cota@braap.org>

The appended paves the way for leveraging the host FPU for a subset
of guest FP operations. For most guest workloads (e.g. FP flags
aren't ever cleared, inexact occurs often and rounding is set to the
default [to nearest]) this will yield sizable performance speedups.

The approach followed here avoids checking the FP exception flags register.
See the added comment for details.

This assumes that QEMU is running on an IEEE754-compliant FPU and
that the rounding is set to the default (to nearest). The
implementation-dependent specifics of the FPU should not matter; things
like tininess detection and snan representation are still dealt with in
soft-fp. However, this approach will break on most hosts if we compile
QEMU with flags that break IEEE compatibility. There is no way to detect
all of these flags at compilation time, but at least we check for
-ffast-math (which defines __FAST_MATH__) and disable hardfloat
(plus emit a #warning) when it is set.

This patch just adds common code. Some operations will be migrated
to hardfloat in subsequent patches to ease bisection.

Note: some architectures (at least PPC, there might be others) clear
the status flags passed to softfloat before most FP operations. This
precludes the use of hardfloat, so to avoid introducing a performance
regression for those targets, we add a flag to disable hardfloat.
In the long run though it would be good to fix the targets so that
at least the inexact flag passed to softfloat is indeed sticky.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index ecdc00c633..468c4554d5 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -83,6 +83,7 @@ this code that are retained.
  * target-dependent and needs the TARGET_* macros.
  */
 #include "qemu/osdep.h"
+#include <math.h>
 #include "qemu/bitops.h"
 #include "fpu/softfloat.h"
 
@@ -95,6 +96,324 @@ this code that are retained.
 *----------------------------------------------------------------------------*/
 #include "fpu/softfloat-macros.h"
 
+/*
+ * Hardfloat
+ *
+ * Fast emulation of guest FP instructions is challenging for two reasons.
+ * First, FP instruction semantics are similar but not identical, particularly
+ * when handling NaNs. Second, emulating at reasonable speed the guest FP
+ * exception flags is not trivial: reading the host's flags register with a
+ * feclearexcept & fetestexcept pair is slow [slightly slower than soft-fp],
+ * and trapping on every FP exception is not fast nor pleasant to work with.
+ *
+ * We address these challenges by leveraging the host FPU for a subset of the
+ * operations. To do this we expand on the idea presented in this paper:
+ *
+ * Guo, Yu-Chuan, et al. "Translating the ARM Neon and VFP instructions in a
+ * binary translator." Software: Practice and Experience 46.12 (2016):1591-1615.
+ *
+ * The idea is thus to leverage the host FPU to (1) compute FP operations
+ * and (2) identify whether FP exceptions occurred while avoiding
+ * expensive exception flag register accesses.
+ *
+ * An important optimization shown in the paper is that given that exception
+ * flags are rarely cleared by the guest, we can avoid recomputing some flags.
+ * This is particularly useful for the inexact flag, which is very frequently
+ * raised in floating-point workloads.
+ *
+ * We optimize the code further by deferring to soft-fp whenever FP exception
+ * detection might get hairy. Two examples: (1) when at least one operand is
+ * denormal/inf/NaN; (2) when operands are not guaranteed to lead to a 0 result
+ * and the result is < the minimum normal.
+ */
+#define GEN_INPUT_FLUSH__NOCHECK(name, soft_t)                          \
+    static inline void name(soft_t *a, float_status *s)                 \
+    {                                                                   \
+        if (unlikely(soft_t ## _is_denormal(*a))) {                     \
+            *a = soft_t ## _set_sign(soft_t ## _zero,                   \
+                                     soft_t ## _is_neg(*a));            \
+            s->float_exception_flags |= float_flag_input_denormal;      \
+        }                                                               \
+    }
+
+GEN_INPUT_FLUSH__NOCHECK(float32_input_flush__nocheck, float32)
+GEN_INPUT_FLUSH__NOCHECK(float64_input_flush__nocheck, float64)
+#undef GEN_INPUT_FLUSH__NOCHECK
+
+#define GEN_INPUT_FLUSH1(name, soft_t)                  \
+    static inline void name(soft_t *a, float_status *s) \
+    {                                                   \
+        if (likely(!s->flush_inputs_to_zero)) {         \
+            return;                                     \
+        }                                               \
+        soft_t ## _input_flush__nocheck(a, s);          \
+    }
+
+GEN_INPUT_FLUSH1(float32_input_flush1, float32)
+GEN_INPUT_FLUSH1(float64_input_flush1, float64)
+#undef GEN_INPUT_FLUSH1
+
+#define GEN_INPUT_FLUSH2(name, soft_t)                                  \
+    static inline void name(soft_t *a, soft_t *b, float_status *s)      \
+    {                                                                   \
+        if (likely(!s->flush_inputs_to_zero)) {                         \
+            return;                                                     \
+        }                                                               \
+        soft_t ## _input_flush__nocheck(a, s);                          \
+        soft_t ## _input_flush__nocheck(b, s);                          \
+    }
+
+GEN_INPUT_FLUSH2(float32_input_flush2, float32)
+GEN_INPUT_FLUSH2(float64_input_flush2, float64)
+#undef GEN_INPUT_FLUSH2
+
+#define GEN_INPUT_FLUSH3(name, soft_t)                                  \
+    static inline void name(soft_t *a, soft_t *b, soft_t *c, float_status *s) \
+    {                                                                   \
+        if (likely(!s->flush_inputs_to_zero)) {                         \
+            return;                                                     \
+        }                                                               \
+        soft_t ## _input_flush__nocheck(a, s);                          \
+        soft_t ## _input_flush__nocheck(b, s);                          \
+        soft_t ## _input_flush__nocheck(c, s);                          \
+    }
+
+GEN_INPUT_FLUSH3(float32_input_flush3, float32)
+GEN_INPUT_FLUSH3(float64_input_flush3, float64)
+#undef GEN_INPUT_FLUSH3
+
+/*
+ * Choose whether to use fpclassify or float32/64_* primitives in the generated
+ * hardfloat functions. Each combination of number of inputs and float size
+ * gets its own value.
+ */
+#if defined(__x86_64__)
+# define QEMU_HARDFLOAT_1F32_USE_FP 0
+# define QEMU_HARDFLOAT_1F64_USE_FP 1
+# define QEMU_HARDFLOAT_2F32_USE_FP 0
+# define QEMU_HARDFLOAT_2F64_USE_FP 1
+# define QEMU_HARDFLOAT_3F32_USE_FP 0
+# define QEMU_HARDFLOAT_3F64_USE_FP 1
+#else
+# define QEMU_HARDFLOAT_1F32_USE_FP 0
+# define QEMU_HARDFLOAT_1F64_USE_FP 0
+# define QEMU_HARDFLOAT_2F32_USE_FP 0
+# define QEMU_HARDFLOAT_2F64_USE_FP 0
+# define QEMU_HARDFLOAT_3F32_USE_FP 0
+# define QEMU_HARDFLOAT_3F64_USE_FP 0
+#endif
+
+/*
+ * QEMU_HARDFLOAT_USE_ISINF chooses whether to use isinf() over
+ * float{32,64}_is_infinity when !USE_FP.
+ * On x86_64/aarch64, using the former over the latter can yield a ~6% speedup.
+ * On power64 however, using isinf() reduces fp-bench performance by up to 50%.
+ */
+#if defined(__x86_64__) || defined(__aarch64__)
+# define QEMU_HARDFLOAT_USE_ISINF   1
+#else
+# define QEMU_HARDFLOAT_USE_ISINF   0
+#endif
+
+/*
+ * Some targets clear the FP flags before most FP operations. This prevents
+ * the use of hardfloat, since hardfloat relies on the inexact flag being
+ * already set.
+ */
+#if defined(TARGET_PPC) || defined(__FAST_MATH__)
+# if defined(__FAST_MATH__)
+#  warning disabling hardfloat due to -ffast-math: hardfloat requires an exact \
+    IEEE implementation
+# endif
+# define QEMU_NO_HARDFLOAT 1
+# define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN
+#else
+# define QEMU_NO_HARDFLOAT 0
+# define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN __attribute__((noinline))
+#endif
+
+static inline bool can_use_fpu(const float_status *s)
+{
+    if (QEMU_NO_HARDFLOAT) {
+        return false;
+    }
+    return likely(s->float_exception_flags & float_flag_inexact &&
+                  s->float_rounding_mode == float_round_nearest_even);
+}
+
+/*
+ * Hardfloat generation functions. Each operation can have two flavors:
+ * either using softfloat primitives (e.g. float32_is_zero_or_normal) for
+ * most condition checks, or native ones (e.g. fpclassify).
+ *
+ * The flavor is chosen by the callers. Instead of using macros, we rely on the
+ * compiler to propagate constants and inline everything into the callers.
+ *
+ * We only generate functions for operations with two inputs, since only
+ * these are common enough to justify consolidating them into common code.
+ */
+
+typedef union {
+    float32 s;
+    float h;
+} union_float32;
+
+typedef union {
+    float64 s;
+    double h;
+} union_float64;
+
+typedef bool (*f32_check_fn)(union_float32 a, union_float32 b);
+typedef bool (*f64_check_fn)(union_float64 a, union_float64 b);
+
+typedef float32 (*soft_f32_op2_fn)(float32 a, float32 b, float_status *s);
+typedef float64 (*soft_f64_op2_fn)(float64 a, float64 b, float_status *s);
+typedef float   (*hard_f32_op2_fn)(float a, float b);
+typedef double  (*hard_f64_op2_fn)(double a, double b);
+
+/* 2-input is-zero-or-normal */
+static inline bool f32_is_zon2(union_float32 a, union_float32 b)
+{
+    if (QEMU_HARDFLOAT_2F32_USE_FP) {
+        /*
+         * Not using a temp variable for consecutive fpclassify calls ends up
+         * generating faster code.
+         */
+        return (fpclassify(a.h) == FP_NORMAL || fpclassify(a.h) == FP_ZERO) &&
+               (fpclassify(b.h) == FP_NORMAL || fpclassify(b.h) == FP_ZERO);
+    }
+    return float32_is_zero_or_normal(a.s) &&
+           float32_is_zero_or_normal(b.s);
+}
+
+static inline bool f64_is_zon2(union_float64 a, union_float64 b)
+{
+    if (QEMU_HARDFLOAT_2F64_USE_FP) {
+        return (fpclassify(a.h) == FP_NORMAL || fpclassify(a.h) == FP_ZERO) &&
+               (fpclassify(b.h) == FP_NORMAL || fpclassify(b.h) == FP_ZERO);
+    }
+    return float64_is_zero_or_normal(a.s) &&
+           float64_is_zero_or_normal(b.s);
+}
+
+/* 3-input is-zero-or-normal */
+static inline
+bool f32_is_zon3(union_float32 a, union_float32 b, union_float32 c)
+{
+    if (QEMU_HARDFLOAT_3F32_USE_FP) {
+        return (fpclassify(a.h) == FP_NORMAL || fpclassify(a.h) == FP_ZERO) &&
+               (fpclassify(b.h) == FP_NORMAL || fpclassify(b.h) == FP_ZERO) &&
+               (fpclassify(c.h) == FP_NORMAL || fpclassify(c.h) == FP_ZERO);
+    }
+    return float32_is_zero_or_normal(a.s) &&
+           float32_is_zero_or_normal(b.s) &&
+           float32_is_zero_or_normal(c.s);
+}
+
+static inline
+bool f64_is_zon3(union_float64 a, union_float64 b, union_float64 c)
+{
+    if (QEMU_HARDFLOAT_3F64_USE_FP) {
+        return (fpclassify(a.h) == FP_NORMAL || fpclassify(a.h) == FP_ZERO) &&
+               (fpclassify(b.h) == FP_NORMAL || fpclassify(b.h) == FP_ZERO) &&
+               (fpclassify(c.h) == FP_NORMAL || fpclassify(c.h) == FP_ZERO);
+    }
+    return float64_is_zero_or_normal(a.s) &&
+           float64_is_zero_or_normal(b.s) &&
+           float64_is_zero_or_normal(c.s);
+}
+
+static inline bool f32_is_inf(union_float32 a)
+{
+    if (QEMU_HARDFLOAT_USE_ISINF) {
+        return isinf(a.h);
+    }
+    return float32_is_infinity(a.s);
+}
+
+static inline bool f64_is_inf(union_float64 a)
+{
+    if (QEMU_HARDFLOAT_USE_ISINF) {
+        return isinf(a.h);
+    }
+    return float64_is_infinity(a.s);
+}
+
+/* Note: @fast_test and @post can be NULL */
+static inline float32
+float32_gen2(float32 xa, float32 xb, float_status *s,
+             hard_f32_op2_fn hard, soft_f32_op2_fn soft,
+             f32_check_fn pre, f32_check_fn post,
+             f32_check_fn fast_test, soft_f32_op2_fn fast_op)
+{
+    union_float32 ua, ub, ur;
+
+    ua.s = xa;
+    ub.s = xb;
+
+    if (unlikely(!can_use_fpu(s))) {
+        goto soft;
+    }
+
+    float32_input_flush2(&ua.s, &ub.s, s);
+    if (unlikely(!pre(ua, ub))) {
+        goto soft;
+    }
+    if (fast_test && fast_test(ua, ub)) {
+        return fast_op(ua.s, ub.s, s);
+    }
+
+    ur.h = hard(ua.h, ub.h);
+    if (unlikely(f32_is_inf(ur))) {
+        s->float_exception_flags |= float_flag_overflow;
+    } else if (unlikely(fabsf(ur.h) <= FLT_MIN)) {
+        if (post == NULL || post(ua, ub)) {
+            goto soft;
+        }
+    }
+    return ur.s;
+
+ soft:
+    return soft(ua.s, ub.s, s);
+}
+
+static inline float64
+float64_gen2(float64 xa, float64 xb, float_status *s,
+             hard_f64_op2_fn hard, soft_f64_op2_fn soft,
+             f64_check_fn pre, f64_check_fn post,
+             f64_check_fn fast_test, soft_f64_op2_fn fast_op)
+{
+    union_float64 ua, ub, ur;
+
+    ua.s = xa;
+    ub.s = xb;
+
+    if (unlikely(!can_use_fpu(s))) {
+        goto soft;
+    }
+
+    float64_input_flush2(&ua.s, &ub.s, s);
+    if (unlikely(!pre(ua, ub))) {
+        goto soft;
+    }
+    if (fast_test && fast_test(ua, ub)) {
+        return fast_op(ua.s, ub.s, s);
+    }
+
+    ur.h = hard(ua.h, ub.h);
+    if (unlikely(f64_is_inf(ur))) {
+        s->float_exception_flags |= float_flag_overflow;
+    } else if (unlikely(fabs(ur.h) <= DBL_MIN)) {
+        if (post == NULL || post(ua, ub)) {
+            goto soft;
+        }
+    }
+    return ur.s;
+
+ soft:
+    return soft(ua.s, ub.s, s);
+}
+
 /*----------------------------------------------------------------------------
 | Returns the fraction bits of the half-precision floating-point value `a'.
 *----------------------------------------------------------------------------*/
-- 
2.17.1
