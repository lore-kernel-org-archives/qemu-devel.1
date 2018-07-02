Received: from eggs.gnu.org ([2001:4830:134:3::10]:43802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqR-0002Aj-MX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqQ-0006Bz-Pm
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:18:11 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  2 Jul 2018 13:17:31 +0200
Message-Id: <20180702111737.18970-10-cohuck@redhat.com>
In-Reply-To: <20180702111737.18970-1-cohuck@redhat.com>
References: <20180702111737.18970-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 09/15] s390x/tcg: SET CLOCK COMPARATOR can clear
 CKC interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's stop the timer and delete any pending CKC IRQ before doing
anything else.

While at it, add a comment why the check for ckc == -1ULL is needed.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180627134410.4901-7-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/misc_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 229f14d3da..e4c1522140 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -154,6 +154,13 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
 {
     S390TODState *td = s390_get_todstate();
 
+    /* stop the timer and remove pending CKC IRQs */
+    timer_del(env->tod_timer);
+    qemu_mutex_lock_iothread();
+    env->pending_int &= ~INTERRUPT_EXT_CLOCK_COMPARATOR;
+    qemu_mutex_unlock_iothread();
+
+    /* the tod has to exceed the ckc, this can never happen if ckc is all 1's */
     if (time == -1ULL) {
         return;
     }
-- 
2.14.4
