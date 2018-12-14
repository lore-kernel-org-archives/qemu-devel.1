Received: from eggs.gnu.org ([2001:4830:134:3::10]:49272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnvs-0008VR-7B
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnvm-0001zQ-0l
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:12 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXnvl-0001yv-Pm
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:05 -0500
Received: by mail-wm1-x329.google.com with SMTP id y1so5744184wmi.3
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 05:55:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 14 Dec 2018 13:54:49 +0000
Message-Id: <20181214135452.25936-13-alex.bennee@linaro.org>
In-Reply-To: <20181214135452.25936-1-alex.bennee@linaro.org>
References: <20181214135452.25936-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/15] hardfloat: implement float32/64 division
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index dad2ce2d9f..82294458fe 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1628,7 +1628,8 @@ float16 float16_div(float16 a, float16 b, float_status *status)
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 float32_div(float32 a, float32 b, float_status *status)
+static float32 QEMU_SOFTFLOAT_ATTR
+soft_f32_div(float32 a, float32 b, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -1637,7 +1638,8 @@ float32 float32_div(float32 a, float32 b, float_status *status)
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 float64_div(float64 a, float64 b, float_status *status)
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_f64_div(float64 a, float64 b, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
@@ -1646,6 +1648,64 @@ float64 float64_div(float64 a, float64 b, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+static float hard_f32_div(float a, float b)
+{
+    return a / b;
+}
+
+static double hard_f64_div(double a, double b)
+{
+    return a / b;
+}
+
+static bool f32_div_pre(union_float32 a, union_float32 b)
+{
+    if (QEMU_HARDFLOAT_2F32_USE_FP) {
+        return (fpclassify(a.h) == FP_NORMAL || fpclassify(a.h) == FP_ZERO) &&
+               fpclassify(b.h) == FP_NORMAL;
+    }
+    return float32_is_zero_or_normal(a.s) && float32_is_normal(b.s);
+}
+
+static bool f64_div_pre(union_float64 a, union_float64 b)
+{
+    if (QEMU_HARDFLOAT_2F64_USE_FP) {
+        return (fpclassify(a.h) == FP_NORMAL || fpclassify(a.h) == FP_ZERO) &&
+               fpclassify(b.h) == FP_NORMAL;
+    }
+    return float64_is_zero_or_normal(a.s) && float64_is_normal(b.s);
+}
+
+static bool f32_div_post(union_float32 a, union_float32 b)
+{
+    if (QEMU_HARDFLOAT_2F32_USE_FP) {
+        return fpclassify(a.h) != FP_ZERO;
+    }
+    return !float32_is_zero(a.s);
+}
+
+static bool f64_div_post(union_float64 a, union_float64 b)
+{
+    if (QEMU_HARDFLOAT_2F64_USE_FP) {
+        return fpclassify(a.h) != FP_ZERO;
+    }
+    return !float64_is_zero(a.s);
+}
+
+float32 QEMU_FLATTEN
+float32_div(float32 a, float32 b, float_status *s)
+{
+    return float32_gen2(a, b, s, hard_f32_div, soft_f32_div,
+                        f32_div_pre, f32_div_post, NULL, NULL);
+}
+
+float64 QEMU_FLATTEN
+float64_div(float64 a, float64 b, float_status *s)
+{
+    return float64_gen2(a, b, s, hard_f64_div, soft_f64_div,
+                        f64_div_pre, f64_div_post, NULL, NULL);
+}
+
 /*
  * Float to Float conversions
  *
-- 
2.17.1
