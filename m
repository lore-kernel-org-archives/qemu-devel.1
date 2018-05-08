Received: from eggs.gnu.org ([2001:4830:134:3::10]:40953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fG1iT-0005JT-V2
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fG1iS-0008I7-UX
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:27:37 -0400
From: Ivan Ren <renyime@gmail.com>
Date: Tue,  8 May 2018 20:27:21 +0800
Message-Id: <1525782441-2224-1-git-send-email-ivanren@tencent.com>
Subject: [Qemu-devel] [PATCH] qcow2: fix preallocation with metadata on bare
 block device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mreitz@redhat.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Create a qcow2 directly on bare block device with
"-o preallocation=metadata" option. When read this qcow2, it will
return dirty data of block device. This patch add QCOW_OFLAG_ZERO
for all preallocated l2 entry if the underlying device is a bare
block device.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
 block/qcow2-cluster.c |  5 +++--
 block/qcow2.c         | 19 ++++++++++++++++---
 block/qcow2.h         |  3 ++-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1aee726..b9e0ceb 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -919,7 +919,8 @@ fail:
     return ret;
 }
 
-int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
+int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m,
+                                uint64_t flags)
 {
     BDRVQcow2State *s = bs->opaque;
     int i, j = 0, l2_index, ret;
@@ -969,7 +970,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
         }
 
         l2_slice[l2_index + i] = cpu_to_be64((cluster_offset +
-                    (i << s->cluster_bits)) | QCOW_OFLAG_COPIED);
+                    (i << s->cluster_bits)) | QCOW_OFLAG_COPIED | flags);
      }
 
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 2f36e63..093735c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2044,7 +2044,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
         while (l2meta != NULL) {
             QCowL2Meta *next;
 
-            ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
+            ret = qcow2_alloc_cluster_link_l2(bs, l2meta, 0);
             if (ret < 0) {
                 goto fail;
             }
@@ -2534,6 +2534,7 @@ static void coroutine_fn preallocate_co(void *opaque)
     uint64_t host_offset = 0;
     unsigned int cur_bytes;
     int ret;
+    struct stat st;
     QCowL2Meta *meta;
 
     qemu_co_mutex_lock(&s->lock);
@@ -2552,7 +2553,19 @@ static void coroutine_fn preallocate_co(void *opaque)
         while (meta) {
             QCowL2Meta *next = meta->next;
 
-            ret = qcow2_alloc_cluster_link_l2(bs, meta);
+            /* Check the underlying device type.
+             * If the underlying device is a block device, we add
+             * QCOW_OFLAG_ZERO for all preallocated l2 entry to ignore dirty
+             * data on block device.
+             * If the underlying device can't be used with stat(return < 0),
+             * treat it as a regular file.
+             */
+            if (stat(bs->filename, &st) < 0 || !S_ISBLK(st.st_mode)) {
+                ret = qcow2_alloc_cluster_link_l2(bs, meta, 0);
+            } else {
+                ret = qcow2_alloc_cluster_link_l2(bs, meta, QCOW_OFLAG_ZERO);
+            }
+
             if (ret < 0) {
                 qcow2_free_any_clusters(bs, meta->alloc_offset,
                                         meta->nb_clusters, QCOW2_DISCARD_NEVER);
@@ -3458,7 +3471,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
             };
             qemu_co_queue_init(&allocation.dependent_requests);
 
-            ret = qcow2_alloc_cluster_link_l2(bs, &allocation);
+            ret = qcow2_alloc_cluster_link_l2(bs, &allocation, 0);
             if (ret < 0) {
                 error_setg_errno(errp, -ret, "Failed to update L2 tables");
                 qcow2_free_clusters(bs, host_offset,
diff --git a/block/qcow2.h b/block/qcow2.h
index adf5c39..9a59602 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -617,7 +617,8 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
                                          uint64_t offset,
                                          int compressed_size);
 
-int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m);
+int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m,
+                                uint64_t flags);
 int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
                           uint64_t bytes, enum qcow2_discard_type type,
                           bool full_discard);
-- 
1.8.3.1
