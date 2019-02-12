Received: from eggs.gnu.org ([209.51.188.92]:53461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVql-0005oZ-D9
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVqd-0002Np-3T
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:37 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 12 Feb 2019 12:02:54 +0100
Message-Id: <20190212110308.13707-3-david@redhat.com>
In-Reply-To: <20190212110308.13707-1-david@redhat.com>
References: <20190212110308.13707-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 01/15] s390x/tcg: Fix TEST DATA CLASS
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
test for quiet NaN's.

While at it, use a better check to test for the mask bits in the data
class mask. The data class mask has 12 bits, whereby bit 0 is the
leftmost bit and bit 11 the rightmost bit. In the PoP an easy to read
table with the numbers is provided for the VECTOR FP TEST DATA CLASS
IMMEDIATE instruction, the table for TEST DATA CLASS is more confusing
as it is based on 64 bit values.

Factor the checks out into separate functions, as they will also be
needed for floating point vector instructions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 96 ++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index e921172bc4..a3214bd546 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -645,66 +645,100 @@ uint64_t HELPER(msdb)(CPUS390XState *env, uint64_t f1,
     return ret;
 }
 
+/*
+ * The rightmost 12 bits are the mask. The rightmost bit has the number 11.
+ */
+static inline bool test_dc_mask(uint16_t dc_mask, int bit, bool neg)
+{
+    return dc_mask & (1 << (11 - bit - neg));
+}
+
+static bool s390_tdc32(CPUS390XState *env, float32 f1, uint16_t dc_mask)
+{
+        const bool neg = float32_is_neg(f1);
+        const bool zero = float32_is_zero(f1);
+        const bool normal = float32_is_normal(f1);
+        const bool denormal = float32_is_denormal(f1);
+        const bool infinity = float32_is_infinity(f1);
+        const bool quiet_nan = float32_is_quiet_nan(f1, &env->fpu_status);
+        const bool sig_nan = float32_is_signaling_nan(f1, &env->fpu_status);
+
+        return (zero && test_dc_mask(dc_mask, 0, neg)) ||
+               (normal && test_dc_mask(dc_mask, 2, neg)) ||
+               (denormal && test_dc_mask(dc_mask, 4, neg)) ||
+               (infinity && test_dc_mask(dc_mask, 6, neg)) ||
+               (quiet_nan && test_dc_mask(dc_mask, 8, neg)) ||
+               (sig_nan && test_dc_mask(dc_mask, 10, neg));
+}
+
 /* test data class 32-bit */
 uint32_t HELPER(tceb)(CPUS390XState *env, uint64_t f1, uint64_t m2)
 {
-    float32 v1 = f1;
-    int neg = float32_is_neg(v1);
     uint32_t cc = 0;
 
-    if ((float32_is_zero(v1) && (m2 & (1 << (11-neg)))) ||
-        (float32_is_infinity(v1) && (m2 & (1 << (5-neg)))) ||
-        (float32_is_any_nan(v1) && (m2 & (1 << (3-neg)))) ||
-        (float32_is_signaling_nan(v1, &env->fpu_status) &&
-         (m2 & (1 << (1-neg))))) {
-        cc = 1;
-    } else if (m2 & (1 << (9-neg))) {
-        /* assume normalized number */
+    if (s390_tdc32(env, f1, m2)) {
         cc = 1;
     }
-    /* FIXME: denormalized? */
     return cc;
 }
 
+static bool s390_tdc64(CPUS390XState *env, float64 f1, uint16_t dc_mask)
+{
+        const bool neg = float64_is_neg(f1);
+        const bool zero = float64_is_zero(f1);
+        const bool normal = float64_is_normal(f1);
+        const bool denormal = float64_is_denormal(f1);
+        const bool infinity = float64_is_infinity(f1);
+        const bool quiet_nan = float64_is_quiet_nan(f1, &env->fpu_status);
+        const bool sig_nan = float64_is_signaling_nan(f1, &env->fpu_status);
+
+        return (zero && test_dc_mask(dc_mask, 0, neg)) ||
+               (normal && test_dc_mask(dc_mask, 2, neg)) ||
+               (denormal && test_dc_mask(dc_mask, 4, neg)) ||
+               (infinity && test_dc_mask(dc_mask, 6, neg)) ||
+               (quiet_nan && test_dc_mask(dc_mask, 8, neg)) ||
+               (sig_nan && test_dc_mask(dc_mask, 10, neg));
+}
+
 /* test data class 64-bit */
 uint32_t HELPER(tcdb)(CPUS390XState *env, uint64_t v1, uint64_t m2)
 {
-    int neg = float64_is_neg(v1);
     uint32_t cc = 0;
 
-    if ((float64_is_zero(v1) && (m2 & (1 << (11-neg)))) ||
-        (float64_is_infinity(v1) && (m2 & (1 << (5-neg)))) ||
-        (float64_is_any_nan(v1) && (m2 & (1 << (3-neg)))) ||
-        (float64_is_signaling_nan(v1, &env->fpu_status) &&
-         (m2 & (1 << (1-neg))))) {
-        cc = 1;
-    } else if (m2 & (1 << (9-neg))) {
-        /* assume normalized number */
+    if (s390_tdc64(env, v1, m2)) {
         cc = 1;
     }
-    /* FIXME: denormalized? */
     return cc;
 }
 
+static bool s390_tdc128(CPUS390XState *env, float128 f1, uint16_t dc_mask)
+{
+        const bool neg = float128_is_neg(f1);
+        const bool zero = float128_is_zero(f1);
+        const bool normal = float128_is_normal(f1);
+        const bool denormal = float128_is_denormal(f1);
+        const bool infinity = float128_is_infinity(f1);
+        const bool quiet_nan = float128_is_quiet_nan(f1, &env->fpu_status);
+        const bool sig_nan = float128_is_signaling_nan(f1, &env->fpu_status);
+
+        return (zero && test_dc_mask(dc_mask, 0, neg)) ||
+               (normal && test_dc_mask(dc_mask, 2, neg)) ||
+               (denormal && test_dc_mask(dc_mask, 4, neg)) ||
+               (infinity && test_dc_mask(dc_mask, 6, neg)) ||
+               (quiet_nan && test_dc_mask(dc_mask, 8, neg)) ||
+               (sig_nan && test_dc_mask(dc_mask, 10, neg));
+}
+
 /* test data class 128-bit */
 uint32_t HELPER(tcxb)(CPUS390XState *env, uint64_t ah,
                       uint64_t al, uint64_t m2)
 {
     float128 v1 = make_float128(ah, al);
-    int neg = float128_is_neg(v1);
     uint32_t cc = 0;
 
-    if ((float128_is_zero(v1) && (m2 & (1 << (11-neg)))) ||
-        (float128_is_infinity(v1) && (m2 & (1 << (5-neg)))) ||
-        (float128_is_any_nan(v1) && (m2 & (1 << (3-neg)))) ||
-        (float128_is_signaling_nan(v1, &env->fpu_status) &&
-         (m2 & (1 << (1-neg))))) {
-        cc = 1;
-    } else if (m2 & (1 << (9-neg))) {
-        /* assume normalized number */
+    if (s390_tdc128(env, v1, m2)) {
         cc = 1;
     }
-    /* FIXME: denormalized? */
     return cc;
 }
 
-- 
2.17.2
