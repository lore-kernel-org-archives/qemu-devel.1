Received: from eggs.gnu.org ([2001:4830:134:3::10]:43989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csy5p-0004qp-OW
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csy5n-0003ck-0v
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:51:53 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 28 Mar 2017 22:51:27 +0200
Message-Id: <20170328205129.15138-3-mreitz@redhat.com>
In-Reply-To: <20170328205129.15138-1-mreitz@redhat.com>
References: <20170328205129.15138-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.10 2/4] block: Add errp to b{lk,
 drv}_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

For one thing, this allows us to drop the error message generation from
qemu-img.c and blockdev.c and instead have it unified in
bdrv_truncate().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h          |  2 +-
 include/sysemu/block-backend.h |  2 +-
 block.c                        | 16 ++++++++++++----
 block/blkdebug.c               |  2 +-
 block/block-backend.c          |  5 +++--
 block/commit.c                 |  5 +++--
 block/crypto.c                 |  2 +-
 block/mirror.c                 |  2 +-
 block/parallels.c              | 13 ++++++++-----
 block/qcow.c                   |  6 +++---
 block/qcow2-refcount.c         |  5 ++++-
 block/qcow2.c                  | 14 +++++++++-----
 block/qed.c                    |  2 +-
 block/raw-format.c             |  2 +-
 block/vdi.c                    |  4 ++--
 block/vhdx-log.c               |  2 +-
 block/vhdx.c                   | 10 +++-------
 block/vmdk.c                   | 13 +++----------
 block/vpc.c                    | 13 +++++++------
 blockdev.c                     | 21 +--------------------
 qemu-img.c                     | 17 ++++-------------
 qemu-io-cmds.c                 |  5 +++--
 22 files changed, 73 insertions(+), 90 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 5149260827..4c9ed0e43c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -294,7 +294,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     const char *backing_file);
 int bdrv_get_backing_file_depth(BlockDriverState *bs);
 void bdrv_refresh_filename(BlockDriverState *bs);
-int bdrv_truncate(BdrvChild *child, int64_t offset);
+int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp);
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
 int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 7462228ac1..0ba4e277b9 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -225,7 +225,7 @@ int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                                       int count, BdrvRequestFlags flags);
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
                           int count);
-int blk_truncate(BlockBackend *blk, int64_t offset);
+int blk_truncate(BlockBackend *blk, int64_t offset, Error **errp);
 int blk_pdiscard(BlockBackend *blk, int64_t offset, int count);
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size);
diff --git a/block.c b/block.c
index 6e906ec53c..9ed526e01d 100644
--- a/block.c
+++ b/block.c
@@ -3222,7 +3222,7 @@ exit:
 /**
  * Truncate file to 'offset' bytes (needed only for file protocols)
  */
-int bdrv_truncate(BdrvChild *child, int64_t offset)
+int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
@@ -3230,12 +3230,18 @@ int bdrv_truncate(BdrvChild *child, int64_t offset)
 
     assert(child->perm & BLK_PERM_RESIZE);
 
-    if (!drv)
+    if (!drv) {
+        error_setg(errp, "No medium inserted");
         return -ENOMEDIUM;
-    if (!drv->bdrv_truncate)
+    }
+    if (!drv->bdrv_truncate) {
+        error_setg(errp, "Image format driver does not support resize");
         return -ENOTSUP;
-    if (bs->read_only)
+    }
+    if (bs->read_only) {
+        error_setg(errp, "Image is read-only");
         return -EACCES;
+    }
 
     ret = drv->bdrv_truncate(bs, offset);
     if (ret == 0) {
@@ -3243,6 +3249,8 @@ int bdrv_truncate(BdrvChild *child, int64_t offset)
         bdrv_dirty_bitmap_truncate(bs);
         bdrv_parent_cb_resize(bs);
         ++bs->write_gen;
+    } else {
+        error_setg_errno(errp, -ret, "Failed to resize image");
     }
     return ret;
 }
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 67e8024e36..15a9966096 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -663,7 +663,7 @@ static int64_t blkdebug_getlength(BlockDriverState *bs)
 
 static int blkdebug_truncate(BlockDriverState *bs, int64_t offset)
 {
-    return bdrv_truncate(bs->file, offset);
+    return bdrv_truncate(bs->file, offset, NULL);
 }
 
 static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
diff --git a/block/block-backend.c b/block/block-backend.c
index 0b6377332c..3abd9005b9 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1705,13 +1705,14 @@ int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
                    BDRV_REQ_WRITE_COMPRESSED);
 }
 
-int blk_truncate(BlockBackend *blk, int64_t offset)
+int blk_truncate(BlockBackend *blk, int64_t offset, Error **errp)
 {
     if (!blk_is_available(blk)) {
+        error_setg(errp, "No medium inserted");
         return -ENOMEDIUM;
     }
 
-    return bdrv_truncate(blk->root, offset);
+    return bdrv_truncate(blk->root, offset, errp);
 }
 
 static void blk_pdiscard_entry(void *opaque)
diff --git a/block/commit.c b/block/commit.c
index 28324820a4..bfdd1b4142 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -151,7 +151,7 @@ static void coroutine_fn commit_run(void *opaque)
     }
 
     if (base_len < s->common.len) {
-        ret = blk_truncate(s->base, s->common.len);
+        ret = blk_truncate(s->base, s->common.len, NULL);
         if (ret) {
             goto out;
         }
@@ -508,8 +508,9 @@ int bdrv_commit(BlockDriverState *bs)
      * grow the backing file image if possible.  If not possible,
      * we must return an error */
     if (length > backing_length) {
-        ret = blk_truncate(backing, length);
+        ret = blk_truncate(backing, length, &local_err);
         if (ret < 0) {
+            error_report_err(local_err);
             goto ro_cleanup;
         }
     }
diff --git a/block/crypto.c b/block/crypto.c
index 4a2038888d..52e4f2b20f 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -389,7 +389,7 @@ static int block_crypto_truncate(BlockDriverState *bs, int64_t offset)
 
     offset += payload_offset;
 
-    return bdrv_truncate(bs->file, offset);
+    return bdrv_truncate(bs->file, offset, NULL);
 }
 
 static void block_crypto_close(BlockDriverState *bs)
diff --git a/block/mirror.c b/block/mirror.c
index 9e2fecc15e..d40e199761 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -724,7 +724,7 @@ static void coroutine_fn mirror_run(void *opaque)
         }
 
         if (s->bdev_length > base_length) {
-            ret = blk_truncate(s->target, s->bdev_length);
+            ret = blk_truncate(s->target, s->bdev_length, NULL);
             if (ret < 0) {
                 goto immediate_exit;
             }
diff --git a/block/parallels.c b/block/parallels.c
index 4173b3fb9d..5fe97a126b 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -216,7 +216,8 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
                                      space << BDRV_SECTOR_BITS, 0);
         } else {
             ret = bdrv_truncate(bs->file,
-                                (s->data_end + space) << BDRV_SECTOR_BITS);
+                                (s->data_end + space) << BDRV_SECTOR_BITS,
+                                NULL);
         }
         if (ret < 0) {
             return ret;
@@ -449,8 +450,10 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
                 size - res->image_end_offset);
         res->leaks += count;
         if (fix & BDRV_FIX_LEAKS) {
-            ret = bdrv_truncate(bs->file, res->image_end_offset);
+            Error *local_err = NULL;
+            ret = bdrv_truncate(bs->file, res->image_end_offset, &local_err);
             if (ret < 0) {
+                error_report_err(local_err);
                 res->check_errors++;
                 return ret;
             }
@@ -497,7 +500,7 @@ static int parallels_create(const char *filename, QemuOpts *opts, Error **errp)
 
     blk_set_allow_write_beyond_eof(file, true);
 
-    ret = blk_truncate(file, 0);
+    ret = blk_truncate(file, 0, errp);
     if (ret < 0) {
         goto exit;
     }
@@ -689,7 +692,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs) ||
-            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs)) != 0) {
+            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs), NULL) != 0) {
         s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
     }
 
@@ -732,7 +735,7 @@ static void parallels_close(BlockDriverState *bs)
     }
 
     if (bs->open_flags & BDRV_O_RDWR) {
-        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS);
+        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, NULL);
     }
 
     g_free(s->bat_dirty_bmap);
diff --git a/block/qcow.c b/block/qcow.c
index 9d6ac83959..5d147b962e 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -473,7 +473,7 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
                 /* round to cluster size */
                 cluster_offset = (cluster_offset + s->cluster_size - 1) &
                     ~(s->cluster_size - 1);
-                bdrv_truncate(bs->file, cluster_offset + s->cluster_size);
+                bdrv_truncate(bs->file, cluster_offset + s->cluster_size, NULL);
                 /* if encrypted, we must initialize the cluster
                    content which won't be written */
                 if (bs->encrypted &&
@@ -833,7 +833,7 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
 
     blk_set_allow_write_beyond_eof(qcow_blk, true);
 
-    ret = blk_truncate(qcow_blk, 0);
+    ret = blk_truncate(qcow_blk, 0, errp);
     if (ret < 0) {
         goto exit;
     }
@@ -916,7 +916,7 @@ static int qcow_make_empty(BlockDriverState *bs)
     if (bdrv_pwrite_sync(bs->file, s->l1_table_offset, s->l1_table,
             l1_length) < 0)
         return -1;
-    ret = bdrv_truncate(bs->file, s->l1_table_offset + l1_length);
+    ret = bdrv_truncate(bs->file, s->l1_table_offset + l1_length, NULL);
     if (ret < 0)
         return ret;
 
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 9e96f64c8b..4efca7ebdb 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1728,14 +1728,17 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
 
             if (fix & BDRV_FIX_ERRORS) {
                 int64_t new_nb_clusters;
+                Error *local_err = NULL;
 
                 if (offset > INT64_MAX - s->cluster_size) {
                     ret = -EINVAL;
                     goto resize_fail;
                 }
 
-                ret = bdrv_truncate(bs->file, offset + s->cluster_size);
+                ret = bdrv_truncate(bs->file, offset + s->cluster_size,
+                                    &local_err);
                 if (ret < 0) {
+                    error_report_err(local_err);
                     goto resize_fail;
                 }
                 size = bdrv_getlength(bs->file->bs);
diff --git a/block/qcow2.c b/block/qcow2.c
index 6a92d2ef3f..845eee4bd9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2294,9 +2294,9 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     }
 
     /* Okay, now that we have a valid image, let's give it the right size */
-    ret = blk_truncate(blk, total_size);
+    ret = blk_truncate(blk, total_size, errp);
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not resize image");
+        error_prepend(errp, "Could not resize image: ");
         goto out;
     }
 
@@ -2584,7 +2584,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         /* align end of file to a sector boundary to ease reading with
            sector based I/Os */
         cluster_offset = bdrv_getlength(bs->file->bs);
-        return bdrv_truncate(bs->file, cluster_offset);
+        return bdrv_truncate(bs->file, cluster_offset, NULL);
     }
 
     buf = qemu_blockalign(bs, s->cluster_size);
@@ -2674,6 +2674,7 @@ fail:
 static int make_completely_empty(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
+    Error *local_err = NULL;
     int ret, l1_clusters;
     int64_t offset;
     uint64_t *new_reftable = NULL;
@@ -2798,8 +2799,10 @@ static int make_completely_empty(BlockDriverState *bs)
         goto fail;
     }
 
-    ret = bdrv_truncate(bs->file, (3 + l1_clusters) * s->cluster_size);
+    ret = bdrv_truncate(bs->file, (3 + l1_clusters) * s->cluster_size,
+                        &local_err);
     if (ret < 0) {
+        error_report_err(local_err);
         goto fail;
     }
 
@@ -3273,9 +3276,10 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
             return ret;
         }
 
-        ret = blk_truncate(blk, new_size);
+        ret = blk_truncate(blk, new_size, &local_err);
         blk_unref(blk);
         if (ret < 0) {
+            error_report_err(local_err);
             return ret;
         }
     }
diff --git a/block/qed.c b/block/qed.c
index 5ec7fd83f2..53199ac8d7 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -635,7 +635,7 @@ static int qed_create(const char *filename, uint32_t cluster_size,
     blk_set_allow_write_beyond_eof(blk, true);
 
     /* File must start empty and grow, check truncate is supported */
-    ret = blk_truncate(blk, 0);
+    ret = blk_truncate(blk, 0, errp);
     if (ret < 0) {
         goto out;
     }
diff --git a/block/raw-format.c b/block/raw-format.c
index 86fbc657eb..a80073369a 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -341,7 +341,7 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset)
 
     s->size = offset;
     offset += s->offset;
-    return bdrv_truncate(bs->file, offset);
+    return bdrv_truncate(bs->file, offset, NULL);
 }
 
 static int raw_media_changed(BlockDriverState *bs)
diff --git a/block/vdi.c b/block/vdi.c
index 9b4f70e977..d12d9cdc79 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -832,9 +832,9 @@ static int vdi_create(const char *filename, QemuOpts *opts, Error **errp)
     }
 
     if (image_type == VDI_TYPE_STATIC) {
-        ret = blk_truncate(blk, offset + blocks * block_size);
+        ret = blk_truncate(blk, offset + blocks * block_size, errp);
         if (ret < 0) {
-            error_setg(errp, "Failed to statically allocate %s", filename);
+            error_prepend(errp, "Failed to statically allocate %s", filename);
             goto exit;
         }
     }
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 67a91c0de5..3f4c2aa095 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -548,7 +548,7 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
             if (new_file_size % (1024*1024)) {
                 /* round up to nearest 1MB boundary */
                 new_file_size = ((new_file_size >> 20) + 1) << 20;
-                bdrv_truncate(bs->file, new_file_size);
+                bdrv_truncate(bs->file, new_file_size, NULL);
             }
         }
         qemu_vfree(desc_entries);
diff --git a/block/vhdx.c b/block/vhdx.c
index d25bcd91de..e8fe3fb5e9 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1171,7 +1171,7 @@ static int vhdx_allocate_block(BlockDriverState *bs, BDRVVHDXState *s,
     /* per the spec, the address for a block is in units of 1MB */
     *new_offset = ROUND_UP(*new_offset, 1024 * 1024);
 
-    return bdrv_truncate(bs->file, *new_offset + s->block_size);
+    return bdrv_truncate(bs->file, *new_offset + s->block_size, NULL);
 }
 
 /*
@@ -1607,17 +1607,13 @@ static int vhdx_create_bat(BlockBackend *blk, BDRVVHDXState *s,
     if (type == VHDX_TYPE_DYNAMIC) {
         /* All zeroes, so we can just extend the file - the end of the BAT
          * is the furthest thing we have written yet */
-        ret = blk_truncate(blk, data_file_offset);
+        ret = blk_truncate(blk, data_file_offset, errp);
         if (ret < 0) {
-            error_setg_errno(errp, -ret,
-                            "Failed to resize the underlying file");
             goto exit;
         }
     } else if (type == VHDX_TYPE_FIXED) {
-        ret = blk_truncate(blk, data_file_offset + image_size);
+        ret = blk_truncate(blk, data_file_offset + image_size, errp);
         if (ret < 0) {
-            error_setg_errno(errp, -ret,
-                            "Failed to resize the underlying file");
             goto exit;
         }
     } else {
diff --git a/block/vmdk.c b/block/vmdk.c
index a9bd22bf93..c61b9cc8e0 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1714,10 +1714,7 @@ static int vmdk_create_extent(const char *filename, int64_t filesize,
     blk_set_allow_write_beyond_eof(blk, true);
 
     if (flat) {
-        ret = blk_truncate(blk, filesize);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "Could not truncate file");
-        }
+        ret = blk_truncate(blk, filesize, errp);
         goto exit;
     }
     magic = cpu_to_be32(VMDK4_MAGIC);
@@ -1780,9 +1777,8 @@ static int vmdk_create_extent(const char *filename, int64_t filesize,
         goto exit;
     }
 
-    ret = blk_truncate(blk, le64_to_cpu(header.grain_offset) << 9);
+    ret = blk_truncate(blk, le64_to_cpu(header.grain_offset) << 9, errp);
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not truncate file");
         goto exit;
     }
 
@@ -2090,10 +2086,7 @@ static int vmdk_create(const char *filename, QemuOpts *opts, Error **errp)
     /* bdrv_pwrite write padding zeros to align to sector, we don't need that
      * for description file */
     if (desc_offset == 0) {
-        ret = blk_truncate(new_blk, desc_len);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "Could not truncate file");
-        }
+        ret = blk_truncate(new_blk, desc_len, errp);
     }
 exit:
     if (new_blk) {
diff --git a/block/vpc.c b/block/vpc.c
index f591d4be38..ecfee77149 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -851,20 +851,21 @@ static int create_dynamic_disk(BlockBackend *blk, uint8_t *buf,
 }
 
 static int create_fixed_disk(BlockBackend *blk, uint8_t *buf,
-                             int64_t total_size)
+                             int64_t total_size, Error **errp)
 {
     int ret;
 
     /* Add footer to total size */
     total_size += HEADER_SIZE;
 
-    ret = blk_truncate(blk, total_size);
+    ret = blk_truncate(blk, total_size, errp);
     if (ret < 0) {
         return ret;
     }
 
     ret = blk_pwrite(blk, total_size - HEADER_SIZE, buf, HEADER_SIZE, 0);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Unable to write VHD header");
         return ret;
     }
 
@@ -996,11 +997,11 @@ static int vpc_create(const char *filename, QemuOpts *opts, Error **errp)
 
     if (disk_type == VHD_DYNAMIC) {
         ret = create_dynamic_disk(blk, buf, total_sectors);
+        if (ret < 0) {
+            error_setg(errp, "Unable to create or write VHD header");
+        }
     } else {
-        ret = create_fixed_disk(blk, buf, total_size);
-    }
-    if (ret < 0) {
-        error_setg(errp, "Unable to create or write VHD header");
+        ret = create_fixed_disk(blk, buf, total_size, errp);
     }
 
 out:
diff --git a/blockdev.c b/blockdev.c
index 040c152512..9afd1e97c3 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2930,26 +2930,7 @@ void qmp_block_resize(bool has_device, const char *device,
     /* complete all in-flight operations before resizing the device */
     bdrv_drain_all();
 
-    ret = blk_truncate(blk, size);
-    switch (ret) {
-    case 0:
-        break;
-    case -ENOMEDIUM:
-        error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, device);
-        break;
-    case -ENOTSUP:
-        error_setg(errp, QERR_UNSUPPORTED);
-        break;
-    case -EACCES:
-        error_setg(errp, "Device '%s' is read only", device);
-        break;
-    case -EBUSY:
-        error_setg(errp, QERR_DEVICE_IN_USE, device);
-        break;
-    default:
-        error_setg_errno(errp, -ret, "Could not resize");
-        break;
-    }
+    ret = blk_truncate(blk, size, errp);
 
 out:
     blk_unref(blk);
diff --git a/qemu-img.c b/qemu-img.c
index b220cf71d7..37c2894678 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3500,20 +3500,11 @@ static int img_resize(int argc, char **argv)
         goto out;
     }
 
-    ret = blk_truncate(blk, total_size);
-    switch (ret) {
-    case 0:
+    ret = blk_truncate(blk, total_size, &err);
+    if (!ret) {
         qprintf(quiet, "Image resized.\n");
-        break;
-    case -ENOTSUP:
-        error_report("This image does not support resize");
-        break;
-    case -EACCES:
-        error_report("Image is read-only");
-        break;
-    default:
-        error_report("Error resizing image: %s", strerror(-ret));
-        break;
+    } else {
+        error_report_err(err);
     }
 out:
     blk_unref(blk);
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 2c48f9ce1a..05bb0b34ec 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1560,6 +1560,7 @@ static const cmdinfo_t flush_cmd = {
 
 static int truncate_f(BlockBackend *blk, int argc, char **argv)
 {
+    Error *local_err = NULL;
     int64_t offset;
     int ret;
 
@@ -1569,9 +1570,9 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
         return 0;
     }
 
-    ret = blk_truncate(blk, offset);
+    ret = blk_truncate(blk, offset, &local_err);
     if (ret < 0) {
-        printf("truncate: %s\n", strerror(-ret));
+        error_report_err(local_err);
         return 0;
     }
 
-- 
2.12.1
