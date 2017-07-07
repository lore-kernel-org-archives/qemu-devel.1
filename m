Received: from eggs.gnu.org ([2001:4830:134:3::10]:43536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmZ-0006g0-AD
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmY-000164-2W
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:07 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:42 +0200
Message-Id: <1499447335-6125-88-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 087/100] qmp: add
 x-debug-block-dirty-bitmap-sha256
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20170628120530.31251-26-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/dirty-bitmap.c         |  5 +++++
 blockdev.c                   | 25 +++++++++++++++++++++++++
 include/block/dirty-bitmap.h |  1 +
 include/qemu/hbitmap.h       |  8 ++++++++
 qapi/block-core.json         | 27 +++++++++++++++++++++++++++
 tests/Makefile.include       |  2 +-
 util/hbitmap.c               | 11 +++++++++++
 7 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index d146941..5fcf917 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -725,3 +725,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
     return bitmap == NULL ? QLIST_FIRST(&bs->dirty_bitmaps) :
                             QLIST_NEXT(bitmap, list);
 }
+
+char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
+{
+    return hbitmap_sha256(bitmap->bitmap, errp);
+}
diff --git a/blockdev.c b/blockdev.c
index b7c1449..988a60d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2820,6 +2820,31 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
     bdrv_clear_dirty_bitmap(bitmap, NULL);
 }
 
+BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
+                                                              const char *name,
+                                                              Error **errp)
+{
+    BdrvDirtyBitmap *bitmap;
+    BlockDriverState *bs;
+    BlockDirtyBitmapSha256 *ret = NULL;
+    char *sha256;
+
+    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
+    if (!bitmap || !bs) {
+        return NULL;
+    }
+
+    sha256 = bdrv_dirty_bitmap_sha256(bitmap, errp);
+    if (sha256 == NULL) {
+        return NULL;
+    }
+
+    ret = g_new(BlockDirtyBitmapSha256, 1);
+    ret->sha256 = sha256;
+
+    return ret;
+}
+
 void hmp_drive_del(Monitor *mon, const QDict *qdict)
 {
     const char *id = qdict_get_str(qdict, "id");
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index c8b3110..8e98aef 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -97,5 +97,6 @@ bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
+char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
 
 #endif
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index b52304a..d3a74a2 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -253,6 +253,14 @@ void hbitmap_deserialize_ones(HBitmap *hb, uint64_t start, uint64_t count,
 void hbitmap_deserialize_finish(HBitmap *hb);
 
 /**
+ * hbitmap_sha256:
+ * @bitmap: HBitmap to operate on.
+ *
+ * Returns SHA256 hash of the last level.
+ */
+char *hbitmap_sha256(const HBitmap *bitmap, Error **errp);
+
+/**
  * hbitmap_free:
  * @hb: HBitmap to operate on.
  *
diff --git a/qapi/block-core.json b/qapi/block-core.json
index fb69efe..9b5047d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1636,6 +1636,33 @@
   'data': 'BlockDirtyBitmap' }
 
 ##
+# @BlockDirtyBitmapSha256:
+#
+# SHA256 hash of dirty bitmap data
+#
+# @sha256: ASCII representation of SHA256 bitmap hash
+#
+# Since: 2.10
+##
+  { 'struct': 'BlockDirtyBitmapSha256',
+    'data': {'sha256': 'str'} }
+
+##
+# @x-debug-block-dirty-bitmap-sha256:
+#
+# Get bitmap SHA256
+#
+# Returns: BlockDirtyBitmapSha256 on success
+#          If @node is not a valid block device, DeviceNotFound
+#          If @name is not found or if hashing has failed, GenericError with an
+#          explanation
+#
+# Since: 2.10
+##
+  { 'command': 'x-debug-block-dirty-bitmap-sha256',
+    'data': 'BlockDirtyBitmap', 'returns': 'BlockDirtyBitmapSha256' }
+
+##
 # @blockdev-mirror:
 #
 # Start mirroring a block device's writes to a new destination.
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 18cd06a..42e17e2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -554,7 +554,7 @@ tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(test-u
 tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
 tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
-tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y)
+tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
 tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
 tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
 tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 0c1591a..21535cc 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -13,6 +13,7 @@
 #include "qemu/hbitmap.h"
 #include "qemu/host-utils.h"
 #include "trace.h"
+#include "crypto/hash.h"
 
 /* HBitmaps provides an array of bits.  The bits are stored as usual in an
  * array of unsigned longs, but HBitmap is also optimized to provide fast
@@ -727,3 +728,13 @@ void hbitmap_free_meta(HBitmap *hb)
     hbitmap_free(hb->meta);
     hb->meta = NULL;
 }
+
+char *hbitmap_sha256(const HBitmap *bitmap, Error **errp)
+{
+    size_t size = bitmap->sizes[HBITMAP_LEVELS - 1] * sizeof(unsigned long);
+    char *data = (char *)bitmap->levels[HBITMAP_LEVELS - 1];
+    char *hash = NULL;
+    qcrypto_hash_digest(QCRYPTO_HASH_ALG_SHA256, data, size, &hash, errp);
+
+    return hash;
+}
-- 
1.8.3.1
