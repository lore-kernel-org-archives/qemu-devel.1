Received: from eggs.gnu.org ([209.51.188.92]:37731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvi16-0003Xg-QA
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:27:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvi14-0004Et-VP
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:27:24 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 13:26:56 +0100
Message-Id: <20190218122710.23639-2-david@redhat.com>
In-Reply-To: <20190218122710.23639-1-david@redhat.com>
References: <20190218122710.23639-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/15] s390x/tcg: Fix TEST DATA CLASS
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

Let's detect normal and denormal ("subnormal") numbers reliably. Also
test for quiet NaN's. As only one class is possible, test common cases
first.

While at it, use a better check to test for the mask bits in the data
class mask. The data class mask has 12 bits, whereby bit 0 is the
leftmost bit and bit 11 the rightmost bit. In the PoP an easy to read
table with the numbers is provided for the VECTOR FP TEST DATA CLASS
IMMEDIATE instruction, the table for TEST DATA CLASS is more confusing
as it is based on 64 bit values.

Factor the checks out into separate functions, as they will also be
needed for floating point vector instructions. We can use a makro to
generate the functions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 85 ++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 50 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index e921172bc4..0e9247bf7e 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -645,67 +645,52 @@ uint64_t HELPER(msdb)(CPUS390XState *env, uint64_t f1,
     return ret;
 }
 
+/* The rightmost bit has the number 11. */
+static inline uint16_t dcmask(int bit, bool neg)
+{
+    return 1 << (11 - bit - neg);
+}
+
+#define DEF_FLOAT_DCMASK(_TYPE) \
+static uint16_t _TYPE##_dcmask(CPUS390XState *env, _TYPE f1)       \
+{                                                                  \
+    const bool neg = _TYPE##_is_neg(f1);                           \
+                                                                   \
+    /* Sorted by most common cases - only one class is possible */ \
+    if (_TYPE##_is_normal(f1)) {                                   \
+        return dcmask(2, neg);                                     \
+    } else if (_TYPE##_is_zero(f1)) {                              \
+        return dcmask(0, neg);                                     \
+    } else if (_TYPE##_is_denormal(f1)) {                          \
+        return dcmask(4, neg);                                     \
+    } else if (_TYPE##_is_infinity(f1)) {                          \
+        return dcmask(6, neg);                                     \
+    } else if (_TYPE##_is_quiet_nan(f1, &env->fpu_status)) {       \
+        return dcmask(8, neg);                                     \
+    }                                                              \
+    /* signaling nan, as last remaining case */                    \
+    return dcmask(10, neg);                                        \
+}
+DEF_FLOAT_DCMASK(float32)
+DEF_FLOAT_DCMASK(float64)
+DEF_FLOAT_DCMASK(float128)
+
 /* test data class 32-bit */
 uint32_t HELPER(tceb)(CPUS390XState *env, uint64_t f1, uint64_t m2)
 {
-    float32 v1 = f1;
-    int neg = float32_is_neg(v1);
-    uint32_t cc = 0;
-
-    if ((float32_is_zero(v1) && (m2 & (1 << (11-neg)))) ||
-        (float32_is_infinity(v1) && (m2 & (1 << (5-neg)))) ||
-        (float32_is_any_nan(v1) && (m2 & (1 << (3-neg)))) ||
-        (float32_is_signaling_nan(v1, &env->fpu_status) &&
-         (m2 & (1 << (1-neg))))) {
-        cc = 1;
-    } else if (m2 & (1 << (9-neg))) {
-        /* assume normalized number */
-        cc = 1;
-    }
-    /* FIXME: denormalized? */
-    return cc;
+    return (m2 & float32_dcmask(env, f1)) != 0;
 }
 
 /* test data class 64-bit */
 uint32_t HELPER(tcdb)(CPUS390XState *env, uint64_t v1, uint64_t m2)
 {
-    int neg = float64_is_neg(v1);
-    uint32_t cc = 0;
-
-    if ((float64_is_zero(v1) && (m2 & (1 << (11-neg)))) ||
-        (float64_is_infinity(v1) && (m2 & (1 << (5-neg)))) ||
-        (float64_is_any_nan(v1) && (m2 & (1 << (3-neg)))) ||
-        (float64_is_signaling_nan(v1, &env->fpu_status) &&
-         (m2 & (1 << (1-neg))))) {
-        cc = 1;
-    } else if (m2 & (1 << (9-neg))) {
-        /* assume normalized number */
-        cc = 1;
-    }
-    /* FIXME: denormalized? */
-    return cc;
+    return (m2 & float64_dcmask(env, v1)) != 0;
 }
 
 /* test data class 128-bit */
-uint32_t HELPER(tcxb)(CPUS390XState *env, uint64_t ah,
-                      uint64_t al, uint64_t m2)
-{
-    float128 v1 = make_float128(ah, al);
-    int neg = float128_is_neg(v1);
-    uint32_t cc = 0;
-
-    if ((float128_is_zero(v1) && (m2 & (1 << (11-neg)))) ||
-        (float128_is_infinity(v1) && (m2 & (1 << (5-neg)))) ||
-        (float128_is_any_nan(v1) && (m2 & (1 << (3-neg)))) ||
-        (float128_is_signaling_nan(v1, &env->fpu_status) &&
-         (m2 & (1 << (1-neg))))) {
-        cc = 1;
-    } else if (m2 & (1 << (9-neg))) {
-        /* assume normalized number */
-        cc = 1;
-    }
-    /* FIXME: denormalized? */
-    return cc;
+uint32_t HELPER(tcxb)(CPUS390XState *env, uint64_t ah, uint64_t al, uint64_t m2)
+{
+    return (m2 & float128_dcmask(env, make_float128(ah, al))) != 0;
 }
 
 /* square root 32-bit */
-- 
2.17.2
