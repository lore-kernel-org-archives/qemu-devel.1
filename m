Received: from eggs.gnu.org ([2001:4830:134:3::10]:44781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dIHK6-00083n-7Z
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dIHK3-0002QH-8d
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:27:14 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:21370 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dIHK2-0002Ps-TK
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:27:11 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  6 Jun 2017 19:26:50 +0300
Message-Id: <20170606162652.112122-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170606162652.112122-1-vsementsov@virtuozzo.com>
References: <20170606162652.112122-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 1/3] block: add bdrv_get_format_alloc_stat
 format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

The function should collect statistics, about used/unused by top-level
format driver space (in its .file) and allocation status
(data/zero/discarded/after-eof) of corresponding areas in this .file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c                   | 16 ++++++++++++++
 include/block/block.h     |  3 +++
 include/block/block_int.h |  2 ++
 qapi/block-core.json      | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/block.c b/block.c
index 50ba264143..7d720ae0c2 100644
--- a/block.c
+++ b/block.c
@@ -3407,6 +3407,22 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
 }
 
 /**
+ * Collect format allocation info. See BlockFormatAllocInfo definition in
+ * qapi/block-core.json.
+ */
+int bdrv_get_format_alloc_stat(BlockDriverState *bs, BlockFormatAllocInfo *bfai)
+{
+    BlockDriver *drv = bs->drv;
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+    if (drv->bdrv_get_format_alloc_stat) {
+        return drv->bdrv_get_format_alloc_stat(bs, bfai);
+    }
+    return -ENOTSUP;
+}
+
+/**
  * Return number of sectors on success, -errno on error.
  */
 int64_t bdrv_nb_sectors(BlockDriverState *bs)
diff --git a/include/block/block.h b/include/block/block.h
index 9b355e92d8..646376a772 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -335,6 +335,9 @@ typedef enum {
 
 int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix);
 
+int bdrv_get_format_alloc_stat(BlockDriverState *bs,
+                               BlockFormatAllocInfo *bfai);
+
 /* The units of offset and total_work_size may be chosen arbitrarily by the
  * block driver; total_work_size may change during the course of the amendment
  * operation */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8d3724cce6..458c715e99 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -208,6 +208,8 @@ struct BlockDriver {
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
     int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
+    int (*bdrv_get_format_alloc_stat)(BlockDriverState *bs,
+                                      BlockFormatAllocInfo *bfai);
 
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ea0b3e8b13..fd7b52bd69 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -139,6 +139,61 @@
            '*format-specific': 'ImageInfoSpecific' } }
 
 ##
+# @BlockFormatAllocInfo:
+#
+#
+# Allocation relations between format file and underlying protocol file.
+# All fields are in bytes.
+#
+# There are two types of the format file portions: 'used' and 'unused'. It's up
+# to the format how to interpret these types. For now the only format supporting
+# the feature is Qcow2 and for this case 'used' are clusters with positive
+# refcount and unused a clusters with zero refcount. Described portions include
+# all format file allocations, not only virtual disk data (metadata, internal
+# snapshots, etc. are included).
+#
+# For the underlying file there are native block-status types of the portions:
+#  - data: allocated data
+#  - zero: read-as-zero holes
+#  - discarded: not allocated
+# 4th additional type is 'overrun', which is for the format file portions beyond
+# the end of the underlying file.
+#
+# So, the fields are:
+#
+# @used-data: used by the format file and backed by data in the underlying file
+#
+# @used-zero: used by the format file and backed by a hole in the underlying
+#             file
+#
+# @used-discarded: used by the format file but actually unallocated in the
+#                  underlying file
+#
+# @used-overrun: used by the format file beyond the end of the underlying file
+#
+# @unused-data: allocated data in the underlying file not used by the format
+#
+# @unused-zero: holes in the underlying file not used by the format file
+#
+# @unused-discarded: unallocated areas in the underlying file not used by the
+#                    format file
+#
+# Note: sum of 6 fields {used,unused}-{data,zero,discarded} is equal to the
+#       length of the underlying file.
+#
+# Since: 2.10
+#
+##
+{ 'struct': 'BlockFormatAllocInfo',
+  'data': {'used-data':        'uint64',
+           'used-zero':        'uint64',
+           'used-discarded':   'uint64',
+           'used-overrun':     'uint64',
+           'unused-data':      'uint64',
+           'unused-zero':      'uint64',
+           'unused-discarded': 'uint64' } }
+
+##
 # @ImageCheck:
 #
 # Information about a QEMU image file check
-- 
2.11.1
