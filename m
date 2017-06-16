Received: from eggs.gnu.org ([2001:4830:134:3::10]:53345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCc-0006VA-R7
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCb-00026R-QV
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:34 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:37:06 +0200
Message-Id: <1497634636-20230-22-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 21/31] qed: Add return value to
 qed_aio_write_inplace/alloc()
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
 block/qed.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 84864e0..4c8ba4a 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1118,7 +1118,7 @@ static bool qed_should_set_need_check(BDRVQEDState *s)
  *
  * This path is taken when writing to previously unallocated clusters.
  */
-static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
+static int qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
 {
     BDRVQEDState *s = acb_to_s(acb);
     int ret;
@@ -1134,7 +1134,7 @@ static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
     }
     if (acb != QSIMPLEQ_FIRST(&s->allocating_write_reqs) ||
         s->allocating_write_reqs_plugged) {
-        return; /* wait for existing request to finish */
+        return -EINPROGRESS; /* wait for existing request to finish */
     }
 
     acb->cur_nclusters = qed_bytes_to_clusters(s,
@@ -1144,8 +1144,7 @@ static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
     if (acb->flags & QED_AIOCB_ZERO) {
         /* Skip ahead if the clusters are already zero */
         if (acb->find_cluster_ret == QED_CLUSTER_ZERO) {
-            qed_aio_start_io(acb);
-            return;
+            return 0;
         }
     } else {
         acb->cur_cluster = qed_alloc_clusters(s, acb->cur_nclusters);
@@ -1155,8 +1154,7 @@ static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
         s->header.features |= QED_F_NEED_CHECK;
         ret = qed_write_header(s);
         if (ret < 0) {
-            qed_aio_complete(acb, ret);
-            return;
+            return ret;
         }
     }
 
@@ -1166,10 +1164,9 @@ static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
         ret = qed_aio_write_cow(acb);
     }
     if (ret < 0) {
-        qed_aio_complete(acb, ret);
-        return;
+        return ret;
     }
-    qed_aio_next_io(acb, 0);
+    return 0;
 }
 
 /**
@@ -1181,10 +1178,8 @@ static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
  *
  * This path is taken when writing to already allocated clusters.
  */
-static void qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset, size_t len)
+static int qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset, size_t len)
 {
-    int ret;
-
     /* Allocate buffer for zero writes */
     if (acb->flags & QED_AIOCB_ZERO) {
         struct iovec *iov = acb->qiov->iov;
@@ -1192,8 +1187,7 @@ static void qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset, size_t len)
         if (!iov->iov_base) {
             iov->iov_base = qemu_try_blockalign(acb->common.bs, iov->iov_len);
             if (iov->iov_base == NULL) {
-                qed_aio_complete(acb, -ENOMEM);
-                return;
+                return -ENOMEM;
             }
             memset(iov->iov_base, 0, iov->iov_len);
         }
@@ -1204,12 +1198,7 @@ static void qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset, size_t len)
     qemu_iovec_concat(&acb->cur_qiov, acb->qiov, acb->qiov_offset, len);
 
     /* Do the actual write */
-    ret = qed_aio_write_main(acb);
-    if (ret < 0) {
-        qed_aio_complete(acb, ret);
-        return;
-    }
-    qed_aio_next_io(acb, 0);
+    return qed_aio_write_main(acb);
 }
 
 /**
@@ -1232,19 +1221,27 @@ static void qed_aio_write_data(void *opaque, int ret,
 
     switch (ret) {
     case QED_CLUSTER_FOUND:
-        qed_aio_write_inplace(acb, offset, len);
+        ret = qed_aio_write_inplace(acb, offset, len);
         break;
 
     case QED_CLUSTER_L2:
     case QED_CLUSTER_L1:
     case QED_CLUSTER_ZERO:
-        qed_aio_write_alloc(acb, len);
+        ret = qed_aio_write_alloc(acb, len);
         break;
 
     default:
-        qed_aio_complete(acb, ret);
+        assert(ret < 0);
         break;
     }
+
+    if (ret < 0) {
+        if (ret != -EINPROGRESS) {
+            qed_aio_complete(acb, ret);
+        }
+        return;
+    }
+    qed_aio_next_io(acb, 0);
 }
 
 /**
-- 
1.8.3.1
