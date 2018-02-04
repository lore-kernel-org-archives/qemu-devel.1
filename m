Received: from eggs.gnu.org ([2001:4830:134:3::10]:47416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf0-0004rX-C1
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBew-00051Q-4n
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:10 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBev-00050Q-Sn
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:06 -0500
Received: by mail-pf0-x244.google.com with SMTP id u15so3376195pfa.0
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:12:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:29 -0800
Message-Id: <20180204041136.17525-18-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 17/24] fpu: Implement int/uint_to_float with
 soft-fp.h
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

Add conversions to float16.  For consistency, add float128
conversions from int16_t/uint16_t.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |  50 +++++------
 fpu/floatxx.inc.c       |  55 ++++++++++++
 fpu/softfloat.c         | 227 ------------------------------------------------
 3 files changed, 78 insertions(+), 254 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index cd39131c10..311c4aba1e 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -190,41 +190,37 @@ enum {
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE integer-to-floating-point conversion routines.
 *----------------------------------------------------------------------------*/
+float16 int16_to_float16(int16_t, float_status *status);
+float16 int32_to_float16(int32_t, float_status *status);
+float16 int64_to_float16(int64_t, float_status *status);
+float16 uint16_to_float16(uint16_t, float_status *status);
+float16 uint32_to_float16(uint32_t, float_status *status);
+float16 uint64_to_float16(uint64_t, float_status *status);
+
+float32 int16_to_float32(int16_t, float_status *status);
 float32 int32_to_float32(int32_t, float_status *status);
-float64 int32_to_float64(int32_t, float_status *status);
+float32 int64_to_float32(int64_t, float_status *status);
+float32 uint16_to_float32(uint16_t, float_status *status);
 float32 uint32_to_float32(uint32_t, float_status *status);
+float32 uint64_to_float32(uint64_t, float_status *status);
+
+float64 int16_to_float64(int16_t, float_status *status);
+float64 int32_to_float64(int32_t, float_status *status);
+float64 int64_to_float64(int64_t, float_status *status);
+float64 uint16_to_float64(uint16_t, float_status *status);
 float64 uint32_to_float64(uint32_t, float_status *status);
+float64 uint64_to_float64(uint64_t, float_status *status);
+
 floatx80 int32_to_floatx80(int32_t, float_status *status);
-float128 int32_to_float128(int32_t, float_status *status);
-float32 int64_to_float32(int64_t, float_status *status);
-float64 int64_to_float64(int64_t, float_status *status);
 floatx80 int64_to_floatx80(int64_t, float_status *status);
+
+float128 int16_to_float128(int16_t, float_status *status);
+float128 int32_to_float128(int32_t, float_status *status);
 float128 int64_to_float128(int64_t, float_status *status);
-float32 uint64_to_float32(uint64_t, float_status *status);
-float64 uint64_to_float64(uint64_t, float_status *status);
+float128 uint16_to_float128(uint16_t, float_status *status);
+float128 uint32_to_float128(uint32_t, float_status *status);
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
diff --git a/fpu/floatxx.inc.c b/fpu/floatxx.inc.c
index da6c17afab..5ca6c924ab 100644
--- a/fpu/floatxx.inc.c
+++ b/fpu/floatxx.inc.c
@@ -141,3 +141,58 @@ DO_FLOAT_TO_UINT(glue(FLOATXX,_to_uint64_round_to_zero), 64, FP_TO_INT_)
 
 #undef DO_FLOAT_TO_INT
 #undef DO_FLOAT_TO_UINT
+
+FLOATXX glue(int64_to_,FLOATXX)(int64_t a, float_status *status)
+{
+    FP_DECL_EX;
+    glue(FP_DECL_, FS)(R);
+    FLOATXX r;
+
+    FP_INIT_ROUNDMODE;
+    glue(FP_FROM_INT_, FS)(R, a, 64, uint64_t);
+    glue(FP_PACK_RAW_, FS)(r, R);
+    FP_HANDLE_EXCEPTIONS;
+    return r;
+}
+
+FLOATXX glue(int16_to_,FLOATXX)(int16_t a, float_status *status)
+{
+    return glue(int64_to_,FLOATXX)(a, status);
+}
+
+FLOATXX glue(int32_to_,FLOATXX)(int32_t a, float_status *status)
+{
+    return glue(int64_to_,FLOATXX)(a, status);
+}
+
+/* The code within _FP_FROM_INT always tests A against 0.  For the
+   unsigned conversion, this may result in a compiler warning.
+   For -Werror, we need to suppress this.  */
+
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wtype-limits"
+
+FLOATXX glue(uint64_to_,FLOATXX)(uint64_t a, float_status *status)
+{
+    FP_DECL_EX;
+    glue(FP_DECL_, FS)(R);
+    FLOATXX r;
+
+    FP_INIT_ROUNDMODE;
+    glue(FP_FROM_INT_, FS)(R, a, 64, uint64_t);
+    glue(FP_PACK_RAW_, FS)(r, R);
+    FP_HANDLE_EXCEPTIONS;
+    return r;
+}
+
+#pragma GCC diagnostic pop
+
+FLOATXX glue(uint16_to_,FLOATXX)(uint16_t a, float_status *status)
+{
+    return glue(uint64_to_,FLOATXX)(a, status);
+}
+
+FLOATXX glue(uint32_to_,FLOATXX)(uint32_t a, float_status *status)
+{
+    return glue(uint64_to_,FLOATXX)(a, status);
+}
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3fe12abab1..47b8c4815b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1234,44 +1234,6 @@ static float128 normalizeRoundAndPackFloat128(flag zSign, int32_t zExp,
 
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
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the 32-bit two's complement integer `a'
 | to the extended double-precision floating-point format.  The conversion
@@ -1295,78 +1257,6 @@ floatx80 int32_to_floatx80(int32_t a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of converting the 32-bit two's complement integer `a' to
-| the quadruple-precision floating-point format.  The conversion is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 int32_to_float128(int32_t a, float_status *status)
-{
-    flag zSign;
-    uint32_t absA;
-    int8_t shiftCount;
-    uint64_t zSig0;
-
-    if ( a == 0 ) return packFloat128( 0, 0, 0, 0 );
-    zSign = ( a < 0 );
-    absA = zSign ? - a : a;
-    shiftCount = countLeadingZeros32( absA ) + 17;
-    zSig0 = absA;
-    return packFloat128( zSign, 0x402E - shiftCount, zSig0<<shiftCount, 0 );
-
-}
-
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
@@ -1388,112 +1278,6 @@ floatx80 int64_to_floatx80(int64_t a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of converting the 64-bit two's complement integer `a' to
-| the quadruple-precision floating-point format.  The conversion is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 int64_to_float128(int64_t a, float_status *status)
-{
-    flag zSign;
-    uint64_t absA;
-    int8_t shiftCount;
-    int32_t zExp;
-    uint64_t zSig0, zSig1;
-
-    if ( a == 0 ) return packFloat128( 0, 0, 0, 0 );
-    zSign = ( a < 0 );
-    absA = zSign ? - a : a;
-    shiftCount = countLeadingZeros64( absA ) + 49;
-    zExp = 0x406E - shiftCount;
-    if ( 64 <= shiftCount ) {
-        zSig1 = 0;
-        zSig0 = absA;
-        shiftCount -= 64;
-    }
-    else {
-        zSig1 = absA;
-        zSig0 = 0;
-    }
-    shortShift128Left( zSig0, zSig1, shiftCount, &zSig0, &zSig1 );
-    return packFloat128( zSign, zExp, zSig0, zSig1 );
-
-}
-
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
-/*----------------------------------------------------------------------------
-| Returns the result of converting the 64-bit unsigned integer `a'
-| to the quadruple-precision floating-point format.  The conversion is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 uint64_to_float128(uint64_t a, float_status *status)
-{
-    if (a == 0) {
-        return float128_zero;
-    }
-    return normalizeRoundAndPackFloat128(0, 0x406E, a, 0, status);
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the single-precision floating-point value
 | `a' to the double-precision floating-point format.  The conversion is
@@ -5354,17 +5138,6 @@ int float128_unordered_quiet(float128 a, float128 b, float_status *status)
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
 #define COMPARE(s, nan_exp)                                                  \
 static inline int float ## s ## _compare_internal(float ## s a, float ## s b,\
                                       int is_quiet, float_status *status)    \
-- 
2.14.3
