Received: from eggs.gnu.org ([2001:4830:134:3::10]:52021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwAE-0007Cv-GU
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwAB-0004qP-Kn
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:44:02 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:40055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGwAB-0004qD-D1
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:59 -0400
Received: by mail-pl0-x243.google.com with SMTP id t12-v6so2264577plo.7
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 17:43:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 17:43:33 -0700
Message-Id: <20180511004345.26708-8-richard.henderson@linaro.org>
In-Reply-To: <20180511004345.26708-1-richard.henderson@linaro.org>
References: <20180511004345.26708-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/19] fpu/softfloat: Replace float_class_msnan
 with parts_silence_nan
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

With a canonical representation of NaNs, we can silence an SNaN
immediately rather than delay until the final format is known.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 23 +++++++++++++++++
 fpu/softfloat.c            | 51 +++++++++++---------------------------
 2 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 2ad524b11e..53a4f45a8c 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -138,6 +138,29 @@ static FloatParts parts_default_nan(float_status *status)
     };
 }
 
+/*----------------------------------------------------------------------------
+| Returns a quiet NaN from a signalling NaN for the deconstructed
+| floating-point parts.
+*----------------------------------------------------------------------------*/
+
+static FloatParts parts_silence_nan(FloatParts a, float_status *status)
+{
+#ifdef NO_SIGNALING_NANS
+    g_assert_not_reached();
+#elif defined(TARGET_HPPA)
+    a.frac &= ~(1ULL << (DECOMPOSED_BINARY_POINT - 1));
+    a.frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 2);
+#else
+    if (status->snan_bit_is_one) {
+        return parts_default_nan(status);
+    } else {
+        a.frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 1);
+    }
+#endif
+    a.cls = float_class_qnan;
+    return a;
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 01036b158e..cce94136d4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -179,7 +179,6 @@ typedef enum __attribute__ ((__packed__)) {
     float_class_inf,
     float_class_qnan,  /* all NaNs from here */
     float_class_snan,
-    float_class_msnan, /* maybe silenced */
 } FloatClass;
 
 /*
@@ -519,13 +518,7 @@ static FloatParts float16_unpack_canonical(float16 f, float_status *s)
 static float16 float16a_round_pack_canonical(const FloatFmt *params,
                                              FloatParts p, float_status *s)
 {
-    switch (p.cls) {
-    case float_class_msnan:
-        return float16_maybe_silence_nan(float16_pack_raw(p), s);
-    default:
-        p = round_canonical(p, s, params);
-        return float16_pack_raw(p);
-    }
+    return float16_pack_raw(round_canonical(p, s, params));
 }
 
 static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
@@ -540,13 +533,7 @@ static FloatParts float32_unpack_canonical(float32 f, float_status *s)
 
 static float32 float32_round_pack_canonical(FloatParts p, float_status *s)
 {
-    switch (p.cls) {
-    case float_class_msnan:
-        return float32_maybe_silence_nan(float32_pack_raw(p), s);
-    default:
-        p = round_canonical(p, s, &float32_params);
-        return float32_pack_raw(p);
-    }
+    return float32_pack_raw(round_canonical(p, s, &float32_params));
 }
 
 static FloatParts float64_unpack_canonical(float64 f, float_status *s)
@@ -556,13 +543,7 @@ static FloatParts float64_unpack_canonical(float64 f, float_status *s)
 
 static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
 {
-    switch (p.cls) {
-    case float_class_msnan:
-        return float64_maybe_silence_nan(float64_pack_raw(p), s);
-    default:
-        p = round_canonical(p, s, &float64_params);
-        return float64_pack_raw(p);
-    }
+    return float64_pack_raw(round_canonical(p, s, &float64_params));
 }
 
 /* Simple helpers for checking if what NaN we have */
@@ -570,10 +551,12 @@ static bool is_nan(FloatClass c)
 {
     return unlikely(c >= float_class_qnan);
 }
+
 static bool is_snan(FloatClass c)
 {
     return c == float_class_snan;
 }
+
 static bool is_qnan(FloatClass c)
 {
     return c == float_class_qnan;
@@ -584,7 +567,7 @@ static FloatParts return_nan(FloatParts a, float_status *s)
     switch (a.cls) {
     case float_class_snan:
         s->float_exception_flags |= float_flag_invalid;
-        a.cls = float_class_msnan;
+        a = parts_silence_nan(a, s);
         /* fall through */
     case float_class_qnan:
         if (s->default_nan_mode) {
@@ -613,7 +596,9 @@ static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
                     (a.frac == b.frac && a.sign < b.sign))) {
             a = b;
         }
-        a.cls = float_class_msnan;
+        if (is_snan(a.cls)) {
+            return parts_silence_nan(a, s);
+        }
     }
     return a;
 }
@@ -645,8 +630,9 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
         default:
             g_assert_not_reached();
         }
-
-        a.cls = float_class_msnan;
+        if (is_snan(a.cls)) {
+            return parts_silence_nan(a, s);
+        }
     }
     return a;
 }
@@ -1245,14 +1231,9 @@ static FloatParts float_to_float(FloatParts a,
         if (s->default_nan_mode) {
             return parts_default_nan(s);
         }
-
-        /*
-         * Reset a.exp to the destination format exp_max as
-         * the maybe_silence_nan code assumes it is correct
-         * (which it would be for non-conversions).
-         */
-        a.exp = dstf->exp_max;
-        a.cls = float_class_msnan;
+        if (is_snan(a.cls)) {
+            return parts_silence_nan(a, s);
+        }
     }
 
     return a;
@@ -1459,7 +1440,6 @@ static int64_t round_to_int_and_pack(FloatParts in, int rmode,
     switch (p.cls) {
     case float_class_snan:
     case float_class_qnan:
-    case float_class_msnan:
         s->float_exception_flags = orig_flags | float_flag_invalid;
         return max;
     case float_class_inf:
@@ -1550,7 +1530,6 @@ static uint64_t round_to_uint_and_pack(FloatParts in, int rmode, uint64_t max,
     switch (p.cls) {
     case float_class_snan:
     case float_class_qnan:
-    case float_class_msnan:
         s->float_exception_flags = orig_flags | float_flag_invalid;
         return max;
     case float_class_inf:
-- 
2.17.0
