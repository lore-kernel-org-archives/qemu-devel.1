Received: from eggs.gnu.org ([2001:4830:134:3::10]:59247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fMB28-0008Jc-Hc
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fMB27-0001MH-PG
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:37:20 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 25 May 2018 13:37:05 +0200
Message-Id: <20180525113708.29856-5-david@redhat.com>
In-Reply-To: <20180525113708.29856-1-david@redhat.com>
References: <20180525113708.29856-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/7] s390x/tcg: SET CLOCK COMPARATOR can
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, "Collin L . Walling" <walling@linux.ibm.com>, david@redhat.com

Let's stop the timer and delete any pending CKC IRQ before doing
anything else.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/misc_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 418326e551..2ef9de1cca 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -158,6 +158,12 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
     Error *err = NULL;
     S390TOD tod_base;
 
+    /* stop the timer and remove pending CKC IRQs */
+    timer_del(env->tod_timer);
+    qemu_mutex_lock_iothread();
+    env->pending_int &= ~INTERRUPT_EXT_CLOCK_COMPARATOR;
+    qemu_mutex_unlock_iothread();
+
     if (time == -1ULL) {
         return;
     }
-- 
2.17.0
