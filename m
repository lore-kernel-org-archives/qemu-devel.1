Received: from eggs.gnu.org ([2001:4830:134:3::10]:35399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDe-000420-Ew
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDd-0006ka-By
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:50 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoSDd-0006k7-4y
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:49 -0500
Received: by mail-wr0-x242.google.com with SMTP id m5so3302538wrg.1
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 03:05:49 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Feb 2018 11:05:19 +0000
Message-Id: <20180221110523.859-20-alex.bennee@linaro.org>
In-Reply-To: <20180221110523.859-1-alex.bennee@linaro.org>
References: <20180221110523.859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/22] fpu/softfloat: re-factor scalbn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This is one of the simpler manipulations you could make to a floating
point number.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 4313d3a602..a07b8556b0 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1663,6 +1663,39 @@ float64 uint16_to_float64(uint16_t a, float_status *status)
     return uint64_to_float64(a, status);
 }
 
+/* Multiply A by 2 raised to the power N.  */
+static FloatParts scalbn_decomposed(FloatParts a, int n, float_status *s)
+{
+    if (unlikely(is_nan(a.cls))) {
+        return return_nan(a, s);
+    }
+    if (a.cls == float_class_normal) {
+        a.exp += n;
+    }
+    return a;
+}
+
+float16 float16_scalbn(float16 a, int n, float_status *status)
+{
+    FloatParts pa = float16_unpack_canonical(a, status);
+    FloatParts pr = scalbn_decomposed(pa, n, status);
+    return float16_round_pack_canonical(pr, status);
+}
+
+float32 float32_scalbn(float32 a, int n, float_status *status)
+{
+    FloatParts pa = float32_unpack_canonical(a, status);
+    FloatParts pr = scalbn_decomposed(pa, n, status);
+    return float32_round_pack_canonical(pr, status);
+}
+
+float64 float64_scalbn(float64 a, int n, float_status *status)
+{
+    FloatParts pa = float64_unpack_canonical(a, status);
+    FloatParts pr = scalbn_decomposed(pa, n, status);
+    return float64_round_pack_canonical(pr, status);
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -6986,79 +7019,6 @@ MINMAX(32)
 MINMAX(64)
 
 
-/* Multiply A by 2 raised to the power N.  */
-float32 float32_scalbn(float32 a, int n, float_status *status)
-{
-    flag aSign;
-    int16_t aExp;
-    uint32_t aSig;
-
-    a = float32_squash_input_denormal(a, status);
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-
-    if ( aExp == 0xFF ) {
-        if ( aSig ) {
-            return propagateFloat32NaN(a, a, status);
-        }
-        return a;
-    }
-    if (aExp != 0) {
-        aSig |= 0x00800000;
-    } else if (aSig == 0) {
-        return a;
-    } else {
-        aExp++;
-    }
-
-    if (n > 0x200) {
-        n = 0x200;
-    } else if (n < -0x200) {
-        n = -0x200;
-    }
-
-    aExp += n - 1;
-    aSig <<= 7;
-    return normalizeRoundAndPackFloat32(aSign, aExp, aSig, status);
-}
-
-float64 float64_scalbn(float64 a, int n, float_status *status)
-{
-    flag aSign;
-    int16_t aExp;
-    uint64_t aSig;
-
-    a = float64_squash_input_denormal(a, status);
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-
-    if ( aExp == 0x7FF ) {
-        if ( aSig ) {
-            return propagateFloat64NaN(a, a, status);
-        }
-        return a;
-    }
-    if (aExp != 0) {
-        aSig |= LIT64( 0x0010000000000000 );
-    } else if (aSig == 0) {
-        return a;
-    } else {
-        aExp++;
-    }
-
-    if (n > 0x1000) {
-        n = 0x1000;
-    } else if (n < -0x1000) {
-        n = -0x1000;
-    }
-
-    aExp += n - 1;
-    aSig <<= 10;
-    return normalizeRoundAndPackFloat64(aSign, aExp, aSig, status);
-}
-
 floatx80 floatx80_scalbn(floatx80 a, int n, float_status *status)
 {
     flag aSign;
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3e6fdd756a..52621e0b79 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -244,6 +244,7 @@ float16 float16_sub(float16, float16, float_status *status);
 float16 float16_mul(float16, float16, float_status *status);
 float16 float16_muladd(float16, float16, float16, int, float_status *status);
 float16 float16_div(float16, float16, float_status *status);
+float16 float16_scalbn(float16, int, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
-- 
2.15.1
