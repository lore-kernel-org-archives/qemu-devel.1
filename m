Received: from eggs.gnu.org ([2001:4830:134:3::10]:39055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fXQ4L-0007ZD-QE
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fXQ4K-0001v6-UM
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:54:05 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Jun 2018 13:53:49 +0200
Message-Id: <20180625115352.6889-7-david@redhat.com>
In-Reply-To: <20180625115352.6889-1-david@redhat.com>
References: <20180625115352.6889-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/9] s390x/tcg: SET CLOCK COMPARATOR can
 clear CKC interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Let's stop the timer and delete any pending CKC IRQ before doing
anything else.

While at it, add a comment while the check for ckc == -1ULL is needed.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/misc_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index be341b5295..4872bdd774 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -156,6 +156,13 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
     S390TODClass *tdc = S390_TOD_GET_CLASS(td);
     S390TOD tod_base;
 
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
2.17.1
