Received: from eggs.gnu.org ([2001:4830:134:3::10]:52141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwAS-0007XY-Oo
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwAR-0004uo-IG
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:44:16 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGwAR-0004ue-9r
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:44:15 -0400
Received: by mail-pg0-x244.google.com with SMTP id z70-v6so1681623pgz.3
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 17:44:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 17:43:45 -0700
Message-Id: <20180511004345.26708-20-richard.henderson@linaro.org>
In-Reply-To: <20180511004345.26708-1-richard.henderson@linaro.org>
References: <20180511004345.26708-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 19/19] fpu/softfloat: Pass FloatClass to
 pickNaNMulAdd
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

For each operand, pass a single enumeration instead of a pair of booleans.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 70 +++++++++++++++-----------------------
 fpu/softfloat.c            | 11 +++---
 2 files changed, 31 insertions(+), 50 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 83e5bf83b9..637f1ea1be 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -583,15 +583,14 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 | information.
 | Return values : 0 : a; 1 : b; 2 : c; 3 : default-NaN
 *----------------------------------------------------------------------------*/
-#if defined(TARGET_ARM)
-static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                         flag cIsQNaN, flag cIsSNaN, flag infzero,
-                         float_status *status)
+static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
+                         bool infzero, float_status *status)
 {
+#if defined(TARGET_ARM)
     /* For ARM, the (inf,zero,qnan) case sets InvalidOp and returns
      * the default NaN
      */
-    if (infzero && cIsQNaN) {
+    if (infzero && is_qnan(c_cls)) {
         float_raise(float_flag_invalid, status);
         return 3;
     }
@@ -599,25 +598,20 @@ static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
     /* This looks different from the ARM ARM pseudocode, because the ARM ARM
      * puts the operands to a fused mac operation (a*b)+c in the order c,a,b.
      */
-    if (cIsSNaN) {
+    if (is_snan(c_cls)) {
         return 2;
-    } else if (aIsSNaN) {
+    } else if (is_snan(a_cls)) {
         return 0;
-    } else if (bIsSNaN) {
+    } else if (is_snan(b_cls)) {
         return 1;
-    } else if (cIsQNaN) {
+    } else if (is_qnan(c_cls)) {
         return 2;
-    } else if (aIsQNaN) {
+    } else if (is_qnan(a_cls)) {
         return 0;
     } else {
         return 1;
     }
-}
 #elif defined(TARGET_MIPS)
-static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                         flag cIsQNaN, flag cIsSNaN, flag infzero,
-                         float_status *status)
-{
     /* For MIPS, the (inf,zero,qnan) case sets InvalidOp and returns
      * the default NaN
      */
@@ -628,41 +622,36 @@ static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
 
     if (SNAN_BIT_IS_ONE(status)) {
         /* Prefer sNaN over qNaN, in the a, b, c order. */
-        if (aIsSNaN) {
+        if (is_snan(a_cls)) {
             return 0;
-        } else if (bIsSNaN) {
+        } else if (is_snan(b_cls)) {
             return 1;
-        } else if (cIsSNaN) {
+        } else if (is_snan(c_cls)) {
             return 2;
-        } else if (aIsQNaN) {
+        } else if (is_qnan(a_cls)) {
             return 0;
-        } else if (bIsQNaN) {
+        } else if (is_qnan(b_cls)) {
             return 1;
         } else {
             return 2;
         }
     } else {
         /* Prefer sNaN over qNaN, in the c, a, b order. */
-        if (cIsSNaN) {
+        if (is_snan(c_cls)) {
             return 2;
-        } else if (aIsSNaN) {
+        } else if (is_snan(a_cls)) {
             return 0;
-        } else if (bIsSNaN) {
+        } else if (is_snan(b_cls)) {
             return 1;
-        } else if (cIsQNaN) {
+        } else if (is_qnan(c_cls)) {
             return 2;
-        } else if (aIsQNaN) {
+        } else if (is_qnan(a_cls)) {
             return 0;
         } else {
             return 1;
         }
     }
-}
 #elif defined(TARGET_PPC)
-static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                         flag cIsQNaN, flag cIsSNaN, flag infzero,
-                         float_status *status)
-{
     /* For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
      * to return an input NaN if we have one (ie c) rather than generating
      * a default NaN
@@ -675,31 +664,26 @@ static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
     /* If fRA is a NaN return it; otherwise if fRB is a NaN return it;
      * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
      */
-    if (aIsSNaN || aIsQNaN) {
+    if (is_nan(a_cls)) {
         return 0;
-    } else if (cIsSNaN || cIsQNaN) {
+    } else if (is_nan(c_cls)) {
         return 2;
     } else {
         return 1;
     }
-}
 #else
-/* A default implementation: prefer a to b to c.
- * This is unlikely to actually match any real implementation.
- */
-static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                         flag cIsQNaN, flag cIsSNaN, flag infzero,
-                         float_status *status)
-{
-    if (aIsSNaN || aIsQNaN) {
+    /* A default implementation: prefer a to b to c.
+     * This is unlikely to actually match any real implementation.
+     */
+    if (is_nan(a_cls)) {
         return 0;
-    } else if (bIsSNaN || bIsQNaN) {
+    } else if (is_nan(b_cls)) {
         return 1;
     } else {
         return 2;
     }
-}
 #endif
+}
 
 /*----------------------------------------------------------------------------
 | Takes two single-precision floating-point values `a' and `b', one of which
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index cd56beb277..4e957a5d6f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -182,17 +182,17 @@ typedef enum __attribute__ ((__packed__)) {
 } FloatClass;
 
 /* Simple helpers for checking if what NaN we have */
-static bool is_nan(FloatClass c)
+static inline __attribute__((unused)) bool is_nan(FloatClass c)
 {
     return unlikely(c >= float_class_qnan);
 }
 
-static bool is_snan(FloatClass c)
+static inline __attribute__((unused)) bool is_snan(FloatClass c)
 {
     return c == float_class_snan;
 }
 
-static bool is_qnan(FloatClass c)
+static inline __attribute__((unused)) bool is_qnan(FloatClass c)
 {
     return c == float_class_qnan;
 }
@@ -612,10 +612,7 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
     if (s->default_nan_mode) {
         return parts_default_nan(s);
     } else {
-        switch (pickNaNMulAdd(is_qnan(a.cls), is_snan(a.cls),
-                              is_qnan(b.cls), is_snan(b.cls),
-                              is_qnan(c.cls), is_snan(c.cls),
-                              inf_zero, s)) {
+        switch (pickNaNMulAdd(a.cls, b.cls, c.cls, inf_zero, s)) {
         case 0:
             break;
         case 1:
-- 
2.17.0
