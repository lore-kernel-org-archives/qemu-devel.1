Received: from eggs.gnu.org ([2001:4830:134:3::10]:52815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvBy-0005q5-OX
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvBx-0001ML-Cq
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:37:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:36:50 +0200
Message-Id: <1497634636-20230-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/31] qed: Remove callback from
 qed_find_cluster()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qed-cluster.c | 39 ++++++++++++++++++++++-----------------
 block/qed.c         | 24 +++++++++++-------------
 block/qed.h         |  4 ++--
 3 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/block/qed-cluster.c b/block/qed-cluster.c
index d279944..88dc979 100644
--- a/block/qed-cluster.c
+++ b/block/qed-cluster.c
@@ -67,22 +67,27 @@ static unsigned int qed_count_contiguous_clusters(BDRVQEDState *s,
  * @s:          QED state
  * @request:    L2 cache entry
  * @pos:        Byte position in device
- * @len:        Number of bytes
- * @cb:         Completion function
- * @opaque:     User data for completion function
+ * @len:        Number of bytes (may be shortened on return)
+ * @img_offset: Contains offset in the image file on success
  *
  * This function translates a position in the block device to an offset in the
- * image file.  It invokes the cb completion callback to report back the
- * translated offset or unallocated range in the image file.
+ * image file. The translated offset or unallocated range in the image file is
+ * reported back in *img_offset and *len.
  *
  * If the L2 table exists, request->l2_table points to the L2 table cache entry
  * and the caller must free the reference when they are finished.  The cache
  * entry is exposed in this way to avoid callers having to read the L2 table
  * again later during request processing.  If request->l2_table is non-NULL it
  * will be unreferenced before taking on the new cache entry.
+ *
+ * On success QED_CLUSTER_FOUND is returned and img_offset/len are a contiguous
+ * range in the image file.
+ *
+ * On failure QED_CLUSTER_L2 or QED_CLUSTER_L1 is returned for missing L2 or L1
+ * table offset, respectively. len is number of contiguous unallocated bytes.
  */
-void qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t pos,
-                      size_t len, QEDFindClusterFunc *cb, void *opaque)
+int qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t pos,
+                     size_t *len, uint64_t *img_offset)
 {
     uint64_t l2_offset;
     uint64_t offset = 0;
@@ -93,16 +98,16 @@ void qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t pos,
     /* Limit length to L2 boundary.  Requests are broken up at the L2 boundary
      * so that a request acts on one L2 table at a time.
      */
-    len = MIN(len, (((pos >> s->l1_shift) + 1) << s->l1_shift) - pos);
+    *len = MIN(*len, (((pos >> s->l1_shift) + 1) << s->l1_shift) - pos);
 
     l2_offset = s->l1_table->offsets[qed_l1_index(s, pos)];
     if (qed_offset_is_unalloc_cluster(l2_offset)) {
-        cb(opaque, QED_CLUSTER_L1, 0, len);
-        return;
+        *img_offset = 0;
+        return QED_CLUSTER_L1;
     }
     if (!qed_check_table_offset(s, l2_offset)) {
-        cb(opaque, -EINVAL, 0, 0);
-        return;
+        *img_offset = *len = 0;
+        return -EINVAL;
     }
 
     ret = qed_read_l2_table(s, request, l2_offset);
@@ -112,8 +117,7 @@ void qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t pos,
     }
 
     index = qed_l2_index(s, pos);
-    n = qed_bytes_to_clusters(s,
-                              qed_offset_into_cluster(s, pos) + len);
+    n = qed_bytes_to_clusters(s, qed_offset_into_cluster(s, pos) + *len);
     n = qed_count_contiguous_clusters(s, request->l2_table->table,
                                       index, n, &offset);
 
@@ -127,10 +131,11 @@ void qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t pos,
         ret = -EINVAL;
     }
 
-    len = MIN(len,
-              n * s->header.cluster_size - qed_offset_into_cluster(s, pos));
+    *len = MIN(*len,
+               n * s->header.cluster_size - qed_offset_into_cluster(s, pos));
 
 out:
-    cb(opaque, ret, offset, len);
+    *img_offset = offset;
     qed_release(s);
+    return ret;
 }
diff --git a/block/qed.c b/block/qed.c
index a837a28..290cbcd 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -776,14 +776,14 @@ static int64_t coroutine_fn bdrv_qed_co_get_block_status(BlockDriverState *bs,
         .file = file,
     };
     QEDRequest request = { .l2_table = NULL };
+    uint64_t offset;
+    int ret;
 
-    qed_find_cluster(s, &request, cb.pos, len, qed_is_allocated_cb, &cb);
+    ret = qed_find_cluster(s, &request, cb.pos, &len, &offset);
+    qed_is_allocated_cb(&cb, ret, offset, len);
 
-    /* Now sleep if the callback wasn't invoked immediately */
-    while (cb.status == BDRV_BLOCK_OFFSET_MASK) {
-        cb.co = qemu_coroutine_self();
-        qemu_coroutine_yield();
-    }
+    /* The callback was invoked immediately */
+    assert(cb.status != BDRV_BLOCK_OFFSET_MASK);
 
     qed_unref_l2_cache_entry(request.l2_table);
 
@@ -1306,8 +1306,6 @@ static void qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset, size_t len)
  *              or -errno
  * @offset:     Cluster offset in bytes
  * @len:        Length in bytes
- *
- * Callback from qed_find_cluster().
  */
 static void qed_aio_write_data(void *opaque, int ret,
                                uint64_t offset, size_t len)
@@ -1343,8 +1341,6 @@ static void qed_aio_write_data(void *opaque, int ret,
  *              or -errno
  * @offset:     Cluster offset in bytes
  * @len:        Length in bytes
- *
- * Callback from qed_find_cluster().
  */
 static void qed_aio_read_data(void *opaque, int ret,
                               uint64_t offset, size_t len)
@@ -1393,6 +1389,8 @@ static void qed_aio_next_io(QEDAIOCB *acb, int ret)
     BDRVQEDState *s = acb_to_s(acb);
     QEDFindClusterFunc *io_fn = (acb->flags & QED_AIOCB_WRITE) ?
                                 qed_aio_write_data : qed_aio_read_data;
+    uint64_t offset;
+    size_t len;
 
     trace_qed_aio_next_io(s, acb, ret, acb->cur_pos + acb->cur_qiov.size);
 
@@ -1419,9 +1417,9 @@ static void qed_aio_next_io(QEDAIOCB *acb, int ret)
     }
 
     /* Find next cluster and start I/O */
-    qed_find_cluster(s, &acb->request,
-                      acb->cur_pos, acb->end_pos - acb->cur_pos,
-                      io_fn, acb);
+    len = acb->end_pos - acb->cur_pos;
+    ret = qed_find_cluster(s, &acb->request, acb->cur_pos, &len, &offset);
+    io_fn(acb, ret, offset, len);
 }
 
 static BlockAIOCB *qed_aio_setup(BlockDriverState *bs,
diff --git a/block/qed.h b/block/qed.h
index c715058..6ab5702 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -247,8 +247,8 @@ int qed_write_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
 /**
  * Cluster functions
  */
-void qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t pos,
-                      size_t len, QEDFindClusterFunc *cb, void *opaque);
+int qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t pos,
+                     size_t *len, uint64_t *img_offset);
 
 /**
  * Consistency check
-- 
1.8.3.1
