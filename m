Received: from eggs.gnu.org ([2001:4830:134:3::10]:42432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f2q4h-0002Kf-F9
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 23:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f2q4e-0006Ee-Aa
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 23:24:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f2q4e-0006DL-69
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 23:24:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5759722E1
	for <qemu-devel@nongnu.org>; Mon,  2 Apr 2018 03:23:56 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Mon,  2 Apr 2018 11:23:36 +0800
Message-Id: <20180402032336.31834-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi-block: Handle error from host devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

The callback of blk_aio_ioctl is not sensible to SCSI errors, so
werror=stop doesn't work if ioctl returns 0 but the scsi status is
error.

Peek at the sg_io_hdr_t fields and amend ret to fix that.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/scsi-disk.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index f5ab767ab5..2c43830586 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2651,10 +2651,26 @@ typedef struct SCSIBlockReq {
     /* Selected bytes of the original CDB, copied into our own CDB.  */
     uint8_t cmd, cdb1, group_number;
 
+    BlockCompletionFunc *cb;
+    void *cb_opaque;
+
     /* CDB passed to SG_IO.  */
     uint8_t cdb[16];
 } SCSIBlockReq;
 
+static void scsi_block_sgio_cb(void *opaque, int ret)
+{
+    SCSIBlockReq *req = opaque;
+
+    if (!ret &&
+        (req->io_header.status ||
+         req->io_header.host_status ||
+         req->io_header.driver_status)) {
+        ret = -EIO;
+    }
+    req->cb(req->cb_opaque, ret);
+}
+
 static BlockAIOCB *scsi_block_do_sgio(SCSIBlockReq *req,
                                       int64_t offset, QEMUIOVector *iov,
                                       int direction,
@@ -2734,7 +2750,9 @@ static BlockAIOCB *scsi_block_do_sgio(SCSIBlockReq *req,
     io_header->usr_ptr = r;
     io_header->flags |= SG_FLAG_DIRECT_IO;
 
-    aiocb = blk_aio_ioctl(s->qdev.conf.blk, SG_IO, io_header, cb, opaque);
+    req->cb_opaque = opaque;
+    aiocb = blk_aio_ioctl(s->qdev.conf.blk, SG_IO, io_header,
+                          scsi_block_sgio_cb, req);
     assert(aiocb != NULL);
     return aiocb;
 }
-- 
2.14.3
