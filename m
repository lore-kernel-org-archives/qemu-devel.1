Received: from eggs.gnu.org ([2001:4830:134:3::10]:47531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBfB-000522-55
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf6-00057j-18
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:21 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:34685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBf5-00057N-PA
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:15 -0500
Received: by mail-pl0-x242.google.com with SMTP id q17so7156453pll.1
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:12:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:36 -0800
Message-Id: <20180204041136.17525-25-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 24/24] fpu: Implement round_to_int with
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

Add float16 support.  Remove float64_trunc_to_int as unused
rather than recreating it within the new framework.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |   2 +-
 fpu/floatxx.inc.c       |  75 ++++++++++++
 fpu/softfloat.c         | 311 ------------------------------------------------
 3 files changed, 76 insertions(+), 312 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3a2d148651..95e96f8557 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -246,6 +246,7 @@ float64 float16_to_float64(float16 a, bool ieee, float_status *status);
 | Software half-precision operations.
 *----------------------------------------------------------------------------*/
 
+float16 float16_round_to_int(float16, float_status *status);
 float16 float16_add(float16, float16, float_status *status);
 float16 float16_sub(float16, float16, float_status *status);
 float16 float16_mul(float16, float16, float_status *status);
@@ -463,7 +464,6 @@ float128 float64_to_float128(float64, float_status *status);
 | Software IEC/IEEE double-precision operations.
 *----------------------------------------------------------------------------*/
 float64 float64_round_to_int(float64, float_status *status);
-float64 float64_trunc_to_int(float64, float_status *status);
 float64 float64_add(float64, float64, float_status *status);
 float64 float64_sub(float64, float64, float_status *status);
 float64 float64_mul(float64, float64, float_status *status);
diff --git a/fpu/floatxx.inc.c b/fpu/floatxx.inc.c
index a4b305e1ff..a90ae95f2d 100644
--- a/fpu/floatxx.inc.c
+++ b/fpu/floatxx.inc.c
@@ -34,6 +34,8 @@
     _FP_FRAC_SNANP(fs, X)
 #define FP_ADD_INTERNAL(fs, wc, R, A, B, OP) \
     _FP_ADD_INTERNAL(fs, wc, R, A, B, '-')
+#define FP_ROUND(wc, X) \
+    _FP_ROUND(wc, X)
 
 static FLOATXX addsub_internal(FLOATXX a, FLOATXX b, float_status *status,
                                bool subtract)
@@ -464,3 +466,76 @@ FLOATXX glue(FLOATXX,_minnummag)(FLOATXX a, FLOATXX b, float_status *status)
     return minmax_internal(a, b, status,
                            MINMAX_MIN | MINMAX_IEEE | MINMAX_MAG);
 }
+
+FLOATXX glue(FLOATXX,_round_to_int)(FLOATXX a, float_status *status)
+{
+    const int fracbits = glue(_FP_FRACBITS_, FS);
+    const int wfracbits = glue(_FP_WFRACBITS_, FS);
+    FP_DECL_EX;
+    glue(FP_DECL_, FS)(A);
+    int rshift, lshift;
+
+    FP_INIT_ROUNDMODE;
+    glue(FP_UNPACK_, FS)(A, a);
+
+    switch (A_c) {
+    case FP_CLS_INF:
+        /* No fractional part, never any exceptions, return unchanged.  */
+        return a;
+
+    case FP_CLS_ZERO:
+    case FP_CLS_NAN:
+        /* No fractional part, but maybe exceptions.  In the cases of
+           denormal-flush-to-zero and SNaN, we will have raised an
+           exception during unpack.  For those, we need to go through
+           repack in order to generate zero or silence the NaN.  */
+        if (!FP_CUR_EXCEPTIONS) {
+            return a;
+        }
+        break;
+
+    case FP_CLS_NORMAL:
+        /* Position the 2**0 bit at _FP_WORKBIT,
+           where _FP_ROUND expects to work.  */
+        rshift = fracbits - 1 - A_e;
+        if (rshift <= 0) {
+            /* Already integral, never any exceptions, return unchanged.  */
+            return a;
+        }
+        if (rshift < wfracbits) {
+            glue(_FP_FRAC_SRS_, WC)(A, rshift, wfracbits);
+        } else {
+            glue(_FP_FRAC_SET_, WC)(A, glue(_FP_MINFRAC_, WC));
+        }
+        FP_ROUND(WC, A);
+
+        /* Drop the rounding bits.  Normally this is done via right-shift
+           during the re-packing stage, but we need to put the rest of the
+           fraction back into place.  */
+        glue(_FP_FRAC_LOW_, WC)(A) &= ~(_FP_WORK_LSB - 1);
+
+        /* Notice rounding to zero.  */
+        if (glue(_FP_FRAC_ZEROP_, WC)(A)) {
+            A_c = FP_CLS_ZERO;
+            break;
+        }
+
+        /* Renormalize the fraction.  This takes care of both overflow
+           and fixing up the fraction after the rshift.  */
+        glue(_FP_FRAC_CLZ_, WC)(lshift, A);
+        lshift -= glue(_FP_WFRACXBITS_, FS);
+        assert(lshift >= 0);
+        glue(_FP_FRAC_SLL_, WC)(A, lshift);
+
+        A_e += rshift - lshift;
+        break;
+
+    default:
+        _FP_UNREACHABLE;
+    }
+
+    glue(FP_PACK_, FS)(a, A);
+    FP_HANDLE_EXCEPTIONS;
+
+    return a;
+}
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 47b9dd9bd3..3d5201b268 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1310,87 +1310,6 @@ floatx80 float32_to_floatx80(float32 a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Rounds the single-precision floating-point value `a' to an integer, and
-| returns the result as a single-precision floating-point value.  The
-| operation is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float32_round_to_int(float32 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    uint32_t lastBitMask, roundBitsMask;
-    uint32_t z;
-    a = float32_squash_input_denormal(a, status);
-
-    aExp = extractFloat32Exp( a );
-    if ( 0x96 <= aExp ) {
-        if ( ( aExp == 0xFF ) && extractFloat32Frac( a ) ) {
-            return propagateFloat32NaN(a, a, status);
-        }
-        return a;
-    }
-    if ( aExp <= 0x7E ) {
-        if ( (uint32_t) ( float32_val(a)<<1 ) == 0 ) return a;
-        status->float_exception_flags |= float_flag_inexact;
-        aSign = extractFloat32Sign( a );
-        switch (status->float_rounding_mode) {
-         case float_round_nearest_even:
-            if ( ( aExp == 0x7E ) && extractFloat32Frac( a ) ) {
-                return packFloat32( aSign, 0x7F, 0 );
-            }
-            break;
-        case float_round_ties_away:
-            if (aExp == 0x7E) {
-                return packFloat32(aSign, 0x7F, 0);
-            }
-            break;
-         case float_round_down:
-            return make_float32(aSign ? 0xBF800000 : 0);
-         case float_round_up:
-            return make_float32(aSign ? 0x80000000 : 0x3F800000);
-        }
-        return packFloat32( aSign, 0, 0 );
-    }
-    lastBitMask = 1;
-    lastBitMask <<= 0x96 - aExp;
-    roundBitsMask = lastBitMask - 1;
-    z = float32_val(a);
-    switch (status->float_rounding_mode) {
-    case float_round_nearest_even:
-        z += lastBitMask>>1;
-        if ((z & roundBitsMask) == 0) {
-            z &= ~lastBitMask;
-        }
-        break;
-    case float_round_ties_away:
-        z += lastBitMask >> 1;
-        break;
-    case float_round_to_zero:
-        break;
-    case float_round_up:
-        if (!extractFloat32Sign(make_float32(z))) {
-            z += roundBitsMask;
-        }
-        break;
-    case float_round_down:
-        if (extractFloat32Sign(make_float32(z))) {
-            z += roundBitsMask;
-        }
-        break;
-    default:
-        abort();
-    }
-    z &= ~ roundBitsMask;
-    if (z != float32_val(a)) {
-        status->float_exception_flags |= float_flag_inexact;
-    }
-    return make_float32(z);
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the remainder of the single-precision floating-point value `a'
 | with respect to the corresponding value `b'.  The operation is performed
@@ -1672,98 +1591,6 @@ floatx80 float64_to_floatx80(float64 a, float_status *status)
             aSign, aExp + 0x3C00, ( aSig | LIT64( 0x0010000000000000 ) )<<11 );
 
 }
-/*----------------------------------------------------------------------------
-| Rounds the double-precision floating-point value `a' to an integer, and
-| returns the result as a double-precision floating-point value.  The
-| operation is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float64_round_to_int(float64 a, float_status *status)
-{
-    flag aSign;
-    int aExp;
-    uint64_t lastBitMask, roundBitsMask;
-    uint64_t z;
-    a = float64_squash_input_denormal(a, status);
-
-    aExp = extractFloat64Exp( a );
-    if ( 0x433 <= aExp ) {
-        if ( ( aExp == 0x7FF ) && extractFloat64Frac( a ) ) {
-            return propagateFloat64NaN(a, a, status);
-        }
-        return a;
-    }
-    if ( aExp < 0x3FF ) {
-        if ( (uint64_t) ( float64_val(a)<<1 ) == 0 ) return a;
-        status->float_exception_flags |= float_flag_inexact;
-        aSign = extractFloat64Sign( a );
-        switch (status->float_rounding_mode) {
-         case float_round_nearest_even:
-            if ( ( aExp == 0x3FE ) && extractFloat64Frac( a ) ) {
-                return packFloat64( aSign, 0x3FF, 0 );
-            }
-            break;
-        case float_round_ties_away:
-            if (aExp == 0x3FE) {
-                return packFloat64(aSign, 0x3ff, 0);
-            }
-            break;
-         case float_round_down:
-            return make_float64(aSign ? LIT64( 0xBFF0000000000000 ) : 0);
-         case float_round_up:
-            return make_float64(
-            aSign ? LIT64( 0x8000000000000000 ) : LIT64( 0x3FF0000000000000 ));
-        }
-        return packFloat64( aSign, 0, 0 );
-    }
-    lastBitMask = 1;
-    lastBitMask <<= 0x433 - aExp;
-    roundBitsMask = lastBitMask - 1;
-    z = float64_val(a);
-    switch (status->float_rounding_mode) {
-    case float_round_nearest_even:
-        z += lastBitMask >> 1;
-        if ((z & roundBitsMask) == 0) {
-            z &= ~lastBitMask;
-        }
-        break;
-    case float_round_ties_away:
-        z += lastBitMask >> 1;
-        break;
-    case float_round_to_zero:
-        break;
-    case float_round_up:
-        if (!extractFloat64Sign(make_float64(z))) {
-            z += roundBitsMask;
-        }
-        break;
-    case float_round_down:
-        if (extractFloat64Sign(make_float64(z))) {
-            z += roundBitsMask;
-        }
-        break;
-    default:
-        abort();
-    }
-    z &= ~ roundBitsMask;
-    if (z != float64_val(a)) {
-        status->float_exception_flags |= float_flag_inexact;
-    }
-    return make_float64(z);
-
-}
-
-float64 float64_trunc_to_int(float64 a, float_status *status)
-{
-    int oldmode;
-    float64 res;
-    oldmode = status->float_rounding_mode;
-    status->float_rounding_mode = float_round_to_zero;
-    res = float64_round_to_int(a, status);
-    status->float_rounding_mode = oldmode;
-    return res;
-}
 
 /*----------------------------------------------------------------------------
 | Returns the remainder of the double-precision floating-point value `a'
@@ -2821,144 +2648,6 @@ floatx80 float128_to_floatx80(float128 a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Rounds the quadruple-precision floating-point value `a' to an integer, and
-| returns the result as a quadruple-precision floating-point value.  The
-| operation is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 float128_round_to_int(float128 a, float_status *status)
-{
-    flag aSign;
-    int32_t aExp;
-    uint64_t lastBitMask, roundBitsMask;
-    float128 z;
-
-    aExp = extractFloat128Exp( a );
-    if ( 0x402F <= aExp ) {
-        if ( 0x406F <= aExp ) {
-            if (    ( aExp == 0x7FFF )
-                 && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) )
-               ) {
-                return propagateFloat128NaN(a, a, status);
-            }
-            return a;
-        }
-        lastBitMask = 1;
-        lastBitMask = ( lastBitMask<<( 0x406E - aExp ) )<<1;
-        roundBitsMask = lastBitMask - 1;
-        z = a;
-        switch (status->float_rounding_mode) {
-        case float_round_nearest_even:
-            if ( lastBitMask ) {
-                add128( z.high, z.low, 0, lastBitMask>>1, &z.high, &z.low );
-                if ( ( z.low & roundBitsMask ) == 0 ) z.low &= ~ lastBitMask;
-            }
-            else {
-                if ( (int64_t) z.low < 0 ) {
-                    ++z.high;
-                    if ( (uint64_t) ( z.low<<1 ) == 0 ) z.high &= ~1;
-                }
-            }
-            break;
-        case float_round_ties_away:
-            if (lastBitMask) {
-                add128(z.high, z.low, 0, lastBitMask >> 1, &z.high, &z.low);
-            } else {
-                if ((int64_t) z.low < 0) {
-                    ++z.high;
-                }
-            }
-            break;
-        case float_round_to_zero:
-            break;
-        case float_round_up:
-            if (!extractFloat128Sign(z)) {
-                add128(z.high, z.low, 0, roundBitsMask, &z.high, &z.low);
-            }
-            break;
-        case float_round_down:
-            if (extractFloat128Sign(z)) {
-                add128(z.high, z.low, 0, roundBitsMask, &z.high, &z.low);
-            }
-            break;
-        default:
-            abort();
-        }
-        z.low &= ~ roundBitsMask;
-    }
-    else {
-        if ( aExp < 0x3FFF ) {
-            if ( ( ( (uint64_t) ( a.high<<1 ) ) | a.low ) == 0 ) return a;
-            status->float_exception_flags |= float_flag_inexact;
-            aSign = extractFloat128Sign( a );
-            switch (status->float_rounding_mode) {
-             case float_round_nearest_even:
-                if (    ( aExp == 0x3FFE )
-                     && (   extractFloat128Frac0( a )
-                          | extractFloat128Frac1( a ) )
-                   ) {
-                    return packFloat128( aSign, 0x3FFF, 0, 0 );
-                }
-                break;
-            case float_round_ties_away:
-                if (aExp == 0x3FFE) {
-                    return packFloat128(aSign, 0x3FFF, 0, 0);
-                }
-                break;
-             case float_round_down:
-                return
-                      aSign ? packFloat128( 1, 0x3FFF, 0, 0 )
-                    : packFloat128( 0, 0, 0, 0 );
-             case float_round_up:
-                return
-                      aSign ? packFloat128( 1, 0, 0, 0 )
-                    : packFloat128( 0, 0x3FFF, 0, 0 );
-            }
-            return packFloat128( aSign, 0, 0, 0 );
-        }
-        lastBitMask = 1;
-        lastBitMask <<= 0x402F - aExp;
-        roundBitsMask = lastBitMask - 1;
-        z.low = 0;
-        z.high = a.high;
-        switch (status->float_rounding_mode) {
-        case float_round_nearest_even:
-            z.high += lastBitMask>>1;
-            if ( ( ( z.high & roundBitsMask ) | a.low ) == 0 ) {
-                z.high &= ~ lastBitMask;
-            }
-            break;
-        case float_round_ties_away:
-            z.high += lastBitMask>>1;
-            break;
-        case float_round_to_zero:
-            break;
-        case float_round_up:
-            if (!extractFloat128Sign(z)) {
-                z.high |= ( a.low != 0 );
-                z.high += roundBitsMask;
-            }
-            break;
-        case float_round_down:
-            if (extractFloat128Sign(z)) {
-                z.high |= (a.low != 0);
-                z.high += roundBitsMask;
-            }
-            break;
-        default:
-            abort();
-        }
-        z.high &= ~ roundBitsMask;
-    }
-    if ( ( z.low != a.low ) || ( z.high != a.high ) ) {
-        status->float_exception_flags |= float_flag_inexact;
-    }
-    return z;
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the remainder of the quadruple-precision floating-point value `a'
 | with respect to the corresponding value `b'.  The operation is performed
-- 
2.14.3
