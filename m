Received: from eggs.gnu.org ([209.51.188.92]:46752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mJk-0000j5-Bo
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mJj-0001pW-I6
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:03:36 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:02:02 +0100
Message-Id: <20190304120210.31500-20-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
References: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 19/27] s390x/tcg: Fix simulated-IEEE exceptions
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

The trap is triggered based on priority of the enabled signaling flags.
Only overflow and underflow allow a concurrent inexact exception.

z14 PoP, 9-33, Figure 9-21

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190218122710.23639-8-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/fpu_helper.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index ea5a37ac5e76..7508c0748e63 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -789,6 +789,19 @@ void HELPER(sfas)(CPUS390XState *env, uint64_t fpc)
      */
     s390_exc = (signalling >> 16) & (fpc >> 24);
     if (s390_exc) {
+        if (s390_exc & S390_IEEE_MASK_INVALID) {
+            s390_exc = S390_IEEE_MASK_INVALID;
+        } else if (s390_exc & S390_IEEE_MASK_DIVBYZERO) {
+            s390_exc = S390_IEEE_MASK_DIVBYZERO;
+        } else if (s390_exc & S390_IEEE_MASK_OVERFLOW) {
+            s390_exc &= (S390_IEEE_MASK_OVERFLOW | S390_IEEE_MASK_INEXACT);
+        } else if (s390_exc & S390_IEEE_MASK_UNDERFLOW) {
+            s390_exc &= (S390_IEEE_MASK_UNDERFLOW | S390_IEEE_MASK_INEXACT);
+        } else if (s390_exc & S390_IEEE_MASK_INEXACT) {
+            s390_exc = S390_IEEE_MASK_INEXACT;
+        } else if (s390_exc & S390_IEEE_MASK_QUANTUM) {
+            s390_exc = S390_IEEE_MASK_QUANTUM;
+        }
         tcg_s390_data_exception(env, s390_exc | 3, GETPC());
     }
 }
-- 
2.17.2
