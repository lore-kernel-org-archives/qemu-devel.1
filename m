Received: from eggs.gnu.org ([2001:4830:134:3::10]:42166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5V-00029y-V2
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5R-0000zj-Jb
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5R-0000yo-EL
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:46 -0400
Message-Id: <1521663109-32262-12-git-send-email-cota@braap.org>
In-Reply-To: <1521663109-32262-1-git-send-email-cota@braap.org>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 11/14] hostfloat: support float32/64 fused
 multiply-add
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
on an aarch64 host:

- before:
fma-single: 53.05 MFlops
fma-double: 51.89 MFlops

- after:
fma-single: 113.93 MFlops
fma-double: 113.04 MFlops

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/hostfloat.h |  2 ++
 include/fpu/softfloat.h |  4 ++--
 fpu/hostfloat.c         | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 fpu/softfloat.c         | 10 ++++----
 4 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/include/fpu/hostfloat.h b/include/fpu/hostfloat.h
index 61a8525..c006576 100644
--- a/include/fpu/hostfloat.h
+++ b/include/fpu/hostfloat.h
@@ -15,10 +15,12 @@ float32 float32_add(float32 a, float32 b, float_status *status);
 float32 float32_sub(float32 a, float32 b, float_status *status);
 float32 float32_mul(float32 a, float32 b, float_status *status);
 float32 float32_div(float32 a, float32 b, float_status *status);
+float32 float32_muladd(float32 a, float32 b, float32 c, int f, float_status *s);
 
 float64 float64_add(float64 a, float64 b, float_status *status);
 float64 float64_sub(float64 a, float64 b, float_status *status);
 float64 float64_mul(float64 a, float64 b, float_status *status);
 float64 float64_div(float64 a, float64 b, float_status *status);
+float64 float64_muladd(float64 a, float64 b, float64 c, int f, float_status *s);
 
 #endif /* HOSTFLOAT_H */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index a690a57..866bd3b 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -347,7 +347,7 @@ float32 soft_float32_sub(float32, float32, float_status *status);
 float32 soft_float32_mul(float32, float32, float_status *status);
 float32 soft_float32_div(float32, float32, float_status *status);
 float32 float32_rem(float32, float32, float_status *status);
-float32 float32_muladd(float32, float32, float32, int, float_status *status);
+float32 soft_float32_muladd(float32, float32, float32, int, float_status *s);
 float32 float32_sqrt(float32, float_status *status);
 float32 float32_exp2(float32, float_status *status);
 float32 float32_log2(float32, float_status *status);
@@ -487,7 +487,7 @@ float64 soft_float64_sub(float64, float64, float_status *status);
 float64 soft_float64_mul(float64, float64, float_status *status);
 float64 soft_float64_div(float64, float64, float_status *status);
 float64 float64_rem(float64, float64, float_status *status);
-float64 float64_muladd(float64, float64, float64, int, float_status *status);
+float64 soft_float64_muladd(float64, float64, float64, int, float_status *s);
 float64 float64_sqrt(float64, float_status *status);
 float64 float64_log2(float64, float_status *status);
 int float64_eq(float64, float64, float_status *status);
diff --git a/fpu/hostfloat.c b/fpu/hostfloat.c
index ff980ac..a56b70a 100644
--- a/fpu/hostfloat.c
+++ b/fpu/hostfloat.c
@@ -206,3 +206,67 @@ GEN_FPU_MUL(float64_mul, float64, double, fabs, DBL_MIN)
 GEN_FPU_DIV(float32_div, float32, float, fabsf, FLT_MIN)
 GEN_FPU_DIV(float64_div, float64, double, fabs, DBL_MIN)
 #undef GEN_FPU_DIV
+
+/*
+ * When (a || b) == 0, there's no need to check for overflow, since we
+ * know the addend is normal || zero and the product is zero.
+ */
+#define GEN_FPU_FMA(name, soft_t, host_t, host_fma_f, host_abs_f, min_normal) \
+    soft_t name(soft_t a, soft_t b, soft_t c, int flags, float_status *s) \
+    {                                                                   \
+        soft_t ## _input_flush3(&a, &b, &c, s);                         \
+        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \
+                   (soft_t ## _is_normal(b) || soft_t ## _is_zero(b)) && \
+                   (soft_t ## _is_normal(c) || soft_t ## _is_zero(c)) && \
+                   !(flags & float_muladd_halve_result) &&              \
+                   s->float_exception_flags & float_flag_inexact &&     \
+                   s->float_rounding_mode == float_round_nearest_even)) { \
+            if (soft_t ## _is_zero(a) || soft_t ## _is_zero(b)) {       \
+                soft_t p, r;                                            \
+                host_t hp, hc, hr;                                      \
+                bool prod_sign;                                         \
+                                                                        \
+                prod_sign = soft_t ## _is_neg(a) ^ soft_t ## _is_neg(b); \
+                prod_sign ^= !!(flags & float_muladd_negate_product);   \
+                p = soft_t ## _set_sign(soft_t ## _zero, prod_sign);    \
+                                                                        \
+                if (flags & float_muladd_negate_c) {                    \
+                    c = soft_t ## _chs(c);                              \
+                }                                                       \
+                                                                        \
+                hp = soft_t ## _to_ ## host_t(p);                       \
+                hc = soft_t ## _to_ ## host_t(c);                       \
+                hr = hp + hc;                                           \
+                r = host_t ## _to_ ## soft_t(hr);                       \
+                return flags & float_muladd_negate_result ?             \
+                    soft_t ## _chs(r) : r;                              \
+            } else {                                                    \
+                host_t ha, hb, hc, hr;                                  \
+                soft_t r;                                               \
+                soft_t sa = flags & float_muladd_negate_product ?       \
+                    soft_t ## _chs(a) : a;                              \
+                soft_t sc = flags & float_muladd_negate_c ?             \
+                    soft_t ## _chs(c) : c;                              \
+                                                                        \
+                ha = soft_t ## _to_ ## host_t(sa);                      \
+                hb = soft_t ## _to_ ## host_t(b);                       \
+                hc = soft_t ## _to_ ## host_t(sc);                      \
+                hr = host_fma_f(ha, hb, hc);                            \
+                r = host_t ## _to_ ## soft_t(hr);                       \
+                                                                        \
+                if (unlikely(soft_t ## _is_infinity(r))) {              \
+                    s->float_exception_flags |= float_flag_overflow;    \
+                } else if (unlikely(host_abs_f(hr) <= min_normal)) {    \
+                    goto soft;                                          \
+                }                                                       \
+                return flags & float_muladd_negate_result ?             \
+                    soft_t ## _chs(r) : r;                              \
+            }                                                           \
+        }                                                               \
+    soft:                                                               \
+        return soft_ ## soft_t ## _muladd(a, b, c, flags, s);           \
+    }
+
+GEN_FPU_FMA(float32_muladd, float32, float, fmaf, fabsf, FLT_MIN)
+GEN_FPU_FMA(float64_muladd, float64, double, fma, fabs, DBL_MIN)
+#undef GEN_FPU_FMA
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index ebc59be..da81ec9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1084,8 +1084,9 @@ float16 __attribute__((flatten)) float16_muladd(float16 a, float16 b, float16 c,
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 __attribute__((flatten)) float32_muladd(float32 a, float32 b, float32 c,
-                                                int flags, float_status *status)
+float32 __attribute__((flatten))
+soft_float32_muladd(float32 a, float32 b, float32 c, int flags,
+                    float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -1095,8 +1096,9 @@ float32 __attribute__((flatten)) float32_muladd(float32 a, float32 b, float32 c,
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 __attribute__((flatten)) float64_muladd(float64 a, float64 b, float64 c,
-                                                int flags, float_status *status)
+float64 __attribute__((flatten))
+soft_float64_muladd(float64 a, float64 b, float64 c, int flags,
+                    float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
-- 
2.7.4
