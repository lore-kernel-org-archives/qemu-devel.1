Received: from eggs.gnu.org ([2001:4830:134:3::10]:35794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFI-0007PB-7h
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFE-0005Nn-DN
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60723)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0hFE-0005Mg-8v
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 27 Mar 2018 01:33:57 -0400
Message-Id: <1522128840-498-12-git-send-email-cota@braap.org>
In-Reply-To: <1522128840-498-1-git-send-email-cota@braap.org>
References: <1522128840-498-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 11/14] hardfloat: support float32/64 fused
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

Performance results for fp-bench run under aarch64-linux-user
on an aarch64 host:

- before:
fma-single: 53.05 MFlops
fma-double: 51.89 MFlops

- after:
fma-single: 110.44 MFlops
fma-double: 101.78 MFlops

- w/ both using float32/64_is_normal etc.:
fma-single: 110.57 MFlops
fma-double: 93.93 MFlops

- w/ both using fpclassify etc.:
fma-single: 102.86 MFlops
fma-double: 101.71 MFlops

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 4 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f414b41..2dedb13 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1348,8 +1348,9 @@ float16 __attribute__((flatten)) float16_muladd(float16 a, float16 b, float16 c,
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 __attribute__((flatten)) float32_muladd(float32 a, float32 b, float32 c,
-                                                int flags, float_status *status)
+static float32 __attribute__((flatten, noinline))
+soft_float32_muladd(float32 a, float32 b, float32 c, int flags,
+                    float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -1359,8 +1360,9 @@ float32 __attribute__((flatten)) float32_muladd(float32 a, float32 b, float32 c,
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 __attribute__((flatten)) float64_muladd(float64 a, float64 b, float64 c,
-                                                int flags, float_status *status)
+static float64 __attribute__((flatten, noinline))
+soft_float64_muladd(float64 a, float64 b, float64 c, int flags,
+                    float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
@@ -1371,6 +1373,134 @@ float64 __attribute__((flatten)) float64_muladd(float64 a, float64 b, float64 c,
 }
 
 /*
+ * When (a || b) == 0, there's no need to check for under/over flow,
+ * since we know the addend is (normal || 0) and the product is 0.
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
+#undef GEN_FPU_FMA
+
+#define GEN_FPU_FMA(name, soft_t, host_t, host_fma_f, host_abs_f, min_normal) \
+    soft_t name(soft_t a, soft_t b, soft_t c, int flags, float_status *s) \
+    {                                                                   \
+        host_t ha, hb, hc;                                              \
+                                                                        \
+        soft_t ## _input_flush3(&a, &b, &c, s);                         \
+        ha = soft_t ## _to_ ## host_t(a);                               \
+        hb = soft_t ## _to_ ## host_t(b);                               \
+        hc = soft_t ## _to_ ## host_t(c);                               \
+        if (likely((fpclassify(ha) == FP_NORMAL ||                      \
+                    fpclassify(ha) == FP_ZERO) &&                       \
+                   (fpclassify(hb) == FP_NORMAL ||                      \
+                    fpclassify(hb) == FP_ZERO) &&                       \
+                   (fpclassify(hc) == FP_NORMAL ||                      \
+                    fpclassify(hc) == FP_ZERO) &&                       \
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
+                host_t hr;                                              \
+                                                                        \
+                if (flags & float_muladd_negate_product) {              \
+                    ha = -ha;                                           \
+                }                                                       \
+                if (flags & float_muladd_negate_c) {                    \
+                    hc = -hc;                                           \
+                }                                                       \
+                hr = host_fma_f(ha, hb, hc);                            \
+                if (unlikely(isinf(hr))) {                              \
+                    s->float_exception_flags |= float_flag_overflow;    \
+                } else if (unlikely(host_abs_f(hr) <= min_normal)) {    \
+                    goto soft;                                          \
+                }                                                       \
+                if (flags & float_muladd_negate_result) {               \
+                    hr = -hr;                                           \
+                }                                                       \
+                return host_t ## _to_ ## soft_t(hr);                    \
+            }                                                           \
+        }                                                               \
+    soft:                                                               \
+        return soft_ ## soft_t ## _muladd(a, b, c, flags, s);           \
+    }
+
+GEN_FPU_FMA(float64_muladd, float64, double, fma, fabs, DBL_MIN)
+#undef GEN_FPU_FMA
+
+/*
  * Returns the result of dividing the floating-point value `a' by the
  * corresponding value `b'. The operation is performed according to
  * the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-- 
2.7.4
