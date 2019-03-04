Received: from eggs.gnu.org ([209.51.188.92]:47083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mKF-0001Ab-Vu
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mKF-0002OL-1G
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:04:07 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:02:09 +0100
Message-Id: <20190304120210.31500-27-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
References: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 26/27] s390x/tcg: Handle all rounding modes
 overwritten by BFP instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

"round to nearest with ties away from 0" maps to float_round_ties_away.
"round to prepare for shorter precision" maps to float_round_to_odd.

As all instructions properly check for valid rounding modes in translate.c
we can add an assert. Fix one missing empty line.

Cc: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190218122710.23639-15-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/fpu_helper.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index e258f20aa980..1be68bafea30 100644
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
