Received: from eggs.gnu.org ([2001:4830:134:3::10]:55999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbN-00027u-Kq
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbM-0001Ul-CP
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:53 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:34 +0200
Message-Id: <1493411622-5343-27-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 26/34] block: Add .bdrv_truncate() error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Add missing error messages for the block driver implementations of
.bdrv_truncate(); drop the generic one from block.c's bdrv_truncate().

Since one of these changes touches a mis-indented block in
block/file-posix.c, this patch fixes that coding style issue along the
way.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170328205129.15138-5-mreitz@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c            |  2 --
 block/file-posix.c | 17 ++++++++++++-----
 block/gluster.c    |  4 +++-
 block/iscsi.c      |  2 ++
 block/nfs.c        | 10 +++++++++-
 block/qcow2.c      |  2 ++
 block/qed.c        |  4 +++-
 block/raw-format.c |  2 ++
 block/rbd.c        |  1 +
 9 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index ff232a2..76bf00f 100644
--- a/block.c
+++ b/block.c
@@ -3334,8 +3334,6 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
         bdrv_dirty_bitmap_truncate(bs);
         bdrv_parent_cb_resize(bs);
         ++bs->write_gen;
-    } else if (errp && !*errp) {
-        error_setg_errno(errp, -ret, "Failed to resize image");
     }
     return ret;
 }
diff --git a/block/file-posix.c b/block/file-posix.c
index 9c0d701..1941fb6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1411,20 +1411,27 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     struct stat st;
+    int ret;
 
     if (fstat(s->fd, &st)) {
-        return -errno;
+        ret = -errno;
+        error_setg_errno(errp, -ret, "Failed to fstat() the file");
+        return ret;
     }
 
     if (S_ISREG(st.st_mode)) {
         if (ftruncate(s->fd, offset) < 0) {
-            return -errno;
+            ret = -errno;
+            error_setg_errno(errp, -ret, "Failed to resize the file");
+            return ret;
         }
     } else if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
-       if (offset > raw_getlength(bs)) {
-           return -EINVAL;
-       }
+        if (offset > raw_getlength(bs)) {
+            error_setg(errp, "Cannot grow device files");
+            return -EINVAL;
+        }
     } else {
+        error_setg(errp, "Resizing this file is not supported");
         return -ENOTSUP;
     }
 
diff --git a/block/gluster.c b/block/gluster.c
index be45c08..1d4e2f7 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1100,7 +1100,9 @@ static int qemu_gluster_truncate(BlockDriverState *bs, int64_t offset,
 
     ret = glfs_ftruncate(s->fd, offset);
     if (ret < 0) {
-        return -errno;
+        ret = -errno;
+        error_setg_errno(errp, -ret, "Failed to truncate file");
+        return ret;
     }
 
     return 0;
diff --git a/block/iscsi.c b/block/iscsi.c
index 1ef38cf..5daa201 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2065,6 +2065,7 @@ static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
     Error *local_err = NULL;
 
     if (iscsilun->type != TYPE_DISK) {
+        error_setg(errp, "Cannot resize non-disk iSCSI devices");
         return -ENOTSUP;
     }
 
@@ -2075,6 +2076,7 @@ static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
     }
 
     if (offset > iscsi_getlength(bs)) {
+        error_setg(errp, "Cannot grow iSCSI devices");
         return -EINVAL;
     }
 
diff --git a/block/nfs.c b/block/nfs.c
index 5ae665a..76572ae 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -767,7 +767,15 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
 static int nfs_file_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     NFSClient *client = bs->opaque;
-    return nfs_ftruncate(client->context, client->fh, offset);
+    int ret;
+
+    ret = nfs_ftruncate(client->context, client->fh, offset);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to truncate file");
+        return ret;
+    }
+
+    return 0;
 }
 
 /* Note that this will not re-establish a connection with the NFS server
diff --git a/block/qcow2.c b/block/qcow2.c
index 6c34798..4ca4cf0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2551,6 +2551,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
     new_l1_size = size_to_l1(s, offset);
     ret = qcow2_grow_l1_table(bs, new_l1_size, true);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to grow the L1 table");
         return ret;
     }
 
@@ -2559,6 +2560,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
     ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
                            &offset, sizeof(uint64_t));
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to update the image size");
         return ret;
     }
 
diff --git a/block/qed.c b/block/qed.c
index fa2aeee..fd76817 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1526,11 +1526,12 @@ static int bdrv_qed_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 
     if (!qed_is_image_size_valid(offset, s->header.cluster_size,
                                  s->header.table_size)) {
+        error_setg(errp, "Invalid image size specified");
         return -EINVAL;
     }
 
-    /* Shrinking is currently not supported */
     if ((uint64_t)offset < s->header.image_size) {
+        error_setg(errp, "Shrinking images is currently not supported");
         return -ENOTSUP;
     }
 
@@ -1539,6 +1540,7 @@ static int bdrv_qed_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
     ret = qed_write_header_sync(s);
     if (ret < 0) {
         s->header.image_size = old_image_size;
+        error_setg_errno(errp, -ret, "Failed to update the image size");
     }
     return ret;
 }
diff --git a/block/raw-format.c b/block/raw-format.c
index 9761bda..36e6503 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -332,10 +332,12 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
     BDRVRawState *s = bs->opaque;
 
     if (s->has_size) {
+        error_setg(errp, "Cannot resize fixed-size raw disks");
         return -ENOTSUP;
     }
 
     if (INT64_MAX - offset < s->offset) {
+        error_setg(errp, "Disk size too large for the chosen offset");
         return -EINVAL;
     }
 
diff --git a/block/rbd.c b/block/rbd.c
index 3e6e73e..fbf3059 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -923,6 +923,7 @@ static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 
     r = rbd_resize(s->image, offset);
     if (r < 0) {
+        error_setg_errno(errp, -r, "Failed to resize file");
         return r;
     }
 
-- 
1.8.3.1
