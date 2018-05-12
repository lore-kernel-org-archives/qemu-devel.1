Received: from eggs.gnu.org ([2001:4830:134:3::10]:33353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdE-0004O6-II
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdD-0002rp-Bi
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:28 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:44967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHIdD-0002rY-3v
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:27 -0400
Received: by mail-pf0-x244.google.com with SMTP id q22-v6so3430880pff.11
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:43:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:42:52 -0700
Message-Id: <20180512004311.9299-9-richard.henderson@linaro.org>
In-Reply-To: <20180512004311.9299-1-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 08/27] fpu/softfloat: Replace
 float_class_dnan with parts_default_nan
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

Note one case where we uselessly assigned to a.sign, which was
overwritten/ignored later when expanding float_class_dnan.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 37 +++++++++++++++++++++++++++++++++++++
 fpu/softfloat.c            | 38 +++++++++++---------------------------
 2 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 515cb12cfa..0d3d81a52b 100644
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
index cb68f2eb20..d16b11a85b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -188,7 +188,6 @@ typedef enum __attribute__ ((__packed__)) {
     float_class_inf,
     float_class_qnan,  /* all NaNs from here */
     float_class_snan,
-    float_class_dnan,
     float_class_msnan, /* maybe silenced */
 } FloatClass;
 
@@ -494,8 +493,6 @@ static FloatParts float16_unpack_canonical(float16 f, float_status *s)
 static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
 {
     switch (p.cls) {
-    case float_class_dnan:
-        return float16_default_nan(s);
     case float_class_msnan:
         p.frac >>= float16_params.frac_shift;
         return float16_maybe_silence_nan(float16_pack_raw(p), s);
@@ -513,8 +510,6 @@ static FloatParts float32_unpack_canonical(float32 f, float_status *s)
 static float32 float32_round_pack_canonical(FloatParts p, float_status *s)
 {
     switch (p.cls) {
-    case float_class_dnan:
-        return float32_default_nan(s);
     case float_class_msnan:
         p.frac >>= float32_params.frac_shift;
         return float32_maybe_silence_nan(float32_pack_raw(p), s);
@@ -532,8 +527,6 @@ static FloatParts float64_unpack_canonical(float64 f, float_status *s)
 static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
 {
     switch (p.cls) {
-    case float_class_dnan:
-        return float64_default_nan(s);
     case float_class_msnan:
         p.frac >>= float64_params.frac_shift;
         return float64_maybe_silence_nan(float64_pack_raw(p), s);
@@ -566,7 +559,7 @@ static FloatParts return_nan(FloatParts a, float_status *s)
         /* fall through */
     case float_class_qnan:
         if (s->default_nan_mode) {
-            a.cls = float_class_dnan;
+            return parts_default_nan(s);
         }
         break;
 
@@ -583,7 +576,7 @@ static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
     }
 
     if (s->default_nan_mode) {
-        a.cls = float_class_dnan;
+        return parts_default_nan(s);
     } else {
         if (pickNaN(is_qnan(a.cls), is_snan(a.cls),
                     is_qnan(b.cls), is_snan(b.cls),
@@ -614,8 +607,7 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
         /* Note that this check is after pickNaNMulAdd so that function
          * has an opportunity to set the Invalid flag.
          */
-        a.cls = float_class_dnan;
-        return a;
+        which = 3;
     }
 
     switch (which) {
@@ -628,8 +620,7 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
         a = c;
         break;
     case 3:
-        a.cls = float_class_dnan;
-        return a;
+        return parts_default_nan(s);
     default:
         g_assert_not_reached();
     }
@@ -682,7 +673,7 @@ static FloatParts addsub_floats(FloatParts a, FloatParts b, bool subtract,
         if (a.cls == float_class_inf) {
             if (b.cls == float_class_inf) {
                 float_raise(float_flag_invalid, s);
-                a.cls = float_class_dnan;
+                return parts_default_nan(s);
             }
             return a;
         }
@@ -828,9 +819,7 @@ static FloatParts mul_floats(FloatParts a, FloatParts b, float_status *s)
     if ((a.cls == float_class_inf && b.cls == float_class_zero) ||
         (a.cls == float_class_zero && b.cls == float_class_inf)) {
         s->float_exception_flags |= float_flag_invalid;
-        a.cls = float_class_dnan;
-        a.sign = sign;
-        return a;
+        return parts_default_nan(s);
     }
     /* Multiply by 0 or Inf */
     if (a.cls == float_class_inf || a.cls == float_class_zero) {
@@ -908,8 +897,7 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
 
     if (inf_zero) {
         s->float_exception_flags |= float_flag_invalid;
-        a.cls = float_class_dnan;
-        return a;
+        return parts_default_nan(s);
     }
 
     if (flags & float_muladd_negate_c) {
@@ -933,12 +921,12 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
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
@@ -1148,8 +1136,7 @@ static FloatParts div_floats(FloatParts a, FloatParts b, float_status *s)
         &&
         (a.cls == float_class_inf || a.cls == float_class_zero)) {
         s->float_exception_flags |= float_flag_invalid;
-        a.cls = float_class_dnan;
-        return a;
+        return parts_default_nan(s);
     }
     /* Inf / x or 0 / x */
     if (a.cls == float_class_inf || a.cls == float_class_zero) {
@@ -1347,7 +1334,6 @@ static int64_t round_to_int_and_pack(FloatParts in, int rmode,
     switch (p.cls) {
     case float_class_snan:
     case float_class_qnan:
-    case float_class_dnan:
     case float_class_msnan:
         s->float_exception_flags = orig_flags | float_flag_invalid;
         return max;
@@ -1439,7 +1425,6 @@ static uint64_t round_to_uint_and_pack(FloatParts in, int rmode, uint64_t max,
     switch (p.cls) {
     case float_class_snan:
     case float_class_qnan:
-    case float_class_dnan:
     case float_class_msnan:
         s->float_exception_flags = orig_flags | float_flag_invalid;
         return max;
@@ -1940,8 +1925,7 @@ static FloatParts sqrt_float(FloatParts a, float_status *s, const FloatFmt *p)
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
