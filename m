Received: from eggs.gnu.org ([2001:4830:134:3::10]:52920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKR-0000MB-0z
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKP-0007Yk-Ji
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 18 Jul 2017 16:17:48 +0200
Message-Id: <1500387486-5469-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
References: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/21] block: remove timer canceling in
 throttle_config()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Manos Pitsidianakis <el13635@mail.ntua.gr>

throttle_config() cancels the timers of the calling BlockBackend. This
doesn't make sense because other BlockBackends in the group remain
untouched. There's no need to cancel the timers in the one specific
BlockBackend so let's not do that. Throttled requests will run as
scheduled and future requests will follow the new configuration. This
also allows a throttle group's configuration to be changed even when it
has no members.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/throttle-groups.c     | 10 +---------
 fsdev/qemu-fsdev-throttle.c |  2 +-
 include/qemu/throttle.h     |  1 -
 tests/test-throttle.c       |  4 ++--
 util/throttle.c             | 14 --------------
 5 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 71af3f7..890bfde 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -426,18 +426,10 @@ void throttle_group_restart_blk(BlockBackend *blk)
 void throttle_group_config(BlockBackend *blk, ThrottleConfig *cfg)
 {
     BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleTimers *tt = &blkp->throttle_timers;
     ThrottleState *ts = blkp->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     qemu_mutex_lock(&tg->lock);
-    /* throttle_config() cancels the timers */
-    if (timer_pending(tt->timers[0])) {
-        tg->any_timer_armed[0] = false;
-    }
-    if (timer_pending(tt->timers[1])) {
-        tg->any_timer_armed[1] = false;
-    }
-    throttle_config(ts, tg->clock_type, tt, cfg);
+    throttle_config(ts, tg->clock_type, cfg);
     qemu_mutex_unlock(&tg->lock);
 
     throttle_group_restart_blk(blk);
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 453fb1e..49eebb5 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -86,7 +86,7 @@ void fsdev_throttle_init(FsThrottle *fst)
                              fsdev_throttle_read_timer_cb,
                              fsdev_throttle_write_timer_cb,
                              fst);
-        throttle_config(&fst->ts, QEMU_CLOCK_REALTIME, &fst->tt, &fst->cfg);
+        throttle_config(&fst->ts, QEMU_CLOCK_REALTIME, &fst->cfg);
         qemu_co_queue_init(&fst->throttled_reqs[0]);
         qemu_co_queue_init(&fst->throttled_reqs[1]);
     }
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 8d2fd77..d056008 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -140,7 +140,6 @@ bool throttle_is_valid(ThrottleConfig *cfg, Error **errp);
 
 void throttle_config(ThrottleState *ts,
                      QEMUClockType clock_type,
-                     ThrottleTimers *tt,
                      ThrottleConfig *cfg);
 
 void throttle_get_config(ThrottleState *ts, ThrottleConfig *cfg);
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 2d9cd46..768f11d 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -228,7 +228,7 @@ static void test_config_functions(void)
                          read_timer_cb, write_timer_cb, &ts);
     /* structure reset by throttle_init previous_leak should be null */
     g_assert(!ts.previous_leak);
-    throttle_config(&ts, QEMU_CLOCK_VIRTUAL, &tt, &orig_cfg);
+    throttle_config(&ts, QEMU_CLOCK_VIRTUAL, &orig_cfg);
 
     /* has previous leak been initialized by throttle_config ? */
     g_assert(ts.previous_leak);
@@ -486,7 +486,7 @@ static bool do_test_accounting(bool is_ops, /* are we testing bps or ops */
     throttle_init(&ts);
     throttle_timers_init(&tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
-    throttle_config(&ts, QEMU_CLOCK_VIRTUAL, &tt, &cfg);
+    throttle_config(&ts, QEMU_CLOCK_VIRTUAL, &cfg);
 
     /* account a read */
     throttle_account(&ts, false, size);
diff --git a/util/throttle.c b/util/throttle.c
index 3e94807..b2a52b8 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -388,24 +388,14 @@ static void throttle_unfix_bucket(LeakyBucket *bkt)
     }
 }
 
-/* take care of canceling a timer */
-static void throttle_cancel_timer(QEMUTimer *timer)
-{
-    assert(timer != NULL);
-
-    timer_del(timer);
-}
-
 /* Used to configure the throttle
  *
  * @ts: the throttle state we are working on
  * @clock_type: the group's clock_type
- * @tt: the throttle timers we use in this aio context
  * @cfg: the config to set
  */
 void throttle_config(ThrottleState *ts,
                      QEMUClockType clock_type,
-                     ThrottleTimers *tt,
                      ThrottleConfig *cfg)
 {
     int i;
@@ -417,10 +407,6 @@ void throttle_config(ThrottleState *ts,
     }
 
     ts->previous_leak = qemu_clock_get_ns(clock_type);
-
-    for (i = 0; i < 2; i++) {
-        throttle_cancel_timer(tt->timers[i]);
-    }
 }
 
 /* used to get config
-- 
1.8.3.1
