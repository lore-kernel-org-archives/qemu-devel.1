Received: from eggs.gnu.org ([2001:4830:134:3::10]:53150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCL-0006CS-JD
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCK-0001jW-Fo
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:17 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:37:00 +0200
Message-Id: <1497634636-20230-16-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/31] qed: Make qed_aio_write_main()
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 61 +++++++++++++++++++------------------------------------------
 1 file changed, 19 insertions(+), 42 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index cfebbae..d164b0e 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -260,13 +260,6 @@ static void qed_aio_start_io(QEDAIOCB *acb)
     qed_aio_next_io(acb, 0);
 }
 
-static void qed_aio_next_io_cb(void *opaque, int ret)
-{
-    QEDAIOCB *acb = opaque;
-
-    qed_aio_next_io(acb, ret);
-}
-
 static void qed_plug_allocating_write_reqs(BDRVQEDState *s)
 {
     assert(!s->allocating_write_reqs_plugged);
@@ -1042,31 +1035,6 @@ err:
     qed_aio_complete(acb, ret);
 }
 
-static void qed_aio_write_l2_update_cb(void *opaque, int ret)
-{
-    QEDAIOCB *acb = opaque;
-    qed_aio_write_l2_update(acb, ret, acb->cur_cluster);
-}
-
-/**
- * Flush new data clusters before updating the L2 table
- *
- * This flush is necessary when a backing file is in use.  A crash during an
- * allocating write could result in empty clusters in the image.  If the write
- * only touched a subregion of the cluster, then backing image sectors have
- * been lost in the untouched region.  The solution is to flush after writing a
- * new data cluster and before updating the L2 table.
- */
-static void qed_aio_write_flush_before_l2_update(void *opaque, int ret)
-{
-    QEDAIOCB *acb = opaque;
-    BDRVQEDState *s = acb_to_s(acb);
-
-    if (!bdrv_aio_flush(s->bs->file->bs, qed_aio_write_l2_update_cb, opaque)) {
-        qed_aio_complete(acb, -EIO);
-    }
-}
-
 /**
  * Write data to the image file
  */
@@ -1076,7 +1044,6 @@ static void qed_aio_write_main(void *opaque, int ret)
     BDRVQEDState *s = acb_to_s(acb);
     uint64_t offset = acb->cur_cluster +
                       qed_offset_into_cluster(s, acb->cur_pos);
-    BlockCompletionFunc *next_fn;
 
     trace_qed_aio_write_main(s, acb, ret, offset, acb->cur_qiov.size);
 
@@ -1085,20 +1052,30 @@ static void qed_aio_write_main(void *opaque, int ret)
         return;
     }
 
+    BLKDBG_EVENT(s->bs->file, BLKDBG_WRITE_AIO);
+    ret = bdrv_pwritev(s->bs->file, offset, &acb->cur_qiov);
+    if (ret >= 0) {
+        ret = 0;
+    }
+
     if (acb->find_cluster_ret == QED_CLUSTER_FOUND) {
-        next_fn = qed_aio_next_io_cb;
+        qed_aio_next_io(acb, ret);
     } else {
         if (s->bs->backing) {
-            next_fn = qed_aio_write_flush_before_l2_update;
-        } else {
-            next_fn = qed_aio_write_l2_update_cb;
+            /*
+             * Flush new data clusters before updating the L2 table
+             *
+             * This flush is necessary when a backing file is in use.  A crash
+             * during an allocating write could result in empty clusters in the
+             * image.  If the write only touched a subregion of the cluster,
+             * then backing image sectors have been lost in the untouched
+             * region.  The solution is to flush after writing a new data
+             * cluster and before updating the L2 table.
+             */
+            ret = bdrv_flush(s->bs->file->bs);
         }
+        qed_aio_write_l2_update(acb, ret, acb->cur_cluster);
     }
-
-    BLKDBG_EVENT(s->bs->file, BLKDBG_WRITE_AIO);
-    bdrv_aio_writev(s->bs->file, offset / BDRV_SECTOR_SIZE,
-                    &acb->cur_qiov, acb->cur_qiov.size / BDRV_SECTOR_SIZE,
-                    next_fn, acb);
 }
 
 /**
-- 
1.8.3.1
