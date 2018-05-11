Received: from eggs.gnu.org ([2001:4830:134:3::10]:51920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwA5-00079I-Vb
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwA3-0004nZ-FP
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:54 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:43037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGwA3-0004nG-78
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:51 -0400
Received: by mail-pf0-x241.google.com with SMTP id j20-v6so1859684pff.10
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 17:43:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 17:43:27 -0700
Message-Id: <20180511004345.26708-2-richard.henderson@linaro.org>
In-Reply-To: <20180511004345.26708-1-richard.henderson@linaro.org>
References: <20180511004345.26708-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 01/19] fpu/softfloat: Merge NO_SIGNALING_NANS
 definitions
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

Move the ifdef inside the relevant functions instead of
duplicating the function declarations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 100 +++++++++++++++----------------------
 1 file changed, 40 insertions(+), 60 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index a20b440159..8bd553abd2 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -233,17 +233,6 @@ typedef struct {
     uint64_t high, low;
 } commonNaNT;
 
-#ifdef NO_SIGNALING_NANS
-int float16_is_quiet_nan(float16 a_, float_status *status)
-{
-    return float16_is_any_nan(a_);
-}
-
-int float16_is_signaling_nan(float16 a_, float_status *status)
-{
-    return 0;
-}
-#else
 /*----------------------------------------------------------------------------
 | Returns 1 if the half-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
@@ -251,12 +240,16 @@ int float16_is_signaling_nan(float16 a_, float_status *status)
 
 int float16_is_quiet_nan(float16 a_, float_status *status)
 {
+#ifdef NO_SIGNALING_NANS
+    return float16_is_any_nan(a_);
+#else
     uint16_t a = float16_val(a_);
     if (status->snan_bit_is_one) {
         return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
     } else {
         return ((a & ~0x8000) >= 0x7C80);
     }
+#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -266,14 +259,17 @@ int float16_is_quiet_nan(float16 a_, float_status *status)
 
 int float16_is_signaling_nan(float16 a_, float_status *status)
 {
+#ifdef NO_SIGNALING_NANS
+    return 0;
+#else
     uint16_t a = float16_val(a_);
     if (status->snan_bit_is_one) {
         return ((a & ~0x8000) >= 0x7C80);
     } else {
         return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
     }
-}
 #endif
+}
 
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN if the half-precision floating point value `a' is a
@@ -293,17 +289,6 @@ float16 float16_maybe_silence_nan(float16 a_, float_status *status)
     return a_;
 }
 
-#ifdef NO_SIGNALING_NANS
-int float32_is_quiet_nan(float32 a_, float_status *status)
-{
-    return float32_is_any_nan(a_);
-}
-
-int float32_is_signaling_nan(float32 a_, float_status *status)
-{
-    return 0;
-}
-#else
 /*----------------------------------------------------------------------------
 | Returns 1 if the single-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
@@ -311,12 +296,16 @@ int float32_is_signaling_nan(float32 a_, float_status *status)
 
 int float32_is_quiet_nan(float32 a_, float_status *status)
 {
+#ifdef NO_SIGNALING_NANS
+    return float32_is_any_nan(a_);
+#else
     uint32_t a = float32_val(a_);
     if (status->snan_bit_is_one) {
         return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
     } else {
         return ((uint32_t)(a << 1) >= 0xFF800000);
     }
+#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -326,14 +315,17 @@ int float32_is_quiet_nan(float32 a_, float_status *status)
 
 int float32_is_signaling_nan(float32 a_, float_status *status)
 {
+#ifdef NO_SIGNALING_NANS
+    return 0;
+#else
     uint32_t a = float32_val(a_);
     if (status->snan_bit_is_one) {
         return ((uint32_t)(a << 1) >= 0xFF800000);
     } else {
         return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
     }
-}
 #endif
+}
 
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN if the single-precision floating point value `a' is a
@@ -704,17 +696,6 @@ static float32 propagateFloat32NaN(float32 a, float32 b, float_status *status)
     }
 }
 
-#ifdef NO_SIGNALING_NANS
-int float64_is_quiet_nan(float64 a_, float_status *status)
-{
-    return float64_is_any_nan(a_);
-}
-
-int float64_is_signaling_nan(float64 a_, float_status *status)
-{
-    return 0;
-}
-#else
 /*----------------------------------------------------------------------------
 | Returns 1 if the double-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
@@ -722,6 +703,9 @@ int float64_is_signaling_nan(float64 a_, float_status *status)
 
 int float64_is_quiet_nan(float64 a_, float_status *status)
 {
+#ifdef NO_SIGNALING_NANS
+    return float64_is_any_nan(a_);
+#else
     uint64_t a = float64_val(a_);
     if (status->snan_bit_is_one) {
         return (((a >> 51) & 0xFFF) == 0xFFE)
@@ -729,6 +713,7 @@ int float64_is_quiet_nan(float64 a_, float_status *status)
     } else {
         return ((a << 1) >= 0xFFF0000000000000ULL);
     }
+#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -738,6 +723,9 @@ int float64_is_quiet_nan(float64 a_, float_status *status)
 
 int float64_is_signaling_nan(float64 a_, float_status *status)
 {
+#ifdef NO_SIGNALING_NANS
+    return 0;
+#else
     uint64_t a = float64_val(a_);
     if (status->snan_bit_is_one) {
         return ((a << 1) >= 0xFFF0000000000000ULL);
@@ -745,8 +733,8 @@ int float64_is_signaling_nan(float64 a_, float_status *status)
         return (((a >> 51) & 0xFFF) == 0xFFE)
             && (a & LIT64(0x0007FFFFFFFFFFFF));
     }
-}
 #endif
+}
 
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN if the double-precision floating point value `a' is a
@@ -859,17 +847,6 @@ static float64 propagateFloat64NaN(float64 a, float64 b, float_status *status)
     }
 }
 
-#ifdef NO_SIGNALING_NANS
-int floatx80_is_quiet_nan(floatx80 a_, float_status *status)
-{
-    return floatx80_is_any_nan(a_);
-}
-
-int floatx80_is_signaling_nan(floatx80 a_, float_status *status)
-{
-    return 0;
-}
-#else
 /*----------------------------------------------------------------------------
 | Returns 1 if the extended double-precision floating-point value `a' is a
 | quiet NaN; otherwise returns 0. This slightly differs from the same
@@ -878,6 +855,9 @@ int floatx80_is_signaling_nan(floatx80 a_, float_status *status)
 
 int floatx80_is_quiet_nan(floatx80 a, float_status *status)
 {
+#ifdef NO_SIGNALING_NANS
+    return floatx80_is_any_nan(a);
+#else
     if (status->snan_bit_is_one) {
         uint64_t aLow;
 
@@ -889,6 +869,7 @@ int floatx80_is_quiet_nan(floatx80 a, float_status *status)
         return ((a.high & 0x7FFF) == 0x7FFF)
             && (LIT64(0x8000000000000000) <= ((uint64_t)(a.low << 1)));
     }
+#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -899,6 +880,9 @@ int floatx80_is_quiet_nan(floatx80 a, float_status *status)
 
 int floatx80_is_signaling_nan(floatx80 a, float_status *status)
 {
+#ifdef NO_SIGNALING_NANS
+    return 0;
+#else
     if (status->snan_bit_is_one) {
         return ((a.high & 0x7FFF) == 0x7FFF)
             && ((a.low << 1) >= 0x8000000000000000ULL);
@@ -910,8 +894,8 @@ int floatx80_is_signaling_nan(floatx80 a, float_status *status)
             && (uint64_t)(aLow << 1)
             && (a.low == aLow);
     }
-}
 #endif
+}
 
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN if the extended double-precision floating point value
@@ -1020,17 +1004,6 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
     }
 }
 
-#ifdef NO_SIGNALING_NANS
-int float128_is_quiet_nan(float128 a_, float_status *status)
-{
-    return float128_is_any_nan(a_);
-}
-
-int float128_is_signaling_nan(float128 a_, float_status *status)
-{
-    return 0;
-}
-#else
 /*----------------------------------------------------------------------------
 | Returns 1 if the quadruple-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
@@ -1038,6 +1011,9 @@ int float128_is_signaling_nan(float128 a_, float_status *status)
 
 int float128_is_quiet_nan(float128 a, float_status *status)
 {
+#ifdef NO_SIGNALING_NANS
+    return float128_is_any_nan(a);
+#else
     if (status->snan_bit_is_one) {
         return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
             && (a.low || (a.high & 0x00007FFFFFFFFFFFULL));
@@ -1045,6 +1021,7 @@ int float128_is_quiet_nan(float128 a, float_status *status)
         return ((a.high << 1) >= 0xFFFF000000000000ULL)
             && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
     }
+#endif
 }
 
 /*----------------------------------------------------------------------------
@@ -1054,6 +1031,9 @@ int float128_is_quiet_nan(float128 a, float_status *status)
 
 int float128_is_signaling_nan(float128 a, float_status *status)
 {
+#ifdef NO_SIGNALING_NANS
+    return 0;
+#else
     if (status->snan_bit_is_one) {
         return ((a.high << 1) >= 0xFFFF000000000000ULL)
             && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
@@ -1061,8 +1041,8 @@ int float128_is_signaling_nan(float128 a, float_status *status)
         return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
             && (a.low || (a.high & LIT64(0x00007FFFFFFFFFFF)));
     }
-}
 #endif
+}
 
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN if the quadruple-precision floating point value `a' is
-- 
2.17.0
