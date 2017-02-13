Received: from eggs.gnu.org ([2001:4830:134:3::10]:59675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMI-0003hD-N1
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMH-0006J5-AY
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:14 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:51 +0100
Message-Id: <1487006583-24350-30-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 29/41] commit: Use real permissions for HMP
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
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is a little simpler than the commit block job because it's
synchronous and only commits into the immediate backing file, but
otherwise doing more or less the same.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 49ffddb..581d161 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -396,11 +396,14 @@ fail:
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
@@ -423,17 +426,31 @@ int bdrv_commit(BlockDriverState *bs)
         }
     }
 
-    /* FIXME Use real permissions */
-    src = blk_new(0, BLK_PERM_ALL);
-    backing = blk_new(0, BLK_PERM_ALL);
+    src = blk_new(BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
+    backing = blk_new(BLK_PERM_WRITE, BLK_PERM_ALL);
+
+    ret = blk_insert_bs(src, bs, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        goto ro_cleanup;
+    }
+
+    /* Insert commit_top block node above backing, so we can write to it */
+    backing_file_bs = backing_bs(bs);
 
-    ret = blk_insert_bs(src, bs, NULL);
+    ret = bdrv_new_open_driver(&bdrv_commit_top, &commit_top_bs, NULL,
+                               BDRV_O_RDWR, &local_err);
     if (ret < 0) {
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
 
@@ -507,6 +524,10 @@ int bdrv_commit(BlockDriverState *bs)
 ro_cleanup:
     qemu_vfree(buf);
 
+    if (backing_file_bs) {
+        bdrv_set_backing_hd(bs, backing_file_bs);
+    }
+    bdrv_unref(commit_top_bs);
     blk_unref(src);
     blk_unref(backing);
 
-- 
1.8.3.1
