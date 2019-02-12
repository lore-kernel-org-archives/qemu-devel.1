Received: from eggs.gnu.org ([209.51.188.92]:53658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVqr-0005rv-5A
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVql-0002Yj-AE
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:44 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 12 Feb 2019 12:02:58 +0100
Message-Id: <20190212110308.13707-7-david@redhat.com>
In-Reply-To: <20190212110308.13707-1-david@redhat.com>
References: <20190212110308.13707-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 05/15] s390x/tcg: Hide IEEE underflows in
 some scenarios
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

IEEE underflows are not reported when the mask bit is off and we don't
also have an inexact exception.

z14 PoP, 9-20, "IEEE Underflow":
    An IEEE-underflow exception is recognized for an
    IEEE target when the tininess condition exists and
    either: (1) the IEEE-underflow mask bit in the FPC
    register is zero and the result value is inexact, or (2)
    the IEEE-underflow mask bit in the FPC register is
    one.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 94680053f9..2e690073ea 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -63,6 +63,19 @@ static void handle_exceptions(CPUS390XState *env, uintptr_t retaddr)
     env->fpu_status.float_exception_flags = 0;
     s390_exc = s390_softfloat_exc_to_ieee(qemu_exc);
 
+    /*
+     * IEEE-Underflow exception recognition exists if a tininess condition
+     * (underflow) exists and
+     * - The mask bit in the FPC is zero and the result is inexact
+     * - The mask bit in the FPC is one
+     * So tininess conditions that are not inexact don't trigger any
+     * underflow action in case the mask bit is not one.
+     */
+    if (!(s390_exc & S390_IEEE_MASK_INEXACT) &&
+        !((env->fpc >> 24) & S390_IEEE_MASK_UNDERFLOW)) {
+        s390_exc &= ~S390_IEEE_MASK_UNDERFLOW;
+    }
+
     /*
      * FIXME:
      * 1. Right now, all inexact conditions are inidicated as
-- 
2.17.2
