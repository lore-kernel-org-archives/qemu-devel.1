Received: from eggs.gnu.org ([2001:4830:134:3::10]:45310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioWs-0006HP-Og
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioWr-0007wi-LX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:50 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:36:27 +0100
Message-Id: <1488314205-16264-29-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 28/46] commit: Use real permissions for HMP
 'commit'
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

This is a little simpler than the commit block job because it's
synchronous and only commits into the immediate backing file, but
otherwise doing more or less the same.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
---
 block/commit.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 8de4473..f18026b 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -401,11 +401,14 @@ fail:
 int bdrv_commit(BlockDriverState *bs)
 {
     BlockBackend *src, *backing;
+    BlockDriverState *backing_file_bs = NULL;
+    BlockDriverState *commit_top_bs = NULL;
     BlockDriver *drv = bs->drv;
     int64_t sector, total_sectors, length, backing_length;
     int n, ro, open_flags;
     int ret = 0;
     uint8_t *buf = NULL;
+    Error *local_err = NULL;
 
     if (!drv)
         return -ENOMEDIUM;
@@ -428,17 +431,31 @@ int bdrv_commit(BlockDriverState *bs)
         }
     }
 
-    /* FIXME Use real permissions */
-    src = blk_new(0, BLK_PERM_ALL);
-    backing = blk_new(0, BLK_PERM_ALL);
+    src = blk_new(BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
+    backing = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
 
-    ret = blk_insert_bs(src, bs, NULL);
+    ret = blk_insert_bs(src, bs, &local_err);
     if (ret < 0) {
+        error_report_err(local_err);
+        goto ro_cleanup;
+    }
+
+    /* Insert commit_top block node above backing, so we can write to it */
+    backing_file_bs = backing_bs(bs);
+
+    commit_top_bs = bdrv_new_open_driver(&bdrv_commit_top, NULL, BDRV_O_RDWR,
+                                         &local_err);
+    if (commit_top_bs == NULL) {
+        error_report_err(local_err);
         goto ro_cleanup;
     }
 
-    ret = blk_insert_bs(backing, bs->backing->bs, NULL);
+    bdrv_set_backing_hd(commit_top_bs, backing_file_bs);
+    bdrv_set_backing_hd(bs, commit_top_bs);
+
+    ret = blk_insert_bs(backing, backing_file_bs, &local_err);
     if (ret < 0) {
+        error_report_err(local_err);
         goto ro_cleanup;
     }
 
@@ -512,8 +529,12 @@ int bdrv_commit(BlockDriverState *bs)
 ro_cleanup:
     qemu_vfree(buf);
 
-    blk_unref(src);
     blk_unref(backing);
+    if (backing_file_bs) {
+        bdrv_set_backing_hd(bs, backing_file_bs);
+    }
+    bdrv_unref(commit_top_bs);
+    blk_unref(src);
 
     if (ro) {
         /* ignoring error return here */
-- 
1.8.3.1
