Received: from eggs.gnu.org ([209.51.188.92]:53582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVqp-0005qJ-Ie
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVqn-0002cp-VR
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:43 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 12 Feb 2019 12:02:57 +0100
Message-Id: <20190212110308.13707-6-david@redhat.com>
In-Reply-To: <20190212110308.13707-1-david@redhat.com>
References: <20190212110308.13707-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 04/15] s390x/tcg: Fix parts of IEEE
 exception handling
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

Many things are wrong and some parts cannot be fixed yet. Fix what we
can fix easily and add two FIXMEs:

The fpc flags are not updated in case an exception is actually injected.
Inexact exceptions have to be handled separately, as they are the only
exceptions that can coexist with underflows and overflows.

I reread the horribly complicated chapters in the PoP at least 5 times
and hope I got it right.

For references:
- z14 PoP, 9-18, "IEEE Exceptions"
- z14 PoP, 19-9, Figure 19-8

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 60f589608e..94680053f9 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -63,13 +63,39 @@ static void handle_exceptions(CPUS390XState *env, uintptr_t retaddr)
     env->fpu_status.float_exception_flags = 0;
     s390_exc = s390_softfloat_exc_to_ieee(qemu_exc);
 
-    /* Install the exceptions that we raised.  */
-    env->fpc |= s390_exc << 16;
+    /*
+     * FIXME:
+     * 1. Right now, all inexact conditions are inidicated as
+     *    "truncated" (0) and never as "incremented" (1) in the DXC.
+     * 2. Only traps due to invalid/divbyzero are suppressing. Other traps
+     *    are completing, meaning the target register has to be written!
+     *    This, however will mean that we have to write the register before
+     *    triggering the trap - impossible right now.
+     */
+
+    /*
+     * invalid/divbyzero cannot coexist with other conditions.
+     * overflow/underflow however can coexist with inexact, we have to
+     * handle it separatly.
+     */
+    if (s390_exc & ~S390_IEEE_MASK_INEXACT) {
+        if (s390_exc & ~S390_IEEE_MASK_INEXACT & env->fpc >> 24) {
+            /* trap condition - inexact reported along */
+            tcg_s390_data_exception(env, s390_exc, retaddr);
+        }
+        /* nontrap condition - inexact handled differently */
+        env->fpc |= (s390_exc & ~S390_IEEE_MASK_INEXACT) << 16;
+    }
 
-    /* Send signals for enabled exceptions.  */
-    s390_exc &= env->fpc >> 24;
-    if (s390_exc) {
-        tcg_s390_data_exception(env, s390_exc, retaddr);
+    /* inexact handling */
+    if (s390_exc & S390_IEEE_MASK_INEXACT) {
+        /* trap condition - overflow/underflow _not_ reported along */
+        if (s390_exc & S390_IEEE_MASK_INEXACT & env->fpc >> 24) {
+            tcg_s390_data_exception(env, s390_exc & S390_IEEE_MASK_INEXACT,
+                                    retaddr);
+        }
+        /* nontrap condition */
+        env->fpc |= (s390_exc & S390_IEEE_MASK_INEXACT) << 16;
     }
 }
 
-- 
2.17.2
