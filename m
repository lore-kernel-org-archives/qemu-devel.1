Received: from eggs.gnu.org ([2001:4830:134:3::10]:51765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fpNAt-0004v2-KJ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 20:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fpNAr-0000mh-3A
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 20:27:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:35114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fpNAq-0000le-Nx
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 20:27:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id p12-v6so8436010pfh.2
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 17:27:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 13 Aug 2018 17:26:51 -0700
Message-Id: <20180814002653.12828-3-richard.henderson@linaro.org>
In-Reply-To: <20180814002653.12828-1-richard.henderson@linaro.org>
References: <20180814002653.12828-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] softfloat: Add scaling float-to-int
 routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |  85 ++++++---
 fpu/softfloat.c         | 391 ++++++++++++++++++++++++++++++++--------
 2 files changed, 379 insertions(+), 97 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 038e375e71..cc1b58b029 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -243,21 +243,34 @@ float128 uint64_to_float128(uint64_t, float_status *status);
 /*----------------------------------------------------------------------------
 | Software half-precision conversion routines.
 *----------------------------------------------------------------------------*/
+
 float16 float32_to_float16(float32, bool ieee, float_status *status);
 float32 float16_to_float32(float16, bool ieee, float_status *status);
 float16 float64_to_float16(float64 a, bool ieee, float_status *status);
 float64 float16_to_float64(float16 a, bool ieee, float_status *status);
+
+int16_t float16_to_int16_scalbn(float16, int, int, float_status *status);
+int32_t float16_to_int32_scalbn(float16, int, int, float_status *status);
+int64_t float16_to_int64_scalbn(float16, int, int, float_status *status);
+
 int16_t float16_to_int16(float16, float_status *status);
-uint16_t float16_to_uint16(float16 a, float_status *status);
-int16_t float16_to_int16_round_to_zero(float16, float_status *status);
-uint16_t float16_to_uint16_round_to_zero(float16 a, float_status *status);
 int32_t float16_to_int32(float16, float_status *status);
-uint32_t float16_to_uint32(float16 a, float_status *status);
-int32_t float16_to_int32_round_to_zero(float16, float_status *status);
-uint32_t float16_to_uint32_round_to_zero(float16 a, float_status *status);
 int64_t float16_to_int64(float16, float_status *status);
-uint64_t float16_to_uint64(float16 a, float_status *status);
+
+int16_t float16_to_int16_round_to_zero(float16, float_status *status);
+int32_t float16_to_int32_round_to_zero(float16, float_status *status);
 int64_t float16_to_int64_round_to_zero(float16, float_status *status);
+
+uint16_t float16_to_uint16_scalbn(float16 a, int, int, float_status *status);
+uint32_t float16_to_uint32_scalbn(float16 a, int, int, float_status *status);
+uint64_t float16_to_uint64_scalbn(float16 a, int, int, float_status *status);
+
+uint16_t float16_to_uint16(float16 a, float_status *status);
+uint32_t float16_to_uint32(float16 a, float_status *status);
+uint64_t float16_to_uint64(float16 a, float_status *status);
+
+uint16_t float16_to_uint16_round_to_zero(float16 a, float_status *status);
+uint32_t float16_to_uint32_round_to_zero(float16 a, float_status *status);
 uint64_t float16_to_uint64_round_to_zero(float16 a, float_status *status);
 
 /*----------------------------------------------------------------------------
@@ -347,18 +360,31 @@ float16 float16_default_nan(float_status *status);
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE single-precision conversion routines.
 *----------------------------------------------------------------------------*/
+
+int16_t float32_to_int16_scalbn(float32, int, int, float_status *status);
+int32_t float32_to_int32_scalbn(float32, int, int, float_status *status);
+int64_t float32_to_int64_scalbn(float32, int, int, float_status *status);
+
 int16_t float32_to_int16(float32, float_status *status);
-uint16_t float32_to_uint16(float32, float_status *status);
-int16_t float32_to_int16_round_to_zero(float32, float_status *status);
-uint16_t float32_to_uint16_round_to_zero(float32, float_status *status);
 int32_t float32_to_int32(float32, float_status *status);
-int32_t float32_to_int32_round_to_zero(float32, float_status *status);
-uint32_t float32_to_uint32(float32, float_status *status);
-uint32_t float32_to_uint32_round_to_zero(float32, float_status *status);
 int64_t float32_to_int64(float32, float_status *status);
-uint64_t float32_to_uint64(float32, float_status *status);
-uint64_t float32_to_uint64_round_to_zero(float32, float_status *status);
+
+int16_t float32_to_int16_round_to_zero(float32, float_status *status);
+int32_t float32_to_int32_round_to_zero(float32, float_status *status);
 int64_t float32_to_int64_round_to_zero(float32, float_status *status);
+
+uint16_t float32_to_uint16_scalbn(float32, int, int, float_status *status);
+uint32_t float32_to_uint32_scalbn(float32, int, int, float_status *status);
+uint64_t float32_to_uint64_scalbn(float32, int, int, float_status *status);
+
+uint16_t float32_to_uint16(float32, float_status *status);
+uint32_t float32_to_uint32(float32, float_status *status);
+uint64_t float32_to_uint64(float32, float_status *status);
+
+uint16_t float32_to_uint16_round_to_zero(float32, float_status *status);
+uint32_t float32_to_uint32_round_to_zero(float32, float_status *status);
+uint64_t float32_to_uint64_round_to_zero(float32, float_status *status);
+
 float64 float32_to_float64(float32, float_status *status);
 floatx80 float32_to_floatx80(float32, float_status *status);
 float128 float32_to_float128(float32, float_status *status);
@@ -476,18 +502,31 @@ float32 float32_default_nan(float_status *status);
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE double-precision conversion routines.
 *----------------------------------------------------------------------------*/
+
+int16_t float64_to_int16_scalbn(float64, int, int, float_status *status);
+int32_t float64_to_int32_scalbn(float64, int, int, float_status *status);
+int64_t float64_to_int64_scalbn(float64, int, int, float_status *status);
+
 int16_t float64_to_int16(float64, float_status *status);
-uint16_t float64_to_uint16(float64, float_status *status);
-int16_t float64_to_int16_round_to_zero(float64, float_status *status);
-uint16_t float64_to_uint16_round_to_zero(float64, float_status *status);
 int32_t float64_to_int32(float64, float_status *status);
-int32_t float64_to_int32_round_to_zero(float64, float_status *status);
-uint32_t float64_to_uint32(float64, float_status *status);
-uint32_t float64_to_uint32_round_to_zero(float64, float_status *status);
 int64_t float64_to_int64(float64, float_status *status);
+
+int16_t float64_to_int16_round_to_zero(float64, float_status *status);
+int32_t float64_to_int32_round_to_zero(float64, float_status *status);
 int64_t float64_to_int64_round_to_zero(float64, float_status *status);
-uint64_t float64_to_uint64(float64 a, float_status *status);
-uint64_t float64_to_uint64_round_to_zero(float64 a, float_status *status);
+
+uint16_t float64_to_uint16_scalbn(float64, int, int, float_status *status);
+uint32_t float64_to_uint32_scalbn(float64, int, int, float_status *status);
+uint64_t float64_to_uint64_scalbn(float64, int, int, float_status *status);
+
+uint16_t float64_to_uint16(float64, float_status *status);
+uint32_t float64_to_uint32(float64, float_status *status);
+uint64_t float64_to_uint64(float64, float_status *status);
+
+uint16_t float64_to_uint16_round_to_zero(float64, float_status *status);
+uint32_t float64_to_uint32_round_to_zero(float64, float_status *status);
+uint64_t float64_to_uint64_round_to_zero(float64, float_status *status);
+
 float32 float64_to_float32(float64, float_status *status);
 floatx80 float64_to_floatx80(float64, float_status *status);
 float128 float64_to_float128(float64, float_status *status);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 12f373cbad..59ca356d0e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1293,19 +1293,23 @@ float32 float64_to_float32(float64 a, float_status *s)
  * Arithmetic.
  */
 
-static FloatParts round_to_int(FloatParts a, int rounding_mode, float_status *s)
+static FloatParts round_to_int(FloatParts a, int rmode,
+                               int scale, float_status *s)
 {
-    if (is_nan(a.cls)) {
-        return return_nan(a, s);
-    }
-
     switch (a.cls) {
+    case float_class_qnan:
+    case float_class_snan:
+        return return_nan(a, s);
+
     case float_class_zero:
     case float_class_inf:
-    case float_class_qnan:
         /* already "integral" */
         break;
+
     case float_class_normal:
+        scale = MIN(MAX(scale, -0x10000), 0x10000);
+        a.exp += scale;
+
         if (a.exp >= DECOMPOSED_BINARY_POINT) {
             /* already integral */
             break;
@@ -1314,7 +1318,7 @@ static FloatParts round_to_int(FloatParts a, int rounding_mode, float_status *s)
             bool one;
             /* all fractional */
             s->float_exception_flags |= float_flag_inexact;
-            switch (rounding_mode) {
+            switch (rmode) {
             case float_round_nearest_even:
                 one = a.exp == -1 && a.frac > DECOMPOSED_IMPLICIT_BIT;
                 break;
@@ -1347,7 +1351,7 @@ static FloatParts round_to_int(FloatParts a, int rounding_mode, float_status *s)
             uint64_t rnd_mask = rnd_even_mask >> 1;
             uint64_t inc;
 
-            switch (rounding_mode) {
+            switch (rmode) {
             case float_round_nearest_even:
                 inc = ((a.frac & rnd_even_mask) != frac_lsbm1 ? frac_lsbm1 : 0);
                 break;
@@ -1387,28 +1391,28 @@ static FloatParts round_to_int(FloatParts a, int rounding_mode, float_status *s)
 float16 float16_round_to_int(float16 a, float_status *s)
 {
     FloatParts pa = float16_unpack_canonical(a, s);
-    FloatParts pr = round_to_int(pa, s->float_rounding_mode, s);
+    FloatParts pr = round_to_int(pa, s->float_rounding_mode, 0, s);
     return float16_round_pack_canonical(pr, s);
 }
 
 float32 float32_round_to_int(float32 a, float_status *s)
 {
     FloatParts pa = float32_unpack_canonical(a, s);
-    FloatParts pr = round_to_int(pa, s->float_rounding_mode, s);
+    FloatParts pr = round_to_int(pa, s->float_rounding_mode, 0, s);
     return float32_round_pack_canonical(pr, s);
 }
 
 float64 float64_round_to_int(float64 a, float_status *s)
 {
     FloatParts pa = float64_unpack_canonical(a, s);
-    FloatParts pr = round_to_int(pa, s->float_rounding_mode, s);
+    FloatParts pr = round_to_int(pa, s->float_rounding_mode, 0, s);
     return float64_round_pack_canonical(pr, s);
 }
 
 float64 float64_trunc_to_int(float64 a, float_status *s)
 {
     FloatParts pa = float64_unpack_canonical(a, s);
-    FloatParts pr = round_to_int(pa, float_round_to_zero, s);
+    FloatParts pr = round_to_int(pa, float_round_to_zero, 0, s);
     return float64_round_pack_canonical(pr, s);
 }
 
@@ -1423,13 +1427,13 @@ float64 float64_trunc_to_int(float64 a, float_status *s)
  * is returned.
 */
 
-static int64_t round_to_int_and_pack(FloatParts in, int rmode,
+static int64_t round_to_int_and_pack(FloatParts in, int rmode, int scale,
                                      int64_t min, int64_t max,
                                      float_status *s)
 {
     uint64_t r;
     int orig_flags = get_float_exception_flags(s);
-    FloatParts p = round_to_int(in, rmode, s);
+    FloatParts p = round_to_int(in, rmode, scale, s);
 
     switch (p.cls) {
     case float_class_snan:
@@ -1469,38 +1473,158 @@ static int64_t round_to_int_and_pack(FloatParts in, int rmode,
     }
 }
 
-#define FLOAT_TO_INT(fsz, isz)                                          \
-int ## isz ## _t float ## fsz ## _to_int ## isz(float ## fsz a,         \
-                                                float_status *s)        \
-{                                                                       \
-    FloatParts p = float ## fsz ## _unpack_canonical(a, s);             \
-    return round_to_int_and_pack(p, s->float_rounding_mode,             \
-                                 INT ## isz ## _MIN, INT ## isz ## _MAX,\
-                                 s);                                    \
-}                                                                       \
-                                                                        \
-int ## isz ## _t float ## fsz ## _to_int ## isz ## _round_to_zero       \
- (float ## fsz a, float_status *s)                                      \
-{                                                                       \
-    FloatParts p = float ## fsz ## _unpack_canonical(a, s);             \
-    return round_to_int_and_pack(p, float_round_to_zero,                \
-                                 INT ## isz ## _MIN, INT ## isz ## _MAX,\
-                                 s);                                    \
+int16_t float16_to_int16_scalbn(float16 a, int rmode, int scale,
+                                float_status *s)
+{
+    return round_to_int_and_pack(float16_unpack_canonical(a, s),
+                                 rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
-FLOAT_TO_INT(16, 16)
-FLOAT_TO_INT(16, 32)
-FLOAT_TO_INT(16, 64)
+int32_t float16_to_int32_scalbn(float16 a, int rmode, int scale,
+                                float_status *s)
+{
+    return round_to_int_and_pack(float16_unpack_canonical(a, s),
+                                 rmode, scale, INT32_MIN, INT32_MAX, s);
+}
 
-FLOAT_TO_INT(32, 16)
-FLOAT_TO_INT(32, 32)
-FLOAT_TO_INT(32, 64)
+int64_t float16_to_int64_scalbn(float16 a, int rmode, int scale,
+                                float_status *s)
+{
+    return round_to_int_and_pack(float16_unpack_canonical(a, s),
+                                 rmode, scale, INT64_MIN, INT64_MAX, s);
+}
 
-FLOAT_TO_INT(64, 16)
-FLOAT_TO_INT(64, 32)
-FLOAT_TO_INT(64, 64)
+int16_t float32_to_int16_scalbn(float32 a, int rmode, int scale,
+                                float_status *s)
+{
+    return round_to_int_and_pack(float32_unpack_canonical(a, s),
+                                 rmode, scale, INT16_MIN, INT16_MAX, s);
+}
 
-#undef FLOAT_TO_INT
+int32_t float32_to_int32_scalbn(float32 a, int rmode, int scale,
+                                float_status *s)
+{
+    return round_to_int_and_pack(float32_unpack_canonical(a, s),
+                                 rmode, scale, INT32_MIN, INT32_MAX, s);
+}
+
+int64_t float32_to_int64_scalbn(float32 a, int rmode, int scale,
+                                float_status *s)
+{
+    return round_to_int_and_pack(float32_unpack_canonical(a, s),
+                                 rmode, scale, INT64_MIN, INT64_MAX, s);
+}
+
+int16_t float64_to_int16_scalbn(float64 a, int rmode, int scale,
+                                float_status *s)
+{
+    return round_to_int_and_pack(float64_unpack_canonical(a, s),
+                                 rmode, scale, INT16_MIN, INT16_MAX, s);
+}
+
+int32_t float64_to_int32_scalbn(float64 a, int rmode, int scale,
+                                float_status *s)
+{
+    return round_to_int_and_pack(float64_unpack_canonical(a, s),
+                                 rmode, scale, INT32_MIN, INT32_MAX, s);
+}
+
+int64_t float64_to_int64_scalbn(float64 a, int rmode, int scale,
+                                float_status *s)
+{
+    return round_to_int_and_pack(float64_unpack_canonical(a, s),
+                                 rmode, scale, INT64_MIN, INT64_MAX, s);
+}
+
+int16_t float16_to_int16(float16 a, float_status *s)
+{
+    return float16_to_int16_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int32_t float16_to_int32(float16 a, float_status *s)
+{
+    return float16_to_int32_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int64_t float16_to_int64(float16 a, float_status *s)
+{
+    return float16_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int16_t float32_to_int16(float32 a, float_status *s)
+{
+    return float32_to_int16_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int32_t float32_to_int32(float32 a, float_status *s)
+{
+    return float32_to_int32_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int64_t float32_to_int64(float32 a, float_status *s)
+{
+    return float32_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int16_t float64_to_int16(float64 a, float_status *s)
+{
+    return float64_to_int16_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int32_t float64_to_int32(float64 a, float_status *s)
+{
+    return float64_to_int32_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int64_t float64_to_int64(float64 a, float_status *s)
+{
+    return float64_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int16_t float16_to_int16_round_to_zero(float16 a, float_status *s)
+{
+    return float16_to_int16_scalbn(a, float_round_to_zero, 0, s);
+}
+
+int32_t float16_to_int32_round_to_zero(float16 a, float_status *s)
+{
+    return float16_to_int32_scalbn(a, float_round_to_zero, 0, s);
+}
+
+int64_t float16_to_int64_round_to_zero(float16 a, float_status *s)
+{
+    return float16_to_int64_scalbn(a, float_round_to_zero, 0, s);
+}
+
+int16_t float32_to_int16_round_to_zero(float32 a, float_status *s)
+{
+    return float32_to_int16_scalbn(a, float_round_to_zero, 0, s);
+}
+
+int32_t float32_to_int32_round_to_zero(float32 a, float_status *s)
+{
+    return float32_to_int32_scalbn(a, float_round_to_zero, 0, s);
+}
+
+int64_t float32_to_int64_round_to_zero(float32 a, float_status *s)
+{
+    return float32_to_int64_scalbn(a, float_round_to_zero, 0, s);
+}
+
+int16_t float64_to_int16_round_to_zero(float64 a, float_status *s)
+{
+    return float64_to_int16_scalbn(a, float_round_to_zero, 0, s);
+}
+
+int32_t float64_to_int32_round_to_zero(float64 a, float_status *s)
+{
+    return float64_to_int32_scalbn(a, float_round_to_zero, 0, s);
+}
+
+int64_t float64_to_int64_round_to_zero(float64 a, float_status *s)
+{
+    return float64_to_int64_scalbn(a, float_round_to_zero, 0, s);
+}
 
 /*
  *  Returns the result of converting the floating-point value `a' to
@@ -1515,11 +1639,12 @@ FLOAT_TO_INT(64, 64)
  *  flag.
  */
 
-static uint64_t round_to_uint_and_pack(FloatParts in, int rmode, uint64_t max,
-                                       float_status *s)
+static uint64_t round_to_uint_and_pack(FloatParts in, int rmode, int scale,
+                                       uint64_t max, float_status *s)
 {
     int orig_flags = get_float_exception_flags(s);
-    FloatParts p = round_to_int(in, rmode, s);
+    FloatParts p = round_to_int(in, rmode, scale, s);
+    uint64_t r;
 
     switch (p.cls) {
     case float_class_snan:
@@ -1532,8 +1657,6 @@ static uint64_t round_to_uint_and_pack(FloatParts in, int rmode, uint64_t max,
     case float_class_zero:
         return 0;
     case float_class_normal:
-    {
-        uint64_t r;
         if (p.sign) {
             s->float_exception_flags = orig_flags | float_flag_invalid;
             return 0;
@@ -1555,45 +1678,165 @@ static uint64_t round_to_uint_and_pack(FloatParts in, int rmode, uint64_t max,
         if (r > max) {
             s->float_exception_flags = orig_flags | float_flag_invalid;
             return max;
-        } else {
-            return r;
         }
-    }
+        return r;
     default:
         g_assert_not_reached();
     }
 }
 
-#define FLOAT_TO_UINT(fsz, isz) \
-uint ## isz ## _t float ## fsz ## _to_uint ## isz(float ## fsz a,       \
-                                                  float_status *s)      \
-{                                                                       \
-    FloatParts p = float ## fsz ## _unpack_canonical(a, s);             \
-    return round_to_uint_and_pack(p, s->float_rounding_mode,            \
-                                 UINT ## isz ## _MAX, s);               \
-}                                                                       \
-                                                                        \
-uint ## isz ## _t float ## fsz ## _to_uint ## isz ## _round_to_zero     \
- (float ## fsz a, float_status *s)                                      \
-{                                                                       \
-    FloatParts p = float ## fsz ## _unpack_canonical(a, s);             \
-    return round_to_uint_and_pack(p, float_round_to_zero,               \
-                                  UINT ## isz ## _MAX, s);              \
+uint16_t float16_to_uint16_scalbn(float16 a, int rmode, int scale,
+                                  float_status *s)
+{
+    return round_to_uint_and_pack(float16_unpack_canonical(a, s),
+                                  rmode, scale, UINT16_MAX, s);
 }
 
-FLOAT_TO_UINT(16, 16)
-FLOAT_TO_UINT(16, 32)
-FLOAT_TO_UINT(16, 64)
+uint32_t float16_to_uint32_scalbn(float16 a, int rmode, int scale,
+                                  float_status *s)
+{
+    return round_to_uint_and_pack(float16_unpack_canonical(a, s),
+                                  rmode, scale, UINT32_MAX, s);
+}
 
-FLOAT_TO_UINT(32, 16)
-FLOAT_TO_UINT(32, 32)
-FLOAT_TO_UINT(32, 64)
+uint64_t float16_to_uint64_scalbn(float16 a, int rmode, int scale,
+                                  float_status *s)
+{
+    return round_to_uint_and_pack(float16_unpack_canonical(a, s),
+                                  rmode, scale, UINT64_MAX, s);
+}
 
-FLOAT_TO_UINT(64, 16)
-FLOAT_TO_UINT(64, 32)
-FLOAT_TO_UINT(64, 64)
+uint16_t float32_to_uint16_scalbn(float32 a, int rmode, int scale,
+                                  float_status *s)
+{
+    return round_to_uint_and_pack(float32_unpack_canonical(a, s),
+                                  rmode, scale, UINT16_MAX, s);
+}
 
-#undef FLOAT_TO_UINT
+uint32_t float32_to_uint32_scalbn(float32 a, int rmode, int scale,
+                                  float_status *s)
+{
+    return round_to_uint_and_pack(float32_unpack_canonical(a, s),
+                                  rmode, scale, UINT32_MAX, s);
+}
+
+uint64_t float32_to_uint64_scalbn(float32 a, int rmode, int scale,
+                                  float_status *s)
+{
+    return round_to_uint_and_pack(float32_unpack_canonical(a, s),
+                                  rmode, scale, UINT64_MAX, s);
+}
+
+uint16_t float64_to_uint16_scalbn(float64 a, int rmode, int scale,
+                                  float_status *s)
+{
+    return round_to_uint_and_pack(float64_unpack_canonical(a, s),
+                                  rmode, scale, UINT16_MAX, s);
+}
+
+uint32_t float64_to_uint32_scalbn(float64 a, int rmode, int scale,
+                                  float_status *s)
+{
+    return round_to_uint_and_pack(float64_unpack_canonical(a, s),
+                                  rmode, scale, UINT32_MAX, s);
+}
+
+uint64_t float64_to_uint64_scalbn(float64 a, int rmode, int scale,
+                                  float_status *s)
+{
+    return round_to_uint_and_pack(float64_unpack_canonical(a, s),
+                                  rmode, scale, UINT64_MAX, s);
+}
+
+uint16_t float16_to_uint16(float16 a, float_status *s)
+{
+    return float16_to_uint16_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint32_t float16_to_uint32(float16 a, float_status *s)
+{
+    return float16_to_uint32_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint64_t float16_to_uint64(float16 a, float_status *s)
+{
+    return float16_to_uint64_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint16_t float32_to_uint16(float32 a, float_status *s)
+{
+    return float32_to_uint16_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint32_t float32_to_uint32(float32 a, float_status *s)
+{
+    return float32_to_uint32_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint64_t float32_to_uint64(float32 a, float_status *s)
+{
+    return float32_to_uint64_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint16_t float64_to_uint16(float64 a, float_status *s)
+{
+    return float64_to_uint16_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint32_t float64_to_uint32(float64 a, float_status *s)
+{
+    return float64_to_uint32_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint64_t float64_to_uint64(float64 a, float_status *s)
+{
+    return float64_to_uint64_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint16_t float16_to_uint16_round_to_zero(float16 a, float_status *s)
+{
+    return float16_to_uint16_scalbn(a, float_round_to_zero, 0, s);
+}
+
+uint32_t float16_to_uint32_round_to_zero(float16 a, float_status *s)
+{
+    return float16_to_uint32_scalbn(a, float_round_to_zero, 0, s);
+}
+
+uint64_t float16_to_uint64_round_to_zero(float16 a, float_status *s)
+{
+    return float16_to_uint64_scalbn(a, float_round_to_zero, 0, s);
+}
+
+uint16_t float32_to_uint16_round_to_zero(float32 a, float_status *s)
+{
+    return float32_to_uint16_scalbn(a, float_round_to_zero, 0, s);
+}
+
+uint32_t float32_to_uint32_round_to_zero(float32 a, float_status *s)
+{
+    return float32_to_uint32_scalbn(a, float_round_to_zero, 0, s);
+}
+
+uint64_t float32_to_uint64_round_to_zero(float32 a, float_status *s)
+{
+    return float32_to_uint64_scalbn(a, float_round_to_zero, 0, s);
+}
+
+uint16_t float64_to_uint16_round_to_zero(float64 a, float_status *s)
+{
+    return float64_to_uint16_scalbn(a, float_round_to_zero, 0, s);
+}
+
+uint32_t float64_to_uint32_round_to_zero(float64 a, float_status *s)
+{
+    return float64_to_uint32_scalbn(a, float_round_to_zero, 0, s);
+}
+
+uint64_t float64_to_uint64_round_to_zero(float64 a, float_status *s)
+{
+    return float64_to_uint64_scalbn(a, float_round_to_zero, 0, s);
+}
 
 /*
  * Integer to float conversions
-- 
2.17.1
