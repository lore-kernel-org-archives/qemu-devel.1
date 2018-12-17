Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqbg-0002Y7-60
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqa7-0000BY-FN
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:57:04 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:35762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gYqa7-0000Ah-75
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:57:03 -0500
Received: by mail-wm1-x332.google.com with SMTP id c126so12101386wmh.0
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 02:57:03 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Dec 2018 10:56:46 +0000
Message-Id: <20181217105650.27361-12-alex.bennee@linaro.org>
In-Reply-To: <20181217105650.27361-1-alex.bennee@linaro.org>
References: <20181217105650.27361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 11/15] hardfloat: implement float32/64
 multiplication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: "Emilio G. Cota" <cota@braap.org>

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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 08afa861a7..dad2ce2d9f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1236,7 +1236,8 @@ float16 QEMU_FLATTEN float16_mul(float16 a, float16 b, float_status *status)
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 QEMU_FLATTEN float32_mul(float32 a, float32 b, float_status *status)
+static float32 QEMU_SOFTFLOAT_ATTR
+soft_f32_mul(float32 a, float32 b, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -1245,7 +1246,8 @@ float32 QEMU_FLATTEN float32_mul(float32 a, float32 b, float_status *status)
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 QEMU_FLATTEN float64_mul(float64 a, float64 b, float_status *status)
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_f64_mul(float64 a, float64 b, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
@@ -1254,6 +1256,54 @@ float64 QEMU_FLATTEN float64_mul(float64 a, float64 b, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+static float hard_f32_mul(float a, float b)
+{
+    return a * b;
+}
+
+static double hard_f64_mul(double a, double b)
+{
+    return a * b;
+}
+
+static bool f32_mul_fast_test(union_float32 a, union_float32 b)
+{
+    return float32_is_zero(a.s) || float32_is_zero(b.s);
+}
+
+static bool f64_mul_fast_test(union_float64 a, union_float64 b)
+{
+    return float64_is_zero(a.s) || float64_is_zero(b.s);
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
+float32 QEMU_FLATTEN
+float32_mul(float32 a, float32 b, float_status *s)
+{
+    return float32_gen2(a, b, s, hard_f32_mul, soft_f32_mul,
+                        f32_is_zon2, NULL, f32_mul_fast_test, f32_mul_fast_op);
+}
+
+float64 QEMU_FLATTEN
+float64_mul(float64 a, float64 b, float_status *s)
+{
+    return float64_gen2(a, b, s, hard_f64_mul, soft_f64_mul,
+                        f64_is_zon2, NULL, f64_mul_fast_test, f64_mul_fast_op);
+}
+
 /*
  * Returns the result of multiplying the floating-point values `a' and
  * `b' then adding 'c', with no intermediate rounding step after the
-- 
2.17.1
