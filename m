Received: from eggs.gnu.org ([209.51.188.92]:54315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVre-0006VD-Ri
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVrL-0003fn-Ek
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:04:27 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 12 Feb 2019 12:03:07 +0100
Message-Id: <20190212110308.13707-16-david@redhat.com>
In-Reply-To: <20190212110308.13707-1-david@redhat.com>
References: <20190212110308.13707-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 14/15] s390x/tcg: Handle all rounding modes
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

PoP describes "Round to nearest with ties away from 0" as
  "The candidate nearest to the input value is selected. In case of a tie,
   the candidate selected is the one that is larger in magnitude."

While float_round_ties_away is according to the introducing commit
f9288a76f181 ("softfloat: Add support for ties-away rounding")
  "roundTiesToAway: the floating-point number nearest to the infinitely
   precise result shall be delivered; if the two nearest floating-point
   numbers bracketing an unrepresentable infinitely precise result are
   equally near, the one with larger magnitude shall be delivered."

So this could be it if we're lucky ;)

Handle "round to prepare for shorter precision" just as when setting it
via SET FLOATING POINT and friends.

As all instructions properly check for valid rounding modes in translate.c
we can add an assert. Fix one missing empty line.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 8ef3d2f0e4..748edcc0f0 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -385,14 +385,26 @@ uint32_t HELPER(cxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
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
+        /*
+         * round to prepare for shorter precision
+         *
+         * FIXME: we actually want something like round_to_odd, but that
+         * does not support all data types yet.
+         */
+        set_float_rounding_mode(float_round_to_zero, &env->fpu_status);
+        break;
     case 4:
-        /* round to nearest */
+        /* round to nearest with ties to even */
         set_float_rounding_mode(float_round_nearest_even, &env->fpu_status);
         break;
     case 5:
@@ -407,6 +419,8 @@ int s390_swap_bfp_rounding_mode(CPUS390XState *env, int m3)
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
