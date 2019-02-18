Received: from eggs.gnu.org ([209.51.188.92]:37862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvi1F-0003dk-IN
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvi1E-0004ME-Og
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:27:33 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 13:27:01 +0100
Message-Id: <20190218122710.23639-7-david@redhat.com>
In-Reply-To: <20190218122710.23639-1-david@redhat.com>
References: <20190218122710.23639-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/15] s390x/tcg: Refactor SET FPC AND
 SIGNAL handling
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

We can directly work on the uint64_t value, no need for a temporary
uint32_t value.

Also cleanup and shorten the comments.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 64efab72a4..ea5a37ac5e 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -771,21 +771,23 @@ void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
 }
 
 /* set fpc and signal */
-void HELPER(sfas)(CPUS390XState *env, uint64_t val)
+void HELPER(sfas)(CPUS390XState *env, uint64_t fpc)
 {
     uint32_t signalling = env->fpc;
-    uint32_t source = val;
     uint32_t s390_exc;
 
-    /* The contents of the source operand are placed in the FPC register;
-       then the flags in the FPC register are set to the logical OR of the
-       signalling flags and the source flags.  */
-    env->fpc = source | (signalling & 0x00ff0000);
-    set_float_rounding_mode(fpc_to_rnd[source & 3], &env->fpu_status);
+    /*
+     * FPC is set to the FPC operand with a bitwise OR of the signalling
+     * flags.
+     */
+    env->fpc = fpc | (signalling & 0x00ff0000);
+    set_float_rounding_mode(fpc_to_rnd[fpc & 3], &env->fpu_status);
 
-    /* If any signalling flag is 1 and the corresponding source mask
-       is also 1, a simulated-iee-exception trap occurs.  */
-    s390_exc = (signalling >> 16) & (source >> 24);
+    /*
+     * If any signaling flag is enabled in the new FPC mask, a
+     * simulated-iee-exception exception occurs.
+     */
+    s390_exc = (signalling >> 16) & (fpc >> 24);
     if (s390_exc) {
         tcg_s390_data_exception(env, s390_exc | 3, GETPC());
     }
-- 
2.17.2
