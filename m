Received: from eggs.gnu.org ([209.51.188.92]:53647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVqq-0005ri-Tk
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVqo-0002du-C3
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:44 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 12 Feb 2019 12:03:01 +0100
Message-Id: <20190212110308.13707-10-david@redhat.com>
In-Reply-To: <20190212110308.13707-1-david@redhat.com>
References: <20190212110308.13707-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 08/15] s390x/tcg: Handle SET FPC AND LOAD
 FPC 3-bit BFP rounding modes
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

We already forward the 3 bits correctly in the translation functions. We
also have to handle them properly and check for specification
exceptions.

Setting an invalid rounding mode (BFP only, all DFP rounding modes)
results in a specification exception. Setting unassigned bits in the
fpc, results in a specification exception.

This fixes LOAD FPC (AND SIGNAL), SET FPC (AND SIGNAL). Also for,
SET BFP ROUNDING MODE, 3-bit rounding mode is now explicitly checked.

Notes:
1. Use "float_round_to_zero" for now to handle "Round to prepare for
   shorter precision". Looking at the PoP "Summary of Rounding and Range
   Actions" for BFP. They differ when it comes to tiny values.
2. TCG_CALL_NO_WG is required for sfpc handler, as we now inject
   exceptions.

We won't be modeling abscence of the "floating-point extension facility"
for now, not necessary as most take the facility for granted without
checking.

z14 PoP, 9-23, "LOAD FPC"
    When the floating-point extension facility is
    installed, bits 29-31 of the second operand must
    specify a valid BFP rounding mode and bits 6-7,
    14-15, 24, and 28 must be zero; otherwise, a
    specification exception is recognized.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 24 ++++++++++++++++++++----
 target/s390x/helper.h     |  2 +-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 15ede530d8..a578f849ad 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -802,21 +802,33 @@ uint64_t HELPER(sqxb)(CPUS390XState *env, uint64_t ah, uint64_t al)
     return RET128(ret);
 }
 
-static const int fpc_to_rnd[4] = {
+static const int fpc_to_rnd[8] = {
     float_round_nearest_even,
     float_round_to_zero,
     float_round_up,
-    float_round_down
+    float_round_down,
+    -1,
+    -1,
+    -1,
+    /*
+     * FIXME: we actually want something like round_to_odd, but that does not
+     * support all data types yet.
+     */
+    float_round_to_zero,
 };
 
 /* set fpc */
 void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
 {
+    if (fpc_to_rnd[fpc & 0x7] == -1 || fpc & 0x03030088u) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, GETPC());
+    }
+
     /* Install everything in the main FPC.  */
     env->fpc = fpc;
 
     /* Install the rounding mode in the shadow fpu_status.  */
-    set_float_rounding_mode(fpc_to_rnd[fpc & 3], &env->fpu_status);
+    set_float_rounding_mode(fpc_to_rnd[fpc & 0x7], &env->fpu_status);
 }
 
 /* set fpc and signal */
@@ -825,12 +837,16 @@ void HELPER(sfas)(CPUS390XState *env, uint64_t fpc)
     uint32_t signalling = env->fpc;
     uint32_t s390_exc;
 
+    if (fpc_to_rnd[fpc & 0x7] == -1 || fpc & 0x03030088u) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, GETPC());
+    }
+
     /*
      * FPC is set to the FPC operand with a bitwise OR of the signalling
      * flags.
      */
     env->fpc = fpc | (signalling & 0x00ff0000);
-    set_float_rounding_mode(fpc_to_rnd[fpc & 3], &env->fpu_status);
+    set_float_rounding_mode(fpc_to_rnd[fpc & 0x7], &env->fpu_status);
 
     /*
      * If any signaling flag is enabled in the new FPC mask, a
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 018e9dd414..974f6bac2a 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -104,7 +104,7 @@ DEF_HELPER_4(trtr, i32, env, i32, i64, i64)
 DEF_HELPER_5(trXX, i32, env, i32, i32, i32, i32)
 DEF_HELPER_4(cksm, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_5(calc_cc, TCG_CALL_NO_RWG_SE, i32, env, i32, i64, i64, i64)
-DEF_HELPER_FLAGS_2(sfpc, TCG_CALL_NO_RWG, void, env, i64)
+DEF_HELPER_FLAGS_2(sfpc, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_2(sfas, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(stfle, i32, env, i64)
-- 
2.17.2
