Received: from eggs.gnu.org ([2001:4830:134:3::10]:42949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dRKUy-0004tD-HQ
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dRKUv-0003Zr-Fv
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:39:52 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:61670)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dRKUv-00039L-3e
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:39:49 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Sat,  1 Jul 2017 18:39:06 +0300
Message-Id: <20170701153906.16588-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v2] block: fix leaks in bdrv_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>

bdrv_open_driver() is called in two places, bdrv_new_open_driver() and
bdrv_open_common(). In the latter, failure cleanup in is in its caller,
bdrv_open_inherit(), which unrefs the bs->file of the failed driver open if it
exists.

Let's move the bs->file cleanup to bdrv_open_driver() to take care of all
callers and do not set bs->drv to NULL unless the driver's open function
failed. When bs is destroyed by removing its last reference, bdrv_close()
checks bs->drv to perform the needed cleanups and also call the driver's close
function.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---

v2:
 move bdrv_unref_child(bs, bs->file) to bdrv_open_driver
 do not set bs->drv to NULL if open succeeds 

 block.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 694396281b..df2a46990c 100644
--- a/block.c
+++ b/block.c
@@ -1091,6 +1091,7 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
 {
     Error *local_err = NULL;
     int ret;
+    bool open_failed;
 
     bdrv_assign_node_name(bs, node_name, &local_err);
     if (local_err) {
@@ -1111,7 +1112,9 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
         ret = 0;
     }
 
-    if (ret < 0) {
+    open_failed = ret < 0;
+
+    if (open_failed) {
         if (local_err) {
             error_propagate(errp, local_err);
         } else if (bs->filename[0]) {
@@ -1142,10 +1145,15 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
     return 0;
 
 free_and_fail:
-    /* FIXME Close bs first if already opened*/
-    g_free(bs->opaque);
-    bs->opaque = NULL;
-    bs->drv = NULL;
+    if (open_failed) {
+        g_free(bs->opaque);
+        bs->opaque = NULL;
+        bs->drv = NULL;
+    }
+    if (bs->file != NULL) {
+        bdrv_unref_child(bs, bs->file);
+        bs->file = NULL;
+    }
     return ret;
 }
 
@@ -2607,9 +2615,6 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
 
 fail:
     blk_unref(file);
-    if (bs->file != NULL) {
-        bdrv_unref_child(bs, bs->file);
-    }
     QDECREF(snapshot_options);
     QDECREF(bs->explicit_options);
     QDECREF(bs->options);
-- 
2.11.0
