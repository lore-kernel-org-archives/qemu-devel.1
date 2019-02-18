Received: from eggs.gnu.org ([209.51.188.92]:38006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvi1S-0003pq-Vh
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvi1Q-0004SK-T0
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:27:46 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 13:27:05 +0100
Message-Id: <20190218122710.23639-11-david@redhat.com>
In-Reply-To: <20190218122710.23639-1-david@redhat.com>
References: <20190218122710.23639-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/15] s390x/tcg: Refactor saving/restoring
 the bfp rounding mode
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

We want to reuse this in the context of vector instructions. So use
better matching names and introduce s390_restore_bfp_rounding_mode().

While at it, add proper newlines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 112 +++++++++++++++++++++++---------------
 target/s390x/internal.h   |   2 +
 2 files changed, 71 insertions(+), 43 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index ed9c74c420..8baca14650 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -372,7 +372,7 @@ uint32_t HELPER(cxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
     return float_comp_to_cc(env, cmp);
 }
 
-static int swap_round_mode(CPUS390XState *env, int m3)
+int s390_swap_bfp_rounding_mode(CPUS390XState *env, int m3)
 {
     int ret = env->fpu_status.float_rounding_mode;
     switch (m3) {
@@ -401,12 +401,18 @@ static int swap_round_mode(CPUS390XState *env, int m3)
     return ret;
 }
 
+void s390_restore_bfp_rounding_mode(CPUS390XState *env, int old_mode)
+{
+    set_float_rounding_mode(old_mode, &env->fpu_status);
+}
+
 /* convert 64-bit int to 32-bit float */
 uint64_t HELPER(cegb)(CPUS390XState *env, int64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     float32 ret = int64_to_float32(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -414,9 +420,10 @@ uint64_t HELPER(cegb)(CPUS390XState *env, int64_t v2, uint32_t m3)
 /* convert 64-bit int to 64-bit float */
 uint64_t HELPER(cdgb)(CPUS390XState *env, int64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     float64 ret = int64_to_float64(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -424,9 +431,10 @@ uint64_t HELPER(cdgb)(CPUS390XState *env, int64_t v2, uint32_t m3)
 /* convert 64-bit int to 128-bit float */
 uint64_t HELPER(cxgb)(CPUS390XState *env, int64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     float128 ret = int64_to_float128(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return RET128(ret);
 }
@@ -434,9 +442,10 @@ uint64_t HELPER(cxgb)(CPUS390XState *env, int64_t v2, uint32_t m3)
 /* convert 64-bit uint to 32-bit float */
 uint64_t HELPER(celgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     float32 ret = uint64_to_float32(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -444,9 +453,10 @@ uint64_t HELPER(celgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 /* convert 64-bit uint to 64-bit float */
 uint64_t HELPER(cdlgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     float64 ret = uint64_to_float64(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -454,9 +464,10 @@ uint64_t HELPER(cdlgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 /* convert 64-bit uint to 128-bit float */
 uint64_t HELPER(cxlgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     float128 ret = uint64_to_float128(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return RET128(ret);
 }
@@ -464,9 +475,10 @@ uint64_t HELPER(cxlgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 /* convert 32-bit float to 64-bit int */
 uint64_t HELPER(cgeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     int64_t ret = float32_to_int64(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -474,9 +486,10 @@ uint64_t HELPER(cgeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 /* convert 64-bit float to 64-bit int */
 uint64_t HELPER(cgdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     int64_t ret = float64_to_int64(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -484,10 +497,11 @@ uint64_t HELPER(cgdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 /* convert 128-bit float to 64-bit int */
 uint64_t HELPER(cgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     float128 v2 = make_float128(h, l);
     int64_t ret = float128_to_int64(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -495,9 +509,10 @@ uint64_t HELPER(cgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
 /* convert 32-bit float to 32-bit int */
 uint64_t HELPER(cfeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     int32_t ret = float32_to_int32(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -505,9 +520,10 @@ uint64_t HELPER(cfeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 /* convert 64-bit float to 32-bit int */
 uint64_t HELPER(cfdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     int32_t ret = float64_to_int32(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -515,10 +531,11 @@ uint64_t HELPER(cfdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 /* convert 128-bit float to 32-bit int */
 uint64_t HELPER(cfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     float128 v2 = make_float128(h, l);
     int32_t ret = float128_to_int32(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -526,11 +543,12 @@ uint64_t HELPER(cfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
 /* convert 32-bit float to 64-bit uint */
 uint64_t HELPER(clgeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     uint64_t ret;
+
     v2 = float32_to_float64(v2, &env->fpu_status);
     ret = float64_to_uint64(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -538,9 +556,10 @@ uint64_t HELPER(clgeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 /* convert 64-bit float to 64-bit uint */
 uint64_t HELPER(clgdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     uint64_t ret = float64_to_uint64(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -548,9 +567,10 @@ uint64_t HELPER(clgdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 /* convert 128-bit float to 64-bit uint */
 uint64_t HELPER(clgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     uint64_t ret = float128_to_uint64(make_float128(h, l), &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -558,9 +578,10 @@ uint64_t HELPER(clgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
 /* convert 32-bit float to 32-bit uint */
 uint64_t HELPER(clfeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     uint32_t ret = float32_to_uint32(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -568,9 +589,10 @@ uint64_t HELPER(clfeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 /* convert 64-bit float to 32-bit uint */
 uint64_t HELPER(clfdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     uint32_t ret = float64_to_uint32(v2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -578,9 +600,10 @@ uint64_t HELPER(clfdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 /* convert 128-bit float to 32-bit uint */
 uint64_t HELPER(clfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     uint32_t ret = float128_to_uint32(make_float128(h, l), &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -588,9 +611,10 @@ uint64_t HELPER(clfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
 /* round to integer 32-bit */
 uint64_t HELPER(fieb)(CPUS390XState *env, uint64_t f2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     float32 ret = float32_round_to_int(f2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -598,9 +622,10 @@ uint64_t HELPER(fieb)(CPUS390XState *env, uint64_t f2, uint32_t m3)
 /* round to integer 64-bit */
 uint64_t HELPER(fidb)(CPUS390XState *env, uint64_t f2, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
     float64 ret = float64_round_to_int(f2, &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return ret;
 }
@@ -608,10 +633,11 @@ uint64_t HELPER(fidb)(CPUS390XState *env, uint64_t f2, uint32_t m3)
 /* round to integer 128-bit */
 uint64_t HELPER(fixb)(CPUS390XState *env, uint64_t ah, uint64_t al, uint32_t m3)
 {
-    int hold = swap_round_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+
     float128 ret = float128_round_to_int(make_float128(ah, al),
                                          &env->fpu_status);
-    set_float_rounding_mode(hold, &env->fpu_status);
+    s390_restore_bfp_rounding_mode(env, old_mode);
     handle_exceptions(env, GETPC());
     return RET128(ret);
 }
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index e1c0b1bd3b..122fe037bc 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -315,6 +315,8 @@ uint32_t set_cc_nz_f128(float128 v);
 #define S390_IEEE_MASK_INEXACT   0x08
 #define S390_IEEE_MASK_QUANTUM   0x04
 uint8_t s390_softfloat_exc_to_ieee(unsigned int exc);
+int s390_swap_bfp_rounding_mode(CPUS390XState *env, int m3);
+void s390_restore_bfp_rounding_mode(CPUS390XState *env, int old_mode);
 
 
 /* gdbstub.c */
-- 
2.17.2
