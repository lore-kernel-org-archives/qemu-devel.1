Received: from eggs.gnu.org ([209.51.188.92]:48256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1h1oql-0002te-GZ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1h1oqk-0006mp-L5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:57:59 -0500
From: Zhengui li <lizhengui@huawei.com>
Date: Thu, 7 Mar 2019 16:57:17 +0800
Message-ID: <1551949037-15528-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] scsi-disk: Fix crash if request is invaild or
 disk is no medium
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com
Cc: lizhengui@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com, wangjie88@huawei.com, zhengxiang9@huawei.com

From: Zhengui Li <lizhengui@huawei.com>

Qemu will crash with the assertion error that "assert(r->req.aiocb !=
NULL)" in scsi_read_complete if request is invaild or disk is no medium.
The error is below:
qemu-kvm: hw/scsi/scsi_disk.c:299: scsi_read_complete: Assertion
`r->req.aiocb != NULL' failed.

This patch add a funtion scsi_read_complete_noio to fix it.

Signed-off-by: Zhengui Li <lizhengui@huawei.com>
---
 hw/scsi/scsi-disk.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index d4e83ae..624df3c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -296,22 +296,15 @@ static void scsi_dma_complete(void *opaque, int ret)
     aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
-static void scsi_read_complete(void * opaque, int ret)
+static void scsi_read_complete_noio(SCSIDiskReq *r, int ret)
 {
-    SCSIDiskReq *r = (SCSIDiskReq *)opaque;
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-    int n;
+    uint32_t n;
 
-    assert(r->req.aiocb != NULL);
-    r->req.aiocb = NULL;
-    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
-    if (scsi_disk_req_check_error(r, ret, true)) {
+    assert (r->req.aiocb == NULL);
+    if (scsi_disk_req_check_error(r, ret, false)) {
         goto done;
     }
 
-    block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
-    trace_scsi_disk_read_complete(r->req.tag, r->qiov.size);
-
     n = r->qiov.size / 512;
     r->sector += n;
     r->sector_count -= n;
@@ -319,6 +312,24 @@ static void scsi_read_complete(void * opaque, int ret)
 
 done:
     scsi_req_unref(&r->req);
+}
+
+static void scsi_read_complete(void * opaque, int ret)
+{
+    SCSIDiskReq *r = (SCSIDiskReq *)opaque;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    assert(r->req.aiocb != NULL);
+    r->req.aiocb = NULL;
+
+    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
+    if (ret < 0) {
+        block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
+    } else {
+        block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
+        trace_scsi_disk_read_complete(r->req.tag, r->qiov.size);
+    }
+    scsi_read_complete_noio(r, ret);
     aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
@@ -395,12 +406,12 @@ static void scsi_read_data(SCSIRequest *req)
     scsi_req_ref(&r->req);
     if (r->req.cmd.mode == SCSI_XFER_TO_DEV) {
         trace_scsi_disk_read_data_invalid();
-        scsi_read_complete(r, -EINVAL);
+        scsi_read_complete_noio(r, -EINVAL);
         return;
     }
 
     if (!blk_is_available(req->dev->conf.blk)) {
-        scsi_read_complete(r, -ENOMEDIUM);
+        scsi_read_complete_noio(r, -ENOMEDIUM);
         return;
     }
 
-- 
2.7.2.windows.1
