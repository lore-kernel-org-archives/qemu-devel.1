Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqbW-0002Y7-KI
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:58:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqa8-0000C1-9N
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:57:09 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gYqa8-0000BI-0h
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:57:04 -0500
Received: by mail-wm1-x344.google.com with SMTP id m1so11885606wml.2
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 02:57:03 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Dec 2018 10:56:49 +0000
Message-Id: <20181217105650.27361-15-alex.bennee@linaro.org>
In-Reply-To: <20181217105650.27361-1-alex.bennee@linaro.org>
References: <20181217105650.27361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 14/15] hardfloat: implement float32/64 square
 root
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

Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
- before:
sqrt-single: 42.30 MFlops
sqrt-double: 22.97 MFlops
- after:
sqrt-single: 311.42 MFlops
sqrt-double: 311.08 MFlops

Here USE_FP makes a huge difference for f64's, with throughput
going from ~200 MFlops to ~300 MFlops.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7554d63495..fbd66fd8dc 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3044,20 +3044,76 @@ float16 QEMU_FLATTEN float16_sqrt(float16 a, float_status *status)
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 QEMU_FLATTEN float32_sqrt(float32 a, float_status *status)
+static float32 QEMU_SOFTFLOAT_ATTR
+soft_f32_sqrt(float32 a, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pr = sqrt_float(pa, status, &float32_params);
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 QEMU_FLATTEN float64_sqrt(float64 a, float_status *status)
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_f64_sqrt(float64 a, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pr = sqrt_float(pa, status, &float64_params);
     return float64_round_pack_canonical(pr, status);
 }
 
+float32 QEMU_FLATTEN float32_sqrt(float32 xa, float_status *s)
+{
+    union_float32 ua, ur;
+
+    ua.s = xa;
+    if (unlikely(!can_use_fpu(s))) {
+        goto soft;
+    }
+
+    float32_input_flush1(&ua.s, s);
+    if (QEMU_HARDFLOAT_1F32_USE_FP) {
+        if (unlikely(!(fpclassify(ua.h) == FP_NORMAL ||
+                       fpclassify(ua.h) == FP_ZERO) ||
+                     signbit(ua.h))) {
+            goto soft;
+        }
+    } else if (unlikely(!float32_is_zero_or_normal(ua.s) ||
+                        float32_is_neg(ua.s))) {
+        goto soft;
+    }
+    ur.h = sqrtf(ua.h);
+    return ur.s;
+
+ soft:
+    return soft_f32_sqrt(ua.s, s);
+}
+
+float64 QEMU_FLATTEN float64_sqrt(float64 xa, float_status *s)
+{
+    union_float64 ua, ur;
+
+    ua.s = xa;
+    if (unlikely(!can_use_fpu(s))) {
+        goto soft;
+    }
+
+    float64_input_flush1(&ua.s, s);
+    if (QEMU_HARDFLOAT_1F64_USE_FP) {
+        if (unlikely(!(fpclassify(ua.h) == FP_NORMAL ||
+                       fpclassify(ua.h) == FP_ZERO) ||
+                     signbit(ua.h))) {
+            goto soft;
+        }
+    } else if (unlikely(!float64_is_zero_or_normal(ua.s) ||
+                        float64_is_neg(ua.s))) {
+        goto soft;
+    }
+    ur.h = sqrt(ua.h);
+    return ur.s;
+
+ soft:
+    return soft_f64_sqrt(ua.s, s);
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated NaN.
 *----------------------------------------------------------------------------*/
-- 
2.17.1
