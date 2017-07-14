Received: from eggs.gnu.org ([2001:4830:134:3::10]:53574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1he-00042g-E8
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1hd-0003SA-FW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:36:22 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:16586)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1hd-0003RK-3a
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:36:21 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 14 Jul 2017 17:35:48 +0300
Message-Id: <20170714143548.32559-3-el13635@mail.ntua.gr>
In-Reply-To: <20170714143548.32559-1-el13635@mail.ntua.gr>
References: <20170714143548.32559-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v3 2/2] block: fix leaks in bdrv_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

bdrv_open_driver() is called in two places, bdrv_new_open_driver() and
bdrv_open_common(). In the latter, failure cleanup in is in its caller,
bdrv_open_inherit(), which unrefs the bs->file of the failed driver open
if it exists.

Let's move the bs->file cleanup to bdrv_open_driver() to take care of
all callers and do not set bs->drv to NULL unless the driver's open
function failed. When bs is destroyed by removing its last reference, it
calls bdrv_close() which checks bs->drv to perform the needed cleanups
and also call the driver's close function. Since it cleans up options
and opaque we must take care not leave dangling pointers.

The error paths in bdrv_open_driver() are now two:
If open fails, drv->bdrv_close() should not be called. Unref the child
if it exists, free what we allocated and set bs->drv to NULL. Return the
error and let callers free their stuff.

If open succeeds but we fail after, return the error and let callers
unref and delete their bs, while cleaning up their allocations.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index 96b912d229..9ff62439be 100644
--- a/block.c
+++ b/block.c
@@ -1119,20 +1119,19 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
         } else {
             error_setg_errno(errp, -ret, "Could not open image");
         }
-        goto free_and_fail;
+        goto open_failed;
     }
 
     ret = refresh_total_sectors(bs, bs->total_sectors);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not refresh total sector count");
-        goto free_and_fail;
+        return ret;
     }
 
     bdrv_refresh_limits(bs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        ret = -EINVAL;
-        goto free_and_fail;
+        return -EINVAL;
     }
 
     assert(bdrv_opt_mem_align(bs) != 0);
@@ -1140,12 +1139,14 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
     assert(is_power_of_2(bs->bl.request_alignment));
 
     return 0;
-
-free_and_fail:
-    /* FIXME Close bs first if already opened*/
-    g_free(bs->opaque);
-    bs->opaque = NULL;
+open_failed:
     bs->drv = NULL;
+    if (bs->file != NULL) {
+        bdrv_unref_child(bs, bs->file);
+        bs->file = NULL;
+    }
+    g_free(bs->opaque);
+    bs->opaque = NULL;
     return ret;
 }
 
@@ -1166,7 +1167,9 @@ BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
     ret = bdrv_open_driver(bs, drv, node_name, bs->options, flags, errp);
     if (ret < 0) {
         QDECREF(bs->explicit_options);
+        bs->explicit_options = NULL;
         QDECREF(bs->options);
+        bs->options = NULL;
         bdrv_unref(bs);
         return NULL;
     }
@@ -2600,9 +2603,6 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
 
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
