Received: from eggs.gnu.org ([2001:4830:134:3::10]:36947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3XW6-0007QX-8c
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 21:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3XW3-0003YY-6J
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 21:47:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46212 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f3XW3-0003YJ-1f
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 21:47:11 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  4 Apr 2018 09:47:02 +0800
Message-Id: <20180404014702.16099-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] scsi-block: Handle error from host devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

The callback of blk_aio_ioctl is not sensible to SCSI errors, so
werror=stop doesn't work if ioctl returns 0 but the scsi status is
error.

Peek at the sg_io_hdr_t fields and amend ret to fix that.

Signed-off-by: Fam Zheng <famz@redhat.com>

---

v2: Fix ->cb. [Daniel]
---
 hw/scsi/scsi-disk.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index f5ab767ab5..9cb08ff491 100644
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
@@ -2734,7 +2750,10 @@ static BlockAIOCB *scsi_block_do_sgio(SCSIBlockReq *req,
     io_header->usr_ptr = r;
     io_header->flags |= SG_FLAG_DIRECT_IO;
 
-    aiocb = blk_aio_ioctl(s->qdev.conf.blk, SG_IO, io_header, cb, opaque);
+    req->cb = cb;
+    req->cb_opaque = opaque;
+    aiocb = blk_aio_ioctl(s->qdev.conf.blk, SG_IO, io_header,
+                          scsi_block_sgio_cb, req);
     assert(aiocb != NULL);
     return aiocb;
 }
-- 
2.14.3
