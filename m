Received: from eggs.gnu.org ([2001:4830:134:3::10]:47454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf2-0004tn-QN
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf1-00055h-9W
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:12 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:39324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBf1-000553-25
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:11 -0500
Received: by mail-pl0-x244.google.com with SMTP id o13so9359917pli.6
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:12:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:33 -0800
Message-Id: <20180204041136.17525-22-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 21/24] fpu: Implement scalbn with soft-fp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org, hsp.cat7@gmail.com

Add float16 support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |   1 +
 fpu/floatxx.inc.c       |  28 +++++++++++++
 fpu/softfloat.c         | 109 ------------------------------------------------
 3 files changed, 29 insertions(+), 109 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 0aae0454e2..b97022be1d 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -267,6 +267,7 @@ float16 float16_minnum(float16, float16, float_status *status);
 float16 float16_maxnum(float16, float16, float_status *status);
 float16 float16_minnummag(float16, float16, float_status *status);
 float16 float16_maxnummag(float16, float16, float_status *status);
+float16 float16_scalbn(float16, int, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
diff --git a/fpu/floatxx.inc.c b/fpu/floatxx.inc.c
index 7a7f53dd5d..8c009dd966 100644
--- a/fpu/floatxx.inc.c
+++ b/fpu/floatxx.inc.c
@@ -117,6 +117,34 @@ FLOATXX glue(FLOATXX,_sqrt)(FLOATXX a, float_status *status)
     return r;
 }
 
+FLOATXX glue(FLOATXX,_scalbn)(FLOATXX a, int n, float_status *status)
+{
+    FP_DECL_EX;
+    glue(FP_DECL_, FS)(A);
+
+    FP_INIT_ROUNDMODE;
+    glue(FP_UNPACK_, FS)(A, a);
+
+    if (likely(A_c == FP_CLS_NORMAL)) {
+        /* Bound N such that the exponent can safely adjusted without
+           overflowing.  The maximum is large enough to take the smallest
+           denormal up beyond the largest normal, which will overflow
+           to infinity when we repack.  */
+        int max = glue(_FP_EXPMAX_, FS) + glue(_FP_FRACBITS_, FS);
+        if (n > max) {
+            n = max;
+        } else if (n < -max) {
+            n = -max;
+        }
+        A_e += n;
+    }
+
+    glue(FP_PACK_, FS)(a, A);
+    FP_HANDLE_EXCEPTIONS;
+
+    return a;
+}
+
 #define DO_FLOAT_TO_INT(NAME, SZ, FP_TO_INT_WHICH)   \
 int##SZ##_t NAME(FLOATXX a, float_status *status) \
 {                                                 \
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 83995cc60f..2550028d9f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4120,79 +4120,6 @@ int floatx80_unordered_quiet(floatx80 a, floatx80 b, float_status *status)
            == float_relation_unordered;
 }
 
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
@@ -4231,39 +4158,3 @@ floatx80 floatx80_scalbn(floatx80 a, int n, float_status *status)
     return normalizeRoundAndPackFloatx80(status->floatx80_rounding_precision,
                                          aSign, aExp, aSig, 0, status);
 }
-
-float128 float128_scalbn(float128 a, int n, float_status *status)
-{
-    flag aSign;
-    int32_t aExp;
-    uint64_t aSig0, aSig1;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    aSign = extractFloat128Sign( a );
-    if ( aExp == 0x7FFF ) {
-        if ( aSig0 | aSig1 ) {
-            return propagateFloat128NaN(a, a, status);
-        }
-        return a;
-    }
-    if (aExp != 0) {
-        aSig0 |= LIT64( 0x0001000000000000 );
-    } else if (aSig0 == 0 && aSig1 == 0) {
-        return a;
-    } else {
-        aExp++;
-    }
-
-    if (n > 0x10000) {
-        n = 0x10000;
-    } else if (n < -0x10000) {
-        n = -0x10000;
-    }
-
-    aExp += n - 1;
-    return normalizeRoundAndPackFloat128( aSign, aExp, aSig0, aSig1
-                                         , status);
-
-}
-- 
2.14.3
