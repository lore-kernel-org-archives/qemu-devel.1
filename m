Received: from eggs.gnu.org ([2001:4830:134:3::10]:40797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQm-00046W-Qb
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQi-0003Lo-1H
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fSYQh-0003L8-Ub
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 11 Jun 2018 21:48:56 -0400
Message-Id: <1528768140-17894-11-git-send-email-cota@braap.org>
In-Reply-To: <1528768140-17894-1-git-send-email-cota@braap.org>
References: <1528768140-17894-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 10/14] hardfloat: support float32/64
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

Performance results for fp-bench:

1. Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
- before:
mul-single: 126.91 MFlops
mul-double: 118.28 MFlops
- after:
mul-single: 258.02 MFlops
mul-double: 197.96 MFlops

2. ARM Aarch64 A57 @ 2.4GHz
- before:
mul-single: 37.42 MFlops
mul-double: 38.77 MFlops
- after:
mul-single: 73.41 MFlops
mul-double: 76.93 MFlops

3. IBM POWER8E @ 2.1 GHz
- before:
mul-single: 58.40 MFlops
mul-double: 59.33 MFlops
- after:
mul-single: 60.25 MFlops
mul-double: 94.79 MFlops

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index cdce6b2..4fcabf6 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1276,8 +1276,8 @@ float16 __attribute__((flatten)) float16_mul(float16 a, float16 b,
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 __attribute__((flatten)) float32_mul(float32 a, float32 b,
-                                             float_status *status)
+static float32 QEMU_SOFTFLOAT_ATTR
+soft_float32_mul(float32 a, float32 b, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -1286,8 +1286,8 @@ float32 __attribute__((flatten)) float32_mul(float32 a, float32 b,
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 __attribute__((flatten)) float64_mul(float64 a, float64 b,
-                                             float_status *status)
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_float64_mul(float64 a, float64 b, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
@@ -1296,6 +1296,64 @@ float64 __attribute__((flatten)) float64_mul(float64 a, float64 b,
     return float64_round_pack_canonical(pr, status);
 }
 
+static float float_mul(float a, float b)
+{
+    return a * b;
+}
+
+static double double_mul(double a, double b)
+{
+    return a * b;
+}
+
+static bool f32_mul_fast(float32 a, float32 b, const struct float_status *s)
+{
+    return float32_is_zero(a) || float32_is_zero(b);
+}
+
+static bool f64_mul_fast(float64 a, float64 b, const struct float_status *s)
+{
+    return float64_is_zero(a) || float64_is_zero(b);
+}
+
+static float32 f32_mul_fast_op(float32 a, float32 b, float_status *s)
+{
+    bool signbit = float32_is_neg(a) ^ float32_is_neg(b);
+
+    return float32_set_sign(float32_zero, signbit);
+}
+
+static float64 f64_mul_fast_op(float64 a, float64 b, float_status *s)
+{
+    bool signbit = float64_is_neg(a) ^ float64_is_neg(b);
+
+    return float64_set_sign(float64_zero, signbit);
+}
+
+float32 __attribute__((flatten))
+float32_mul(float32 a, float32 b, float_status *s)
+{
+    if (QEMU_HARDFLOAT_2F32_USE_FP) {
+        return float_gen2(a, b, s, float_mul, soft_float32_mul, float_is_zon2,
+                          NULL, f32_mul_fast, f32_mul_fast_op);
+    } else {
+        return f32_gen2(a, b, s, float_mul, soft_float32_mul, f32_is_zon2, NULL,
+                        f32_mul_fast, f32_mul_fast_op);
+    }
+}
+
+float64 __attribute__((flatten))
+float64_mul(float64 a, float64 b, float_status *s)
+{
+    if (QEMU_HARDFLOAT_2F64_USE_FP) {
+        return double_gen2(a, b, s, double_mul, soft_float64_mul,
+                           double_is_zon2, NULL, f64_mul_fast, f64_mul_fast_op);
+    } else {
+        return f64_gen2(a, b, s, double_mul, soft_float64_mul, f64_is_zon2,
+                        NULL, f64_mul_fast, f64_mul_fast_op);
+    }
+}
+
 /*
  * Returns the result of multiplying the floating-point values `a' and
  * `b' then adding 'c', with no intermediate rounding step after the
-- 
2.7.4
