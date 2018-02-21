Received: from eggs.gnu.org ([2001:4830:134:3::10]:35377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDd-00041s-Hd
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDb-0006ir-PS
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:49 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoSDb-0006iU-GY
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:47 -0500
Received: by mail-wr0-x244.google.com with SMTP id n7so3287058wrn.5
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 03:05:47 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Feb 2018 11:05:10 +0000
Message-Id: <20180221110523.859-11-alex.bennee@linaro.org>
In-Reply-To: <20180221110523.859-1-alex.bennee@linaro.org>
References: <20180221110523.859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/22] fpu/softfloat: move the extract functions
 to the top of the file
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

This is pure code-motion during re-factoring as the helpers will be
needed earlier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3a4ab1355f..297e48f5c9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -132,6 +132,60 @@ static inline flag extractFloat16Sign(float16 a)
     return float16_val(a)>>15;
 }
 
+/*----------------------------------------------------------------------------
+| Returns the fraction bits of the single-precision floating-point value `a'.
+*----------------------------------------------------------------------------*/
+
+static inline uint32_t extractFloat32Frac(float32 a)
+{
+    return float32_val(a) & 0x007FFFFF;
+}
+
+/*----------------------------------------------------------------------------
+| Returns the exponent bits of the single-precision floating-point value `a'.
+*----------------------------------------------------------------------------*/
+
+static inline int extractFloat32Exp(float32 a)
+{
+    return (float32_val(a) >> 23) & 0xFF;
+}
+
+/*----------------------------------------------------------------------------
+| Returns the sign bit of the single-precision floating-point value `a'.
+*----------------------------------------------------------------------------*/
+
+static inline flag extractFloat32Sign(float32 a)
+{
+    return float32_val(a) >> 31;
+}
+
+/*----------------------------------------------------------------------------
+| Returns the fraction bits of the double-precision floating-point value `a'.
+*----------------------------------------------------------------------------*/
+
+static inline uint64_t extractFloat64Frac(float64 a)
+{
+    return float64_val(a) & LIT64(0x000FFFFFFFFFFFFF);
+}
+
+/*----------------------------------------------------------------------------
+| Returns the exponent bits of the double-precision floating-point value `a'.
+*----------------------------------------------------------------------------*/
+
+static inline int extractFloat64Exp(float64 a)
+{
+    return (float64_val(a) >> 52) & 0x7FF;
+}
+
+/*----------------------------------------------------------------------------
+| Returns the sign bit of the double-precision floating-point value `a'.
+*----------------------------------------------------------------------------*/
+
+static inline flag extractFloat64Sign(float64 a)
+{
+    return float64_val(a) >> 63;
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -299,39 +353,6 @@ static int64_t roundAndPackUint64(flag zSign, uint64_t absZ0,
     return absZ0;
 }
 
-/*----------------------------------------------------------------------------
-| Returns the fraction bits of the single-precision floating-point value `a'.
-*----------------------------------------------------------------------------*/
-
-static inline uint32_t extractFloat32Frac( float32 a )
-{
-
-    return float32_val(a) & 0x007FFFFF;
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the exponent bits of the single-precision floating-point value `a'.
-*----------------------------------------------------------------------------*/
-
-static inline int extractFloat32Exp(float32 a)
-{
-
-    return ( float32_val(a)>>23 ) & 0xFF;
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the sign bit of the single-precision floating-point value `a'.
-*----------------------------------------------------------------------------*/
-
-static inline flag extractFloat32Sign( float32 a )
-{
-
-    return float32_val(a)>>31;
-
-}
-
 /*----------------------------------------------------------------------------
 | If `a' is denormal and we are in flush-to-zero mode then set the
 | input-denormal exception and return zero. Otherwise just return the value.
@@ -492,39 +513,6 @@ static float32
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the fraction bits of the double-precision floating-point value `a'.
-*----------------------------------------------------------------------------*/
-
-static inline uint64_t extractFloat64Frac( float64 a )
-{
-
-    return float64_val(a) & LIT64( 0x000FFFFFFFFFFFFF );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the exponent bits of the double-precision floating-point value `a'.
-*----------------------------------------------------------------------------*/
-
-static inline int extractFloat64Exp(float64 a)
-{
-
-    return ( float64_val(a)>>52 ) & 0x7FF;
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the sign bit of the double-precision floating-point value `a'.
-*----------------------------------------------------------------------------*/
-
-static inline flag extractFloat64Sign( float64 a )
-{
-
-    return float64_val(a)>>63;
-
-}
-
 /*----------------------------------------------------------------------------
 | If `a' is denormal and we are in flush-to-zero mode then set the
 | input-denormal exception and return zero. Otherwise just return the value.
-- 
2.15.1
