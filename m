Received: from eggs.gnu.org ([2001:4830:134:3::10]:52802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvBy-0005pO-4P
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvBx-0001Lb-3N
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:37:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:36:51 +0200
Message-Id: <1497634636-20230-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/31] qed: Make qed_read_backing_file()
 synchronous
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

Note that this code is generally not running in coroutine context, so
this is an actual blocking synchronous operation. We'll fix this in a
moment.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 290cbcd..1105f19 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -808,13 +808,13 @@ static BDRVQEDState *acb_to_s(QEDAIOCB *acb)
  * This function reads qiov->size bytes starting at pos from the backing file.
  * If there is no backing file then zeroes are read.
  */
-static void qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
-                                  QEMUIOVector *qiov,
-                                  QEMUIOVector **backing_qiov,
-                                  BlockCompletionFunc *cb, void *opaque)
+static int qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
+                                 QEMUIOVector *qiov,
+                                 QEMUIOVector **backing_qiov)
 {
     uint64_t backing_length = 0;
     size_t size;
+    int ret;
 
     /* If there is a backing file, get its length.  Treat the absence of a
      * backing file like a zero length backing file.
@@ -822,8 +822,7 @@ static void qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
     if (s->bs->backing) {
         int64_t l = bdrv_getlength(s->bs->backing->bs);
         if (l < 0) {
-            cb(opaque, l);
-            return;
+            return l;
         }
         backing_length = l;
     }
@@ -836,8 +835,7 @@ static void qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
 
     /* Complete now if there are no backing file sectors to read */
     if (pos >= backing_length) {
-        cb(opaque, 0);
-        return;
+        return 0;
     }
 
     /* If the read straddles the end of the backing file, shorten it */
@@ -849,8 +847,11 @@ static void qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
     qemu_iovec_concat(*backing_qiov, qiov, 0, size);
 
     BLKDBG_EVENT(s->bs->file, BLKDBG_READ_BACKING_AIO);
-    bdrv_aio_readv(s->bs->backing, pos / BDRV_SECTOR_SIZE,
-                   *backing_qiov, size / BDRV_SECTOR_SIZE, cb, opaque);
+    ret = bdrv_preadv(s->bs->backing, pos, *backing_qiov);
+    if (ret < 0) {
+        return ret;
+    }
+    return 0;
 }
 
 typedef struct {
@@ -907,6 +908,7 @@ static void qed_copy_from_backing_file(BDRVQEDState *s, uint64_t pos,
                                        void *opaque)
 {
     CopyFromBackingFileCB *copy_cb;
+    int ret;
 
     /* Skip copy entirely if there is no work to do */
     if (len == 0) {
@@ -922,8 +924,9 @@ static void qed_copy_from_backing_file(BDRVQEDState *s, uint64_t pos,
     copy_cb->iov.iov_len = len;
     qemu_iovec_init_external(&copy_cb->qiov, &copy_cb->iov, 1);
 
-    qed_read_backing_file(s, pos, &copy_cb->qiov, &copy_cb->backing_qiov,
-                          qed_copy_from_backing_file_write, copy_cb);
+    ret = qed_read_backing_file(s, pos, &copy_cb->qiov,
+                                &copy_cb->backing_qiov);
+    qed_copy_from_backing_file_write(copy_cb, ret);
 }
 
 /**
@@ -1366,8 +1369,9 @@ static void qed_aio_read_data(void *opaque, int ret,
         qed_aio_start_io(acb);
         return;
     } else if (ret != QED_CLUSTER_FOUND) {
-        qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov,
-                              &acb->backing_qiov, qed_aio_next_io_cb, acb);
+        ret = qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov,
+                                    &acb->backing_qiov);
+        qed_aio_next_io(acb, ret);
         return;
     }
 
-- 
1.8.3.1
