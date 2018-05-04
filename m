Received: from eggs.gnu.org ([2001:4830:134:3::10]:53391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEXb8-0004ik-UN
	for qemu-devel@nongnu.org; Fri, 04 May 2018 06:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEXb7-0008LV-V1
	for qemu-devel@nongnu.org; Fri, 04 May 2018 06:05:54 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 11:05:47 +0100
Message-Id: <20180504100547.14621-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] softfloat: Handle default NaN mode after
 pickNaNMulAdd, not before
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-stable@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

It is implementation defined whether a multiply-add of
(0,inf,qnan) or (inf,0,qnan) raises InvalidaOperation or
not, so we let the target-specific pickNaNMulAdd function
handle this. This means that we must do the "return the
default NaN in default NaN mode" check after the call,
not before. Correct the ordering, and restore the comment
from the old propagateFloat64MulAddNaN() that warned about
this corner case.

This fixes a regression from 2.11 for Arm guests where we would
incorrectly fail to set the Invalid flag for these cases.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat.c | 52 ++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 70e0c40a1c..8401b37bd4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -602,34 +602,42 @@ static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
 static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
                                   bool inf_zero, float_status *s)
 {
+    int which;
+
     if (is_snan(a.cls) || is_snan(b.cls) || is_snan(c.cls)) {
         s->float_exception_flags |= float_flag_invalid;
     }
 
-    if (s->default_nan_mode) {
-        a.cls = float_class_dnan;
-    } else {
-        switch (pickNaNMulAdd(is_qnan(a.cls), is_snan(a.cls),
-                              is_qnan(b.cls), is_snan(b.cls),
-                              is_qnan(c.cls), is_snan(c.cls),
-                              inf_zero, s)) {
-        case 0:
-            break;
-        case 1:
-            a = b;
-            break;
-        case 2:
-            a = c;
-            break;
-        case 3:
-            a.cls = float_class_dnan;
-            return a;
-        default:
-            g_assert_not_reached();
-        }
+    which = pickNaNMulAdd(is_qnan(a.cls), is_snan(a.cls),
+                          is_qnan(b.cls), is_snan(b.cls),
+                          is_qnan(c.cls), is_snan(c.cls),
+                          inf_zero, s);
 
-        a.cls = float_class_msnan;
+    if (s->default_nan_mode) {
+        /* Note that this check is after pickNaNMulAdd so that function
+         * has an opportunity to set the Invalid flag.
+         */
+        a.cls = float_class_dnan;
+        return a;
     }
+
+    switch (which) {
+    case 0:
+        break;
+    case 1:
+        a = b;
+        break;
+    case 2:
+        a = c;
+        break;
+    case 3:
+        a.cls = float_class_dnan;
+        return a;
+    default:
+        g_assert_not_reached();
+    }
+    a.cls = float_class_msnan;
+
     return a;
 }
 
-- 
2.17.0
