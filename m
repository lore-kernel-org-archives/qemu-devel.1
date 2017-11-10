Received: from eggs.gnu.org ([2001:4830:134:3::10]:47097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eDB5r-0006qH-Nw
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:19:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eDB5q-0003n3-O5
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:19:43 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 10 Nov 2017 15:19:34 +0000
Message-Id: <20171110151934.16883-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v4] throttle-groups: drain before detaching
 ThrottleState
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

I/O requests hang after stop/cont commands at least since QEMU 2.10.0
with -drive iops=100:

  (guest)$ dd if=/dev/zero of=/dev/vdb oflag=direct count=1000
  (qemu) stop
  (qemu) cont
  ...I/O is stuck...

This happens because blk_set_aio_context() detaches the ThrottleState
while requests may still be in flight:

  if (tgm->throttle_state) {
      throttle_group_detach_aio_context(tgm);
      throttle_group_attach_aio_context(tgm, new_context);
  }

This patch encloses the detach/attach calls in a drained region so no
I/O request is left hanging.  Also add assertions so we don't make the
same mistake again in the future.

Reported-by: Yongxue Hong <yhong@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v4:
 * Simplified patch in response to Berto's review
---
 block/block-backend.c   | 2 ++
 block/throttle-groups.c | 6 ++++++
 2 files changed, 8 insertions(+)

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
index b291a88481..2587f19ca3 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -594,6 +594,12 @@ void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
 void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
 {
     ThrottleTimers *tt = &tgm->throttle_timers;
+
+    /* Requests must have been drained */
+    assert(tgm->pending_reqs[0] == 0 && tgm->pending_reqs[1] == 0);
+    assert(qemu_co_queue_empty(&tgm->throttled_reqs[0]));
+    assert(qemu_co_queue_empty(&tgm->throttled_reqs[1]));
+
     throttle_timers_detach_aio_context(tt);
     tgm->aio_context = NULL;
 }
-- 
2.13.6
