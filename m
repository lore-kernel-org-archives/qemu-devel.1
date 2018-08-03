Received: from eggs.gnu.org ([2001:4830:134:3::10]:39650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1flcLH-0008FR-3v
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 11:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1flcLG-0005zq-4p
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 11:50:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  3 Aug 2018 23:49:55 +0800
Message-Id: <20180803154955.25251-1-famz@redhat.com>
Subject: [Qemu-devel] [RFC PATCH] async: Fix aio_notify_accept
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

>From main loop, bdrv_set_aio_context() can call IOThread's aio_poll().
That breaks aio_notify() because the ctx->notifier event can get cleared
too early by this which causes IOThread hanging.

See https://bugzilla.redhat.com/show_bug.cgi?id=1562750 for details.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 util/async.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/async.c b/util/async.c
index 05979f8014..c6e8aebc3a 100644
--- a/util/async.c
+++ b/util/async.c
@@ -355,7 +355,11 @@ void aio_notify(AioContext *ctx)
 
 void aio_notify_accept(AioContext *ctx)
 {
-    if (atomic_xchg(&ctx->notified, false)) {
+    /* If ctx->notify_me >= 2, another aio_poll() is waiting which may need the
+     * ctx->notifier event to wake up, so don't already clear it just because "we" are
+     * done iterating. */
+    if (atomic_read(&ctx->notify_me) < 2
+        && atomic_xchg(&ctx->notified, false)) {
         event_notifier_test_and_clear(&ctx->notifier);
     }
 }
-- 
2.17.1
