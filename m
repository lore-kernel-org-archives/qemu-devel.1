Received: from eggs.gnu.org ([2001:4830:134:3::10]:33309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFn-0006h7-Jq
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFm-0002yX-HY
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:51 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:24 +0100
Message-Id: <1483969476-7172-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/14] coroutine: Introduce
 qemu_coroutine_enter_if_inactive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

In the context of asynchronous work, if we have a worker coroutine that
didn't yield, the parent coroutine cannot be reentered because it hasn't
yielded yet. In this case we don't even have to reenter the parent
because it will see that the work is already done and won't even yield.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/qemu/coroutine.h | 6 ++++++
 util/qemu-coroutine.c    | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index e6a60d5..12584ed 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -71,6 +71,12 @@ Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque);
 void qemu_coroutine_enter(Coroutine *coroutine);
 
 /**
+ * Transfer control to a coroutine if it's not active (i.e. part of the call
+ * stack of the running coroutine). Otherwise, do nothing.
+ */
+void qemu_coroutine_enter_if_inactive(Coroutine *co);
+
+/**
  * Transfer control back to a coroutine's caller
  *
  * This function does not return until the coroutine is re-entered using
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 737bffa..a5d2f6c 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -131,6 +131,13 @@ void qemu_coroutine_enter(Coroutine *co)
     }
 }
 
+void qemu_coroutine_enter_if_inactive(Coroutine *co)
+{
+    if (!qemu_coroutine_entered(co)) {
+        qemu_coroutine_enter(co);
+    }
+}
+
 void coroutine_fn qemu_coroutine_yield(void)
 {
     Coroutine *self = qemu_coroutine_self();
-- 
1.8.3.1
