Received: from eggs.gnu.org ([2001:4830:134:3::10]:38554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1Amh-0007W5-P9
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1Ama-0002yK-1L
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:03 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Apr 2017 14:00:48 +0200
Message-Id: <20170420120058.28404-8-pbonzini@redhat.com>
In-Reply-To: <20170420120058.28404-1-pbonzini@redhat.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/17] throttle-groups: do not use
 qemu_co_enter_next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

Prepare for removing this function; always restart throttled requests
from coroutine context.  This will matter when restarting throttled
requests will have to acquire a CoMutex.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/throttle-groups.c | 65 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 69bfbd4..d66bf62 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -260,6 +260,18 @@ static bool throttle_group_schedule_timer(BlockBackend *blk, bool is_write)
     return must_wait;
 }
 
+/* Start the next pending I/O request for a BlockBackend.
+ *
+ * @blk:       the current BlockBackend
+ * @is_write:  the type of operation (read/write)
+ */
+static bool throttle_group_co_restart_queue(BlockBackend *blk, bool is_write)
+{
+    BlockBackendPublic *blkp = blk_get_public(blk);
+
+    return qemu_co_queue_next(&blkp->throttled_reqs[is_write]);
+}
+
 /* Look for the next pending I/O request and schedule it.
  *
  * This assumes that tg->lock is held.
@@ -287,7 +299,7 @@ static void schedule_next_request(BlockBackend *blk, bool is_write)
     if (!must_wait) {
         /* Give preference to requests from the current blk */
         if (qemu_in_coroutine() &&
-            qemu_co_queue_next(&blkp->throttled_reqs[is_write])) {
+            throttle_group_co_restart_queue(blk, is_write)) {
             token = blk;
         } else {
             ThrottleTimers *tt = &blk_get_public(token)->throttle_timers;
@@ -340,18 +352,57 @@ void coroutine_fn throttle_group_co_io_limits_intercept(BlockBackend *blk,
     qemu_mutex_unlock(&tg->lock);
 }
 
-void throttle_group_restart_blk(BlockBackend *blk)
+typedef struct {
+    BlockBackend *blk;
+    bool is_write;
+    int ret;
+} RestartData;
+
+static void throttle_group_restart_queue_entry(void *opaque)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
+    RestartData *data = opaque;
+
+    data->ret = throttle_group_co_restart_queue(data->blk, data->is_write);
+}
+
+static int throttle_group_restart_queue(BlockBackend *blk, bool is_write)
+{
+    Coroutine *co;
+    RestartData rd = {
+        .blk = blk,
+        .is_write = is_write
+    };
+
+    aio_context_acquire(blk_get_aio_context(blk));
+    co = qemu_coroutine_create(throttle_group_restart_queue_entry, &rd);
+    /* The request doesn't start until after throttle_group_restart_queue_entry
+     * returns, so the coroutine cannot yield.
+     */
+    qemu_coroutine_enter(co);
+    aio_context_release(blk_get_aio_context(blk));
+    return rd.ret;
+}
+
+static void throttle_group_restart_blk_entry(void *opaque)
+{
+    BlockBackend *blk = opaque;
     int i;
 
     for (i = 0; i < 2; i++) {
-        while (qemu_co_enter_next(&blkp->throttled_reqs[i])) {
+        while (throttle_group_co_restart_queue(blk, i)) {
             ;
         }
     }
 }
 
+void throttle_group_restart_blk(BlockBackend *blk)
+{
+    Coroutine *co;
+
+    co = qemu_coroutine_create(throttle_group_restart_blk_entry, blk);
+    qemu_coroutine_enter(co);
+}
+
 /* Update the throttle configuration for a particular group. Similar
  * to throttle_config(), but guarantees atomicity within the
  * throttling group.
@@ -376,8 +427,8 @@ void throttle_group_config(BlockBackend *blk, ThrottleConfig *cfg)
     throttle_config(ts, tt, cfg);
     qemu_mutex_unlock(&tg->lock);
 
-    qemu_co_enter_next(&blkp->throttled_reqs[0]);
-    qemu_co_enter_next(&blkp->throttled_reqs[1]);
+    throttle_group_restart_queue(blk, 0);
+    throttle_group_restart_queue(blk, 1);
 }
 
 /* Get the throttle configuration from a particular group. Similar to
@@ -417,7 +468,7 @@ static void timer_cb(BlockBackend *blk, bool is_write)
 
     /* Run the request that was waiting for this timer */
     aio_context_acquire(blk_get_aio_context(blk));
-    empty_queue = !qemu_co_enter_next(&blkp->throttled_reqs[is_write]);
+    empty_queue = !throttle_group_restart_queue(blk, is_write);
     aio_context_release(blk_get_aio_context(blk));
 
     /* If the request queue was empty then we have to take care of
-- 
2.9.3
