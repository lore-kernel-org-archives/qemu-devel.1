Received: from eggs.gnu.org ([2001:4830:134:3::10]:46858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDtv5-0004NU-WA
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDtv4-0008NP-Kz
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:43:52 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDtv4-0008N1-Bs
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:43:50 -0400
Received: by mail-wr0-x244.google.com with SMTP id y15-v6so2808199wrg.11
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 08:43:50 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  2 May 2018 16:43:43 +0100
Message-Id: <20180502154344.10585-3-alex.bennee@linaro.org>
In-Reply-To: <20180502154344.10585-1-alex.bennee@linaro.org>
References: <20180502154344.10585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/3] fpu/softfloat: support ARM Alternative
 half-precision
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

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
---
 fpu/softfloat.c | 97 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 23 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 28b9f4f79b..25a331158f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -234,6 +234,8 @@ typedef struct {
  *   frac_lsb: least significant bit of fraction
  *   fram_lsbm1: the bit bellow the least significant bit (for rounding)
  *   round_mask/roundeven_mask: masks used for rounding
+ * The following optional modifiers are available:
+ *   arm_althp: handle ARM Alternative Half Precision
  */
 typedef struct {
     int exp_size;
@@ -245,6 +247,7 @@ typedef struct {
     uint64_t frac_lsbm1;
     uint64_t round_mask;
     uint64_t roundeven_mask;
+    bool arm_althp;
 } FloatFmt;
 
 /* Expand fields based on the size of exponent and fraction */
@@ -257,12 +260,17 @@ typedef struct {
     .frac_lsb       = 1ull << (DECOMPOSED_BINARY_POINT - F),         \
     .frac_lsbm1     = 1ull << ((DECOMPOSED_BINARY_POINT - F) - 1),   \
     .round_mask     = (1ull << (DECOMPOSED_BINARY_POINT - F)) - 1,   \
-    .roundeven_mask = (2ull << (DECOMPOSED_BINARY_POINT - F)) - 1
+    .roundeven_mask = (2ull << (DECOMPOSED_BINARY_POINT - F)) - 1,
 
 static const FloatFmt float16_params = {
     FLOAT_PARAMS(5, 10)
 };
 
+static const FloatFmt float16_params_ahp = {
+    FLOAT_PARAMS(5, 10)
+    .arm_althp = true
+};
+
 static const FloatFmt float32_params = {
     FLOAT_PARAMS(8, 23)
 };
@@ -326,7 +334,7 @@ static inline float64 float64_pack_raw(FloatParts p)
 static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
                                float_status *status)
 {
-    if (part.exp == parm->exp_max) {
+    if (part.exp == parm->exp_max && !parm->arm_althp) {
         if (part.frac == 0) {
             part.cls = float_class_inf;
         } else {
@@ -412,8 +420,9 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
 
         exp += parm->exp_bias;
         if (likely(exp > 0)) {
+            bool maybe_inexact = false;
             if (frac & round_mask) {
-                flags |= float_flag_inexact;
+                maybe_inexact = true;
                 frac += inc;
                 if (frac & DECOMPOSED_OVERFLOW_BIT) {
                     frac >>= 1;
@@ -422,14 +431,26 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
             }
             frac >>= frac_shift;
 
-            if (unlikely(exp >= exp_max)) {
-                flags |= float_flag_overflow | float_flag_inexact;
-                if (overflow_norm) {
-                    exp = exp_max - 1;
-                    frac = -1;
-                } else {
-                    p.cls = float_class_inf;
-                    goto do_inf;
+            if (parm->arm_althp) {
+                if (unlikely(exp >= exp_max + 1)) {
+                        flags |= float_flag_invalid;
+                        frac = -1;
+                        exp = exp_max;
+                } else if (maybe_inexact) {
+                    flags |= float_flag_inexact;
+                }
+            } else {
+                if (unlikely(exp >= exp_max)) {
+                    flags |= float_flag_overflow | float_flag_inexact;
+                    if (overflow_norm) {
+                        exp = exp_max - 1;
+                        frac = -1;
+                    } else {
+                        p.cls = float_class_inf;
+                        goto do_inf;
+                    }
+                } else if (maybe_inexact) {
+                    flags |= float_flag_inexact;
                 }
             }
         } else if (s->flush_to_zero) {
@@ -474,7 +495,13 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
     case float_class_inf:
     do_inf:
         exp = exp_max;
-        frac = 0;
+        if (parm->arm_althp) {
+            flags |= float_flag_invalid;
+            /* Alt HP returns result = sign:Ones(M-1) */
+            frac = -1;
+        } else {
+            frac = 0;
+        }
         break;
 
     case float_class_qnan:
@@ -492,12 +519,21 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
     return p;
 }
 
+/* Explicit FloatFmt version */
+static FloatParts float16a_unpack_canonical(const FloatFmt *params,
+                                            float16 f, float_status *s)
+{
+    return canonicalize(float16_unpack_raw(f), params, s);
+}
+
 static FloatParts float16_unpack_canonical(float16 f, float_status *s)
 {
-    return canonicalize(float16_unpack_raw(f), &float16_params, s);
+    return float16a_unpack_canonical(&float16_params, f, s);
 }
 
-static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
+
+static float16 float16a_round_pack_canonical(const FloatFmt *params,
+                                             FloatParts p, float_status *s)
 {
     switch (p.cls) {
     case float_class_dnan:
@@ -505,11 +541,16 @@ static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
     case float_class_msnan:
         return float16_maybe_silence_nan(float16_pack_raw(p), s);
     default:
-        p = round_canonical(p, s, &float16_params);
+        p = round_canonical(p, s, params);
         return float16_pack_raw(p);
     }
 }
 
+static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
+{
+    return float16a_round_pack_canonical(&float16_params, p, s);
+}
+
 static FloatParts float32_unpack_canonical(float32 f, float_status *s)
 {
     return canonicalize(float32_unpack_raw(f), &float32_params, s);
@@ -1235,25 +1276,34 @@ static FloatParts float_to_float(FloatParts a,
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
+    FloatParts p = float16a_unpack_canonical(fmt16, a, s);
+    FloatParts pr = float_to_float(p, fmt16, &float32_params, s);
     return float32_round_pack_canonical(pr, s);
 }
 
 float64 float16_to_float64(float16 a, bool ieee, float_status *s)
 {
-    FloatParts p = float16_unpack_canonical(a, s);
-    FloatParts pr = float_to_float(p, &float16_params, &float64_params, s);
+    const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
+    FloatParts p = float16a_unpack_canonical(fmt16, a, s);
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
+    return float16a_round_pack_canonical(fmt16, pr, s);
 }
 
 float64 float32_to_float64(float32 a, float_status *s)
@@ -1265,9 +1315,10 @@ float64 float32_to_float64(float32 a, float_status *s)
 
 float16 float64_to_float16(float64 a, bool ieee, float_status *s)
 {
+    const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
     FloatParts p = float64_unpack_canonical(a, s);
-    FloatParts pr = float_to_float(p, &float64_params, &float16_params, s);
-    return float16_round_pack_canonical(pr, s);
+    FloatParts pr = float_to_float(p, &float64_params, fmt16, s);
+    return float16a_round_pack_canonical(fmt16, pr, s);
 }
 
 float32 float64_to_float32(float64 a, float_status *s)
-- 
2.17.0
