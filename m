Received: from eggs.gnu.org ([2001:4830:134:3::10]:60392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcXZ1-0005ky-4l
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcXYy-0005Mf-U7
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:50:23 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Tue,  1 Aug 2017 16:49:07 +0300
Message-Id: <20170801134907.31253-4-el13635@mail.ntua.gr>
In-Reply-To: <20170801134907.31253-1-el13635@mail.ntua.gr>
References: <20170801134907.31253-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 3/3] block: remove legacy I/O throttling
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
 block.c                         |   8 +++
 block/block-backend.c           | 149 +++++++++++++++++++++++++---------------
 block/qapi.c                    |  14 ++--
 block/throttle.c                |   8 +++
 blockdev.c                      |  55 +++++++++++----
 include/block/block_int.h       |  13 ++++
 include/block/throttle-groups.h |   2 +
 include/sysemu/block-backend.h  |   8 +--
 tests/test-throttle.c           |  15 ++--
 9 files changed, 186 insertions(+), 86 deletions(-)

diff --git a/block.c b/block.c
index 9ebdba28b0..c6aad25286 100644
--- a/block.c
+++ b/block.c
@@ -1975,6 +1975,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
     child = g_new(BdrvChild, 1);
     *child = (BdrvChild) {
         .bs             = NULL,
+        .parent_bs      = NULL,
         .name           = g_strdup(child_name),
         .role           = child_role,
         .perm           = perm,
@@ -2009,6 +2010,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
     if (child == NULL) {
         return NULL;
     }
+    child->parent_bs = parent_bs;
 
     QLIST_INSERT_HEAD(&parent_bs->children, child, next);
     return child;
@@ -3729,6 +3731,12 @@ const char *bdrv_get_parent_name(const BlockDriverState *bs)
                 return name;
             }
         }
+        if (c->parent_bs && c->parent_bs->implicit) {
+            name = bdrv_get_parent_name(c->parent_bs);
+            if (name && *name) {
+                return name;
+            }
+        }
     }
 
     return NULL;
diff --git a/block/block-backend.c b/block/block-backend.c
index df0200fc49..45f45efee9 100644
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
@@ -282,8 +283,8 @@ static void blk_delete(BlockBackend *blk)
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
@@ -593,13 +594,7 @@ BlockBackend *blk_by_public(BlockBackendPublic *public)
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
 
@@ -620,12 +615,6 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
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
 
@@ -983,13 +972,6 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
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
@@ -1010,11 +992,6 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
     }
 
     bdrv_inc_in_flight(bs);
-    /* throttling disk I/O */
-    if (blk->public.throttle_group_member.throttle_state) {
-        throttle_group_co_io_limits_intercept(&blk->public.throttle_group_member,
-                bytes, true);
-    }
 
     if (!blk->enable_write_cache) {
         flags |= BDRV_REQ_FUA;
@@ -1682,16 +1659,9 @@ static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb)
 void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
 {
     BlockDriverState *bs = blk_bs(blk);
-    ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
 
     if (bs) {
-        if (tgm->throttle_state) {
-            throttle_group_detach_aio_context(tgm);
-        }
         bdrv_set_aio_context(bs, new_context);
-        if (tgm->throttle_state) {
-            throttle_group_attach_aio_context(tgm, new_context);
-        }
     }
 }
 
@@ -1909,45 +1879,110 @@ int blk_commit_all(void)
 /* throttling disk I/O limits */
 void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg)
 {
-    throttle_group_config(&blk->public.throttle_group_member, cfg);
+    assert(blk->public.throttle_node);
+    throttle_group_config(throttle_get_tgm(blk->public.throttle_node), cfg);
 }
 
-void blk_io_limits_disable(BlockBackend *blk)
+void blk_io_limits_disable(BlockBackend *blk, Error **errp)
 {
-    assert(blk->public.throttle_group_member.throttle_state);
-    bdrv_drained_begin(blk_bs(blk));
-    throttle_group_unregister_tgm(&blk->public.throttle_group_member);
-    bdrv_drained_end(blk_bs(blk));
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
+    blk_insert_bs(blk, bs, &error_abort);
+    bdrv_unref(bs);
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
+
+    bdrv_drained_begin(bs);
+    /*
+     * increase bs ref count so it doesn't get deleted when removed
+     * from the BlockBackend's root
+     * */
+    bdrv_ref(bs);
+    blk_remove_bs(blk);
+
+    qdict_set_default_str(options, "file", bs->node_name);
+    qdict_set_default_str(options, QEMU_OPT_THROTTLE_GROUP_NAME, group);
+    throttle_node = bdrv_new_open_driver(bdrv_find_format("throttle"),
+            NULL, bdrv_get_flags(bs), options, errp);
+    QDECREF(options);
+    if (!throttle_node) {
+        blk_insert_bs(blk, bs, &error_abort);
+        bdrv_unref(bs);
+        bdrv_drained_end(bs);
+        return;
+    }
+    throttle_node->implicit = true;
+    /* bs will be throttle_node's child now so unref it*/
+    bdrv_unref(bs);
+
+    blk_insert_bs(blk, throttle_node, &local_err);
+    if (local_err) {
+        bdrv_ref(bs);
+        bdrv_unref(throttle_node);
+        blk_insert_bs(blk, bs, &error_abort);
+        bdrv_unref(bs);
+        error_propagate(errp, local_err);
+        return;
+    }
+    bdrv_unref(throttle_node);
+
+    assert(throttle_node->file->bs == bs);
+    assert(throttle_node->refcnt == 1);
+
+    bdrv_drained_end(bs);
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
 
+    tgm = throttle_get_tgm(blk->public.throttle_node);
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
@@ -1958,19 +1993,25 @@ static void blk_root_drained_begin(BdrvChild *child)
 
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
index 8d18920ae1..cfc3236757 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -66,11 +66,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 
     info->detect_zeroes = bs->detect_zeroes;
 
-    if (blk && blk_get_public(blk)->throttle_group_member.throttle_state) {
+    if (blk && blk_get_public(blk)->throttle_node) {
         ThrottleConfig cfg;
-        BlockBackendPublic *blkp = blk_get_public(blk);
+        ThrottleGroupMember *tgm = throttle_get_tgm(blk_get_public(blk)->throttle_node);
 
-        throttle_group_get_config(&blkp->throttle_group_member, &cfg);
+        throttle_group_get_config(tgm, &cfg);
 
         info->bps     = cfg.buckets[THROTTLE_BPS_TOTAL].avg;
         info->bps_rd  = cfg.buckets[THROTTLE_BPS_READ].avg;
@@ -119,7 +119,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 
         info->has_group = true;
         info->group =
-            g_strdup(throttle_group_get_name(&blkp->throttle_group_member));
+            g_strdup(throttle_group_get_name(tgm));
     }
 
     info->write_threshold = bdrv_write_threshold_get(bs);
@@ -148,7 +148,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         /* Skip automatically inserted nodes that the user isn't aware of for
          * query-block (blk != NULL), but not for query-named-block-nodes */
         while (blk && bs0 && bs0->drv && bs0->implicit) {
-            bs0 = backing_bs(bs0);
+            bs0 = child_bs(bs0);
         }
     }
 
@@ -336,7 +336,7 @@ static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
 
     /* Skip automatically inserted nodes that the user isn't aware of */
     while (bs && bs->drv && bs->implicit) {
-        bs = backing_bs(bs);
+        bs = child_bs(bs);
     }
 
     info->device = g_strdup(blk_name(blk));
@@ -465,7 +465,7 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
      * a BlockBackend-level command. Stay at the exact node for a node-level
      * command. */
     while (blk_level && bs->drv && bs->implicit) {
-        bs = backing_bs(bs);
+        bs = child_bs(bs);
         assert(bs);
     }
 
diff --git a/block/throttle.c b/block/throttle.c
index f3395462fb..f7d1510c79 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -38,6 +38,14 @@ static QemuOptsList throttle_opts = {
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
 /* Extract ThrottleConfig options. Assumes cfg is initialized and will be
  * checked for validity.
  */
diff --git a/blockdev.c b/blockdev.c
index d903a23786..6fafd0efbc 100644
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
 
@@ -2616,6 +2623,9 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     BlockDriverState *bs;
     BlockBackend *blk;
     AioContext *aio_context;
+    BlockDriverState *throttle_node = NULL;
+    ThrottleGroupMember *tgm;
+    Error *local_err = NULL;
 
     blk = qmp_get_blk(arg->has_device ? arg->device : NULL,
                       arg->has_id ? arg->id : NULL,
@@ -2691,19 +2701,38 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
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
+        tgm = throttle_get_tgm(throttle_node);
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
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 9eeae490f0..e19bd81498 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -514,6 +514,7 @@ extern const BdrvChildRole child_backing;
 
 struct BdrvChild {
     BlockDriverState *bs;
+    BlockDriverState *parent_bs;
     char *name;
     const BdrvChildRole *role;
     void *opaque;
@@ -695,11 +696,23 @@ typedef enum BlockMirrorBackingMode {
     MIRROR_LEAVE_BACKING_CHAIN,
 } BlockMirrorBackingMode;
 
+static inline BlockDriverState *file_bs(BlockDriverState *bs)
+{
+    return bs->file ? bs->file->bs : NULL;
+}
 static inline BlockDriverState *backing_bs(BlockDriverState *bs)
 {
     return bs->backing ? bs->backing->bs : NULL;
 }
 
+/* Returns either bs->file->bs or bs->backing->bs. Used for filter drivers,
+ * which only have one child */
+static inline BlockDriverState *child_bs(BlockDriverState *bs)
+{
+    assert(!(file_bs(bs) && backing_bs(bs)));
+    return backing_bs(bs) ? backing_bs(bs) : file_bs(bs);
+}
+
 
 /* Essential block drivers which must always be statically linked into qemu, and
  * which therefore can be accessed without using bdrv_find_format() */
diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
index 82f030523f..ba86a9601a 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -76,5 +76,7 @@ void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm
 void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
                                        AioContext *new_context);
 void throttle_group_detach_aio_context(ThrottleGroupMember *tgm);
+ThrottleGroupMember *throttle_get_tgm(BlockDriverState *bs);
+
 
 #endif
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 0e0cda7521..2079657d3a 100644
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
@@ -224,8 +224,8 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
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
index 0ea9093eee..e1403a2039 100644
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
@@ -655,6 +650,10 @@ static void test_groups(void)
     g_assert(tgm1->throttle_state == NULL);
     g_assert(tgm2->throttle_state == NULL);
     g_assert(tgm3->throttle_state == NULL);
+
+    g_free(tgm1);
+    g_free(tgm2);
+    g_free(tgm3);
 }
 
 int main(int argc, char **argv)
-- 
2.11.0
