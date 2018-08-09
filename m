Received: from eggs.gnu.org ([2001:4830:134:3::10]:43844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsdW-0004eA-9T
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsdQ-0004Qk-TN
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:38:26 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:37:53 +0200
Message-Id: <20180809213801.15098-4-mreitz@redhat.com>
In-Reply-To: <20180809213801.15098-1-mreitz@redhat.com>
References: <20180809213801.15098-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 03/11] block: Filtered children access functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

What bs->file and bs->backing mean depends on the node.  For filter
nodes, both signify a node that will eventually receive all R/W
accesses.  For format nodes, bs->file contains metadata and data, and
bs->backing will not receive writes -- instead, writes are COWed to
bs->file.  Usually.

In any case, it is not trivial to guess what a child means exactly with
our currently limited form of expression.  It is better to introduce
some functions that actually guarantee a meaning:

- bdrv_filtered_cow_child() will return the child that receives requests
  filtered through COW.  That is, reads may or may not be forwarded
  (depending on the overlay's allocation status), but writes never go to
  this child.

- bdrv_filtered_rw_child() will return the child that receives requests
  filtered through some very plain process.  Reads and writes issued to
  the parent will go to the child as well (although timing, etc. may be
  modified).

- All drivers but quorum (but quorum is pretty opaque to the general
  block layer anyway) always only have one of these children: All read
  requests must be served from the filtered_rw_child (if it exists), so
  if there was a filtered_cow_child in addition, it would not receive
  any requests at all.
  (The closest here is mirror, where all requests are passed on to the
  source, but with write-blocking, write requests are "COWed" to the
  target.  But that just means that the target is a special child that
  cannot be introspected by the generic block layer functions, and that
  source is a filtered_rw_child.)
  Therefore, we can also add bdrv_filtered_child() which returns that
  one child (or NULL, if there is no filtered child).

Also, many places in the current block layer should be skipping filters
(all filters or just the ones added implicitly, it depends) when going
through a block node chain.  They do not do that currently, but this
patch makes them.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json           |   4 +
 include/block/block.h          |   1 +
 include/block/block_int.h      |  33 +++++-
 block.c                        | 184 ++++++++++++++++++++++++++++-----
 block/backup.c                 |   8 +-
 block/block-backend.c          |  16 ++-
 block/commit.c                 |  36 ++++---
 block/io.c                     |  27 ++---
 block/mirror.c                 |  37 ++++---
 block/qapi.c                   |  26 ++---
 block/stream.c                 |  15 ++-
 blockdev.c                     |  84 ++++++++++++---
 migration/block-dirty-bitmap.c |   4 +-
 nbd/server.c                   |   8 +-
 qemu-img.c                     |  12 ++-
 15 files changed, 363 insertions(+), 132 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f20efc97f7..a71df88eb2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2248,6 +2248,10 @@
 # On successful completion the image file is updated to drop the backing file
 # and the BLOCK_JOB_COMPLETED event is emitted.
 #
+# In case @device is a filter node, block-stream modifies the first non-filter
+# overlay node below it to point to base's backing node (or NULL if @base was
+# not specified) instead of modifying @device itself.
+#
 # @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
diff --git a/include/block/block.h b/include/block/block.h
index 7ef118a704..a01986495d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -452,6 +452,7 @@ BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
                                  Error **errp);
 bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base);
+bool bdrv_legacy_chain_contains(BlockDriverState *top, BlockDriverState *base);
 BlockDriverState *bdrv_next_node(BlockDriverState *bs);
 BlockDriverState *bdrv_next_all_states(BlockDriverState *bs);
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 90217512b5..fa9154899d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -91,6 +91,7 @@ struct BlockDriver {
      * certain callbacks that refer to data (see block.c) to their bs->file if
      * the driver doesn't implement them. Drivers that do not wish to forward
      * must implement them and return -ENOTSUP.
+     * Note that filters are not allowed to modify data.
      */
     bool is_filter;
     /* for snapshots block filter like Quorum can implement the
@@ -887,11 +888,6 @@ typedef enum BlockMirrorBackingMode {
     MIRROR_LEAVE_BACKING_CHAIN,
 } BlockMirrorBackingMode;
 
-static inline BlockDriverState *backing_bs(BlockDriverState *bs)
-{
-    return bs->backing ? bs->backing->bs : NULL;
-}
-
 
 /* Essential block drivers which must always be statically linked into qemu, and
  * which therefore can be accessed without using bdrv_find_format() */
@@ -1215,4 +1211,31 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
 
 int refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 
+BdrvChild *bdrv_filtered_cow_child(BlockDriverState *bs);
+BdrvChild *bdrv_filtered_rw_child(BlockDriverState *bs);
+BdrvChild *bdrv_filtered_child(BlockDriverState *bs);
+BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs);
+BlockDriverState *bdrv_skip_rw_filters(BlockDriverState *bs);
+BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
+
+static inline BlockDriverState *child_bs(BdrvChild *child)
+{
+    return child ? child->bs : NULL;
+}
+
+static inline BlockDriverState *bdrv_filtered_cow_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_filtered_cow_child(bs));
+}
+
+static inline BlockDriverState *bdrv_filtered_rw_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_filtered_rw_child(bs));
+}
+
+static inline BlockDriverState *bdrv_filtered_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_filtered_child(bs));
+}
+
 #endif /* BLOCK_INT_H */
diff --git a/block.c b/block.c
index 5118d992c3..61a2fe14eb 100644
--- a/block.c
+++ b/block.c
@@ -532,11 +532,12 @@ int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
 int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *filtered = bdrv_filtered_rw_bs(bs);
 
     if (drv && drv->bdrv_probe_blocksizes) {
         return drv->bdrv_probe_blocksizes(bs, bsz);
-    } else if (drv && drv->is_filter && bs->file) {
-        return bdrv_probe_blocksizes(bs->file->bs, bsz);
+    } else if (filtered) {
+        return bdrv_probe_blocksizes(filtered, bsz);
     }
 
     return -ENOTSUP;
@@ -551,11 +552,12 @@ int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
 int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *filtered = bdrv_filtered_rw_bs(bs);
 
     if (drv && drv->bdrv_probe_geometry) {
         return drv->bdrv_probe_geometry(bs, geo);
-    } else if (drv && drv->is_filter && bs->file) {
-        return bdrv_probe_geometry(bs->file->bs, geo);
+    } else if (filtered) {
+        return bdrv_probe_geometry(filtered, geo);
     }
 
     return -ENOTSUP;
@@ -2261,7 +2263,7 @@ static void bdrv_parent_cb_change_media(BlockDriverState *bs, bool load)
 }
 
 /*
- * Sets the backing file link of a BDS. A new reference is created; callers
+ * Sets the bs->backing link of a BDS. A new reference is created; callers
  * which don't need their own reference any more must call bdrv_unref().
  */
 void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
@@ -2313,7 +2315,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     QDict *tmp_parent_options = NULL;
     Error *local_err = NULL;
 
-    if (bs->backing != NULL) {
+    if (bdrv_filtered_cow_child(bs) != NULL) {
         goto free_exit;
     }
 
@@ -3722,8 +3724,8 @@ int bdrv_change_backing_file(BlockDriverState *bs,
 BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
                                     BlockDriverState *bs)
 {
-    while (active && bs != backing_bs(active)) {
-        active = backing_bs(active);
+    while (active && bs != bdrv_filtered_bs(active)) {
+        active = bdrv_filtered_bs(active);
     }
 
     return active;
@@ -3926,10 +3928,14 @@ bool bdrv_is_sg(BlockDriverState *bs)
 
 bool bdrv_is_encrypted(BlockDriverState *bs)
 {
-    if (bs->backing && bs->backing->bs->encrypted) {
+    BlockDriverState *filtered = bdrv_filtered_bs(bs);
+    if (bs->encrypted) {
         return true;
     }
-    return bs->encrypted;
+    if (filtered && bdrv_is_encrypted(filtered)) {
+        return true;
+    }
+    return false;
 }
 
 const char *bdrv_get_format_name(BlockDriverState *bs)
@@ -4068,7 +4074,19 @@ BlockDriverState *bdrv_lookup_bs(const char *device,
 bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base)
 {
     while (top && top != base) {
-        top = backing_bs(top);
+        top = bdrv_filtered_bs(top);
+    }
+
+    return top != NULL;
+}
+
+/* Same as bdrv_chain_contains(), but skip implicitly added R/W filter
+ * nodes and do not move past explicitly added R/W filters. */
+bool bdrv_legacy_chain_contains(BlockDriverState *top, BlockDriverState *base)
+{
+    top = bdrv_skip_implicit_filters(top);
+    while (top && top != base) {
+        top = bdrv_skip_implicit_filters(bdrv_filtered_cow_bs(top));
     }
 
     return top != NULL;
@@ -4140,20 +4158,24 @@ int bdrv_has_zero_init_1(BlockDriverState *bs)
 
 int bdrv_has_zero_init(BlockDriverState *bs)
 {
+    BlockDriverState *filtered;
+
     if (!bs->drv) {
         return 0;
     }
 
     /* If BS is a copy on write image, it is initialized to
        the contents of the base image, which may not be zeroes.  */
-    if (bs->backing) {
+    if (bdrv_filtered_cow_child(bs)) {
         return 0;
     }
     if (bs->drv->bdrv_has_zero_init) {
         return bs->drv->bdrv_has_zero_init(bs);
     }
-    if (bs->file && bs->drv->is_filter) {
-        return bdrv_has_zero_init(bs->file->bs);
+
+    filtered = bdrv_filtered_rw_bs(bs);
+    if (filtered) {
+        return bdrv_has_zero_init(filtered);
     }
 
     /* safe default */
@@ -4164,7 +4186,7 @@ bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs)
 {
     BlockDriverInfo bdi;
 
-    if (bs->backing) {
+    if (bdrv_filtered_cow_child(bs)) {
         return false;
     }
 
@@ -4198,8 +4220,9 @@ int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
         return -ENOMEDIUM;
     }
     if (!drv->bdrv_get_info) {
-        if (bs->file && drv->is_filter) {
-            return bdrv_get_info(bs->file->bs, bdi);
+        BlockDriverState *filtered = bdrv_filtered_rw_bs(bs);
+        if (filtered) {
+            return bdrv_get_info(filtered, bdi);
         }
         return -ENOTSUP;
     }
@@ -4301,7 +4324,15 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
 
     is_protocol = path_has_protocol(backing_file);
 
-    for (curr_bs = bs; curr_bs->backing; curr_bs = curr_bs->backing->bs) {
+    /* Being largely a legacy function, skip any filters here
+     * (because filters do not have normal filenames, so they cannot
+     * match anyway; and allowing json:{} filenames is a bit out of
+     * scope) */
+    for (curr_bs = bdrv_skip_rw_filters(bs);
+         bdrv_filtered_cow_child(curr_bs) != NULL;
+         curr_bs = bdrv_backing_chain_next(curr_bs))
+    {
+        BlockDriverState *bs_below = bdrv_backing_chain_next(curr_bs);
 
         /* If either of the filename paths is actually a protocol, then
          * compare unmodified paths; otherwise make paths relative */
@@ -4309,7 +4340,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
             char *backing_file_full_ret;
 
             if (strcmp(backing_file, curr_bs->backing_file) == 0) {
-                retval = curr_bs->backing->bs;
+                retval = bs_below;
                 break;
             }
             /* Also check against the full backing filename for the image */
@@ -4319,7 +4350,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
                 bool equal = strcmp(backing_file, backing_file_full_ret) == 0;
                 g_free(backing_file_full_ret);
                 if (equal) {
-                    retval = curr_bs->backing->bs;
+                    retval = bs_below;
                     break;
                 }
             }
@@ -4345,7 +4376,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
             g_free(filename_tmp);
 
             if (strcmp(backing_file_full, filename_full) == 0) {
-                retval = curr_bs->backing->bs;
+                retval = bs_below;
                 break;
             }
         }
@@ -5256,9 +5287,10 @@ static bool append_strong_runtime_options(QDict *d, BlockDriverState *bs)
  * would result in exactly bs->backing. */
 static bool bdrv_backing_overridden(BlockDriverState *bs)
 {
-    if (bs->backing) {
-        return strcmp(bs->auto_backing_file,
-                      bs->backing->bs->filename);
+    BlockDriverState *backing = bdrv_filtered_cow_bs(bs);
+
+    if (backing) {
+        return strcmp(bs->auto_backing_file, backing->filename);
     } else {
         /* No backing BDS, so if the image header reports any backing
          * file, it must have been suppressed */
@@ -5341,7 +5373,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
                       qobject_ref(child->bs->full_open_options));
         }
 
-        if (backing_overridden && !bs->backing) {
+        if (backing_overridden && !bdrv_filtered_cow_child(bs)) {
             /* Force no backing file */
             qdict_put_null(opts, "backing");
         }
@@ -5487,3 +5519,105 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
 
     return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
 }
+
+/*
+ * Return the child that @bs acts as an overlay for, and from which data may be
+ * copied in COW or COR operations.  Usually this is the backing file.
+ */
+BdrvChild *bdrv_filtered_cow_child(BlockDriverState *bs)
+{
+    if (!bs || !bs->drv) {
+        return NULL;
+    }
+
+    if (bs->drv->is_filter) {
+        return NULL;
+    }
+
+    return bs->backing;
+}
+
+/*
+ * If @bs acts as a pass-through filter for one of its children,
+ * return that child.  "Pass-through" means that write operations to
+ * @bs are forwarded to that child instead of triggering COW.
+ */
+BdrvChild *bdrv_filtered_rw_child(BlockDriverState *bs)
+{
+    if (!bs || !bs->drv) {
+        return NULL;
+    }
+
+    if (!bs->drv->is_filter) {
+        return NULL;
+    }
+
+    return bs->backing ?: bs->file;
+}
+
+/*
+ * Return any filtered child, independently on how it reacts to write
+ * accesses and whether data is copied onto this BDS through COR.
+ */
+BdrvChild *bdrv_filtered_child(BlockDriverState *bs)
+{
+    BdrvChild *cow_child = bdrv_filtered_cow_child(bs);
+    BdrvChild *rw_child = bdrv_filtered_rw_child(bs);
+
+    /* There can only be one filtered child at a time */
+    assert(!(cow_child && rw_child));
+
+    return cow_child ?: rw_child;
+}
+
+static BlockDriverState *bdrv_skip_filters(BlockDriverState *bs,
+                                           bool stop_on_explicit_filter)
+{
+    BdrvChild *filtered;
+
+    if (!bs) {
+        return NULL;
+    }
+
+    while (!(stop_on_explicit_filter && !bs->implicit)) {
+        filtered = bdrv_filtered_rw_child(bs);
+        if (!filtered) {
+            break;
+        }
+        bs = filtered->bs;
+    }
+    /* Note that this treats nodes with bs->drv == NULL as not being
+     * R/W filters (bs->drv == NULL should be replaced by something
+     * else anyway).
+     * The advantage of this behavior is that this function will thus
+     * always return a non-NULL value (given a non-NULL @bs). */
+
+    return bs;
+}
+
+/*
+ * Return the first BDS that has not been added implicitly or that
+ * does not have an RW-filtered child down the chain starting from @bs
+ * (including @bs itself).
+ */
+BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs)
+{
+    return bdrv_skip_filters(bs, true);
+}
+
+/*
+ * Return the first BDS that does not have an RW-filtered child down
+ * the chain starting from @bs (including @bs itself).
+ */
+BlockDriverState *bdrv_skip_rw_filters(BlockDriverState *bs)
+{
+    return bdrv_skip_filters(bs, false);
+}
+
+/*
+ * For a backing chain, return the first non-filter backing image.
+ */
+BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs)
+{
+    return bdrv_skip_rw_filters(bdrv_filtered_cow_bs(bdrv_skip_rw_filters(bs)));
+}
diff --git a/block/backup.c b/block/backup.c
index 8630d32926..4ddc0bb632 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -618,6 +618,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     int64_t len;
     BlockDriverInfo bdi;
     BackupBlockJob *job = NULL;
+    bool target_does_cow;
     int ret;
 
     assert(bs);
@@ -712,8 +713,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     /* If there is no backing file on the target, we cannot rely on COW if our
      * backup cluster size is smaller than the target cluster size. Even for
      * targets with a backing file, try to avoid COW if possible. */
+    target_does_cow = bdrv_filtered_cow_child(target);
     ret = bdrv_get_info(target, &bdi);
-    if (ret == -ENOTSUP && !target->backing) {
+    if (ret == -ENOTSUP && !target_does_cow) {
         /* Cluster size is not defined */
         warn_report("The target block device doesn't provide "
                     "information about the block size and it doesn't have a "
@@ -722,14 +724,14 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                     "this default, the backup may be unusable",
                     BACKUP_CLUSTER_SIZE_DEFAULT);
         job->cluster_size = BACKUP_CLUSTER_SIZE_DEFAULT;
-    } else if (ret < 0 && !target->backing) {
+    } else if (ret < 0 && !target_does_cow) {
         error_setg_errno(errp, -ret,
             "Couldn't determine the cluster size of the target image, "
             "which has no backing file");
         error_append_hint(errp,
             "Aborting, since this may create an unusable destination image\n");
         goto error;
-    } else if (ret < 0 && target->backing) {
+    } else if (ret < 0 && target_does_cow) {
         /* Not fatal; just trudge on ahead. */
         job->cluster_size = BACKUP_CLUSTER_SIZE_DEFAULT;
     } else {
diff --git a/block/block-backend.c b/block/block-backend.c
index fa120630be..832c5e3838 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2114,11 +2114,17 @@ int blk_commit_all(void)
         AioContext *aio_context = blk_get_aio_context(blk);
 
         aio_context_acquire(aio_context);
-        if (blk_is_inserted(blk) && blk->root->bs->backing) {
-            int ret = bdrv_commit(blk->root->bs);
-            if (ret < 0) {
-                aio_context_release(aio_context);
-                return ret;
+        if (blk_is_inserted(blk)) {
+            BlockDriverState *non_filter;
+
+            /* Legacy function, so skip implicit filters */
+            non_filter = bdrv_skip_implicit_filters(blk->root->bs);
+            if (bdrv_filtered_cow_child(non_filter)) {
+                int ret = bdrv_commit(non_filter);
+                if (ret < 0) {
+                    aio_context_release(aio_context);
+                    return ret;
+                }
             }
         }
         aio_context_release(aio_context);
diff --git a/block/commit.c b/block/commit.c
index a95b87bb3a..3ea8e76a50 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -124,10 +124,9 @@ static void commit_complete(Job *job, void *opaque)
      * filter driver from the backing chain. Do this as the final step so that
      * the 'consistent read' permission can be granted.  */
     if (remove_commit_top_bs) {
-        bdrv_child_try_set_perm(commit_top_bs->backing, 0, BLK_PERM_ALL,
-                                &error_abort);
-        bdrv_replace_node(commit_top_bs, backing_bs(commit_top_bs),
-                          &error_abort);
+        BdrvChild *unfiltered_top = bdrv_filtered_rw_child(commit_top_bs);
+        bdrv_child_try_set_perm(unfiltered_top, 0, BLK_PERM_ALL, &error_abort);
+        bdrv_replace_node(commit_top_bs, unfiltered_top->bs, &error_abort);
     }
 
     bdrv_unref(commit_top_bs);
@@ -331,9 +330,13 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     bdrv_unref(commit_top_bs);
 
     /* Block all nodes between top and base, because they will
-     * disappear from the chain after this operation. */
+     * disappear from the chain after this operation.
+     * Note that this assumes that the user is fine with removing all
+     * nodes (including R/W filters) between top and base.  Assuring
+     * this is the responsibility of the interface (i.e. whoever calls
+     * commit_start()). */
     assert(bdrv_chain_contains(top, base));
-    for (iter = top; iter != base; iter = backing_bs(iter)) {
+    for (iter = top; iter != base; iter = bdrv_filtered_bs(iter)) {
         /* XXX BLK_PERM_WRITE needs to be allowed so we don't block ourselves
          * at s->base (if writes are blocked for a node, they are also blocked
          * for its backing file). The other options would be a second filter
@@ -410,20 +413,23 @@ int bdrv_commit(BlockDriverState *bs)
     if (!drv)
         return -ENOMEDIUM;
 
-    if (!bs->backing) {
+    backing_file_bs = bdrv_filtered_cow_bs(bs);
+
+    if (!backing_file_bs) {
         return -ENOTSUP;
     }
 
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_COMMIT_SOURCE, NULL) ||
-        bdrv_op_is_blocked(bs->backing->bs, BLOCK_OP_TYPE_COMMIT_TARGET, NULL)) {
+        bdrv_op_is_blocked(backing_file_bs, BLOCK_OP_TYPE_COMMIT_TARGET, NULL))
+    {
         return -EBUSY;
     }
 
-    ro = bs->backing->bs->read_only;
-    open_flags =  bs->backing->bs->open_flags;
+    ro = backing_file_bs->read_only;
+    open_flags =  backing_file_bs->open_flags;
 
     if (ro) {
-        if (bdrv_reopen(bs->backing->bs, open_flags | BDRV_O_RDWR, NULL)) {
+        if (bdrv_reopen(backing_file_bs, open_flags | BDRV_O_RDWR, NULL)) {
             return -EACCES;
         }
     }
@@ -438,8 +444,6 @@ int bdrv_commit(BlockDriverState *bs)
     }
 
     /* Insert commit_top block node above backing, so we can write to it */
-    backing_file_bs = backing_bs(bs);
-
     commit_top_bs = bdrv_new_open_driver(&bdrv_commit_top, NULL, BDRV_O_RDWR,
                                          &local_err);
     if (commit_top_bs == NULL) {
@@ -525,15 +529,13 @@ ro_cleanup:
     qemu_vfree(buf);
 
     blk_unref(backing);
-    if (backing_file_bs) {
-        bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
-    }
+    bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
     bdrv_unref(commit_top_bs);
     blk_unref(src);
 
     if (ro) {
         /* ignoring error return here */
-        bdrv_reopen(bs->backing->bs, open_flags & ~BDRV_O_RDWR, NULL);
+        bdrv_reopen(backing_file_bs, open_flags & ~BDRV_O_RDWR, NULL);
     }
 
     return ret;
diff --git a/block/io.c b/block/io.c
index 7100344c7b..8a442d37b2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -120,6 +120,7 @@ static void bdrv_merge_limits(BlockLimits *dst, const BlockLimits *src)
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *cow_bs = bdrv_filtered_cow_bs(bs);
     Error *local_err = NULL;
 
     memset(&bs->bl, 0, sizeof(bs->bl));
@@ -148,13 +149,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
         bs->bl.max_iov = IOV_MAX;
     }
 
-    if (bs->backing) {
-        bdrv_refresh_limits(bs->backing->bs, &local_err);
+    if (cow_bs) {
+        bdrv_refresh_limits(cow_bs, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
-        bdrv_merge_limits(&bs->bl, &bs->backing->bs->bl);
+        bdrv_merge_limits(&bs->bl, &cow_bs->bl);
     }
 
     /* Then let the driver override it */
@@ -2170,11 +2171,12 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
     } else if (want_zero) {
+        BlockDriverState *cow_bs = bdrv_filtered_cow_bs(bs);
+
         if (bdrv_unallocated_blocks_are_zero(bs)) {
             ret |= BDRV_BLOCK_ZERO;
-        } else if (bs->backing) {
-            BlockDriverState *bs2 = bs->backing->bs;
-            int64_t size2 = bdrv_getlength(bs2);
+        } else if (cow_bs) {
+            int64_t size2 = bdrv_getlength(cow_bs);
 
             if (size2 >= 0 && offset >= size2) {
                 ret |= BDRV_BLOCK_ZERO;
@@ -2239,7 +2241,7 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
     bool first = true;
 
     assert(bs != base);
-    for (p = bs; p != base; p = backing_bs(p)) {
+    for (p = bs; p != base; p = bdrv_filtered_bs(p)) {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
         if (ret < 0) {
@@ -2324,7 +2326,7 @@ int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
 int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
                       int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
-    return bdrv_block_status_above(bs, backing_bs(bs),
+    return bdrv_block_status_above(bs, bdrv_filtered_bs(bs),
                                    offset, bytes, pnum, map, file);
 }
 
@@ -2334,7 +2336,7 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
     int ret;
     int64_t dummy;
 
-    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false, offset,
+    ret = bdrv_common_block_status_above(bs, bdrv_filtered_bs(bs), false, offset,
                                          bytes, pnum ? pnum : &dummy, NULL,
                                          NULL);
     if (ret < 0) {
@@ -2390,7 +2392,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
             n = pnum_inter;
         }
 
-        intermediate = backing_bs(intermediate);
+        intermediate = bdrv_filtered_bs(intermediate);
     }
 
     *pnum = n;
@@ -3169,8 +3171,9 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
     }
 
     if (!drv->bdrv_co_truncate) {
-        if (bs->file && drv->is_filter) {
-            ret = bdrv_co_truncate(bs->file, offset, prealloc, errp);
+        BdrvChild *filtered = bdrv_filtered_rw_child(bs);
+        if (filtered) {
+            ret = bdrv_co_truncate(filtered, offset, prealloc, errp);
             goto out;
         }
         error_setg(errp, "Image format driver does not support resize");
diff --git a/block/mirror.c b/block/mirror.c
index 5c561c6241..85f5742eae 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -618,7 +618,7 @@ static void mirror_exit(Job *job, void *opaque)
     MirrorExitData *data = opaque;
     MirrorBDSOpaque *bs_opaque = s->mirror_top_bs->opaque;
     AioContext *replace_aio_context = NULL;
-    BlockDriverState *src = s->mirror_top_bs->backing->bs;
+    BlockDriverState *src = bdrv_filtered_rw_bs(s->mirror_top_bs);
     BlockDriverState *target_bs = blk_bs(s->target);
     BlockDriverState *mirror_top_bs = s->mirror_top_bs;
     Error *local_err = NULL;
@@ -644,12 +644,13 @@ static void mirror_exit(Job *job, void *opaque)
 
     /* We don't access the source any more. Dropping any WRITE/RESIZE is
      * required before it could become a backing file of target_bs. */
-    bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
-                            &error_abort);
+    bdrv_child_try_set_perm(bdrv_filtered_rw_child(mirror_top_bs),
+                            0, BLK_PERM_ALL, &error_abort);
     if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing = s->is_none_mode ? src : s->base;
-        if (backing_bs(target_bs) != backing) {
-            bdrv_set_backing_hd(target_bs, backing, &local_err);
+        if (bdrv_backing_chain_next(target_bs) != backing) {
+            bdrv_set_backing_hd(bdrv_skip_rw_filters(target_bs), backing,
+                                &local_err);
             if (local_err) {
                 error_report_err(local_err);
                 data->ret = -EPERM;
@@ -698,9 +699,10 @@ static void mirror_exit(Job *job, void *opaque)
      * valid. Also give up permissions on mirror_top_bs->backing, which might
      * block the removal. */
     block_job_remove_all_bdrv(bjob);
-    bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
-                            &error_abort);
-    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
+    bdrv_child_try_set_perm(bdrv_filtered_rw_child(mirror_top_bs),
+                            0, BLK_PERM_ALL, &error_abort);
+    bdrv_replace_node(mirror_top_bs, bdrv_filtered_rw_bs(mirror_top_bs),
+                      &error_abort);
 
     /* We just changed the BDS the job BB refers to (with either or both of the
      * bdrv_replace_node() calls), so switch the BB back so the cleanup does
@@ -881,7 +883,7 @@ static void coroutine_fn mirror_run(void *opaque)
     } else {
         s->target_cluster_size = BDRV_SECTOR_SIZE;
     }
-    if (backing_filename[0] && !target_bs->backing &&
+    if (backing_filename[0] && !bdrv_filtered_cow_child(target_bs) &&
         s->granularity < s->target_cluster_size) {
         s->buf_size = MAX(s->buf_size, s->target_cluster_size);
         s->cow_bitmap = bitmap_new(length);
@@ -1060,7 +1062,7 @@ static void mirror_complete(Job *job, Error **errp)
     if (s->backing_mode == MIRROR_OPEN_BACKING_CHAIN) {
         int ret;
 
-        assert(!target->backing);
+        assert(!bdrv_filtered_cow_child(target));
         ret = bdrv_open_backing_file(target, NULL, "backing", errp);
         if (ret < 0) {
             return;
@@ -1604,7 +1606,9 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
      * any jobs in them must be blocked */
     if (target_is_backing) {
         BlockDriverState *iter;
-        for (iter = backing_bs(bs); iter != target; iter = backing_bs(iter)) {
+        for (iter = bdrv_filtered_bs(bs); iter != target;
+             iter = bdrv_filtered_bs(iter))
+        {
             /* XXX BLK_PERM_WRITE needs to be allowed so we don't block
              * ourselves at s->base (if writes are blocked for a node, they are
              * also blocked for its backing file). The other options would be a
@@ -1636,9 +1640,10 @@ fail:
         job_early_fail(&s->common.job);
     }
 
-    bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
-                            &error_abort);
-    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
+    bdrv_child_try_set_perm(bdrv_filtered_rw_child(mirror_top_bs),
+                            0, BLK_PERM_ALL, &error_abort);
+    bdrv_replace_node(mirror_top_bs, bdrv_filtered_rw_bs(mirror_top_bs),
+                      &error_abort);
 
     bdrv_unref(mirror_top_bs);
 }
@@ -1653,14 +1658,14 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   MirrorCopyMode copy_mode, Error **errp)
 {
     bool is_none_mode;
-    BlockDriverState *base;
+    BlockDriverState *base = NULL;
 
     if (mode == MIRROR_SYNC_MODE_INCREMENTAL) {
         error_setg(errp, "Sync mode 'incremental' not supported");
         return;
     }
     is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
-    base = mode == MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
+    base = mode == MIRROR_SYNC_MODE_TOP ? bdrv_backing_chain_next(bs) : NULL;
     mirror_start_job(job_id, bs, JOB_DEFAULT, target, replaces,
                      speed, granularity, buf_size, backing_mode,
                      on_source_error, on_target_error, unmap, NULL, NULL,
diff --git a/block/qapi.c b/block/qapi.c
index 430d4b24d4..f2eb83945e 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -149,9 +149,9 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
             return NULL;
         }
 
-        if (bs0->drv && bs0->backing) {
+        if (bs0->drv && bdrv_filtered_cow_child(bs0)) {
             info->backing_file_depth++;
-            bs0 = bs0->backing->bs;
+            bs0 = bdrv_filtered_cow_bs(bs0);
             (*p_image_info)->has_backing_image = true;
             p_image_info = &((*p_image_info)->backing_image);
         } else {
@@ -160,9 +160,8 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 
         /* Skip automatically inserted nodes that the user isn't aware of for
          * query-block (blk != NULL), but not for query-named-block-nodes */
-        while (blk && bs0->drv && bs0->implicit) {
-            bs0 = backing_bs(bs0);
-            assert(bs0);
+        if (blk) {
+            bs0 = bdrv_skip_implicit_filters(bs0);
         }
     }
 
@@ -342,9 +341,9 @@ static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
     BlockDriverState *bs = blk_bs(blk);
     char *qdev;
 
-    /* Skip automatically inserted nodes that the user isn't aware of */
-    while (bs && bs->drv && bs->implicit) {
-        bs = backing_bs(bs);
+    if (bs) {
+        /* Skip automatically inserted nodes that the user isn't aware of */
+        bs = bdrv_skip_implicit_filters(bs);
     }
 
     info->device = g_strdup(blk_name(blk));
@@ -501,6 +500,7 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
 static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
                                         bool blk_level)
 {
+    BlockDriverState *cow_bs;
     BlockStats *s = NULL;
 
     s = g_malloc0(sizeof(*s));
@@ -513,9 +513,8 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
     /* Skip automatically inserted nodes that the user isn't aware of in
      * a BlockBackend-level command. Stay at the exact node for a node-level
      * command. */
-    while (blk_level && bs->drv && bs->implicit) {
-        bs = backing_bs(bs);
-        assert(bs);
+    if (blk_level) {
+        bs = bdrv_skip_implicit_filters(bs);
     }
 
     if (bdrv_get_node_name(bs)[0]) {
@@ -530,9 +529,10 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
         s->parent = bdrv_query_bds_stats(bs->file->bs, blk_level);
     }
 
-    if (blk_level && bs->backing) {
+    cow_bs = bdrv_filtered_cow_bs(bs);
+    if (blk_level && cow_bs) {
         s->has_backing = true;
-        s->backing = bdrv_query_bds_stats(bs->backing->bs, blk_level);
+        s->backing = bdrv_query_bds_stats(cow_bs, blk_level);
     }
 
     return s;
diff --git a/block/stream.c b/block/stream.c
index 9264b68a1e..77933ed09e 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -64,10 +64,13 @@ static void stream_complete(Job *job, void *opaque)
     BlockJob *bjob = &s->common;
     StreamCompleteData *data = opaque;
     BlockDriverState *bs = blk_bs(bjob->blk);
+    BlockDriverState *unfiltered = bdrv_skip_rw_filters(bs);
     BlockDriverState *base = s->base;
     Error *local_err = NULL;
 
-    if (!job_is_cancelled(job) && bs->backing && data->ret == 0) {
+    if (!job_is_cancelled(job) && bdrv_filtered_cow_child(unfiltered) &&
+        data->ret == 0)
+    {
         const char *base_id = NULL, *base_fmt = NULL;
         if (base) {
             base_id = s->backing_file_str;
@@ -75,7 +78,7 @@ static void stream_complete(Job *job, void *opaque)
                 base_fmt = base->drv->format_name;
             }
         }
-        data->ret = bdrv_change_backing_file(bs, base_id, base_fmt);
+        data->ret = bdrv_change_backing_file(unfiltered, base_id, base_fmt);
         bdrv_set_backing_hd(bs, base, &local_err);
         if (local_err) {
             error_report_err(local_err);
@@ -112,7 +115,7 @@ static void coroutine_fn stream_run(void *opaque)
     int64_t n = 0; /* bytes */
     void *buf;
 
-    if (!bs->backing) {
+    if (!bdrv_filtered_child(bs)) {
         goto out;
     }
 
@@ -153,7 +156,7 @@ static void coroutine_fn stream_run(void *opaque)
         } else if (ret >= 0) {
             /* Copy if allocated in the intermediate images.  Limit to the
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
-            ret = bdrv_is_allocated_above(backing_bs(bs), base,
+            ret = bdrv_is_allocated_above(bdrv_filtered_bs(bs), base,
                                           offset, n, &n);
 
             /* Finish early if end of backing file has been reached */
@@ -252,7 +255,9 @@ void stream_start(const char *job_id, BlockDriverState *bs,
      * disappear from the chain after this operation. The streaming job reads
      * every block only once, assuming that it doesn't change, so block writes
      * and resizes. */
-    for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
+    for (iter = bdrv_filtered_bs(bs); iter && iter != base;
+         iter = bdrv_filtered_bs(iter))
+    {
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED,
                            &error_abort);
diff --git a/blockdev.c b/blockdev.c
index 2d61588a9a..33dd6408c0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1092,7 +1092,7 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
             return;
         }
 
-        bs = blk_bs(blk);
+        bs = bdrv_skip_implicit_filters(blk_bs(blk));
         aio_context = bdrv_get_aio_context(bs);
         aio_context_acquire(aio_context);
 
@@ -1662,7 +1662,7 @@ static void external_snapshot_prepare(BlkActionState *common,
         goto out;
     }
 
-    if (state->new_bs->backing != NULL) {
+    if (bdrv_filtered_cow_child(state->new_bs)) {
         error_setg(errp, "The snapshot already has a backing image");
         goto out;
     }
@@ -3158,6 +3158,11 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         if (!base_bs) {
             goto out;
         }
+        /* Streaming copies data through COR, so all of the filters
+         * between the target and the base are considered.  Therefore,
+         * we can use bdrv_chain_contains() and do not have to use
+         * bdrv_legacy_chain_contains() (which does not go past
+         * explicitly added filters). */
         if (bs == base_bs || !bdrv_chain_contains(bs, base_bs)) {
             error_setg(errp, "Node '%s' is not a backing image of '%s'",
                        base_node, device);
@@ -3169,7 +3174,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     }
 
     /* Check for op blockers in the whole chain between bs and base */
-    for (iter = bs; iter && iter != base_bs; iter = backing_bs(iter)) {
+    for (iter = bs; iter && iter != base_bs; iter = bdrv_filtered_bs(iter)) {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_STREAM, errp)) {
             goto out;
         }
@@ -3282,7 +3287,9 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
 
     assert(bdrv_get_aio_context(base_bs) == aio_context);
 
-    for (iter = top_bs; iter != backing_bs(base_bs); iter = backing_bs(iter)) {
+    for (iter = top_bs; iter != bdrv_filtered_bs(base_bs);
+         iter = bdrv_filtered_bs(iter))
+    {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_COMMIT_TARGET, errp)) {
             goto out;
         }
@@ -3293,6 +3300,12 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
         error_setg(errp, "cannot commit an image into itself");
         goto out;
     }
+    if (!bdrv_legacy_chain_contains(top_bs, base_bs)) {
+        /* We have to disallow this until the user can give explicit
+         * consent */
+        error_setg(errp, "Cannot commit through explicit filter nodes");
+        goto out;
+    }
 
     if (top_bs == bs) {
         if (has_backing_file) {
@@ -3384,7 +3397,11 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
     /* See if we have a backing HD we can use to create our new image
      * on top of. */
     if (backup->sync == MIRROR_SYNC_MODE_TOP) {
-        source = backing_bs(bs);
+        /* Backup will not replace the source by the target, so none
+         * of the filters skipped here will be removed (in contrast to
+         * mirror).  Therefore, we can skip all of them when looking
+         * for the first COW relationship. */
+        source = bdrv_filtered_cow_bs(bdrv_skip_rw_filters(bs));
         if (!source) {
             backup->sync = MIRROR_SYNC_MODE_FULL;
         }
@@ -3404,9 +3421,14 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
     if (backup->mode != NEW_IMAGE_MODE_EXISTING) {
         assert(backup->format);
         if (source) {
-            bdrv_refresh_filename(source);
-            bdrv_img_create(backup->target, backup->format, source->filename,
-                            source->drv->format_name, NULL,
+            /* Implicit filters should not appear in the filename */
+            BlockDriverState *explicit_backing =
+                bdrv_skip_implicit_filters(source);
+
+            bdrv_refresh_filename(explicit_backing);
+            bdrv_img_create(backup->target, backup->format,
+                            explicit_backing->filename,
+                            explicit_backing->drv->format_name, NULL,
                             size, flags, false, &local_err);
         } else {
             bdrv_img_create(backup->target, backup->format, NULL, NULL, NULL,
@@ -3640,7 +3662,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    if (!bs->backing && sync == MIRROR_SYNC_MODE_TOP) {
+    if (!bdrv_backing_chain_next(bs) && sync == MIRROR_SYNC_MODE_TOP) {
         sync = MIRROR_SYNC_MODE_FULL;
     }
 
@@ -3680,8 +3702,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
     /* pass the node name to replace to mirror start since it's loose coupling
      * and will allow to check whether the node still exist at mirror completion
      */
-    mirror_start(job_id, bs, target,
-                 has_replaces ? replaces : NULL,
+    mirror_start(job_id, bs, target, replaces,
                  speed, granularity, buf_size, sync, backing_mode,
                  on_source_error, on_target_error, unmap, filter_node_name,
                  copy_mode, errp);
@@ -3689,7 +3710,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
 
 void qmp_drive_mirror(DriveMirror *arg, Error **errp)
 {
-    BlockDriverState *bs;
+    BlockDriverState *bs, *unfiltered_bs;
     BlockDriverState *source, *target_bs;
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode;
@@ -3698,6 +3719,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     int flags;
     int64_t size;
     const char *format = arg->format;
+    const char *replaces_node_name = NULL;
 
     bs = qmp_get_root_bs(arg->device, errp);
     if (!bs) {
@@ -3709,6 +3731,14 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         return;
     }
 
+    /* If the user has not instructed us otherwise, we should let the
+     * block job run from @bs (thus taking into account all filters on
+     * it) but replace @unfiltered_bs when it finishes (thus not
+     * removing those filters).
+     * (And if there are any explicit filters, we should assume the
+     *  user knows how to use the @replaces option.) */
+    unfiltered_bs = bdrv_skip_implicit_filters(bs);
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3722,8 +3752,14 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     }
 
     flags = bs->open_flags | BDRV_O_RDWR;
-    source = backing_bs(bs);
+    source = bdrv_filtered_cow_bs(unfiltered_bs);
     if (!source && arg->sync == MIRROR_SYNC_MODE_TOP) {
+        if (bdrv_filtered_bs(unfiltered_bs)) {
+            /* @unfiltered_bs is an explicit filter */
+            error_setg(errp, "Cannot perform sync=top mirror through an "
+                       "explicitly added filter node on the source");
+            goto out;
+        }
         arg->sync = MIRROR_SYNC_MODE_FULL;
     }
     if (arg->sync == MIRROR_SYNC_MODE_NONE) {
@@ -3742,6 +3778,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
                              " named node of the graph");
             goto out;
         }
+        replaces_node_name = arg->replaces;
+    } else if (unfiltered_bs != bs) {
+        replaces_node_name = unfiltered_bs->node_name;
     }
 
     if (arg->mode == NEW_IMAGE_MODE_ABSOLUTE_PATHS) {
@@ -3761,6 +3800,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         bdrv_img_create(arg->target, format,
                         NULL, NULL, NULL, size, flags, false, &local_err);
     } else {
+        /* Implicit filters should not appear in the filename */
+        BlockDriverState *explicit_backing = bdrv_skip_implicit_filters(source);
+
         switch (arg->mode) {
         case NEW_IMAGE_MODE_EXISTING:
             break;
@@ -3768,8 +3810,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
             /* create new image with backing file */
             bdrv_refresh_filename(source);
             bdrv_img_create(arg->target, format,
-                            source->filename,
-                            source->drv->format_name,
+                            explicit_backing->filename,
+                            explicit_backing->drv->format_name,
                             NULL, size, flags, false, &local_err);
             break;
         default:
@@ -3801,7 +3843,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     bdrv_set_aio_context(target_bs, aio_context);
 
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, target_bs,
-                           arg->has_replaces, arg->replaces, arg->sync,
+                           !!replaces_node_name, replaces_node_name, arg->sync,
                            backing_mode, arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
                            arg->has_buf_size, arg->buf_size,
@@ -3833,7 +3875,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                          bool has_copy_mode, MirrorCopyMode copy_mode,
                          Error **errp)
 {
-    BlockDriverState *bs;
+    BlockDriverState *bs, *unfiltered_bs;
     BlockDriverState *target_bs;
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode = MIRROR_LEAVE_BACKING_CHAIN;
@@ -3844,6 +3886,14 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
         return;
     }
 
+    /* Same as in qmp_drive_mirror(): We want to run the job from @bs,
+     * but we want to replace @unfiltered_bs on completion. */
+    unfiltered_bs = bdrv_skip_implicit_filters(bs);
+    if (!has_replaces && unfiltered_bs != bs) {
+        replaces = unfiltered_bs->node_name;
+        has_replaces = true;
+    }
+
     target_bs = bdrv_lookup_bs(target, target, errp);
     if (!target_bs) {
         return;
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 477826330c..2890dffc73 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -284,9 +284,7 @@ static int init_dirty_bitmap_migration(void)
         const char *drive_name = bdrv_get_device_or_node_name(bs);
 
         /* skip automatically inserted nodes */
-        while (bs && bs->drv && bs->implicit) {
-            bs = backing_bs(bs);
-        }
+        bs = bdrv_skip_implicit_filters(bs);
 
         for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
              bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
diff --git a/nbd/server.c b/nbd/server.c
index ea5fe0eb33..ea654a20c1 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2415,13 +2415,9 @@ void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
         return;
     }
 
-    while (true) {
+    while (bs && !bm) {
         bm = bdrv_find_dirty_bitmap(bs, bitmap);
-        if (bm != NULL || bs->backing == NULL) {
-            break;
-        }
-
-        bs = bs->backing->bs;
+        bs = bdrv_filtered_bs(bs);
     }
 
     if (bm == NULL) {
diff --git a/qemu-img.c b/qemu-img.c
index 0752bbe4d9..307e72c9fd 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -996,7 +996,7 @@ static int img_commit(int argc, char **argv)
     if (!blk) {
         return 1;
     }
-    bs = blk_bs(blk);
+    bs = bdrv_skip_implicit_filters(blk_bs(blk));
 
     qemu_progress_init(progress, 1.f);
     qemu_progress_print(0.f, 100);
@@ -1013,7 +1013,7 @@ static int img_commit(int argc, char **argv)
         /* This is different from QMP, which by default uses the deepest file in
          * the backing chain (i.e., the very base); however, the traditional
          * behavior of qemu-img commit is using the immediate backing file. */
-        base_bs = backing_bs(bs);
+        base_bs = bdrv_filtered_cow_bs(bs);
         if (!base_bs) {
             error_setg(&local_err, "Image does not have a backing file");
             goto done;
@@ -2438,7 +2438,8 @@ static int img_convert(int argc, char **argv)
          * s.target_backing_sectors has to be negative, which it will
          * be automatically).  The backing file length is used only
          * for optimizations, so such a case is not fatal. */
-        s.target_backing_sectors = bdrv_nb_sectors(out_bs->backing->bs);
+        s.target_backing_sectors =
+            bdrv_nb_sectors(bdrv_filtered_cow_bs(out_bs));
     } else {
         s.target_backing_sectors = -1;
     }
@@ -2806,11 +2807,12 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
         if (ret & (BDRV_BLOCK_ZERO|BDRV_BLOCK_DATA)) {
             break;
         }
-        bs = backing_bs(bs);
+        bs = bdrv_filtered_cow_bs(bs);
         if (bs == NULL) {
             ret = 0;
             break;
         }
+        bs = bdrv_skip_implicit_filters(bs);
 
         depth++;
     }
@@ -2940,7 +2942,7 @@ static int img_map(int argc, char **argv)
     if (!blk) {
         return 1;
     }
-    bs = blk_bs(blk);
+    bs = bdrv_skip_implicit_filters(blk_bs(blk));
 
     if (output_format == OFORMAT_HUMAN) {
         printf("%-16s%-16s%-16s%s\n", "Offset", "Length", "Mapped to", "File");
-- 
2.17.1
