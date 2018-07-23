Received: from eggs.gnu.org ([2001:4830:134:3::10]:42677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKB-0003Q4-St
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKA-00056V-QR
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:55 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:14 -0500
Message-Id: <20180723201748.25573-66-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 65/99] softfloat: Handle default NaN mode after
 pickNaNMulAdd, not before
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180504100547.14621-1-peter.maydell@linaro.org
(cherry picked from commit 1839189bbf89889076aadf0c793c1b57977b28d7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 fpu/softfloat.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

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
 
+    which = pickNaNMulAdd(is_qnan(a.cls), is_snan(a.cls),
+                          is_qnan(b.cls), is_snan(b.cls),
+                          is_qnan(c.cls), is_snan(c.cls),
+                          inf_zero, s);
+
     if (s->default_nan_mode) {
+        /* Note that this check is after pickNaNMulAdd so that function
+         * has an opportunity to set the Invalid flag.
+         */
         a.cls = float_class_dnan;
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
+        return a;
+    }
 
-        a.cls = float_class_msnan;
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
     }
+    a.cls = float_class_msnan;
+
     return a;
 }
 
-- 
2.17.1
