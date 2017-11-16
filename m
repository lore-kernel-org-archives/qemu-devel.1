Received: from eggs.gnu.org ([2001:4830:134:3::10]:60165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eFN9L-0002w4-9O
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eFN9H-00061A-UN
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:36:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eFN9H-00060t-O5
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:36:19 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 16 Nov 2017 16:36:14 +0000
Message-Id: <20171116163614.24710-2-stefanha@redhat.com>
In-Reply-To: <20171116163614.24710-1-stefanha@redhat.com>
References: <20171116163614.24710-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11 1/1] throttle-groups: forget timer and
 schedule next TGM on detach
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

tg->any_timer_armed[] must be cleared when detaching pending timers from
the AioContext.  Failure to do so leads to hung I/O because it looks
like there are still timers pending when in fact they have been removed.

Other ThrottleGroupMembers might have requests pending too so it's
necessary to schedule the next TGM so it can set a timer.

This patch fixes hung I/O when QEMU is launched with drives that are in
the same throttling group:

  (guest)$ dd if=/dev/zero of=/dev/vdb oflag=direct bs=512 &
  (guest)$ dd if=/dev/zero of=/dev/vdc oflag=direct bs=512 &
  (qemu) stop
  (qemu) cont
  ...I/O is stuck...

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20171116112150.27607-1-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/throttle-groups.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 2587f19ca3..f26bcb5eee 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -593,13 +593,25 @@ void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
 
 void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
 {
+    ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
     ThrottleTimers *tt = &tgm->throttle_timers;
+    int i;
 
     /* Requests must have been drained */
     assert(tgm->pending_reqs[0] == 0 && tgm->pending_reqs[1] == 0);
     assert(qemu_co_queue_empty(&tgm->throttled_reqs[0]));
     assert(qemu_co_queue_empty(&tgm->throttled_reqs[1]));
 
+    /* Kick off next ThrottleGroupMember, if necessary */
+    qemu_mutex_lock(&tg->lock);
+    for (i = 0; i < 2; i++) {
+        if (timer_pending(tt->timers[i])) {
+            tg->any_timer_armed[i] = false;
+            schedule_next_request(tgm, i);
+        }
+    }
+    qemu_mutex_unlock(&tg->lock);
+
     throttle_timers_detach_aio_context(tt);
     tgm->aio_context = NULL;
 }
-- 
2.13.6
