Received: from eggs.gnu.org ([2001:4830:134:3::10]:50594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dufUN-0002kh-Mn
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dufUM-0006L3-Sc
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:56:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 20 Sep 2017 11:17:40 +0100
Message-Id: <20170920101740.12490-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2] throttle-groups: update
 tg->any_timer_armed[] on detach
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

Clear tg->any_timer_armed[] when throttling timers are destroyed during
AioContext attach/detach.  Failure to do so causes throttling to hang
because we believe the timer is already scheduled!

The following was broken at least since QEMU 2.10.0 with -drive
iops=100:

  $ dd if=/dev/zero of=/dev/vdb oflag=direct count=1000
  (qemu) stop
  (qemu) cont
  ...I/O is stuck...

Reported-by: Yongxue Hong <yhong@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
 * Use timer_pending(tt->timers[i]) instead of token [Berto]
 * Fix s/destroy/destroyed/ typo [Eric]

 block/throttle-groups.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 6ba992c8d7..0a49f3c409 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -592,6 +592,17 @@ void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
 void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
 {
     ThrottleTimers *tt = &tgm->throttle_timers;
+    ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
+
+    qemu_mutex_lock(&tg->lock);
+    if (timer_pending(tt->timers[0])) {
+        tg->any_timer_armed[0] = false;
+    }
+    if (timer_pending(tt->timers[1])) {
+        tg->any_timer_armed[1] = false;
+    }
+    qemu_mutex_unlock(&tg->lock);
+
     throttle_timers_detach_aio_context(tt);
     tgm->aio_context = NULL;
 }
-- 
2.13.5
