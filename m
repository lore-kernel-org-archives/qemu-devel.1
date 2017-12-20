Received: from eggs.gnu.org ([2001:4830:134:3::10]:55743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReI3-0004by-E5
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReHx-0006JX-Py
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:07 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 14:19:32 +0100
Message-Id: <20171220131939.27543-8-kwolf@redhat.com>
In-Reply-To: <20171220131939.27543-1-kwolf@redhat.com>
References: <20171220131939.27543-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/14] block: bdrv_drain_recurse(): Remove
 unused begin parameter
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

Now that the bdrv_drain_invoke() calls are pulled up to the callers of
bdrv_drain_recurse(), the 'begin' parameter isn't needed any more.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index 603f5b059e..390d463c71 100644
--- a/block/io.c
+++ b/block/io.c
@@ -195,7 +195,7 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
     }
 }
 
-static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
+static bool bdrv_drain_recurse(BlockDriverState *bs)
 {
     BdrvChild *child, *tmp;
     bool waited;
@@ -218,7 +218,7 @@ static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
              */
             bdrv_ref(bs);
         }
-        waited |= bdrv_drain_recurse(bs, begin);
+        waited |= bdrv_drain_recurse(bs);
         if (in_main_loop) {
             bdrv_unref(bs);
         }
@@ -283,7 +283,7 @@ void bdrv_drained_begin(BlockDriverState *bs)
     }
 
     bdrv_drain_invoke(bs, true);
-    bdrv_drain_recurse(bs, true);
+    bdrv_drain_recurse(bs);
 }
 
 void bdrv_drained_end(BlockDriverState *bs)
@@ -299,7 +299,7 @@ void bdrv_drained_end(BlockDriverState *bs)
 
     bdrv_parent_drained_end(bs);
     bdrv_drain_invoke(bs, false);
-    bdrv_drain_recurse(bs, false);
+    bdrv_drain_recurse(bs);
     aio_enable_external(bdrv_get_aio_context(bs));
 }
 
@@ -378,7 +378,7 @@ void bdrv_drain_all_begin(void)
             aio_context_acquire(aio_context);
             for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
                 if (aio_context == bdrv_get_aio_context(bs)) {
-                    waited |= bdrv_drain_recurse(bs, true);
+                    waited |= bdrv_drain_recurse(bs);
                 }
             }
             aio_context_release(aio_context);
@@ -400,7 +400,7 @@ void bdrv_drain_all_end(void)
         aio_enable_external(aio_context);
         bdrv_parent_drained_end(bs);
         bdrv_drain_invoke(bs, false);
-        bdrv_drain_recurse(bs, false);
+        bdrv_drain_recurse(bs);
         aio_context_release(aio_context);
     }
 
-- 
2.13.6
