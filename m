Received: from eggs.gnu.org ([2001:4830:134:3::10]:60624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VR5-0001Uo-NG
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VR4-00037b-IO
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:09:39 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Mar 2018 19:09:08 +0800
Message-Id: <20180329110914.20888-3-famz@redhat.com>
In-Reply-To: <20180329110914.20888-1-famz@redhat.com>
References: <20180329110914.20888-1-famz@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 2/8] qcow2: Implement bdrv_co_map_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

Extract the common code from qcow2_co_block_status, then use it to
implement qcow2_co_map_range. The major difference is the allocation
logic, enabled by BDRV_REQ_ALLOCATE.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/qcow2.c | 103 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 30 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 486f3e83b7..86bbeb69db 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1755,6 +1755,73 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     return status;
 }
 
+static int qcow2_handle_l2meta(BlockDriverState *bs, QCowL2Meta *l2meta)
+{
+    int ret = 0;
+
+    while (l2meta != NULL) {
+        QCowL2Meta *next;
+
+        if (!ret) {
+            ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
+        }
+
+        /* Take the request off the list of running requests */
+        if (l2meta->nb_clusters != 0) {
+            QLIST_REMOVE(l2meta, next_in_flight);
+        }
+
+        qemu_co_queue_restart_all(&l2meta->dependent_requests);
+
+        next = l2meta->next;
+        g_free(l2meta);
+        l2meta = next;
+    }
+    return ret;
+}
+
+static int coroutine_fn qcow2_co_map_range(BlockDriverState *bs, int64_t offset,
+                                           int64_t bytes, int64_t *pnum, int64_t *map,
+                                           BlockDriverState **file,
+                                           int flags)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+    uint64_t cluster_offset;
+    unsigned int cur_bytes = MIN(bytes, INT_MAX);
+    int offset_in_cluster;
+    QCowL2Meta *l2meta = NULL;
+
+    if (!(flags & BDRV_REQ_ALLOCATE)) {
+        return qcow2_co_block_status(bs, true, offset, bytes, pnum, map, file);
+    }
+    qemu_co_mutex_lock(&s->lock);
+    ret = qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
+                                     &cluster_offset, &l2meta);
+    if (ret < 0) {
+        goto out;
+    }
+
+    offset_in_cluster = offset_into_cluster(s, offset);
+    ret = qcow2_pre_write_overlap_check(bs, 0,
+                                        cluster_offset + offset_in_cluster,
+                                        cur_bytes);
+    if (ret < 0) {
+        goto out;
+    }
+    ret = qcow2_handle_l2meta(bs, l2meta);
+    if (ret < 0) {
+        goto out;
+    }
+    *pnum = cur_bytes;
+    *map = cluster_offset + offset_in_cluster;
+    *file = bs->file->bs;
+    ret = BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA;
+out:
+    qemu_co_mutex_unlock(&s->lock);
+    return ret;
+}
+
 static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                                         uint64_t bytes, QEMUIOVector *qiov,
                                         int flags)
@@ -2041,24 +2108,10 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
             }
         }
 
-        while (l2meta != NULL) {
-            QCowL2Meta *next;
-
-            ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
-            if (ret < 0) {
-                goto fail;
-            }
-
-            /* Take the request off the list of running requests */
-            if (l2meta->nb_clusters != 0) {
-                QLIST_REMOVE(l2meta, next_in_flight);
-            }
-
-            qemu_co_queue_restart_all(&l2meta->dependent_requests);
-
-            next = l2meta->next;
-            g_free(l2meta);
-            l2meta = next;
+        ret = qcow2_handle_l2meta(bs, l2meta);
+        l2meta = NULL;
+        if (ret) {
+            goto fail;
         }
 
         bytes -= cur_bytes;
@@ -2069,18 +2122,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
     ret = 0;
 
 fail:
-    while (l2meta != NULL) {
-        QCowL2Meta *next;
-
-        if (l2meta->nb_clusters != 0) {
-            QLIST_REMOVE(l2meta, next_in_flight);
-        }
-        qemu_co_queue_restart_all(&l2meta->dependent_requests);
-
-        next = l2meta->next;
-        g_free(l2meta);
-        l2meta = next;
-    }
+    qcow2_handle_l2meta(bs, l2meta);
 
     qemu_co_mutex_unlock(&s->lock);
 
@@ -4508,6 +4550,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_co_create       = qcow2_co_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_block_status = qcow2_co_block_status,
+    .bdrv_co_map_range    = qcow2_co_map_range,
 
     .bdrv_co_preadv         = qcow2_co_preadv,
     .bdrv_co_pwritev        = qcow2_co_pwritev,
-- 
2.14.3
