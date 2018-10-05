Received: from eggs.gnu.org ([2001:4830:134:3::10]:38628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UQg-0000Wv-K9
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UQd-0004vB-Km
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:22 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8UQc-0004KX-KN
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:19 -0400
Received: by mail-oi1-x244.google.com with SMTP id s69-v6so11088230oie.10
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 11:02:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Oct 2018 13:01:58 -0500
Message-Id: <20181005180201.11387-6-richard.henderson@linaro.org>
In-Reply-To: <20181005180201.11387-1-richard.henderson@linaro.org>
References: <20181005180201.11387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/8] softfloat: Fix division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The __udiv_qrnnd primitive that we nicked from gmp requires its
inputs to be normalized.  We were not doing that.  Because the
inputs are nearly normalized already, finishing that is trivial.

Replace div128to64 with a "proper" udiv_qrnnd, so that this
remains a reusable primitive.

Fixes: cf07323d494
Fixes: https://bugs.launchpad.net/qemu/+bug/1793119
Tested-by: Emilio G. Cota <cota@braap.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 34 ++++++++++++++++++++++++---------
 fpu/softfloat.c                | 35 ++++++++++++++++++++++++++--------
 2 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index edc682139e..a1d99c730d 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -329,15 +329,30 @@ static inline void
 | pieces which are stored at the locations pointed to by `z0Ptr' and `z1Ptr'.
 *----------------------------------------------------------------------------*/
 
-static inline void
- shortShift128Left(
-     uint64_t a0, uint64_t a1, int count, uint64_t *z0Ptr, uint64_t *z1Ptr)
+static inline void shortShift128Left(uint64_t a0, uint64_t a1, int count,
+                                     uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
+    *z1Ptr = a1 << count;
+    *z0Ptr = count == 0 ? a0 : (a0 << count) | (a1 >> (-count & 63));
+}
 
-    *z1Ptr = a1<<count;
-    *z0Ptr =
-        ( count == 0 ) ? a0 : ( a0<<count ) | ( a1>>( ( - count ) & 63 ) );
+/*----------------------------------------------------------------------------
+| Shifts the 128-bit value formed by concatenating `a0' and `a1' left by the
+| number of bits given in `count'.  Any bits shifted off are lost.  The value
+| of `count' may be greater than 64.  The result is broken into two 64-bit
+| pieces which are stored at the locations pointed to by `z0Ptr' and `z1Ptr'.
+*----------------------------------------------------------------------------*/
 
+static inline void shift128Left(uint64_t a0, uint64_t a1, int count,
+                                uint64_t *z0Ptr, uint64_t *z1Ptr)
+{
+    if (count < 64) {
+        *z1Ptr = a1 << count;
+        *z0Ptr = count == 0 ? a0 : (a0 << count) | (a1 >> (-count & 63));
+    } else {
+        *z1Ptr = 0;
+        *z0Ptr = a1 << (count - 64);
+    }
 }
 
 /*----------------------------------------------------------------------------
@@ -619,7 +634,8 @@ static inline uint64_t estimateDiv128To64(uint64_t a0, uint64_t a1, uint64_t b)
  *
  * Licensed under the GPLv2/LGPLv3
  */
-static inline uint64_t div128To64(uint64_t n0, uint64_t n1, uint64_t d)
+static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
+                                  uint64_t n0, uint64_t d)
 {
     uint64_t d0, d1, q0, q1, r1, r0, m;
 
@@ -658,8 +674,8 @@ static inline uint64_t div128To64(uint64_t n0, uint64_t n1, uint64_t d)
     }
     r0 -= m;
 
-    /* Return remainder in LSB */
-    return (q1 << 32) | q0 | (r0 != 0);
+    *r = r0;
+    return (q1 << 32) | q0;
 }
 
 /*----------------------------------------------------------------------------
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 71da0f68bb..46ae206172 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1112,19 +1112,38 @@ static FloatParts div_floats(FloatParts a, FloatParts b, float_status *s)
     bool sign = a.sign ^ b.sign;
 
     if (a.cls == float_class_normal && b.cls == float_class_normal) {
-        uint64_t temp_lo, temp_hi;
+        uint64_t n0, n1, q, r;
         int exp = a.exp - b.exp;
+
+        /*
+         * We want a 2*N / N-bit division to produce exactly an N-bit
+         * result, so that we do not lose any precision and so that we
+         * do not have to renormalize afterward.  If A.frac < B.frac,
+         * then division would produce an (N-1)-bit result; shift A left
+         * by one to produce the an N-bit result, and decrement the
+         * exponent to match.
+         *
+         * The udiv_qrnnd algorithm that we're using requires normalization,
+         * i.e. the msb of the denominator must be set.  Since we know that
+         * DECOMPOSED_BINARY_POINT is msb-1, the inputs must be shifted left
+         * by one (more), and the remainder must be shifted right by one.
+         */
         if (a.frac < b.frac) {
             exp -= 1;
-            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT + 1,
-                              &temp_hi, &temp_lo);
+            shift128Left(0, a.frac, DECOMPOSED_BINARY_POINT + 2, &n1, &n0);
         } else {
-            shortShift128Left(0, a.frac, DECOMPOSED_BINARY_POINT,
-                              &temp_hi, &temp_lo);
+            shift128Left(0, a.frac, DECOMPOSED_BINARY_POINT + 1, &n1, &n0);
         }
-        /* LSB of quot is set if inexact which roundandpack will use
-         * to set flags. Yet again we re-use a for the result */
-        a.frac = div128To64(temp_lo, temp_hi, b.frac);
+        q = udiv_qrnnd(&r, n1, n0, b.frac << 1);
+
+        /*
+         * Set lsb if there is a remainder, to set inexact.
+         * As mentioned above, to find the actual value of the remainder we
+         * would need to shift right, but (1) we are only concerned about
+         * non-zero-ness, and (2) the remainder will always be even because
+         * both inputs to the division primitive are even.
+         */
+        a.frac = q | (r != 0);
         a.sign = sign;
         a.exp = exp;
         return a;
-- 
2.17.1
