Received: from eggs.gnu.org ([2001:4830:134:3::10]:41624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrI0-0008O0-Er
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrHz-0005sh-8w
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrHz-0005rj-0X
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:19 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06F5EC04B936
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:39:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:38:56 +0200
Message-Id: <20170605123908.18777-8-pbonzini@redhat.com>
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/19] throttle-groups: only start one
 coroutine from drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

Starting all waiting coroutines from bdrv_drain_all is unnecessary;
throttle_group_co_io_limits_intercept calls schedule_next_request as
soon as the coroutine restarts, which in turn will restart the next
request if possible.

If we only start the first request and let the coroutines dance from
there the code is simpler and there is more reuse between
throttle_group_config, throttle_group_restart_blk and timer_cb.  The
next patch will benefit from this.

We also stop accessing from throttle_group_restart_blk the
blkp->throttled_reqs CoQueues even when there was no
attached throttling group.  This worked but is not pretty.

The only thing that can interrupt the dance is the QEMU_CLOCK_VIRTUAL
timer when switching from one block device to the next, because the
timer is set to "now + 1" but QEMU_CLOCK_VIRTUAL might not be running.
Set that timer to point in the present ("now") rather than the future
and things work.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/throttle-groups.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 69bfbd44d9..85169ecfb0 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -292,7 +292,7 @@ static void schedule_next_request(BlockBackend *blk, bool is_write)
         } else {
             ThrottleTimers *tt = &blk_get_public(token)->throttle_timers;
             int64_t now = qemu_clock_get_ns(tt->clock_type);
-            timer_mod(tt->timers[is_write], now + 1);
+            timer_mod(tt->timers[is_write], now);
             tg->any_timer_armed[is_write] = true;
         }
         tg->tokens[is_write] = token;
@@ -340,15 +340,32 @@ void coroutine_fn throttle_group_co_io_limits_intercept(BlockBackend *blk,
     qemu_mutex_unlock(&tg->lock);
 }
 
+static void throttle_group_restart_queue(BlockBackend *blk, bool is_write)
+{
+    BlockBackendPublic *blkp = blk_get_public(blk);
+    ThrottleGroup *tg = container_of(blkp->throttle_state, ThrottleGroup, ts);
+    bool empty_queue;
+
+    aio_context_acquire(blk_get_aio_context(blk));
+    empty_queue = !qemu_co_enter_next(&blkp->throttled_reqs[is_write]);
+    aio_context_release(blk_get_aio_context(blk));
+
+    /* If the request queue was empty then we have to take care of
+     * scheduling the next one */
+    if (empty_queue) {
+        qemu_mutex_lock(&tg->lock);
+        schedule_next_request(blk, is_write);
+        qemu_mutex_unlock(&tg->lock);
+    }
+}
+
 void throttle_group_restart_blk(BlockBackend *blk)
 {
     BlockBackendPublic *blkp = blk_get_public(blk);
-    int i;
 
-    for (i = 0; i < 2; i++) {
-        while (qemu_co_enter_next(&blkp->throttled_reqs[i])) {
-            ;
-        }
+    if (blkp->throttle_state) {
+        throttle_group_restart_queue(blk, 0);
+        throttle_group_restart_queue(blk, 1);
     }
 }
 
@@ -376,8 +393,7 @@ void throttle_group_config(BlockBackend *blk, ThrottleConfig *cfg)
     throttle_config(ts, tt, cfg);
     qemu_mutex_unlock(&tg->lock);
 
-    qemu_co_enter_next(&blkp->throttled_reqs[0]);
-    qemu_co_enter_next(&blkp->throttled_reqs[1]);
+    throttle_group_restart_blk(blk);
 }
 
 /* Get the throttle configuration from a particular group. Similar to
@@ -408,7 +424,6 @@ static void timer_cb(BlockBackend *blk, bool is_write)
     BlockBackendPublic *blkp = blk_get_public(blk);
     ThrottleState *ts = blkp->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
-    bool empty_queue;
 
     /* The timer has just been fired, so we can update the flag */
     qemu_mutex_lock(&tg->lock);
@@ -416,17 +431,7 @@ static void timer_cb(BlockBackend *blk, bool is_write)
     qemu_mutex_unlock(&tg->lock);
 
     /* Run the request that was waiting for this timer */
-    aio_context_acquire(blk_get_aio_context(blk));
-    empty_queue = !qemu_co_enter_next(&blkp->throttled_reqs[is_write]);
-    aio_context_release(blk_get_aio_context(blk));
-
-    /* If the request queue was empty then we have to take care of
-     * scheduling the next one */
-    if (empty_queue) {
-        qemu_mutex_lock(&tg->lock);
-        schedule_next_request(blk, is_write);
-        qemu_mutex_unlock(&tg->lock);
-    }
+    throttle_group_restart_queue(blk, is_write);
 }
 
 static void read_timer_cb(void *opaque)
-- 
2.13.0
