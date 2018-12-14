Received: from eggs.gnu.org ([2001:4830:134:3::10]:49243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnvo-0008Rb-Vq
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnvl-0001z3-GO
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:08 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXnvl-0001yX-6u
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:05 -0500
Received: by mail-wr1-x42d.google.com with SMTP id v13so5520787wrw.5
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 05:55:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 14 Dec 2018 13:54:50 +0000
Message-Id: <20181214135452.25936-14-alex.bennee@linaro.org>
In-Reply-To: <20181214135452.25936-1-alex.bennee@linaro.org>
References: <20181214135452.25936-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/15] hardfloat: implement float32/64 fused
 multiply-add
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 82294458fe..7554d63495 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1518,8 +1518,9 @@ float16 QEMU_FLATTEN float16_muladd(float16 a, float16 b, float16 c,
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 QEMU_FLATTEN float32_muladd(float32 a, float32 b, float32 c,
-                                                int flags, float_status *status)
+static float32 QEMU_SOFTFLOAT_ATTR
+soft_f32_muladd(float32 a, float32 b, float32 c, int flags,
+                float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
@@ -1529,8 +1530,9 @@ float32 QEMU_FLATTEN float32_muladd(float32 a, float32 b, float32 c,
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 QEMU_FLATTEN float64_muladd(float64 a, float64 b, float64 c,
-                                                int flags, float_status *status)
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_f64_muladd(float64 a, float64 b, float64 c, int flags,
+                float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
@@ -1540,6 +1542,128 @@ float64 QEMU_FLATTEN float64_muladd(float64 a, float64 b, float64 c,
     return float64_round_pack_canonical(pr, status);
 }
 
+float32 QEMU_FLATTEN
+float32_muladd(float32 xa, float32 xb, float32 xc, int flags, float_status *s)
+{
+    union_float32 ua, ub, uc, ur;
+
+    ua.s = xa;
+    ub.s = xb;
+    uc.s = xc;
+
+    if (unlikely(!can_use_fpu(s))) {
+        goto soft;
+    }
+    if (unlikely(flags & float_muladd_halve_result)) {
+        goto soft;
+    }
+
+    float32_input_flush3(&ua.s, &ub.s, &uc.s, s);
+    if (unlikely(!f32_is_zon3(ua, ub, uc))) {
+        goto soft;
+    }
+    /*
+     * When (a || b) == 0, there's no need to check for under/over flow,
+     * since we know the addend is (normal || 0) and the product is 0.
+     */
+    if (float32_is_zero(ua.s) || float32_is_zero(ub.s)) {
+        union_float32 up;
+        bool prod_sign;
+
+        prod_sign = float32_is_neg(ua.s) ^ float32_is_neg(ub.s);
+        prod_sign ^= !!(flags & float_muladd_negate_product);
+        up.s = float32_set_sign(float32_zero, prod_sign);
+
+        if (flags & float_muladd_negate_c) {
+            uc.h = -uc.h;
+        }
+        ur.h = up.h + uc.h;
+    } else {
+        if (flags & float_muladd_negate_product) {
+            ua.h = -ua.h;
+        }
+        if (flags & float_muladd_negate_c) {
+            uc.h = -uc.h;
+        }
+
+        ur.h = fmaf(ua.h, ub.h, uc.h);
+
+        if (unlikely(f32_is_inf(ur))) {
+            s->float_exception_flags |= float_flag_overflow;
+        } else if (unlikely(fabsf(ur.h) <= FLT_MIN)) {
+            goto soft;
+        }
+    }
+    if (flags & float_muladd_negate_result) {
+        return float32_chs(ur.s);
+    }
+    return ur.s;
+
+ soft:
+    return soft_f32_muladd(ua.s, ub.s, uc.s, flags, s);
+}
+
+float64 QEMU_FLATTEN
+float64_muladd(float64 xa, float64 xb, float64 xc, int flags, float_status *s)
+{
+    union_float64 ua, ub, uc, ur;
+
+    ua.s = xa;
+    ub.s = xb;
+    uc.s = xc;
+
+    if (unlikely(!can_use_fpu(s))) {
+        goto soft;
+    }
+    if (unlikely(flags & float_muladd_halve_result)) {
+        goto soft;
+    }
+
+    float64_input_flush3(&ua.s, &ub.s, &uc.s, s);
+    if (unlikely(!f64_is_zon3(ua, ub, uc))) {
+        goto soft;
+    }
+    /*
+     * When (a || b) == 0, there's no need to check for under/over flow,
+     * since we know the addend is (normal || 0) and the product is 0.
+     */
+    if (float64_is_zero(ua.s) || float64_is_zero(ub.s)) {
+        union_float64 up;
+        bool prod_sign;
+
+        prod_sign = float64_is_neg(ua.s) ^ float64_is_neg(ub.s);
+        prod_sign ^= !!(flags & float_muladd_negate_product);
+        up.s = float64_set_sign(float64_zero, prod_sign);
+
+        if (flags & float_muladd_negate_c) {
+            uc.h = -uc.h;
+        }
+        ur.h = up.h + uc.h;
+    } else {
+        if (flags & float_muladd_negate_product) {
+            ua.h = -ua.h;
+        }
+        if (flags & float_muladd_negate_c) {
+            uc.h = -uc.h;
+        }
+
+        ur.h = fma(ua.h, ub.h, uc.h);
+
+        if (unlikely(f64_is_inf(ur))) {
+            s->float_exception_flags |= float_flag_overflow;
+        } else if (unlikely(fabs(ur.h) <= FLT_MIN)) {
+            goto soft;
+        }
+    }
+    if (flags & float_muladd_negate_result) {
+        return float64_chs(ur.s);
+    }
+    return ur.s;
+
+ soft:
+    return soft_f64_muladd(ua.s, ub.s, uc.s, flags, s);
+}
+
 /*
  * Returns the result of dividing the floating-point value `a' by the
  * corresponding value `b'. The operation is performed according to
-- 
2.17.1
