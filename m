Received: from eggs.gnu.org ([2001:4830:134:3::10]:40804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQm-00046j-RM
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQi-0003MT-8c
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fSYQi-0003Lj-1V
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 11 Jun 2018 21:48:58 -0400
Message-Id: <1528768140-17894-13-git-send-email-cota@braap.org>
In-Reply-To: <1528768140-17894-1-git-send-email-cota@braap.org>
References: <1528768140-17894-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 12/14] hardfloat: support float32/64 fused
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

Performance results for fp-bench:

1. Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
- before:
fma-single: 74.73 MFlops
fma-double: 74.54 MFlops
- after:
fma-single: 203.37 MFlops
fma-double: 169.37 MFlops

2. ARM Aarch64 A57 @ 2.4GHz
- before:
fma-single: 23.24 MFlops
fma-double: 23.70 MFlops
- after:
fma-single: 66.14 MFlops
fma-double: 63.10 MFlops

3. IBM POWER8E @ 2.1 GHz
- before:
fma-single: 37.26 MFlops
fma-double: 37.29 MFlops
- after:
fma-single: 48.90 MFlops
fma-double: 59.51 MFlops

Here having 3FP64 set to 1 pays off for x86_64:
[1] 170.15 vs [0] 153.12 MFlops

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 169 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 4 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index fa6c3b6..63cf60c 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1568,8 +1568,9 @@ float16 __attribute__((flatten)) float16_muladd(float16 a, float16 b, float16 c,
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 __attribute__((flatten)) float32_muladd(float32 a, float32 b, float32 c,
-                                                int flags, float_status *status)
+static float32 QEMU_SOFTFLOAT_ATTR
+soft_float32_muladd(float32 a, float32 b, float32 c, int flags,
+                    float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -1579,8 +1580,9 @@ float32 __attribute__((flatten)) float32_muladd(float32 a, float32 b, float32 c,
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 __attribute__((flatten)) float64_muladd(float64 a, float64 b, float64 c,
-                                                int flags, float_status *status)
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_float64_muladd(float64 a, float64 b, float64 c, int flags,
+                    float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
@@ -1591,6 +1593,165 @@ float64 __attribute__((flatten)) float64_muladd(float64 a, float64 b, float64 c,
 }
 
 /*
+ * FMA generator for softfloat-based condition checks.
+ *
+ * When (a || b) == 0, there's no need to check for under/over flow,
+ * since we know the addend is (normal || 0) and the product is 0.
+ */
+#define GEN_FMA_SF(name, soft_t, host_t, host_fma_f, host_abs_f, min_normal) \
+    static soft_t                                                       \
+    name(soft_t a, soft_t b, soft_t c, int flags, float_status *s)      \
+    {                                                                   \
+        if (QEMU_NO_HARDFLOAT) {                                        \
+            goto soft;                                                  \
+        }                                                               \
+        soft_t ## _input_flush3(&a, &b, &c, s);                         \
+        if (likely(soft_t ## _is_zero_or_normal(a) &&                   \
+                   soft_t ## _is_zero_or_normal(b) &&                   \
+                   soft_t ## _is_zero_or_normal(c) &&                   \
+                   !(flags & float_muladd_halve_result) &&              \
+                   can_use_fpu(s))) {                                   \
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
+                if (unlikely(isinf(hr))) {                              \
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
+/* FMA generator for native floating point condition checks */
+#define GEN_FMA_FP(name, soft_t, host_t, host_fma_f, host_abs_f, min_normal) \
+    static soft_t \
+    name(soft_t a, soft_t b, soft_t c, int flags, float_status *s)      \
+    {                                                                   \
+        host_t ha, hb, hc;                                              \
+                                                                        \
+        if (QEMU_NO_HARDFLOAT) {                                        \
+            goto soft;                                                  \
+        }                                                               \
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
+                   can_use_fpu(s))) {                                   \
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
+GEN_FMA_SF(f32_muladd, float32, float, fmaf, fabsf, FLT_MIN)
+GEN_FMA_SF(f64_muladd, float64, double, fma, fabs, DBL_MIN)
+#undef GEN_FMA_SF
+
+GEN_FMA_FP(float_muladd, float32, float, fmaf, fabsf, FLT_MIN)
+GEN_FMA_FP(double_muladd, float64, double, fma, fabs, DBL_MIN)
+#undef GEN_FMA_FP
+
+float32 __attribute__((flatten))
+float32_muladd(float32 a, float32 b, float32 c, int flags, float_status *s)
+{
+    if (QEMU_HARDFLOAT_3F32_USE_FP) {
+        return float_muladd(a, b, c, flags, s);
+    } else {
+        return f32_muladd(a, b, c, flags, s);
+    }
+}
+
+float64 __attribute__((flatten))
+float64_muladd(float64 a, float64 b, float64 c, int flags, float_status *s)
+{
+    if (QEMU_HARDFLOAT_3F64_USE_FP) {
+        return double_muladd(a, b, c, flags, s);
+    } else {
+        return f64_muladd(a, b, c, flags, s);
+    }
+}
+
+/*
  * Returns the result of dividing the floating-point value `a' by the
  * corresponding value `b'. The operation is performed according to
  * the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-- 
2.7.4
