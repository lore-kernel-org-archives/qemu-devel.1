Received: from eggs.gnu.org ([209.51.188.92]:53556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVqo-0005po-Q4
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVqn-0002bd-EO
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:42 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 12 Feb 2019 12:02:55 +0100
Message-Id: <20190212110308.13707-4-david@redhat.com>
In-Reply-To: <20190212110308.13707-1-david@redhat.com>
References: <20190212110308.13707-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 02/15] s390x/tcg: Fix rounding from float128
 to uint64_t/uin32_t
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

Let's use the proepr conversion functions now that we have them.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index a3214bd546..f9ec519067 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -509,9 +509,7 @@ uint64_t HELPER(clgdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 uint64_t HELPER(clgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
 {
     int hold = swap_round_mode(env, m3);
-    float128 v2 = make_float128(h, l);
-    /* ??? Not 100% correct.  */
-    uint64_t ret = float128_to_int64(v2, &env->fpu_status);
+    uint64_t ret = float128_to_uint64(make_float128(h, l), &env->fpu_status);
     set_float_rounding_mode(hold, &env->fpu_status);
     handle_exceptions(env, GETPC());
     return ret;
@@ -541,9 +539,7 @@ uint64_t HELPER(clfdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
 uint64_t HELPER(clfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
 {
     int hold = swap_round_mode(env, m3);
-    float128 v2 = make_float128(h, l);
-    /* Not 100% correct.  */
-    uint32_t ret = float128_to_int64(v2, &env->fpu_status);
+    uint32_t ret = float128_to_uint32(make_float128(h, l), &env->fpu_status);
     set_float_rounding_mode(hold, &env->fpu_status);
     handle_exceptions(env, GETPC());
     return ret;
-- 
2.17.2
