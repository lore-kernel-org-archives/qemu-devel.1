Received: from eggs.gnu.org ([2001:4830:134:3::10]:35133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVxAs-0002xn-0P
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVxAq-0002p9-8z
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:46:14 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 14 Jul 2017 12:45:16 +0300
Message-Id: <20170714094521.4909-3-el13635@mail.ntua.gr>
In-Reply-To: <20170714094521.4909-1-el13635@mail.ntua.gr>
References: <20170714094521.4909-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 2/7] block: add aio_context field in
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

timer_cb() needs to know about the current Aio context of the throttle
request that is woken up. In order to make ThrottleGroupMember backend
agnostic, this information is stored in an aio_context field instead of
accessing it from BlockBackend.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/block-backend.c           | 14 ++++-----
 block/throttle-groups.c         | 38 ++++++++++++++++---------
 include/block/throttle-groups.h |  7 ++++-
 tests/test-throttle.c           | 63 +++++++++++++++++++++--------------------
 4 files changed, 69 insertions(+), 53 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 30a60c0e7f..37b95dd20a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1686,17 +1686,15 @@ static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb)
 void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
 {
     BlockDriverState *bs = blk_bs(blk);
-    ThrottleTimers *tt;
+    ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
 
     if (bs) {
-        if (blk->public.throttle_group_member.throttle_state) {
-            tt = &blk->public.throttle_group_member.throttle_timers;
-            throttle_timers_detach_aio_context(tt);
+        if (tgm->throttle_state) {
+            throttle_group_detach_aio_context(tgm);
         }
         bdrv_set_aio_context(bs, new_context);
-        if (blk->public.throttle_group_member.throttle_state) {
-            tt = &blk->public.throttle_group_member.throttle_timers;
-            throttle_timers_attach_aio_context(tt, new_context);
+        if (tgm->throttle_state) {
+            throttle_group_attach_aio_context(tgm, new_context);
         }
     }
 }
@@ -1930,7 +1928,7 @@ void blk_io_limits_disable(BlockBackend *blk)
 void blk_io_limits_enable(BlockBackend *blk, const char *group)
 {
     assert(!blk->public.throttle_group_member.throttle_state);
-    throttle_group_register_tgm(&blk->public.throttle_group_member, group);
+    throttle_group_register_tgm(&blk->public.throttle_group_member, group, blk_get_aio_context(blk));
 }
 
 void blk_io_limits_update_group(BlockBackend *blk, const char *group)
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index c8ed16ddf8..a979e86243 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -391,9 +391,6 @@ static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
 
 static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool is_write)
 {
-    BlockBackendPublic *blkp = container_of(tgm, BlockBackendPublic,
-            throttle_group_member);
-    BlockBackend *blk = blk_by_public(blkp);
     Coroutine *co;
     RestartData rd = {
         .tgm = tgm,
@@ -401,7 +398,7 @@ static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool is_write
     };
 
     co = qemu_coroutine_create(throttle_group_restart_queue_entry, &rd);
-    aio_co_enter(blk_get_aio_context(blk), co);
+    aio_co_enter(tgm->aio_context, co);
 }
 
 void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
@@ -449,13 +446,11 @@ void throttle_group_get_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg)
 /* ThrottleTimers callback. This wakes up a request that was waiting
  * because it had been throttled.
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
 
@@ -484,18 +479,18 @@ static void write_timer_cb(void *opaque)
  *
  * @tgm:       the ThrottleGroupMember to insert
  * @groupname: the name of the group
+ * @ctx:       the AioContext to use
  */
 void throttle_group_register_tgm(ThrottleGroupMember *tgm,
-                                 const char *groupname)
+                                 const char *groupname,
+                                 AioContext *ctx)
 {
     int i;
-    BlockBackendPublic *blkp = container_of(tgm, BlockBackendPublic,
-            throttle_group_member);
-    BlockBackend *blk = blk_by_public(blkp);
     ThrottleState *ts = throttle_group_incref(groupname);
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
 
     tgm->throttle_state = ts;
+    tgm->aio_context = ctx;
 
     qemu_mutex_lock(&tg->lock);
     /* If the ThrottleGroup is new set this ThrottleGroupMember as the token */
@@ -508,11 +503,11 @@ void throttle_group_register_tgm(ThrottleGroupMember *tgm,
     QLIST_INSERT_HEAD(&tg->head, tgm, round_robin);
 
     throttle_timers_init(&tgm->throttle_timers,
-                         blk_get_aio_context(blk),
+                         tgm->aio_context,
                          tg->clock_type,
                          read_timer_cb,
                          write_timer_cb,
-                         blk);
+                         tgm);
 
     qemu_mutex_unlock(&tg->lock);
 }
@@ -559,6 +554,21 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
     tgm->throttle_state = NULL;
 }
 
+void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
+                                       AioContext *new_context)
+{
+    ThrottleTimers *tt = &tgm->throttle_timers;
+    throttle_timers_attach_aio_context(tt, new_context);
+    tgm->aio_context = new_context;
+}
+
+void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
+{
+    tgm->aio_context = NULL;
+    ThrottleTimers *tt = &tgm->throttle_timers;
+    throttle_timers_detach_aio_context(tt);
+}
+
 static void throttle_groups_init(void)
 {
     qemu_mutex_init(&throttle_groups_lock);
diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
index 1a6bcdae74..a0f27cac63 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -33,6 +33,7 @@
  */
 
 typedef struct ThrottleGroupMember {
+    AioContext   *aio_context;
     /* throttled_reqs_lock protects the CoQueues for throttled requests.  */
     CoMutex      throttled_reqs_lock;
     CoQueue      throttled_reqs[2];
@@ -61,12 +62,16 @@ void throttle_group_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg);
 void throttle_group_get_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg);
 
 void throttle_group_register_tgm(ThrottleGroupMember *tgm,
-                                const char *groupname);
+                                const char *groupname,
+                                AioContext *ctx);
 void throttle_group_unregister_tgm(ThrottleGroupMember *tgm);
 void throttle_group_restart_tgm(ThrottleGroupMember *tgm);
 
 void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
                                                         unsigned int bytes,
                                                         bool is_write);
+void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
+                                       AioContext *new_context);
+void throttle_group_detach_aio_context(ThrottleGroupMember *tgm);
 
 #endif
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 6e6d926883..57cf5ba711 100644
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
 
@@ -224,7 +227,7 @@ static void test_config_functions(void)
     orig_cfg.op_size = 1;
 
     throttle_init(&ts);
-    throttle_timers_init(&tt, ctx, QEMU_CLOCK_VIRTUAL,
+    throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
     /* structure reset by throttle_init previous_leak should be null */
     g_assert(!ts.previous_leak);
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
@@ -484,7 +487,7 @@ static bool do_test_accounting(bool is_ops, /* are we testing bps or ops */
     cfg.op_size = op_size;
 
     throttle_init(&ts);
-    throttle_timers_init(&tt, ctx, QEMU_CLOCK_VIRTUAL,
+    throttle_timers_init(tt, ctx, QEMU_CLOCK_VIRTUAL,
                          read_timer_cb, write_timer_cb, &ts);
     throttle_config(&ts, QEMU_CLOCK_VIRTUAL, &cfg);
 
@@ -511,7 +514,7 @@ static bool do_test_accounting(bool is_ops, /* are we testing bps or ops */
         return false;
     }
 
-    throttle_timers_destroy(&tt);
+    throttle_timers_destroy(tt);
 
     return true;
 }
@@ -611,9 +614,9 @@ static void test_groups(void)
     g_assert(tgm2->throttle_state == NULL);
     g_assert(tgm3->throttle_state == NULL);
 
-    throttle_group_register_tgm(tgm1, "bar");
-    throttle_group_register_tgm(tgm2, "foo");
-    throttle_group_register_tgm(tgm3, "bar");
+    throttle_group_register_tgm(tgm1, "bar", blk_get_aio_context(blk1));
+    throttle_group_register_tgm(tgm2, "foo", blk_get_aio_context(blk2));
+    throttle_group_register_tgm(tgm3, "bar", blk_get_aio_context(blk3));
 
     g_assert(tgm1->throttle_state != NULL);
     g_assert(tgm2->throttle_state != NULL);
-- 
2.11.0
