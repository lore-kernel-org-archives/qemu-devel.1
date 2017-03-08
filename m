Received: from eggs.gnu.org ([2001:4830:134:3::10]:48701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clh42-0003yN-Sz
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clh41-0008KS-9c
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 14:15:58 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  8 Mar 2017 20:15:44 +0100
Message-Id: <20170308191544.3025-2-mreitz@redhat.com>
In-Reply-To: <20170308191434.2413-1-mreitz@redhat.com>
References: <20170308191434.2413-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 4/4] block: Add some
 bdrv_truncate() error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Add missing error messages for the drivers I am comfortable to do this
in.

Since one of these changes touches a mis-indented block in
block/file-posix.c, this patch fixes that coding style issue along the
way.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 17 ++++++++++++-----
 block/qcow2.c      |  2 ++
 block/qed.c        |  4 +++-
 block/raw-format.c |  2 ++
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9d2bea730d..013aa07437 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1341,20 +1341,27 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
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
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 17585fbb89..53b0bd61a7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2550,6 +2550,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
     new_l1_size = size_to_l1(s, offset);
     ret = qcow2_grow_l1_table(bs, new_l1_size, true);
     if (ret < 0) {
+        error_setg(errp, "Failed to grow the L1 table");
         return ret;
     }
 
@@ -2558,6 +2559,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
     ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
                            &offset, sizeof(uint64_t));
     if (ret < 0) {
+        error_setg(errp, "Failed to update the image size");
         return ret;
     }
 
diff --git a/block/qed.c b/block/qed.c
index fa2aeee471..eb346d645b 100644
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
+        error_setg(errp, "Failed to update the image size");
     }
     return ret;
 }
diff --git a/block/raw-format.c b/block/raw-format.c
index 9761bdaff8..36e65036f0 100644
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
 
-- 
2.12.0
