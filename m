Received: from eggs.gnu.org ([2001:4830:134:3::10]:40793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQm-000464-OO
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQi-0003Mm-GF
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fSYQi-0003Ls-9u
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 11 Jun 2018 21:48:59 -0400
Message-Id: <1528768140-17894-14-git-send-email-cota@braap.org>
In-Reply-To: <1528768140-17894-1-git-send-email-cota@braap.org>
References: <1528768140-17894-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 13/14] hardfloat: support float32/64 square
 root
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
sqrt-single: 43.27 MFlops
sqrt-double: 24.81 MFlops
- after:
sqrt-single: 297.94 MFlops
sqrt-double: 210.46 MFlops

2. ARM Aarch64 A57 @ 2.4GHz
- before:
sqrt-single: 12.41 MFlops
sqrt-double: 6.22 MFlops
- after:
sqrt-single: 55.58 MFlops
sqrt-double: 40.63 MFlops

3. IBM POWER8E @ 2.1 GHz
- before:
sqrt-single: 17.01 MFlops
sqrt-double: 9.61 MFlops
- after:
sqrt-single: 104.17 MFlops
sqrt-double: 133.32 MFlops

Here none of the machines got faster from enabling USE_FP. For
instance, on x86_64 sqrt is 23% slower for single precision,
with it enabled, and 17% slower for double precision.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 63cf60c..f89e872 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2812,14 +2812,16 @@ float16 __attribute__((flatten)) float16_sqrt(float16 a, float_status *status)
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 __attribute__((flatten)) float32_sqrt(float32 a, float_status *status)
+static float32 QEMU_SOFTFLOAT_ATTR
+soft_float32_sqrt(float32 a, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pr = sqrt_float(pa, status, &float32_params);
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 __attribute__((flatten)) float64_sqrt(float64 a, float_status *status)
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_float64_sqrt(float64 a, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pr = sqrt_float(pa, status, &float64_params);
@@ -2899,6 +2901,73 @@ float64 float64_silence_nan(float64 a, float_status *status)
     return float64_pack_raw(p);
 }
 
+#define GEN_SQRT_SF(name, soft_t, host_t, host_sqrt_func)               \
+    static soft_t name(soft_t a, float_status *s)                       \
+    {                                                                   \
+        if (QEMU_NO_HARDFLOAT) {                                        \
+            goto soft;                                                  \
+        }                                                               \
+        soft_t ## _input_flush1(&a, s);                                 \
+        if (likely(soft_t ## _is_zero_or_normal(a) &&                   \
+                   !soft_t ## _is_neg(a) &&                             \
+                   can_use_fpu(s))) {                                   \
+            host_t ha = soft_t ## _to_ ## host_t(a);                    \
+            host_t hr = host_sqrt_func(ha);                             \
+                                                                        \
+            return host_t ## _to_ ## soft_t(hr);                        \
+        }                                                               \
+    soft:                                                               \
+        return soft_ ## soft_t ## _sqrt(a, s);                          \
+    }
+
+#define GEN_SQRT_FP(name, soft_t, host_t, host_sqrt_func)               \
+    static soft_t name(soft_t a, float_status *s)                       \
+    {                                                                   \
+        host_t ha;                                                      \
+                                                                        \
+        if (QEMU_NO_HARDFLOAT) {                                        \
+            goto soft;                                                  \
+        }                                                               \
+        soft_t ## _input_flush1(&a, s);                                 \
+        ha = soft_t ## _to_ ## host_t(a);                               \
+        if (likely((fpclassify(ha) == FP_NORMAL ||                      \
+                    fpclassify(ha) == FP_ZERO) &&                       \
+                   !signbit(ha) &&                                      \
+                   can_use_fpu(s))) {                                   \
+            host_t hr = host_sqrt_func(ha);                             \
+                                                                        \
+            return host_t ## _to_ ## soft_t(hr);                        \
+        }                                                               \
+    soft:                                                               \
+        return soft_ ## soft_t ## _sqrt(a, s);                          \
+    }
+
+GEN_SQRT_SF(f32_sqrt, float32, float, sqrtf)
+GEN_SQRT_SF(f64_sqrt, float64, double, sqrt)
+#undef GEN_SQRT_SF
+
+GEN_SQRT_FP(float_sqrt, float32, float, sqrtf)
+GEN_SQRT_FP(double_sqrt, float64, double, sqrt)
+#undef GEN_SQRT_FP
+
+float32 __attribute__((flatten)) float32_sqrt(float32 a, float_status *s)
+{
+    if (QEMU_HARDFLOAT_1F32_USE_FP) {
+        return float_sqrt(a, s);
+    } else {
+        return f32_sqrt(a, s);
+    }
+}
+
+float64 __attribute__((flatten)) float64_sqrt(float64 a, float_status *s)
+{
+    if (QEMU_HARDFLOAT_1F64_USE_FP) {
+        return double_sqrt(a, s);
+    } else {
+        return f64_sqrt(a, s);
+    }
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
-- 
2.7.4
