Received: from eggs.gnu.org ([2001:4830:134:3::10]:40800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQm-00046e-Q8
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQi-0003MO-9j
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fSYQi-0003LE-0V
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 11 Jun 2018 21:48:57 -0400
Message-Id: <1528768140-17894-12-git-send-email-cota@braap.org>
In-Reply-To: <1528768140-17894-1-git-send-email-cota@braap.org>
References: <1528768140-17894-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 11/14] hardfloat: support float32/64 division
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
div-single: 34.84 MFlops
div-double: 34.04 MFlops
- after:
div-single: 275.23 MFlops
div-double: 216.38 MFlops

2. ARM Aarch64 A57 @ 2.4GHz
- before:
div-single: 9.33 MFlops
div-double: 9.30 MFlops
- after:
div-single: 51.55 MFlops
div-double: 15.09 MFlops

3. IBM POWER8E @ 2.1 GHz
- before:
div-single: 25.65 MFlops
div-double: 24.91 MFlops
- after:
div-single: 96.83 MFlops
div-double: 31.01 MFlops

Here setting 2FP64_USE_FP to 1 pays off for x86_64:
[1] 215.97 vs [0] 62.15 MFlops

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 4fcabf6..fa6c3b6 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1659,7 +1659,8 @@ float16 float16_div(float16 a, float16 b, float_status *status)
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 float32_div(float32 a, float32 b, float_status *status)
+static float32 QEMU_SOFTFLOAT_ATTR
+soft_float32_div(float32 a, float32 b, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -1668,7 +1669,8 @@ float32 float32_div(float32 a, float32 b, float_status *status)
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 float64_div(float64 a, float64 b, float_status *status)
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_float64_div(float64 a, float64 b, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
@@ -1677,6 +1679,88 @@ float64 float64_div(float64 a, float64 b, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+static float float_div(float a, float b)
+{
+    return a / b;
+}
+
+static double double_div(double a, double b)
+{
+    return a / b;
+}
+
+static bool f32_div_pre(float32 a, float32 b, const struct float_status *s)
+{
+    return likely(float32_is_zero_or_normal(a) &&
+                  float32_is_normal(b) &&
+                  can_use_fpu(s));
+}
+
+static bool f64_div_pre(float64 a, float64 b, const struct float_status *s)
+{
+    return likely(float64_is_zero_or_normal(a) &&
+                  float64_is_normal(b) &&
+                  can_use_fpu(s));
+}
+
+static bool float_div_pre(float a, float b, const struct float_status *s)
+{
+    return likely((fpclassify(a) == FP_NORMAL || fpclassify(a) == FP_ZERO) &&
+                  fpclassify(b) == FP_NORMAL &&
+                  can_use_fpu(s));
+}
+
+static bool double_div_pre(double a, double b, const struct float_status *s)
+{
+    return likely((fpclassify(a) == FP_NORMAL || fpclassify(a) == FP_ZERO) &&
+                  fpclassify(b) == FP_NORMAL &&
+                  can_use_fpu(s));
+}
+
+static bool f32_div_post(float32 a, float32 b, const struct float_status *s)
+{
+    return !float32_is_zero(a);
+}
+
+static bool f64_div_post(float64 a, float64 b, const struct float_status *s)
+{
+    return !float64_is_zero(a);
+}
+
+static bool float_div_post(float a, float b, const struct float_status *s)
+{
+    return fpclassify(a) != FP_ZERO;
+}
+
+static bool double_div_post(double a, double b, const struct float_status *s)
+{
+    return fpclassify(a) != FP_ZERO;
+}
+
+float32 __attribute__((flatten))
+float32_div(float32 a, float32 b, float_status *s)
+{
+    if (QEMU_HARDFLOAT_2F32_USE_FP) {
+        return float_gen2(a, b, s, float_div, soft_float32_div, float_div_pre,
+                          float_div_post, NULL, NULL);
+    } else {
+        return f32_gen2(a, b, s, float_div, soft_float32_div, f32_div_pre,
+                        f32_div_post, NULL, NULL);
+    }
+}
+
+float64 __attribute__((flatten))
+float64_div(float64 a, float64 b, float_status *s)
+{
+    if (QEMU_HARDFLOAT_2F64_USE_FP) {
+        return double_gen2(a, b, s, double_div, soft_float64_div,
+                           double_div_pre, double_div_post, NULL, NULL);
+    } else {
+        return f64_gen2(a, b, s, double_div, soft_float64_div, f64_div_pre,
+                        f64_div_post, NULL, NULL);
+    }
+}
+
 /*
  * Float to Float conversions
  *
-- 
2.7.4
