Received: from eggs.gnu.org ([2001:4830:134:3::10]:51548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsw0-0006nY-45
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvw-000755-8Y
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:16 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYsvv-00072X-R3
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:12 -0500
Received: by mail-wm0-x244.google.com with SMTP id i11so20234682wmf.4
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:23:11 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:48 +0000
Message-Id: <20180109122252.17670-17-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 16/20] fpu/softfloat: re-factor float to
 int/uint
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

We share the common int64/uint64_pack_decomposed function across all
the helpers and simply limit the final result depending on the final
size.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

--
v2
  - apply float_flg_invalid fixes next patch
---
 fpu/softfloat.c         | 1011 +++++++++++------------------------------------
 include/fpu/softfloat.h |   13 +
 2 files changed, 235 insertions(+), 789 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index edc35300d1..514f43c065 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1312,6 +1312,194 @@ float64 float64_trunc_to_int(float64 a, float_status *s)
     return float64_round_pack_canonical(pr, s);
 }
 
+/*----------------------------------------------------------------------------
+| Returns the result of converting the floating-point value
+| `a' to the two's complement integer format.  The conversion is
+| performed according to the IEC/IEEE Standard for Binary Floating-Point
+| Arithmetic---which means in particular that the conversion is rounded
+| according to the current rounding mode.  If `a' is a NaN, the largest
+| positive integer is returned.  Otherwise, if the conversion overflows, the
+| largest integer with the same sign as `a' is returned.
+*----------------------------------------------------------------------------*/
+
+static int64_t int64_pack_decomposed(decomposed_parts p, float_status *s)
+{
+    uint64_t r;
+
+    switch (p.cls) {
+    case float_class_snan:
+    case float_class_qnan:
+        return INT64_MAX;
+    case float_class_inf:
+        return p.sign ? INT64_MIN : INT64_MAX;
+    case float_class_zero:
+        return 0;
+    case float_class_normal:
+        if (p.exp < DECOMPOSED_BINARY_POINT) {
+            r = p.frac >> (DECOMPOSED_BINARY_POINT - p.exp);
+        } else if (p.exp < 64) {
+            r = p.frac << (p.exp - DECOMPOSED_BINARY_POINT);
+        } else {
+            s->float_exception_flags |= float_flag_invalid;
+            r = UINT64_MAX;
+        }
+        if (p.sign) {
+            return r < - (uint64_t) INT64_MIN ? -r : INT64_MIN;
+        } else {
+            return r < INT64_MAX ? r : INT64_MAX;
+        }
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static int16_t int16_pack_decomposed(decomposed_parts p, float_status *s)
+{
+    int64_t r = int64_pack_decomposed(p, s);
+    if (r < INT16_MIN) {
+        s->float_exception_flags |= float_flag_invalid;
+        return INT16_MIN;
+    } else if (r > INT16_MAX) {
+        s->float_exception_flags |= float_flag_invalid;
+        return INT16_MAX;
+    }
+    return r;
+}
+
+static int32_t int32_pack_decomposed(decomposed_parts p, float_status *s)
+{
+    int64_t r = int64_pack_decomposed(p, s);
+    if (r < INT32_MIN) {
+        s->float_exception_flags |= float_flag_invalid;
+        return INT32_MIN;
+    } else if (r > INT32_MAX) {
+        s->float_exception_flags |= float_flag_invalid;
+        return INT32_MAX;
+    }
+    return r;
+}
+
+#define FLOAT_TO_INT(fsz, isz) \
+int ## isz ## _t float ## fsz ## _to_int ## isz(float ## fsz a, float_status *s) \
+{                                                                       \
+    decomposed_parts pa = float ## fsz ## _unpack_canonical(a, s);      \
+    decomposed_parts pr = round_decomposed(pa, s->float_rounding_mode, s); \
+    return int ## isz ## _pack_decomposed(pr, s);                       \
+}                                                                       \
+                                                                        \
+int ## isz ## _t float ## fsz ## _to_int ## isz ## _round_to_zero       \
+ (float ## fsz a, float_status *s)                                      \
+{                                                                       \
+    decomposed_parts pa = float ## fsz ## _unpack_canonical(a, s);      \
+    decomposed_parts pr = round_decomposed(pa, float_round_to_zero, s); \
+    return int ## isz ## _pack_decomposed(pr, s);                       \
+}
+
+FLOAT_TO_INT(16, 16)
+FLOAT_TO_INT(16, 32)
+FLOAT_TO_INT(16, 64)
+
+FLOAT_TO_INT(32, 16)
+FLOAT_TO_INT(32, 32)
+FLOAT_TO_INT(32, 64)
+
+FLOAT_TO_INT(64, 16)
+FLOAT_TO_INT(64, 32)
+FLOAT_TO_INT(64, 64)
+
+#undef FLOAT_TO_INT
+
+/*
+ *  Returns the result of converting the floating-point value `a' to
+ *  the unsigned integer format. The conversion is performed according
+ *  to the IEC/IEEE Standard for Binary Floating-Point
+ *  Arithmetic---which means in particular that the conversion is
+ *  rounded according to the current rounding mode. If `a' is a NaN,
+ *  the largest unsigned integer is returned. Otherwise, if the
+ *  conversion overflows, the largest unsigned integer is returned. If
+ *  the 'a' is negative, the result is rounded and zero is returned;
+ *  values that do not round to zero will raise the inexact exception
+ *  flag.
+ */
+
+static uint64_t uint64_pack_decomposed(decomposed_parts p, float_status *s)
+{
+    switch (p.cls) {
+    case float_class_snan:
+    case float_class_qnan:
+        return UINT64_MAX;
+    case float_class_inf:
+        return p.sign ? 0 : UINT64_MAX;
+    case float_class_zero:
+        return 0;
+    case float_class_normal:
+        if (p.sign) {
+            s->float_exception_flags |= float_flag_invalid;
+            return 0;
+        }
+        if (p.exp < DECOMPOSED_BINARY_POINT) {
+            return p.frac >> (DECOMPOSED_BINARY_POINT - p.exp);
+        } else if (p.exp < 64) {
+            return p.frac << (p.exp - DECOMPOSED_BINARY_POINT);
+        } else {
+            s->float_exception_flags |= float_flag_invalid;
+            return UINT64_MAX;
+        }
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint16_t uint16_pack_decomposed(decomposed_parts p, float_status *s)
+{
+    uint64_t r = uint64_pack_decomposed(p, s);
+    if (r > UINT16_MAX) {
+        s->float_exception_flags |= float_flag_invalid;
+        r = UINT16_MAX;
+    }
+    return r;
+}
+
+static uint32_t uint32_pack_decomposed(decomposed_parts p, float_status *s)
+{
+    uint64_t r = uint64_pack_decomposed(p, s);
+    if (r > UINT32_MAX) {
+        s->float_exception_flags |= float_flag_invalid;
+        r = UINT32_MAX;
+    }
+    return r;
+}
+
+#define FLOAT_TO_UINT(fsz, isz) \
+uint ## isz ## _t float ## fsz ## _to_uint ## isz(float ## fsz a, float_status *s) \
+{                                                                       \
+    decomposed_parts pa = float ## fsz ## _unpack_canonical(a, s);      \
+    decomposed_parts pr = round_decomposed(pa, s->float_rounding_mode, s); \
+    return uint ## isz ## _pack_decomposed(pr, s);                      \
+}                                                                       \
+                                                                        \
+uint ## isz ## _t float ## fsz ## _to_uint ## isz ## _round_to_zero     \
+ (float ## fsz a, float_status *s)                                      \
+{                                                                       \
+    decomposed_parts pa = float ## fsz ## _unpack_canonical(a, s);      \
+    decomposed_parts pr = round_decomposed(pa, float_round_to_zero, s); \
+    return uint ## isz ## _pack_decomposed(pr, s);                      \
+}
+
+FLOAT_TO_UINT(16, 16)
+FLOAT_TO_UINT(16, 32)
+FLOAT_TO_UINT(16, 64)
+
+FLOAT_TO_UINT(32, 16)
+FLOAT_TO_UINT(32, 32)
+FLOAT_TO_UINT(32, 64)
+
+FLOAT_TO_UINT(64, 16)
+FLOAT_TO_UINT(64, 32)
+FLOAT_TO_UINT(64, 64)
+
+#undef FLOAT_TO_UINT
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -2663,288 +2851,8 @@ float128 uint64_to_float128(uint64_t a, float_status *status)
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
 
 /*----------------------------------------------------------------------------
 | Returns the result of converting the single-precision floating-point value
@@ -3500,289 +3408,59 @@ int float32_le_quiet(float32 a, float32 b, float_status *status)
 | Returns 1 if the single-precision floating-point value `a' is less than
 | the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
 | exception.  Otherwise, the comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_lt_quiet(float32 a, float32 b, float_status *status)
-{
-    flag aSign, bSign;
-    uint32_t av, bv;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        if (float32_is_signaling_nan(a, status)
-         || float32_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloat32Sign( a );
-    bSign = extractFloat32Sign( b );
-    av = float32_val(a);
-    bv = float32_val(b);
-    if ( aSign != bSign ) return aSign && ( (uint32_t) ( ( av | bv )<<1 ) != 0 );
-    return ( av != bv ) && ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point values `a' and `b' cannot
-| be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.  The
-| comparison is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_unordered_quiet(float32 a, float32 b, float_status *status)
-{
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        if (float32_is_signaling_nan(a, status)
-         || float32_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 1;
-    }
-    return 0;
-}
-
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
+| Standard for Binary Floating-Point Arithmetic.
 *----------------------------------------------------------------------------*/
 
-int64_t float64_to_int64(float64 a, float_status *status)
+int float32_lt_quiet(float32 a, float32 b, float_status *status)
 {
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint64_t aSig, aSigExtra;
-    a = float64_squash_input_denormal(a, status);
+    flag aSign, bSign;
+    uint32_t av, bv;
+    a = float32_squash_input_denormal(a, status);
+    b = float32_squash_input_denormal(b, status);
 
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-    if ( aExp ) aSig |= LIT64( 0x0010000000000000 );
-    shiftCount = 0x433 - aExp;
-    if ( shiftCount <= 0 ) {
-        if ( 0x43E < aExp ) {
+    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
+         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
+       ) {
+        if (float32_is_signaling_nan(a, status)
+         || float32_is_signaling_nan(b, status)) {
             float_raise(float_flag_invalid, status);
-            if (    ! aSign
-                 || (    ( aExp == 0x7FF )
-                      && ( aSig != LIT64( 0x0010000000000000 ) ) )
-               ) {
-                return LIT64( 0x7FFFFFFFFFFFFFFF );
-            }
-            return (int64_t) LIT64( 0x8000000000000000 );
         }
-        aSigExtra = 0;
-        aSig <<= - shiftCount;
-    }
-    else {
-        shift64ExtraRightJamming( aSig, 0, shiftCount, &aSig, &aSigExtra );
+        return 0;
     }
-    return roundAndPackInt64(aSign, aSig, aSigExtra, status);
+    aSign = extractFloat32Sign( a );
+    bSign = extractFloat32Sign( b );
+    av = float32_val(a);
+    bv = float32_val(b);
+    if ( aSign != bSign ) return aSign && ( (uint32_t) ( ( av | bv )<<1 ) != 0 );
+    return ( av != bv ) && ( aSign ^ ( av < bv ) );
 
 }
 
 /*----------------------------------------------------------------------------
-| Returns the result of converting the double-precision floating-point value
-| `a' to the 64-bit two's complement integer format.  The conversion is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic, except that the conversion is always rounded toward zero.
-| If `a' is a NaN, the largest positive integer is returned.  Otherwise, if
-| the conversion overflows, the largest integer with the same sign as `a' is
-| returned.
+| Returns 1 if the single-precision floating-point values `a' and `b' cannot
+| be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.  The
+| comparison is performed according to the IEC/IEEE Standard for Binary
+| Floating-Point Arithmetic.
 *----------------------------------------------------------------------------*/
 
-int64_t float64_to_int64_round_to_zero(float64 a, float_status *status)
+int float32_unordered_quiet(float32 a, float32 b, float_status *status)
 {
-    flag aSign;
-    int aExp;
-    int shiftCount;
-    uint64_t aSig;
-    int64_t z;
-    a = float64_squash_input_denormal(a, status);
+    a = float32_squash_input_denormal(a, status);
+    b = float32_squash_input_denormal(b, status);
 
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
+    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
+         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
+       ) {
+        if (float32_is_signaling_nan(a, status)
+         || float32_is_signaling_nan(b, status)) {
+            float_raise(float_flag_invalid, status);
         }
+        return 1;
     }
-    if ( aSign ) z = - z;
-    return z;
-
+    return 0;
 }
 
+
 /*----------------------------------------------------------------------------
 | Returns the result of converting the double-precision floating-point value
 | `a' to the single-precision floating-point format.  The conversion is
@@ -7049,252 +6727,7 @@ float64 uint32_to_float64(uint32_t a, float_status *status)
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
 
-uint64_t float64_to_uint64_round_to_zero(float64 a, float_status *status)
-{
-    signed char current_rounding_mode = status->float_rounding_mode;
-    set_float_rounding_mode(float_round_to_zero, status);
-    uint64_t v = float64_to_uint64(a, status);
-    set_float_rounding_mode(current_rounding_mode, status);
-    return v;
-}
 
 #define COMPARE(s, nan_exp)                                                  \
 static inline int float ## s ## _compare_internal(float ## s a, float ## s b,\
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 6427762a9a..d7bc7cbcb6 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -314,6 +314,19 @@ float16 float32_to_float16(float32, flag, float_status *status);
 float32 float16_to_float32(float16, flag, float_status *status);
 float16 float64_to_float16(float64 a, flag ieee, float_status *status);
 float64 float16_to_float64(float16 a, flag ieee, float_status *status);
+int16_t float16_to_int16(float16, float_status *status);
+uint16_t float16_to_uint16(float16 a, float_status *status);
+int16_t float16_to_int16_round_to_zero(float16, float_status *status);
+uint16_t float16_to_uint16_round_to_zero(float16 a, float_status *status);
+int32_t float16_to_int32(float16, float_status *status);
+uint32_t float16_to_uint32(float16 a, float_status *status);
+int32_t float16_to_int32_round_to_zero(float16, float_status *status);
+uint32_t float16_to_uint32_round_to_zero(float16 a, float_status *status);
+int64_t float16_to_int64(float16, float_status *status);
+uint64_t float16_to_uint64(float16 a, float_status *status);
+int64_t float16_to_int64_round_to_zero(float16, float_status *status);
+uint64_t float16_to_uint64_round_to_zero(float16 a, float_status *status);
+float16 int16_to_float16(int16_t a, float_status *status);
 
 /*----------------------------------------------------------------------------
 | Software half-precision operations.
-- 
2.15.1
