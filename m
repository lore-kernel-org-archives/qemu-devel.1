Received: from eggs.gnu.org ([2001:4830:134:3::10]:52811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvBy-0005pt-GB
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvBx-0001M9-Aj
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:37:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:36:49 +0200
Message-Id: <1497634636-20230-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/31] qed: Remove callback from
 qed_read_l2_table()
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed-cluster.c | 94 ++++++++++++++++++-----------------------------------
 block/qed-table.c   | 15 +++------
 block/qed.h         |  3 +-
 3 files changed, 36 insertions(+), 76 deletions(-)

diff --git a/block/qed-cluster.c b/block/qed-cluster.c
index 8f5da74..d279944 100644
--- a/block/qed-cluster.c
+++ b/block/qed-cluster.c
@@ -61,59 +61,6 @@ static unsigned int qed_count_contiguous_clusters(BDRVQEDState *s,
     return i - index;
 }
 
-typedef struct {
-    BDRVQEDState *s;
-    uint64_t pos;
-    size_t len;
-
-    QEDRequest *request;
-
-    /* User callback */
-    QEDFindClusterFunc *cb;
-    void *opaque;
-} QEDFindClusterCB;
-
-static void qed_find_cluster_cb(void *opaque, int ret)
-{
-    QEDFindClusterCB *find_cluster_cb = opaque;
-    BDRVQEDState *s = find_cluster_cb->s;
-    QEDRequest *request = find_cluster_cb->request;
-    uint64_t offset = 0;
-    size_t len = 0;
-    unsigned int index;
-    unsigned int n;
-
-    qed_acquire(s);
-    if (ret) {
-        goto out;
-    }
-
-    index = qed_l2_index(s, find_cluster_cb->pos);
-    n = qed_bytes_to_clusters(s,
-                              qed_offset_into_cluster(s, find_cluster_cb->pos) +
-                              find_cluster_cb->len);
-    n = qed_count_contiguous_clusters(s, request->l2_table->table,
-                                      index, n, &offset);
-
-    if (qed_offset_is_unalloc_cluster(offset)) {
-        ret = QED_CLUSTER_L2;
-    } else if (qed_offset_is_zero_cluster(offset)) {
-        ret = QED_CLUSTER_ZERO;
-    } else if (qed_check_cluster_offset(s, offset)) {
-        ret = QED_CLUSTER_FOUND;
-    } else {
-        ret = -EINVAL;
-    }
-
-    len = MIN(find_cluster_cb->len, n * s->header.cluster_size -
-              qed_offset_into_cluster(s, find_cluster_cb->pos));
-
-out:
-    find_cluster_cb->cb(find_cluster_cb->opaque, ret, offset, len);
-    qed_release(s);
-    g_free(find_cluster_cb);
-}
-
 /**
  * Find the offset of a data cluster
  *
@@ -137,8 +84,11 @@ out:
 void qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t pos,
                       size_t len, QEDFindClusterFunc *cb, void *opaque)
 {
-    QEDFindClusterCB *find_cluster_cb;
     uint64_t l2_offset;
+    uint64_t offset = 0;
+    unsigned int index;
+    unsigned int n;
+    int ret;
 
     /* Limit length to L2 boundary.  Requests are broken up at the L2 boundary
      * so that a request acts on one L2 table at a time.
@@ -155,14 +105,32 @@ void qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t pos,
         return;
     }
 
-    find_cluster_cb = g_malloc(sizeof(*find_cluster_cb));
-    find_cluster_cb->s = s;
-    find_cluster_cb->pos = pos;
-    find_cluster_cb->len = len;
-    find_cluster_cb->cb = cb;
-    find_cluster_cb->opaque = opaque;
-    find_cluster_cb->request = request;
+    ret = qed_read_l2_table(s, request, l2_offset);
+    qed_acquire(s);
+    if (ret) {
+        goto out;
+    }
+
+    index = qed_l2_index(s, pos);
+    n = qed_bytes_to_clusters(s,
+                              qed_offset_into_cluster(s, pos) + len);
+    n = qed_count_contiguous_clusters(s, request->l2_table->table,
+                                      index, n, &offset);
+
+    if (qed_offset_is_unalloc_cluster(offset)) {
+        ret = QED_CLUSTER_L2;
+    } else if (qed_offset_is_zero_cluster(offset)) {
+        ret = QED_CLUSTER_ZERO;
+    } else if (qed_check_cluster_offset(s, offset)) {
+        ret = QED_CLUSTER_FOUND;
+    } else {
+        ret = -EINVAL;
+    }
+
+    len = MIN(len,
+              n * s->header.cluster_size - qed_offset_into_cluster(s, pos));
 
-    qed_read_l2_table(s, request, l2_offset,
-                      qed_find_cluster_cb, find_cluster_cb);
+out:
+    cb(opaque, ret, offset, len);
+    qed_release(s);
 }
diff --git a/block/qed-table.c b/block/qed-table.c
index 4270003..ffecbea 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -177,8 +177,7 @@ int qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
     return ret;
 }
 
-void qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset,
-                       BlockCompletionFunc *cb, void *opaque)
+int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset)
 {
     int ret;
 
@@ -187,8 +186,7 @@ void qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset,
     /* Check for cached L2 entry */
     request->l2_table = qed_find_l2_cache_entry(&s->l2_cache, offset);
     if (request->l2_table) {
-        cb(opaque, 0);
-        return;
+        return 0;
     }
 
     request->l2_table = qed_alloc_l2_cache_entry(&s->l2_cache);
@@ -215,17 +213,12 @@ void qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset,
     }
     qed_release(s);
 
-    cb(opaque, ret);
+    return ret;
 }
 
 int qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request, uint64_t offset)
 {
-    int ret = -EINPROGRESS;
-
-    qed_read_l2_table(s, request, offset, qed_sync_cb, &ret);
-    BDRV_POLL_WHILE(s->bs, ret == -EINPROGRESS);
-
-    return ret;
+    return qed_read_l2_table(s, request, offset);
 }
 
 void qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
diff --git a/block/qed.h b/block/qed.h
index ce8c314..c715058 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -237,8 +237,7 @@ int qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
                             unsigned int n);
 int qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
                            uint64_t offset);
-void qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset,
-                       BlockCompletionFunc *cb, void *opaque);
+int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset);
 void qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
                         unsigned int index, unsigned int n, bool flush,
                         BlockCompletionFunc *cb, void *opaque);
-- 
1.8.3.1
