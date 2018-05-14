Received: from eggs.gnu.org ([2001:4830:134:3::10]:52731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILiK-0008OZ-U5
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILiH-0000GH-LU
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:13:04 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:42034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILiH-0000EG-Cy
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:13:01 -0400
Received: by mail-pg0-x243.google.com with SMTP id p9-v6so6060659pgc.9
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:13:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:12:19 -0700
Message-Id: <20180514221219.7091-29-richard.henderson@linaro.org>
In-Reply-To: <20180514221219.7091-1-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 28/28] fpu/softfloat: Define
 floatN_silence_nan in terms of parts_silence_nan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Isolate the target-specific choice to 3 functions instead of 6.

The code in floatx80_default_nan tried to be over-general.  There are
only two targets that support this format: x86 and m68k.  Thus there
is no point in inventing a mechanism for snan_bit_is_one.

Move routines that no longer have ifdefs out of softfloat-specialize.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 81 ++------------------------------------
 fpu/softfloat.c            | 19 +++++++++
 2 files changed, 23 insertions(+), 77 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index ec4fb6ba8b..16c0bcb6fa 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -278,24 +278,6 @@ int float16_is_signaling_nan(float16 a_, float_status *status)
 #endif
 }
 
-/*----------------------------------------------------------------------------
-| Returns a quiet NaN from a signalling NaN for the half-precision
-| floating point value `a'.
-*----------------------------------------------------------------------------*/
-
-float16 float16_silence_nan(float16 a, float_status *status)
-{
-#ifdef NO_SIGNALING_NANS
-    g_assert_not_reached();
-#else
-    if (snan_bit_is_one(status)) {
-        return float16_default_nan(status);
-    } else {
-        return a | (1 << 9);
-    }
-#endif
-}
-
 /*----------------------------------------------------------------------------
 | Returns 1 if the single-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
@@ -334,30 +316,6 @@ int float32_is_signaling_nan(float32 a_, float_status *status)
 #endif
 }
 
-/*----------------------------------------------------------------------------
-| Returns a quiet NaN from a signalling NaN for the single-precision
-| floating point value `a'.
-*----------------------------------------------------------------------------*/
-
-float32 float32_silence_nan(float32 a, float_status *status)
-{
-#ifdef NO_SIGNALING_NANS
-    g_assert_not_reached();
-#else
-    if (snan_bit_is_one(status)) {
-# ifdef TARGET_HPPA
-        a &= ~0x00400000;
-        a |=  0x00200000;
-        return a;
-# else
-        return float32_default_nan(status);
-# endif
-    } else {
-        return a | (1 << 22);
-    }
-#endif
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the single-precision floating-point NaN
 | `a' to the canonical NaN format.  If `a' is a signaling NaN, the invalid
@@ -706,31 +664,6 @@ int float64_is_signaling_nan(float64 a_, float_status *status)
 #endif
 }
 
-/*----------------------------------------------------------------------------
-| Returns a quiet NaN from a signalling NaN for the double-precision
-| floating point value `a'.
-*----------------------------------------------------------------------------*/
-
-float64 float64_silence_nan(float64 a, float_status *status)
-{
-#ifdef NO_SIGNALING_NANS
-    g_assert_not_reached();
-#else
-    if (snan_bit_is_one(status)) {
-# ifdef TARGET_HPPA
-        a &= ~0x0008000000000000ULL;
-        a |=  0x0004000000000000ULL;
-        return a;
-# else
-        return float64_default_nan(status);
-# endif
-    } else {
-        return a | LIT64(0x0008000000000000);
-    }
-#endif
-}
-
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the double-precision floating-point NaN
 | `a' to the canonical NaN format.  If `a' is a signaling NaN, the invalid
@@ -886,16 +819,10 @@ int floatx80_is_signaling_nan(floatx80 a, float_status *status)
 
 floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
 {
-#ifdef NO_SIGNALING_NANS
-    g_assert_not_reached();
-#else
-    if (snan_bit_is_one(status)) {
-        return floatx80_default_nan(status);
-    } else {
-        a.low |= LIT64(0xC000000000000000);
-        return a;
-    }
-#endif
+    /* None of the targets that have snan_bit_is_one use floatx80.  */
+    assert(!snan_bit_is_one(status));
+    a.low |= LIT64(0xC000000000000000);
+    return a;
 }
 
 /*----------------------------------------------------------------------------
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b5842f7b1c..40b039ee5b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2128,6 +2128,25 @@ float128 float128_default_nan(float_status *status)
     return r;
 }
 
+/*----------------------------------------------------------------------------
+| Returns a quiet NaN from a signalling NaN for the floating point value `a'.
+*----------------------------------------------------------------------------*/
+
+float16 float16_silence_nan(float16 a, float_status *status)
+{
+    return float16_pack_raw(parts_silence_nan(float16_unpack_raw(a), status));
+}
+
+float32 float32_silence_nan(float32 a, float_status *status)
+{
+    return float32_pack_raw(parts_silence_nan(float32_unpack_raw(a), status));
+}
+
+float64 float64_silence_nan(float64 a, float_status *status)
+{
+    return float64_pack_raw(parts_silence_nan(float64_unpack_raw(a), status));
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
-- 
2.17.0
