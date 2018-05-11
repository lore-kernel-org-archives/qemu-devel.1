Received: from eggs.gnu.org ([2001:4830:134:3::10]:51991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwAB-0007AG-LB
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwAA-0004q6-9m
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:59 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:37381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGwAA-0004pu-2J
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:58 -0400
Received: by mail-pl0-x242.google.com with SMTP id f7-v6so2266816plr.4
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 17:43:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 17:43:32 -0700
Message-Id: <20180511004345.26708-7-richard.henderson@linaro.org>
In-Reply-To: <20180511004345.26708-1-richard.henderson@linaro.org>
References: <20180511004345.26708-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/19] fpu/softfloat: Replace float_class_dnan
 with parts_default_nan
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

With a canonical representation of NaNs, we can return the
default nan directly rather than delay the expansion until
the final format is known.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 37 +++++++++++++++++++++++++++++++++++++
 fpu/softfloat.c            | 38 ++++++++++++--------------------------
 2 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 82d7a030e7..2ad524b11e 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -101,6 +101,43 @@ static bool parts_is_snan_frac(uint64_t frac, float_status *status)
 #endif
 }
 
+/*----------------------------------------------------------------------------
+| The pattern for a default generated deconstructed floating-point NaN.
+*----------------------------------------------------------------------------*/
+
+static FloatParts parts_default_nan(float_status *status)
+{
+    bool sign = 0;
+    uint64_t frac;
+
+#if defined(TARGET_SPARC) || defined(TARGET_M68K)
+    frac = (1ULL << DECOMPOSED_BINARY_POINT) - 1;
+#elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA) || \
+      defined(TARGET_S390X) || defined(TARGET_RISCV)
+    frac = 1ULL << (DECOMPOSED_BINARY_POINT - 1);
+#elif defined(TARGET_HPPA)
+    frac = 1ULL << (DECOMPOSED_BINARY_POINT - 2);
+#else
+    if (status->snan_bit_is_one) {
+        frac = (1ULL << (DECOMPOSED_BINARY_POINT - 1)) - 1;
+    } else {
+#if defined(TARGET_MIPS)
+        frac = 1ULL << (DECOMPOSED_BINARY_POINT - 1);
+#else
+        frac = 1ULL << (DECOMPOSED_BINARY_POINT - 1);
+        sign = 1;
+#endif
+    }
+#endif
+
+    return (FloatParts) {
+        .cls = float_class_qnan,
+        .sign = sign,
+        .exp = INT_MAX,
+        .frac = frac
+    };
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6dfc992a7f..01036b158e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -179,7 +179,6 @@ typedef enum __attribute__ ((__packed__)) {
     float_class_inf,
     float_class_qnan,  /* all NaNs from here */
     float_class_snan,
-    float_class_dnan,
     float_class_msnan, /* maybe silenced */
 } FloatClass;
 
@@ -521,8 +520,6 @@ static float16 float16a_round_pack_canonical(const FloatFmt *params,
                                              FloatParts p, float_status *s)
 {
     switch (p.cls) {
-    case float_class_dnan:
-        return float16_default_nan(s);
     case float_class_msnan:
         return float16_maybe_silence_nan(float16_pack_raw(p), s);
     default:
@@ -544,8 +541,6 @@ static FloatParts float32_unpack_canonical(float32 f, float_status *s)
 static float32 float32_round_pack_canonical(FloatParts p, float_status *s)
 {
     switch (p.cls) {
-    case float_class_dnan:
-        return float32_default_nan(s);
     case float_class_msnan:
         return float32_maybe_silence_nan(float32_pack_raw(p), s);
     default:
@@ -562,8 +557,6 @@ static FloatParts float64_unpack_canonical(float64 f, float_status *s)
 static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
 {
     switch (p.cls) {
-    case float_class_dnan:
-        return float64_default_nan(s);
     case float_class_msnan:
         return float64_maybe_silence_nan(float64_pack_raw(p), s);
     default:
@@ -595,7 +588,7 @@ static FloatParts return_nan(FloatParts a, float_status *s)
         /* fall through */
     case float_class_qnan:
         if (s->default_nan_mode) {
-            a.cls = float_class_dnan;
+            return parts_default_nan(s);
         }
         break;
 
@@ -612,7 +605,7 @@ static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
     }
 
     if (s->default_nan_mode) {
-        a.cls = float_class_dnan;
+        return parts_default_nan(s);
     } else {
         if (pickNaN(is_qnan(a.cls), is_snan(a.cls),
                     is_qnan(b.cls), is_snan(b.cls),
@@ -633,7 +626,7 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
     }
 
     if (s->default_nan_mode) {
-        a.cls = float_class_dnan;
+        return parts_default_nan(s);
     } else {
         switch (pickNaNMulAdd(is_qnan(a.cls), is_snan(a.cls),
                               is_qnan(b.cls), is_snan(b.cls),
@@ -648,8 +641,7 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
             a = c;
             break;
         case 3:
-            a.cls = float_class_dnan;
-            return a;
+            return parts_default_nan(s);
         default:
             g_assert_not_reached();
         }
@@ -703,7 +695,7 @@ static FloatParts addsub_floats(FloatParts a, FloatParts b, bool subtract,
         if (a.cls == float_class_inf) {
             if (b.cls == float_class_inf) {
                 float_raise(float_flag_invalid, s);
-                a.cls = float_class_dnan;
+                return parts_default_nan(s);
             }
             return a;
         }
@@ -849,7 +841,7 @@ static FloatParts mul_floats(FloatParts a, FloatParts b, float_status *s)
     if ((a.cls == float_class_inf && b.cls == float_class_zero) ||
         (a.cls == float_class_zero && b.cls == float_class_inf)) {
         s->float_exception_flags |= float_flag_invalid;
-        a.cls = float_class_dnan;
+        a = parts_default_nan(s);
         a.sign = sign;
         return a;
     }
@@ -929,8 +921,7 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
 
     if (inf_zero) {
         s->float_exception_flags |= float_flag_invalid;
-        a.cls = float_class_dnan;
-        return a;
+        return parts_default_nan(s);
     }
 
     if (flags & float_muladd_negate_c) {
@@ -954,12 +945,12 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
     if (c.cls == float_class_inf) {
         if (p_class == float_class_inf && p_sign != c.sign) {
             s->float_exception_flags |= float_flag_invalid;
-            a.cls = float_class_dnan;
+            return parts_default_nan(s);
         } else {
             a.cls = float_class_inf;
             a.sign = c.sign ^ sign_flip;
+            return a;
         }
-        return a;
     }
 
     if (p_class == float_class_inf) {
@@ -1169,8 +1160,7 @@ static FloatParts div_floats(FloatParts a, FloatParts b, float_status *s)
         &&
         (a.cls == float_class_inf || a.cls == float_class_zero)) {
         s->float_exception_flags |= float_flag_invalid;
-        a.cls = float_class_dnan;
-        return a;
+        return parts_default_nan(s);
     }
     /* Inf / x or 0 / x */
     if (a.cls == float_class_inf || a.cls == float_class_zero) {
@@ -1253,8 +1243,7 @@ static FloatParts float_to_float(FloatParts a,
         }
 
         if (s->default_nan_mode) {
-            a.cls = float_class_dnan;
-            return a;
+            return parts_default_nan(s);
         }
 
         /*
@@ -1470,7 +1459,6 @@ static int64_t round_to_int_and_pack(FloatParts in, int rmode,
     switch (p.cls) {
     case float_class_snan:
     case float_class_qnan:
-    case float_class_dnan:
     case float_class_msnan:
         s->float_exception_flags = orig_flags | float_flag_invalid;
         return max;
@@ -1562,7 +1550,6 @@ static uint64_t round_to_uint_and_pack(FloatParts in, int rmode, uint64_t max,
     switch (p.cls) {
     case float_class_snan:
     case float_class_qnan:
-    case float_class_dnan:
     case float_class_msnan:
         s->float_exception_flags = orig_flags | float_flag_invalid;
         return max;
@@ -2063,8 +2050,7 @@ static FloatParts sqrt_float(FloatParts a, float_status *s, const FloatFmt *p)
     }
     if (a.sign) {
         s->float_exception_flags |= float_flag_invalid;
-        a.cls = float_class_dnan;
-        return a;
+        return parts_default_nan(s);
     }
     if (a.cls == float_class_inf) {
         return a;  /* sqrt(+inf) = +inf */
-- 
2.17.0
