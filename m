Received: from eggs.gnu.org ([2001:4830:134:3::10]:33410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdK-0004Xq-Sn
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdH-0002uj-Nz
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:34 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:45673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHIdH-0002uW-GW
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:31 -0400
Received: by mail-pg0-x241.google.com with SMTP id w3-v6so3074280pgv.12
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:43:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:42:55 -0700
Message-Id: <20180512004311.9299-12-richard.henderson@linaro.org>
In-Reply-To: <20180512004311.9299-1-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/27] fpu/softfloat: support ARM
 Alternative half-precision
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

From: Alex Bennée <alex.bennee@linaro.org>

For float16 ARM supports an alternative half-precision format which
sacrifices the ability to represent NaN/Inf in return for a higher
dynamic range. To support this I've added an additional
FloatFmt (float16_params_ahp).

The new FloatFmt flag (arm_althp) is then used to modify the behaviour
of canonicalize and round_canonical with respect to representation and
exception raising.

Finally the float16_to_floatN and floatN_to_float16 conversion
routines select the new alternative FloatFmt when !ieee.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
v3
  - squash NaN to 0 if destination is AHP F16
v4
  - handle inf -> ahp max in float_to_float not round_canonical
  - assert no nan and inf for ahp in round_canonical
  - check ahp before snan in float_to_float
---
 fpu/softfloat.c | 95 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 81 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index aa219223ff..15a272759d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -211,8 +211,10 @@ typedef struct {
  *   frac_shift: shift to normalise the fraction with DECOMPOSED_BINARY_POINT
  * The following are computed based the size of fraction
  *   frac_lsb: least significant bit of fraction
- *   fram_lsbm1: the bit bellow the least significant bit (for rounding)
+ *   frac_lsbm1: the bit bellow the least significant bit (for rounding)
  *   round_mask/roundeven_mask: masks used for rounding
+ * The following optional modifiers are available:
+ *   arm_althp: handle ARM Alternative Half Precision
  */
 typedef struct {
     int exp_size;
@@ -224,6 +226,7 @@ typedef struct {
     uint64_t frac_lsbm1;
     uint64_t round_mask;
     uint64_t roundeven_mask;
+    bool arm_althp;
 } FloatFmt;
 
 /*----------------------------------------------------------------------------
@@ -252,6 +255,11 @@ static const FloatFmt float16_params = {
     FLOAT_PARAMS(5, 10)
 };
 
+static const FloatFmt float16_params_ahp = {
+    FLOAT_PARAMS(5, 10),
+    .arm_althp = true
+};
+
 static const FloatFmt float32_params = {
     FLOAT_PARAMS(8, 23)
 };
@@ -315,7 +323,7 @@ static inline float64 float64_pack_raw(FloatParts p)
 static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
                                float_status *status)
 {
-    if (part.exp == parm->exp_max) {
+    if (part.exp == parm->exp_max && !parm->arm_althp) {
         if (part.frac == 0) {
             part.cls = float_class_inf;
         } else {
@@ -404,7 +412,15 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
             }
             frac >>= frac_shift;
 
-            if (unlikely(exp >= exp_max)) {
+            if (parm->arm_althp) {
+                /* ARM Alt HP eschews Inf and NaN for a wider exponent.  */
+                if (unlikely(exp > exp_max)) {
+                    /* Overflow.  Return the maximum normal.  */
+                    flags = float_flag_invalid;
+                    exp = exp_max;
+                    frac = -1;
+                }
+            } else if (unlikely(exp >= exp_max)) {
                 flags |= float_flag_overflow | float_flag_inexact;
                 if (overflow_norm) {
                     exp = exp_max - 1;
@@ -455,12 +471,14 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
 
     case float_class_inf:
     do_inf:
+        assert(!parm->arm_althp);
         exp = exp_max;
         frac = 0;
         break;
 
     case float_class_qnan:
     case float_class_snan:
+        assert(!parm->arm_althp);
         exp = exp_max;
         frac >>= parm->frac_shift;
         break;
@@ -475,14 +493,27 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
     return p;
 }
 
+/* Explicit FloatFmt version */
+static FloatParts float16a_unpack_canonical(float16 f, float_status *s,
+                                            const FloatFmt *params)
+{
+    return canonicalize(float16_unpack_raw(f), params, s);
+}
+
 static FloatParts float16_unpack_canonical(float16 f, float_status *s)
 {
-    return canonicalize(float16_unpack_raw(f), &float16_params, s);
+    return float16a_unpack_canonical(f, s, &float16_params);
+}
+
+static float16 float16a_round_pack_canonical(FloatParts p, float_status *s,
+                                             const FloatFmt *params)
+{
+    return float16_pack_raw(round_canonical(p, s, params));
 }
 
 static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
 {
-    return float16_pack_raw(round_canonical(p, s, &float16_params));
+    return float16a_round_pack_canonical(p, s, &float16_params);
 }
 
 static FloatParts float32_unpack_canonical(float32 f, float_status *s)
@@ -1174,7 +1205,33 @@ static FloatParts float_to_float(FloatParts a,
                                  const FloatFmt *srcf, const FloatFmt *dstf,
                                  float_status *s)
 {
-    if (is_nan(a.cls)) {
+    if (dstf->arm_althp) {
+        switch (a.cls) {
+        case float_class_qnan:
+        case float_class_snan:
+            /* There is no NaN in the destination format.  Raise Invalid
+             * and return a zero with the sign of the input NaN.
+             */
+            s->float_exception_flags |= float_flag_invalid;
+            a.cls = float_class_zero;
+            a.frac = 0;
+            a.exp = 0;
+            break;
+
+        case float_class_inf:
+            /* There is no Inf in the destination format.  Raise Invalid
+             * and return the maximum normal with the correct sign.
+             */
+            s->float_exception_flags |= float_flag_invalid;
+            a.cls = float_class_normal;
+            a.exp = dstf->exp_max;
+            a.frac = ((1ull << dstf->frac_size) - 1) << dstf->frac_shift;
+            break;
+
+        default:
+            break;
+        }
+    } else if (is_nan(a.cls)) {
         if (is_snan(a.cls)) {
             s->float_exception_flags |= float_flag_invalid;
             a = parts_silence_nan(a, s);
@@ -1186,25 +1243,34 @@ static FloatParts float_to_float(FloatParts a,
     return a;
 }
 
+/*
+ * Currently non-ieee implies ARM Alternative Half Precision handling
+ * for float16 values. If more are needed we'll need to expand the API
+ * into softfloat.
+ */
+
 float32 float16_to_float32(float16 a, bool ieee, float_status *s)
 {
-    FloatParts p = float16_unpack_canonical(a, s);
-    FloatParts pr = float_to_float(p, &float16_params, &float32_params, s);
+    const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
+    FloatParts p = float16a_unpack_canonical(a, s, fmt16);
+    FloatParts pr = float_to_float(p, fmt16, &float32_params, s);
     return float32_round_pack_canonical(pr, s);
 }
 
 float64 float16_to_float64(float16 a, bool ieee, float_status *s)
 {
-    FloatParts p = float16_unpack_canonical(a, s);
-    FloatParts pr = float_to_float(p, &float16_params, &float64_params, s);
+    const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
+    FloatParts p = float16a_unpack_canonical(a, s, fmt16);
+    FloatParts pr = float_to_float(p, fmt16, &float64_params, s);
     return float64_round_pack_canonical(pr, s);
 }
 
 float16 float32_to_float16(float32 a, bool ieee, float_status *s)
 {
+    const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
     FloatParts p = float32_unpack_canonical(a, s);
-    FloatParts pr = float_to_float(p, &float32_params, &float16_params, s);
-    return float16_round_pack_canonical(pr, s);
+    FloatParts pr = float_to_float(p, &float32_params, fmt16, s);
+    return float16a_round_pack_canonical(pr, s, fmt16);
 }
 
 float64 float32_to_float64(float32 a, float_status *s)
@@ -1216,9 +1282,10 @@ float64 float32_to_float64(float32 a, float_status *s)
 
 float16 float64_to_float16(float64 a, bool ieee, float_status *s)
 {
+    const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
     FloatParts p = float64_unpack_canonical(a, s);
-    FloatParts pr = float_to_float(p, &float64_params, &float16_params, s);
-    return float16_round_pack_canonical(pr, s);
+    FloatParts pr = float_to_float(p, &float64_params, fmt16, s);
+    return float16a_round_pack_canonical(pr, s, fmt16);
 }
 
 float32 float64_to_float32(float64 a, float_status *s)
-- 
2.17.0
