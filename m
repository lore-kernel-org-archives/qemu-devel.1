Received: from eggs.gnu.org ([2001:4830:134:3::10]:59668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deepa.srinivasan@oracle.com>) id 1eHX3w-0000vA-Tw
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deepa.srinivasan@oracle.com>) id 1eHX3s-0001Rz-QY
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:35:44 -0500
From: Deepa Srinivasan <deepa.srinivasan@oracle.com>
Date: Wed, 22 Nov 2017 07:33:28 -0800
Message-Id: <1511364808-30171-1-git-send-email-deepa.srinivasan@oracle.com>
Subject: [Qemu-devel] [PATCH] block: Fix qemu crash when using scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mark.kanda@oracle.com
Cc: Deepa Srinivasan <deepa.srinivasan@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Starting qemu with the following arguments causes qemu to segfault:
... -device lsi,id=lsi0 -drive file=iscsi:<...>,format=raw,if=none,node-name=
iscsi1 -device scsi-block,bus=lsi0.0,id=<...>,drive=iscsi1

This patch fixes blk_aio_ioctl() so it does not pass stack addresses to
blk_aio_ioctl_entry() which may be invoked after blk_aio_ioctl() returns. More
details about the bug follow.

blk_aio_ioctl() invokes blk_aio_prwv() with blk_aio_ioctl_entry as the
coroutine parameter. blk_aio_prwv() ultimately calls aio_co_enter().

When blk_aio_ioctl() is executed from within a coroutine context (e.g.
iscsi_bh_cb()), aio_co_enter() adds the coroutine (blk_aio_ioctl_entry) to
the current coroutine's wakeup queue. blk_aio_ioctl() then returns.

When blk_aio_ioctl_entry() executes later, it accesses an invalid pointer:
....
    BlkRwCo *rwco = &acb->rwco;

    rwco->ret = blk_co_ioctl(rwco->blk, rwco->offset,
                             rwco->qiov->iov[0].iov_base);  <--- qiov is
                                                                 invalid here
...

In the case when blk_aio_ioctl() is called from a non-coroutine context,
blk_aio_ioctl_entry() executes immediately. But if bdrv_co_ioctl() calls
qemu_coroutine_yield(), blk_aio_ioctl() will return. When the coroutine
execution is complete, control returns to blk_aio_ioctl_entry() after the call
to blk_co_ioctl(). There is no invalid reference after this point, but the
function is still holding on to invalid pointers.

The fix is to allocate memory for the QEMUIOVector and struct iovec as part of
the request struct which the IO buffer is part of. The memory for this struct is
guaranteed to be valid till the AIO is completed.

Signed-off-by: Deepa Srinivasan <deepa.srinivasan@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
---
 block/block-backend.c          | 13 ++-----------
 hw/block/virtio-blk.c          |  9 ++++++++-
 hw/scsi/scsi-disk.c            | 10 +++++++++-
 hw/scsi/scsi-generic.c         |  9 ++++++++-
 include/sysemu/block-backend.h |  2 +-
 5 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index baef8e7..c275827 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1472,19 +1472,10 @@ static void blk_aio_ioctl_entry(void *opaque)
     blk_aio_complete(acb);
 }
 
-BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
+BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, QEMUIOVector *qiov,
                           BlockCompletionFunc *cb, void *opaque)
 {
-    QEMUIOVector qiov;
-    struct iovec iov;
-
-    iov = (struct iovec) {
-        .iov_base = buf,
-        .iov_len = 0,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
-
-    return blk_aio_prwv(blk, req, 0, &qiov, blk_aio_ioctl_entry, 0, cb, opaque);
+    return blk_aio_prwv(blk, req, 0, qiov, blk_aio_ioctl_entry, 0, cb, opaque);
 }
 
 int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 05d1440..ed9f774 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -151,6 +151,8 @@ out:
 typedef struct {
     VirtIOBlockReq *req;
     struct sg_io_hdr hdr;
+    QEMUIOVector qiov;
+    struct iovec iov;
 } VirtIOBlockIoctlReq;
 
 static void virtio_blk_ioctl_complete(void *opaque, int status)
@@ -298,7 +300,12 @@ static int virtio_blk_handle_scsi_req(VirtIOBlockReq *req)
     ioctl_req->hdr.sbp = elem->in_sg[elem->in_num - 3].iov_base;
     ioctl_req->hdr.mx_sb_len = elem->in_sg[elem->in_num - 3].iov_len;
 
-    acb = blk_aio_ioctl(blk->blk, SG_IO, &ioctl_req->hdr,
+    ioctl_req->iov.iov_base = &ioctl_req->hdr;
+    ioctl_req->iov.iov_len = 0;
+
+    qemu_iovec_init_external(&ioctl_req->qiov, &ioctl_req->iov, 1);
+
+    acb = blk_aio_ioctl(blk->blk, SG_IO, &ioctl_req->qiov,
                         virtio_blk_ioctl_complete, ioctl_req);
     if (!acb) {
         g_free(ioctl_req);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 1243117..7cbe18d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2636,6 +2636,9 @@ typedef struct SCSIBlockReq {
     SCSIDiskReq req;
     sg_io_hdr_t io_header;
 
+    QEMUIOVector qiov;
+    struct iovec iov;
+
     /* Selected bytes of the original CDB, copied into our own CDB.  */
     uint8_t cmd, cdb1, group_number;
 
@@ -2722,7 +2725,12 @@ static BlockAIOCB *scsi_block_do_sgio(SCSIBlockReq *req,
     io_header->usr_ptr = r;
     io_header->flags |= SG_FLAG_DIRECT_IO;
 
-    aiocb = blk_aio_ioctl(s->qdev.conf.blk, SG_IO, io_header, cb, opaque);
+    req->iov.iov_base = io_header;
+    req->iov.iov_len = 0;
+
+    qemu_iovec_init_external(&req->qiov, &req->iov, 1);
+
+    aiocb = blk_aio_ioctl(s->qdev.conf.blk, SG_IO, &req->qiov, cb, opaque);
     assert(aiocb != NULL);
     return aiocb;
 }
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index bd0d9ff..856af7c 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -46,6 +46,8 @@ typedef struct SCSIGenericReq {
     int buflen;
     int len;
     sg_io_hdr_t io_header;
+    QEMUIOVector qiov;
+    struct iovec iov;
 } SCSIGenericReq;
 
 static void scsi_generic_save_request(QEMUFile *f, SCSIRequest *req)
@@ -135,7 +137,12 @@ static int execute_command(BlockBackend *blk,
     r->io_header.usr_ptr = r;
     r->io_header.flags |= SG_FLAG_DIRECT_IO;
 
-    r->req.aiocb = blk_aio_ioctl(blk, SG_IO, &r->io_header, complete, r);
+    r->iov.iov_base = &r->io_header;
+    r->iov.iov_len = 0;
+
+    qemu_iovec_init_external(&r->qiov, &r->iov, 1);
+
+    r->req.aiocb = blk_aio_ioctl(blk, SG_IO, &r->qiov, complete, r);
     if (r->req.aiocb == NULL) {
         return -EIO;
     }
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index c4e52a5..32f4486 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -151,7 +151,7 @@ void blk_aio_cancel(BlockAIOCB *acb);
 void blk_aio_cancel_async(BlockAIOCB *acb);
 int blk_co_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
 int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
-BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
+BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, QEMUIOVector *qiov,
                           BlockCompletionFunc *cb, void *opaque);
 int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
 int blk_co_flush(BlockBackend *blk);
-- 
2.7.4
