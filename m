Received: from eggs.gnu.org ([209.51.188.92]:39687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtvbu-00007K-Vq
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtvbr-0002MK-7W
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:34:02 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 13 Feb 2019 15:33:18 +0100
Message-Id: <20190213143322.31371-12-david@redhat.com>
In-Reply-To: <20190213143322.31371-1-david@redhat.com>
References: <20190213143322.31371-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/15] s390x/tcg: Prepare for
 IEEE-inexact-exception control (XxC)
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

Some instructions allow to suppress IEEE inexact exceptions.

z14 PoP, 9-23, "Suppression of Certain IEEE Exceptions"
    IEEE-inexact-exception control (XxC): Bit 1 of
    the M4 field is the XxC bit. If XxC is zero, recogni-
    tion of IEEE-inexact exception is not suppressed;
    if XxC is one, recognition of IEEE-inexact excep-
    tion is suppressed.

Especially, handling for overflow/unerflow remains as is, inexact is
reported along

z14 PoP, 9-23, "Suppression of Certain IEEE Exceptions"
    For example, the IEEE-inexact-exception control (XxC)
    has no effect on the DXC; that is, the DXC for IEEE-
    overflow or IEEE-underflow exceptions along with the
    detail for exact, inexact and truncated, or inexact and
    incremented, is reported according to the actual con-
    dition.

Follow up patches will wire it correctly up for the applicable
instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 114 +++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 0cd6e19ce8..f6f010ae35 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -50,7 +50,7 @@ uint8_t s390_softfloat_exc_to_ieee(unsigned int exc)
 }
 
 /* Should be called after any operation that may raise IEEE exceptions.  */
-static void handle_exceptions(CPUS390XState *env, uintptr_t retaddr)
+static void handle_exceptions(CPUS390XState *env, bool XxC, uintptr_t retaddr)
 {
     unsigned s390_exc, qemu_exc;
 
@@ -101,7 +101,7 @@ static void handle_exceptions(CPUS390XState *env, uintptr_t retaddr)
     }
 
     /* inexact handling */
-    if (s390_exc & S390_IEEE_MASK_INEXACT) {
+    if (s390_exc & S390_IEEE_MASK_INEXACT && !XxC) {
         /* trap condition - overflow/underflow _not_ reported along */
         if (s390_exc & S390_IEEE_MASK_INEXACT & env->fpc >> 24) {
             tcg_s390_data_exception(env, s390_exc & S390_IEEE_MASK_INEXACT,
@@ -174,7 +174,7 @@ uint32_t set_cc_nz_f128(float128 v)
 uint64_t HELPER(aeb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     float32 ret = float32_add(f1, f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -182,7 +182,7 @@ uint64_t HELPER(aeb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 uint64_t HELPER(adb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     float64 ret = float64_add(f1, f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -193,7 +193,7 @@ uint64_t HELPER(axb)(CPUS390XState *env, uint64_t ah, uint64_t al,
     float128 ret = float128_add(make_float128(ah, al),
                                 make_float128(bh, bl),
                                 &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return RET128(ret);
 }
 
@@ -201,7 +201,7 @@ uint64_t HELPER(axb)(CPUS390XState *env, uint64_t ah, uint64_t al,
 uint64_t HELPER(seb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     float32 ret = float32_sub(f1, f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -209,7 +209,7 @@ uint64_t HELPER(seb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 uint64_t HELPER(sdb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     float64 ret = float64_sub(f1, f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -220,7 +220,7 @@ uint64_t HELPER(sxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
     float128 ret = float128_sub(make_float128(ah, al),
                                 make_float128(bh, bl),
                                 &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return RET128(ret);
 }
 
@@ -228,7 +228,7 @@ uint64_t HELPER(sxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
 uint64_t HELPER(deb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     float32 ret = float32_div(f1, f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -236,7 +236,7 @@ uint64_t HELPER(deb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 uint64_t HELPER(ddb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     float64 ret = float64_div(f1, f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -247,7 +247,7 @@ uint64_t HELPER(dxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
     float128 ret = float128_div(make_float128(ah, al),
                                 make_float128(bh, bl),
                                 &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return RET128(ret);
 }
 
@@ -255,7 +255,7 @@ uint64_t HELPER(dxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
 uint64_t HELPER(meeb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     float32 ret = float32_mul(f1, f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -263,7 +263,7 @@ uint64_t HELPER(meeb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 uint64_t HELPER(mdb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     float64 ret = float64_mul(f1, f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -272,7 +272,7 @@ uint64_t HELPER(mdeb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     float64 ret = float32_to_float64(f2, &env->fpu_status);
     ret = float64_mul(f1, ret, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -283,7 +283,7 @@ uint64_t HELPER(mxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
     float128 ret = float128_mul(make_float128(ah, al),
                                 make_float128(bh, bl),
                                 &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return RET128(ret);
 }
 
@@ -293,7 +293,7 @@ uint64_t HELPER(mxdb)(CPUS390XState *env, uint64_t ah, uint64_t al,
 {
     float128 ret = float64_to_float128(f2, &env->fpu_status);
     ret = float128_mul(make_float128(ah, al), ret, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return RET128(ret);
 }
 
@@ -301,7 +301,7 @@ uint64_t HELPER(mxdb)(CPUS390XState *env, uint64_t ah, uint64_t al,
 uint64_t HELPER(ldeb)(CPUS390XState *env, uint64_t f2)
 {
     float64 ret = float32_to_float64(f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -309,7 +309,7 @@ uint64_t HELPER(ldeb)(CPUS390XState *env, uint64_t f2)
 uint64_t HELPER(ldxb)(CPUS390XState *env, uint64_t ah, uint64_t al)
 {
     float64 ret = float128_to_float64(make_float128(ah, al), &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -317,7 +317,7 @@ uint64_t HELPER(ldxb)(CPUS390XState *env, uint64_t ah, uint64_t al)
 uint64_t HELPER(lxdb)(CPUS390XState *env, uint64_t f2)
 {
     float128 ret = float64_to_float128(f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return RET128(ret);
 }
 
@@ -325,7 +325,7 @@ uint64_t HELPER(lxdb)(CPUS390XState *env, uint64_t f2)
 uint64_t HELPER(lxeb)(CPUS390XState *env, uint64_t f2)
 {
     float128 ret = float32_to_float128(f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return RET128(ret);
 }
 
@@ -333,7 +333,7 @@ uint64_t HELPER(lxeb)(CPUS390XState *env, uint64_t f2)
 uint64_t HELPER(ledb)(CPUS390XState *env, uint64_t f2)
 {
     float32 ret = float64_to_float32(f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -341,7 +341,7 @@ uint64_t HELPER(ledb)(CPUS390XState *env, uint64_t f2)
 uint64_t HELPER(lexb)(CPUS390XState *env, uint64_t ah, uint64_t al)
 {
     float32 ret = float128_to_float32(make_float128(ah, al), &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -349,7 +349,7 @@ uint64_t HELPER(lexb)(CPUS390XState *env, uint64_t ah, uint64_t al)
 uint32_t HELPER(ceb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     int cmp = float32_compare_quiet(f1, f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return float_comp_to_cc(env, cmp);
 }
 
@@ -357,7 +357,7 @@ uint32_t HELPER(ceb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 uint32_t HELPER(cdb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     int cmp = float64_compare_quiet(f1, f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return float_comp_to_cc(env, cmp);
 }
 
@@ -368,7 +368,7 @@ uint32_t HELPER(cxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
     int cmp = float128_compare_quiet(make_float128(ah, al),
                                      make_float128(bh, bl),
                                      &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return float_comp_to_cc(env, cmp);
 }
 
@@ -413,7 +413,7 @@ uint64_t HELPER(cegb)(CPUS390XState *env, int64_t v2, uint32_t m3)
     float32 ret = int64_to_float32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -424,7 +424,7 @@ uint64_t HELPER(cdgb)(CPUS390XState *env, int64_t v2, uint32_t m3)
     float64 ret = int64_to_float64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -435,7 +435,7 @@ uint64_t HELPER(cxgb)(CPUS390XState *env, int64_t v2, uint32_t m3)
     float128 ret = int64_to_float128(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return RET128(ret);
 }
 
@@ -446,7 +446,7 @@ uint64_t HELPER(celgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
     float32 ret = uint64_to_float32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -457,7 +457,7 @@ uint64_t HELPER(cdlgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
     float64 ret = uint64_to_float64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -468,7 +468,7 @@ uint64_t HELPER(cxlgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
     float128 ret = uint64_to_float128(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return RET128(ret);
 }
 
@@ -479,7 +479,7 @@ uint64_t HELPER(cgeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
     int64_t ret = float32_to_int64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -490,7 +490,7 @@ uint64_t HELPER(cgdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
     int64_t ret = float64_to_int64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -502,7 +502,7 @@ uint64_t HELPER(cgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
     int64_t ret = float128_to_int64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -513,7 +513,7 @@ uint64_t HELPER(cfeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
     int32_t ret = float32_to_int32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -524,7 +524,7 @@ uint64_t HELPER(cfdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
     int32_t ret = float64_to_int32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -536,7 +536,7 @@ uint64_t HELPER(cfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
     int32_t ret = float128_to_int32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -549,7 +549,7 @@ uint64_t HELPER(clgeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
     v2 = float32_to_float64(v2, &env->fpu_status);
     ret = float64_to_uint64(v2, &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -560,7 +560,7 @@ uint64_t HELPER(clgdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
     uint64_t ret = float64_to_uint64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -571,7 +571,7 @@ uint64_t HELPER(clgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
     uint64_t ret = float128_to_uint64(make_float128(h, l), &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -582,7 +582,7 @@ uint64_t HELPER(clfeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
     uint32_t ret = float32_to_uint32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -593,7 +593,7 @@ uint64_t HELPER(clfdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
     uint32_t ret = float64_to_uint32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -604,7 +604,7 @@ uint64_t HELPER(clfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
     uint32_t ret = float128_to_uint32(make_float128(h, l), &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -615,7 +615,7 @@ uint64_t HELPER(fieb)(CPUS390XState *env, uint64_t f2, uint32_t m3)
     float32 ret = float32_round_to_int(f2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -626,7 +626,7 @@ uint64_t HELPER(fidb)(CPUS390XState *env, uint64_t f2, uint32_t m3)
     float64 ret = float64_round_to_int(f2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -634,11 +634,11 @@ uint64_t HELPER(fidb)(CPUS390XState *env, uint64_t f2, uint32_t m3)
 uint64_t HELPER(fixb)(CPUS390XState *env, uint64_t ah, uint64_t al, uint32_t m3)
 {
     int old_mode = s390_swap_bfp_rounding_mode(env, m3);
-
     float128 ret = float128_round_to_int(make_float128(ah, al),
                                          &env->fpu_status);
+
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return RET128(ret);
 }
 
@@ -646,7 +646,7 @@ uint64_t HELPER(fixb)(CPUS390XState *env, uint64_t ah, uint64_t al, uint32_t m3)
 uint32_t HELPER(keb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     int cmp = float32_compare(f1, f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return float_comp_to_cc(env, cmp);
 }
 
@@ -654,7 +654,7 @@ uint32_t HELPER(keb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 uint32_t HELPER(kdb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
     int cmp = float64_compare(f1, f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return float_comp_to_cc(env, cmp);
 }
 
@@ -665,7 +665,7 @@ uint32_t HELPER(kxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
     int cmp = float128_compare(make_float128(ah, al),
                                make_float128(bh, bl),
                                &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return float_comp_to_cc(env, cmp);
 }
 
@@ -674,7 +674,7 @@ uint64_t HELPER(maeb)(CPUS390XState *env, uint64_t f1,
                       uint64_t f2, uint64_t f3)
 {
     float32 ret = float32_muladd(f2, f3, f1, 0, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -683,7 +683,7 @@ uint64_t HELPER(madb)(CPUS390XState *env, uint64_t f1,
                       uint64_t f2, uint64_t f3)
 {
     float64 ret = float64_muladd(f2, f3, f1, 0, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -693,7 +693,7 @@ uint64_t HELPER(mseb)(CPUS390XState *env, uint64_t f1,
 {
     float32 ret = float32_muladd(f2, f3, f1, float_muladd_negate_c,
                                  &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -703,7 +703,7 @@ uint64_t HELPER(msdb)(CPUS390XState *env, uint64_t f1,
 {
     float64 ret = float64_muladd(f2, f3, f1, float_muladd_negate_c,
                                  &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -759,7 +759,7 @@ uint32_t HELPER(tcxb)(CPUS390XState *env, uint64_t ah, uint64_t al, uint64_t m2)
 uint64_t HELPER(sqeb)(CPUS390XState *env, uint64_t f2)
 {
     float32 ret = float32_sqrt(f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -767,7 +767,7 @@ uint64_t HELPER(sqeb)(CPUS390XState *env, uint64_t f2)
 uint64_t HELPER(sqdb)(CPUS390XState *env, uint64_t f2)
 {
     float64 ret = float64_sqrt(f2, &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return ret;
 }
 
@@ -775,7 +775,7 @@ uint64_t HELPER(sqdb)(CPUS390XState *env, uint64_t f2)
 uint64_t HELPER(sqxb)(CPUS390XState *env, uint64_t ah, uint64_t al)
 {
     float128 ret = float128_sqrt(make_float128(ah, al), &env->fpu_status);
-    handle_exceptions(env, GETPC());
+    handle_exceptions(env, false, GETPC());
     return RET128(ret);
 }
 
-- 
2.17.2
