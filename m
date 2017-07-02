Received: from eggs.gnu.org ([2001:4830:134:3::10]:56746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dRbnO-0008KD-Nn
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 06:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dRbnM-00024I-WB
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 06:08:02 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Sun,  2 Jul 2017 13:06:45 +0300
Message-Id: <20170702100646.20656-2-el13635@mail.ntua.gr>
In-Reply-To: <20170702100646.20656-1-el13635@mail.ntua.gr>
References: <20170702100646.20656-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 1/2] block: add clock_type field to
 ThrottleGroup
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

Clock type in throttling is currently inferred by the ThrottleTimer's
clock type even though it is a per-ThrottleGroup property; it doesn't
make sense to have different clock types in the same group. Moving this
to a field in ThrottleGroup can simplify some of the throttle functions.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/throttle-groups.c     | 20 ++++++++++----------
 fsdev/qemu-fsdev-throttle.c |  2 +-
 include/qemu/throttle.h     |  1 +
 tests/test-throttle.c       |  4 ++--
 util/throttle.c             |  4 +++-
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index da2b490c38..71af3f72a1 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -61,6 +61,7 @@ typedef struct ThrottleGroup {
     QLIST_HEAD(, BlockBackendPublic) head;
     BlockBackend *tokens[2];
     bool any_timer_armed[2];
+    QEMUClockType clock_type;
 
     /* These two are protected by the global throttle_groups_lock */
     unsigned refcount;
@@ -98,6 +99,12 @@ ThrottleState *throttle_group_incref(const char *name)
     if (!tg) {
         tg = g_new0(ThrottleGroup, 1);
         tg->name = g_strdup(name);
+        tg->clock_type = QEMU_CLOCK_REALTIME;
+
+        if (qtest_enabled()) {
+            /* For testing block IO throttling only */
+            tg->clock_type = QEMU_CLOCK_VIRTUAL;
+        }
         qemu_mutex_init(&tg->lock);
         throttle_init(&tg->ts);
         QLIST_INIT(&tg->head);
@@ -310,7 +317,7 @@ static void schedule_next_request(BlockBackend *blk, bool is_write)
             token = blk;
         } else {
             ThrottleTimers *tt = &blk_get_public(token)->throttle_timers;
-            int64_t now = qemu_clock_get_ns(tt->clock_type);
+            int64_t now = qemu_clock_get_ns(tg->clock_type);
             timer_mod(tt->timers[is_write], now);
             tg->any_timer_armed[is_write] = true;
         }
@@ -430,7 +437,7 @@ void throttle_group_config(BlockBackend *blk, ThrottleConfig *cfg)
     if (timer_pending(tt->timers[1])) {
         tg->any_timer_armed[1] = false;
     }
-    throttle_config(ts, tt, cfg);
+    throttle_config(ts, tg->clock_type, tt, cfg);
     qemu_mutex_unlock(&tg->lock);
 
     throttle_group_restart_blk(blk);
@@ -497,13 +504,6 @@ void throttle_group_register_blk(BlockBackend *blk, const char *groupname)
     BlockBackendPublic *blkp = blk_get_public(blk);
     ThrottleState *ts = throttle_group_incref(groupname);
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
-    int clock_type = QEMU_CLOCK_REALTIME;
-
-    if (qtest_enabled()) {
-        /* For testing block IO throttling only */
-        clock_type = QEMU_CLOCK_VIRTUAL;
-    }
-
     blkp->throttle_state = ts;
 
     qemu_mutex_lock(&tg->lock);
@@ -518,7 +518,7 @@ void throttle_group_register_blk(BlockBackend *blk, const char *groupname)
 
     throttle_timers_init(&blkp->throttle_timers,
                          blk_get_aio_context(blk),
-                         clock_type,
+                         tg->clock_type,
                          read_timer_cb,
                          write_timer_cb,
                          blk);
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 7ae4e86646..453fb1efde 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -86,7 +86,7 @@ void fsdev_throttle_init(FsThrottle *fst)
                              fsdev_throttle_read_timer_cb,
                              fsdev_throttle_write_timer_cb,
                              fst);
-        throttle_config(&fst->ts, &fst->tt, &fst->cfg);
+        throttle_config(&fst->ts, QEMU_CLOCK_REALTIME, &fst->tt, &fst->cfg);
         qemu_co_queue_init(&fst->throttled_reqs[0]);
         qemu_co_queue_init(&fst->throttled_reqs[1]);
     }
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 9109657609..8d2fd77d2b 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -139,6 +139,7 @@ bool throttle_enabled(ThrottleConfig *cfg);
 bool throttle_is_valid(ThrottleConfig *cfg, Error **errp);
 
 void throttle_config(ThrottleState *ts,
+                     QEMUClockType clock_type,
                      ThrottleTimers *tt,
                      ThrottleConfig *cfg);
 
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index a9201b1fea..2d9cd4647c 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -228,7 +228,7 @@ static void test_config_functions(void)
                          read_timer_cb, write_timer_cb, &ts);
     /* structure reset by throttle_init previous_leak should be null */
     g_assert(!ts.previous_leak);
-    throttle_config(&ts, &tt, &orig_cfg);
+    throttle_config(&ts, QEMU_CLOCK_VIRTUAL, &tt, &orig_cfg);
 
     /* has previous leak been initialized by throttle_config ? */
     g_assert(ts.previous_leak);
@@ -486,7 +486,7 @@ static bool do_test_accounting(bool is_ops, /* are we testing bps or ops */
     throttle_init(&ts);
     throttle_timers_init(&tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
-    throttle_config(&ts, &tt, &cfg);
+    throttle_config(&ts, QEMU_CLOCK_VIRTUAL, &tt, &cfg);
 
     /* account a read */
     throttle_account(&ts, false, size);
diff --git a/util/throttle.c b/util/throttle.c
index 3570ed25fc..3e948071dd 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -399,10 +399,12 @@ static void throttle_cancel_timer(QEMUTimer *timer)
 /* Used to configure the throttle
  *
  * @ts: the throttle state we are working on
+ * @clock_type: the group's clock_type
  * @tt: the throttle timers we use in this aio context
  * @cfg: the config to set
  */
 void throttle_config(ThrottleState *ts,
+                     QEMUClockType clock_type,
                      ThrottleTimers *tt,
                      ThrottleConfig *cfg)
 {
@@ -414,7 +416,7 @@ void throttle_config(ThrottleState *ts,
         throttle_fix_bucket(&ts->cfg.buckets[i]);
     }
 
-    ts->previous_leak = qemu_clock_get_ns(tt->clock_type);
+    ts->previous_leak = qemu_clock_get_ns(clock_type);
 
     for (i = 0; i < 2; i++) {
         throttle_cancel_timer(tt->timers[i]);
-- 
2.11.0
