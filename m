Received: from eggs.gnu.org ([2001:4830:134:3::10]:43707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXi5-0007RA-31
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXi3-0001pC-1h
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:40:57 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Mar 2017 22:40:32 +0100
Message-Id: <20170313214045.26857-1-mreitz@redhat.com>
In-Reply-To: <20170313214001.26339-1-mreitz@redhat.com>
References: <20170313214001.26339-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 03/16] block: Add PreallocMode to
 blk_truncate()
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

blk_truncate() itself will pass that value to bdrv_truncate(), and all
callers of blk_truncate() just set the parameter to PREALLOC_MODE_OFF
for now.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/sysemu/block-backend.h | 3 ++-
 block/block-backend.c          | 5 +++--
 block/commit.c                 | 4 ++--
 block/mirror.c                 | 3 ++-
 block/parallels.c              | 2 +-
 block/qcow.c                   | 2 +-
 block/qcow2.c                  | 4 ++--
 block/qed.c                    | 2 +-
 block/vdi.c                    | 3 ++-
 block/vhdx.c                   | 5 +++--
 block/vmdk.c                   | 7 ++++---
 block/vpc.c                    | 2 +-
 blockdev.c                     | 2 +-
 qemu-img.c                     | 2 +-
 qemu-io-cmds.c                 | 2 +-
 15 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 5796d1d634..9bdb216127 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -217,7 +217,8 @@ int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                                       int count, BdrvRequestFlags flags);
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
                           int count);
-int blk_truncate(BlockBackend *blk, int64_t offset, Error **errp);
+int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode prealloc,
+                 Error **errp);
 int blk_pdiscard(BlockBackend *blk, int64_t offset, int count);
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size);
diff --git a/block/block-backend.c b/block/block-backend.c
index 1bebc7f1ba..ab0b649b6a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1698,14 +1698,15 @@ int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
                    BDRV_REQ_WRITE_COMPRESSED);
 }
 
-int blk_truncate(BlockBackend *blk, int64_t offset, Error **errp)
+int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode prealloc,
+                 Error **errp)
 {
     if (!blk_is_available(blk)) {
         error_setg(errp, "No medium inserted");
         return -ENOMEDIUM;
     }
 
-    return bdrv_truncate(blk->root, offset, PREALLOC_MODE_OFF, errp);
+    return bdrv_truncate(blk->root, offset, prealloc, errp);
 }
 
 static void blk_pdiscard_entry(void *opaque)
diff --git a/block/commit.c b/block/commit.c
index bfdd1b4142..9a32338b82 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -151,7 +151,7 @@ static void coroutine_fn commit_run(void *opaque)
     }
 
     if (base_len < s->common.len) {
-        ret = blk_truncate(s->base, s->common.len, NULL);
+        ret = blk_truncate(s->base, s->common.len, PREALLOC_MODE_OFF, NULL);
         if (ret) {
             goto out;
         }
@@ -508,7 +508,7 @@ int bdrv_commit(BlockDriverState *bs)
      * grow the backing file image if possible.  If not possible,
      * we must return an error */
     if (length > backing_length) {
-        ret = blk_truncate(backing, length, &local_err);
+        ret = blk_truncate(backing, length, PREALLOC_MODE_OFF, &local_err);
         if (ret < 0) {
             error_report_err(local_err);
             goto ro_cleanup;
diff --git a/block/mirror.c b/block/mirror.c
index a520007800..cd187eaddb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -722,7 +722,8 @@ static void coroutine_fn mirror_run(void *opaque)
         }
 
         if (s->bdev_length > base_length) {
-            ret = blk_truncate(s->target, s->bdev_length, NULL);
+            ret = blk_truncate(s->target, s->bdev_length, PREALLOC_MODE_OFF,
+                               NULL);
             if (ret < 0) {
                 goto immediate_exit;
             }
diff --git a/block/parallels.c b/block/parallels.c
index 180111f71e..e4c3f877f6 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -501,7 +501,7 @@ static int parallels_create(const char *filename, QemuOpts *opts, Error **errp)
 
     blk_set_allow_write_beyond_eof(file, true);
 
-    ret = blk_truncate(file, 0, errp);
+    ret = blk_truncate(file, 0, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto exit;
     }
diff --git a/block/qcow.c b/block/qcow.c
index 45e3ff1a89..20d160a9ac 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -834,7 +834,7 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
 
     blk_set_allow_write_beyond_eof(qcow_blk, true);
 
-    ret = blk_truncate(qcow_blk, 0, errp);
+    ret = blk_truncate(qcow_blk, 0, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto exit;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 52b9ad75fe..210646b60f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2294,7 +2294,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     }
 
     /* Okay, now that we have a valid image, let's give it the right size */
-    ret = blk_truncate(blk, total_size, errp);
+    ret = blk_truncate(blk, total_size, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto out;
     }
@@ -3284,7 +3284,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
             return ret;
         }
 
-        ret = blk_truncate(blk, new_size, &local_err);
+        ret = blk_truncate(blk, new_size, PREALLOC_MODE_OFF, &local_err);
         blk_unref(blk);
         if (ret < 0) {
             error_report_err(local_err);
diff --git a/block/qed.c b/block/qed.c
index b5102f5d7f..7490ecf026 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -635,7 +635,7 @@ static int qed_create(const char *filename, uint32_t cluster_size,
     blk_set_allow_write_beyond_eof(blk, true);
 
     /* File must start empty and grow, check truncate is supported */
-    ret = blk_truncate(blk, 0, errp);
+    ret = blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto out;
     }
diff --git a/block/vdi.c b/block/vdi.c
index d12d9cdc79..2434a9cd8d 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -832,7 +832,8 @@ static int vdi_create(const char *filename, QemuOpts *opts, Error **errp)
     }
 
     if (image_type == VDI_TYPE_STATIC) {
-        ret = blk_truncate(blk, offset + blocks * block_size, errp);
+        ret = blk_truncate(blk, offset + blocks * block_size,
+                           PREALLOC_MODE_OFF, errp);
         if (ret < 0) {
             error_prepend(errp, "Failed to statically allocate %s", filename);
             goto exit;
diff --git a/block/vhdx.c b/block/vhdx.c
index 967c93e996..96933ed2f0 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1608,12 +1608,13 @@ static int vhdx_create_bat(BlockBackend *blk, BDRVVHDXState *s,
     if (type == VHDX_TYPE_DYNAMIC) {
         /* All zeroes, so we can just extend the file - the end of the BAT
          * is the furthest thing we have written yet */
-        ret = blk_truncate(blk, data_file_offset, errp);
+        ret = blk_truncate(blk, data_file_offset, PREALLOC_MODE_OFF, errp);
         if (ret < 0) {
             goto exit;
         }
     } else if (type == VHDX_TYPE_FIXED) {
-        ret = blk_truncate(blk, data_file_offset + image_size, errp);
+        ret = blk_truncate(blk, data_file_offset + image_size,
+                           PREALLOC_MODE_OFF, errp);
         if (ret < 0) {
             goto exit;
         }
diff --git a/block/vmdk.c b/block/vmdk.c
index c61b9cc8e0..7decd3ed44 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1714,7 +1714,7 @@ static int vmdk_create_extent(const char *filename, int64_t filesize,
     blk_set_allow_write_beyond_eof(blk, true);
 
     if (flat) {
-        ret = blk_truncate(blk, filesize, errp);
+        ret = blk_truncate(blk, filesize, PREALLOC_MODE_OFF, errp);
         goto exit;
     }
     magic = cpu_to_be32(VMDK4_MAGIC);
@@ -1777,7 +1777,8 @@ static int vmdk_create_extent(const char *filename, int64_t filesize,
         goto exit;
     }
 
-    ret = blk_truncate(blk, le64_to_cpu(header.grain_offset) << 9, errp);
+    ret = blk_truncate(blk, le64_to_cpu(header.grain_offset) << 9,
+                       PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto exit;
     }
@@ -2086,7 +2087,7 @@ static int vmdk_create(const char *filename, QemuOpts *opts, Error **errp)
     /* bdrv_pwrite write padding zeros to align to sector, we don't need that
      * for description file */
     if (desc_offset == 0) {
-        ret = blk_truncate(new_blk, desc_len, errp);
+        ret = blk_truncate(new_blk, desc_len, PREALLOC_MODE_OFF, errp);
     }
 exit:
     if (new_blk) {
diff --git a/block/vpc.c b/block/vpc.c
index ecfee77149..de71398eb4 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -858,7 +858,7 @@ static int create_fixed_disk(BlockBackend *blk, uint8_t *buf,
     /* Add footer to total size */
     total_size += HEADER_SIZE;
 
-    ret = blk_truncate(blk, total_size, errp);
+    ret = blk_truncate(blk, total_size, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         return ret;
     }
diff --git a/blockdev.c b/blockdev.c
index de50d461d2..77f14f6a10 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2928,7 +2928,7 @@ void qmp_block_resize(bool has_device, const char *device,
     /* complete all in-flight operations before resizing the device */
     bdrv_drain_all();
 
-    ret = blk_truncate(blk, size, errp);
+    ret = blk_truncate(blk, size, PREALLOC_MODE_OFF, errp);
 
 out:
     blk_unref(blk);
diff --git a/qemu-img.c b/qemu-img.c
index 0b0178949d..3e637a932b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3440,7 +3440,7 @@ static int img_resize(int argc, char **argv)
         goto out;
     }
 
-    ret = blk_truncate(blk, total_size, &err);
+    ret = blk_truncate(blk, total_size, PREALLOC_MODE_OFF, &err);
     if (!ret) {
         qprintf(quiet, "Image resized.\n");
     } else {
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 05bb0b34ec..b5d9b293b0 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1570,7 +1570,7 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
         return 0;
     }
 
-    ret = blk_truncate(blk, offset, &local_err);
+    ret = blk_truncate(blk, offset, PREALLOC_MODE_OFF, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         return 0;
-- 
2.12.0
