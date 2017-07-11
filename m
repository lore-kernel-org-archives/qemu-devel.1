Received: from eggs.gnu.org ([2001:4830:134:3::10]:47006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmI-00026V-Ij
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmH-0007Fv-1I
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:46 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:08:01 +0200
Message-Id: <20170711160814.20941-73-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 72/85] block: Add PreallocMode to blk_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

blk_truncate() itself will pass that value to bdrv_truncate(), and all
callers of blk_truncate() just set the parameter to PREALLOC_MODE_OFF
for now.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170613202107.10125-4-mreitz@redhat.com
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
index 1e05281..d9ea0cd 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -223,7 +223,8 @@ int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                                       int bytes, BdrvRequestFlags flags);
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
                           int bytes);
-int blk_truncate(BlockBackend *blk, int64_t offset, Error **errp);
+int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode prealloc,
+                 Error **errp);
 int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size);
diff --git a/block/block-backend.c b/block/block-backend.c
index 3c1b756..fe3542b 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1773,14 +1773,15 @@ int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
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
index 774a8a5..1314360 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -163,7 +163,7 @@ static void coroutine_fn commit_run(void *opaque)
     }
 
     if (base_len < s->common.len) {
-        ret = blk_truncate(s->base, s->common.len, NULL);
+        ret = blk_truncate(s->base, s->common.len, PREALLOC_MODE_OFF, NULL);
         if (ret) {
             goto out;
         }
@@ -521,7 +521,7 @@ int bdrv_commit(BlockDriverState *bs)
      * grow the backing file image if possible.  If not possible,
      * we must return an error */
     if (length > backing_length) {
-        ret = blk_truncate(backing, length, &local_err);
+        ret = blk_truncate(backing, length, PREALLOC_MODE_OFF, &local_err);
         if (ret < 0) {
             error_report_err(local_err);
             goto ro_cleanup;
diff --git a/block/mirror.c b/block/mirror.c
index eaf0fe7..8583b76 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -739,7 +739,8 @@ static void coroutine_fn mirror_run(void *opaque)
         }
 
         if (s->bdev_length > base_length) {
-            ret = blk_truncate(s->target, s->bdev_length, NULL);
+            ret = blk_truncate(s->target, s->bdev_length, PREALLOC_MODE_OFF,
+                               NULL);
             if (ret < 0) {
                 goto immediate_exit;
             }
diff --git a/block/parallels.c b/block/parallels.c
index 5a38998..5bbdfab 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -508,7 +508,7 @@ static int parallels_create(const char *filename, QemuOpts *opts, Error **errp)
 
     blk_set_allow_write_beyond_eof(file, true);
 
-    ret = blk_truncate(file, 0, errp);
+    ret = blk_truncate(file, 0, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto exit;
     }
diff --git a/block/qcow.c b/block/qcow.c
index 10c96b8..66827d6 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -813,7 +813,7 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
 
     blk_set_allow_write_beyond_eof(qcow_blk, true);
 
-    ret = blk_truncate(qcow_blk, 0, errp);
+    ret = blk_truncate(qcow_blk, 0, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto exit;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 7391b49..0f44780 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2802,7 +2802,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     }
 
     /* Okay, now that we have a valid image, let's give it the right size */
-    ret = blk_truncate(blk, total_size, errp);
+    ret = blk_truncate(blk, total_size, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         error_prepend(errp, "Could not resize image: ");
         goto out;
@@ -3995,7 +3995,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
             return ret;
         }
 
-        ret = blk_truncate(blk, new_size, &local_err);
+        ret = blk_truncate(blk, new_size, PREALLOC_MODE_OFF, &local_err);
         blk_unref(blk);
         if (ret < 0) {
             error_report_err(local_err);
diff --git a/block/qed.c b/block/qed.c
index 8f7e45c..86cad21 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -583,7 +583,7 @@ static int qed_create(const char *filename, uint32_t cluster_size,
     blk_set_allow_write_beyond_eof(blk, true);
 
     /* File must start empty and grow, check truncate is supported */
-    ret = blk_truncate(blk, 0, errp);
+    ret = blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto out;
     }
diff --git a/block/vdi.c b/block/vdi.c
index 79af477..2b6e8fa 100644
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
index 85c476a..a9cecd2 100644
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
index 55581b0..24d71b5 100644
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
index b313c68..9a6f817 100644
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
index 124c230..9c6dd27 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2958,7 +2958,7 @@ void qmp_block_resize(bool has_device, const char *device,
     }
 
     bdrv_drained_begin(bs);
-    ret = blk_truncate(blk, size, errp);
+    ret = blk_truncate(blk, size, PREALLOC_MODE_OFF, errp);
     bdrv_drained_end(bs);
 
 out:
diff --git a/qemu-img.c b/qemu-img.c
index 930ae88..1b74195 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3537,7 +3537,7 @@ static int img_resize(int argc, char **argv)
         goto out;
     }
 
-    ret = blk_truncate(blk, total_size, &err);
+    ret = blk_truncate(blk, total_size, PREALLOC_MODE_OFF, &err);
     if (!ret) {
         qprintf(quiet, "Image resized.\n");
     } else {
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index f4fdf2d..3eb42c6 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1577,7 +1577,7 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
         return 0;
     }
 
-    ret = blk_truncate(blk, offset, &local_err);
+    ret = blk_truncate(blk, offset, PREALLOC_MODE_OFF, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         return 0;
-- 
2.9.4
