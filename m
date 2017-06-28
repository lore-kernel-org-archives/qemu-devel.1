Received: from eggs.gnu.org ([2001:4830:134:3::10]:60407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj7-0006Qb-DT
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj3-00033d-CL
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:45 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:15228 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQBj2-0002yD-Tt
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Jun 2017 15:05:29 +0300
Message-Id: <20170628120530.31251-30-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-1-vsementsov@virtuozzo.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v22 29/30] qmp: block-dirty-bitmap-remove:
 remove persistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Remove persistent bitmap from the storage on block-dirty-bitmap-remove.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 blockdev.c           | 10 ++++++++++
 qapi/block-core.json |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 3c8fb75208..122a936719 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2783,6 +2783,7 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
+    Error *local_err = NULL;
 
     bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
     if (!bitmap || !bs) {
@@ -2795,6 +2796,15 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
                    name);
         return;
     }
+
+    if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
+        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
     bdrv_dirty_bitmap_make_anon(bitmap);
     bdrv_release_dirty_bitmap(bs, bitmap);
 }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6ad8585400..e471efa1b4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1601,7 +1601,8 @@
 # @block-dirty-bitmap-remove:
 #
 # Stop write tracking and remove the dirty bitmap that was created
-# with block-dirty-bitmap-add.
+# with block-dirty-bitmap-add. If the bitmap is persistent, remove it from its
+# storage too.
 #
 # Returns: nothing on success
 #          If @node is not a valid block device or node, DeviceNotFound
-- 
2.11.1
