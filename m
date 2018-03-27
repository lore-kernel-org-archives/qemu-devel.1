Received: from eggs.gnu.org ([2001:4830:134:3::10]:35787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFI-0007P5-70
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFD-0005Lw-F5
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36039)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0hFD-0005LK-AK
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 27 Mar 2018 01:33:53 -0400
Message-Id: <1522128840-498-8-git-send-email-cota@braap.org>
In-Reply-To: <1522128840-498-1-git-send-email-cota@braap.org>
References: <1522128840-498-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 07/14] fpu: introduce hardfloat
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

This patch just adds some boilerplate code; subsequent patches add
operations, one per commit to ease bisection.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6803279..ffe16b2 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -82,6 +82,8 @@ this code that are retained.
 /* softfloat (and in particular the code in softfloat-specialize.h) is
  * target-dependent and needs the TARGET_* macros.
  */
+#include <math.h>
+
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "fpu/softfloat.h"
@@ -105,6 +107,95 @@ this code that are retained.
 *----------------------------------------------------------------------------*/
 #include "softfloat-specialize.h"
 
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
+ * We address these challenges by leverage the host FPU for a subset of the
+ * operations. To do this we follow the main idea presented in this paper:
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
+#define GEN_INPUT_FLUSH(soft_t)                                         \
+    static inline __attribute__((always_inline)) void                   \
+    soft_t ## _input_flush__nocheck(soft_t *a, float_status *s)         \
+    {                                                                   \
+        if (unlikely(soft_t ## _is_denormal(*a))) {                     \
+            *a = soft_t ## _set_sign(soft_t ## _zero,                   \
+                                     soft_t ## _is_neg(*a));            \
+            s->float_exception_flags |= float_flag_input_denormal;      \
+        }                                                               \
+    }                                                                   \
+                                                                        \
+    static inline __attribute__((always_inline)) void                   \
+    soft_t ## _input_flush1(soft_t *a, float_status *s)                 \
+    {                                                                   \
+        if (likely(!s->flush_inputs_to_zero)) {                         \
+            return;                                                     \
+        }                                                               \
+        soft_t ## _input_flush__nocheck(a, s);                          \
+    }                                                                   \
+                                                                        \
+    static inline __attribute__((always_inline)) void                   \
+    soft_t ## _input_flush2(soft_t *a, soft_t *b, float_status *s)      \
+    {                                                                   \
+        if (likely(!s->flush_inputs_to_zero)) {                         \
+            return;                                                     \
+        }                                                               \
+        soft_t ## _input_flush__nocheck(a, s);                          \
+        soft_t ## _input_flush__nocheck(b, s);                          \
+    }                                                                   \
+                                                                        \
+    static inline __attribute__((always_inline)) void                   \
+    soft_t ## _input_flush3(soft_t *a, soft_t *b, soft_t *c,            \
+                            float_status *s)                            \
+    {                                                                   \
+        if (likely(!s->flush_inputs_to_zero)) {                         \
+            return;                                                     \
+        }                                                               \
+        soft_t ## _input_flush__nocheck(a, s);                          \
+        soft_t ## _input_flush__nocheck(b, s);                          \
+        soft_t ## _input_flush__nocheck(c, s);                          \
+    }
+
+GEN_INPUT_FLUSH(float32)
+GEN_INPUT_FLUSH(float64)
+#undef GEN_INPUT_FLUSH
+
 /*----------------------------------------------------------------------------
 | Returns the fraction bits of the half-precision floating-point value `a'.
 *----------------------------------------------------------------------------*/
-- 
2.7.4
