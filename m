Received: from eggs.gnu.org ([209.51.188.92]:53501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVqn-0005p7-GM
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVql-0002Z2-DI
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:41 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 12 Feb 2019 12:02:59 +0100
Message-Id: <20190212110308.13707-8-david@redhat.com>
In-Reply-To: <20190212110308.13707-1-david@redhat.com>
References: <20190212110308.13707-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 06/15] s390x/tcg: Refactor SET FPC AND
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 2e690073ea..7c39829352 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -820,21 +820,23 @@ void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
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
