Received: from eggs.gnu.org ([2001:4830:134:3::10]:47456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf3-0004u9-3N
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBey-00052x-Hz
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:13 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:46161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBey-000526-6p
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:08 -0500
Received: by mail-pg0-x242.google.com with SMTP id s9so15973629pgq.13
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:12:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:30 -0800
Message-Id: <20180204041136.17525-19-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 18/24] fpu: Implement compares with soft-fp.h
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

Add float16 comparisons.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |   10 +
 fpu/floatxx.inc.c       |   67 +++
 fpu/softfloat.c         | 1051 ++---------------------------------------------
 3 files changed, 109 insertions(+), 1019 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 311c4aba1e..80df716a55 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -250,6 +250,16 @@ float16 float16_add(float16, float16, float_status *status);
 float16 float16_sub(float16, float16, float_status *status);
 float16 float16_mul(float16, float16, float_status *status);
 float16 float16_div(float16, float16, float_status *status);
+int float16_eq(float16, float16, float_status *status);
+int float16_le(float16, float16, float_status *status);
+int float16_lt(float16, float16, float_status *status);
+int float16_unordered(float16, float16, float_status *status);
+int float16_eq_quiet(float16, float16, float_status *status);
+int float16_le_quiet(float16, float16, float_status *status);
+int float16_lt_quiet(float16, float16, float_status *status);
+int float16_unordered_quiet(float16, float16, float_status *status);
+int float16_compare(float16, float16, float_status *status);
+int float16_compare_quiet(float16, float16, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
diff --git a/fpu/floatxx.inc.c b/fpu/floatxx.inc.c
index 5ca6c924ab..db49423723 100644
--- a/fpu/floatxx.inc.c
+++ b/fpu/floatxx.inc.c
@@ -196,3 +196,70 @@ FLOATXX glue(uint32_to_,FLOATXX)(uint32_t a, float_status *status)
 {
     return glue(uint64_to_,FLOATXX)(a, status);
 }
+
+static int compare_internal(FLOATXX a, FLOATXX b,
+                            float_status *status, bool quiet)
+{
+    FP_DECL_EX;
+    glue(FP_DECL_, FS)(A);
+    glue(FP_DECL_, FS)(B);
+    int r;
+
+    FP_INIT_EXCEPTIONS;
+    glue(FP_UNPACK_RAW_, FS)(A, a);
+    glue(FP_UNPACK_RAW_, FS)(B, b);
+    glue(FP_CMP_, FS)(r, A, B, float_relation_unordered, (quiet ? 1 : 2));
+    FP_HANDLE_EXCEPTIONS;
+
+    return r;
+}
+
+int glue(FLOATXX,_compare)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return compare_internal(a, b, status, false);
+}
+
+int glue(FLOATXX,_compare_quiet)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return compare_internal(a, b, status, true);
+}
+
+int glue(FLOATXX,_eq)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return compare_internal(a, b, status, false) == 0;
+}
+
+int glue(FLOATXX,_le)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return compare_internal(a, b, status, false) <= 0;
+}
+
+int glue(FLOATXX,_lt)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return compare_internal(a, b, status, false) < 0;
+}
+
+int glue(FLOATXX,_unordered)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return compare_internal(a, b, status, false) == float_relation_unordered;
+}
+
+int glue(FLOATXX,_eq_quiet)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return compare_internal(a, b, status, true) == 0;
+}
+
+int glue(FLOATXX,_le_quiet)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return compare_internal(a, b, status, true) <= 0;
+}
+
+int glue(FLOATXX,_lt_quiet)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return compare_internal(a, b, status, true) < 0;
+}
+
+int glue(FLOATXX,_unordered_quiet)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return compare_internal(a, b, status, true) == float_relation_unordered;
+}
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 47b8c4815b..f75cd0bac4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1972,222 +1972,6 @@ float32 float32_log2(float32 a, float_status *status)
     return normalizeRoundAndPackFloat32(zSign, 0x85, zSig, status);
 }
 
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point value `a' is equal to
-| the corresponding value `b', and 0 otherwise.  The invalid exception is
-| raised if either operand is a NaN.  Otherwise, the comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_eq(float32 a, float32 b, float_status *status)
-{
-    uint32_t av, bv;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    av = float32_val(a);
-    bv = float32_val(b);
-    return ( av == bv ) || ( (uint32_t) ( ( av | bv )<<1 ) == 0 );
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point value `a' is less than
-| or equal to the corresponding value `b', and 0 otherwise.  The invalid
-| exception is raised if either operand is a NaN.  The comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_le(float32 a, float32 b, float_status *status)
-{
-    flag aSign, bSign;
-    uint32_t av, bv;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloat32Sign( a );
-    bSign = extractFloat32Sign( b );
-    av = float32_val(a);
-    bv = float32_val(b);
-    if ( aSign != bSign ) return aSign || ( (uint32_t) ( ( av | bv )<<1 ) == 0 );
-    return ( av == bv ) || ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point value `a' is less than
-| the corresponding value `b', and 0 otherwise.  The invalid exception is
-| raised if either operand is a NaN.  The comparison is performed according
-| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_lt(float32 a, float32 b, float_status *status)
-{
-    flag aSign, bSign;
-    uint32_t av, bv;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
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
-| be compared, and 0 otherwise.  The invalid exception is raised if either
-| operand is a NaN.  The comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_unordered(float32 a, float32 b, float_status *status)
-{
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 1;
-    }
-    return 0;
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point value `a' is equal to
-| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
-| exception.  The comparison is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_eq_quiet(float32 a, float32 b, float_status *status)
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
-        return 0;
-    }
-    return ( float32_val(a) == float32_val(b) ) ||
-            ( (uint32_t) ( ( float32_val(a) | float32_val(b) )<<1 ) == 0 );
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point value `a' is less than or
-| equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs do not
-| cause an exception.  Otherwise, the comparison is performed according to the
-| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_le_quiet(float32 a, float32 b, float_status *status)
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
-    if ( aSign != bSign ) return aSign || ( (uint32_t) ( ( av | bv )<<1 ) == 0 );
-    return ( av == bv ) || ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point value `a' is less than
-| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
-| exception.  Otherwise, the comparison is performed according to the IEC/IEEE
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
 /*----------------------------------------------------------------------------
 | Returns the result of converting the double-precision floating-point value
 | `a' to the single-precision floating-point format.  The conversion is
@@ -3123,226 +2907,6 @@ float64 float64_log2(float64 a, float_status *status)
     return normalizeRoundAndPackFloat64(zSign, 0x408, zSig, status);
 }
 
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point value `a' is equal to the
-| corresponding value `b', and 0 otherwise.  The invalid exception is raised
-| if either operand is a NaN.  Otherwise, the comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_eq(float64 a, float64 b, float_status *status)
-{
-    uint64_t av, bv;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    av = float64_val(a);
-    bv = float64_val(b);
-    return ( av == bv ) || ( (uint64_t) ( ( av | bv )<<1 ) == 0 );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point value `a' is less than or
-| equal to the corresponding value `b', and 0 otherwise.  The invalid
-| exception is raised if either operand is a NaN.  The comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_le(float64 a, float64 b, float_status *status)
-{
-    flag aSign, bSign;
-    uint64_t av, bv;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloat64Sign( a );
-    bSign = extractFloat64Sign( b );
-    av = float64_val(a);
-    bv = float64_val(b);
-    if ( aSign != bSign ) return aSign || ( (uint64_t) ( ( av | bv )<<1 ) == 0 );
-    return ( av == bv ) || ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point value `a' is less than
-| the corresponding value `b', and 0 otherwise.  The invalid exception is
-| raised if either operand is a NaN.  The comparison is performed according
-| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_lt(float64 a, float64 b, float_status *status)
-{
-    flag aSign, bSign;
-    uint64_t av, bv;
-
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloat64Sign( a );
-    bSign = extractFloat64Sign( b );
-    av = float64_val(a);
-    bv = float64_val(b);
-    if ( aSign != bSign ) return aSign && ( (uint64_t) ( ( av | bv )<<1 ) != 0 );
-    return ( av != bv ) && ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point values `a' and `b' cannot
-| be compared, and 0 otherwise.  The invalid exception is raised if either
-| operand is a NaN.  The comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_unordered(float64 a, float64 b, float_status *status)
-{
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 1;
-    }
-    return 0;
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point value `a' is equal to the
-| corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
-| exception.The comparison is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_eq_quiet(float64 a, float64 b, float_status *status)
-{
-    uint64_t av, bv;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        if (float64_is_signaling_nan(a, status)
-         || float64_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    av = float64_val(a);
-    bv = float64_val(b);
-    return ( av == bv ) || ( (uint64_t) ( ( av | bv )<<1 ) == 0 );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point value `a' is less than or
-| equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs do not
-| cause an exception.  Otherwise, the comparison is performed according to the
-| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_le_quiet(float64 a, float64 b, float_status *status)
-{
-    flag aSign, bSign;
-    uint64_t av, bv;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        if (float64_is_signaling_nan(a, status)
-         || float64_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloat64Sign( a );
-    bSign = extractFloat64Sign( b );
-    av = float64_val(a);
-    bv = float64_val(b);
-    if ( aSign != bSign ) return aSign || ( (uint64_t) ( ( av | bv )<<1 ) == 0 );
-    return ( av == bv ) || ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point value `a' is less than
-| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
-| exception.  Otherwise, the comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_lt_quiet(float64 a, float64 b, float_status *status)
-{
-    flag aSign, bSign;
-    uint64_t av, bv;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        if (float64_is_signaling_nan(a, status)
-         || float64_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloat64Sign( a );
-    bSign = extractFloat64Sign( b );
-    av = float64_val(a);
-    bv = float64_val(b);
-    if ( aSign != bSign ) return aSign && ( (uint64_t) ( ( av | bv )<<1 ) != 0 );
-    return ( av != bv ) && ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point values `a' and `b' cannot
-| be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.  The
-| comparison is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_unordered_quiet(float64 a, float64 b, float_status *status)
-{
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        if (float64_is_signaling_nan(a, status)
-         || float64_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 1;
-    }
-    return 0;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the extended double-precision floating-
 | point value `a' to the 32-bit two's complement integer format.  The
@@ -4227,263 +3791,6 @@ floatx80 floatx80_sqrt(floatx80 a, float_status *status)
                                 0, zExp, zSig0, zSig1, status);
 }
 
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is equal
-| to the corresponding value `b', and 0 otherwise.  The invalid exception is
-| raised if either operand is a NaN.  Otherwise, the comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int floatx80_eq(floatx80 a, floatx80 b, float_status *status)
-{
-
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
-        || (extractFloatx80Exp(a) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(a) << 1))
-        || (extractFloatx80Exp(b) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(b) << 1))
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    return
-           ( a.low == b.low )
-        && (    ( a.high == b.high )
-             || (    ( a.low == 0 )
-                  && ( (uint16_t) ( ( a.high | b.high )<<1 ) == 0 ) )
-           );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is
-| less than or equal to the corresponding value `b', and 0 otherwise.  The
-| invalid exception is raised if either operand is a NaN.  The comparison is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int floatx80_le(floatx80 a, floatx80 b, float_status *status)
-{
-    flag aSign, bSign;
-
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
-        || (extractFloatx80Exp(a) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(a) << 1))
-        || (extractFloatx80Exp(b) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(b) << 1))
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloatx80Sign( a );
-    bSign = extractFloatx80Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            || (    ( ( (uint16_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 == 0 );
-    }
-    return
-          aSign ? le128( b.high, b.low, a.high, a.low )
-        : le128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is
-| less than the corresponding value `b', and 0 otherwise.  The invalid
-| exception is raised if either operand is a NaN.  The comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int floatx80_lt(floatx80 a, floatx80 b, float_status *status)
-{
-    flag aSign, bSign;
-
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
-        || (extractFloatx80Exp(a) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(a) << 1))
-        || (extractFloatx80Exp(b) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(b) << 1))
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloatx80Sign( a );
-    bSign = extractFloatx80Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            && (    ( ( (uint16_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 != 0 );
-    }
-    return
-          aSign ? lt128( b.high, b.low, a.high, a.low )
-        : lt128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point values `a' and `b'
-| cannot be compared, and 0 otherwise.  The invalid exception is raised if
-| either operand is a NaN.   The comparison is performed according to the
-| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-int floatx80_unordered(floatx80 a, floatx80 b, float_status *status)
-{
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
-        || (extractFloatx80Exp(a) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(a) << 1))
-        || (extractFloatx80Exp(b) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(b) << 1))
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 1;
-    }
-    return 0;
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is
-| equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs do not
-| cause an exception.  The comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int floatx80_eq_quiet(floatx80 a, floatx80 b, float_status *status)
-{
-
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    if (    (    ( extractFloatx80Exp( a ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( a )<<1 ) )
-         || (    ( extractFloatx80Exp( b ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( b )<<1 ) )
-       ) {
-        if (floatx80_is_signaling_nan(a, status)
-         || floatx80_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    return
-           ( a.low == b.low )
-        && (    ( a.high == b.high )
-             || (    ( a.low == 0 )
-                  && ( (uint16_t) ( ( a.high | b.high )<<1 ) == 0 ) )
-           );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is less
-| than or equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs
-| do not cause an exception.  Otherwise, the comparison is performed according
-| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int floatx80_le_quiet(floatx80 a, floatx80 b, float_status *status)
-{
-    flag aSign, bSign;
-
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    if (    (    ( extractFloatx80Exp( a ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( a )<<1 ) )
-         || (    ( extractFloatx80Exp( b ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( b )<<1 ) )
-       ) {
-        if (floatx80_is_signaling_nan(a, status)
-         || floatx80_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloatx80Sign( a );
-    bSign = extractFloatx80Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            || (    ( ( (uint16_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 == 0 );
-    }
-    return
-          aSign ? le128( b.high, b.low, a.high, a.low )
-        : le128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is less
-| than the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause
-| an exception.  Otherwise, the comparison is performed according to the
-| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int floatx80_lt_quiet(floatx80 a, floatx80 b, float_status *status)
-{
-    flag aSign, bSign;
-
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    if (    (    ( extractFloatx80Exp( a ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( a )<<1 ) )
-         || (    ( extractFloatx80Exp( b ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( b )<<1 ) )
-       ) {
-        if (floatx80_is_signaling_nan(a, status)
-         || floatx80_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloatx80Sign( a );
-    bSign = extractFloatx80Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            && (    ( ( (uint16_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 != 0 );
-    }
-    return
-          aSign ? lt128( b.high, b.low, a.high, a.low )
-        : lt128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point values `a' and `b'
-| cannot be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.
-| The comparison is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-int floatx80_unordered_quiet(floatx80 a, floatx80 b, float_status *status)
-{
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
-        float_raise(float_flag_invalid, status);
-        return 1;
-    }
-    if (    (    ( extractFloatx80Exp( a ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( a )<<1 ) )
-         || (    ( extractFloatx80Exp( b ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( b )<<1 ) )
-       ) {
-        if (floatx80_is_signaling_nan(a, status)
-         || floatx80_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 1;
-    }
-    return 0;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the quadruple-precision floating-point
 | value `a' to the single-precision floating-point format.  The conversion
@@ -4900,298 +4207,6 @@ float128 float128_sqrt(float128 a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point value `a' is equal to
-| the corresponding value `b', and 0 otherwise.  The invalid exception is
-| raised if either operand is a NaN.  Otherwise, the comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_eq(float128 a, float128 b, float_status *status)
-{
-
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    return
-           ( a.low == b.low )
-        && (    ( a.high == b.high )
-             || (    ( a.low == 0 )
-                  && ( (uint64_t) ( ( a.high | b.high )<<1 ) == 0 ) )
-           );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point value `a' is less than
-| or equal to the corresponding value `b', and 0 otherwise.  The invalid
-| exception is raised if either operand is a NaN.  The comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_le(float128 a, float128 b, float_status *status)
-{
-    flag aSign, bSign;
-
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            || (    ( ( (uint64_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 == 0 );
-    }
-    return
-          aSign ? le128( b.high, b.low, a.high, a.low )
-        : le128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point value `a' is less than
-| the corresponding value `b', and 0 otherwise.  The invalid exception is
-| raised if either operand is a NaN.  The comparison is performed according
-| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_lt(float128 a, float128 b, float_status *status)
-{
-    flag aSign, bSign;
-
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            && (    ( ( (uint64_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 != 0 );
-    }
-    return
-          aSign ? lt128( b.high, b.low, a.high, a.low )
-        : lt128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point values `a' and `b' cannot
-| be compared, and 0 otherwise.  The invalid exception is raised if either
-| operand is a NaN. The comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_unordered(float128 a, float128 b, float_status *status)
-{
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 1;
-    }
-    return 0;
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point value `a' is equal to
-| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
-| exception.  The comparison is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_eq_quiet(float128 a, float128 b, float_status *status)
-{
-
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        if (float128_is_signaling_nan(a, status)
-         || float128_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    return
-           ( a.low == b.low )
-        && (    ( a.high == b.high )
-             || (    ( a.low == 0 )
-                  && ( (uint64_t) ( ( a.high | b.high )<<1 ) == 0 ) )
-           );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point value `a' is less than
-| or equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs do not
-| cause an exception.  Otherwise, the comparison is performed according to the
-| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_le_quiet(float128 a, float128 b, float_status *status)
-{
-    flag aSign, bSign;
-
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        if (float128_is_signaling_nan(a, status)
-         || float128_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            || (    ( ( (uint64_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 == 0 );
-    }
-    return
-          aSign ? le128( b.high, b.low, a.high, a.low )
-        : le128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point value `a' is less than
-| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
-| exception.  Otherwise, the comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_lt_quiet(float128 a, float128 b, float_status *status)
-{
-    flag aSign, bSign;
-
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        if (float128_is_signaling_nan(a, status)
-         || float128_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            && (    ( ( (uint64_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 != 0 );
-    }
-    return
-          aSign ? lt128( b.high, b.low, a.high, a.low )
-        : lt128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point values `a' and `b' cannot
-| be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.  The
-| comparison is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_unordered_quiet(float128 a, float128 b, float_status *status)
-{
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        if (float128_is_signaling_nan(a, status)
-         || float128_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 1;
-    }
-    return 0;
-}
-
-#define COMPARE(s, nan_exp)                                                  \
-static inline int float ## s ## _compare_internal(float ## s a, float ## s b,\
-                                      int is_quiet, float_status *status)    \
-{                                                                            \
-    flag aSign, bSign;                                                       \
-    uint ## s ## _t av, bv;                                                  \
-    a = float ## s ## _squash_input_denormal(a, status);                     \
-    b = float ## s ## _squash_input_denormal(b, status);                     \
-                                                                             \
-    if (( ( extractFloat ## s ## Exp( a ) == nan_exp ) &&                    \
-         extractFloat ## s ## Frac( a ) ) ||                                 \
-        ( ( extractFloat ## s ## Exp( b ) == nan_exp ) &&                    \
-          extractFloat ## s ## Frac( b ) )) {                                \
-        if (!is_quiet ||                                                     \
-            float ## s ## _is_signaling_nan(a, status) ||                  \
-            float ## s ## _is_signaling_nan(b, status)) {                 \
-            float_raise(float_flag_invalid, status);                         \
-        }                                                                    \
-        return float_relation_unordered;                                     \
-    }                                                                        \
-    aSign = extractFloat ## s ## Sign( a );                                  \
-    bSign = extractFloat ## s ## Sign( b );                                  \
-    av = float ## s ## _val(a);                                              \
-    bv = float ## s ## _val(b);                                              \
-    if ( aSign != bSign ) {                                                  \
-        if ( (uint ## s ## _t) ( ( av | bv )<<1 ) == 0 ) {                   \
-            /* zero case */                                                  \
-            return float_relation_equal;                                     \
-        } else {                                                             \
-            return 1 - (2 * aSign);                                          \
-        }                                                                    \
-    } else {                                                                 \
-        if (av == bv) {                                                      \
-            return float_relation_equal;                                     \
-        } else {                                                             \
-            return 1 - 2 * (aSign ^ ( av < bv ));                            \
-        }                                                                    \
-    }                                                                        \
-}                                                                            \
-                                                                             \
-int float ## s ## _compare(float ## s a, float ## s b, float_status *status) \
-{                                                                            \
-    return float ## s ## _compare_internal(a, b, 0, status);                 \
-}                                                                            \
-                                                                             \
-int float ## s ## _compare_quiet(float ## s a, float ## s b,                 \
-                                 float_status *status)                       \
-{                                                                            \
-    return float ## s ## _compare_internal(a, b, 1, status);                 \
-}
-
-COMPARE(32, 0xff)
-COMPARE(64, 0x7ff)
-
 static inline int floatx80_compare_internal(floatx80 a, floatx80 b,
                                             int is_quiet, float_status *status)
 {
@@ -5242,48 +4257,46 @@ int floatx80_compare_quiet(floatx80 a, floatx80 b, float_status *status)
     return floatx80_compare_internal(a, b, 1, status);
 }
 
-static inline int float128_compare_internal(float128 a, float128 b,
-                                            int is_quiet, float_status *status)
+int floatx80_eq(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aSign, bSign;
+    return floatx80_compare_internal(a, b, 0, status) == 0;
+}
 
-    if (( ( extractFloat128Exp( a ) == 0x7fff ) &&
-          ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) ) ||
-        ( ( extractFloat128Exp( b ) == 0x7fff ) &&
-          ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )) {
-        if (!is_quiet ||
-            float128_is_signaling_nan(a, status) ||
-            float128_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return float_relation_unordered;
-    }
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign != bSign ) {
-        if ( ( ( ( a.high | b.high )<<1 ) | a.low | b.low ) == 0 ) {
-            /* zero case */
-            return float_relation_equal;
-        } else {
-            return 1 - (2 * aSign);
-        }
-    } else {
-        if (a.low == b.low && a.high == b.high) {
-            return float_relation_equal;
-        } else {
-            return 1 - 2 * (aSign ^ ( lt128( a.high, a.low, b.high, b.low ) ));
-        }
-    }
+int floatx80_le(floatx80 a, floatx80 b, float_status *status)
+{
+    return floatx80_compare_internal(a, b, 0, status) <= 0;
 }
 
-int float128_compare(float128 a, float128 b, float_status *status)
+int floatx80_lt(floatx80 a, floatx80 b, float_status *status)
+{
+    return floatx80_compare_internal(a, b, 0, status) < 0;
+}
+
+int floatx80_unordered(floatx80 a, floatx80 b, float_status *status)
+{
+    return floatx80_compare_internal(a, b, 0, status)
+           == float_relation_unordered;
+}
+
+int floatx80_eq_quiet(floatx80 a, floatx80 b, float_status *status)
 {
-    return float128_compare_internal(a, b, 0, status);
+    return floatx80_compare_internal(a, b, 1, status) == 0;
 }
 
-int float128_compare_quiet(float128 a, float128 b, float_status *status)
+int floatx80_le_quiet(floatx80 a, floatx80 b, float_status *status)
+{
+    return floatx80_compare_internal(a, b, 1, status) <= 0;
+}
+
+int floatx80_lt_quiet(floatx80 a, floatx80 b, float_status *status)
+{
+    return floatx80_compare_internal(a, b, 1, status) < 0;
+}
+
+int floatx80_unordered_quiet(floatx80 a, floatx80 b, float_status *status)
 {
-    return float128_compare_internal(a, b, 1, status);
+    return floatx80_compare_internal(a, b, 1, status)
+           == float_relation_unordered;
 }
 
 /* min() and max() functions. These can't be implemented as
-- 
2.14.3
