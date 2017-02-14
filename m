Received: from eggs.gnu.org ([2001:4830:134:3::10]:54958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdgSJ-0005Xh-PC
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdgSD-0003zW-76
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:59:55 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:15365 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cdgSC-0003vJ-K1
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:59:49 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 14 Feb 2017 19:59:32 +0300
Message-Id: <1487091579-67092-19-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 18/25] qmp: add
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
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
index 9208844..b684d8b 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -588,3 +588,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
     return bitmap == NULL ? QLIST_FIRST(&bs->dirty_bitmaps) :
                             QLIST_NEXT(bitmap, list);
 }
+
+char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
+{
+    return hbitmap_sha256(bitmap->bitmap, errp);
+}
diff --git a/blockdev.c b/blockdev.c
index e32ac69..c41b791 100644
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
index d71edc4..b022b34 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -86,4 +86,6 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
 
 bool bdrv_has_persistent_bitmaps(BlockDriverState *bs);
 
+char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
+
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
index 09dcf4e..d6f1734 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1642,6 +1642,33 @@
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
+#          If @name is not found or if hashing has failed, GenericError with an
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
index ad35a64..d0809fe 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -519,7 +519,7 @@ tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) $(test-u
 tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-obj-y) $(test-util-obj-y)
 tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
 tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
-tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y)
+tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
 tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
 tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o page_cache.o $(test-util-obj-y)
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
