Received: from eggs.gnu.org ([2001:4830:134:3::10]:42180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5W-0002A4-0O
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5R-0000zT-E8
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33073)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5R-0000yO-6V
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:44 -0400
Message-Id: <1521663109-32262-10-git-send-email-cota@braap.org>
In-Reply-To: <1521663109-32262-1-git-send-email-cota@braap.org>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 09/14] hostfloat: support float32/64
 multiplication
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

Note that special-casing "a_is_zero || b_is_zero" pays off--see
the last patch in this series for performance numbers on that.

Performance results for fp-bench run under aarch64-linux-user
on an Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz host:

- before:
mul-single: 86.17 MFlops
mul-double: 87.74 MFlops

- after:
mul-single: 114.74 MFlops
mul-double: 112.33 MFlops

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/hostfloat.h |  2 ++
 include/fpu/softfloat.h |  4 ++--
 fpu/hostfloat.c         | 34 ++++++++++++++++++++++++++++++++++
 fpu/softfloat.c         |  8 ++++----
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/include/fpu/hostfloat.h b/include/fpu/hostfloat.h
index db49efa..7049f7e 100644
--- a/include/fpu/hostfloat.h
+++ b/include/fpu/hostfloat.h
@@ -13,8 +13,10 @@
 
 float32 float32_add(float32 a, float32 b, float_status *status);
 float32 float32_sub(float32 a, float32 b, float_status *status);
+float32 float32_mul(float32 a, float32 b, float_status *status);
 
 float64 float64_add(float64 a, float64 b, float_status *status);
 float64 float64_sub(float64 a, float64 b, float_status *status);
+float64 float64_mul(float64 a, float64 b, float_status *status);
 
 #endif /* HOSTFLOAT_H */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index eb7e9bc..2b07ae8 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -344,7 +344,7 @@ float128 float32_to_float128(float32, float_status *status);
 float32 float32_round_to_int(float32, float_status *status);
 float32 soft_float32_add(float32, float32, float_status *status);
 float32 soft_float32_sub(float32, float32, float_status *status);
-float32 float32_mul(float32, float32, float_status *status);
+float32 soft_float32_mul(float32, float32, float_status *status);
 float32 float32_div(float32, float32, float_status *status);
 float32 float32_rem(float32, float32, float_status *status);
 float32 float32_muladd(float32, float32, float32, int, float_status *status);
@@ -484,7 +484,7 @@ float64 float64_round_to_int(float64, float_status *status);
 float64 float64_trunc_to_int(float64, float_status *status);
 float64 soft_float64_add(float64, float64, float_status *status);
 float64 soft_float64_sub(float64, float64, float_status *status);
-float64 float64_mul(float64, float64, float_status *status);
+float64 soft_float64_mul(float64, float64, float_status *status);
 float64 float64_div(float64, float64, float_status *status);
 float64 float64_rem(float64, float64, float_status *status);
 float64 float64_muladd(float64, float64, float64, int, float_status *status);
diff --git a/fpu/hostfloat.c b/fpu/hostfloat.c
index 502552b..985d6f1 100644
--- a/fpu/hostfloat.c
+++ b/fpu/hostfloat.c
@@ -144,3 +144,37 @@ GEN_INPUT_FLUSH(float64)
 GEN_FPU_ADDSUB(float32_add, float32_sub, float32, float, fabsf, FLT_MIN)
 GEN_FPU_ADDSUB(float64_add, float64_sub, float64, double, fabs, DBL_MIN)
 #undef GEN_FPU_ADDSUB
+
+#define GEN_FPU_MUL(name, soft_t, host_t, host_abs_func, min_normal)    \
+    soft_t name(soft_t a, soft_t b, float_status *s)                    \
+    {                                                                   \
+        soft_t ## _input_flush2(&a, &b, s);                             \
+        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \
+                   (soft_t ## _is_normal(b) || soft_t ## _is_zero(b)) && \
+                   s->float_exception_flags & float_flag_inexact &&     \
+                   s->float_rounding_mode == float_round_nearest_even)) { \
+            if (soft_t ## _is_zero(a) || soft_t ## _is_zero(b)) {       \
+                bool signbit = soft_t ## _is_neg(a) ^ soft_t ## _is_neg(b); \
+                                                                        \
+                return soft_t ## _set_sign(soft_t ## _zero, signbit);   \
+            } else {                                                    \
+                host_t ha = soft_t ## _to_ ## host_t(a);                \
+                host_t hb = soft_t ## _to_ ## host_t(b);                \
+                host_t hr = ha * hb;                                    \
+                soft_t r = host_t ## _to_ ## soft_t(hr);                \
+                                                                        \
+                if (unlikely(soft_t ## _is_infinity(r))) {              \
+                    s->float_exception_flags |= float_flag_overflow;    \
+                } else if (unlikely(host_abs_func(hr) <= min_normal)) { \
+                    goto soft;                                          \
+                }                                                       \
+                return r;                                               \
+            }                                                           \
+        }                                                               \
+    soft:                                                               \
+        return soft_ ## soft_t ## _mul(a, b, s);                        \
+    }
+
+GEN_FPU_MUL(float32_mul, float32, float, fabsf, FLT_MIN)
+GEN_FPU_MUL(float64_mul, float64, double, fabs, DBL_MIN)
+#undef GEN_FPU_MUL
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index bd82adf..e3f2918 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -849,8 +849,8 @@ float16 __attribute__((flatten)) float16_mul(float16 a, float16 b,
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 __attribute__((flatten)) float32_mul(float32 a, float32 b,
-                                             float_status *status)
+float32 __attribute__((flatten))
+soft_float32_mul(float32 a, float32 b, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -859,8 +859,8 @@ float32 __attribute__((flatten)) float32_mul(float32 a, float32 b,
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 __attribute__((flatten)) float64_mul(float64 a, float64 b,
-                                             float_status *status)
+float64 __attribute__((flatten))
+soft_float64_mul(float64 a, float64 b, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
-- 
2.7.4
