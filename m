Received: from eggs.gnu.org ([2001:4830:134:3::10]:60117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0r-0001jC-A1
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0o-0004UY-Rh
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:37 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 23 Jun 2017 15:46:59 +0300
Message-Id: <20170623124700.1389-8-el13635@mail.ntua.gr>
In-Reply-To: <20170623124700.1389-1-el13635@mail.ntua.gr>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH RFC v3 7/8] block: remove legacy I/O throttling
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

This commit removes all I/O throttling from block/block-backend.c. In
order to support the existing interface, it is changed to use the
block/throttle.c filter driver.

The throttle filter node that is created by the legacy interface is
stored in a 'throttle_node' field in the BlockBackendPublic of the
device. The legacy throttle node is managed by the legacy interface
completely. More advanced configurations with the filter drive are
possible using the QMP API, but these will be ignored by the legacy
interface.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/block-backend.c          | 158 ++++++++++++++++++++++++++---------------
 block/qapi.c                   |   8 +--
 block/throttle.c               |   4 ++
 blockdev.c                     |  55 ++++++++++----
 include/sysemu/block-backend.h |   8 +--
 tests/test-throttle.c          |  15 ++--
 util/throttle.c                |   4 --
 7 files changed, 160 insertions(+), 92 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 1d501ec973..c777943572 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -216,9 +216,6 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
     blk->shared_perm = shared_perm;
     blk_set_enable_write_cache(blk, true);
 
-    qemu_co_mutex_init(&blk->public.throttle_group_member.throttled_reqs_lock);
-    qemu_co_queue_init(&blk->public.throttle_group_member.throttled_reqs[0]);
-    qemu_co_queue_init(&blk->public.throttle_group_member.throttled_reqs[1]);
     block_acct_init(&blk->stats);
 
     notifier_list_init(&blk->remove_bs_notifiers);
@@ -286,8 +283,8 @@ static void blk_delete(BlockBackend *blk)
     assert(!blk->refcnt);
     assert(!blk->name);
     assert(!blk->dev);
-    if (blk->public.throttle_group_member.throttle_state) {
-        blk_io_limits_disable(blk);
+    if (blk->public.throttle_node) {
+        blk_io_limits_disable(blk, &error_abort);
     }
     if (blk->root) {
         blk_remove_bs(blk);
@@ -597,13 +594,7 @@ BlockBackend *blk_by_public(BlockBackendPublic *public)
  */
 void blk_remove_bs(BlockBackend *blk)
 {
-    ThrottleTimers *tt;
-
     notifier_list_notify(&blk->remove_bs_notifiers, blk);
-    if (blk->public.throttle_group_member.throttle_state) {
-        tt = &blk->public.throttle_group_member.throttle_timers;
-        throttle_timers_detach_aio_context(tt);
-    }
 
     blk_update_root_state(blk);
 
@@ -624,12 +615,6 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
     bdrv_ref(bs);
 
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
-    if (blk->public.throttle_group_member.throttle_state) {
-        throttle_timers_attach_aio_context(
-            &blk->public.throttle_group_member.throttle_timers,
-            bdrv_get_aio_context(bs));
-    }
-
     return 0;
 }
 
@@ -987,13 +972,6 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
     }
 
     bdrv_inc_in_flight(bs);
-
-    /* throttling disk I/O */
-    if (blk->public.throttle_group_member.throttle_state) {
-        throttle_group_co_io_limits_intercept(&blk->public.throttle_group_member,
-                bytes, false);
-    }
-
     ret = bdrv_co_preadv(blk->root, offset, bytes, qiov, flags);
     bdrv_dec_in_flight(bs);
     return ret;
@@ -1014,11 +992,6 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
     }
 
     bdrv_inc_in_flight(bs);
-    /* throttling disk I/O */
-    if (blk->public.throttle_group_member.throttle_state) {
-        throttle_group_co_io_limits_intercept(&blk->public.throttle_group_member,
-                bytes, true);
-    }
 
     if (!blk->enable_write_cache) {
         flags |= BDRV_REQ_FUA;
@@ -1686,18 +1659,9 @@ static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb)
 void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
 {
     BlockDriverState *bs = blk_bs(blk);
-    ThrottleTimers *tt;
 
     if (bs) {
-        if (blk->public.throttle_group_member.throttle_state) {
-            tt = &blk->public.throttle_group_member.throttle_timers;
-            throttle_timers_detach_aio_context(tt);
-        }
         bdrv_set_aio_context(bs, new_context);
-        if (blk->public.throttle_group_member.throttle_state) {
-            tt = &blk->public.throttle_group_member.throttle_timers;
-            throttle_timers_attach_aio_context(tt, new_context);
-        }
     }
 }
 
@@ -1914,45 +1878,115 @@ int blk_commit_all(void)
 /* throttling disk I/O limits */
 void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg)
 {
-    throttle_group_config(&blk->public.throttle_group_member, cfg);
+    ThrottleGroupMember *tgm;
+
+    assert(blk->public.throttle_node);
+    tgm = blk->public.throttle_node->opaque;
+    throttle_group_config(tgm, cfg);
 }
 
-void blk_io_limits_disable(BlockBackend *blk)
+void blk_io_limits_disable(BlockBackend *blk, Error **errp)
 {
-    assert(blk->public.throttle_group_member.throttle_state);
-    bdrv_drained_begin(blk_bs(blk));
-    throttle_group_unregister_tgm(&blk->public.throttle_group_member);
-    bdrv_drained_end(blk_bs(blk));
+    Error *local_err = NULL;
+    BlockDriverState *bs, *throttle_node;
+
+    throttle_node = blk_get_public(blk)->throttle_node;
+
+    assert(throttle_node && throttle_node->refcnt == 1);
+
+    bs = throttle_node->file->bs;
+    blk_get_public(blk)->throttle_node = NULL;
+
+    /* ref throttle_node's child bs so that it isn't lost when throttle_node is
+     * destroyed */
+    bdrv_ref(bs);
+
+    /* this destroys throttle_node */
+    blk_remove_bs(blk);
+
+    blk_insert_bs(blk, bs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        blk_insert_bs(blk, bs, NULL);
+    }
+    bdrv_unref(bs);
 }
 
 /* should be called before blk_set_io_limits if a limit is set */
-void blk_io_limits_enable(BlockBackend *blk, const char *group)
+void blk_io_limits_enable(BlockBackend *blk, const char *group,  Error **errp)
 {
-    blk->public.throttle_group_member.aio_context = blk_get_aio_context(blk);
-    assert(!blk->public.throttle_group_member.throttle_state);
-    throttle_group_register_tgm(&blk->public.throttle_group_member, group);
+    BlockDriverState *bs = blk_bs(blk), *throttle_node;
+    Error *local_err = NULL;
+    /*
+     * increase bs refcount so it doesn't get deleted when removed
+     * from the BlockBackend's root
+     * */
+    bdrv_ref(bs);
+    blk_remove_bs(blk);
+
+    QDict *options = qdict_new();
+    qdict_set_default_str(options, "file", bs->node_name);
+    qdict_set_default_str(options, "throttling-group", group);
+    throttle_node = bdrv_new_open_driver(bdrv_find_format("throttle"),
+            NULL, bdrv_get_flags(bs), options, &local_err);
+
+    QDECREF(options);
+    if (local_err) {
+        blk_insert_bs(blk, bs, NULL);
+        bdrv_unref(bs);
+        error_propagate(errp, local_err);
+        return;
+    }
+    /* bs will be throttle_node's child now so unref it*/
+    bdrv_unref(bs);
+
+    blk_insert_bs(blk, throttle_node, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        bdrv_ref(bs);
+        bdrv_unref(throttle_node);
+        blk_insert_bs(blk, bs, NULL);
+        bdrv_unref(bs);
+        return;
+    }
+    bdrv_unref(throttle_node);
+
+    assert(throttle_node->file->bs == bs);
+    assert(throttle_node->refcnt == 1);
+
+    blk_get_public(blk)->throttle_node = throttle_node;
 }
 
-void blk_io_limits_update_group(BlockBackend *blk, const char *group)
+void blk_io_limits_update_group(BlockBackend *blk, const char *group, Error **errp)
 {
+    ThrottleGroupMember *tgm;
+    Error *local_err = NULL;
+
     /* this BB is not part of any group */
-    if (!blk->public.throttle_group_member.throttle_state) {
+    if (!blk->public.throttle_node) {
         return;
     }
 
+    tgm = blk->public.throttle_node->opaque;
+
     /* this BB is a part of the same group than the one we want */
-    if (!g_strcmp0(throttle_group_get_name(&blk->public.throttle_group_member),
+    if (!g_strcmp0(throttle_group_get_name(tgm),
                 group)) {
         return;
     }
 
-    /* need to change the group this bs belong to */
-    blk_io_limits_disable(blk);
-    blk_io_limits_enable(blk, group);
+    /* need to change the group this bs belongs to */
+    blk_io_limits_disable(blk, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    blk_io_limits_enable(blk, group, errp);
 }
 
 static void blk_root_drained_begin(BdrvChild *child)
 {
+    ThrottleGroupMember *tgm;
     BlockBackend *blk = child->opaque;
 
     if (++blk->quiesce_counter == 1) {
@@ -1963,19 +1997,25 @@ static void blk_root_drained_begin(BdrvChild *child)
 
     /* Note that blk->root may not be accessible here yet if we are just
      * attaching to a BlockDriverState that is drained. Use child instead. */
-
-    if (atomic_fetch_inc(&blk->public.throttle_group_member.io_limits_disabled) == 0) {
-        throttle_group_restart_tgm(&blk->public.throttle_group_member);
+    if (blk->public.throttle_node) {
+        tgm = blk->public.throttle_node->opaque;
+        if (atomic_fetch_inc(&tgm->io_limits_disabled) == 0) {
+            throttle_group_restart_tgm(tgm);
+        }
     }
 }
 
 static void blk_root_drained_end(BdrvChild *child)
 {
+    ThrottleGroupMember *tgm;
     BlockBackend *blk = child->opaque;
     assert(blk->quiesce_counter);
 
-    assert(blk->public.throttle_group_member.io_limits_disabled);
-    atomic_dec(&blk->public.throttle_group_member.io_limits_disabled);
+    if (blk->public.throttle_node) {
+        tgm = blk->public.throttle_node->opaque;
+        assert(tgm->io_limits_disabled);
+        atomic_dec(&tgm->io_limits_disabled);
+    }
 
     if (--blk->quiesce_counter == 0) {
         if (blk->dev_ops && blk->dev_ops->drained_end) {
diff --git a/block/qapi.c b/block/qapi.c
index 70ec5552be..053c3cb8b3 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -67,11 +67,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
     info->backing_file_depth = bdrv_get_backing_file_depth(bs);
     info->detect_zeroes = bs->detect_zeroes;
 
-    if (blk && blk_get_public(blk)->throttle_group_member.throttle_state) {
+    if (blk && blk_get_public(blk)->throttle_node) {
         ThrottleConfig cfg;
-        BlockBackendPublic *blkp = blk_get_public(blk);
+        ThrottleGroupMember *tgm = blk_get_public(blk)->throttle_node->opaque;
 
-        throttle_group_get_config(&blkp->throttle_group_member, &cfg);
+        throttle_group_get_config(tgm, &cfg);
 
         info->bps     = cfg.buckets[THROTTLE_BPS_TOTAL].avg;
         info->bps_rd  = cfg.buckets[THROTTLE_BPS_READ].avg;
@@ -120,7 +120,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 
         info->has_group = true;
         info->group =
-            g_strdup(throttle_group_get_name(&blkp->throttle_group_member));
+            g_strdup(throttle_group_get_name(tgm));
     }
 
     info->write_threshold = bdrv_write_threshold_get(bs);
diff --git a/block/throttle.c b/block/throttle.c
index 0c17051161..62fa28315a 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -341,6 +341,8 @@ static int throttle_co_flush(BlockDriverState *bs)
 static void throttle_detach_aio_context(BlockDriverState *bs)
 {
     ThrottleGroupMember *tgm = bs->opaque;
+    tgm->aio_context = NULL;
+
     throttle_timers_detach_aio_context(&tgm->throttle_timers);
 }
 
@@ -348,6 +350,8 @@ static void throttle_attach_aio_context(BlockDriverState *bs,
                                     AioContext *new_context)
 {
     ThrottleGroupMember *tgm = bs->opaque;
+    tgm->aio_context = new_context;
+
     throttle_timers_attach_aio_context(&tgm->throttle_timers, new_context);
 }
 
diff --git a/blockdev.c b/blockdev.c
index 794e681cf8..c928ced35a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -610,7 +610,14 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
         if (!throttling_group) {
             throttling_group = id;
         }
-        blk_io_limits_enable(blk, throttling_group);
+        blk_io_limits_enable(blk, throttling_group, &error);
+        if (error) {
+            error_propagate(errp, error);
+            blk_unref(blk);
+            blk = NULL;
+            goto err_no_bs_opts;
+
+        }
         blk_set_io_limits(blk, &cfg);
     }
 
@@ -2621,6 +2628,9 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     BlockDriverState *bs;
     BlockBackend *blk;
     AioContext *aio_context;
+    BlockDriverState *throttle_node = NULL;
+    ThrottleGroupMember *tgm;
+    Error *local_err = NULL;
 
     blk = qmp_get_blk(arg->has_device ? arg->device : NULL,
                       arg->has_id ? arg->id : NULL,
@@ -2696,19 +2706,38 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     if (throttle_enabled(&cfg)) {
         /* Enable I/O limits if they're not enabled yet, otherwise
          * just update the throttling group. */
-        if (!blk_get_public(blk)->throttle_group_member.throttle_state) {
-            blk_io_limits_enable(blk,
-                                 arg->has_group ? arg->group :
-                                 arg->has_device ? arg->device :
-                                 arg->id);
-        } else if (arg->has_group) {
-            blk_io_limits_update_group(blk, arg->group);
+        if (!blk_get_public(blk)->throttle_node) {
+            blk_io_limits_enable(blk, arg->has_group ? arg->group :
+                    arg->has_device ? arg->device : arg->id, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                goto out;
+            }
         }
-        /* Set the new throttling configuration */
-        blk_set_io_limits(blk, &cfg);
-    } else if (blk_get_public(blk)->throttle_group_member.throttle_state) {
-        /* If all throttling settings are set to 0, disable I/O limits */
-        blk_io_limits_disable(blk);
+
+        if (arg->has_group) {
+            /* move throttle node membership to arg->group */
+            blk_io_limits_update_group(blk, arg->group, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                goto out;
+            }
+        }
+
+        throttle_node = blk_get_public(blk)->throttle_node;
+        tgm = throttle_node->opaque;
+        throttle_group_config(tgm, &cfg);
+    } else if (blk_get_public(blk)->throttle_node) {
+        /*
+         * If all throttling settings are set to 0, disable I/O limits
+         * by deleting the legacy throttle node
+         * */
+        blk_io_limits_disable(blk, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            goto out;
+        }
+
     }
 
 out:
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 4fec907b7f..bef8fd53fa 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -73,7 +73,7 @@ typedef struct BlockDevOps {
  * friends so that BlockBackends can be kept in lists outside block-backend.c
  * */
 typedef struct BlockBackendPublic {
-    ThrottleGroupMember throttle_group_member;
+    BlockDriverState *throttle_node;
 } BlockBackendPublic;
 
 BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm);
@@ -221,8 +221,8 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
                                   void *opaque, int ret);
 
 void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg);
-void blk_io_limits_disable(BlockBackend *blk);
-void blk_io_limits_enable(BlockBackend *blk, const char *group);
-void blk_io_limits_update_group(BlockBackend *blk, const char *group);
+void blk_io_limits_disable(BlockBackend *blk, Error **errp);
+void blk_io_limits_enable(BlockBackend *blk, const char *group, Error **errp);
+void blk_io_limits_update_group(BlockBackend *blk, const char *group, Error **errp);
 
 #endif
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index d3298234aa..c5b5492e78 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -594,7 +594,6 @@ static void test_groups(void)
 {
     ThrottleConfig cfg1, cfg2;
     BlockBackend *blk1, *blk2, *blk3;
-    BlockBackendPublic *blkp1, *blkp2, *blkp3;
     ThrottleGroupMember *tgm1, *tgm2, *tgm3;
 
     /* No actual I/O is performed on these devices */
@@ -602,13 +601,9 @@ static void test_groups(void)
     blk2 = blk_new(0, BLK_PERM_ALL);
     blk3 = blk_new(0, BLK_PERM_ALL);
 
-    blkp1 = blk_get_public(blk1);
-    blkp2 = blk_get_public(blk2);
-    blkp3 = blk_get_public(blk3);
-
-    tgm1 = &blkp1->throttle_group_member;
-    tgm2 = &blkp2->throttle_group_member;
-    tgm3 = &blkp3->throttle_group_member;
+    tgm1 = g_new0(ThrottleGroupMember, 1);
+    tgm2 = g_new0(ThrottleGroupMember, 1);
+    tgm3 = g_new0(ThrottleGroupMember, 1);
 
     tgm1->aio_context = blk_get_aio_context(blk1);
     tgm2->aio_context = blk_get_aio_context(blk2);
@@ -659,6 +654,10 @@ static void test_groups(void)
     g_assert(tgm1->throttle_state == NULL);
     g_assert(tgm2->throttle_state == NULL);
     g_assert(tgm3->throttle_state == NULL);
+
+    g_free(tgm1);
+    g_free(tgm2);
+    g_free(tgm3);
 }
 
 int main(int argc, char **argv)
diff --git a/util/throttle.c b/util/throttle.c
index e763474b1a..3570ed25fc 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -185,8 +185,6 @@ static bool throttle_compute_timer(ThrottleState *ts,
 void throttle_timers_attach_aio_context(ThrottleTimers *tt,
                                         AioContext *new_context)
 {
-    ThrottleGroupMember *tgm = container_of(tt, ThrottleGroupMember, throttle_timers);
-    tgm->aio_context = new_context;
     tt->timers[0] = aio_timer_new(new_context, tt->clock_type, SCALE_NS,
                                   tt->read_timer_cb, tt->timer_opaque);
     tt->timers[1] = aio_timer_new(new_context, tt->clock_type, SCALE_NS,
@@ -244,8 +242,6 @@ static void throttle_timer_destroy(QEMUTimer **timer)
 void throttle_timers_detach_aio_context(ThrottleTimers *tt)
 {
     int i;
-    ThrottleGroupMember *tgm = container_of(tt, ThrottleGroupMember, throttle_timers);
-    tgm->aio_context = NULL;
 
     for (i = 0; i < 2; i++) {
         throttle_timer_destroy(&tt->timers[i]);
-- 
2.11.0
