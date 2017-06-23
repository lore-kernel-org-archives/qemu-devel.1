Received: from eggs.gnu.org ([2001:4830:134:3::10]:59858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMA-0001PT-2o
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORM8-0007la-Ts
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:30 +0200
Message-Id: <1498234919-27316-33-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 32/61] qed: Remove callback from
 qed_copy_from_backing_file()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

With this change, qed_aio_write_prefill() and qed_aio_write_postfill()
collapse into a single function. This is reflected by a rename of the
combined function to qed_aio_write_cow().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 57 +++++++++++++++++++++++----------------------------------
 1 file changed, 23 insertions(+), 34 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index af53b8f..658b31b 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -861,13 +861,9 @@ static int qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
  * @pos:        Byte position in device
  * @len:        Number of bytes
  * @offset:     Byte offset in image file
- * @cb:         Completion function
- * @opaque:     User data for completion function
  */
-static void qed_copy_from_backing_file(BDRVQEDState *s, uint64_t pos,
-                                       uint64_t len, uint64_t offset,
-                                       BlockCompletionFunc *cb,
-                                       void *opaque)
+static int qed_copy_from_backing_file(BDRVQEDState *s, uint64_t pos,
+                                      uint64_t len, uint64_t offset)
 {
     QEMUIOVector qiov;
     QEMUIOVector *backing_qiov = NULL;
@@ -876,8 +872,7 @@ static void qed_copy_from_backing_file(BDRVQEDState *s, uint64_t pos,
 
     /* Skip copy entirely if there is no work to do */
     if (len == 0) {
-        cb(opaque, 0);
-        return;
+        return 0;
     }
 
     iov = (struct iovec) {
@@ -906,7 +901,7 @@ static void qed_copy_from_backing_file(BDRVQEDState *s, uint64_t pos,
     ret = 0;
 out:
     qemu_vfree(iov.iov_base);
-    cb(opaque, ret);
+    return ret;
 }
 
 /**
@@ -1133,42 +1128,36 @@ static void qed_aio_write_main(void *opaque, int ret)
 }
 
 /**
- * Populate back untouched region of new data cluster
+ * Populate untouched regions of new data cluster
  */
-static void qed_aio_write_postfill(void *opaque, int ret)
+static void qed_aio_write_cow(void *opaque, int ret)
 {
     QEDAIOCB *acb = opaque;
     BDRVQEDState *s = acb_to_s(acb);
-    uint64_t start = acb->cur_pos + acb->cur_qiov.size;
-    uint64_t len =
-        qed_start_of_cluster(s, start + s->header.cluster_size - 1) - start;
-    uint64_t offset = acb->cur_cluster +
-                      qed_offset_into_cluster(s, acb->cur_pos) +
-                      acb->cur_qiov.size;
+    uint64_t start, len, offset;
+
+    /* Populate front untouched region of new data cluster */
+    start = qed_start_of_cluster(s, acb->cur_pos);
+    len = qed_offset_into_cluster(s, acb->cur_pos);
 
+    trace_qed_aio_write_prefill(s, acb, start, len, acb->cur_cluster);
+    ret = qed_copy_from_backing_file(s, start, len, acb->cur_cluster);
     if (ret) {
         qed_aio_complete(acb, ret);
         return;
     }
 
-    trace_qed_aio_write_postfill(s, acb, start, len, offset);
-    qed_copy_from_backing_file(s, start, len, offset,
-                                qed_aio_write_main, acb);
-}
+    /* Populate back untouched region of new data cluster */
+    start = acb->cur_pos + acb->cur_qiov.size;
+    len = qed_start_of_cluster(s, start + s->header.cluster_size - 1) - start;
+    offset = acb->cur_cluster +
+             qed_offset_into_cluster(s, acb->cur_pos) +
+             acb->cur_qiov.size;
 
-/**
- * Populate front untouched region of new data cluster
- */
-static void qed_aio_write_prefill(void *opaque, int ret)
-{
-    QEDAIOCB *acb = opaque;
-    BDRVQEDState *s = acb_to_s(acb);
-    uint64_t start = qed_start_of_cluster(s, acb->cur_pos);
-    uint64_t len = qed_offset_into_cluster(s, acb->cur_pos);
+    trace_qed_aio_write_postfill(s, acb, start, len, offset);
+    ret = qed_copy_from_backing_file(s, start, len, offset);
 
-    trace_qed_aio_write_prefill(s, acb, start, len, acb->cur_cluster);
-    qed_copy_from_backing_file(s, start, len, acb->cur_cluster,
-                                qed_aio_write_postfill, acb);
+    qed_aio_write_main(acb, ret);
 }
 
 /**
@@ -1236,7 +1225,7 @@ static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
 
         cb = qed_aio_write_zero_cluster;
     } else {
-        cb = qed_aio_write_prefill;
+        cb = qed_aio_write_cow;
         acb->cur_cluster = qed_alloc_clusters(s, acb->cur_nclusters);
     }
 
-- 
1.8.3.1
