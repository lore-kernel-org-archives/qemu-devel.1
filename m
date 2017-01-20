Received: from eggs.gnu.org ([2001:4830:134:3::10]:45397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHu-0003CV-Ij
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHp-0003CI-Gf
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcHp-0003Bw-8E
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:37 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EDF0274870
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:43:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 17:43:14 +0100
Message-Id: <20170120164322.21851-10-pbonzini@redhat.com>
In-Reply-To: <20170120164322.21851-1-pbonzini@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/17] qed: introduce qed_aio_start_io and
 qed_aio_next_io_cb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com

qed_aio_start_io and qed_aio_next_io will not have to acquire/release
the AioContext, while qed_aio_next_io_cb will.  Split the functionality
and gain a little type-safety in the process.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qed.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 1a7ef0a..7f1c508 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -273,7 +273,19 @@ static CachedL2Table *qed_new_l2_table(BDRVQEDState *s)
     return l2_table;
 }
 
-static void qed_aio_next_io(void *opaque, int ret);
+static void qed_aio_next_io(QEDAIOCB *acb, int ret);
+
+static void qed_aio_start_io(QEDAIOCB *acb)
+{
+    qed_aio_next_io(acb, 0);
+}
+
+static void qed_aio_next_io_cb(void *opaque, int ret)
+{
+    QEDAIOCB *acb = opaque;
+
+    qed_aio_next_io(acb, ret);
+}
 
 static void qed_plug_allocating_write_reqs(BDRVQEDState *s)
 {
@@ -292,7 +304,7 @@ static void qed_unplug_allocating_write_reqs(BDRVQEDState *s)
 
     acb = QSIMPLEQ_FIRST(&s->allocating_write_reqs);
     if (acb) {
-        qed_aio_next_io(acb, 0);
+        qed_aio_start_io(acb);
     }
 }
 
@@ -959,7 +971,7 @@ static void qed_aio_complete(QEDAIOCB *acb, int ret)
         QSIMPLEQ_REMOVE_HEAD(&s->allocating_write_reqs, next);
         acb = QSIMPLEQ_FIRST(&s->allocating_write_reqs);
         if (acb) {
-            qed_aio_next_io(acb, 0);
+            qed_aio_start_io(acb);
         } else if (s->header.features & QED_F_NEED_CHECK) {
             qed_start_need_check_timer(s);
         }
@@ -984,7 +996,7 @@ static void qed_commit_l2_update(void *opaque, int ret)
     acb->request.l2_table = qed_find_l2_cache_entry(&s->l2_cache, l2_offset);
     assert(acb->request.l2_table != NULL);
 
-    qed_aio_next_io(opaque, ret);
+    qed_aio_next_io(acb, ret);
 }
 
 /**
@@ -1032,11 +1044,11 @@ static void qed_aio_write_l2_update(QEDAIOCB *acb, int ret, uint64_t offset)
     if (need_alloc) {
         /* Write out the whole new L2 table */
         qed_write_l2_table(s, &acb->request, 0, s->table_nelems, true,
-                            qed_aio_write_l1_update, acb);
+                           qed_aio_write_l1_update, acb);
     } else {
         /* Write out only the updated part of the L2 table */
         qed_write_l2_table(s, &acb->request, index, acb->cur_nclusters, false,
-                            qed_aio_next_io, acb);
+                           qed_aio_next_io_cb, acb);
     }
     return;
 
@@ -1088,7 +1100,7 @@ static void qed_aio_write_main(void *opaque, int ret)
     }
 
     if (acb->find_cluster_ret == QED_CLUSTER_FOUND) {
-        next_fn = qed_aio_next_io;
+        next_fn = qed_aio_next_io_cb;
     } else {
         if (s->bs->backing) {
             next_fn = qed_aio_write_flush_before_l2_update;
@@ -1201,7 +1213,7 @@ static void qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
     if (acb->flags & QED_AIOCB_ZERO) {
         /* Skip ahead if the clusters are already zero */
         if (acb->find_cluster_ret == QED_CLUSTER_ZERO) {
-            qed_aio_next_io(acb, 0);
+            qed_aio_start_io(acb);
             return;
         }
 
@@ -1321,18 +1333,18 @@ static void qed_aio_read_data(void *opaque, int ret,
     /* Handle zero cluster and backing file reads */
     if (ret == QED_CLUSTER_ZERO) {
         qemu_iovec_memset(&acb->cur_qiov, 0, 0, acb->cur_qiov.size);
-        qed_aio_next_io(acb, 0);
+        qed_aio_start_io(acb);
         return;
     } else if (ret != QED_CLUSTER_FOUND) {
         qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov,
-                              &acb->backing_qiov, qed_aio_next_io, acb);
+                              &acb->backing_qiov, qed_aio_next_io_cb, acb);
         return;
     }
 
     BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
     bdrv_aio_readv(bs->file, offset / BDRV_SECTOR_SIZE,
                    &acb->cur_qiov, acb->cur_qiov.size / BDRV_SECTOR_SIZE,
-                   qed_aio_next_io, acb);
+                   qed_aio_next_io_cb, acb);
     return;
 
 err:
@@ -1342,9 +1354,8 @@ err:
 /**
  * Begin next I/O or complete the request
  */
-static void qed_aio_next_io(void *opaque, int ret)
+static void qed_aio_next_io(QEDAIOCB *acb, int ret)
 {
-    QEDAIOCB *acb = opaque;
     BDRVQEDState *s = acb_to_s(acb);
     QEDFindClusterFunc *io_fn = (acb->flags & QED_AIOCB_WRITE) ?
                                 qed_aio_write_data : qed_aio_read_data;
@@ -1400,7 +1411,7 @@ static BlockAIOCB *qed_aio_setup(BlockDriverState *bs,
     qemu_iovec_init(&acb->cur_qiov, qiov->niov);
 
     /* Start request */
-    qed_aio_next_io(acb, 0);
+    qed_aio_start_io(acb);
     return &acb->common;
 }
 
-- 
2.9.3
