Received: from eggs.gnu.org ([2001:4830:134:3::10]:47418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf0-0004rY-Cl
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBev-000514-P9
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:10 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:46160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBev-00050A-DE
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:05 -0500
Received: by mail-pg0-x241.google.com with SMTP id s9so15973596pgq.13
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:12:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:28 -0800
Message-Id: <20180204041136.17525-17-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 16/24] fpu: Implement float_to_int/uint with
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

Add float16 conversions.  For consistency, add missing
float128 conversions to uint32_t.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |   20 +-
 fpu/floatxx.inc.c       |   45 ++
 fpu/softfloat.c         | 1088 -----------------------------------------------
 3 files changed, 64 insertions(+), 1089 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 85e4a74f1b..cd39131c10 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -228,6 +228,19 @@ static inline float64 uint16_to_float64(uint16_t v, float_status *status)
 /*----------------------------------------------------------------------------
 | Software half-precision conversion routines.
 *----------------------------------------------------------------------------*/
+int16_t float16_to_int16(float16, float_status *status);
+uint16_t float16_to_uint16(float16, float_status *status);
+int16_t float16_to_int16_round_to_zero(float16, float_status *status);
+uint16_t float16_to_uint16_round_to_zero(float16, float_status *status);
+int32_t float16_to_int32(float16, float_status *status);
+int32_t float16_to_int32_round_to_zero(float16, float_status *status);
+uint32_t float16_to_uint32(float16, float_status *status);
+uint32_t float16_to_uint32_round_to_zero(float16, float_status *status);
+int64_t float16_to_int64(float16, float_status *status);
+uint64_t float16_to_uint64(float16, float_status *status);
+uint64_t float16_to_uint64_round_to_zero(float16, float_status *status);
+int64_t float16_to_int64_round_to_zero(float16, float_status *status);
+
 float16 float32_to_float16(float32, flag, float_status *status);
 float32 float16_to_float32(float16, flag, float_status *status);
 float16 float64_to_float16(float64 a, flag ieee, float_status *status);
@@ -627,13 +640,18 @@ floatx80 floatx80_default_nan(float_status *status);
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE quadruple-precision conversion routines.
 *----------------------------------------------------------------------------*/
+int16_t float128_to_int16(float128, float_status *status);
+int16_t float128_to_int16_round_to_zero(float128, float_status *status);
+uint16_t float128_to_uint16(float128, float_status *status);
+uint16_t float128_to_uint16_round_to_zero(float128, float_status *status);
 int32_t float128_to_int32(float128, float_status *status);
 int32_t float128_to_int32_round_to_zero(float128, float_status *status);
+uint32_t float128_to_uint32(float128, float_status *status);
+uint32_t float128_to_uint32_round_to_zero(float128, float_status *status);
 int64_t float128_to_int64(float128, float_status *status);
 int64_t float128_to_int64_round_to_zero(float128, float_status *status);
 uint64_t float128_to_uint64(float128, float_status *status);
 uint64_t float128_to_uint64_round_to_zero(float128, float_status *status);
-uint32_t float128_to_uint32_round_to_zero(float128, float_status *status);
 float32 float128_to_float32(float128, float_status *status);
 float64 float128_to_float64(float128, float_status *status);
 floatx80 float128_to_floatx80(float128, float_status *status);
diff --git a/fpu/floatxx.inc.c b/fpu/floatxx.inc.c
index aca5ed3097..da6c17afab 100644
--- a/fpu/floatxx.inc.c
+++ b/fpu/floatxx.inc.c
@@ -96,3 +96,48 @@ FLOATXX glue(FLOATXX,_div)(FLOATXX a, FLOATXX b, float_status *status)
 
     return r;
 }
+
+#define DO_FLOAT_TO_INT(NAME, SZ, FP_TO_INT_WHICH)   \
+int##SZ##_t NAME(FLOATXX a, float_status *status) \
+{                                                 \
+    FP_DECL_EX;                                   \
+    glue(FP_DECL_, FS)(A);                        \
+    uint##SZ##_t r;                               \
+    FP_INIT_ROUNDMODE;                            \
+    glue(FP_UNPACK_RAW_, FS)(A, a);               \
+    glue(FP_TO_INT_WHICH, FS)(r, A, SZ, 1);       \
+    FP_HANDLE_EXCEPTIONS;                         \
+    return r;                                     \
+}
+
+#define DO_FLOAT_TO_UINT(NAME, SZ, FP_TO_INT_WHICH)   \
+uint##SZ##_t NAME(FLOATXX a, float_status *status) \
+{                                                  \
+    FP_DECL_EX;                                    \
+    glue(FP_DECL_, FS)(A);                         \
+    uint##SZ##_t r;                                \
+    FP_INIT_ROUNDMODE;                             \
+    glue(FP_UNPACK_RAW_, FS)(A, a);                \
+    glue(FP_TO_INT_WHICH, FS)(r, A, SZ, 0);        \
+    FP_HANDLE_EXCEPTIONS;                          \
+    return r;                                      \
+}
+
+DO_FLOAT_TO_INT(glue(FLOATXX,_to_int16), 16, FP_TO_INT_ROUND_)
+DO_FLOAT_TO_INT(glue(FLOATXX,_to_int32), 32, FP_TO_INT_ROUND_)
+DO_FLOAT_TO_INT(glue(FLOATXX,_to_int64), 64, FP_TO_INT_ROUND_)
+
+DO_FLOAT_TO_INT(glue(FLOATXX,_to_int16_round_to_zero), 16, FP_TO_INT_)
+DO_FLOAT_TO_INT(glue(FLOATXX,_to_int32_round_to_zero), 32, FP_TO_INT_)
+DO_FLOAT_TO_INT(glue(FLOATXX,_to_int64_round_to_zero), 64, FP_TO_INT_)
+
+DO_FLOAT_TO_UINT(glue(FLOATXX,_to_uint16), 16, FP_TO_INT_ROUND_)
+DO_FLOAT_TO_UINT(glue(FLOATXX,_to_uint32), 32, FP_TO_INT_ROUND_)
+DO_FLOAT_TO_UINT(glue(FLOATXX,_to_uint64), 64, FP_TO_INT_ROUND_)
+
+DO_FLOAT_TO_UINT(glue(FLOATXX,_to_uint16_round_to_zero), 16, FP_TO_INT_)
+DO_FLOAT_TO_UINT(glue(FLOATXX,_to_uint32_round_to_zero), 32, FP_TO_INT_)
+DO_FLOAT_TO_UINT(glue(FLOATXX,_to_uint64_round_to_zero), 64, FP_TO_INT_)
+
+#undef DO_FLOAT_TO_INT
+#undef DO_FLOAT_TO_UINT
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7cadf8ef1e..3fe12abab1 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -244,61 +244,6 @@ static int64_t roundAndPackInt64(flag zSign, uint64_t absZ0, uint64_t absZ1,
 
 }
 
-/*----------------------------------------------------------------------------
-| Takes the 128-bit fixed-point value formed by concatenating `absZ0' and
-| `absZ1', with binary point between bits 63 and 64 (between the input words),
-| and returns the properly rounded 64-bit unsigned integer corresponding to the
-| input.  Ordinarily, the fixed-point input is simply rounded to an integer,
-| with the inexact exception raised if the input cannot be represented exactly
-| as an integer.  However, if the fixed-point input is too large, the invalid
-| exception is raised and the largest unsigned integer is returned.
-*----------------------------------------------------------------------------*/
-
-static int64_t roundAndPackUint64(flag zSign, uint64_t absZ0,
-                                uint64_t absZ1, float_status *status)
-{
-    int8_t roundingMode;
-    flag roundNearestEven, increment;
-
-    roundingMode = status->float_rounding_mode;
-    roundNearestEven = (roundingMode == float_round_nearest_even);
-    switch (roundingMode) {
-    case float_round_nearest_even:
-    case float_round_ties_away:
-        increment = ((int64_t)absZ1 < 0);
-        break;
-    case float_round_to_zero:
-        increment = 0;
-        break;
-    case float_round_up:
-        increment = !zSign && absZ1;
-        break;
-    case float_round_down:
-        increment = zSign && absZ1;
-        break;
-    default:
-        abort();
-    }
-    if (increment) {
-        ++absZ0;
-        if (absZ0 == 0) {
-            float_raise(float_flag_invalid, status);
-            return LIT64(0xFFFFFFFFFFFFFFFF);
-        }
-        absZ0 &= ~(((uint64_t)(absZ1<<1) == 0) & roundNearestEven);
-    }
-
-    if (zSign && absZ0) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-
-    if (absZ1) {
-        status->float_exception_flags |= float_flag_inexact;
-    }
-    return absZ0;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the fraction bits of the single-precision floating-point value `a'.
 *----------------------------------------------------------------------------*/
@@ -1549,289 +1494,6 @@ float128 uint64_to_float128(uint64_t a, float_status *status)
     return normalizeRoundAndPackFloat128(0, 0x406E, a, 0, status);
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of converting the single-precision floating-point value
-| `a' to the 32-bit two's complement integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic---which means in particular that the conversion is rounded
-| according to the current rounding mode.  If `a' is a NaN, the largest
-| positive integer is returned.  Otherwise, if the conversion overflows, the
-| largest integer with the same sign as `a' is returned.
-*----------------------------------------------------------------------------*/
-
-int32_t float32_to_int32(float32 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint32_t aSig;
-    uint64_t aSig64;
-
-    a = float32_squash_input_denormal(a, status);
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    if ( ( aExp == 0xFF ) && aSig ) aSign = 0;
-    if ( aExp ) aSig |= 0x00800000;
-    shiftCount = 0xAF - aExp;
-    aSig64 = aSig;
-    aSig64 <<= 32;
-    if ( 0 < shiftCount ) shift64RightJamming( aSig64, shiftCount, &aSig64 );
-    return roundAndPackInt32(aSign, aSig64, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the single-precision floating-point value
-| `a' to the 32-bit two's complement integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic, except that the conversion is always rounded toward zero.
-| If `a' is a NaN, the largest positive integer is returned.  Otherwise, if
-| the conversion overflows, the largest integer with the same sign as `a' is
-| returned.
-*----------------------------------------------------------------------------*/
-
-int32_t float32_to_int32_round_to_zero(float32 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint32_t aSig;
-    int32_t z;
-    a = float32_squash_input_denormal(a, status);
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    shiftCount = aExp - 0x9E;
-    if ( 0 <= shiftCount ) {
-        if ( float32_val(a) != 0xCF000000 ) {
-            float_raise(float_flag_invalid, status);
-            if ( ! aSign || ( ( aExp == 0xFF ) && aSig ) ) return 0x7FFFFFFF;
-        }
-        return (int32_t) 0x80000000;
-    }
-    else if ( aExp <= 0x7E ) {
-        if (aExp | aSig) {
-            status->float_exception_flags |= float_flag_inexact;
-        }
-        return 0;
-    }
-    aSig = ( aSig | 0x00800000 )<<8;
-    z = aSig>>( - shiftCount );
-    if ( (uint32_t) ( aSig<<( shiftCount & 31 ) ) ) {
-        status->float_exception_flags |= float_flag_inexact;
-    }
-    if ( aSign ) z = - z;
-    return z;
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the single-precision floating-point value
-| `a' to the 16-bit two's complement integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic, except that the conversion is always rounded toward zero.
-| If `a' is a NaN, the largest positive integer is returned.  Otherwise, if
-| the conversion overflows, the largest integer with the same sign as `a' is
-| returned.
-*----------------------------------------------------------------------------*/
-
-int16_t float32_to_int16_round_to_zero(float32 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint32_t aSig;
-    int32_t z;
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    shiftCount = aExp - 0x8E;
-    if ( 0 <= shiftCount ) {
-        if ( float32_val(a) != 0xC7000000 ) {
-            float_raise(float_flag_invalid, status);
-            if ( ! aSign || ( ( aExp == 0xFF ) && aSig ) ) {
-                return 0x7FFF;
-            }
-        }
-        return (int32_t) 0xffff8000;
-    }
-    else if ( aExp <= 0x7E ) {
-        if ( aExp | aSig ) {
-            status->float_exception_flags |= float_flag_inexact;
-        }
-        return 0;
-    }
-    shiftCount -= 0x10;
-    aSig = ( aSig | 0x00800000 )<<8;
-    z = aSig>>( - shiftCount );
-    if ( (uint32_t) ( aSig<<( shiftCount & 31 ) ) ) {
-        status->float_exception_flags |= float_flag_inexact;
-    }
-    if ( aSign ) {
-        z = - z;
-    }
-    return z;
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the single-precision floating-point value
-| `a' to the 64-bit two's complement integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic---which means in particular that the conversion is rounded
-| according to the current rounding mode.  If `a' is a NaN, the largest
-| positive integer is returned.  Otherwise, if the conversion overflows, the
-| largest integer with the same sign as `a' is returned.
-*----------------------------------------------------------------------------*/
-
-int64_t float32_to_int64(float32 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint32_t aSig;
-    uint64_t aSig64, aSigExtra;
-    a = float32_squash_input_denormal(a, status);
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    shiftCount = 0xBE - aExp;
-    if ( shiftCount < 0 ) {
-        float_raise(float_flag_invalid, status);
-        if ( ! aSign || ( ( aExp == 0xFF ) && aSig ) ) {
-            return LIT64( 0x7FFFFFFFFFFFFFFF );
-        }
-        return (int64_t) LIT64( 0x8000000000000000 );
-    }
-    if ( aExp ) aSig |= 0x00800000;
-    aSig64 = aSig;
-    aSig64 <<= 40;
-    shift64ExtraRightJamming( aSig64, 0, shiftCount, &aSig64, &aSigExtra );
-    return roundAndPackInt64(aSign, aSig64, aSigExtra, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the single-precision floating-point value
-| `a' to the 64-bit unsigned integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic---which means in particular that the conversion is rounded
-| according to the current rounding mode.  If `a' is a NaN, the largest
-| unsigned integer is returned.  Otherwise, if the conversion overflows, the
-| largest unsigned integer is returned.  If the 'a' is negative, the result
-| is rounded and zero is returned; values that do not round to zero will
-| raise the inexact exception flag.
-*----------------------------------------------------------------------------*/
-
-uint64_t float32_to_uint64(float32 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint32_t aSig;
-    uint64_t aSig64, aSigExtra;
-    a = float32_squash_input_denormal(a, status);
-
-    aSig = extractFloat32Frac(a);
-    aExp = extractFloat32Exp(a);
-    aSign = extractFloat32Sign(a);
-    if ((aSign) && (aExp > 126)) {
-        float_raise(float_flag_invalid, status);
-        if (float32_is_any_nan(a)) {
-            return LIT64(0xFFFFFFFFFFFFFFFF);
-        } else {
-            return 0;
-        }
-    }
-    shiftCount = 0xBE - aExp;
-    if (aExp) {
-        aSig |= 0x00800000;
-    }
-    if (shiftCount < 0) {
-        float_raise(float_flag_invalid, status);
-        return LIT64(0xFFFFFFFFFFFFFFFF);
-    }
-
-    aSig64 = aSig;
-    aSig64 <<= 40;
-    shift64ExtraRightJamming(aSig64, 0, shiftCount, &aSig64, &aSigExtra);
-    return roundAndPackUint64(aSign, aSig64, aSigExtra, status);
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the single-precision floating-point value
-| `a' to the 64-bit unsigned integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic, except that the conversion is always rounded toward zero.  If
-| `a' is a NaN, the largest unsigned integer is returned.  Otherwise, if the
-| conversion overflows, the largest unsigned integer is returned.  If the
-| 'a' is negative, the result is rounded and zero is returned; values that do
-| not round to zero will raise the inexact flag.
-*----------------------------------------------------------------------------*/
-
-uint64_t float32_to_uint64_round_to_zero(float32 a, float_status *status)
-{
-    signed char current_rounding_mode = status->float_rounding_mode;
-    set_float_rounding_mode(float_round_to_zero, status);
-    int64_t v = float32_to_uint64(a, status);
-    set_float_rounding_mode(current_rounding_mode, status);
-    return v;
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the single-precision floating-point value
-| `a' to the 64-bit two's complement integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic, except that the conversion is always rounded toward zero.  If
-| `a' is a NaN, the largest positive integer is returned.  Otherwise, if the
-| conversion overflows, the largest integer with the same sign as `a' is
-| returned.
-*----------------------------------------------------------------------------*/
-
-int64_t float32_to_int64_round_to_zero(float32 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint32_t aSig;
-    uint64_t aSig64;
-    int64_t z;
-    a = float32_squash_input_denormal(a, status);
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    shiftCount = aExp - 0xBE;
-    if ( 0 <= shiftCount ) {
-        if ( float32_val(a) != 0xDF000000 ) {
-            float_raise(float_flag_invalid, status);
-            if ( ! aSign || ( ( aExp == 0xFF ) && aSig ) ) {
-                return LIT64( 0x7FFFFFFFFFFFFFFF );
-            }
-        }
-        return (int64_t) LIT64( 0x8000000000000000 );
-    }
-    else if ( aExp <= 0x7E ) {
-        if (aExp | aSig) {
-            status->float_exception_flags |= float_flag_inexact;
-        }
-        return 0;
-    }
-    aSig64 = aSig | 0x00800000;
-    aSig64 <<= 40;
-    z = aSig64>>( - shiftCount );
-    if ( (uint64_t) ( aSig64<<( shiftCount & 63 ) ) ) {
-        status->float_exception_flags |= float_flag_inexact;
-    }
-    if ( aSign ) z = - z;
-    return z;
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the single-precision floating-point value
 | `a' to the double-precision floating-point format.  The conversion is
@@ -2742,237 +2404,6 @@ int float32_unordered_quiet(float32 a, float32 b, float_status *status)
     return 0;
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of converting the double-precision floating-point value
-| `a' to the 32-bit two's complement integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic---which means in particular that the conversion is rounded
-| according to the current rounding mode.  If `a' is a NaN, the largest
-| positive integer is returned.  Otherwise, if the conversion overflows, the
-| largest integer with the same sign as `a' is returned.
-*----------------------------------------------------------------------------*/
-
-int32_t float64_to_int32(float64 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint64_t aSig;
-    a = float64_squash_input_denormal(a, status);
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-    if ( ( aExp == 0x7FF ) && aSig ) aSign = 0;
-    if ( aExp ) aSig |= LIT64( 0x0010000000000000 );
-    shiftCount = 0x42C - aExp;
-    if ( 0 < shiftCount ) shift64RightJamming( aSig, shiftCount, &aSig );
-    return roundAndPackInt32(aSign, aSig, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the double-precision floating-point value
-| `a' to the 32-bit two's complement integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic, except that the conversion is always rounded toward zero.
-| If `a' is a NaN, the largest positive integer is returned.  Otherwise, if
-| the conversion overflows, the largest integer with the same sign as `a' is
-| returned.
-*----------------------------------------------------------------------------*/
-
-int32_t float64_to_int32_round_to_zero(float64 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint64_t aSig, savedASig;
-    int32_t z;
-    a = float64_squash_input_denormal(a, status);
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-    if ( 0x41E < aExp ) {
-        if ( ( aExp == 0x7FF ) && aSig ) aSign = 0;
-        goto invalid;
-    }
-    else if ( aExp < 0x3FF ) {
-        if (aExp || aSig) {
-            status->float_exception_flags |= float_flag_inexact;
-        }
-        return 0;
-    }
-    aSig |= LIT64( 0x0010000000000000 );
-    shiftCount = 0x433 - aExp;
-    savedASig = aSig;
-    aSig >>= shiftCount;
-    z = aSig;
-    if ( aSign ) z = - z;
-    if ( ( z < 0 ) ^ aSign ) {
- invalid:
-        float_raise(float_flag_invalid, status);
-        return aSign ? (int32_t) 0x80000000 : 0x7FFFFFFF;
-    }
-    if ( ( aSig<<shiftCount ) != savedASig ) {
-        status->float_exception_flags |= float_flag_inexact;
-    }
-    return z;
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the double-precision floating-point value
-| `a' to the 16-bit two's complement integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic, except that the conversion is always rounded toward zero.
-| If `a' is a NaN, the largest positive integer is returned.  Otherwise, if
-| the conversion overflows, the largest integer with the same sign as `a' is
-| returned.
-*----------------------------------------------------------------------------*/
-
-int16_t float64_to_int16_round_to_zero(float64 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint64_t aSig, savedASig;
-    int32_t z;
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-    if ( 0x40E < aExp ) {
-        if ( ( aExp == 0x7FF ) && aSig ) {
-            aSign = 0;
-        }
-        goto invalid;
-    }
-    else if ( aExp < 0x3FF ) {
-        if ( aExp || aSig ) {
-            status->float_exception_flags |= float_flag_inexact;
-        }
-        return 0;
-    }
-    aSig |= LIT64( 0x0010000000000000 );
-    shiftCount = 0x433 - aExp;
-    savedASig = aSig;
-    aSig >>= shiftCount;
-    z = aSig;
-    if ( aSign ) {
-        z = - z;
-    }
-    if ( ( (int16_t)z < 0 ) ^ aSign ) {
- invalid:
-        float_raise(float_flag_invalid, status);
-        return aSign ? (int32_t) 0xffff8000 : 0x7FFF;
-    }
-    if ( ( aSig<<shiftCount ) != savedASig ) {
-        status->float_exception_flags |= float_flag_inexact;
-    }
-    return z;
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the double-precision floating-point value
-| `a' to the 64-bit two's complement integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic---which means in particular that the conversion is rounded
-| according to the current rounding mode.  If `a' is a NaN, the largest
-| positive integer is returned.  Otherwise, if the conversion overflows, the
-| largest integer with the same sign as `a' is returned.
-*----------------------------------------------------------------------------*/
-
-int64_t float64_to_int64(float64 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint64_t aSig, aSigExtra;
-    a = float64_squash_input_denormal(a, status);
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-    if ( aExp ) aSig |= LIT64( 0x0010000000000000 );
-    shiftCount = 0x433 - aExp;
-    if ( shiftCount <= 0 ) {
-        if ( 0x43E < aExp ) {
-            float_raise(float_flag_invalid, status);
-            if (    ! aSign
-                 || (    ( aExp == 0x7FF )
-                      && ( aSig != LIT64( 0x0010000000000000 ) ) )
-               ) {
-                return LIT64( 0x7FFFFFFFFFFFFFFF );
-            }
-            return (int64_t) LIT64( 0x8000000000000000 );
-        }
-        aSigExtra = 0;
-        aSig <<= - shiftCount;
-    }
-    else {
-        shift64ExtraRightJamming( aSig, 0, shiftCount, &aSig, &aSigExtra );
-    }
-    return roundAndPackInt64(aSign, aSig, aSigExtra, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the double-precision floating-point value
-| `a' to the 64-bit two's complement integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic, except that the conversion is always rounded toward zero.
-| If `a' is a NaN, the largest positive integer is returned.  Otherwise, if
-| the conversion overflows, the largest integer with the same sign as `a' is
-| returned.
-*----------------------------------------------------------------------------*/
-
-int64_t float64_to_int64_round_to_zero(float64 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint64_t aSig;
-    int64_t z;
-    a = float64_squash_input_denormal(a, status);
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-    if ( aExp ) aSig |= LIT64( 0x0010000000000000 );
-    shiftCount = aExp - 0x433;
-    if ( 0 <= shiftCount ) {
-        if ( 0x43E <= aExp ) {
-            if ( float64_val(a) != LIT64( 0xC3E0000000000000 ) ) {
-                float_raise(float_flag_invalid, status);
-                if (    ! aSign
-                     || (    ( aExp == 0x7FF )
-                          && ( aSig != LIT64( 0x0010000000000000 ) ) )
-                   ) {
-                    return LIT64( 0x7FFFFFFFFFFFFFFF );
-                }
-            }
-            return (int64_t) LIT64( 0x8000000000000000 );
-        }
-        z = aSig<<shiftCount;
-    }
-    else {
-        if ( aExp < 0x3FE ) {
-            if (aExp | aSig) {
-                status->float_exception_flags |= float_flag_inexact;
-            }
-            return 0;
-        }
-        z = aSig>>( - shiftCount );
-        if ( (uint64_t) ( aSig<<( shiftCount & 63 ) ) ) {
-            status->float_exception_flags |= float_flag_inexact;
-        }
-    }
-    if ( aSign ) z = - z;
-    return z;
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the double-precision floating-point value
 | `a' to the single-precision floating-point format.  The conversion is
@@ -5269,278 +4700,6 @@ int floatx80_unordered_quiet(floatx80 a, floatx80 b, float_status *status)
     return 0;
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of converting the quadruple-precision floating-point
-| value `a' to the 32-bit two's complement integer format.  The conversion
-| is performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic---which means in particular that the conversion is rounded
-| according to the current rounding mode.  If `a' is a NaN, the largest
-| positive integer is returned.  Otherwise, if the conversion overflows, the
-| largest integer with the same sign as `a' is returned.
-*----------------------------------------------------------------------------*/
-
-int32_t float128_to_int32(float128 a, float_status *status)
-{
-    flag aSign;
-    int32_t aExp, shiftCount;
-    uint64_t aSig0, aSig1;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    aSign = extractFloat128Sign( a );
-    if ( ( aExp == 0x7FFF ) && ( aSig0 | aSig1 ) ) aSign = 0;
-    if ( aExp ) aSig0 |= LIT64( 0x0001000000000000 );
-    aSig0 |= ( aSig1 != 0 );
-    shiftCount = 0x4028 - aExp;
-    if ( 0 < shiftCount ) shift64RightJamming( aSig0, shiftCount, &aSig0 );
-    return roundAndPackInt32(aSign, aSig0, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the quadruple-precision floating-point
-| value `a' to the 32-bit two's complement integer format.  The conversion
-| is performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic, except that the conversion is always rounded toward zero.  If
-| `a' is a NaN, the largest positive integer is returned.  Otherwise, if the
-| conversion overflows, the largest integer with the same sign as `a' is
-| returned.
-*----------------------------------------------------------------------------*/
-
-int32_t float128_to_int32_round_to_zero(float128 a, float_status *status)
-{
-    flag aSign;
-    int32_t aExp, shiftCount;
-    uint64_t aSig0, aSig1, savedASig;
-    int32_t z;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    aSign = extractFloat128Sign( a );
-    aSig0 |= ( aSig1 != 0 );
-    if ( 0x401E < aExp ) {
-        if ( ( aExp == 0x7FFF ) && aSig0 ) aSign = 0;
-        goto invalid;
-    }
-    else if ( aExp < 0x3FFF ) {
-        if (aExp || aSig0) {
-            status->float_exception_flags |= float_flag_inexact;
-        }
-        return 0;
-    }
-    aSig0 |= LIT64( 0x0001000000000000 );
-    shiftCount = 0x402F - aExp;
-    savedASig = aSig0;
-    aSig0 >>= shiftCount;
-    z = aSig0;
-    if ( aSign ) z = - z;
-    if ( ( z < 0 ) ^ aSign ) {
- invalid:
-        float_raise(float_flag_invalid, status);
-        return aSign ? (int32_t) 0x80000000 : 0x7FFFFFFF;
-    }
-    if ( ( aSig0<<shiftCount ) != savedASig ) {
-        status->float_exception_flags |= float_flag_inexact;
-    }
-    return z;
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the quadruple-precision floating-point
-| value `a' to the 64-bit two's complement integer format.  The conversion
-| is performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic---which means in particular that the conversion is rounded
-| according to the current rounding mode.  If `a' is a NaN, the largest
-| positive integer is returned.  Otherwise, if the conversion overflows, the
-| largest integer with the same sign as `a' is returned.
-*----------------------------------------------------------------------------*/
-
-int64_t float128_to_int64(float128 a, float_status *status)
-{
-    flag aSign;
-    int32_t aExp, shiftCount;
-    uint64_t aSig0, aSig1;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    aSign = extractFloat128Sign( a );
-    if ( aExp ) aSig0 |= LIT64( 0x0001000000000000 );
-    shiftCount = 0x402F - aExp;
-    if ( shiftCount <= 0 ) {
-        if ( 0x403E < aExp ) {
-            float_raise(float_flag_invalid, status);
-            if (    ! aSign
-                 || (    ( aExp == 0x7FFF )
-                      && ( aSig1 || ( aSig0 != LIT64( 0x0001000000000000 ) ) )
-                    )
-               ) {
-                return LIT64( 0x7FFFFFFFFFFFFFFF );
-            }
-            return (int64_t) LIT64( 0x8000000000000000 );
-        }
-        shortShift128Left( aSig0, aSig1, - shiftCount, &aSig0, &aSig1 );
-    }
-    else {
-        shift64ExtraRightJamming( aSig0, aSig1, shiftCount, &aSig0, &aSig1 );
-    }
-    return roundAndPackInt64(aSign, aSig0, aSig1, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the quadruple-precision floating-point
-| value `a' to the 64-bit two's complement integer format.  The conversion
-| is performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic, except that the conversion is always rounded toward zero.
-| If `a' is a NaN, the largest positive integer is returned.  Otherwise, if
-| the conversion overflows, the largest integer with the same sign as `a' is
-| returned.
-*----------------------------------------------------------------------------*/
-
-int64_t float128_to_int64_round_to_zero(float128 a, float_status *status)
-{
-    flag aSign;
-    int32_t aExp, shiftCount;
-    uint64_t aSig0, aSig1;
-    int64_t z;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    aSign = extractFloat128Sign( a );
-    if ( aExp ) aSig0 |= LIT64( 0x0001000000000000 );
-    shiftCount = aExp - 0x402F;
-    if ( 0 < shiftCount ) {
-        if ( 0x403E <= aExp ) {
-            aSig0 &= LIT64( 0x0000FFFFFFFFFFFF );
-            if (    ( a.high == LIT64( 0xC03E000000000000 ) )
-                 && ( aSig1 < LIT64( 0x0002000000000000 ) ) ) {
-                if (aSig1) {
-                    status->float_exception_flags |= float_flag_inexact;
-                }
-            }
-            else {
-                float_raise(float_flag_invalid, status);
-                if ( ! aSign || ( ( aExp == 0x7FFF ) && ( aSig0 | aSig1 ) ) ) {
-                    return LIT64( 0x7FFFFFFFFFFFFFFF );
-                }
-            }
-            return (int64_t) LIT64( 0x8000000000000000 );
-        }
-        z = ( aSig0<<shiftCount ) | ( aSig1>>( ( - shiftCount ) & 63 ) );
-        if ( (uint64_t) ( aSig1<<shiftCount ) ) {
-            status->float_exception_flags |= float_flag_inexact;
-        }
-    }
-    else {
-        if ( aExp < 0x3FFF ) {
-            if ( aExp | aSig0 | aSig1 ) {
-                status->float_exception_flags |= float_flag_inexact;
-            }
-            return 0;
-        }
-        z = aSig0>>( - shiftCount );
-        if (    aSig1
-             || ( shiftCount && (uint64_t) ( aSig0<<( shiftCount & 63 ) ) ) ) {
-            status->float_exception_flags |= float_flag_inexact;
-        }
-    }
-    if ( aSign ) z = - z;
-    return z;
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the quadruple-precision floating-point value
-| `a' to the 64-bit unsigned integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic---which means in particular that the conversion is rounded
-| according to the current rounding mode.  If `a' is a NaN, the largest
-| positive integer is returned.  If the conversion overflows, the
-| largest unsigned integer is returned.  If 'a' is negative, the value is
-| rounded and zero is returned; negative values that do not round to zero
-| will raise the inexact exception.
-*----------------------------------------------------------------------------*/
-
-uint64_t float128_to_uint64(float128 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint64_t aSig0, aSig1;
-
-    aSig0 = extractFloat128Frac0(a);
-    aSig1 = extractFloat128Frac1(a);
-    aExp = extractFloat128Exp(a);
-    aSign = extractFloat128Sign(a);
-    if (aSign && (aExp > 0x3FFE)) {
-        float_raise(float_flag_invalid, status);
-        if (float128_is_any_nan(a)) {
-            return LIT64(0xFFFFFFFFFFFFFFFF);
-        } else {
-            return 0;
-        }
-    }
-    if (aExp) {
-        aSig0 |= LIT64(0x0001000000000000);
-    }
-    shiftCount = 0x402F - aExp;
-    if (shiftCount <= 0) {
-        if (0x403E < aExp) {
-            float_raise(float_flag_invalid, status);
-            return LIT64(0xFFFFFFFFFFFFFFFF);
-        }
-        shortShift128Left(aSig0, aSig1, -shiftCount, &aSig0, &aSig1);
-    } else {
-        shift64ExtraRightJamming(aSig0, aSig1, shiftCount, &aSig0, &aSig1);
-    }
-    return roundAndPackUint64(aSign, aSig0, aSig1, status);
-}
-
-uint64_t float128_to_uint64_round_to_zero(float128 a, float_status *status)
-{
-    uint64_t v;
-    signed char current_rounding_mode = status->float_rounding_mode;
-
-    set_float_rounding_mode(float_round_to_zero, status);
-    v = float128_to_uint64(a, status);
-    set_float_rounding_mode(current_rounding_mode, status);
-
-    return v;
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the quadruple-precision floating-point
-| value `a' to the 32-bit unsigned integer format.  The conversion
-| is performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic except that the conversion is always rounded toward zero.
-| If `a' is a NaN, the largest positive integer is returned.  Otherwise,
-| if the conversion overflows, the largest unsigned integer is returned.
-| If 'a' is negative, the value is rounded and zero is returned; negative
-| values that do not round to zero will raise the inexact exception.
-*----------------------------------------------------------------------------*/
-
-uint32_t float128_to_uint32_round_to_zero(float128 a, float_status *status)
-{
-    uint64_t v;
-    uint32_t res;
-    int old_exc_flags = get_float_exception_flags(status);
-
-    v = float128_to_uint64_round_to_zero(a, status);
-    if (v > 0xffffffff) {
-        res = 0xffffffff;
-    } else {
-        return v;
-    }
-    set_float_exception_flags(old_exc_flags, status);
-    float_raise(float_flag_invalid, status);
-    return res;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the quadruple-precision floating-point
 | value `a' to the single-precision floating-point format.  The conversion
@@ -6206,253 +5365,6 @@ float64 uint32_to_float64(uint32_t a, float_status *status)
     return int64_to_float64(a, status);
 }
 
-uint32_t float32_to_uint32(float32 a, float_status *status)
-{
-    int64_t v;
-    uint32_t res;
-    int old_exc_flags = get_float_exception_flags(status);
-
-    v = float32_to_int64(a, status);
-    if (v < 0) {
-        res = 0;
-    } else if (v > 0xffffffff) {
-        res = 0xffffffff;
-    } else {
-        return v;
-    }
-    set_float_exception_flags(old_exc_flags, status);
-    float_raise(float_flag_invalid, status);
-    return res;
-}
-
-uint32_t float32_to_uint32_round_to_zero(float32 a, float_status *status)
-{
-    int64_t v;
-    uint32_t res;
-    int old_exc_flags = get_float_exception_flags(status);
-
-    v = float32_to_int64_round_to_zero(a, status);
-    if (v < 0) {
-        res = 0;
-    } else if (v > 0xffffffff) {
-        res = 0xffffffff;
-    } else {
-        return v;
-    }
-    set_float_exception_flags(old_exc_flags, status);
-    float_raise(float_flag_invalid, status);
-    return res;
-}
-
-int16_t float32_to_int16(float32 a, float_status *status)
-{
-    int32_t v;
-    int16_t res;
-    int old_exc_flags = get_float_exception_flags(status);
-
-    v = float32_to_int32(a, status);
-    if (v < -0x8000) {
-        res = -0x8000;
-    } else if (v > 0x7fff) {
-        res = 0x7fff;
-    } else {
-        return v;
-    }
-
-    set_float_exception_flags(old_exc_flags, status);
-    float_raise(float_flag_invalid, status);
-    return res;
-}
-
-uint16_t float32_to_uint16(float32 a, float_status *status)
-{
-    int32_t v;
-    uint16_t res;
-    int old_exc_flags = get_float_exception_flags(status);
-
-    v = float32_to_int32(a, status);
-    if (v < 0) {
-        res = 0;
-    } else if (v > 0xffff) {
-        res = 0xffff;
-    } else {
-        return v;
-    }
-
-    set_float_exception_flags(old_exc_flags, status);
-    float_raise(float_flag_invalid, status);
-    return res;
-}
-
-uint16_t float32_to_uint16_round_to_zero(float32 a, float_status *status)
-{
-    int64_t v;
-    uint16_t res;
-    int old_exc_flags = get_float_exception_flags(status);
-
-    v = float32_to_int64_round_to_zero(a, status);
-    if (v < 0) {
-        res = 0;
-    } else if (v > 0xffff) {
-        res = 0xffff;
-    } else {
-        return v;
-    }
-    set_float_exception_flags(old_exc_flags, status);
-    float_raise(float_flag_invalid, status);
-    return res;
-}
-
-uint32_t float64_to_uint32(float64 a, float_status *status)
-{
-    uint64_t v;
-    uint32_t res;
-    int old_exc_flags = get_float_exception_flags(status);
-
-    v = float64_to_uint64(a, status);
-    if (v > 0xffffffff) {
-        res = 0xffffffff;
-    } else {
-        return v;
-    }
-    set_float_exception_flags(old_exc_flags, status);
-    float_raise(float_flag_invalid, status);
-    return res;
-}
-
-uint32_t float64_to_uint32_round_to_zero(float64 a, float_status *status)
-{
-    uint64_t v;
-    uint32_t res;
-    int old_exc_flags = get_float_exception_flags(status);
-
-    v = float64_to_uint64_round_to_zero(a, status);
-    if (v > 0xffffffff) {
-        res = 0xffffffff;
-    } else {
-        return v;
-    }
-    set_float_exception_flags(old_exc_flags, status);
-    float_raise(float_flag_invalid, status);
-    return res;
-}
-
-int16_t float64_to_int16(float64 a, float_status *status)
-{
-    int64_t v;
-    int16_t res;
-    int old_exc_flags = get_float_exception_flags(status);
-
-    v = float64_to_int32(a, status);
-    if (v < -0x8000) {
-        res = -0x8000;
-    } else if (v > 0x7fff) {
-        res = 0x7fff;
-    } else {
-        return v;
-    }
-
-    set_float_exception_flags(old_exc_flags, status);
-    float_raise(float_flag_invalid, status);
-    return res;
-}
-
-uint16_t float64_to_uint16(float64 a, float_status *status)
-{
-    int64_t v;
-    uint16_t res;
-    int old_exc_flags = get_float_exception_flags(status);
-
-    v = float64_to_int32(a, status);
-    if (v < 0) {
-        res = 0;
-    } else if (v > 0xffff) {
-        res = 0xffff;
-    } else {
-        return v;
-    }
-
-    set_float_exception_flags(old_exc_flags, status);
-    float_raise(float_flag_invalid, status);
-    return res;
-}
-
-uint16_t float64_to_uint16_round_to_zero(float64 a, float_status *status)
-{
-    int64_t v;
-    uint16_t res;
-    int old_exc_flags = get_float_exception_flags(status);
-
-    v = float64_to_int64_round_to_zero(a, status);
-    if (v < 0) {
-        res = 0;
-    } else if (v > 0xffff) {
-        res = 0xffff;
-    } else {
-        return v;
-    }
-    set_float_exception_flags(old_exc_flags, status);
-    float_raise(float_flag_invalid, status);
-    return res;
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of converting the double-precision floating-point value
-| `a' to the 64-bit unsigned integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic---which means in particular that the conversion is rounded
-| according to the current rounding mode.  If `a' is a NaN, the largest
-| positive integer is returned.  If the conversion overflows, the
-| largest unsigned integer is returned.  If 'a' is negative, the value is
-| rounded and zero is returned; negative values that do not round to zero
-| will raise the inexact exception.
-*----------------------------------------------------------------------------*/
-
-uint64_t float64_to_uint64(float64 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint64_t aSig, aSigExtra;
-    a = float64_squash_input_denormal(a, status);
-
-    aSig = extractFloat64Frac(a);
-    aExp = extractFloat64Exp(a);
-    aSign = extractFloat64Sign(a);
-    if (aSign && (aExp > 1022)) {
-        float_raise(float_flag_invalid, status);
-        if (float64_is_any_nan(a)) {
-            return LIT64(0xFFFFFFFFFFFFFFFF);
-        } else {
-            return 0;
-        }
-    }
-    if (aExp) {
-        aSig |= LIT64(0x0010000000000000);
-    }
-    shiftCount = 0x433 - aExp;
-    if (shiftCount <= 0) {
-        if (0x43E < aExp) {
-            float_raise(float_flag_invalid, status);
-            return LIT64(0xFFFFFFFFFFFFFFFF);
-        }
-        aSigExtra = 0;
-        aSig <<= -shiftCount;
-    } else {
-        shift64ExtraRightJamming(aSig, 0, shiftCount, &aSig, &aSigExtra);
-    }
-    return roundAndPackUint64(aSign, aSig, aSigExtra, status);
-}
-
-uint64_t float64_to_uint64_round_to_zero(float64 a, float_status *status)
-{
-    signed char current_rounding_mode = status->float_rounding_mode;
-    set_float_rounding_mode(float_round_to_zero, status);
-    uint64_t v = float64_to_uint64(a, status);
-    set_float_rounding_mode(current_rounding_mode, status);
-    return v;
-}
-
 #define COMPARE(s, nan_exp)                                                  \
 static inline int float ## s ## _compare_internal(float ## s a, float ## s b,\
                                       int is_quiet, float_status *status)    \
-- 
2.14.3
