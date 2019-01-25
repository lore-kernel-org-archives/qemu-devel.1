Received: from eggs.gnu.org ([209.51.188.92]:57209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gn2Ma-0001xj-QU
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gn2MZ-00049K-Dl
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:21:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 25 Jan 2019 17:21:38 +0300
Message-Id: <20190125142138.76710-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] qcow2: avoid lseek on block_status if possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

drv_co_block_status digs bs->file for additional, more accurate search
for hole inside region, reported as DATA by bs since 5daa74a6ebc.

This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
knows, where are holes and where is data. But every block_status
request calls lseek additionally. Assume a big disk, full of
data, in any iterative copying block job (or img convert) we'll call
lseek(HOLE) on every iteration, and each of these lseeks will have to
iterate through all metadata up to the end of file. It's obviously
ineffective behavior. And for many scenarios we don't need this lseek
at all.

However, lseek is needed when we have metadata-preallocated image.

So, let's detect metadata-preallocation case and don't dig qcow2's
protocol file in other cases.

The idea is to compare allocation size in POV of filesystem with
allocations size in POV of Qcow2 (by refcounts). If allocation in fs is
significantly lower, consider it as metadata-preallocation case.

Suggested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi!

So, to continue talk about lseek/no lseek when qcow2 block_status reports
DATA.

Results on tmpfs:
cached is lseek cache by Kevin
detect is this patch
no lseek is just remove block_status query on bs->file->bs in
         bdrv_co_block_status

    +---------------------+--------+--------+--------+----------+
    |                     | master | cached | detect | no lseek |
    +---------------------+--------+--------+--------+----------+
    | test.qcow2          | 80     | 40     | 0.169  | 0.162    |
    +---------------------+--------+--------+--------+----------+
    | test_forward.qcow2  | 79     | 0.171  | 0.169  | 0.163    |
    +---------------------+--------+--------+--------+----------+
    | test_prealloc.qcow2 | 0.054  | 0.053  | 0.055  | 0.263    |
    +---------------------+--------+--------+--------+----------+

 block/qcow2.h             |  1 +
 include/block/block_int.h |  7 +++++++
 block/io.c                |  3 ++-
 block/qcow2-refcount.c    | 36 ++++++++++++++++++++++++++++++++++++
 block/qcow2.c             |  7 +++++++
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 438a1dee9e..d7113ed44c 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -610,6 +610,7 @@ int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
                                 void *cb_opaque, Error **errp);
 int qcow2_shrink_reftable(BlockDriverState *bs);
 int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size);
+int qcow2_detect_metadata_preallocation(BlockDriverState *bs);
 
 /* qcow2-cluster.c functions */
 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622216..c895ca7169 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -59,6 +59,12 @@
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
+typedef enum BdrvYesNoUnknown {
+    BDRV_UNKNOWN = 0,
+    BDRV_NO,
+    BDRV_YES,
+} BdrvYesNoUnknown;
+
 enum BdrvTrackedRequestType {
     BDRV_TRACKED_READ,
     BDRV_TRACKED_WRITE,
@@ -682,6 +688,7 @@ struct BlockDriverState {
     bool probed;    /* if true, format was probed rather than specified */
     bool force_share; /* if true, always allow all shared permissions */
     bool implicit;  /* if true, this filter node was automatically inserted */
+    BdrvYesNoUnknown metadata_preallocation;
 
     BlockDriver *drv; /* NULL means no media */
     void *opaque;
diff --git a/block/io.c b/block/io.c
index bd9d688f8b..815661750a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2186,7 +2186,8 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         }
     }
 
-    if (want_zero && local_file && local_file != bs &&
+    if (want_zero && bs->metadata_preallocation != BDRV_NO &&
+        local_file && local_file != bs &&
         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
         (ret & BDRV_BLOCK_OFFSET_VALID)) {
         int64_t file_pnum;
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 1c63ac244a..008196d849 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -3379,3 +3379,39 @@ int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size)
                             "There are no references in the refcount table.");
     return -EIO;
 }
+
+int qcow2_detect_metadata_preallocation(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int64_t i, end_cluster, cluster_count = 0;
+    int64_t file_length, real_allocation, metadata_allocation, file_tail;
+    uint64_t refcount;
+
+    file_length = bdrv_getlength(bs->file->bs);
+    if (file_length < 0) {
+        return file_length;
+    }
+    file_tail = offset_into_cluster(s, file_length);
+
+    real_allocation = bdrv_get_allocated_file_size(bs->file->bs);
+    if (real_allocation < 0) {
+        return real_allocation;
+    }
+
+    end_cluster = size_to_clusters(s, file_length);
+    for (i = 0; i < end_cluster; i++) {
+        int ret = qcow2_get_refcount(bs, i, &refcount);
+        if (ret < 0) {
+            return ret;
+        }
+        cluster_count += !!refcount;
+    }
+
+    metadata_allocation = cluster_count * s->cluster_size;
+    if (!!refcount && file_tail) {
+        metadata_allocation -= s->cluster_size - file_tail;
+    }
+
+    return real_allocation < 0.9 * metadata_allocation &&
+        real_allocation + s->cluster_size < metadata_allocation;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 4897abae5e..adc9cdcb27 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1800,6 +1800,13 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     unsigned int bytes;
     int status = 0;
 
+    if (bs->metadata_preallocation == BDRV_UNKNOWN) {
+        ret = qcow2_detect_metadata_preallocation(bs);
+        if (ret >= 0) {
+            bs->metadata_preallocation = ret ? BDRV_YES : BDRV_NO;
+        }
+    }
+
     bytes = MIN(INT_MAX, count);
     qemu_co_mutex_lock(&s->lock);
     ret = qcow2_get_cluster_offset(bs, offset, &bytes, &cluster_offset);
-- 
2.18.0
