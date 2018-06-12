Received: from eggs.gnu.org ([2001:4830:134:3::10]:40799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQm-00046a-QO
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQi-0003Mc-9I
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35109)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fSYQh-0003L7-WA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 11 Jun 2018 21:48:55 -0400
Message-Id: <1528768140-17894-10-git-send-email-cota@braap.org>
In-Reply-To: <1528768140-17894-1-git-send-email-cota@braap.org>
References: <1528768140-17894-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 09/14] hardfloat: support float32/64
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

Performance results (single and double precision) for fp-bench:

1. Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
- before:
add-single: 135.07 MFlops
add-double: 131.60 MFlops
sub-single: 130.04 MFlops
sub-double: 133.01 MFlops
- after:
add-single: 443.04 MFlops
add-double: 301.95 MFlops
sub-single: 411.36 MFlops
sub-double: 293.15 MFlops

2. ARM Aarch64 A57 @ 2.4GHz
- before:
add-single: 44.79 MFlops
add-double: 49.20 MFlops
sub-single: 44.55 MFlops
sub-double: 49.06 MFlops
- after:
add-single: 93.28 MFlops
add-double: 88.27 MFlops
sub-single: 91.47 MFlops
sub-double: 88.27 MFlops

3. IBM POWER8E @ 2.1 GHz
- before:
add-single: 72.59 MFlops
add-double: 72.27 MFlops
sub-single: 75.33 MFlops
sub-double: 70.54 MFlops
- after:
add-single: 112.95 MFlops
add-double: 201.11 MFlops
sub-single: 116.80 MFlops
sub-double: 188.72 MFlops

Note that the IBM and ARM machines benefit from having
HARDFLOAT_2F{32,64}_USE_FP set to 0. Otherwise their performance
can suffer significantly:
- IBM Power8:
add-single: [1] 54.94 vs [0] 116.37 MFlops
add-double: [1] 58.92 vs [0] 201.44 MFlops
- Aarch64 A57:
add-single: [1] 80.72 vs [0] 93.24 MFlops
add-double: [1] 82.10 vs [0] 88.18 MFlops

On the Intel machine, having 2F64 set to 1 pays off, but it
doesn't for 2F32:
- Intel i7-6700K:
add-single: [1] 285.79 vs [0] 426.70 MFlops
add-double: [1] 302.15 vs [0] 278.82 MFlops

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 8 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 4d378d7..cdce6b2 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1077,8 +1077,8 @@ float16  __attribute__((flatten)) float16_add(float16 a, float16 b,
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 __attribute__((flatten)) float32_add(float32 a, float32 b,
-                                             float_status *status)
+static float32 QEMU_SOFTFLOAT_ATTR
+soft_float32_add(float32 a, float32 b, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -1087,8 +1087,8 @@ float32 __attribute__((flatten)) float32_add(float32 a, float32 b,
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 __attribute__((flatten)) float64_add(float64 a, float64 b,
-                                             float_status *status)
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_float64_add(float64 a, float64 b, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
@@ -1107,8 +1107,8 @@ float16 __attribute__((flatten)) float16_sub(float16 a, float16 b,
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 __attribute__((flatten)) float32_sub(float32 a, float32 b,
-                                             float_status *status)
+static float32 QEMU_SOFTFLOAT_ATTR
+soft_float32_sub(float32 a, float32 b, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -1117,8 +1117,8 @@ float32 __attribute__((flatten)) float32_sub(float32 a, float32 b,
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 __attribute__((flatten)) float64_sub(float64 a, float64 b,
-                                             float_status *status)
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_float64_sub(float64 a, float64 b, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
@@ -1127,6 +1127,96 @@ float64 __attribute__((flatten)) float64_sub(float64 a, float64 b,
     return float64_round_pack_canonical(pr, status);
 }
 
+static float float_add(float a, float b)
+{
+    return a + b;
+}
+
+static float float_sub(float a, float b)
+{
+    return a - b;
+}
+
+static double double_add(double a, double b)
+{
+    return a + b;
+}
+
+static double double_sub(double a, double b)
+{
+    return a - b;
+}
+
+static bool f32_addsub_post(float32 a, float32 b, const struct float_status *s)
+{
+    return !(float32_is_zero(a) && float32_is_zero(b));
+}
+
+static bool
+float_addsub_post(float a, float b, const struct float_status *s)
+{
+    return !(fpclassify(a) == FP_ZERO && fpclassify(b) == FP_ZERO);
+}
+
+static bool f64_addsub_post(float64 a, float64 b, const struct float_status *s)
+{
+    return !(float64_is_zero(a) && float64_is_zero(b));
+}
+
+static bool
+double_addsub_post(double a, double b, const struct float_status *s)
+{
+    return !(fpclassify(a) == FP_ZERO && fpclassify(b) == FP_ZERO);
+}
+
+static float32 float32_addsub(float32 a, float32 b, float_status *s,
+                              float_op2_func_t hard, f32_op2_func_t soft)
+{
+    if (QEMU_HARDFLOAT_2F32_USE_FP) {
+        return float_gen2(a, b, s, hard, soft, float_is_zon2, float_addsub_post,
+                          NULL, NULL);
+    } else {
+        return f32_gen2(a, b, s, hard, soft, f32_is_zon2, f32_addsub_post,
+                        NULL, NULL);
+    }
+}
+
+static float64 float64_addsub(float64 a, float64 b, float_status *s,
+                              double_op2_func_t hard, f64_op2_func_t soft)
+{
+    if (QEMU_HARDFLOAT_2F64_USE_FP) {
+        return double_gen2(a, b, s, hard, soft, double_is_zon2,
+                           double_addsub_post, NULL, NULL);
+    } else {
+        return f64_gen2(a, b, s, hard, soft, f64_is_zon2, f64_addsub_post,
+                        NULL, NULL);
+    }
+}
+
+float32 __attribute__((flatten))
+float32_add(float32 a, float32 b, float_status *s)
+{
+    return float32_addsub(a, b, s, float_add, soft_float32_add);
+}
+
+float32 __attribute__((flatten))
+float32_sub(float32 a, float32 b, float_status *s)
+{
+    return float32_addsub(a, b, s, float_sub, soft_float32_sub);
+}
+
+float64 __attribute__((flatten))
+float64_add(float64 a, float64 b, float_status *s)
+{
+    return float64_addsub(a, b, s, double_add, soft_float64_add);
+}
+
+float64 __attribute__((flatten))
+float64_sub(float64 a, float64 b, float_status *s)
+{
+    return float64_addsub(a, b, s, double_sub, soft_float64_sub);
+}
+
 /*
  * Returns the result of multiplying the floating-point values `a' and
  * `b'. The operation is performed according to the IEC/IEEE Standard
-- 
2.7.4
