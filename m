Received: from eggs.gnu.org ([2001:4830:134:3::10]:36371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSU-0002HS-BK
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSO-0005Cr-9V
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:50 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:43692 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVdSN-00059G-NO
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 23 Jan 2017 15:10:30 +0300
Message-Id: <20170123121036.4823-19-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-1-vsementsov@virtuozzo.com>
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 18/24] qmp: add
 x-debug-block-dirty-bitmap-sha256
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c         |  5 +++++
 blockdev.c                   | 29 +++++++++++++++++++++++++++++
 include/block/dirty-bitmap.h |  2 ++
 include/qemu/hbitmap.h       |  8 ++++++++
 qapi/block-core.json         | 27 +++++++++++++++++++++++++++
 tests/Makefile.include       |  2 +-
 util/hbitmap.c               | 11 +++++++++++
 7 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index fe34d488aa..775181c9ab 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -589,3 +589,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
     return bitmap == NULL ? QLIST_FIRST(&bs->dirty_bitmaps) :
                             QLIST_NEXT(bitmap, list);
 }
+
+char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
+{
+    return hbitmap_sha256(bitmap->bitmap, errp);
+}
diff --git a/blockdev.c b/blockdev.c
index e32ac69e4b..c41b791289 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2820,6 +2820,35 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
     aio_context_release(aio_context);
 }
 
+BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
+                                                              const char *name,
+                                                              Error **errp)
+{
+    AioContext *aio_context;
+    BdrvDirtyBitmap *bitmap;
+    BlockDriverState *bs;
+    BlockDirtyBitmapSha256 *ret = NULL;
+    char *sha256;
+
+    bitmap = block_dirty_bitmap_lookup(node, name, &bs, &aio_context, errp);
+    if (!bitmap || !bs) {
+        return NULL;
+    }
+
+    sha256 = bdrv_dirty_bitmap_sha256(bitmap, errp);
+    if (sha256 == NULL) {
+        goto out;
+    }
+
+    ret = g_new(BlockDirtyBitmapSha256, 1);
+    ret->sha256 = sha256;
+
+out:
+    aio_context_release(aio_context);
+
+    return ret;
+}
+
 void hmp_drive_del(Monitor *mon, const QDict *qdict)
 {
     const char *id = qdict_get_str(qdict, "id");
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index d71edc4d13..b022b34964 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -86,4 +86,6 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
 
 bool bdrv_has_persistent_bitmaps(BlockDriverState *bs);
 
+char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
+
 #endif
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 063ec0e7ad..750346ce40 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -240,6 +240,14 @@ void hbitmap_deserialize_ones(HBitmap *hb, uint64_t start, uint64_t count,
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
index 2c0aa1f44d..956b69567d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1289,6 +1289,33 @@
   'data': 'BlockDirtyBitmap' }
 
 ##
+# @BlockDirtyBitmapSha256:
+#
+# SHA256 hash of dirty bitmap data
+#
+# @sha256: ASCII representation of SHA256 bitmap hash
+#
+# Since: 2.9
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
+#          If @name is not found or if hashing is failed, GenericError with an
+#          explanation
+#
+# Since: 2.9
+##
+  { 'command': 'x-debug-block-dirty-bitmap-sha256',
+    'data': 'BlockDirtyBitmap', 'returns': 'BlockDirtyBitmapSha256' }
+
+##
 # @blockdev-mirror:
 #
 # Start mirroring a block device's writes to a new destination.
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e98d3b6bb3..b85ff7899d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -496,7 +496,7 @@ tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(test-u
 tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
 tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
-tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y)
+tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
 tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
 tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o page_cache.o $(test-util-obj-y)
 tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 47418a915e..2dc09b811a 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -13,6 +13,7 @@
 #include "qemu/hbitmap.h"
 #include "qemu/host-utils.h"
 #include "trace.h"
+#include "crypto/hash.h"
 
 /* HBitmaps provides an array of bits.  The bits are stored as usual in an
  * array of unsigned longs, but HBitmap is also optimized to provide fast
@@ -711,3 +712,13 @@ void hbitmap_free_meta(HBitmap *hb)
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
2.11.0
