Received: from eggs.gnu.org ([2001:4830:134:3::10]:39342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dwTtS-00068i-BT
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dwTtO-0006y6-9l
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:57:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 25 Sep 2017 14:57:35 +0100
Message-Id: <20170925135735.25076-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3] throttle-groups: cancel timers on restart
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

Throttling group members are restarted on config change and by
bdrv_drained_begin().  Pending timers should be cancelled before
restarting the queue, otherwise requests see that tg->any_timer_armed[]
is already set and do not schedule a timer.

For example, a hang occurs at least since QEMU 2.10.0 with -drive
iops=100 because no further timers will be scheduled:

  (guest)$ dd if=/dev/zero of=/dev/vdb oflag=direct count=1000
  (qemu) stop
  (qemu) cont
  ...I/O is stuck...

This can be fixed by calling throttle_group_detach_aio_context() from a
bdrv_drained_begin/end() region.  This way timers are quiesced properly,
requests are drained, and other throttle group members are scheduled, if
necessary.

Reported-by: Yongxue Hong <yhong@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v3:
 * Different approach this time, based on Berto's insight that another
   TGM may need to be scheduled now that our TGM's timers have been
   detached.

   I realized the problem isn't the detach operation, it's the restart
   operation that runs before detach.  Timers shouldn't be left active
   across restart.

   After fixing restart no change is necessary in detach, but I decided
   to add assertions to make it clear that this function must be called
   in a quiesced environment.

 block/block-backend.c   |  2 ++
 block/throttle-groups.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 45d9101be3..da2f6c0f8a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1748,8 +1748,10 @@ void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
 
     if (bs) {
         if (tgm->throttle_state) {
+            bdrv_drained_begin(bs);
             throttle_group_detach_aio_context(tgm);
             throttle_group_attach_aio_context(tgm, new_context);
+            bdrv_drained_end(bs);
         }
         bdrv_set_aio_context(bs, new_context);
     }
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 6ba992c8d7..c13530695a 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -420,6 +420,23 @@ static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool is_write
 void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
 {
     if (tgm->throttle_state) {
+        ThrottleState *ts = tgm->throttle_state;
+        ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
+        ThrottleTimers *tt = &tgm->throttle_timers;
+
+        /* Cancel pending timers */
+        qemu_mutex_lock(&tg->lock);
+        if (timer_pending(tt->timers[0])) {
+            timer_del(tt->timers[0]);
+            tg->any_timer_armed[0] = false;
+        }
+        if (timer_pending(tt->timers[1])) {
+            timer_del(tt->timers[1]);
+            tg->any_timer_armed[1] = false;
+        }
+        qemu_mutex_unlock(&tg->lock);
+
+        /* This also schedules the next request in other TGMs, if necessary */
         throttle_group_restart_queue(tgm, 0);
         throttle_group_restart_queue(tgm, 1);
     }
@@ -592,6 +609,17 @@ void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
 void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
 {
     ThrottleTimers *tt = &tgm->throttle_timers;
+
+    /* Requests must have been drained */
+    assert(tgm->pending_reqs[0] == 0);
+    assert(tgm->pending_reqs[1] == 0);
+    assert(qemu_co_queue_empty(&tgm->throttled_reqs[0]));
+    assert(qemu_co_queue_empty(&tgm->throttled_reqs[1]));
+
+    /* Timers must be disabled */
+    assert(!timer_pending(tt->timers[0]));
+    assert(!timer_pending(tt->timers[1]));
+
     throttle_timers_detach_aio_context(tt);
     tgm->aio_context = NULL;
 }
-- 
2.13.5
