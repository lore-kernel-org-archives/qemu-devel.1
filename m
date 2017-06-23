Received: from eggs.gnu.org ([2001:4830:134:3::10]:60249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMM-0001fS-Rx
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORML-0007vX-PP
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:41 +0200
Message-Id: <1498234919-27316-44-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 43/61] qed: Add return value to
 qed_aio_write_main()
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

Don't recurse into qed_aio_next_io() and qed_aio_complete() here, but
just return an error code and let the caller handle it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 55 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 3cda01f..a4b13f8 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1022,29 +1022,22 @@ static int qed_aio_write_l2_update(QEDAIOCB *acb, uint64_t offset)
 /**
  * Write data to the image file
  */
-static void qed_aio_write_main(void *opaque, int ret)
+static int qed_aio_write_main(QEDAIOCB *acb)
 {
-    QEDAIOCB *acb = opaque;
     BDRVQEDState *s = acb_to_s(acb);
     uint64_t offset = acb->cur_cluster +
                       qed_offset_into_cluster(s, acb->cur_pos);
+    int ret;
 
-    trace_qed_aio_write_main(s, acb, ret, offset, acb->cur_qiov.size);
-
-    if (ret) {
-        qed_aio_complete(acb, ret);
-        return;
-    }
+    trace_qed_aio_write_main(s, acb, 0, offset, acb->cur_qiov.size);
 
     BLKDBG_EVENT(s->bs->file, BLKDBG_WRITE_AIO);
     ret = bdrv_pwritev(s->bs->file, offset, &acb->cur_qiov);
-    if (ret >= 0) {
-        ret = 0;
+    if (ret < 0) {
+        return ret;
     }
 
-    if (acb->find_cluster_ret == QED_CLUSTER_FOUND) {
-        qed_aio_next_io(acb, ret);
-    } else {
+    if (acb->find_cluster_ret != QED_CLUSTER_FOUND) {
         if (s->bs->backing) {
             /*
              * Flush new data clusters before updating the L2 table
@@ -1057,20 +1050,16 @@ static void qed_aio_write_main(void *opaque, int ret)
              * cluster and before updating the L2 table.
              */
             ret = bdrv_flush(s->bs->file->bs);
-        }
-        if (ret) {
-            goto err;
+            if (ret < 0) {
+                return ret;
+            }
         }
         ret = qed_aio_write_l2_update(acb, acb->cur_cluster);
-        if (ret) {
-            goto err;
+        if (ret < 0) {
+            return ret;
         }
-        qed_aio_next_io(acb, 0);
     }
-    return;
-
-err:
-    qed_aio_complete(acb, ret);
+    return 0;
 }
 
 /**
@@ -1102,8 +1091,17 @@ static void qed_aio_write_cow(void *opaque, int ret)
 
     trace_qed_aio_write_postfill(s, acb, start, len, offset);
     ret = qed_copy_from_backing_file(s, start, len, offset);
+    if (ret) {
+        qed_aio_complete(acb, ret);
+        return;
+    }
 
-    qed_aio_write_main(acb, ret);
+    ret = qed_aio_write_main(acb);
+    if (ret < 0) {
+        qed_aio_complete(acb, ret);
+        return;
+    }
+    qed_aio_next_io(acb, 0);
 }
 
 /**
@@ -1201,6 +1199,8 @@ static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
  */
 static void qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset, size_t len)
 {
+    int ret;
+
     /* Allocate buffer for zero writes */
     if (acb->flags & QED_AIOCB_ZERO) {
         struct iovec *iov = acb->qiov->iov;
@@ -1220,7 +1220,12 @@ static void qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset, size_t len)
     qemu_iovec_concat(&acb->cur_qiov, acb->qiov, acb->qiov_offset, len);
 
     /* Do the actual write */
-    qed_aio_write_main(acb, 0);
+    ret = qed_aio_write_main(acb);
+    if (ret < 0) {
+        qed_aio_complete(acb, ret);
+        return;
+    }
+    qed_aio_next_io(acb, 0);
 }
 
 /**
-- 
1.8.3.1
