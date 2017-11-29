Received: from eggs.gnu.org ([2001:4830:134:3::10]:41730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3il-0006WE-Re
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:52:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3ik-0006YF-Gk
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:52:19 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 29 Nov 2017 22:49:55 +0800
Message-Id: <20171129144956.11409-9-famz@redhat.com>
In-Reply-To: <20171129144956.11409-1-famz@redhat.com>
References: <20171129144956.11409-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 8/9] block: Drop old drained_{begin,
 end} callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c                        | 24 ------------------------
 block/block-backend.c          | 22 ----------------------
 blockjob.c                     |  6 ------
 include/block/block.h          | 16 ----------------
 include/block/block_int.h      | 11 -----------
 include/sysemu/block-backend.h |  8 --------
 6 files changed, 87 deletions(-)

diff --git a/block.c b/block.c
index 949f0dec11..4434441df5 100644
--- a/block.c
+++ b/block.c
@@ -810,18 +810,6 @@ static char *bdrv_child_get_parent_desc(BdrvChild *c)
     return g_strdup(bdrv_get_device_or_node_name(parent));
 }
 
-static void bdrv_child_cb_drained_begin(BdrvChild *child)
-{
-    BlockDriverState *bs = child->opaque;
-    bdrv_drained_begin(bs);
-}
-
-static void bdrv_child_cb_drained_end(BdrvChild *child)
-{
-    BlockDriverState *bs = child->opaque;
-    bdrv_drained_end(bs);
-}
-
 static int bdrv_child_cb_inactivate(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
@@ -887,8 +875,6 @@ static void bdrv_inherited_options(int *child_flags, QDict *child_options,
 const BdrvChildRole child_file = {
     .get_parent_desc = bdrv_child_get_parent_desc,
     .inherit_options = bdrv_inherited_options,
-    .drained_begin   = bdrv_child_cb_drained_begin,
-    .drained_end     = bdrv_child_cb_drained_end,
     .inactivate      = bdrv_child_cb_inactivate,
 };
 
@@ -909,8 +895,6 @@ static void bdrv_inherited_fmt_options(int *child_flags, QDict *child_options,
 const BdrvChildRole child_format = {
     .get_parent_desc = bdrv_child_get_parent_desc,
     .inherit_options = bdrv_inherited_fmt_options,
-    .drained_begin   = bdrv_child_cb_drained_begin,
-    .drained_end     = bdrv_child_cb_drained_end,
     .inactivate      = bdrv_child_cb_inactivate,
 };
 
@@ -1022,8 +1006,6 @@ const BdrvChildRole child_backing = {
     .attach          = bdrv_backing_attach,
     .detach          = bdrv_backing_detach,
     .inherit_options = bdrv_backing_options,
-    .drained_begin   = bdrv_child_cb_drained_begin,
-    .drained_end     = bdrv_child_cb_drained_end,
     .inactivate      = bdrv_child_cb_inactivate,
     .update_filename = bdrv_backing_update_filename,
 };
@@ -1973,9 +1955,6 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
         assert(bdrv_get_aio_context(old_bs) == bdrv_get_aio_context(new_bs));
     }
     if (old_bs) {
-        if (old_bs->quiesce_counter && child->role->drained_end) {
-            child->role->drained_end(child);
-        }
         if (child->role->detach) {
             child->role->detach(child);
         }
@@ -1986,9 +1965,6 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
 
     if (new_bs) {
         QLIST_INSERT_HEAD(&new_bs->parents, child, next_parent);
-        if (new_bs->quiesce_counter && child->role->drained_begin) {
-            child->role->drained_begin(child);
-        }
 
         if (child->role->attach) {
             child->role->attach(child);
diff --git a/block/block-backend.c b/block/block-backend.c
index baef8e7abc..05855ab767 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -68,7 +68,6 @@ struct BlockBackend {
 
     NotifierList remove_bs_notifiers, insert_bs_notifiers;
 
-    int quiesce_counter;
     VMChangeStateEntry *vmsh;
     bool force_allow_inactivate;
 };
@@ -245,9 +244,6 @@ static const BdrvChildRole child_root = {
     .get_name           = blk_root_get_name,
     .get_parent_desc    = blk_root_get_parent_desc,
 
-    .drained_begin      = blk_root_drained_begin,
-    .drained_end        = blk_root_drained_end,
-
     .activate           = blk_root_activate,
     .inactivate         = blk_root_inactivate,
 };
@@ -887,11 +883,6 @@ void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops,
 
     blk->dev_ops = ops;
     blk->dev_opaque = opaque;
-
-    /* Are we currently quiesced? Should we enforce this right now? */
-    if (blk->quiesce_counter && ops->drained_begin) {
-        ops->drained_begin(opaque);
-    }
 }
 
 /*
@@ -2068,12 +2059,6 @@ static void blk_root_drained_begin(BdrvChild *child)
 {
     BlockBackend *blk = child->opaque;
 
-    if (++blk->quiesce_counter == 1) {
-        if (blk->dev_ops && blk->dev_ops->drained_begin) {
-            blk->dev_ops->drained_begin(blk->dev_opaque);
-        }
-    }
-
     /* Note that blk->root may not be accessible here yet if we are just
      * attaching to a BlockDriverState that is drained. Use child instead. */
 
@@ -2085,14 +2070,7 @@ static void blk_root_drained_begin(BdrvChild *child)
 static void blk_root_drained_end(BdrvChild *child)
 {
     BlockBackend *blk = child->opaque;
-    assert(blk->quiesce_counter);
 
     assert(blk->public.throttle_group_member.io_limits_disabled);
     atomic_dec(&blk->public.throttle_group_member.io_limits_disabled);
-
-    if (--blk->quiesce_counter == 0) {
-        if (blk->dev_ops && blk->dev_ops->drained_end) {
-            blk->dev_ops->drained_end(blk->dev_opaque);
-        }
-    }
 }
diff --git a/blockjob.c b/blockjob.c
index 86d060c89c..809111bf24 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -160,11 +160,6 @@ static void block_job_drained_end(void *opaque)
     block_job_resume(job);
 }
 
-static const BlockDevOps block_job_dev_ops = {
-    .drained_begin = block_job_drained_begin,
-    .drained_end = block_job_drained_end,
-};
-
 void block_job_unref(BlockJob *job)
 {
     if (--job->refcnt == 0) {
@@ -680,7 +675,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abort);
     bs->job = job;
 
-    blk_set_dev_ops(blk, &block_job_dev_ops, job);
     aio_context_add_drain_ops(blk_get_aio_context(blk),
                               block_job_drained_begin, block_job_drained_end,
                               job);
diff --git a/include/block/block.h b/include/block/block.h
index c05cac57e5..df73e77200 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -579,22 +579,6 @@ int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo);
 void bdrv_io_plug(BlockDriverState *bs);
 void bdrv_io_unplug(BlockDriverState *bs);
 
-/**
- * bdrv_parent_drained_begin:
- *
- * Begin a quiesced section of all users of @bs. This is part of
- * bdrv_drained_begin.
- */
-void bdrv_parent_drained_begin(BlockDriverState *bs);
-
-/**
- * bdrv_parent_drained_end:
- *
- * End a quiesced section of all users of @bs. This is part of
- * bdrv_drained_end.
- */
-void bdrv_parent_drained_end(BlockDriverState *bs);
-
 /**
  * bdrv_drained_begin:
  *
diff --git a/include/block/block_int.h b/include/block/block_int.h
index e107163594..8eed595682 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -535,17 +535,6 @@ struct BdrvChildRole {
      * caller is responsible for freeing the memory. */
     char *(*get_parent_desc)(BdrvChild *child);
 
-    /*
-     * If this pair of functions is implemented, the parent doesn't issue new
-     * requests after returning from .drained_begin() until .drained_end() is
-     * called.
-     *
-     * Note that this can be nested. If drained_begin() was called twice, new
-     * I/O is allowed only after drained_end() was called twice, too.
-     */
-    void (*drained_begin)(BdrvChild *child);
-    void (*drained_end)(BdrvChild *child);
-
     /* Notifies the parent that the child has been activated/inactivated (e.g.
      * when migration is completing) and it can start/stop requesting
      * permissions and doing I/O on it. */
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index c4e52a5fa3..9e81232a83 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -58,14 +58,6 @@ typedef struct BlockDevOps {
      * Runs when the size changed (e.g. monitor command block_resize)
      */
     void (*resize_cb)(void *opaque);
-    /*
-     * Runs when the backend receives a drain request.
-     */
-    void (*drained_begin)(void *opaque);
-    /*
-     * Runs when the backend's last drain request ends.
-     */
-    void (*drained_end)(void *opaque);
 } BlockDevOps;
 
 /* This struct is embedded in (the private) BlockBackend struct and contains
-- 
2.14.3
