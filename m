Received: from eggs.gnu.org ([2001:4830:134:3::10]:49184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnvi-0008Mg-MG
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnvh-0001wu-Az
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:02 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXnvg-0001vm-TQ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:01 -0500
Received: by mail-wr1-x433.google.com with SMTP id p4so5509606wrt.7
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 05:55:00 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 14 Dec 2018 13:54:47 +0000
Message-Id: <20181214135452.25936-11-alex.bennee@linaro.org>
In-Reply-To: <20181214135452.25936-1-alex.bennee@linaro.org>
References: <20181214135452.25936-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/15] hardfloat: implement float32/64 addition
 and subtraction
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 468c4554d5..08afa861a7 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1054,49 +1054,128 @@ float16 QEMU_FLATTEN float16_add(float16 a, float16 b, float_status *status)
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 QEMU_FLATTEN float32_add(float32 a, float32 b, float_status *status)
+float16 QEMU_FLATTEN float16_sub(float16 a, float16 b, float_status *status)
+{
+    FloatParts pa = float16_unpack_canonical(a, status);
+    FloatParts pb = float16_unpack_canonical(b, status);
+    FloatParts pr = addsub_floats(pa, pb, true, status);
+
+    return float16_round_pack_canonical(pr, status);
+}
+
+static float32 QEMU_SOFTFLOAT_ATTR
+soft_f32_addsub(float32 a, float32 b, bool subtract, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pb = float32_unpack_canonical(b, status);
-    FloatParts pr = addsub_floats(pa, pb, false, status);
+    FloatParts pr = addsub_floats(pa, pb, subtract, status);
 
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 QEMU_FLATTEN float64_add(float64 a, float64 b, float_status *status)
+static inline float32 soft_f32_add(float32 a, float32 b, float_status *status)
+{
+    return soft_f32_addsub(a, b, false, status);
+}
+
+static inline float32 soft_f32_sub(float32 a, float32 b, float_status *status)
+{
+    return soft_f32_addsub(a, b, true, status);
+}
+
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_f64_addsub(float64 a, float64 b, bool subtract, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pb = float64_unpack_canonical(b, status);
-    FloatParts pr = addsub_floats(pa, pb, false, status);
+    FloatParts pr = addsub_floats(pa, pb, subtract, status);
 
     return float64_round_pack_canonical(pr, status);
 }
 
-float16 QEMU_FLATTEN float16_sub(float16 a, float16 b, float_status *status)
+static inline float64 soft_f64_add(float64 a, float64 b, float_status *status)
 {
-    FloatParts pa = float16_unpack_canonical(a, status);
-    FloatParts pb = float16_unpack_canonical(b, status);
-    FloatParts pr = addsub_floats(pa, pb, true, status);
+    return soft_f64_addsub(a, b, false, status);
+}
 
-    return float16_round_pack_canonical(pr, status);
+static inline float64 soft_f64_sub(float64 a, float64 b, float_status *status)
+{
+    return soft_f64_addsub(a, b, true, status);
 }
 
-float32 QEMU_FLATTEN float32_sub(float32 a, float32 b, float_status *status)
+static float hard_f32_add(float a, float b)
 {
-    FloatParts pa = float32_unpack_canonical(a, status);
-    FloatParts pb = float32_unpack_canonical(b, status);
-    FloatParts pr = addsub_floats(pa, pb, true, status);
+    return a + b;
+}
 
-    return float32_round_pack_canonical(pr, status);
+static float hard_f32_sub(float a, float b)
+{
+    return a - b;
 }
 
-float64 QEMU_FLATTEN float64_sub(float64 a, float64 b, float_status *status)
+static double hard_f64_add(double a, double b)
 {
-    FloatParts pa = float64_unpack_canonical(a, status);
-    FloatParts pb = float64_unpack_canonical(b, status);
-    FloatParts pr = addsub_floats(pa, pb, true, status);
+    return a + b;
+}
 
-    return float64_round_pack_canonical(pr, status);
+static double hard_f64_sub(double a, double b)
+{
+    return a - b;
+}
+
+static bool f32_addsub_post(union_float32 a, union_float32 b)
+{
+    if (QEMU_HARDFLOAT_2F32_USE_FP) {
+        return !(fpclassify(a.h) == FP_ZERO && fpclassify(b.h) == FP_ZERO);
+    }
+    return !(float32_is_zero(a.s) && float32_is_zero(b.s));
+}
+
+static bool f64_addsub_post(union_float64 a, union_float64 b)
+{
+    if (QEMU_HARDFLOAT_2F64_USE_FP) {
+        return !(fpclassify(a.h) == FP_ZERO && fpclassify(b.h) == FP_ZERO);
+    } else {
+        return !(float64_is_zero(a.s) && float64_is_zero(b.s));
+    }
+}
+
+static float32 float32_addsub(float32 a, float32 b, float_status *s,
+                              hard_f32_op2_fn hard, soft_f32_op2_fn soft)
+{
+    return float32_gen2(a, b, s, hard, soft,
+                        f32_is_zon2, f32_addsub_post, NULL, NULL);
+}
+
+static float64 float64_addsub(float64 a, float64 b, float_status *s,
+                              hard_f64_op2_fn hard, soft_f64_op2_fn soft)
+{
+    return float64_gen2(a, b, s, hard, soft,
+                        f64_is_zon2, f64_addsub_post, NULL, NULL);
+}
+
+float32 QEMU_FLATTEN
+float32_add(float32 a, float32 b, float_status *s)
+{
+    return float32_addsub(a, b, s, hard_f32_add, soft_f32_add);
+}
+
+float32 QEMU_FLATTEN
+float32_sub(float32 a, float32 b, float_status *s)
+{
+    return float32_addsub(a, b, s, hard_f32_sub, soft_f32_sub);
+}
+
+float64 QEMU_FLATTEN
+float64_add(float64 a, float64 b, float_status *s)
+{
+    return float64_addsub(a, b, s, hard_f64_add, soft_f64_add);
+}
+
+float64 QEMU_FLATTEN
+float64_sub(float64 a, float64 b, float_status *s)
+{
+    return float64_addsub(a, b, s, hard_f64_sub, soft_f64_sub);
 }
 
 /*
-- 
2.17.1
