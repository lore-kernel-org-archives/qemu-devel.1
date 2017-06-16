Received: from eggs.gnu.org ([2001:4830:134:3::10]:53378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCe-0006Wc-2s
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCd-00029H-0B
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:37:07 +0200
Message-Id: <1497634636-20230-23-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 22/31] qed: Add return value to
 qed_aio_read/write_data()
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

Don't recurse into qed_aio_next_io() and qed_aio_complete() here, but
just return an error code and let the caller handle it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 72 ++++++++++++++++++++++++++-----------------------------------
 block/qed.h | 21 ------------------
 2 files changed, 31 insertions(+), 62 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 4c8ba4a..6f83831 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1205,13 +1205,12 @@ static int qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset, size_t len)
  * Write data cluster
  *
  * @opaque:     Write request
- * @ret:        QED_CLUSTER_FOUND, QED_CLUSTER_L2, QED_CLUSTER_L1,
- *              or -errno
+ * @ret:        QED_CLUSTER_FOUND, QED_CLUSTER_L2 or QED_CLUSTER_L1
  * @offset:     Cluster offset in bytes
  * @len:        Length in bytes
  */
-static void qed_aio_write_data(void *opaque, int ret,
-                               uint64_t offset, size_t len)
+static int qed_aio_write_data(void *opaque, int ret,
+                              uint64_t offset, size_t len)
 {
     QEDAIOCB *acb = opaque;
 
@@ -1221,40 +1220,27 @@ static void qed_aio_write_data(void *opaque, int ret,
 
     switch (ret) {
     case QED_CLUSTER_FOUND:
-        ret = qed_aio_write_inplace(acb, offset, len);
-        break;
+        return qed_aio_write_inplace(acb, offset, len);
 
     case QED_CLUSTER_L2:
     case QED_CLUSTER_L1:
     case QED_CLUSTER_ZERO:
-        ret = qed_aio_write_alloc(acb, len);
-        break;
+        return qed_aio_write_alloc(acb, len);
 
     default:
-        assert(ret < 0);
-        break;
-    }
-
-    if (ret < 0) {
-        if (ret != -EINPROGRESS) {
-            qed_aio_complete(acb, ret);
-        }
-        return;
+        g_assert_not_reached();
     }
-    qed_aio_next_io(acb, 0);
 }
 
 /**
  * Read data cluster
  *
  * @opaque:     Read request
- * @ret:        QED_CLUSTER_FOUND, QED_CLUSTER_L2, QED_CLUSTER_L1,
- *              or -errno
+ * @ret:        QED_CLUSTER_FOUND, QED_CLUSTER_L2 or QED_CLUSTER_L1
  * @offset:     Cluster offset in bytes
  * @len:        Length in bytes
  */
-static void qed_aio_read_data(void *opaque, int ret,
-                              uint64_t offset, size_t len)
+static int qed_aio_read_data(void *opaque, int ret, uint64_t offset, size_t len)
 {
     QEDAIOCB *acb = opaque;
     BDRVQEDState *s = acb_to_s(acb);
@@ -1265,34 +1251,23 @@ static void qed_aio_read_data(void *opaque, int ret,
 
     trace_qed_aio_read_data(s, acb, ret, offset, len);
 
-    if (ret < 0) {
-        goto err;
-    }
-
     qemu_iovec_concat(&acb->cur_qiov, acb->qiov, acb->qiov_offset, len);
 
     /* Handle zero cluster and backing file reads */
     if (ret == QED_CLUSTER_ZERO) {
         qemu_iovec_memset(&acb->cur_qiov, 0, 0, acb->cur_qiov.size);
-        qed_aio_start_io(acb);
-        return;
+        return 0;
     } else if (ret != QED_CLUSTER_FOUND) {
-        ret = qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov,
-                                    &acb->backing_qiov);
-        qed_aio_next_io(acb, ret);
-        return;
+        return qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov,
+                                     &acb->backing_qiov);
     }
 
     BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
     ret = bdrv_preadv(bs->file, offset, &acb->cur_qiov);
     if (ret < 0) {
-        goto err;
+        return ret;
     }
-    qed_aio_next_io(acb, 0);
-    return;
-
-err:
-    qed_aio_complete(acb, ret);
+    return 0;
 }
 
 /**
@@ -1301,8 +1276,6 @@ err:
 static void qed_aio_next_io(QEDAIOCB *acb, int ret)
 {
     BDRVQEDState *s = acb_to_s(acb);
-    QEDFindClusterFunc *io_fn = (acb->flags & QED_AIOCB_WRITE) ?
-                                qed_aio_write_data : qed_aio_read_data;
     uint64_t offset;
     size_t len;
 
@@ -1333,7 +1306,24 @@ static void qed_aio_next_io(QEDAIOCB *acb, int ret)
     /* Find next cluster and start I/O */
     len = acb->end_pos - acb->cur_pos;
     ret = qed_find_cluster(s, &acb->request, acb->cur_pos, &len, &offset);
-    io_fn(acb, ret, offset, len);
+    if (ret < 0) {
+        qed_aio_complete(acb, ret);
+        return;
+    }
+
+    if (acb->flags & QED_AIOCB_WRITE) {
+        ret = qed_aio_write_data(acb, ret, offset, len);
+    } else {
+        ret = qed_aio_read_data(acb, ret, offset, len);
+    }
+
+    if (ret < 0) {
+        if (ret != -EINPROGRESS) {
+            qed_aio_complete(acb, ret);
+        }
+        return;
+    }
+    qed_aio_next_io(acb, 0);
 }
 
 static BlockAIOCB *qed_aio_setup(BlockDriverState *bs,
diff --git a/block/qed.h b/block/qed.h
index 51443fa..8644fed 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -177,27 +177,6 @@ enum {
     QED_CLUSTER_L1,            /* cluster missing in L1 */
 };
 
-/**
- * qed_find_cluster() completion callback
- *
- * @opaque:     User data for completion callback
- * @ret:        QED_CLUSTER_FOUND   Success
- *              QED_CLUSTER_L2      Data cluster unallocated in L2
- *              QED_CLUSTER_L1      L2 unallocated in L1
- *              -errno              POSIX error occurred
- * @offset:     Data cluster offset
- * @len:        Contiguous bytes starting from cluster offset
- *
- * This function is invoked when qed_find_cluster() completes.
- *
- * On success ret is QED_CLUSTER_FOUND and offset/len are a contiguous range
- * in the image file.
- *
- * On failure ret is QED_CLUSTER_L2 or QED_CLUSTER_L1 for missing L2 or L1
- * table offset, respectively.  len is number of contiguous unallocated bytes.
- */
-typedef void QEDFindClusterFunc(void *opaque, int ret, uint64_t offset, size_t len);
-
 void qed_acquire(BDRVQEDState *s);
 void qed_release(BDRVQEDState *s);
 
-- 
1.8.3.1
