Received: from eggs.gnu.org ([209.51.188.92]:47434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wim-0003wM-4u
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wil-0000cW-94
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:40 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:34141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2Wil-0000bd-13
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:39 -0500
Received: by mail-wr1-x42d.google.com with SMTP id f14so23644671wrg.1
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:48:12 +0100
Message-Id: <1552117698-12355-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/25] scsi-disk: Fix crash if request is
 invaild or disk is no medium
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhengui Li <lizhengui@huawei.com>

From: Zhengui Li <lizhengui@huawei.com>

Qemu will crash with the assertion error that "assert(r->req.aiocb !=
NULL)" in scsi_read_complete if request is invaild or disk is no medium.
The error is below:
qemu-kvm: hw/scsi/scsi_disk.c:299: scsi_read_complete: Assertion
`r->req.aiocb != NULL' failed.

This patch add a funtion scsi_read_complete_noio to fix it.

Signed-off-by: Zhengui Li <lizhengui@huawei.com>
Message-Id: <1551949966-20092-1-git-send-email-lizhengui@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index d4e83ae..e7e865a 100644
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
+    assert(r->req.aiocb == NULL);
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
+static void scsi_read_complete(void *opaque, int ret)
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
1.8.3.1
