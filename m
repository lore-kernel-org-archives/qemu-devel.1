Received: from eggs.gnu.org ([2001:4830:134:3::10]:56761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dRbnR-0008M9-0t
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 06:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dRbnP-00026P-SE
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 06:08:04 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Sun,  2 Jul 2017 13:06:46 +0300
Message-Id: <20170702100646.20656-3-el13635@mail.ntua.gr>
In-Reply-To: <20170702100646.20656-1-el13635@mail.ntua.gr>
References: <20170702100646.20656-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 2/2] block: remove timer canceling in
 throttle_config()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

throttle_config() cancels the timers of the calling BlockBackend. This
doesn't make sense because other BlockBackends in the group remain
untouched. There's no need to cancel the timers in the one specific
BlockBackend so let's not do that. Throttled requests will run as
scheduled and future requests will follow the new configuration. This
also allows a throttle group's configuration to be changed even when it
has no members.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/throttle-groups.c     | 10 +---------
 fsdev/qemu-fsdev-throttle.c |  2 +-
 include/qemu/throttle.h     |  1 -
 tests/test-throttle.c       |  4 ++--
 util/throttle.c             | 14 --------------
 5 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 71af3f72a1..890bfded3f 100644
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
index 453fb1efde..49eebb5412 100644
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
index 8d2fd77d2b..d056008c18 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -140,7 +140,6 @@ bool throttle_is_valid(ThrottleConfig *cfg, Error **errp);
 
 void throttle_config(ThrottleState *ts,
                      QEMUClockType clock_type,
-                     ThrottleTimers *tt,
                      ThrottleConfig *cfg);
 
 void throttle_get_config(ThrottleState *ts, ThrottleConfig *cfg);
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 2d9cd4647c..768f11dfed 100644
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
index 3e948071dd..b2a52b8b34 100644
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
2.11.0
