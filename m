Received: from eggs.gnu.org ([2001:4830:134:3::10]:42157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5V-00029q-Sc
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5R-0000zb-EA
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34761)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5R-0000yR-6S
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:45 -0400
Message-Id: <1521663109-32262-11-git-send-email-cota@braap.org>
In-Reply-To: <1521663109-32262-1-git-send-email-cota@braap.org>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 10/14] hostfloat: support float32/64 division
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
div-single: 29.77 MFlops
div-double: 29.85 MFlops

- after:
div-single: 85.90 MFlops
div-double: 86.10 MFlops

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/hostfloat.h |  2 ++
 include/fpu/softfloat.h |  4 ++--
 fpu/hostfloat.c         | 28 ++++++++++++++++++++++++++++
 fpu/softfloat.c         |  4 ++--
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/fpu/hostfloat.h b/include/fpu/hostfloat.h
index 7049f7e..61a8525 100644
--- a/include/fpu/hostfloat.h
+++ b/include/fpu/hostfloat.h
@@ -14,9 +14,11 @@
 float32 float32_add(float32 a, float32 b, float_status *status);
 float32 float32_sub(float32 a, float32 b, float_status *status);
 float32 float32_mul(float32 a, float32 b, float_status *status);
+float32 float32_div(float32 a, float32 b, float_status *status);
 
 float64 float64_add(float64 a, float64 b, float_status *status);
 float64 float64_sub(float64 a, float64 b, float_status *status);
 float64 float64_mul(float64 a, float64 b, float_status *status);
+float64 float64_div(float64 a, float64 b, float_status *status);
 
 #endif /* HOSTFLOAT_H */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 2b07ae8..a690a57 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -345,7 +345,7 @@ float32 float32_round_to_int(float32, float_status *status);
 float32 soft_float32_add(float32, float32, float_status *status);
 float32 soft_float32_sub(float32, float32, float_status *status);
 float32 soft_float32_mul(float32, float32, float_status *status);
-float32 float32_div(float32, float32, float_status *status);
+float32 soft_float32_div(float32, float32, float_status *status);
 float32 float32_rem(float32, float32, float_status *status);
 float32 float32_muladd(float32, float32, float32, int, float_status *status);
 float32 float32_sqrt(float32, float_status *status);
@@ -485,7 +485,7 @@ float64 float64_trunc_to_int(float64, float_status *status);
 float64 soft_float64_add(float64, float64, float_status *status);
 float64 soft_float64_sub(float64, float64, float_status *status);
 float64 soft_float64_mul(float64, float64, float_status *status);
-float64 float64_div(float64, float64, float_status *status);
+float64 soft_float64_div(float64, float64, float_status *status);
 float64 float64_rem(float64, float64, float_status *status);
 float64 float64_muladd(float64, float64, float64, int, float_status *status);
 float64 float64_sqrt(float64, float_status *status);
diff --git a/fpu/hostfloat.c b/fpu/hostfloat.c
index 985d6f1..ff980ac 100644
--- a/fpu/hostfloat.c
+++ b/fpu/hostfloat.c
@@ -178,3 +178,31 @@ GEN_FPU_ADDSUB(float64_add, float64_sub, float64, double, fabs, DBL_MIN)
 GEN_FPU_MUL(float32_mul, float32, float, fabsf, FLT_MIN)
 GEN_FPU_MUL(float64_mul, float64, double, fabs, DBL_MIN)
 #undef GEN_FPU_MUL
+
+#define GEN_FPU_DIV(name, soft_t, host_t, host_abs_func, min_normal)    \
+    soft_t name(soft_t a, soft_t b, float_status *s)                    \
+    {                                                                   \
+        soft_t ## _input_flush2(&a, &b, s);                             \
+        if (likely(soft_t ## _is_normal(a) &&                           \
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
+            } else if (unlikely(host_abs_func(hr) <= min_normal)) {     \
+                goto soft;                                              \
+            }                                                           \
+            return r;                                                   \
+        }                                                               \
+     soft:                                                              \
+        return soft_ ## soft_t ## _div(a, b, s);                        \
+    }
+
+GEN_FPU_DIV(float32_div, float32, float, fabsf, FLT_MIN)
+GEN_FPU_DIV(float64_div, float64, double, fabs, DBL_MIN)
+#undef GEN_FPU_DIV
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e3f2918..ebc59be 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1176,7 +1176,7 @@ float16 float16_div(float16 a, float16 b, float_status *status)
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 float32_div(float32 a, float32 b, float_status *status)
+float32 soft_float32_div(float32 a, float32 b, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -1185,7 +1185,7 @@ float32 float32_div(float32 a, float32 b, float_status *status)
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 float64_div(float64 a, float64 b, float_status *status)
+float64 soft_float64_div(float64 a, float64 b, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
-- 
2.7.4
