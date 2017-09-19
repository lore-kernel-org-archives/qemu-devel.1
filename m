Received: from eggs.gnu.org ([2001:4830:134:3::10]:57561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1duKnF-0006lz-Uq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1duKnF-00053n-3w
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:50:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 19 Sep 2017 16:50:25 +0100
Message-Id: <20170919155025.4098-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] throttle-groups: update tg->any_timer_armed[]
 on detach
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

Clear tg->any_timer_armed[] when throttling timers are destroy during
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
 block/throttle-groups.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 6ba992c8d7..2bfd03faa0 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -592,7 +592,20 @@ void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
 void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
 {
     ThrottleTimers *tt = &tgm->throttle_timers;
+    ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
+
     throttle_timers_detach_aio_context(tt);
+
+    /* Forget about these timers, they have been destroyed */
+    qemu_mutex_lock(&tg->lock);
+    if (tg->tokens[0] == tgm) {
+        tg->any_timer_armed[0] = false;
+    }
+    if (tg->tokens[1] == tgm) {
+        tg->any_timer_armed[1] = false;
+    }
+    qemu_mutex_unlock(&tg->lock);
+
     tgm->aio_context = NULL;
 }
 
-- 
2.13.5
