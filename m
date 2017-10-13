Received: from eggs.gnu.org ([2001:4830:134:3::10]:44111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32se-0000eK-7n
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sb-0002KJ-CP
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:12 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:55189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32sb-0002JI-5v
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:09 -0400
Received: by mail-wm0-x22e.google.com with SMTP id i124so22849885wmf.3
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:32:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:33 +0100
Message-Id: <20171013162438.32458-26-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 25/30] softfloat: float16_round_to_int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Again a mechanical conversion.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c         | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h |  1 +
 2 files changed, 83 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f7473f97e3..dc7f5f6d88 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3532,6 +3532,88 @@ static void normalizeFloat16Subnormal(uint32_t aSig, int *zExpPtr,
     *zExpPtr = 1 - shiftCount;
 }
 
+/*----------------------------------------------------------------------------
+| Rounds the half-precision floating-point value `a' to an integer,
+| and returns the result as a half-precision floating-point value. The
+| operation is performed according to the IEC/IEEE Standard for Binary
+| Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+float16 float16_round_to_int(float16 a, float_status *status)
+{
+    flag aSign;
+    int aExp;
+    uint16_t lastBitMask, roundBitsMask;
+    uint16_t z;
+    a = float16_squash_input_denormal(a, status);
+
+    aExp = extractFloat16Exp( a );
+    if ( 0x19 <= aExp ) {
+        if ( ( aExp == 0x1F ) && extractFloat16Frac( a ) ) {
+            return propagateFloat16NaN(a, a, status);
+        }
+        return a;
+    }
+    if ( aExp <= 0xE ) {
+        if ( (uint16_t) ( float16_val(a)<<1 ) == 0 ) return a;
+        status->float_exception_flags |= float_flag_inexact;
+        aSign = extractFloat16Sign( a );
+        switch (status->float_rounding_mode) {
+        case float_round_nearest_even:
+            if ( ( aExp == 0xE ) && extractFloat16Frac( a ) ) {
+                return packFloat16( aSign, 0xF, 0 );
+            }
+            break;
+        case float_round_ties_away:
+            if (aExp == 0xE) {
+                return packFloat16(aSign, 0xF, 0);
+            }
+            break;
+        case float_round_down:
+            return make_float16(aSign ? 0xBC00 : 0);
+        case float_round_up:
+            /* -0.0/1.0f */
+            return make_float16(aSign ? 0x8000 : 0x3C00);
+        }
+        return packFloat16( aSign, 0, 0 );
+    }
+    lastBitMask = 1;
+    lastBitMask <<= 0x19 - aExp;
+    roundBitsMask = lastBitMask - 1;
+    z = float16_val(a);
+    switch (status->float_rounding_mode) {
+    case float_round_nearest_even:
+        z += lastBitMask>>1;
+        if ((z & roundBitsMask) == 0) {
+            z &= ~lastBitMask;
+        }
+        break;
+    case float_round_ties_away:
+        z += lastBitMask >> 1;
+        break;
+    case float_round_to_zero:
+        break;
+    case float_round_up:
+        if (!extractFloat16Sign(make_float16(z))) {
+            z += roundBitsMask;
+        }
+        break;
+    case float_round_down:
+        if (extractFloat16Sign(make_float16(z))) {
+            z += roundBitsMask;
+        }
+        break;
+    default:
+        abort();
+    }
+    z &= ~ roundBitsMask;
+    if (z != float16_val(a)) {
+        status->float_exception_flags |= float_flag_inexact;
+    }
+    return make_float16(z);
+
+}
+
 /*----------------------------------------------------------------------------
 | Returns the result of adding the absolute values of the half-precision
 | floating-point values `a' and `b'.  If `zSign' is 1, the sum is negated
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index a7435e2a5b..856f67cf12 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -346,6 +346,7 @@ float64 float16_to_float64(float16 a, flag ieee, float_status *status);
 | Software half-precision operations.
 *----------------------------------------------------------------------------*/
 
+float16 float16_round_to_int(float16, float_status *status);
 float16 float16_add(float16, float16, float_status *status);
 float16 float16_sub(float16, float16, float_status *status);
 float16 float16_mul(float16, float16, float_status *status);
-- 
2.14.1
