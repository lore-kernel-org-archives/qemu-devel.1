Received: from eggs.gnu.org ([2001:4830:134:3::10]:52289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1i-0002w8-Dd
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1h-0005KC-Es
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:47 +0100
Message-Id: <20180213170529.10858-14-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/55] sheepdog: Make sd_prealloc() take a BDS
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

We want to use this function in sd_truncate() later on, so taking a
filename is not exactly ideal.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/sheepdog.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index af125a2c8d..cc1d37b3da 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1826,10 +1826,10 @@ static int do_sd_create(BDRVSheepdogState *s, uint32_t *vdi_id, int snapshot,
     return 0;
 }
 
-static int sd_prealloc(const char *filename, Error **errp)
+static int sd_prealloc(BlockDriverState *bs, Error **errp)
 {
     BlockBackend *blk = NULL;
-    BDRVSheepdogState *base = NULL;
+    BDRVSheepdogState *base = bs->opaque;
     unsigned long buf_size;
     uint32_t idx, max_idx;
     uint32_t object_size;
@@ -1837,10 +1837,11 @@ static int sd_prealloc(const char *filename, Error **errp)
     void *buf = NULL;
     int ret;
 
-    blk = blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
-    if (blk == NULL) {
-        ret = -EIO;
+    blk = blk_new(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE | BLK_PERM_RESIZE,
+                  BLK_PERM_ALL);
+
+    ret = blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
         goto out_with_err_set;
     }
 
@@ -1852,7 +1853,6 @@ static int sd_prealloc(const char *filename, Error **errp)
         goto out;
     }
 
-    base = blk_bs(blk)->opaque;
     object_size = (UINT32_C(1) << base->inode.block_size_shift);
     buf_size = MIN(object_size, SD_DATA_OBJ_SIZE);
     buf = g_malloc0(buf_size);
@@ -2108,7 +2108,20 @@ static int sd_create(const char *filename, QemuOpts *opts,
     }
 
     if (prealloc) {
-        ret = sd_prealloc(filename, errp);
+        BlockDriverState *bs;
+        QDict *opts;
+
+        opts = qdict_new();
+        qdict_put_str(opts, "driver", "sheepdog");
+        bs = bdrv_open(filename, NULL, opts, BDRV_O_PROTOCOL | BDRV_O_RDWR,
+                       errp);
+        if (!bs) {
+            goto out;
+        }
+
+        ret = sd_prealloc(bs, errp);
+
+        bdrv_unref(bs);
     }
 out:
     g_free(backing_file);
-- 
2.13.6
