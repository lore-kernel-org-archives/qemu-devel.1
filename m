Received: from eggs.gnu.org ([2001:4830:134:3::10]:60502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEYbC-0002Sh-Jh
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:37:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEYb6-0004LJ-Ug
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:37:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eEYb6-0004Ko-Os
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:37:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 14 Nov 2017 10:37:18 +0000
Message-Id: <20171114103721.13869-3-stefanha@redhat.com>
In-Reply-To: <20171114103721.13869-1-stefanha@redhat.com>
References: <20171114103721.13869-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11-rc2 2/5] throttle-groups: drain before
 detaching ThrottleState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

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
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20171110151934.16883-1-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/block-backend.c   | 2 ++
 block/throttle-groups.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 18e543780d..ab75da32c9 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1752,8 +1752,10 @@ void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
 
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
