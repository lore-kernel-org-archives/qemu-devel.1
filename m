Received: from eggs.gnu.org ([2001:4830:134:3::10]:38473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dlEbY-0007Ol-Rl
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dlEbW-0003Tn-QQ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:24:56 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 25 Aug 2017 16:23:29 +0300
Message-Id: <20170825132332.6734-5-el13635@mail.ntua.gr>
In-Reply-To: <20170825132332.6734-1-el13635@mail.ntua.gr>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v3 4/7] block: remove legacy I/O throttling
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
 include/block/throttle-groups.h |   1 +
 include/sysemu/block-backend.h  |   6 +-
 block/block-backend.c           | 134 +++++++++++++++++++++++++---------------
 block/qapi.c                    |  10 +--
 block/throttle.c                |   8 +++
 blockdev.c                      |  37 ++++++++---
 tests/test-throttle.c           |  19 +++---
 7 files changed, 140 insertions(+), 75 deletions(-)

diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
index e2fd0513c4..8493540766 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -81,5 +81,6 @@ void throttle_group_detach_aio_context(ThrottleGroupMember *tgm);
  * mutex.
  */
 bool throttle_group_exists(const char *name);
+ThrottleGroupMember *throttle_get_tgm(BlockDriverState *bs);
 
 #endif
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 0e0cda7521..4a7ca53685 100644
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
@@ -225,7 +225,7 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
 
 void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg);
 void blk_io_limits_disable(BlockBackend *blk);
-void blk_io_limits_enable(BlockBackend *blk, const char *group);
-void blk_io_limits_update_group(BlockBackend *blk, const char *group);
+void blk_io_limits_enable(BlockBackend *blk, const char *group, Error **errp);
+void blk_io_limits_update_group(BlockBackend *blk, const char *group, Error **errp);
 
 #endif
diff --git a/block/block-backend.c b/block/block-backend.c
index c51fb8c8aa..693ad27fc9 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -15,6 +15,7 @@
 #include "block/block_int.h"
 #include "block/blockjob.h"
 #include "block/throttle-groups.h"
+#include "qemu/throttle-options.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "qapi-event.h"
@@ -319,7 +320,7 @@ static void blk_delete(BlockBackend *blk)
     assert(!blk->refcnt);
     assert(!blk->name);
     assert(!blk->dev);
-    if (blk->public.throttle_group_member.throttle_state) {
+    if (blk->public.throttle_node) {
         blk_io_limits_disable(blk);
     }
     if (blk->root) {
@@ -634,13 +635,7 @@ BlockBackend *blk_by_public(BlockBackendPublic *public)
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
 
@@ -661,12 +656,6 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
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
 
@@ -1024,13 +1013,6 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
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
@@ -1051,11 +1033,6 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
     }
 
     bdrv_inc_in_flight(bs);
-    /* throttling disk I/O */
-    if (blk->public.throttle_group_member.throttle_state) {
-        throttle_group_co_io_limits_intercept(&blk->public.throttle_group_member,
-                bytes, true);
-    }
 
     if (!blk->enable_write_cache) {
         flags |= BDRV_REQ_FUA;
@@ -1723,13 +1700,8 @@ static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb)
 void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
 {
     BlockDriverState *bs = blk_bs(blk);
-    ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
 
     if (bs) {
-        if (tgm->throttle_state) {
-            throttle_group_detach_aio_context(tgm);
-            throttle_group_attach_aio_context(tgm, new_context);
-        }
         bdrv_set_aio_context(bs, new_context);
     }
 }
@@ -1948,45 +1920,101 @@ int blk_commit_all(void)
 /* throttling disk I/O limits */
 void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg)
 {
-    throttle_group_config(&blk->public.throttle_group_member, cfg);
+    assert(blk->public.throttle_node);
+    throttle_group_config(throttle_get_tgm(blk->public.throttle_node), cfg);
 }
 
 void blk_io_limits_disable(BlockBackend *blk)
 {
-    assert(blk->public.throttle_group_member.throttle_state);
-    bdrv_drained_begin(blk_bs(blk));
-    throttle_group_unregister_tgm(&blk->public.throttle_group_member);
-    bdrv_drained_end(blk_bs(blk));
+    BlockDriverState *bs, *throttle_node;
+
+    throttle_node = blk_get_public(blk)->throttle_node;
+
+    assert(throttle_node);
+
+    bs = throttle_node->file->bs;
+    bdrv_drained_begin(bs);
+
+    /* Ref throttle_node's child bs to ensure it won't go away */
+    bdrv_ref(bs);
+
+    bdrv_child_try_set_perm(throttle_node->file, 0, BLK_PERM_ALL,
+                            &error_abort);
+    /* Replace throttle_node with bs. While throttle_node was inserted under
+     * blk, at this point it might have more than one parent, so use
+     * bdrv_replace_node(). This destroys throttle_node */
+    bdrv_replace_node(throttle_node, bs, &error_abort);
+    blk_get_public(blk)->throttle_node = NULL;
+
+    bdrv_unref(bs);
+    bdrv_drained_end(bs);
+
 }
 
 /* should be called before blk_set_io_limits if a limit is set */
-void blk_io_limits_enable(BlockBackend *blk, const char *group)
+void blk_io_limits_enable(BlockBackend *blk, const char *group,  Error **errp)
 {
-    assert(!blk->public.throttle_group_member.throttle_state);
-    throttle_group_register_tgm(&blk->public.throttle_group_member,
-                                group, blk_get_aio_context(blk));
+    BlockDriverState *bs = blk_bs(blk), *throttle_node;
+    QDict *options = qdict_new();
+    Error *local_err = NULL;
+    ThrottleState *ts;
+
+    bdrv_drained_begin(bs);
+
+    /* Force creation of group in case it doesn't exist */
+    ts = throttle_group_incref(group);
+    qdict_set_default_str(options, "file", bs->node_name);
+    qdict_set_default_str(options, QEMU_OPT_THROTTLE_GROUP_NAME, group);
+    throttle_node = bdrv_new_open_driver(bdrv_find_format("throttle"), NULL,
+                                         bdrv_get_flags(bs), options, errp);
+    if (!throttle_node) {
+        goto end;
+    }
+    throttle_node->implicit = true;
+
+    blk_remove_bs(blk);
+    blk_insert_bs(blk, throttle_node, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        blk_insert_bs(blk, bs, &error_abort);
+        bdrv_unref(throttle_node);
+        throttle_node = NULL;
+        goto end;
+    }
+    bdrv_unref(throttle_node);
+
+    assert(throttle_node->file->bs == bs);
+    assert(throttle_node->refcnt == 1);
+
+end:
+    throttle_group_unref(ts);
+    bdrv_drained_end(bs);
+    blk_get_public(blk)->throttle_node = throttle_node;
 }
 
-void blk_io_limits_update_group(BlockBackend *blk, const char *group)
+void blk_io_limits_update_group(BlockBackend *blk, const char *group, Error **errp)
 {
+    ThrottleGroupMember *tgm;
+
     /* this BB is not part of any group */
-    if (!blk->public.throttle_group_member.throttle_state) {
+    if (!blk->public.throttle_node) {
         return;
     }
 
+    tgm = throttle_get_tgm(blk->public.throttle_node);
     /* this BB is a part of the same group than the one we want */
-    if (!g_strcmp0(throttle_group_get_name(&blk->public.throttle_group_member),
-                group)) {
+    if (!g_strcmp0(throttle_group_get_name(tgm), group)) {
         return;
     }
 
-    /* need to change the group this bs belong to */
+    /* need to change the group this bs belongs to */
     blk_io_limits_disable(blk);
-    blk_io_limits_enable(blk, group);
+    blk_io_limits_enable(blk, group, errp);
 }
 
 static void blk_root_drained_begin(BdrvChild *child)
 {
+    ThrottleGroupMember *tgm;
     BlockBackend *blk = child->opaque;
 
     if (++blk->quiesce_counter == 1) {
@@ -1997,19 +2025,25 @@ static void blk_root_drained_begin(BdrvChild *child)
 
     /* Note that blk->root may not be accessible here yet if we are just
      * attaching to a BlockDriverState that is drained. Use child instead. */
-
-    if (atomic_fetch_inc(&blk->public.throttle_group_member.io_limits_disabled) == 0) {
-        throttle_group_restart_tgm(&blk->public.throttle_group_member);
+    if (blk->public.throttle_node) {
+        tgm = throttle_get_tgm(blk->public.throttle_node);
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
+        tgm = throttle_get_tgm(blk->public.throttle_node);
+        assert(tgm->io_limits_disabled);
+        atomic_dec(&tgm->io_limits_disabled);
+    }
 
     if (--blk->quiesce_counter == 0) {
         if (blk->dev_ops && blk->dev_ops->drained_end) {
diff --git a/block/qapi.c b/block/qapi.c
index 847b044d13..ab55db7134 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -66,11 +66,12 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 
     info->detect_zeroes = bs->detect_zeroes;
 
-    if (blk && blk_get_public(blk)->throttle_group_member.throttle_state) {
+    if (blk && blk_get_public(blk)->throttle_node) {
         ThrottleConfig cfg;
-        BlockBackendPublic *blkp = blk_get_public(blk);
+        BlockDriverState *throttle_node = blk_get_public(blk)->throttle_node;
+        ThrottleGroupMember *tgm = throttle_get_tgm(throttle_node);
 
-        throttle_group_get_config(&blkp->throttle_group_member, &cfg);
+        throttle_group_get_config(tgm, &cfg);
 
         info->bps     = cfg.buckets[THROTTLE_BPS_TOTAL].avg;
         info->bps_rd  = cfg.buckets[THROTTLE_BPS_READ].avg;
@@ -118,8 +119,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         info->iops_size = cfg.op_size;
 
         info->has_group = true;
-        info->group =
-            g_strdup(throttle_group_get_name(&blkp->throttle_group_member));
+        info->group = g_strdup(throttle_group_get_name(tgm));
     }
 
     info->write_threshold = bdrv_write_threshold_get(bs);
diff --git a/block/throttle.c b/block/throttle.c
index 5ee1e2a7ca..7804ded709 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -35,6 +35,14 @@ static QemuOptsList throttle_opts = {
     },
 };
 
+static BlockDriver bdrv_throttle;
+
+ThrottleGroupMember *throttle_get_tgm(BlockDriverState *bs)
+{
+    assert(bs->drv == &bdrv_throttle);
+    return (ThrottleGroupMember *)bs->opaque;
+}
+
 static int throttle_configure_tgm(BlockDriverState *bs,
                                   ThrottleGroupMember *tgm,
                                   QDict *options, Error **errp)
diff --git a/blockdev.c b/blockdev.c
index 6ffa5b0b04..3f76eed2aa 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -607,7 +607,14 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
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
 
@@ -2629,6 +2636,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     BlockDriverState *bs;
     BlockBackend *blk;
     AioContext *aio_context;
+    Error *local_err = NULL;
 
     blk = qmp_get_blk(arg->has_device ? arg->device : NULL,
                       arg->has_id ? arg->id : NULL,
@@ -2704,18 +2712,29 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     if (throttle_enabled(&cfg)) {
         /* Enable I/O limits if they're not enabled yet, otherwise
          * just update the throttling group. */
-        if (!blk_get_public(blk)->throttle_group_member.throttle_state) {
-            blk_io_limits_enable(blk,
-                                 arg->has_group ? arg->group :
-                                 arg->has_device ? arg->device :
-                                 arg->id);
+        if (!blk_get_public(blk)->throttle_node) {
+            blk_io_limits_enable(blk, arg->has_group ? arg->group :
+                                 arg->has_device ? arg->device : arg->id,
+                                 &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                goto out;
+            }
         } else if (arg->has_group) {
-            blk_io_limits_update_group(blk, arg->group);
+            /* move throttle node membership to arg->group */
+            blk_io_limits_update_group(blk, arg->group, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                goto out;
+            }
         }
         /* Set the new throttling configuration */
         blk_set_io_limits(blk, &cfg);
-    } else if (blk_get_public(blk)->throttle_group_member.throttle_state) {
-        /* If all throttling settings are set to 0, disable I/O limits */
+    } else if (blk_get_public(blk)->throttle_node) {
+        /*
+         * If all throttling settings are set to 0, disable I/O limits
+         * by deleting the legacy throttle node
+         * */
         blk_io_limits_disable(blk);
     }
 
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 0ea9093eee..eef2b1c707 100644
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
 
     g_assert(tgm1->throttle_state == NULL);
     g_assert(tgm2->throttle_state == NULL);
@@ -655,6 +650,14 @@ static void test_groups(void)
     g_assert(tgm1->throttle_state == NULL);
     g_assert(tgm2->throttle_state == NULL);
     g_assert(tgm3->throttle_state == NULL);
+
+    g_free(tgm1);
+    g_free(tgm2);
+    g_free(tgm3);
+
+    blk_unref(blk1);
+    blk_unref(blk2);
+    blk_unref(blk3);
 }
 
 int main(int argc, char **argv)
-- 
2.11.0
