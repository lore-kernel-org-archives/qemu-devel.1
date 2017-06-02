Received: from eggs.gnu.org ([2001:4830:134:3::10]:54674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGhgg-0001uY-Tx
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGhgc-0002Le-Gz
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:12:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dGhgc-0002KX-7m
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:11:58 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  2 Jun 2017 16:11:10 +0800
Message-Id: <20170602081120.3497-13-famz@redhat.com>
In-Reply-To: <20170602081120.3497-1-famz@redhat.com>
References: <20170602081120.3497-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v2 12/22] throttle-groups: do not use
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
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Prepare for removing this function; always restart throttled requests
from coroutine context.  This will matter when restarting throttled
requests will have to acquire a CoMutex.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170525163225.29954-9-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/throttle-groups.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 85169ec..8bf1031 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -260,6 +260,20 @@ static bool throttle_group_schedule_timer(BlockBackend *blk, bool is_write)
     return must_wait;
 }
 
+/* Start the next pending I/O request for a BlockBackend.  Return whether
+ * any request was actually pending.
+ *
+ * @blk:       the current BlockBackend
+ * @is_write:  the type of operation (read/write)
+ */
+static bool coroutine_fn throttle_group_co_restart_queue(BlockBackend *blk,
+                                                         bool is_write)
+{
+    BlockBackendPublic *blkp = blk_get_public(blk);
+
+    return qemu_co_queue_next(&blkp->throttled_reqs[is_write]);
+}
+
 /* Look for the next pending I/O request and schedule it.
  *
  * This assumes that tg->lock is held.
@@ -287,7 +301,7 @@ static void schedule_next_request(BlockBackend *blk, bool is_write)
     if (!must_wait) {
         /* Give preference to requests from the current blk */
         if (qemu_in_coroutine() &&
-            qemu_co_queue_next(&blkp->throttled_reqs[is_write])) {
+            throttle_group_co_restart_queue(blk, is_write)) {
             token = blk;
         } else {
             ThrottleTimers *tt = &blk_get_public(token)->throttle_timers;
@@ -340,15 +354,21 @@ void coroutine_fn throttle_group_co_io_limits_intercept(BlockBackend *blk,
     qemu_mutex_unlock(&tg->lock);
 }
 
-static void throttle_group_restart_queue(BlockBackend *blk, bool is_write)
+typedef struct {
+    BlockBackend *blk;
+    bool is_write;
+} RestartData;
+
+static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
 {
+    RestartData *data = opaque;
+    BlockBackend *blk = data->blk;
+    bool is_write = data->is_write;
     BlockBackendPublic *blkp = blk_get_public(blk);
     ThrottleGroup *tg = container_of(blkp->throttle_state, ThrottleGroup, ts);
     bool empty_queue;
 
-    aio_context_acquire(blk_get_aio_context(blk));
-    empty_queue = !qemu_co_enter_next(&blkp->throttled_reqs[is_write]);
-    aio_context_release(blk_get_aio_context(blk));
+    empty_queue = !throttle_group_co_restart_queue(blk, is_write);
 
     /* If the request queue was empty then we have to take care of
      * scheduling the next one */
@@ -359,6 +379,18 @@ static void throttle_group_restart_queue(BlockBackend *blk, bool is_write)
     }
 }
 
+static void throttle_group_restart_queue(BlockBackend *blk, bool is_write)
+{
+    Coroutine *co;
+    RestartData rd = {
+        .blk = blk,
+        .is_write = is_write
+    };
+
+    co = qemu_coroutine_create(throttle_group_restart_queue_entry, &rd);
+    aio_co_enter(blk_get_aio_context(blk), co);
+}
+
 void throttle_group_restart_blk(BlockBackend *blk)
 {
     BlockBackendPublic *blkp = blk_get_public(blk);
-- 
2.9.4
