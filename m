Received: from eggs.gnu.org ([2001:4830:134:3::10]:51570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONe4-0002QJ-BL
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONe1-0007gx-9i
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:20 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eONe1-0007g1-0S
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:17 -0500
Received: by mail-wr0-x243.google.com with SMTP id l22so17456934wrc.11
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 04:57:16 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Dec 2017 12:56:54 +0000
Message-Id: <20171211125705.16120-9-alex.bennee@linaro.org>
In-Reply-To: <20171211125705.16120-1-alex.bennee@linaro.org>
References: <20171211125705.16120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 08/19] fpu/softfloat: move the extract
 functions to the top of the file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This is pure code-motion during re-factoring as the helpers will be
needed earlier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c | 119 +++++++++++++++++++++++++-------------------------------
 1 file changed, 53 insertions(+), 66 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 44c043924e..0850a78149 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -132,6 +132,59 @@ static inline flag extractFloat16Sign(float16 a)
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
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -299,39 +352,6 @@ static int64_t roundAndPackUint64(flag zSign, uint64_t absZ0,
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
@@ -492,39 +512,6 @@ static float32
 
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
