Received: from eggs.gnu.org ([2001:4830:134:3::10]:39358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJrTf-0000BN-LY
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 21:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJrTa-00036g-Hg
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 21:15:39 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Sun, 11 Jun 2017 04:14:26 +0300
Message-Id: <20170611011427.6713-2-el13635@mail.ntua.gr>
In-Reply-To: <20170611011427.6713-1-el13635@mail.ntua.gr>
References: <20170611011427.6713-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH RFC v2 1/2] block: move ThrottleGroup
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
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

This commit gathers ThrottleGroup membership details from BlockBackendPublic
into ThrottleGroupMember and refactors existing code to use the structure.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/block-backend.c           |  75 ++++++----
 block/qapi.c                    |   8 +-
 block/throttle-groups.c         | 305 +++++++++++++++++-----------------------
 blockdev.c                      |   4 +-
 include/block/throttle-groups.h |  15 +-
 include/qemu/throttle.h         |  64 +++++++++
 include/sysemu/block-backend.h  |  22 +--
 tests/test-throttle.c           |  53 +++----
 util/throttle.c                 |   5 +
 9 files changed, 293 insertions(+), 258 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index f3a60081a7..1d6b35c34d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -209,6 +209,7 @@ static const BdrvChildRole child_root = {
 BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
 {
     BlockBackend *blk;
+    BlockBackendPublic *blkp;
 
     blk = g_new0(BlockBackend, 1);
     blk->refcnt = 1;
@@ -216,8 +217,9 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
     blk->shared_perm = shared_perm;
     blk_set_enable_write_cache(blk, true);
 
-    qemu_co_queue_init(&blk->public.throttled_reqs[0]);
-    qemu_co_queue_init(&blk->public.throttled_reqs[1]);
+    blkp = blk_get_public(blk);
+    qemu_co_queue_init(&blkp->throttle_group_member.throttled_reqs[0]);
+    qemu_co_queue_init(&blkp->throttle_group_member.throttled_reqs[1]);
 
     notifier_list_init(&blk->remove_bs_notifiers);
     notifier_list_init(&blk->insert_bs_notifiers);
@@ -284,7 +286,7 @@ static void blk_delete(BlockBackend *blk)
     assert(!blk->refcnt);
     assert(!blk->name);
     assert(!blk->dev);
-    if (blk->public.throttle_state) {
+    if (blk_get_public(blk)->throttle_group_member.throttle_state) {
         blk_io_limits_disable(blk);
     }
     if (blk->root) {
@@ -596,8 +598,10 @@ BlockBackend *blk_by_public(BlockBackendPublic *public)
 void blk_remove_bs(BlockBackend *blk)
 {
     notifier_list_notify(&blk->remove_bs_notifiers, blk);
-    if (blk->public.throttle_state) {
-        throttle_timers_detach_aio_context(&blk->public.throttle_timers);
+    BlockBackendPublic *blkp = blk_get_public(blk);
+    if (blkp->throttle_group_member.throttle_state) {
+        ThrottleTimers *tt = &blkp->throttle_group_member.throttle_timers;
+        throttle_timers_detach_aio_context(tt);
     }
 
     blk_update_root_state(blk);
@@ -619,9 +623,10 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
     bdrv_ref(bs);
 
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
-    if (blk->public.throttle_state) {
+    if (blk_get_public(blk)->throttle_group_member.throttle_state) {
         throttle_timers_attach_aio_context(
-            &blk->public.throttle_timers, bdrv_get_aio_context(bs));
+            &blk_get_public(blk)->throttle_group_member.throttle_timers,
+            bdrv_get_aio_context(bs));
     }
 
     return 0;
@@ -972,6 +977,7 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
 {
     int ret;
     BlockDriverState *bs = blk_bs(blk);
+    BlockBackendPublic *blkp;
 
     trace_blk_co_preadv(blk, bs, offset, bytes, flags);
 
@@ -981,10 +987,12 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
     }
 
     bdrv_inc_in_flight(bs);
+    blkp = blk_get_public(blk);
 
     /* throttling disk I/O */
-    if (blk->public.throttle_state) {
-        throttle_group_co_io_limits_intercept(blk, bytes, false);
+    if (blkp->throttle_group_member.throttle_state) {
+        throttle_group_co_io_limits_intercept(&blkp->throttle_group_member,
+                bytes, false);
     }
 
     ret = bdrv_co_preadv(blk->root, offset, bytes, qiov, flags);
@@ -998,6 +1006,7 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
 {
     int ret;
     BlockDriverState *bs = blk_bs(blk);
+    BlockBackendPublic *blkp;
 
     trace_blk_co_pwritev(blk, bs, offset, bytes, flags);
 
@@ -1007,10 +1016,11 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
     }
 
     bdrv_inc_in_flight(bs);
-
+    blkp = blk_get_public(blk);
     /* throttling disk I/O */
-    if (blk->public.throttle_state) {
-        throttle_group_co_io_limits_intercept(blk, bytes, true);
+    if (blkp->throttle_group_member.throttle_state) {
+        throttle_group_co_io_limits_intercept(&blkp->throttle_group_member,
+                bytes, true);
     }
 
     if (!blk->enable_write_cache) {
@@ -1681,13 +1691,15 @@ void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
     BlockDriverState *bs = blk_bs(blk);
 
     if (bs) {
-        if (blk->public.throttle_state) {
-            throttle_timers_detach_aio_context(&blk->public.throttle_timers);
+        BlockBackendPublic *blkp = blk_get_public(blk);
+        if (blkp->throttle_group_member.throttle_state) {
+            ThrottleTimers *tt = &blkp->throttle_group_member.throttle_timers;
+            throttle_timers_detach_aio_context(tt);
         }
         bdrv_set_aio_context(bs, new_context);
-        if (blk->public.throttle_state) {
-            throttle_timers_attach_aio_context(&blk->public.throttle_timers,
-                                               new_context);
+        if (blkp->throttle_group_member.throttle_state) {
+            ThrottleTimers *tt = &blkp->throttle_group_member.throttle_timers;
+            throttle_timers_attach_aio_context(tt, new_context);
         }
     }
 }
@@ -1905,33 +1917,39 @@ int blk_commit_all(void)
 /* throttling disk I/O limits */
 void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg)
 {
-    throttle_group_config(blk, cfg);
+    throttle_group_config(&blk_get_public(blk)->throttle_group_member, cfg);
 }
 
 void blk_io_limits_disable(BlockBackend *blk)
 {
-    assert(blk->public.throttle_state);
+    assert(blk_get_public(blk)->throttle_group_member.throttle_state);
     bdrv_drained_begin(blk_bs(blk));
-    throttle_group_unregister_blk(blk);
+    throttle_group_unregister_tgm(&blk_get_public(blk)->throttle_group_member);
     bdrv_drained_end(blk_bs(blk));
 }
 
 /* should be called before blk_set_io_limits if a limit is set */
 void blk_io_limits_enable(BlockBackend *blk, const char *group)
 {
-    assert(!blk->public.throttle_state);
-    throttle_group_register_blk(blk, group);
+    BlockBackendPublic *blkp = blk_get_public(blk);
+
+    assert(!blkp->throttle_group_member.throttle_state);
+
+    blkp->throttle_group_member.aio_context = blk_get_aio_context(blk);
+    throttle_group_register_tgm(&blkp->throttle_group_member, group);
 }
 
 void blk_io_limits_update_group(BlockBackend *blk, const char *group)
 {
+    BlockBackendPublic *blkp = blk_get_public(blk);
     /* this BB is not part of any group */
-    if (!blk->public.throttle_state) {
+    if (!blkp->throttle_group_member.throttle_state) {
         return;
     }
 
     /* this BB is a part of the same group than the one we want */
-    if (!g_strcmp0(throttle_group_get_name(blk), group)) {
+    if (!g_strcmp0(throttle_group_get_name(&blkp->throttle_group_member),
+                group)) {
         return;
     }
 
@@ -1953,8 +1971,9 @@ static void blk_root_drained_begin(BdrvChild *child)
     /* Note that blk->root may not be accessible here yet if we are just
      * attaching to a BlockDriverState that is drained. Use child instead. */
 
-    if (blk->public.io_limits_disabled++ == 0) {
-        throttle_group_restart_blk(blk);
+    if (blk_get_public(blk)->throttle_group_member.io_limits_disabled++ == 0) {
+        BlockBackendPublic *blkp = blk_get_public(blk);
+        throttle_group_restart_tgm(&blkp->throttle_group_member);
     }
 }
 
@@ -1963,8 +1982,8 @@ static void blk_root_drained_end(BdrvChild *child)
     BlockBackend *blk = child->opaque;
     assert(blk->quiesce_counter);
 
-    assert(blk->public.io_limits_disabled);
-    --blk->public.io_limits_disabled;
+    assert(blk_get_public(blk)->throttle_group_member.io_limits_disabled);
+    --blk_get_public(blk)->throttle_group_member.io_limits_disabled;
 
     if (--blk->quiesce_counter == 0) {
         if (blk->dev_ops && blk->dev_ops->drained_end) {
diff --git a/block/qapi.c b/block/qapi.c
index a40922ea26..d7fc1345df 100644
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
index b73e7a800b..d8bf990ccb 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -29,43 +29,6 @@
 #include "qemu/thread.h"
 #include "sysemu/qtest.h"
 
-/* The ThrottleGroup structure (with its ThrottleState) is shared
- * among different BlockBackends and it's independent from
- * AioContext, so in order to use it from different threads it needs
- * its own locking.
- *
- * This locking is however handled internally in this file, so it's
- * transparent to outside users.
- *
- * The whole ThrottleGroup structure is private and invisible to
- * outside users, that only use it through its ThrottleState.
- *
- * In addition to the ThrottleGroup structure, BlockBackendPublic has
- * fields that need to be accessed by other members of the group and
- * therefore also need to be protected by this lock. Once a
- * BlockBackend is registered in a group those fields can be accessed
- * by other threads any time.
- *
- * Again, all this is handled internally and is mostly transparent to
- * the outside. The 'throttle_timers' field however has an additional
- * constraint because it may be temporarily invalid (see for example
- * bdrv_set_aio_context()). Therefore in this file a thread will
- * access some other BlockBackend's timers only after verifying that
- * that BlockBackend has throttled requests in the queue.
- */
-typedef struct ThrottleGroup {
-    char *name; /* This is constant during the lifetime of the group */
-
-    QemuMutex lock; /* This lock protects the following four fields */
-    ThrottleState ts;
-    QLIST_HEAD(, BlockBackendPublic) head;
-    BlockBackend *tokens[2];
-    bool any_timer_armed[2];
-
-    /* These two are protected by the global throttle_groups_lock */
-    unsigned refcount;
-    QTAILQ_ENTRY(ThrottleGroup) list;
-} ThrottleGroup;
 
 static QemuMutex throttle_groups_lock;
 static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =
@@ -133,114 +96,113 @@ void throttle_group_unref(ThrottleState *ts)
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
+    ThrottleState *ts = tgm->throttle_state;
+    ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
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
+     * then decide the token is the current TGM because chances are
+     * the current TGM get the current request queued.
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
 
-    if (blkp->io_limits_disabled) {
+    if (tgm->io_limits_disabled) {
         return false;
     }
 
@@ -251,9 +213,9 @@ static bool throttle_group_schedule_timer(BlockBackend *blk, bool is_write)
 
     must_wait = throttle_schedule_timer(ts, tt, is_write);
 
-    /* If a timer just got armed, set blk as the current token */
+    /* If a timer just got armed, set tgm as the current token */
     if (must_wait) {
-        tg->tokens[is_write] = blk;
+        tg->tokens[is_write] = tgm;
         tg->any_timer_armed[is_write] = true;
     }
 
@@ -264,19 +226,19 @@ static bool throttle_group_schedule_timer(BlockBackend *blk, bool is_write)
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
 
@@ -285,12 +247,12 @@ static void schedule_next_request(BlockBackend *blk, bool is_write)
 
     /* If it doesn't have to wait, queue it for immediate execution */
     if (!must_wait) {
-        /* Give preference to requests from the current blk */
+        /* Give preference to requests from the current tgm */
         if (qemu_in_coroutine() &&
-            qemu_co_queue_next(&blkp->throttled_reqs[is_write])) {
-            token = blk;
+            qemu_co_queue_next(&tgm->throttled_reqs[is_write])) {
+            token = tgm;
         } else {
-            ThrottleTimers *tt = &blk_get_public(token)->throttle_timers;
+            ThrottleTimers *tt = &token->throttle_timers;
             int64_t now = qemu_clock_get_ns(tt->clock_type);
             timer_mod(tt->timers[is_write], now + 1);
             tg->any_timer_armed[is_write] = true;
@@ -299,71 +261,66 @@ static void schedule_next_request(BlockBackend *blk, bool is_write)
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
+    ThrottleState *ts = tgm->throttle_state;
+    ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
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
-        qemu_co_queue_wait(&blkp->throttled_reqs[is_write], NULL);
+        qemu_co_queue_wait(&tgm->throttled_reqs[is_write], NULL);
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
 
-void throttle_group_restart_blk(BlockBackend *blk)
+void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
     int i;
 
     for (i = 0; i < 2; i++) {
-        while (qemu_co_enter_next(&blkp->throttled_reqs[i])) {
+        while (qemu_co_enter_next(&tgm->throttled_reqs[i])) {
             ;
         }
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
@@ -376,37 +333,34 @@ void throttle_group_config(BlockBackend *blk, ThrottleConfig *cfg)
     throttle_config(ts, tt, cfg);
     qemu_mutex_unlock(&tg->lock);
 
-    qemu_co_enter_next(&blkp->throttled_reqs[0]);
-    qemu_co_enter_next(&blkp->throttled_reqs[1]);
+    qemu_co_enter_next(&tgm->throttled_reqs[0]);
+    qemu_co_enter_next(&tgm->throttled_reqs[1]);
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
- * @blk:       the BlockBackend whose request had been throttled
+ * @tgm:       the ThrottleGroupMember whose request had been throttled
  * @is_write:  the type of operation (read/write)
  */
-static void timer_cb(BlockBackend *blk, bool is_write)
+static void timer_cb(ThrottleGroupMember *tgm, bool is_write)
 {
-    BlockBackendPublic *blkp = blk_get_public(blk);
-    ThrottleState *ts = blkp->throttle_state;
+    ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     bool empty_queue;
 
@@ -416,15 +370,15 @@ static void timer_cb(BlockBackend *blk, bool is_write)
     qemu_mutex_unlock(&tg->lock);
 
     /* Run the request that was waiting for this timer */
-    aio_context_acquire(blk_get_aio_context(blk));
-    empty_queue = !qemu_co_enter_next(&blkp->throttled_reqs[is_write]);
-    aio_context_release(blk_get_aio_context(blk));
+    aio_context_acquire(tgm->aio_context);
+    empty_queue = !qemu_co_enter_next(&tgm->throttled_reqs[is_write]);
+    aio_context_release(tgm->aio_context);
 
     /* If the request queue was empty then we have to take care of
      * scheduling the next one */
     if (empty_queue) {
         qemu_mutex_lock(&tg->lock);
-        schedule_next_request(blk, is_write);
+        schedule_next_request(tgm, is_write);
         qemu_mutex_unlock(&tg->lock);
     }
 }
@@ -439,17 +393,17 @@ static void write_timer_cb(void *opaque)
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
     ThrottleState *ts = throttle_group_incref(groupname);
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     int clock_type = QEMU_CLOCK_REALTIME;
@@ -459,67 +413,68 @@ void throttle_group_register_blk(BlockBackend *blk, const char *groupname)
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
-                         blk_get_aio_context(blk),
+    throttle_timers_init(&tgm->throttle_timers,
+                         tgm->aio_context,
                          clock_type,
                          read_timer_cb,
                          write_timer_cb,
-                         blk);
+                         tgm);
 
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
index c63f4e82c7..ad8cec8008 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2706,7 +2706,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     if (throttle_enabled(&cfg)) {
         /* Enable I/O limits if they're not enabled yet, otherwise
          * just update the throttling group. */
-        if (!blk_get_public(blk)->throttle_state) {
+        if (!blk_get_public(blk)->throttle_group_member.throttle_state) {
             blk_io_limits_enable(blk,
                                  arg->has_group ? arg->group :
                                  arg->has_device ? arg->device :
@@ -2716,7 +2716,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
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
index 9109657609..8b67fbfdfb 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -27,6 +27,9 @@
 
 #include "qemu-common.h"
 #include "qemu/timer.h"
+#include "qemu/queue.h"
+#include "qemu/thread.h"
+#include "qemu/coroutine.h"
 
 #define THROTTLE_VALUE_MAX 1000000000000000LL
 
@@ -153,4 +156,65 @@ bool throttle_schedule_timer(ThrottleState *ts,
 
 void throttle_account(ThrottleState *ts, bool is_write, uint64_t size);
 
+/* The ThrottleGroup structure (with its ThrottleState) is shared among
+ * different ThrottleGroupMembers and it's independent from AioContext, so in
+ * order to use it from different threads it needs its own locking.
+ *
+ * This locking is however handled internally in block/throttle-groups.c so
+ * it's transparent to outside users.
+ *
+ * The whole ThrottleGroup structure is private and invisible to outside users,
+ * that only use it through its ThrottleState.
+ *
+ * In addition to the ThrottleGroup structure, ThrottleGroupMember has fields
+ * that need to be accessed by other members of the group and therefore also
+ * need to be protected by this lock. Once a ThrottleGroupMember is registered
+ * in a group those fields can be accessed by other threads any time.
+ *
+ * Again, all this is handled internally in block/throttle-groups.c and is
+ * mostly transparent to the outside. The 'throttle_timers' field however has
+ * an additional constraint because it may be temporarily invalid (see for
+ * example bdrv_set_aio_context()). Therefore block/throttle-groups.c will
+ * access some other ThrottleGroupMember's timers only after verifying that
+ * ThrottleGroupMember  has throttled requests in the queue.
+ */
+
+typedef struct ThrottleGroup {
+    char *name; /* This is constant during the lifetime of the group */
+
+    QemuMutex lock; /* This lock protects the following four fields */
+    ThrottleState ts;
+    QLIST_HEAD(, ThrottleGroupMember) head;
+    struct ThrottleGroupMember *tokens[2];
+    bool any_timer_armed[2];
+
+    /* These two are protected by the global throttle_groups_lock */
+    unsigned refcount;
+    QTAILQ_ENTRY(ThrottleGroup) list;
+} ThrottleGroup;
+
+/* The ThrottleGroupMember structure indicates membership in a ThrottleGroup
+ * and holds related data.
+ */
+
+typedef struct ThrottleGroupMember {
+    AioContext *aio_context;
+    /* I/O throttling has its own locking, but also some fields are
+     * protected by the AioContext lock.
+     */
+
+    /* Protected by AioContext lock.  */
+    CoQueue      throttled_reqs[2];
+
+    /* Nonzero if the I/O limits are currently being ignored; generally
+     * it is zero.  */
+    unsigned int io_limits_disabled;
+
+    ThrottleState *throttle_state;
+    ThrottleTimers throttle_timers;
+    unsigned       pending_reqs[2];
+    QLIST_ENTRY(ThrottleGroupMember) round_robin;
+
+} ThrottleGroupMember;
+
 #endif
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 840ad6134c..4fec907b7f 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -70,26 +70,10 @@ typedef struct BlockDevOps {
 
 /* This struct is embedded in (the private) BlockBackend struct and contains
  * fields that must be public. This is in particular for QLIST_ENTRY() and
- * friends so that BlockBackends can be kept in lists outside block-backend.c */
+ * friends so that BlockBackends can be kept in lists outside block-backend.c
+ * */
 typedef struct BlockBackendPublic {
-    /* I/O throttling has its own locking, but also some fields are
-     * protected by the AioContext lock.
-     */
-
-    /* Protected by AioContext lock.  */
-    CoQueue      throttled_reqs[2];
-
-    /* Nonzero if the I/O limits are currently being ignored; generally
-     * it is zero.  */
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
diff --git a/util/throttle.c b/util/throttle.c
index 3570ed25fc..ec1fe73dbd 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -185,6 +185,9 @@ static bool throttle_compute_timer(ThrottleState *ts,
 void throttle_timers_attach_aio_context(ThrottleTimers *tt,
                                         AioContext *new_context)
 {
+    ThrottleGroupMember *tgm = container_of(tt, ThrottleGroupMember, throttle_timers);
+    tgm->aio_context = new_context;
+
     tt->timers[0] = aio_timer_new(new_context, tt->clock_type, SCALE_NS,
                                   tt->read_timer_cb, tt->timer_opaque);
     tt->timers[1] = aio_timer_new(new_context, tt->clock_type, SCALE_NS,
@@ -241,6 +244,8 @@ static void throttle_timer_destroy(QEMUTimer **timer)
 /* Remove timers from event loop */
 void throttle_timers_detach_aio_context(ThrottleTimers *tt)
 {
+    ThrottleGroupMember *tgm = container_of(tt, ThrottleGroupMember, throttle_timers);
+    tgm->aio_context = NULL;
     int i;
 
     for (i = 0; i < 2; i++) {
-- 
2.11.0
