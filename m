Received: from eggs.gnu.org ([2001:4830:134:3::10]:48001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fHA6P-0001wV-FN
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fHA6O-0005Xa-Fg
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:37:01 -0400
From: Ivan Ren <renyime@gmail.com>
Date: Fri, 11 May 2018 23:36:44 +0800
Message-Id: <1526053004-12268-1-git-send-email-ivanren@tencent.com>
Subject: [Qemu-devel] [PATCH v3] qcow2: fix preallocation with metadata on
 bare block device
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
return pre-existing data on block device. This patch add
QCOW_OFLAG_ZERO flag (supported in qcow_version >= 3) for
preallocated l2 entry to avoid this problem.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
Changes in v2:
- always pass QCOW_OFLAG_ZERO when preallocate metadta
Changes in v3:
- limit this feature only on qcow_version >= 3
---
 block/qcow2-cluster.c |  5 +++--
 block/qcow2.c         | 12 +++++++++---
 block/qcow2.h         |  3 ++-
 3 files changed, 14 insertions(+), 6 deletions(-)

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
index 2f36e63..ee862b0 100644
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
@@ -2552,7 +2552,13 @@ static void coroutine_fn preallocate_co(void *opaque)
         while (meta) {
             QCowL2Meta *next = meta->next;
 
-            ret = qcow2_alloc_cluster_link_l2(bs, meta);
+            if (s->qcow_version >= 3) {
+                /* add QCOW_OFLAG_ZERO to avoid pre-existing data be read */
+                ret = qcow2_alloc_cluster_link_l2(bs, meta, QCOW_OFLAG_ZERO);
+            } else {
+                ret = qcow2_alloc_cluster_link_l2(bs, meta, 0);
+            }
+
             if (ret < 0) {
                 qcow2_free_any_clusters(bs, meta->alloc_offset,
                                         meta->nb_clusters, QCOW2_DISCARD_NEVER);
@@ -3458,7 +3464,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
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
