Received: from eggs.gnu.org ([2001:4830:134:3::10]:38803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dB2Sd-00068i-GY
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dB2Sc-00055u-Hl
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:10:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 17 May 2017 18:09:41 +0100
Message-Id: <20170517170941.25850-4-stefanha@redhat.com>
In-Reply-To: <20170517170941.25850-1-stefanha@redhat.com>
References: <20170517170941.25850-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] migration: avoid recursive AioContext
 locking in save_vmstate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

AioContext was designed to allow nested acquire/release calls.  It uses
a recursive mutex so callers don't need to worry about nesting...or so
we thought.

BDRV_POLL_WHILE() is used to wait for block I/O requests.  It releases
the AioContext temporarily around aio_poll().  This gives IOThreads a
chance to acquire the AioContext to process I/O completions.

It turns out that recursive locking and BDRV_POLL_WHILE() don't mix.
BDRV_POLL_WHILE() only releases the AioContext once, so the IOThread
will not be able to acquire the AioContext if it was acquired
multiple times.

Instead of trying to release AioContext n times in BDRV_POLL_WHILE(),
this patch simply avoids nested locking in save_vmstate().  It's the
simplest fix and we should step back to consider the big picture with
all the recent changes to block layer threading.

This patch is the final fix to solve 'savevm' hanging with -object
iothread.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 migration/savevm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 7f66d58..a70ba20 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2153,6 +2153,14 @@ int save_vmstate(const char *name)
         goto the_end;
     }
 
+    /* The bdrv_all_create_snapshot() call that follows acquires the AioContext
+     * for itself.  BDRV_POLL_WHILE() does not support nested locking because
+     * it only releases the lock once.  Therefore synchronous I/O will deadlock
+     * unless we release the AioContext before bdrv_all_create_snapshot().
+     */
+    aio_context_release(aio_context);
+    aio_context = NULL;
+
     ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
     if (ret < 0) {
         error_report("Error while creating snapshot on '%s'",
@@ -2163,7 +2171,9 @@ int save_vmstate(const char *name)
     ret = 0;
 
  the_end:
-    aio_context_release(aio_context);
+    if (aio_context) {
+        aio_context_release(aio_context);
+    }
     if (saved_vm_running) {
         vm_start();
     }
-- 
2.9.3
