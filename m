Received: from eggs.gnu.org ([2001:4830:134:3::10]:59610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAchX-0006aj-VY
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAchU-0006hA-M8
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:16:35 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 11 Oct 2018 18:16:17 +0300
Message-Id: <20181011151623.25702-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181011151623.25702-1-vsementsov@virtuozzo.com>
References: <20181011151623.25702-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 2/8] block/qcow2-refcount: avoid eating RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

qcow2_inc_refcounts_imrt() (through realloc_refcount_array()) can eat
an unpredictable amount of memory on corrupted table entries, which are
referencing regions far beyond the end of file.

Prevent this, by skipping such regions from further processing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index b453d87a3f..afaa1a1409 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1499,12 +1499,30 @@ int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t start, last, cluster_offset, k, refcount;
+    int64_t file_len;
     int ret;
 
     if (size <= 0) {
         return 0;
     }
 
+    file_len = bdrv_getlength(bs->file->bs);
+    if (file_len < 0) {
+        return file_len;
+    }
+
+    /* Last cluster of qcow2 image may be semi-allocated, so it's may be OK to
+     * reference some space after file end but it should be less than one
+     * cluster.
+     */
+    if (offset + size - file_len >= s->cluster_size) {
+        fprintf(stderr, "ERROR: counting reference for region exceeding the "
+                "end of the file by one cluster or more: offset 0x%" PRIx64
+                " size 0x%" PRIx64 "\n", offset, size);
+        res->corruptions++;
+        return 0;
+    }
+
     start = start_of_cluster(s, offset);
     last = start_of_cluster(s, offset + size - 1);
     for(cluster_offset = start; cluster_offset <= last;
-- 
2.18.0
