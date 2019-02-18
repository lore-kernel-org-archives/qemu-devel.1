Received: from eggs.gnu.org ([209.51.188.92]:38111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvi1c-0003yG-Mh
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvi1a-0004X3-Oz
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:27:56 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 13:27:09 +0100
Message-Id: <20190218122710.23639-15-david@redhat.com>
In-Reply-To: <20190218122710.23639-1-david@redhat.com>
References: <20190218122710.23639-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 14/15] s390x/tcg: Handle all rounding modes
 overwritten by BFP instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

"round to nearest with ties away from 0" maps to float_round_ties_away.
"round to prepare for shorter precision" maps to float_round_to_odd.

As all instructions properly check for valid rounding modes in translate.c
we can add an assert. Fix one missing empty line.

Cc: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index e258f20aa9..1be68bafea 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -397,14 +397,21 @@ uint32_t HELPER(cxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
 int s390_swap_bfp_rounding_mode(CPUS390XState *env, int m3)
 {
     int ret = env->fpu_status.float_rounding_mode;
+
     switch (m3) {
     case 0:
         /* current mode */
         break;
     case 1:
-        /* biased round no nearest */
+        /* round to nearest with ties away from 0 */
+        set_float_rounding_mode(float_round_ties_away, &env->fpu_status);
+        break;
+    case 3:
+        /* round to prepare for shorter precision */
+        set_float_rounding_mode(float_round_to_odd, &env->fpu_status);
+        break;
     case 4:
-        /* round to nearest */
+        /* round to nearest with ties to even */
         set_float_rounding_mode(float_round_nearest_even, &env->fpu_status);
         break;
     case 5:
@@ -419,6 +426,8 @@ int s390_swap_bfp_rounding_mode(CPUS390XState *env, int m3)
         /* round to -inf */
         set_float_rounding_mode(float_round_down, &env->fpu_status);
         break;
+    default:
+        g_assert_not_reached();
     }
     return ret;
 }
-- 
2.17.2
