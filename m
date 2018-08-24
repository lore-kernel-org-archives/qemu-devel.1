Received: from eggs.gnu.org ([2001:4830:134:3::10]:35311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tc-00073L-Th
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tb-0002r2-0t
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:56 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Ta-0002N1-MQ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:54 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8TV-0006LQ-6S
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:33:49 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:32:52 +0100
Message-Id: <20180824093343.11346-2-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/52] softfloat: Add scaling int-to-float
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180814002653.12828-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat.h |  56 ++++++++----
 fpu/softfloat.c         | 188 +++++++++++++++++++++++++++++-----------
 2 files changed, 179 insertions(+), 65 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 69f4dbc4db7..038e375e713 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -190,22 +190,54 @@ enum {
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE integer-to-floating-point conversion routines.
 *----------------------------------------------------------------------------*/
+
+float16 int16_to_float16_scalbn(int16_t a, int, float_status *status);
+float16 int32_to_float16_scalbn(int32_t a, int, float_status *status);
+float16 int64_to_float16_scalbn(int64_t a, int, float_status *status);
+float16 uint16_to_float16_scalbn(uint16_t a, int, float_status *status);
+float16 uint32_to_float16_scalbn(uint32_t a, int, float_status *status);
+float16 uint64_to_float16_scalbn(uint64_t a, int, float_status *status);
+
+float16 int16_to_float16(int16_t a, float_status *status);
+float16 int32_to_float16(int32_t a, float_status *status);
+float16 int64_to_float16(int64_t a, float_status *status);
+float16 uint16_to_float16(uint16_t a, float_status *status);
+float16 uint32_to_float16(uint32_t a, float_status *status);
+float16 uint64_to_float16(uint64_t a, float_status *status);
+
+float32 int16_to_float32_scalbn(int16_t, int, float_status *status);
+float32 int32_to_float32_scalbn(int32_t, int, float_status *status);
+float32 int64_to_float32_scalbn(int64_t, int, float_status *status);
+float32 uint16_to_float32_scalbn(uint16_t, int, float_status *status);
+float32 uint32_to_float32_scalbn(uint32_t, int, float_status *status);
+float32 uint64_to_float32_scalbn(uint64_t, int, float_status *status);
+
 float32 int16_to_float32(int16_t, float_status *status);
 float32 int32_to_float32(int32_t, float_status *status);
-float64 int16_to_float64(int16_t, float_status *status);
-float64 int32_to_float64(int32_t, float_status *status);
+float32 int64_to_float32(int64_t, float_status *status);
 float32 uint16_to_float32(uint16_t, float_status *status);
 float32 uint32_to_float32(uint32_t, float_status *status);
+float32 uint64_to_float32(uint64_t, float_status *status);
+
+float64 int16_to_float64_scalbn(int16_t, int, float_status *status);
+float64 int32_to_float64_scalbn(int32_t, int, float_status *status);
+float64 int64_to_float64_scalbn(int64_t, int, float_status *status);
+float64 uint16_to_float64_scalbn(uint16_t, int, float_status *status);
+float64 uint32_to_float64_scalbn(uint32_t, int, float_status *status);
+float64 uint64_to_float64_scalbn(uint64_t, int, float_status *status);
+
+float64 int16_to_float64(int16_t, float_status *status);
+float64 int32_to_float64(int32_t, float_status *status);
+float64 int64_to_float64(int64_t, float_status *status);
 float64 uint16_to_float64(uint16_t, float_status *status);
 float64 uint32_to_float64(uint32_t, float_status *status);
-floatx80 int32_to_floatx80(int32_t, float_status *status);
-float128 int32_to_float128(int32_t, float_status *status);
-float32 int64_to_float32(int64_t, float_status *status);
-float64 int64_to_float64(int64_t, float_status *status);
-floatx80 int64_to_floatx80(int64_t, float_status *status);
-float128 int64_to_float128(int64_t, float_status *status);
-float32 uint64_to_float32(uint64_t, float_status *status);
 float64 uint64_to_float64(uint64_t, float_status *status);
+
+floatx80 int32_to_floatx80(int32_t, float_status *status);
+floatx80 int64_to_floatx80(int64_t, float_status *status);
+
+float128 int32_to_float128(int32_t, float_status *status);
+float128 int64_to_float128(int64_t, float_status *status);
 float128 uint64_to_float128(uint64_t, float_status *status);
 
 /*----------------------------------------------------------------------------
@@ -227,12 +259,6 @@ int64_t float16_to_int64(float16, float_status *status);
 uint64_t float16_to_uint64(float16 a, float_status *status);
 int64_t float16_to_int64_round_to_zero(float16, float_status *status);
 uint64_t float16_to_uint64_round_to_zero(float16 a, float_status *status);
-float16 int16_to_float16(int16_t a, float_status *status);
-float16 int32_to_float16(int32_t a, float_status *status);
-float16 int64_to_float16(int64_t a, float_status *status);
-float16 uint16_to_float16(uint16_t a, float_status *status);
-float16 uint32_to_float16(uint32_t a, float_status *status);
-float16 uint64_to_float16(uint64_t a, float_status *status);
 
 /*----------------------------------------------------------------------------
 | Software half-precision operations.
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7d63cffdeb8..12f373cbade 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1603,81 +1603,122 @@ FLOAT_TO_UINT(64, 64)
  * to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
  */
 
-static FloatParts int_to_float(int64_t a, float_status *status)
+static FloatParts int_to_float(int64_t a, int scale, float_status *status)
 {
-    FloatParts r = {};
+    FloatParts r = { .sign = false };
+
     if (a == 0) {
         r.cls = float_class_zero;
-        r.sign = false;
-    } else if (a == (1ULL << 63)) {
-        r.cls = float_class_normal;
-        r.sign = true;
-        r.frac = DECOMPOSED_IMPLICIT_BIT;
-        r.exp = 63;
     } else {
-        uint64_t f;
-        if (a < 0) {
-            f = -a;
-            r.sign = true;
-        } else {
-            f = a;
-            r.sign = false;
-        }
-        int shift = clz64(f) - 1;
+        uint64_t f = a;
+        int shift;
+
         r.cls = float_class_normal;
-        r.exp = (DECOMPOSED_BINARY_POINT - shift);
-        r.frac = f << shift;
+        if (a < 0) {
+            f = -f;
+            r.sign = true;
+        }
+        shift = clz64(f) - 1;
+        scale = MIN(MAX(scale, -0x10000), 0x10000);
+
+        r.exp = DECOMPOSED_BINARY_POINT - shift + scale;
+        r.frac = (shift < 0 ? DECOMPOSED_IMPLICIT_BIT : f << shift);
     }
 
     return r;
 }
 
+float16 int64_to_float16_scalbn(int64_t a, int scale, float_status *status)
+{
+    FloatParts pa = int_to_float(a, scale, status);
+    return float16_round_pack_canonical(pa, status);
+}
+
+float16 int32_to_float16_scalbn(int32_t a, int scale, float_status *status)
+{
+    return int64_to_float16_scalbn(a, scale, status);
+}
+
+float16 int16_to_float16_scalbn(int16_t a, int scale, float_status *status)
+{
+    return int64_to_float16_scalbn(a, scale, status);
+}
+
 float16 int64_to_float16(int64_t a, float_status *status)
 {
-    FloatParts pa = int_to_float(a, status);
-    return float16_round_pack_canonical(pa, status);
+    return int64_to_float16_scalbn(a, 0, status);
 }
 
 float16 int32_to_float16(int32_t a, float_status *status)
 {
-    return int64_to_float16(a, status);
+    return int64_to_float16_scalbn(a, 0, status);
 }
 
 float16 int16_to_float16(int16_t a, float_status *status)
 {
-    return int64_to_float16(a, status);
+    return int64_to_float16_scalbn(a, 0, status);
+}
+
+float32 int64_to_float32_scalbn(int64_t a, int scale, float_status *status)
+{
+    FloatParts pa = int_to_float(a, scale, status);
+    return float32_round_pack_canonical(pa, status);
+}
+
+float32 int32_to_float32_scalbn(int32_t a, int scale, float_status *status)
+{
+    return int64_to_float32_scalbn(a, scale, status);
+}
+
+float32 int16_to_float32_scalbn(int16_t a, int scale, float_status *status)
+{
+    return int64_to_float32_scalbn(a, scale, status);
 }
 
 float32 int64_to_float32(int64_t a, float_status *status)
 {
-    FloatParts pa = int_to_float(a, status);
-    return float32_round_pack_canonical(pa, status);
+    return int64_to_float32_scalbn(a, 0, status);
 }
 
 float32 int32_to_float32(int32_t a, float_status *status)
 {
-    return int64_to_float32(a, status);
+    return int64_to_float32_scalbn(a, 0, status);
 }
 
 float32 int16_to_float32(int16_t a, float_status *status)
 {
-    return int64_to_float32(a, status);
+    return int64_to_float32_scalbn(a, 0, status);
+}
+
+float64 int64_to_float64_scalbn(int64_t a, int scale, float_status *status)
+{
+    FloatParts pa = int_to_float(a, scale, status);
+    return float64_round_pack_canonical(pa, status);
+}
+
+float64 int32_to_float64_scalbn(int32_t a, int scale, float_status *status)
+{
+    return int64_to_float64_scalbn(a, scale, status);
+}
+
+float64 int16_to_float64_scalbn(int16_t a, int scale, float_status *status)
+{
+    return int64_to_float64_scalbn(a, scale, status);
 }
 
 float64 int64_to_float64(int64_t a, float_status *status)
 {
-    FloatParts pa = int_to_float(a, status);
-    return float64_round_pack_canonical(pa, status);
+    return int64_to_float64_scalbn(a, 0, status);
 }
 
 float64 int32_to_float64(int32_t a, float_status *status)
 {
-    return int64_to_float64(a, status);
+    return int64_to_float64_scalbn(a, 0, status);
 }
 
 float64 int16_to_float64(int16_t a, float_status *status)
 {
-    return int64_to_float64(a, status);
+    return int64_to_float64_scalbn(a, 0, status);
 }
 
 
@@ -1689,73 +1730,120 @@ float64 int16_to_float64(int16_t a, float_status *status)
  * IEC/IEEE Standard for Binary Floating-Point Arithmetic.
  */
 
-static FloatParts uint_to_float(uint64_t a, float_status *status)
+static FloatParts uint_to_float(uint64_t a, int scale, float_status *status)
 {
-    FloatParts r = { .sign = false};
+    FloatParts r = { .sign = false };
 
     if (a == 0) {
         r.cls = float_class_zero;
     } else {
-        int spare_bits = clz64(a) - 1;
+        scale = MIN(MAX(scale, -0x10000), 0x10000);
         r.cls = float_class_normal;
-        r.exp = DECOMPOSED_BINARY_POINT - spare_bits;
-        if (spare_bits < 0) {
-            shift64RightJamming(a, -spare_bits, &a);
+        if ((int64_t)a < 0) {
+            r.exp = DECOMPOSED_BINARY_POINT + 1 + scale;
+            shift64RightJamming(a, 1, &a);
             r.frac = a;
         } else {
-            r.frac = a << spare_bits;
+            int shift = clz64(a) - 1;
+            r.exp = DECOMPOSED_BINARY_POINT - shift + scale;
+            r.frac = a << shift;
         }
     }
 
     return r;
 }
 
+float16 uint64_to_float16_scalbn(uint64_t a, int scale, float_status *status)
+{
+    FloatParts pa = uint_to_float(a, scale, status);
+    return float16_round_pack_canonical(pa, status);
+}
+
+float16 uint32_to_float16_scalbn(uint32_t a, int scale, float_status *status)
+{
+    return uint64_to_float16_scalbn(a, scale, status);
+}
+
+float16 uint16_to_float16_scalbn(uint16_t a, int scale, float_status *status)
+{
+    return uint64_to_float16_scalbn(a, scale, status);
+}
+
 float16 uint64_to_float16(uint64_t a, float_status *status)
 {
-    FloatParts pa = uint_to_float(a, status);
-    return float16_round_pack_canonical(pa, status);
+    return uint64_to_float16_scalbn(a, 0, status);
 }
 
 float16 uint32_to_float16(uint32_t a, float_status *status)
 {
-    return uint64_to_float16(a, status);
+    return uint64_to_float16_scalbn(a, 0, status);
 }
 
 float16 uint16_to_float16(uint16_t a, float_status *status)
 {
-    return uint64_to_float16(a, status);
+    return uint64_to_float16_scalbn(a, 0, status);
+}
+
+float32 uint64_to_float32_scalbn(uint64_t a, int scale, float_status *status)
+{
+    FloatParts pa = uint_to_float(a, scale, status);
+    return float32_round_pack_canonical(pa, status);
+}
+
+float32 uint32_to_float32_scalbn(uint32_t a, int scale, float_status *status)
+{
+    return uint64_to_float32_scalbn(a, scale, status);
+}
+
+float32 uint16_to_float32_scalbn(uint16_t a, int scale, float_status *status)
+{
+    return uint64_to_float32_scalbn(a, scale, status);
 }
 
 float32 uint64_to_float32(uint64_t a, float_status *status)
 {
-    FloatParts pa = uint_to_float(a, status);
-    return float32_round_pack_canonical(pa, status);
+    return uint64_to_float32_scalbn(a, 0, status);
 }
 
 float32 uint32_to_float32(uint32_t a, float_status *status)
 {
-    return uint64_to_float32(a, status);
+    return uint64_to_float32_scalbn(a, 0, status);
 }
 
 float32 uint16_to_float32(uint16_t a, float_status *status)
 {
-    return uint64_to_float32(a, status);
+    return uint64_to_float32_scalbn(a, 0, status);
+}
+
+float64 uint64_to_float64_scalbn(uint64_t a, int scale, float_status *status)
+{
+    FloatParts pa = uint_to_float(a, scale, status);
+    return float64_round_pack_canonical(pa, status);
+}
+
+float64 uint32_to_float64_scalbn(uint32_t a, int scale, float_status *status)
+{
+    return uint64_to_float64_scalbn(a, scale, status);
+}
+
+float64 uint16_to_float64_scalbn(uint16_t a, int scale, float_status *status)
+{
+    return uint64_to_float64_scalbn(a, scale, status);
 }
 
 float64 uint64_to_float64(uint64_t a, float_status *status)
 {
-    FloatParts pa = uint_to_float(a, status);
-    return float64_round_pack_canonical(pa, status);
+    return uint64_to_float64_scalbn(a, 0, status);
 }
 
 float64 uint32_to_float64(uint32_t a, float_status *status)
 {
-    return uint64_to_float64(a, status);
+    return uint64_to_float64_scalbn(a, 0, status);
 }
 
 float64 uint16_to_float64(uint16_t a, float_status *status)
 {
-    return uint64_to_float64(a, status);
+    return uint64_to_float64_scalbn(a, 0, status);
 }
 
 /* Float Min/Max */
-- 
2.18.0
