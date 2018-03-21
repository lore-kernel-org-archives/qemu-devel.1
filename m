Received: from eggs.gnu.org ([2001:4830:134:3::10]:42162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5V-00029v-U1
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5R-0000zH-Ap
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52375)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5R-0000y7-2s
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:43 -0400
Message-Id: <1521663109-32262-9-git-send-email-cota@braap.org>
In-Reply-To: <1521663109-32262-1-git-send-email-cota@braap.org>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 08/14] hostfloat: support float32/64
 addition and subtraction
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

Performance results (single and double precision) for
fp-bench run under aarch64-linux-user on an Intel(R)
Core(TM) i7-4790K CPU @ 4.00GHz host:

- before:
add-single: 86.74 MFlops
add-double: 86.46 MFlops
sub-single: 83.33 MFlops
sub-double: 84.57 MFlops

- after:
add-single: 188.26 MFlops
add-double: 186.60 MFlops
sub-single: 186.19 MFlops
sub-double: 187.77 MFlops

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/hostfloat.h |  6 ++++++
 include/fpu/softfloat.h |  8 ++++----
 fpu/hostfloat.c         | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 fpu/softfloat.c         | 16 ++++++++--------
 4 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/include/fpu/hostfloat.h b/include/fpu/hostfloat.h
index b01291b..db49efa 100644
--- a/include/fpu/hostfloat.h
+++ b/include/fpu/hostfloat.h
@@ -11,4 +11,10 @@
 #error fpu/hostfloat.h must only be included from softfloat.h
 #endif
 
+float32 float32_add(float32 a, float32 b, float_status *status);
+float32 float32_sub(float32 a, float32 b, float_status *status);
+
+float64 float64_add(float64 a, float64 b, float_status *status);
+float64 float64_sub(float64 a, float64 b, float_status *status);
+
 #endif /* HOSTFLOAT_H */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 8963b68..eb7e9bc 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -342,8 +342,8 @@ float128 float32_to_float128(float32, float_status *status);
 | Software IEC/IEEE single-precision operations.
 *----------------------------------------------------------------------------*/
 float32 float32_round_to_int(float32, float_status *status);
-float32 float32_add(float32, float32, float_status *status);
-float32 float32_sub(float32, float32, float_status *status);
+float32 soft_float32_add(float32, float32, float_status *status);
+float32 soft_float32_sub(float32, float32, float_status *status);
 float32 float32_mul(float32, float32, float_status *status);
 float32 float32_div(float32, float32, float_status *status);
 float32 float32_rem(float32, float32, float_status *status);
@@ -482,8 +482,8 @@ float128 float64_to_float128(float64, float_status *status);
 *----------------------------------------------------------------------------*/
 float64 float64_round_to_int(float64, float_status *status);
 float64 float64_trunc_to_int(float64, float_status *status);
-float64 float64_add(float64, float64, float_status *status);
-float64 float64_sub(float64, float64, float_status *status);
+float64 soft_float64_add(float64, float64, float_status *status);
+float64 soft_float64_sub(float64, float64, float_status *status);
 float64 float64_mul(float64, float64, float_status *status);
 float64 float64_div(float64, float64, float_status *status);
 float64 float64_rem(float64, float64, float_status *status);
diff --git a/fpu/hostfloat.c b/fpu/hostfloat.c
index cab0341..502552b 100644
--- a/fpu/hostfloat.c
+++ b/fpu/hostfloat.c
@@ -94,3 +94,53 @@ GEN_TYPE_CONV(double_to_float64, float64, double)
 GEN_INPUT_FLUSH(float32)
 GEN_INPUT_FLUSH(float64)
 #undef GEN_INPUT_FLUSH
+
+#define GEN_FPU_ADDSUB(add_name, sub_name, soft_t, host_t,              \
+                       host_abs_func, min_normal)                       \
+    static inline __attribute__((always_inline)) soft_t                 \
+    fpu_ ## soft_t ## _addsub(soft_t a, soft_t b, bool subtract,        \
+                              float_status *s)                          \
+    {                                                                   \
+        soft_t ## _input_flush2(&a, &b, s);                             \
+        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \
+                   (soft_t ## _is_normal(b) || soft_t ## _is_zero(b)) && \
+                   s->float_exception_flags & float_flag_inexact &&     \
+                   s->float_rounding_mode == float_round_nearest_even)) { \
+            host_t ha = soft_t ## _to_ ## host_t(a);                    \
+            host_t hb = soft_t ## _to_ ## host_t(b);                    \
+            host_t hr;                                                  \
+            soft_t r;                                                   \
+                                                                        \
+            if (subtract) {                                             \
+                hb = -hb;                                               \
+            }                                                           \
+            hr = ha + hb;                                               \
+            r = host_t ## _to_ ## soft_t(hr);                           \
+            if (unlikely(soft_t ## _is_infinity(r))) {                  \
+                s->float_exception_flags |= float_flag_overflow;        \
+            } else if (unlikely(host_abs_func(hr) <= min_normal)) {     \
+                goto soft;                                              \
+            }                                                           \
+            return r;                                                   \
+        }                                                               \
+    soft:                                                               \
+        if (subtract) {                                                 \
+            return soft_ ## soft_t ## _sub(a, b, s);                    \
+        } else {                                                        \
+            return soft_ ## soft_t ## _add(a, b, s);                    \
+        }                                                               \
+    }                                                                   \
+                                                                        \
+    soft_t add_name(soft_t a, soft_t b, float_status *status)           \
+    {                                                                   \
+        return fpu_ ## soft_t ## _addsub(a, b, false, status);          \
+    }                                                                   \
+                                                                        \
+    soft_t sub_name(soft_t a, soft_t b, float_status *status)           \
+    {                                                                   \
+        return fpu_ ## soft_t ## _addsub(a, b, true, status);           \
+    }                                                                   \
+
+GEN_FPU_ADDSUB(float32_add, float32_sub, float32, float, fabsf, FLT_MIN)
+GEN_FPU_ADDSUB(float64_add, float64_sub, float64, double, fabs, DBL_MIN)
+#undef GEN_FPU_ADDSUB
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index ee615a9..bd82adf 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -738,8 +738,8 @@ float16  __attribute__((flatten)) float16_add(float16 a, float16 b,
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 __attribute__((flatten)) float32_add(float32 a, float32 b,
-                                             float_status *status)
+float32 __attribute__((flatten)) soft_float32_add(float32 a, float32 b,
+                                                  float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -748,8 +748,8 @@ float32 __attribute__((flatten)) float32_add(float32 a, float32 b,
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 __attribute__((flatten)) float64_add(float64 a, float64 b,
-                                             float_status *status)
+float64 __attribute__((flatten)) soft_float64_add(float64 a, float64 b,
+                                                  float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
@@ -768,8 +768,8 @@ float16 __attribute__((flatten)) float16_sub(float16 a, float16 b,
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 __attribute__((flatten)) float32_sub(float32 a, float32 b,
-                                             float_status *status)
+float32 __attribute__((flatten)) soft_float32_sub(float32 a, float32 b,
+                                                  float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -778,8 +778,8 @@ float32 __attribute__((flatten)) float32_sub(float32 a, float32 b,
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 __attribute__((flatten)) float64_sub(float64 a, float64 b,
-                                             float_status *status)
+float64 __attribute__((flatten)) soft_float64_sub(float64 a, float64 b,
+                                                  float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
-- 
2.7.4
