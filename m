Received: from eggs.gnu.org ([2001:4830:134:3::10]:40802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQm-00046f-QY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQi-0003MJ-9H
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fSYQi-0003L3-1V
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 11 Jun 2018 21:48:54 -0400
Message-Id: <1528768140-17894-9-git-send-email-cota@braap.org>
In-Reply-To: <1528768140-17894-1-git-send-email-cota@braap.org>
References: <1528768140-17894-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 08/14] fpu: introduce hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

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
QEMU with flags such as -ffast-math. We control the flags so this should
be easy to enforce though.

This patch just adds common code. Some operations will be migrated
to hardfloat in subsequent patches to ease bisection.

Note: some architectures (at least PPC, there might be others) clear
the status flags passed to softfloat before most FP operations. This
precludes the use of hardfloat, so to avoid introducing a performance
regression for those targets, we add a flag to disable hardfloat.
In the long run though it would be good to fix the targets so that
at least the inexact flag passed to softfloat is indeed sticky.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 341 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 341 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2ab5a88..4d378d7 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -83,6 +83,7 @@ this code that are retained.
  * target-dependent and needs the TARGET_* macros.
  */
 #include "qemu/osdep.h"
+#include <math.h>
 #include "qemu/bitops.h"
 #include "fpu/softfloat.h"
 
@@ -95,6 +96,346 @@ this code that are retained.
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
+#define GEN_TYPE_CONV(name, to_t, from_t)       \
+    static inline to_t name(from_t a)           \
+    {                                           \
+        to_t r = *(to_t *)&a;                   \
+        return r;                               \
+    }
+
+GEN_TYPE_CONV(float32_to_float, float, float32)
+GEN_TYPE_CONV(float64_to_double, double, float64)
+GEN_TYPE_CONV(float_to_float32, float32, float)
+GEN_TYPE_CONV(double_to_float64, float64, double)
+#undef GEN_TYPE_CONV
+
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
+static inline bool can_use_fpu(const float_status *s)
+{
+    return likely(s->float_exception_flags & float_flag_inexact &&
+                  s->float_rounding_mode == float_round_nearest_even);
+}
+
+/*
+ * Choose whether to use fpclassify or float32/64_* primitives in the generated
+ * hardfloat functions. Each combination of number of inputs and float size
+ * gets its own value.
+ */
+#if defined(__x86_64__)
+# define QEMU_HARDFLOAT_1F32_USE_FP 0
+# define QEMU_HARDFLOAT_1F64_USE_FP 0
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
+#if defined(TARGET_PPC)
+# define QEMU_NO_HARDFLOAT 1
+# define QEMU_SOFTFLOAT_ATTR __attribute__((flatten))
+#else
+# define QEMU_NO_HARDFLOAT 0
+# define QEMU_SOFTFLOAT_ATTR __attribute__((noinline))
+#endif
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
+typedef bool (*f32_check_func_t)(float32 a, float32 b, const float_status *s);
+typedef bool (*f64_check_func_t)(float64 a, float64 b, const float_status *s);
+typedef bool (*float_check_func_t)(float a, float b, const float_status *s);
+typedef bool (*double_check_func_t)(double a, double b, const float_status *s);
+
+typedef float32 (*f32_op2_func_t)(float32 a, float32 b, float_status *s);
+typedef float64 (*f64_op2_func_t)(float64 a, float64 b, float_status *s);
+typedef float (*float_op2_func_t)(float a, float b);
+typedef double (*double_op2_func_t)(double a, double b);
+
+/* 2-input is-zero-or-normal */
+static inline bool
+f32_is_zon2(float32 a, float32 b, const struct float_status *s)
+{
+    return likely(float32_is_zero_or_normal(a) &&
+                  float32_is_zero_or_normal(b) &&
+                  can_use_fpu(s));
+}
+
+static inline bool
+float_is_zon2(float a, float b, const struct float_status *s)
+{
+    return likely((fpclassify(a) == FP_NORMAL || fpclassify(a) == FP_ZERO) &&
+                  (fpclassify(b) == FP_NORMAL || fpclassify(b) == FP_ZERO) &&
+                  can_use_fpu(s));
+}
+
+static inline bool
+f64_is_zon2(float64 a, float64 b, const struct float_status *s)
+{
+    return likely(float64_is_zero_or_normal(a) &&
+                  float64_is_zero_or_normal(b) &&
+                  can_use_fpu(s));
+}
+
+static inline bool
+double_is_zon2(double a, double b, const struct float_status *s)
+{
+    return likely((fpclassify(a) == FP_NORMAL || fpclassify(a) == FP_ZERO) &&
+                  (fpclassify(b) == FP_NORMAL || fpclassify(b) == FP_ZERO) &&
+                  can_use_fpu(s));
+}
+
+/*
+ * Note: @fast and @post can be NULL.
+ * Note: @fast and @fast_op always use softfloat types.
+ */
+static inline float32
+f32_gen2(float32 a, float32 b, float_status *s, float_op2_func_t hard,
+         f32_op2_func_t soft, f32_check_func_t pre, f32_check_func_t post,
+         f32_check_func_t fast, f32_op2_func_t fast_op)
+{
+    if (QEMU_NO_HARDFLOAT) {
+        goto soft;
+    }
+    float32_input_flush2(&a, &b, s);
+    if (likely(pre(a, b, s))) {
+        if (fast != NULL && fast(a, b, s)) {
+            return fast_op(a, b, s);
+        } else {
+            float ha = float32_to_float(a);
+            float hb = float32_to_float(b);
+            float hr = hard(ha, hb);
+            float32 r = float_to_float32(hr);
+
+            if (unlikely(QEMU_HARDFLOAT_USE_ISINF ?
+                         isinf(hr) : float32_is_infinity(r))) {
+                s->float_exception_flags |= float_flag_overflow;
+            } else if (unlikely(fabsf(hr) <= FLT_MIN &&
+                                (post == NULL || post(a, b, s)))) {
+                goto soft;
+            }
+            return r;
+        }
+    }
+ soft:
+    return soft(a, b, s);
+}
+
+static inline float32
+float_gen2(float32 a, float32 b, float_status *s, float_op2_func_t hard,
+           f32_op2_func_t soft, float_check_func_t pre, float_check_func_t post,
+           f32_check_func_t fast, f32_op2_func_t fast_op)
+{
+    float ha, hb;
+
+    if (QEMU_NO_HARDFLOAT) {
+        goto soft;
+    }
+    float32_input_flush2(&a, &b, s);
+    ha = float32_to_float(a);
+    hb = float32_to_float(b);
+    if (likely(pre(ha, hb, s))) {
+        if (fast != NULL && fast(a, b, s)) {
+            return fast_op(a, b, s);
+        } else {
+            float hr = hard(ha, hb);
+            float32 r = float_to_float32(hr);
+
+            if (unlikely(isinf(hr))) {
+                s->float_exception_flags |= float_flag_overflow;
+            } else if (unlikely(fabsf(hr) <= FLT_MIN &&
+                                (post == NULL || post(ha, hb, s)))) {
+                goto soft;
+            }
+            return r;
+        }
+    }
+ soft:
+    return soft(a, b, s);
+}
+
+static inline float64
+f64_gen2(float64 a, float64 b, float_status *s, double_op2_func_t hard,
+         f64_op2_func_t soft, f64_check_func_t pre, f64_check_func_t post,
+         f64_check_func_t fast, f64_op2_func_t fast_op)
+{
+    if (QEMU_NO_HARDFLOAT) {
+        goto soft;
+    }
+    float64_input_flush2(&a, &b, s);
+    if (likely(pre(a, b, s))) {
+        if (fast != NULL && fast(a, b, s)) {
+            return fast_op(a, b, s);
+        } else {
+            double ha = float64_to_double(a);
+            double hb = float64_to_double(b);
+            double hr = hard(ha, hb);
+            float64 r = double_to_float64(hr);
+
+            if (unlikely(QEMU_HARDFLOAT_USE_ISINF ?
+                         isinf(hr) : float64_is_infinity(r))) {
+                s->float_exception_flags |= float_flag_overflow;
+            } else if (unlikely(fabsf(hr) <= FLT_MIN &&
+                                (post == NULL || post(a, b, s)))) {
+                goto soft;
+            }
+            return r;
+        }
+    }
+ soft:
+    return soft(a, b, s);
+}
+
+static inline float64
+double_gen2(float64 a, float64 b, float_status *s, double_op2_func_t hard,
+            f64_op2_func_t soft, double_check_func_t pre,
+            double_check_func_t post, f64_check_func_t fast,
+            f64_op2_func_t fast_op)
+{
+    double ha, hb;
+
+    if (QEMU_NO_HARDFLOAT) {
+        goto soft;
+    }
+    float64_input_flush2(&a, &b, s);
+    ha = float64_to_double(a);
+    hb = float64_to_double(b);
+    if (likely(pre(ha, hb, s))) {
+        if (fast != NULL && fast(a, b, s)) {
+            return fast_op(a, b, s);
+        } else {
+            double hr = hard(ha, hb);
+            float64 r = double_to_float64(hr);
+
+            if (unlikely(isinf(hr))) {
+                s->float_exception_flags |= float_flag_overflow;
+            } else if (unlikely(fabs(hr) <= DBL_MIN &&
+                                (post == NULL || post(ha, hb, s)))) {
+                goto soft;
+            }
+            return r;
+        }
+    }
+ soft:
+    return soft(a, b, s);
+}
+
 /*----------------------------------------------------------------------------
 | Returns the fraction bits of the half-precision floating-point value `a'.
 *----------------------------------------------------------------------------*/
-- 
2.7.4
