Received: from eggs.gnu.org ([2001:4830:134:3::10]:44108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32se-0000eG-6L
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sZ-0002Ii-Rl
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:12 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:45961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32sZ-0002Hn-IV
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:07 -0400
Received: by mail-wr0-x236.google.com with SMTP id k7so1431247wre.2
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:32:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:28 +0100
Message-Id: <20171013162438.32458-21-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 20/30] softfloat: half-precision compare
 functions
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

This is mostly a mechanical conversion of the float32 variants of the
same name with some judicious search/replace and some constants
changed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c         | 216 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h |   8 ++
 2 files changed, 224 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index ff967f5525..fdb2999c41 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3884,6 +3884,222 @@ float16 float16_div(float16 a, float16 b, float_status *status)
 
 }
 
+/*----------------------------------------------------------------------------
+| Returns 1 if the half-precision floating-point value `a' is equal to
+| the corresponding value `b', and 0 otherwise.  The invalid exception is
+| raised if either operand is a NaN.  Otherwise, the comparison is performed
+| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+int float16_eq(float16 a, float16 b, float_status *status)
+{
+    uint32_t av, bv;
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    if (    ( ( extractFloat16Exp( a ) == 0x1F ) && extractFloat16Frac( a ) )
+         || ( ( extractFloat16Exp( b ) == 0x1F ) && extractFloat16Frac( b ) )
+       ) {
+        float_raise(float_flag_invalid, status);
+        return 0;
+    }
+    av = float16_val(a);
+    bv = float16_val(b);
+    return ( av == bv ) || ( (uint32_t) ( ( av | bv )<<1 ) == 0 );
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the half-precision floating-point value `a' is less than
+| or equal to the corresponding value `b', and 0 otherwise.  The invalid
+| exception is raised if either operand is a NaN.  The comparison is performed
+| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+int float16_le(float16 a, float16 b, float_status *status)
+{
+    flag aSign, bSign;
+    uint32_t av, bv;
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    if (    ( ( extractFloat16Exp( a ) == 0x1F ) && extractFloat16Frac( a ) )
+         || ( ( extractFloat16Exp( b ) == 0x1F ) && extractFloat16Frac( b ) )
+       ) {
+        float_raise(float_flag_invalid, status);
+        return 0;
+    }
+    aSign = extractFloat16Sign( a );
+    bSign = extractFloat16Sign( b );
+    av = float16_val(a);
+    bv = float16_val(b);
+    if ( aSign != bSign ) return aSign || ( (uint32_t) ( ( av | bv )<<1 ) == 0 );
+    return ( av == bv ) || ( aSign ^ ( av < bv ) );
+
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the half-precision floating-point value `a' is less than
+| the corresponding value `b', and 0 otherwise.  The invalid exception is
+| raised if either operand is a NaN.  The comparison is performed according
+| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+int float16_lt(float16 a, float16 b, float_status *status)
+{
+    flag aSign, bSign;
+    uint32_t av, bv;
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    if (    ( ( extractFloat16Exp( a ) == 0x1F ) && extractFloat16Frac( a ) )
+         || ( ( extractFloat16Exp( b ) == 0x1F ) && extractFloat16Frac( b ) )
+       ) {
+        float_raise(float_flag_invalid, status);
+        return 0;
+    }
+    aSign = extractFloat16Sign( a );
+    bSign = extractFloat16Sign( b );
+    av = float16_val(a);
+    bv = float16_val(b);
+    if ( aSign != bSign ) return aSign && ( (uint32_t) ( ( av | bv )<<1 ) != 0 );
+    return ( av != bv ) && ( aSign ^ ( av < bv ) );
+
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the half-precision floating-point values `a' and `b' cannot
+| be compared, and 0 otherwise.  The invalid exception is raised if either
+| operand is a NaN.  The comparison is performed according to the IEC/IEEE
+| Standard for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+int float16_unordered(float16 a, float16 b, float_status *status)
+{
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    if (    ( ( extractFloat16Exp( a ) == 0x1F ) && extractFloat16Frac( a ) )
+         || ( ( extractFloat16Exp( b ) == 0x1F ) && extractFloat16Frac( b ) )
+       ) {
+        float_raise(float_flag_invalid, status);
+        return 1;
+    }
+    return 0;
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the half-precision floating-point value `a' is equal to
+| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
+| exception.  The comparison is performed according to the IEC/IEEE Standard
+| for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+int float16_eq_quiet(float16 a, float16 b, float_status *status)
+{
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    if (    ( ( extractFloat16Exp( a ) == 0x1F ) && extractFloat16Frac( a ) )
+         || ( ( extractFloat16Exp( b ) == 0x1F ) && extractFloat16Frac( b ) )
+       ) {
+        if (float16_is_signaling_nan(a, status)
+         || float16_is_signaling_nan(b, status)) {
+            float_raise(float_flag_invalid, status);
+        }
+        return 0;
+    }
+    return ( float16_val(a) == float16_val(b) ) ||
+            ( (uint32_t) ( ( float16_val(a) | float16_val(b) )<<1 ) == 0 );
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the half-precision floating-point value `a' is less than or
+| equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs do not
+| cause an exception.  Otherwise, the comparison is performed according to the
+| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+int float16_le_quiet(float16 a, float16 b, float_status *status)
+{
+    flag aSign, bSign;
+    uint32_t av, bv;
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    if (    ( ( extractFloat16Exp( a ) == 0x1F ) && extractFloat16Frac( a ) )
+         || ( ( extractFloat16Exp( b ) == 0x1F ) && extractFloat16Frac( b ) )
+       ) {
+        if (float16_is_signaling_nan(a, status)
+         || float16_is_signaling_nan(b, status)) {
+            float_raise(float_flag_invalid, status);
+        }
+        return 0;
+    }
+    aSign = extractFloat16Sign( a );
+    bSign = extractFloat16Sign( b );
+    av = float16_val(a);
+    bv = float16_val(b);
+    if ( aSign != bSign ) return aSign || ( (uint32_t) ( ( av | bv )<<1 ) == 0 );
+    return ( av == bv ) || ( aSign ^ ( av < bv ) );
+
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the half-precision floating-point value `a' is less than
+| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
+| exception.  Otherwise, the comparison is performed according to the IEC/IEEE
+| Standard for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+int float16_lt_quiet(float16 a, float16 b, float_status *status)
+{
+    flag aSign, bSign;
+    uint32_t av, bv;
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    if (    ( ( extractFloat16Exp( a ) == 0x1F ) && extractFloat16Frac( a ) )
+         || ( ( extractFloat16Exp( b ) == 0x1F ) && extractFloat16Frac( b ) )
+       ) {
+        if (float16_is_signaling_nan(a, status)
+         || float16_is_signaling_nan(b, status)) {
+            float_raise(float_flag_invalid, status);
+        }
+        return 0;
+    }
+    aSign = extractFloat16Sign( a );
+    bSign = extractFloat16Sign( b );
+    av = float16_val(a);
+    bv = float16_val(b);
+    if ( aSign != bSign ) return aSign && ( (uint32_t) ( ( av | bv )<<1 ) != 0 );
+    return ( av != bv ) && ( aSign ^ ( av < bv ) );
+
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the half-precision floating-point values `a' and `b' cannot
+| be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.  The
+| comparison is performed according to the IEC/IEEE Standard for Binary
+| Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+int float16_unordered_quiet(float16 a, float16 b, float_status *status)
+{
+    a = float16_squash_input_denormal(a, status);
+    b = float16_squash_input_denormal(b, status);
+
+    if (    ( ( extractFloat16Exp( a ) == 0x1F ) && extractFloat16Frac( a ) )
+         || ( ( extractFloat16Exp( b ) == 0x1F ) && extractFloat16Frac( b ) )
+       ) {
+        if (float16_is_signaling_nan(a, status)
+         || float16_is_signaling_nan(b, status)) {
+            float_raise(float_flag_invalid, status);
+        }
+        return 1;
+    }
+    return 0;
+}
+
 /* Half precision floats come in two formats: standard IEEE and "ARM" format.
    The latter gains extra exponent range by omitting the NaN/Inf encodings.  */
 
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index f1d79b6d03..76a8310780 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -350,6 +350,14 @@ float16 float16_add(float16, float16, float_status *status);
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
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
-- 
2.14.1
