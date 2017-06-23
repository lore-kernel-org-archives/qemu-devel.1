Received: from eggs.gnu.org ([2001:4830:134:3::10]:60074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0p-0001cG-Q5
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0n-0004TY-Og
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:35 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 23 Jun 2017 15:46:54 +0300
Message-Id: <20170623124700.1389-3-el13635@mail.ntua.gr>
In-Reply-To: <20170623124700.1389-1-el13635@mail.ntua.gr>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH RFC v3 2/8] block: Add aio_context field in
 ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

timer_cb() needs to know about the current Aio context of the throttle
request that is woken up. In order to make ThrottleGroupMember backend
agnostic, this information is stored in an aio_context field instead of
accessing it from BlockBackend.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/block-backend.c   |  1 +
 block/throttle-groups.c | 19 +++++----------
 include/qemu/throttle.h |  1 +
 tests/test-throttle.c   | 65 +++++++++++++++++++++++++++----------------------
 util/throttle.c         |  4 +++
 5 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 90a7abaa53..1d501ec973 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1928,6 +1928,7 @@ void blk_io_limits_disable(BlockBackend *blk)
 /* should be called before blk_set_io_limits if a limit is set */
 void blk_io_limits_enable(BlockBackend *blk, const char *group)
 {
+    blk->public.throttle_group_member.aio_context = blk_get_aio_context(blk);
     assert(!blk->public.throttle_group_member.throttle_state);
     throttle_group_register_tgm(&blk->public.throttle_group_member, group);
 }
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 5e9d8fb4d6..7883cbb511 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -71,6 +71,7 @@ static QemuMutex throttle_groups_lock;
 static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =
     QTAILQ_HEAD_INITIALIZER(throttle_groups);
 
+
 /* Increments the reference count of a ThrottleGroup given its name.
  *
  * If no ThrottleGroup is found with the given name a new one is
@@ -383,9 +384,6 @@ static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
 
 static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool is_write)
 {
-    BlockBackendPublic *blkp = container_of(tgm, BlockBackendPublic,
-            throttle_group_member);
-    BlockBackend *blk = blk_by_public(blkp);
     Coroutine *co;
     RestartData rd = {
         .tgm = tgm,
@@ -393,7 +391,7 @@ static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool is_write
     };
 
     co = qemu_coroutine_create(throttle_group_restart_queue_entry, &rd);
-    aio_co_enter(blk_get_aio_context(blk), co);
+    aio_co_enter(tgm->aio_context, co);
 }
 
 void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
@@ -447,13 +445,11 @@ void throttle_group_get_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg)
 /* ThrottleTimers callback. This wakes up a request that was waiting because it
  * had been throttled.
  *
- * @blk:       the BlockBackend whose request had been throttled
+ * @tgm:       the ThrottleGroupMember whose request had been throttled
  * @is_write:  the type of operation (read/write)
  */
-static void timer_cb(BlockBackend *blk, bool is_write)
+static void timer_cb(ThrottleGroupMember *tgm, bool is_write)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleGroupMember *tgm = &blkp->throttle_group_member;
     ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
 
@@ -487,9 +483,6 @@ void throttle_group_register_tgm(ThrottleGroupMember *tgm,
                                  const char *groupname)
 {
     int i;
-    BlockBackendPublic *blkp = container_of(tgm, BlockBackendPublic,
-            throttle_group_member);
-    BlockBackend *blk = blk_by_public(blkp);
     ThrottleState *ts = throttle_group_incref(groupname);
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     int clock_type = QEMU_CLOCK_REALTIME;
@@ -512,11 +505,11 @@ void throttle_group_register_tgm(ThrottleGroupMember *tgm,
     QLIST_INSERT_HEAD(&tg->head, tgm, round_robin);
 
     throttle_timers_init(&tgm->throttle_timers,
-                         blk_get_aio_context(blk),
+                         tgm->aio_context,
                          clock_type,
                          read_timer_cb,
                          write_timer_cb,
-                         blk);
+                         tgm);
 
     qemu_mutex_unlock(&tg->lock);
 }
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index e99cbfc865..3e92d4d4eb 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -160,6 +160,7 @@ void throttle_account(ThrottleState *ts, bool is_write, uint64_t size);
  */
 
 typedef struct ThrottleGroupMember {
+    AioContext  *aio_context;
     /* throttled_reqs_lock protects the CoQueues for throttled requests.  */
     CoMutex      throttled_reqs_lock;
     CoQueue      throttled_reqs[2];
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 0f95da2592..d3298234aa 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -24,8 +24,9 @@
 static AioContext     *ctx;
 static LeakyBucket    bkt;
 static ThrottleConfig cfg;
+static ThrottleGroupMember tgm;
 static ThrottleState  ts;
-static ThrottleTimers tt;
+static ThrottleTimers *tt;
 
 /* useful function */
 static bool double_cmp(double x, double y)
@@ -153,19 +154,21 @@ static void test_init(void)
 {
     int i;
 
+    tt = &tgm.throttle_timers;
+
     /* fill the structures with crap */
     memset(&ts, 1, sizeof(ts));
-    memset(&tt, 1, sizeof(tt));
+    memset(tt, 1, sizeof(*tt));
 
     /* init structures */
     throttle_init(&ts);
-    throttle_timers_init(&tt, ctx, QEMU_CLOCK_VIRTUAL,
+    throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
 
     /* check initialized fields */
-    g_assert(tt.clock_type == QEMU_CLOCK_VIRTUAL);
-    g_assert(tt.timers[0]);
-    g_assert(tt.timers[1]);
+    g_assert(tt->clock_type == QEMU_CLOCK_VIRTUAL);
+    g_assert(tt->timers[0]);
+    g_assert(tt->timers[1]);
 
     /* check other fields where cleared */
     g_assert(!ts.previous_leak);
@@ -176,18 +179,18 @@ static void test_init(void)
         g_assert(!ts.cfg.buckets[i].level);
     }
 
-    throttle_timers_destroy(&tt);
+    throttle_timers_destroy(tt);
 }
 
 static void test_destroy(void)
 {
     int i;
     throttle_init(&ts);
-    throttle_timers_init(&tt, ctx, QEMU_CLOCK_VIRTUAL,
+    throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
-    throttle_timers_destroy(&tt);
+    throttle_timers_destroy(tt);
     for (i = 0; i < 2; i++) {
-        g_assert(!tt.timers[i]);
+        g_assert(!tt->timers[i]);
     }
 }
 
@@ -224,11 +227,11 @@ static void test_config_functions(void)
     orig_cfg.op_size = 1;
 
     throttle_init(&ts);
-    throttle_timers_init(&tt, ctx, QEMU_CLOCK_VIRTUAL,
+    throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
     /* structure reset by throttle_init previous_leak should be null */
     g_assert(!ts.previous_leak);
-    throttle_config(&ts, &tt, &orig_cfg);
+    throttle_config(&ts, tt, &orig_cfg);
 
     /* has previous leak been initialized by throttle_config ? */
     g_assert(ts.previous_leak);
@@ -236,7 +239,7 @@ static void test_config_functions(void)
     /* get back the fixed configuration */
     throttle_get_config(&ts, &final_cfg);
 
-    throttle_timers_destroy(&tt);
+    throttle_timers_destroy(tt);
 
     g_assert(final_cfg.buckets[THROTTLE_BPS_TOTAL].avg == 153);
     g_assert(final_cfg.buckets[THROTTLE_BPS_READ].avg  == 56);
@@ -417,45 +420,45 @@ static void test_have_timer(void)
 {
     /* zero structures */
     memset(&ts, 0, sizeof(ts));
-    memset(&tt, 0, sizeof(tt));
+    memset(tt, 0, sizeof(*tt));
 
     /* no timer set should return false */
-    g_assert(!throttle_timers_are_initialized(&tt));
+    g_assert(!throttle_timers_are_initialized(tt));
 
     /* init structures */
     throttle_init(&ts);
-    throttle_timers_init(&tt, ctx, QEMU_CLOCK_VIRTUAL,
+    throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
 
     /* timer set by init should return true */
-    g_assert(throttle_timers_are_initialized(&tt));
+    g_assert(throttle_timers_are_initialized(tt));
 
-    throttle_timers_destroy(&tt);
+    throttle_timers_destroy(tt);
 }
 
 static void test_detach_attach(void)
 {
     /* zero structures */
     memset(&ts, 0, sizeof(ts));
-    memset(&tt, 0, sizeof(tt));
+    memset(tt, 0, sizeof(*tt));
 
     /* init the structure */
     throttle_init(&ts);
-    throttle_timers_init(&tt, ctx, QEMU_CLOCK_VIRTUAL,
+    throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
 
     /* timer set by init should return true */
-    g_assert(throttle_timers_are_initialized(&tt));
+    g_assert(throttle_timers_are_initialized(tt));
 
     /* timer should no longer exist after detaching */
-    throttle_timers_detach_aio_context(&tt);
-    g_assert(!throttle_timers_are_initialized(&tt));
+    throttle_timers_detach_aio_context(tt);
+    g_assert(!throttle_timers_are_initialized(tt));
 
     /* timer should exist again after attaching */
-    throttle_timers_attach_aio_context(&tt, ctx);
-    g_assert(throttle_timers_are_initialized(&tt));
+    throttle_timers_attach_aio_context(tt, ctx);
+    g_assert(throttle_timers_are_initialized(tt));
 
-    throttle_timers_destroy(&tt);
+    throttle_timers_destroy(tt);
 }
 
 static bool do_test_accounting(bool is_ops, /* are we testing bps or ops */
@@ -484,9 +487,9 @@ static bool do_test_accounting(bool is_ops, /* are we testing bps or ops */
     cfg.op_size = op_size;
 
     throttle_init(&ts);
-    throttle_timers_init(&tt, ctx, QEMU_CLOCK_VIRTUAL,
+    throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
-    throttle_config(&ts, &tt, &cfg);
+    throttle_config(&ts, tt, &cfg);
 
     /* account a read */
     throttle_account(&ts, false, size);
@@ -511,7 +514,7 @@ static bool do_test_accounting(bool is_ops, /* are we testing bps or ops */
         return false;
     }
 
-    throttle_timers_destroy(&tt);
+    throttle_timers_destroy(tt);
 
     return true;
 }
@@ -607,6 +610,10 @@ static void test_groups(void)
     tgm2 = &blkp2->throttle_group_member;
     tgm3 = &blkp3->throttle_group_member;
 
+    tgm1->aio_context = blk_get_aio_context(blk1);
+    tgm2->aio_context = blk_get_aio_context(blk2);
+    tgm3->aio_context = blk_get_aio_context(blk3);
+
     g_assert(tgm1->throttle_state == NULL);
     g_assert(tgm2->throttle_state == NULL);
     g_assert(tgm3->throttle_state == NULL);
diff --git a/util/throttle.c b/util/throttle.c
index 3570ed25fc..e763474b1a 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -185,6 +185,8 @@ static bool throttle_compute_timer(ThrottleState *ts,
 void throttle_timers_attach_aio_context(ThrottleTimers *tt,
                                         AioContext *new_context)
 {
+    ThrottleGroupMember *tgm = container_of(tt, ThrottleGroupMember, throttle_timers);
+    tgm->aio_context = new_context;
     tt->timers[0] = aio_timer_new(new_context, tt->clock_type, SCALE_NS,
                                   tt->read_timer_cb, tt->timer_opaque);
     tt->timers[1] = aio_timer_new(new_context, tt->clock_type, SCALE_NS,
@@ -242,6 +244,8 @@ static void throttle_timer_destroy(QEMUTimer **timer)
 void throttle_timers_detach_aio_context(ThrottleTimers *tt)
 {
     int i;
+    ThrottleGroupMember *tgm = container_of(tt, ThrottleGroupMember, throttle_timers);
+    tgm->aio_context = NULL;
 
     for (i = 0; i < 2; i++) {
         throttle_timer_destroy(&tt->timers[i]);
-- 
2.11.0
