Received: from eggs.gnu.org ([2001:4830:134:3::10]:35791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFI-0007P8-82
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFE-0005Mz-4H
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0hFE-0005MQ-03
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 27 Mar 2018 01:33:56 -0400
Message-Id: <1522128840-498-11-git-send-email-cota@braap.org>
In-Reply-To: <1522128840-498-1-git-send-email-cota@braap.org>
References: <1522128840-498-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 10/14] hardfloat: support float32/64 division
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

Performance results for fp-bench run under aarch64-linux-user
on an Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz host:

- before:
div-single: 30.30 MFlops
div-double: 29.59 MFlops

- after:
div-single: 94.07 MFlops
div-double: 106.79 MFlops

- w/ both using float32/64_is_normal etc.:
div-single: 94.08 MFlops
div-double: 99.09 MFlops

- w/ both using fpclassify etc.:
div-single: 88.82 MFlops
div-double: 105.20 MFlops

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9739a86..f414b41 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1440,7 +1440,8 @@ float16 float16_div(float16 a, float16 b, float_status *status)
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 float32_div(float32 a, float32 b, float_status *status)
+static float32 __attribute__((flatten, noinline))
+soft_float32_div(float32 a, float32 b, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -1449,7 +1450,8 @@ float32 float32_div(float32 a, float32 b, float_status *status)
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 float64_div(float64 a, float64 b, float_status *status)
+static float64 __attribute__((flatten, noinline))
+soft_float64_div(float64 a, float64 b, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
@@ -1458,6 +1460,64 @@ float64 float64_div(float64 a, float64 b, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+#define GEN_FPU_DIV(name, soft_t, host_t, host_abs_func, min_normal)    \
+    soft_t name(soft_t a, soft_t b, float_status *s)                    \
+    {                                                                   \
+        soft_t ## _input_flush2(&a, &b, s);                             \
+        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \
+                   soft_t ## _is_normal(b) &&                           \
+                   s->float_exception_flags & float_flag_inexact &&     \
+                   s->float_rounding_mode == float_round_nearest_even)) { \
+            host_t ha = soft_t ## _to_ ## host_t(a);                    \
+            host_t hb = soft_t ## _to_ ## host_t(b);                    \
+            host_t hr = ha / hb;                                        \
+            soft_t r = host_t ## _to_ ## soft_t(hr);                    \
+                                                                        \
+            if (unlikely(soft_t ## _is_infinity(r))) {                  \
+                s->float_exception_flags |= float_flag_overflow;        \
+            } else if (unlikely(host_abs_func(hr) <= min_normal) &&     \
+                       !soft_t ## _is_zero(a)) {                        \
+                goto soft;                                              \
+            }                                                           \
+            return r;                                                   \
+        }                                                               \
+    soft:                                                               \
+        return soft_ ## soft_t ## _div(a, b, s);                        \
+    }
+
+GEN_FPU_DIV(float32_div, float32, float, fabsf, FLT_MIN)
+#undef GEN_FPU_DIV
+
+#define GEN_FPU_DIV(name, soft_t, host_t, host_abs_func, min_normal)    \
+    soft_t name(soft_t a, soft_t b, float_status *s)                    \
+    {                                                                   \
+        host_t ha, hb;                                                  \
+                                                                        \
+        soft_t ## _input_flush2(&a, &b, s);                             \
+        ha = soft_t ## _to_ ## host_t(a);                               \
+        hb = soft_t ## _to_ ## host_t(b);                               \
+        if (likely((fpclassify(ha) == FP_NORMAL ||                      \
+                    fpclassify(ha) == FP_ZERO) &&                       \
+                   fpclassify(hb) == FP_NORMAL &&                       \
+                   s->float_exception_flags & float_flag_inexact &&     \
+                   s->float_rounding_mode == float_round_nearest_even)) { \
+            host_t hr = ha / hb;                                        \
+                                                                        \
+            if (unlikely(isinf(hr))) {                                  \
+                s->float_exception_flags |= float_flag_overflow;        \
+            } else if (unlikely(host_abs_func(hr) <= min_normal) &&     \
+                       !soft_t ## _is_zero(a)) {                        \
+                goto soft;                                              \
+            }                                                           \
+            return host_t ## _to_ ## soft_t(hr);                        \
+        }                                                               \
+    soft:                                                               \
+        return soft_ ## soft_t ## _div(a, b, s);                        \
+    }
+
+GEN_FPU_DIV(float64_div, float64, double, fabs, DBL_MIN)
+#undef GEN_FPU_DIV
+
 /*
  * Rounds the floating-point value `a' to an integer, and returns the
  * result as a floating-point value. The operation is performed
-- 
2.7.4
