Received: from eggs.gnu.org ([2001:4830:134:3::10]:60184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0w-0001wF-EZ
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0r-0004WD-Lw
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:42 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 23 Jun 2017 15:46:53 +0300
Message-Id: <20170623124700.1389-2-el13635@mail.ntua.gr>
In-Reply-To: <20170623124700.1389-1-el13635@mail.ntua.gr>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH RFC v3 1/8] block: move ThrottleGroup
 membership to ThrottleGroupMember
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

This commit gathers ThrottleGroup membership details from
BlockBackendPublic into ThrottleGroupMember and refactors existing code
to use the structure.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/block-backend.c           |  66 +++++----
 block/qapi.c                    |   8 +-
 block/throttle-groups.c         | 304 ++++++++++++++++++++--------------------
 blockdev.c                      |   4 +-
 include/block/throttle-groups.h |  15 +-
 include/qemu/throttle.h         |  26 ++++
 include/sysemu/block-backend.h  |  20 +--
 tests/test-throttle.c           |  53 +++----
 8 files changed, 260 insertions(+), 236 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index a2bbae90b1..90a7abaa53 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -216,9 +216,9 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
     blk->shared_perm = shared_perm;
     blk_set_enable_write_cache(blk, true);
 
-    qemu_co_mutex_init(&blk->public.throttled_reqs_lock);
-    qemu_co_queue_init(&blk->public.throttled_reqs[0]);
-    qemu_co_queue_init(&blk->public.throttled_reqs[1]);
+    qemu_co_mutex_init(&blk->public.throttle_group_member.throttled_reqs_lock);
+    qemu_co_queue_init(&blk->public.throttle_group_member.throttled_reqs[0]);
+    qemu_co_queue_init(&blk->public.throttle_group_member.throttled_reqs[1]);
     block_acct_init(&blk->stats);
 
     notifier_list_init(&blk->remove_bs_notifiers);
@@ -286,7 +286,7 @@ static void blk_delete(BlockBackend *blk)
     assert(!blk->refcnt);
     assert(!blk->name);
     assert(!blk->dev);
-    if (blk->public.throttle_state) {
+    if (blk->public.throttle_group_member.throttle_state) {
         blk_io_limits_disable(blk);
     }
     if (blk->root) {
@@ -597,9 +597,12 @@ BlockBackend *blk_by_public(BlockBackendPublic *public)
  */
 void blk_remove_bs(BlockBackend *blk)
 {
+    ThrottleTimers *tt;
+
     notifier_list_notify(&blk->remove_bs_notifiers, blk);
-    if (blk->public.throttle_state) {
-        throttle_timers_detach_aio_context(&blk->public.throttle_timers);
+    if (blk->public.throttle_group_member.throttle_state) {
+        tt = &blk->public.throttle_group_member.throttle_timers;
+        throttle_timers_detach_aio_context(tt);
     }
 
     blk_update_root_state(blk);
@@ -621,9 +624,10 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
     bdrv_ref(bs);
 
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
-    if (blk->public.throttle_state) {
+    if (blk->public.throttle_group_member.throttle_state) {
         throttle_timers_attach_aio_context(
-            &blk->public.throttle_timers, bdrv_get_aio_context(bs));
+            &blk->public.throttle_group_member.throttle_timers,
+            bdrv_get_aio_context(bs));
     }
 
     return 0;
@@ -985,8 +989,9 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
     bdrv_inc_in_flight(bs);
 
     /* throttling disk I/O */
-    if (blk->public.throttle_state) {
-        throttle_group_co_io_limits_intercept(blk, bytes, false);
+    if (blk->public.throttle_group_member.throttle_state) {
+        throttle_group_co_io_limits_intercept(&blk->public.throttle_group_member,
+                bytes, false);
     }
 
     ret = bdrv_co_preadv(blk->root, offset, bytes, qiov, flags);
@@ -1009,10 +1014,10 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
     }
 
     bdrv_inc_in_flight(bs);
-
     /* throttling disk I/O */
-    if (blk->public.throttle_state) {
-        throttle_group_co_io_limits_intercept(blk, bytes, true);
+    if (blk->public.throttle_group_member.throttle_state) {
+        throttle_group_co_io_limits_intercept(&blk->public.throttle_group_member,
+                bytes, true);
     }
 
     if (!blk->enable_write_cache) {
@@ -1681,15 +1686,17 @@ static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb)
 void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
 {
     BlockDriverState *bs = blk_bs(blk);
+    ThrottleTimers *tt;
 
     if (bs) {
-        if (blk->public.throttle_state) {
-            throttle_timers_detach_aio_context(&blk->public.throttle_timers);
+        if (blk->public.throttle_group_member.throttle_state) {
+            tt = &blk->public.throttle_group_member.throttle_timers;
+            throttle_timers_detach_aio_context(tt);
         }
         bdrv_set_aio_context(bs, new_context);
-        if (blk->public.throttle_state) {
-            throttle_timers_attach_aio_context(&blk->public.throttle_timers,
-                                               new_context);
+        if (blk->public.throttle_group_member.throttle_state) {
+            tt = &blk->public.throttle_group_member.throttle_timers;
+            throttle_timers_attach_aio_context(tt, new_context);
         }
     }
 }
@@ -1907,33 +1914,34 @@ int blk_commit_all(void)
 /* throttling disk I/O limits */
 void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg)
 {
-    throttle_group_config(blk, cfg);
+    throttle_group_config(&blk->public.throttle_group_member, cfg);
 }
 
 void blk_io_limits_disable(BlockBackend *blk)
 {
-    assert(blk->public.throttle_state);
+    assert(blk->public.throttle_group_member.throttle_state);
     bdrv_drained_begin(blk_bs(blk));
-    throttle_group_unregister_blk(blk);
+    throttle_group_unregister_tgm(&blk->public.throttle_group_member);
     bdrv_drained_end(blk_bs(blk));
 }
 
 /* should be called before blk_set_io_limits if a limit is set */
 void blk_io_limits_enable(BlockBackend *blk, const char *group)
 {
-    assert(!blk->public.throttle_state);
-    throttle_group_register_blk(blk, group);
+    assert(!blk->public.throttle_group_member.throttle_state);
+    throttle_group_register_tgm(&blk->public.throttle_group_member, group);
 }
 
 void blk_io_limits_update_group(BlockBackend *blk, const char *group)
 {
     /* this BB is not part of any group */
-    if (!blk->public.throttle_state) {
+    if (!blk->public.throttle_group_member.throttle_state) {
         return;
     }
 
     /* this BB is a part of the same group than the one we want */
-    if (!g_strcmp0(throttle_group_get_name(blk), group)) {
+    if (!g_strcmp0(throttle_group_get_name(&blk->public.throttle_group_member),
+                group)) {
         return;
     }
 
@@ -1955,8 +1963,8 @@ static void blk_root_drained_begin(BdrvChild *child)
     /* Note that blk->root may not be accessible here yet if we are just
      * attaching to a BlockDriverState that is drained. Use child instead. */
 
-    if (atomic_fetch_inc(&blk->public.io_limits_disabled) == 0) {
-        throttle_group_restart_blk(blk);
+    if (atomic_fetch_inc(&blk->public.throttle_group_member.io_limits_disabled) == 0) {
+        throttle_group_restart_tgm(&blk->public.throttle_group_member);
     }
 }
 
@@ -1965,8 +1973,8 @@ static void blk_root_drained_end(BdrvChild *child)
     BlockBackend *blk = child->opaque;
     assert(blk->quiesce_counter);
 
-    assert(blk->public.io_limits_disabled);
-    atomic_dec(&blk->public.io_limits_disabled);
+    assert(blk->public.throttle_group_member.io_limits_disabled);
+    atomic_dec(&blk->public.throttle_group_member.io_limits_disabled);
 
     if (--blk->quiesce_counter == 0) {
         if (blk->dev_ops && blk->dev_ops->drained_end) {
diff --git a/block/qapi.c b/block/qapi.c
index 0a41d59bf3..70ec5552be 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -67,10 +67,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
     info->backing_file_depth = bdrv_get_backing_file_depth(bs);
     info->detect_zeroes = bs->detect_zeroes;
 
-    if (blk && blk_get_public(blk)->throttle_state) {
+    if (blk && blk_get_public(blk)->throttle_group_member.throttle_state) {
         ThrottleConfig cfg;
+        BlockBackendPublic *blkp = blk_get_public(blk);
 
-        throttle_group_get_config(blk, &cfg);
+        throttle_group_get_config(&blkp->throttle_group_member, &cfg);
 
         info->bps     = cfg.buckets[THROTTLE_BPS_TOTAL].avg;
         info->bps_rd  = cfg.buckets[THROTTLE_BPS_READ].avg;
@@ -118,7 +119,8 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         info->iops_size = cfg.op_size;
 
         info->has_group = true;
-        info->group = g_strdup(throttle_group_get_name(blk));
+        info->group =
+            g_strdup(throttle_group_get_name(&blkp->throttle_group_member));
     }
 
     info->write_threshold = bdrv_write_threshold_get(bs);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index a181cb1dee..5e9d8fb4d6 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -30,7 +30,7 @@
 #include "sysemu/qtest.h"
 
 /* The ThrottleGroup structure (with its ThrottleState) is shared
- * among different BlockBackends and it's independent from
+ * among different ThrottleGroupMembers and it's independent from
  * AioContext, so in order to use it from different threads it needs
  * its own locking.
  *
@@ -40,7 +40,7 @@
  * The whole ThrottleGroup structure is private and invisible to
  * outside users, that only use it through its ThrottleState.
  *
- * In addition to the ThrottleGroup structure, BlockBackendPublic has
+ * In addition to the ThrottleGroup structure, ThrottleGroupMember has
  * fields that need to be accessed by other members of the group and
  * therefore also need to be protected by this lock. Once a
  * BlockBackend is registered in a group those fields can be accessed
@@ -58,8 +58,8 @@ typedef struct ThrottleGroup {
 
     QemuMutex lock; /* This lock protects the following four fields */
     ThrottleState ts;
-    QLIST_HEAD(, BlockBackendPublic) head;
-    BlockBackend *tokens[2];
+    QLIST_HEAD(, ThrottleGroupMember) head;
+    ThrottleGroupMember *tokens[2];
     bool any_timer_armed[2];
 
     /* These two are protected by the global throttle_groups_lock */
@@ -133,114 +133,112 @@ void throttle_group_unref(ThrottleState *ts)
     qemu_mutex_unlock(&throttle_groups_lock);
 }
 
-/* Get the name from a BlockBackend's ThrottleGroup. The name (and the pointer)
+/* Get the name from a ThrottleGroupMember's group. The name (and the pointer)
  * is guaranteed to remain constant during the lifetime of the group.
  *
- * @blk:  a BlockBackend that is member of a throttling group
+ * @tgm:  a ThrottleGroupMember
  * @ret:  the name of the group.
  */
-const char *throttle_group_get_name(BlockBackend *blk)
+const char *throttle_group_get_name(ThrottleGroupMember *tgm)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleGroup *tg = container_of(blkp->throttle_state, ThrottleGroup, ts);
+    ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
     return tg->name;
 }
 
-/* Return the next BlockBackend in the round-robin sequence, simulating a
- * circular list.
+/* Return the next ThrottleGroupMember in the round-robin sequence, simulating
+ * a circular list.
  *
  * This assumes that tg->lock is held.
  *
- * @blk: the current BlockBackend
- * @ret: the next BlockBackend in the sequence
+ * @tgm: the current ThrottleGroupMember
+ * @ret: the next ThrottleGroupMember in the sequence
  */
-static BlockBackend *throttle_group_next_blk(BlockBackend *blk)
+static ThrottleGroupMember *throttle_group_next_tgm(ThrottleGroupMember *tgm)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleState *ts = blkp->throttle_state;
+    ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
-    BlockBackendPublic *next = QLIST_NEXT(blkp, round_robin);
+    ThrottleGroupMember *next = QLIST_NEXT(tgm, round_robin);
 
     if (!next) {
         next = QLIST_FIRST(&tg->head);
     }
 
-    return blk_by_public(next);
+    return next;
 }
 
 /*
- * Return whether a BlockBackend has pending requests.
+ * Return whether a ThrottleGroupMember has pending requests.
  *
  * This assumes that tg->lock is held.
  *
- * @blk: the BlockBackend
- * @is_write:  the type of operation (read/write)
- * @ret:       whether the BlockBackend has pending requests.
+ * @tgm:        the ThrottleGroupMember
+ * @is_write:   the type of operation (read/write)
+ * @ret:        whether the ThrottleGroupMember has pending requests.
  */
-static inline bool blk_has_pending_reqs(BlockBackend *blk,
+static inline bool tgm_has_pending_reqs(ThrottleGroupMember *tgm,
                                         bool is_write)
 {
-    const BlockBackendPublic *blkp = blk_get_public(blk);
-    return blkp->pending_reqs[is_write];
+    return tgm->pending_reqs[is_write];
 }
 
-/* Return the next BlockBackend in the round-robin sequence with pending I/O
- * requests.
+/* Return the next ThrottleGroupMember in the round-robin sequence with pending
+ * I/O requests.
  *
  * This assumes that tg->lock is held.
  *
- * @blk:       the current BlockBackend
+ * @tgm:       the current ThrottleGroupMember
  * @is_write:  the type of operation (read/write)
- * @ret:       the next BlockBackend with pending requests, or blk if there is
- *             none.
+ * @ret:       the next ThrottleGroupMember with pending requests, or tgm if
+ *             there is none.
  */
-static BlockBackend *next_throttle_token(BlockBackend *blk, bool is_write)
+static ThrottleGroupMember *next_throttle_token(ThrottleGroupMember *tgm,
+                                                bool is_write)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleGroup *tg = container_of(blkp->throttle_state, ThrottleGroup, ts);
-    BlockBackend *token, *start;
+    ThrottleState *ts = tgm->throttle_state;
+    ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
+    ThrottleGroupMember *token, *start;
 
     start = token = tg->tokens[is_write];
 
     /* get next bs round in round robin style */
-    token = throttle_group_next_blk(token);
-    while (token != start && !blk_has_pending_reqs(token, is_write)) {
-        token = throttle_group_next_blk(token);
+    token = throttle_group_next_tgm(token);
+    while (token != start && !tgm_has_pending_reqs(token, is_write)) {
+        token = throttle_group_next_tgm(token);
     }
 
     /* If no IO are queued for scheduling on the next round robin token
-     * then decide the token is the current bs because chances are
-     * the current bs get the current request queued.
+     * then decide the token is the current tgm because chances are
+     * the current tgm get the current request queued.
      */
-    if (token == start && !blk_has_pending_reqs(token, is_write)) {
-        token = blk;
+    if (token == start && !tgm_has_pending_reqs(token, is_write)) {
+        token = tgm;
     }
 
-    /* Either we return the original BB, or one with pending requests */
-    assert(token == blk || blk_has_pending_reqs(token, is_write));
+    /* Either we return the original TGM, or one with pending requests */
+    assert(token == tgm || tgm_has_pending_reqs(token, is_write));
 
     return token;
 }
 
-/* Check if the next I/O request for a BlockBackend needs to be throttled or
- * not. If there's no timer set in this group, set one and update the token
- * accordingly.
+/* Check if the next I/O request for a ThrottleGroupMember needs to be
+ * throttled or not. If there's no timer set in this group, set one and update
+ * the token accordingly.
  *
  * This assumes that tg->lock is held.
  *
- * @blk:        the current BlockBackend
+ * @tgm:        the current ThrottleGroupMember
  * @is_write:   the type of operation (read/write)
  * @ret:        whether the I/O request needs to be throttled or not
  */
-static bool throttle_group_schedule_timer(BlockBackend *blk, bool is_write)
+static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
+                                          bool is_write)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleState *ts = blkp->throttle_state;
-    ThrottleTimers *tt = &blkp->throttle_timers;
+    ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
+    ThrottleTimers *tt = &tgm->throttle_timers;
     bool must_wait;
 
-    if (atomic_read(&blkp->io_limits_disabled)) {
+    if (atomic_read(&tgm->io_limits_disabled)) {
         return false;
     }
 
@@ -251,30 +249,29 @@ static bool throttle_group_schedule_timer(BlockBackend *blk, bool is_write)
 
     must_wait = throttle_schedule_timer(ts, tt, is_write);
 
-    /* If a timer just got armed, set blk as the current token */
+    /* If a timer just got armed, set tgm as the current token */
     if (must_wait) {
-        tg->tokens[is_write] = blk;
+        tg->tokens[is_write] = tgm;
         tg->any_timer_armed[is_write] = true;
     }
 
     return must_wait;
 }
 
-/* Start the next pending I/O request for a BlockBackend.  Return whether
+/* Start the next pending I/O request for a ThrottleGroupMember.  Return whether
  * any request was actually pending.
  *
- * @blk:       the current BlockBackend
+ * @tgm:       the current ThrottleGroupMember
  * @is_write:  the type of operation (read/write)
  */
-static bool coroutine_fn throttle_group_co_restart_queue(BlockBackend *blk,
+static bool coroutine_fn throttle_group_co_restart_queue(ThrottleGroupMember *tgm,
                                                          bool is_write)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
     bool ret;
 
-    qemu_co_mutex_lock(&blkp->throttled_reqs_lock);
-    ret = qemu_co_queue_next(&blkp->throttled_reqs[is_write]);
-    qemu_co_mutex_unlock(&blkp->throttled_reqs_lock);
+    qemu_co_mutex_lock(&tgm->throttled_reqs_lock);
+    ret = qemu_co_queue_next(&tgm->throttled_reqs[is_write]);
+    qemu_co_mutex_unlock(&tgm->throttled_reqs_lock);
 
     return ret;
 }
@@ -283,19 +280,19 @@ static bool coroutine_fn throttle_group_co_restart_queue(BlockBackend *blk,
  *
  * This assumes that tg->lock is held.
  *
- * @blk:       the current BlockBackend
+ * @tgm:       the current ThrottleGroupMember
  * @is_write:  the type of operation (read/write)
  */
-static void schedule_next_request(BlockBackend *blk, bool is_write)
+static void schedule_next_request(ThrottleGroupMember *tgm, bool is_write)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleGroup *tg = container_of(blkp->throttle_state, ThrottleGroup, ts);
+    ThrottleState *ts = tgm->throttle_state;
+    ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     bool must_wait;
-    BlockBackend *token;
+    ThrottleGroupMember *token;
 
     /* Check if there's any pending request to schedule next */
-    token = next_throttle_token(blk, is_write);
-    if (!blk_has_pending_reqs(token, is_write)) {
+    token = next_throttle_token(tgm, is_write);
+    if (!tgm_has_pending_reqs(token, is_write)) {
         return;
     }
 
@@ -304,12 +301,12 @@ static void schedule_next_request(BlockBackend *blk, bool is_write)
 
     /* If it doesn't have to wait, queue it for immediate execution */
     if (!must_wait) {
-        /* Give preference to requests from the current blk */
+        /* Give preference to requests from the current tgm */
         if (qemu_in_coroutine() &&
-            throttle_group_co_restart_queue(blk, is_write)) {
-            token = blk;
+            throttle_group_co_restart_queue(tgm, is_write)) {
+            token = tgm;
         } else {
-            ThrottleTimers *tt = &blk_get_public(token)->throttle_timers;
+            ThrottleTimers *tt = &token->throttle_timers;
             int64_t now = qemu_clock_get_ns(tt->clock_type);
             timer_mod(tt->timers[is_write], now);
             tg->any_timer_armed[is_write] = true;
@@ -318,80 +315,80 @@ static void schedule_next_request(BlockBackend *blk, bool is_write)
     }
 }
 
-/* Check if an I/O request needs to be throttled, wait and set a timer
- * if necessary, and schedule the next request using a round robin
- * algorithm.
+/* Check if an I/O request needs to be throttled, wait and set a timer if
+ * necessary, and schedule the next request using a round robin algorithm.
  *
- * @blk:       the current BlockBackend
+ * @tgm:       the current ThrottleGroupMember
  * @bytes:     the number of bytes for this I/O
  * @is_write:  the type of operation (read/write)
  */
-void coroutine_fn throttle_group_co_io_limits_intercept(BlockBackend *blk,
+void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
                                                         unsigned int bytes,
                                                         bool is_write)
 {
     bool must_wait;
-    BlockBackend *token;
-
-    BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleGroup *tg = container_of(blkp->throttle_state, ThrottleGroup, ts);
+    ThrottleGroupMember *token;
+    ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
     qemu_mutex_lock(&tg->lock);
 
     /* First we check if this I/O has to be throttled. */
-    token = next_throttle_token(blk, is_write);
+    token = next_throttle_token(tgm, is_write);
     must_wait = throttle_group_schedule_timer(token, is_write);
 
     /* Wait if there's a timer set or queued requests of this type */
-    if (must_wait || blkp->pending_reqs[is_write]) {
-        blkp->pending_reqs[is_write]++;
+    if (must_wait || tgm->pending_reqs[is_write]) {
+        tgm->pending_reqs[is_write]++;
         qemu_mutex_unlock(&tg->lock);
-        qemu_co_mutex_lock(&blkp->throttled_reqs_lock);
-        qemu_co_queue_wait(&blkp->throttled_reqs[is_write],
-                           &blkp->throttled_reqs_lock);
-        qemu_co_mutex_unlock(&blkp->throttled_reqs_lock);
+        qemu_co_mutex_lock(&tgm->throttled_reqs_lock);
+        qemu_co_queue_wait(&tgm->throttled_reqs[is_write],
+                           &tgm->throttled_reqs_lock);
+        qemu_co_mutex_unlock(&tgm->throttled_reqs_lock);
         qemu_mutex_lock(&tg->lock);
-        blkp->pending_reqs[is_write]--;
+        tgm->pending_reqs[is_write]--;
     }
 
     /* The I/O will be executed, so do the accounting */
-    throttle_account(blkp->throttle_state, is_write, bytes);
+    throttle_account(tgm->throttle_state, is_write, bytes);
 
     /* Schedule the next request */
-    schedule_next_request(blk, is_write);
+    schedule_next_request(tgm, is_write);
 
     qemu_mutex_unlock(&tg->lock);
 }
 
 typedef struct {
-    BlockBackend *blk;
+    ThrottleGroupMember *tgm;
     bool is_write;
 } RestartData;
 
 static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
 {
     RestartData *data = opaque;
-    BlockBackend *blk = data->blk;
+    ThrottleGroupMember *tgm = data->tgm;
+    ThrottleState *ts = tgm->throttle_state;
+    ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     bool is_write = data->is_write;
-    BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleGroup *tg = container_of(blkp->throttle_state, ThrottleGroup, ts);
     bool empty_queue;
 
-    empty_queue = !throttle_group_co_restart_queue(blk, is_write);
+    empty_queue = !throttle_group_co_restart_queue(tgm, is_write);
 
     /* If the request queue was empty then we have to take care of
      * scheduling the next one */
     if (empty_queue) {
         qemu_mutex_lock(&tg->lock);
-        schedule_next_request(blk, is_write);
+        schedule_next_request(tgm, is_write);
         qemu_mutex_unlock(&tg->lock);
     }
 }
 
-static void throttle_group_restart_queue(BlockBackend *blk, bool is_write)
+static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool is_write)
 {
+    BlockBackendPublic *blkp = container_of(tgm, BlockBackendPublic,
+            throttle_group_member);
+    BlockBackend *blk = blk_by_public(blkp);
     Coroutine *co;
     RestartData rd = {
-        .blk = blk,
+        .tgm = tgm,
         .is_write = is_write
     };
 
@@ -399,28 +396,24 @@ static void throttle_group_restart_queue(BlockBackend *blk, bool is_write)
     aio_co_enter(blk_get_aio_context(blk), co);
 }
 
-void throttle_group_restart_blk(BlockBackend *blk)
+void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
-
-    if (blkp->throttle_state) {
-        throttle_group_restart_queue(blk, 0);
-        throttle_group_restart_queue(blk, 1);
+    if (tgm->throttle_state) {
+        throttle_group_restart_queue(tgm, 0);
+        throttle_group_restart_queue(tgm, 1);
     }
 }
 
-/* Update the throttle configuration for a particular group. Similar
- * to throttle_config(), but guarantees atomicity within the
- * throttling group.
+/* Update the throttle configuration for a particular group. Similar to
+ * throttle_config(), but guarantees atomicity within the throttling group.
  *
- * @blk: a BlockBackend that is a member of the group
- * @cfg: the configuration to set
+ * @tgm:    a ThrottleGroupMember that is a member of the group
+ * @cfg:    the configuration to set
  */
-void throttle_group_config(BlockBackend *blk, ThrottleConfig *cfg)
+void throttle_group_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleTimers *tt = &blkp->throttle_timers;
-    ThrottleState *ts = blkp->throttle_state;
+    ThrottleTimers *tt = &tgm->throttle_timers;
+    ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     qemu_mutex_lock(&tg->lock);
     /* throttle_config() cancels the timers */
@@ -433,28 +426,26 @@ void throttle_group_config(BlockBackend *blk, ThrottleConfig *cfg)
     throttle_config(ts, tt, cfg);
     qemu_mutex_unlock(&tg->lock);
 
-    throttle_group_restart_blk(blk);
+    throttle_group_restart_tgm(tgm);
 }
 
 /* Get the throttle configuration from a particular group. Similar to
- * throttle_get_config(), but guarantees atomicity within the
- * throttling group.
+ * throttle_get_config(), but guarantees atomicity within the throttling group.
  *
- * @blk: a BlockBackend that is a member of the group
- * @cfg: the configuration will be written here
+ * @tgm:    a ThrottleGroupMember that is a member of the group
+ * @cfg:    the configuration will be written here
  */
-void throttle_group_get_config(BlockBackend *blk, ThrottleConfig *cfg)
+void throttle_group_get_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleState *ts = blkp->throttle_state;
+    ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     qemu_mutex_lock(&tg->lock);
     throttle_get_config(ts, cfg);
     qemu_mutex_unlock(&tg->lock);
 }
 
-/* ThrottleTimers callback. This wakes up a request that was waiting
- * because it had been throttled.
+/* ThrottleTimers callback. This wakes up a request that was waiting because it
+ * had been throttled.
  *
  * @blk:       the BlockBackend whose request had been throttled
  * @is_write:  the type of operation (read/write)
@@ -462,7 +453,8 @@ void throttle_group_get_config(BlockBackend *blk, ThrottleConfig *cfg)
 static void timer_cb(BlockBackend *blk, bool is_write)
 {
     BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleState *ts = blkp->throttle_state;
+    ThrottleGroupMember *tgm = &blkp->throttle_group_member;
+    ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
 
     /* The timer has just been fired, so we can update the flag */
@@ -471,7 +463,7 @@ static void timer_cb(BlockBackend *blk, bool is_write)
     qemu_mutex_unlock(&tg->lock);
 
     /* Run the request that was waiting for this timer */
-    throttle_group_restart_queue(blk, is_write);
+    throttle_group_restart_queue(tgm, is_write);
 }
 
 static void read_timer_cb(void *opaque)
@@ -484,17 +476,20 @@ static void write_timer_cb(void *opaque)
     timer_cb(opaque, true);
 }
 
-/* Register a BlockBackend in the throttling group, also initializing its
- * timers and updating its throttle_state pointer to point to it. If a
+/* Register a ThrottleGroupMember from the throttling group, also initializing
+ * its timers and updating its throttle_state pointer to point to it. If a
  * throttling group with that name does not exist yet, it will be created.
  *
- * @blk:       the BlockBackend to insert
+ * @tgm:       the ThrottleGroupMember to insert
  * @groupname: the name of the group
  */
-void throttle_group_register_blk(BlockBackend *blk, const char *groupname)
+void throttle_group_register_tgm(ThrottleGroupMember *tgm,
+                                 const char *groupname)
 {
     int i;
-    BlockBackendPublic *blkp = blk_get_public(blk);
+    BlockBackendPublic *blkp = container_of(tgm, BlockBackendPublic,
+            throttle_group_member);
+    BlockBackend *blk = blk_by_public(blkp);
     ThrottleState *ts = throttle_group_incref(groupname);
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     int clock_type = QEMU_CLOCK_REALTIME;
@@ -504,19 +499,19 @@ void throttle_group_register_blk(BlockBackend *blk, const char *groupname)
         clock_type = QEMU_CLOCK_VIRTUAL;
     }
 
-    blkp->throttle_state = ts;
+    tgm->throttle_state = ts;
 
     qemu_mutex_lock(&tg->lock);
-    /* If the ThrottleGroup is new set this BlockBackend as the token */
+    /* If the ThrottleGroup is new set this ThrottleGroupMember as the token */
     for (i = 0; i < 2; i++) {
         if (!tg->tokens[i]) {
-            tg->tokens[i] = blk;
+            tg->tokens[i] = tgm;
         }
     }
 
-    QLIST_INSERT_HEAD(&tg->head, blkp, round_robin);
+    QLIST_INSERT_HEAD(&tg->head, tgm, round_robin);
 
-    throttle_timers_init(&blkp->throttle_timers,
+    throttle_timers_init(&tgm->throttle_timers,
                          blk_get_aio_context(blk),
                          clock_type,
                          read_timer_cb,
@@ -526,45 +521,46 @@ void throttle_group_register_blk(BlockBackend *blk, const char *groupname)
     qemu_mutex_unlock(&tg->lock);
 }
 
-/* Unregister a BlockBackend from its group, removing it from the list,
+/* Unregister a ThrottleGroupMember from its group, removing it from the list,
  * destroying the timers and setting the throttle_state pointer to NULL.
  *
- * The BlockBackend must not have pending throttled requests, so the caller has
- * to drain them first.
+ * The ThrottleGroupMember must not have pending throttled requests, so the
+ * caller has to drain them first.
  *
  * The group will be destroyed if it's empty after this operation.
  *
- * @blk: the BlockBackend to remove
+ * @tgm the ThrottleGroupMember to remove
  */
-void throttle_group_unregister_blk(BlockBackend *blk)
+void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleGroup *tg = container_of(blkp->throttle_state, ThrottleGroup, ts);
+    ThrottleState *ts = tgm->throttle_state;
+    ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
+    ThrottleGroupMember *token;
     int i;
 
-    assert(blkp->pending_reqs[0] == 0 && blkp->pending_reqs[1] == 0);
-    assert(qemu_co_queue_empty(&blkp->throttled_reqs[0]));
-    assert(qemu_co_queue_empty(&blkp->throttled_reqs[1]));
+    assert(tgm->pending_reqs[0] == 0 && tgm->pending_reqs[1] == 0);
+    assert(qemu_co_queue_empty(&tgm->throttled_reqs[0]));
+    assert(qemu_co_queue_empty(&tgm->throttled_reqs[1]));
 
     qemu_mutex_lock(&tg->lock);
     for (i = 0; i < 2; i++) {
-        if (tg->tokens[i] == blk) {
-            BlockBackend *token = throttle_group_next_blk(blk);
-            /* Take care of the case where this is the last blk in the group */
-            if (token == blk) {
+        if (tg->tokens[i] == tgm) {
+            token = throttle_group_next_tgm(tgm);
+            /* Take care of the case where this is the last tgm in the group */
+            if (token == tgm) {
                 token = NULL;
             }
             tg->tokens[i] = token;
         }
     }
 
-    /* remove the current blk from the list */
-    QLIST_REMOVE(blkp, round_robin);
-    throttle_timers_destroy(&blkp->throttle_timers);
+    /* remove the current tgm from the list */
+    QLIST_REMOVE(tgm, round_robin);
+    throttle_timers_destroy(&tgm->throttle_timers);
     qemu_mutex_unlock(&tg->lock);
 
     throttle_group_unref(&tg->ts);
-    blkp->throttle_state = NULL;
+    tgm->throttle_state = NULL;
 }
 
 static void throttle_groups_init(void)
diff --git a/blockdev.c b/blockdev.c
index f92dcf24bf..794e681cf8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2696,7 +2696,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     if (throttle_enabled(&cfg)) {
         /* Enable I/O limits if they're not enabled yet, otherwise
          * just update the throttling group. */
-        if (!blk_get_public(blk)->throttle_state) {
+        if (!blk_get_public(blk)->throttle_group_member.throttle_state) {
             blk_io_limits_enable(blk,
                                  arg->has_group ? arg->group :
                                  arg->has_device ? arg->device :
@@ -2706,7 +2706,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
         }
         /* Set the new throttling configuration */
         blk_set_io_limits(blk, &cfg);
-    } else if (blk_get_public(blk)->throttle_state) {
+    } else if (blk_get_public(blk)->throttle_group_member.throttle_state) {
         /* If all throttling settings are set to 0, disable I/O limits */
         blk_io_limits_disable(blk);
     }
diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
index d983d34074..487b2da461 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -28,19 +28,20 @@
 #include "qemu/throttle.h"
 #include "block/block_int.h"
 
-const char *throttle_group_get_name(BlockBackend *blk);
+const char *throttle_group_get_name(ThrottleGroupMember *tgm);
 
 ThrottleState *throttle_group_incref(const char *name);
 void throttle_group_unref(ThrottleState *ts);
 
-void throttle_group_config(BlockBackend *blk, ThrottleConfig *cfg);
-void throttle_group_get_config(BlockBackend *blk, ThrottleConfig *cfg);
+void throttle_group_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg);
+void throttle_group_get_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg);
 
-void throttle_group_register_blk(BlockBackend *blk, const char *groupname);
-void throttle_group_unregister_blk(BlockBackend *blk);
-void throttle_group_restart_blk(BlockBackend *blk);
+void throttle_group_register_tgm(ThrottleGroupMember *tgm,
+                                const char *groupname);
+void throttle_group_unregister_tgm(ThrottleGroupMember *tgm);
+void throttle_group_restart_tgm(ThrottleGroupMember *tgm);
 
-void coroutine_fn throttle_group_co_io_limits_intercept(BlockBackend *blk,
+void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
                                                         unsigned int bytes,
                                                         bool is_write);
 
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 9109657609..e99cbfc865 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -27,6 +27,7 @@
 
 #include "qemu-common.h"
 #include "qemu/timer.h"
+#include "qemu/coroutine.h"
 
 #define THROTTLE_VALUE_MAX 1000000000000000LL
 
@@ -153,4 +154,29 @@ bool throttle_schedule_timer(ThrottleState *ts,
 
 void throttle_account(ThrottleState *ts, bool is_write, uint64_t size);
 
+
+/* The ThrottleGroupMember structure indicates membership in a ThrottleGroup
+ * and holds related data.
+ */
+
+typedef struct ThrottleGroupMember {
+    /* throttled_reqs_lock protects the CoQueues for throttled requests.  */
+    CoMutex      throttled_reqs_lock;
+    CoQueue      throttled_reqs[2];
+
+    /* Nonzero if the I/O limits are currently being ignored; generally
+     * it is zero.  Accessed with atomic operations.
+     */
+    unsigned int io_limits_disabled;
+
+    /* The following fields are protected by the ThrottleGroup lock.
+     * See the ThrottleGroup documentation for details.
+     * throttle_state tells us if I/O limits are configured. */
+    ThrottleState *throttle_state;
+    ThrottleTimers throttle_timers;
+    unsigned       pending_reqs[2];
+    QLIST_ENTRY(ThrottleGroupMember) round_robin;
+
+} ThrottleGroupMember;
+
 #endif
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 999eb2333a..4fec907b7f 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -70,24 +70,10 @@ typedef struct BlockDevOps {
 
 /* This struct is embedded in (the private) BlockBackend struct and contains
  * fields that must be public. This is in particular for QLIST_ENTRY() and
- * friends so that BlockBackends can be kept in lists outside block-backend.c */
+ * friends so that BlockBackends can be kept in lists outside block-backend.c
+ * */
 typedef struct BlockBackendPublic {
-    /* throttled_reqs_lock protects the CoQueues for throttled requests.  */
-    CoMutex      throttled_reqs_lock;
-    CoQueue      throttled_reqs[2];
-
-    /* Nonzero if the I/O limits are currently being ignored; generally
-     * it is zero.  Accessed with atomic operations.
-     */
-    unsigned int io_limits_disabled;
-
-    /* The following fields are protected by the ThrottleGroup lock.
-     * See the ThrottleGroup documentation for details.
-     * throttle_state tells us if I/O limits are configured. */
-    ThrottleState *throttle_state;
-    ThrottleTimers throttle_timers;
-    unsigned       pending_reqs[2];
-    QLIST_ENTRY(BlockBackendPublic) round_robin;
+    ThrottleGroupMember throttle_group_member;
 } BlockBackendPublic;
 
 BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm);
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index a9201b1fea..0f95da2592 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -592,6 +592,7 @@ static void test_groups(void)
     ThrottleConfig cfg1, cfg2;
     BlockBackend *blk1, *blk2, *blk3;
     BlockBackendPublic *blkp1, *blkp2, *blkp3;
+    ThrottleGroupMember *tgm1, *tgm2, *tgm3;
 
     /* No actual I/O is performed on these devices */
     blk1 = blk_new(0, BLK_PERM_ALL);
@@ -602,21 +603,25 @@ static void test_groups(void)
     blkp2 = blk_get_public(blk2);
     blkp3 = blk_get_public(blk3);
 
-    g_assert(blkp1->throttle_state == NULL);
-    g_assert(blkp2->throttle_state == NULL);
-    g_assert(blkp3->throttle_state == NULL);
+    tgm1 = &blkp1->throttle_group_member;
+    tgm2 = &blkp2->throttle_group_member;
+    tgm3 = &blkp3->throttle_group_member;
 
-    throttle_group_register_blk(blk1, "bar");
-    throttle_group_register_blk(blk2, "foo");
-    throttle_group_register_blk(blk3, "bar");
+    g_assert(tgm1->throttle_state == NULL);
+    g_assert(tgm2->throttle_state == NULL);
+    g_assert(tgm3->throttle_state == NULL);
 
-    g_assert(blkp1->throttle_state != NULL);
-    g_assert(blkp2->throttle_state != NULL);
-    g_assert(blkp3->throttle_state != NULL);
+    throttle_group_register_tgm(tgm1, "bar");
+    throttle_group_register_tgm(tgm2, "foo");
+    throttle_group_register_tgm(tgm3, "bar");
 
-    g_assert(!strcmp(throttle_group_get_name(blk1), "bar"));
-    g_assert(!strcmp(throttle_group_get_name(blk2), "foo"));
-    g_assert(blkp1->throttle_state == blkp3->throttle_state);
+    g_assert(tgm1->throttle_state != NULL);
+    g_assert(tgm2->throttle_state != NULL);
+    g_assert(tgm3->throttle_state != NULL);
+
+    g_assert(!strcmp(throttle_group_get_name(tgm1), "bar"));
+    g_assert(!strcmp(throttle_group_get_name(tgm2), "foo"));
+    g_assert(tgm1->throttle_state == tgm3->throttle_state);
 
     /* Setting the config of a group member affects the whole group */
     throttle_config_init(&cfg1);
@@ -624,29 +629,29 @@ static void test_groups(void)
     cfg1.buckets[THROTTLE_BPS_WRITE].avg = 285000;
     cfg1.buckets[THROTTLE_OPS_READ].avg  = 20000;
     cfg1.buckets[THROTTLE_OPS_WRITE].avg = 12000;
-    throttle_group_config(blk1, &cfg1);
+    throttle_group_config(tgm1, &cfg1);
 
-    throttle_group_get_config(blk1, &cfg1);
-    throttle_group_get_config(blk3, &cfg2);
+    throttle_group_get_config(tgm1, &cfg1);
+    throttle_group_get_config(tgm3, &cfg2);
     g_assert(!memcmp(&cfg1, &cfg2, sizeof(cfg1)));
 
     cfg2.buckets[THROTTLE_BPS_READ].avg  = 4547;
     cfg2.buckets[THROTTLE_BPS_WRITE].avg = 1349;
     cfg2.buckets[THROTTLE_OPS_READ].avg  = 123;
     cfg2.buckets[THROTTLE_OPS_WRITE].avg = 86;
-    throttle_group_config(blk3, &cfg1);
+    throttle_group_config(tgm3, &cfg1);
 
-    throttle_group_get_config(blk1, &cfg1);
-    throttle_group_get_config(blk3, &cfg2);
+    throttle_group_get_config(tgm1, &cfg1);
+    throttle_group_get_config(tgm3, &cfg2);
     g_assert(!memcmp(&cfg1, &cfg2, sizeof(cfg1)));
 
-    throttle_group_unregister_blk(blk1);
-    throttle_group_unregister_blk(blk2);
-    throttle_group_unregister_blk(blk3);
+    throttle_group_unregister_tgm(tgm1);
+    throttle_group_unregister_tgm(tgm2);
+    throttle_group_unregister_tgm(tgm3);
 
-    g_assert(blkp1->throttle_state == NULL);
-    g_assert(blkp2->throttle_state == NULL);
-    g_assert(blkp3->throttle_state == NULL);
+    g_assert(tgm1->throttle_state == NULL);
+    g_assert(tgm2->throttle_state == NULL);
+    g_assert(tgm3->throttle_state == NULL);
 }
 
 int main(int argc, char **argv)
-- 
2.11.0
