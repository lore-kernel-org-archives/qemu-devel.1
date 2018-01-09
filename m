Received: from eggs.gnu.org ([2001:4830:134:3::10]:53780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYt16-0002bd-Tn
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYt14-0002D2-En
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:32 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYt14-0002Cb-4X
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:30 -0500
Received: by mail-wm0-x244.google.com with SMTP id 123so742874wme.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:28:30 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:49 +0000
Message-Id: <20180109122252.17670-18-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 17/20] fpu/softfloat: re-factor int/uint to
 float
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

These are considerably simpler as the lower order integers can just
use the higher order conversion function. As the decomposed fractional
part is a full 64 bit rounding and inexact handling comes from the
pack functions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - explicit setting of r.sign
---
 fpu/softfloat.c         | 322 ++++++++++++++++++++++++------------------------
 include/fpu/softfloat.h |  30 ++---
 2 files changed, 172 insertions(+), 180 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 514f43c065..bb68d77f72 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1500,6 +1500,169 @@ FLOAT_TO_UINT(64, 64)
 
 #undef FLOAT_TO_UINT
 
+/*
+ * Integer to float conversions
+ *
+ * Returns the result of converting the two's complement integer `a'
+ * to the floating-point format. The conversion is performed according
+ * to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
+ */
+
+static decomposed_parts int_to_float(int64_t a, float_status *status)
+{
+    decomposed_parts r;
+    if (a == 0) {
+        r.cls = float_class_zero;
+        r.sign = false;
+    } else if (a == (1ULL << 63)) {
+        r.cls = float_class_normal;
+        r.sign = true;
+        r.frac = DECOMPOSED_IMPLICIT_BIT;
+        r.exp = 63;
+    } else {
+        uint64_t f;
+        if (a < 0) {
+            f = -a;
+            r.sign = true;
+        } else {
+            f = a;
+            r.sign = false;
+        }
+        int shift = clz64(f) - 1;
+        r.cls = float_class_normal;
+        r.exp = (DECOMPOSED_BINARY_POINT - shift);
+        r.frac = f << shift;
+    }
+
+    return r;
+}
+
+float16 int64_to_float16(int64_t a, float_status *status)
+{
+    decomposed_parts pa = int_to_float(a, status);
+    return float16_round_pack_canonical(pa, status);
+}
+
+float16 int32_to_float16(int32_t a, float_status *status)
+{
+    return int64_to_float16(a, status);
+}
+
+float16 int16_to_float16(int16_t a, float_status *status)
+{
+    return int64_to_float16(a, status);
+}
+
+float32 int64_to_float32(int64_t a, float_status *status)
+{
+    decomposed_parts pa = int_to_float(a, status);
+    return float32_round_pack_canonical(pa, status);
+}
+
+float32 int32_to_float32(int32_t a, float_status *status)
+{
+    return int64_to_float32(a, status);
+}
+
+float32 int16_to_float32(int16_t a, float_status *status)
+{
+    return int64_to_float32(a, status);
+}
+
+float64 int64_to_float64(int64_t a, float_status *status)
+{
+    decomposed_parts pa = int_to_float(a, status);
+    return float64_round_pack_canonical(pa, status);
+}
+
+float64 int32_to_float64(int32_t a, float_status *status)
+{
+    return int64_to_float64(a, status);
+}
+
+float64 int16_to_float64(int16_t a, float_status *status)
+{
+    return int64_to_float64(a, status);
+}
+
+
+/*
+ * Unsigned Integer to float conversions
+ *
+ * Returns the result of converting the unsigned integer `a' to the
+ * floating-point format. The conversion is performed according to the
+ * IEC/IEEE Standard for Binary Floating-Point Arithmetic.
+ */
+
+static decomposed_parts uint_to_float(uint64_t a, float_status *status)
+{
+    decomposed_parts r = { .sign = false};
+
+    if (a == 0) {
+        r.cls = float_class_zero;
+    } else {
+        int spare_bits = clz64(a) - 1;
+        r.cls = float_class_normal;
+        r.exp = DECOMPOSED_BINARY_POINT - spare_bits;
+        if (spare_bits < 0) {
+            shift64RightJamming(a, -spare_bits, &a);
+            r.frac = a;
+        } else {
+            r.frac = a << spare_bits;
+        }
+    }
+
+    return r;
+}
+
+float16 uint64_to_float16(uint64_t a, float_status *status)
+{
+    decomposed_parts pa = uint_to_float(a, status);
+    return float16_round_pack_canonical(pa, status);
+}
+
+float16 uint32_to_float16(uint32_t a, float_status *status)
+{
+    return uint64_to_float16(a, status);
+}
+
+float16 uint16_to_float16(uint16_t a, float_status *status)
+{
+    return uint64_to_float16(a, status);
+}
+
+float32 uint64_to_float32(uint64_t a, float_status *status)
+{
+    decomposed_parts pa = uint_to_float(a, status);
+    return float32_round_pack_canonical(pa, status);
+}
+
+float32 uint32_to_float32(uint32_t a, float_status *status)
+{
+    return uint64_to_float32(a, status);
+}
+
+float32 uint16_to_float32(uint16_t a, float_status *status)
+{
+    return uint64_to_float32(a, status);
+}
+
+float64 uint64_to_float64(uint64_t a, float_status *status)
+{
+    decomposed_parts pa = uint_to_float(a, status);
+    return float64_round_pack_canonical(pa, status);
+}
+
+float64 uint32_to_float64(uint32_t a, float_status *status)
+{
+    return uint64_to_float64(a, status);
+}
+
+float64 uint16_to_float64(uint16_t a, float_status *status)
+{
+    return uint64_to_float64(a, status);
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -2591,43 +2754,6 @@ static float128 normalizeRoundAndPackFloat128(flag zSign, int32_t zExp,
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of converting the 32-bit two's complement integer `a'
-| to the single-precision floating-point format.  The conversion is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 int32_to_float32(int32_t a, float_status *status)
-{
-    flag zSign;
-
-    if ( a == 0 ) return float32_zero;
-    if ( a == (int32_t) 0x80000000 ) return packFloat32( 1, 0x9E, 0 );
-    zSign = ( a < 0 );
-    return normalizeRoundAndPackFloat32(zSign, 0x9C, zSign ? -a : a, status);
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the 32-bit two's complement integer `a'
-| to the double-precision floating-point format.  The conversion is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 int32_to_float64(int32_t a, float_status *status)
-{
-    flag zSign;
-    uint32_t absA;
-    int8_t shiftCount;
-    uint64_t zSig;
-
-    if ( a == 0 ) return float64_zero;
-    zSign = ( a < 0 );
-    absA = zSign ? - a : a;
-    shiftCount = countLeadingZeros32( absA ) + 21;
-    zSig = absA;
-    return packFloat64( zSign, 0x432 - shiftCount, zSig<<shiftCount );
-
-}
 
 /*----------------------------------------------------------------------------
 | Returns the result of converting the 32-bit two's complement integer `a'
@@ -2674,56 +2800,6 @@ float128 int32_to_float128(int32_t a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of converting the 64-bit two's complement integer `a'
-| to the single-precision floating-point format.  The conversion is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 int64_to_float32(int64_t a, float_status *status)
-{
-    flag zSign;
-    uint64_t absA;
-    int8_t shiftCount;
-
-    if ( a == 0 ) return float32_zero;
-    zSign = ( a < 0 );
-    absA = zSign ? - a : a;
-    shiftCount = countLeadingZeros64( absA ) - 40;
-    if ( 0 <= shiftCount ) {
-        return packFloat32( zSign, 0x95 - shiftCount, absA<<shiftCount );
-    }
-    else {
-        shiftCount += 7;
-        if ( shiftCount < 0 ) {
-            shift64RightJamming( absA, - shiftCount, &absA );
-        }
-        else {
-            absA <<= shiftCount;
-        }
-        return roundAndPackFloat32(zSign, 0x9C - shiftCount, absA, status);
-    }
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the 64-bit two's complement integer `a'
-| to the double-precision floating-point format.  The conversion is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 int64_to_float64(int64_t a, float_status *status)
-{
-    flag zSign;
-
-    if ( a == 0 ) return float64_zero;
-    if ( a == (int64_t) LIT64( 0x8000000000000000 ) ) {
-        return packFloat64( 1, 0x43E, 0 );
-    }
-    zSign = ( a < 0 );
-    return normalizeRoundAndPackFloat64(zSign, 0x43C, zSign ? -a : a, status);
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the 64-bit two's complement integer `a'
 | to the extended double-precision floating-point format.  The conversion
@@ -2778,65 +2854,6 @@ float128 int64_to_float128(int64_t a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of converting the 64-bit unsigned integer `a'
-| to the single-precision floating-point format.  The conversion is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 uint64_to_float32(uint64_t a, float_status *status)
-{
-    int shiftcount;
-
-    if (a == 0) {
-        return float32_zero;
-    }
-
-    /* Determine (left) shift needed to put first set bit into bit posn 23
-     * (since packFloat32() expects the binary point between bits 23 and 22);
-     * this is the fast case for smallish numbers.
-     */
-    shiftcount = countLeadingZeros64(a) - 40;
-    if (shiftcount >= 0) {
-        return packFloat32(0, 0x95 - shiftcount, a << shiftcount);
-    }
-    /* Otherwise we need to do a round-and-pack. roundAndPackFloat32()
-     * expects the binary point between bits 30 and 29, hence the + 7.
-     */
-    shiftcount += 7;
-    if (shiftcount < 0) {
-        shift64RightJamming(a, -shiftcount, &a);
-    } else {
-        a <<= shiftcount;
-    }
-
-    return roundAndPackFloat32(0, 0x9c - shiftcount, a, status);
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the 64-bit unsigned integer `a'
-| to the double-precision floating-point format.  The conversion is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 uint64_to_float64(uint64_t a, float_status *status)
-{
-    int exp = 0x43C;
-    int shiftcount;
-
-    if (a == 0) {
-        return float64_zero;
-    }
-
-    shiftcount = countLeadingZeros64(a) - 1;
-    if (shiftcount < 0) {
-        shift64RightJamming(a, -shiftcount, &a);
-    } else {
-        a <<= shiftcount;
-    }
-    return roundAndPackFloat64(0, exp - shiftcount, a, status);
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the 64-bit unsigned integer `a'
 | to the quadruple-precision floating-point format.  The conversion is performed
@@ -6716,19 +6733,6 @@ int float128_unordered_quiet(float128 a, float128 b, float_status *status)
     return 0;
 }
 
-/* misc functions */
-float32 uint32_to_float32(uint32_t a, float_status *status)
-{
-    return int64_to_float32(a, status);
-}
-
-float64 uint32_to_float64(uint32_t a, float_status *status)
-{
-    return int64_to_float64(a, status);
-}
-
-
-
 #define COMPARE(s, nan_exp)                                                  \
 static inline int float ## s ## _compare_internal(float ## s a, float ## s b,\
                                       int is_quiet, float_status *status)    \
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index d7bc7cbcb6..aa9e30d254 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -272,9 +272,13 @@ enum {
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE integer-to-floating-point conversion routines.
 *----------------------------------------------------------------------------*/
+float32 int16_to_float32(int16_t, float_status *status);
 float32 int32_to_float32(int32_t, float_status *status);
+float64 int16_to_float64(int16_t, float_status *status);
 float64 int32_to_float64(int32_t, float_status *status);
+float32 uint16_to_float32(uint16_t, float_status *status);
 float32 uint32_to_float32(uint32_t, float_status *status);
+float64 uint16_to_float64(uint16_t, float_status *status);
 float64 uint32_to_float64(uint32_t, float_status *status);
 floatx80 int32_to_floatx80(int32_t, float_status *status);
 float128 int32_to_float128(int32_t, float_status *status);
@@ -286,27 +290,6 @@ float32 uint64_to_float32(uint64_t, float_status *status);
 float64 uint64_to_float64(uint64_t, float_status *status);
 float128 uint64_to_float128(uint64_t, float_status *status);
 
-/* We provide the int16 versions for symmetry of API with float-to-int */
-static inline float32 int16_to_float32(int16_t v, float_status *status)
-{
-    return int32_to_float32(v, status);
-}
-
-static inline float32 uint16_to_float32(uint16_t v, float_status *status)
-{
-    return uint32_to_float32(v, status);
-}
-
-static inline float64 int16_to_float64(int16_t v, float_status *status)
-{
-    return int32_to_float64(v, status);
-}
-
-static inline float64 uint16_to_float64(uint16_t v, float_status *status)
-{
-    return uint32_to_float64(v, status);
-}
-
 /*----------------------------------------------------------------------------
 | Software half-precision conversion routines.
 *----------------------------------------------------------------------------*/
@@ -327,6 +310,11 @@ uint64_t float16_to_uint64(float16 a, float_status *status);
 int64_t float16_to_int64_round_to_zero(float16, float_status *status);
 uint64_t float16_to_uint64_round_to_zero(float16 a, float_status *status);
 float16 int16_to_float16(int16_t a, float_status *status);
+float16 int32_to_float16(int32_t a, float_status *status);
+float16 int64_to_float16(int64_t a, float_status *status);
+float16 uint16_to_float16(uint16_t a, float_status *status);
+float16 uint32_to_float16(uint32_t a, float_status *status);
+float16 uint64_to_float16(uint64_t a, float_status *status);
 
 /*----------------------------------------------------------------------------
 | Software half-precision operations.
-- 
2.15.1
