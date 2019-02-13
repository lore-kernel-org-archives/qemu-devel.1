Received: from eggs.gnu.org ([209.51.188.92]:39454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtvbZ-0008Ij-LA
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtvbY-000299-Qi
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:33:41 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 13 Feb 2019 15:33:12 +0100
Message-Id: <20190213143322.31371-6-david@redhat.com>
In-Reply-To: <20190213143322.31371-1-david@redhat.com>
References: <20190213143322.31371-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/15] s390x/tcg: Hide IEEE underflows in
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index dcad9c367a..64efab72a4 100644
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
