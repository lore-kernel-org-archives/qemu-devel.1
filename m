Received: from eggs.gnu.org ([2001:4830:134:3::10]:44049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDVlJ-0003RS-W8
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDVlI-00081F-OF
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:56:10 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  1 May 2018 15:55:46 +0200
Message-Id: <20180501135547.12414-4-laurent@vivier.eu>
In-Reply-To: <20180501135547.12414-1-laurent@vivier.eu>
References: <20180501135547.12414-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 3/4] m68k: remove dead code (Coverity CID1390617)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, Michael Tokarev <mjt@tls.msk.ru>

floatx80_sin() and floatx80_cos() are derived from one
sincos() function. They have both unused code coming from
their common origin. Remove it.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180430170156.1860-2-laurent@vivier.eu>
---
 target/m68k/softfloat.c | 43 ++++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 2c069a5efb..e41b07d042 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -1497,7 +1497,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
     int32_t compact, l, n, j;
     floatx80 fp0, fp1, fp2, fp3, fp4, fp5, x, invtwopi, twopi1, twopi2;
     float32 posneg1, twoto63;
-    flag adjn, endflag;
+    flag endflag;
 
     aSig = extractFloatx80Frac(a);
     aExp = extractFloatx80Exp(a);
@@ -1515,8 +1515,6 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
         return packFloatx80(aSign, 0, 0);
     }
 
-    adjn = 0;
-
     user_rnd_mode = status->float_rounding_mode;
     user_rnd_prec = status->floatx80_rounding_precision;
     status->float_rounding_mode = float_round_nearest_even;
@@ -1591,14 +1589,8 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             status->float_rounding_mode = user_rnd_mode;
             status->floatx80_rounding_precision = user_rnd_prec;
 
-            if (adjn) {
-                /* COSTINY */
-                a = floatx80_sub(fp0, float32_to_floatx80(
-                                 make_float32(0x00800000), status), status);
-            } else {
-                /* SINTINY */
-                a = floatx80_move(a, status);
-            }
+            /* SINTINY */
+            a = floatx80_move(a, status);
             float_raise(float_flag_inexact, status);
 
             return a;
@@ -1616,7 +1608,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
                            status); /* FP0 IS R = (X-Y1)-Y2 */
 
     sincont:
-        if ((n + adjn) & 1) {
+        if (n & 1) {
             /* COSPOLY */
             fp0 = floatx80_mul(fp0, fp0, status); /* FP0 IS S */
             fp1 = floatx80_mul(fp0, fp0, status); /* FP1 IS T */
@@ -1629,7 +1621,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             xExp = extractFloatx80Exp(fp0);
             xSig = extractFloatx80Frac(fp0);
 
-            if (((n + adjn) >> 1) & 1) {
+            if ((n >> 1) & 1) {
                 xSign ^= 1;
                 posneg1 = make_float32(0xBF800000); /* -1 */
             } else {
@@ -1681,7 +1673,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             xExp = extractFloatx80Exp(fp0);
             xSig = extractFloatx80Frac(fp0);
 
-            xSign ^= ((n + adjn) >> 1) & 1; /* X IS NOW R'= SGN*R */
+            xSign ^= (n >> 1) & 1; /* X IS NOW R'= SGN*R */
 
             fp0 = floatx80_mul(fp0, fp0, status); /* FP0 IS S */
             fp1 = floatx80_mul(fp0, fp0, status); /* FP1 IS T */
@@ -1744,7 +1736,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
     int32_t compact, l, n, j;
     floatx80 fp0, fp1, fp2, fp3, fp4, fp5, x, invtwopi, twopi1, twopi2;
     float32 posneg1, twoto63;
-    flag adjn, endflag;
+    flag endflag;
 
     aSig = extractFloatx80Frac(a);
     aExp = extractFloatx80Exp(a);
@@ -1762,8 +1754,6 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
         return packFloatx80(0, one_exp, one_sig);
     }
 
-    adjn = 1;
-
     user_rnd_mode = status->float_rounding_mode;
     user_rnd_prec = status->floatx80_rounding_precision;
     status->float_rounding_mode = float_round_nearest_even;
@@ -1837,15 +1827,10 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             status->float_rounding_mode = user_rnd_mode;
             status->floatx80_rounding_precision = user_rnd_prec;
 
-            if (adjn) {
-                /* COSTINY */
-                a = floatx80_sub(fp0, float32_to_floatx80(
-                                 make_float32(0x00800000), status),
-                                 status);
-            } else {
-                /* SINTINY */
-                a = floatx80_move(a, status);
-            }
+            /* COSTINY */
+            a = floatx80_sub(fp0, float32_to_floatx80(
+                             make_float32(0x00800000), status),
+                             status);
             float_raise(float_flag_inexact, status);
 
             return a;
@@ -1863,7 +1848,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
                            status); /* FP0 IS R = (X-Y1)-Y2 */
 
     sincont:
-        if ((n + adjn) & 1) {
+        if ((n + 1) & 1) {
             /* COSPOLY */
             fp0 = floatx80_mul(fp0, fp0, status); /* FP0 IS S */
             fp1 = floatx80_mul(fp0, fp0, status); /* FP1 IS T */
@@ -1876,7 +1861,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             xExp = extractFloatx80Exp(fp0);
             xSig = extractFloatx80Frac(fp0);
 
-            if (((n + adjn) >> 1) & 1) {
+            if (((n + 1) >> 1) & 1) {
                 xSign ^= 1;
                 posneg1 = make_float32(0xBF800000); /* -1 */
             } else {
@@ -1927,7 +1912,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             xExp = extractFloatx80Exp(fp0);
             xSig = extractFloatx80Frac(fp0);
 
-            xSign ^= ((n + adjn) >> 1) & 1; /* X IS NOW R'= SGN*R */
+            xSign ^= ((n + 1) >> 1) & 1; /* X IS NOW R'= SGN*R */
 
             fp0 = floatx80_mul(fp0, fp0, status); /* FP0 IS S */
             fp1 = floatx80_mul(fp0, fp0, status); /* FP1 IS T */
-- 
2.14.3
