Received: from eggs.gnu.org ([2001:4830:134:3::10]:39606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1d97hB-00051i-1J
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1d97h8-00064o-2E
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39441 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1d97h7-0005z7-NW
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:09 -0400
From: Hannes Reinecke <hare@suse.de>
Date: Fri, 12 May 2017 12:20:56 +0200
Message-Id: <20170512102057.5855-4-hare@suse.de>
In-Reply-To: <20170512102057.5855-1-hare@suse.de>
References: <20170512102057.5855-1-hare@suse.de>
Subject: [Qemu-devel] [PATCH 3/4] scsi: per-request timeouts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.com>, qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

Add a 'timeout' value per request to allow to specify individual
per-request timeouts.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/scsi-bus.c     |  1 +
 hw/scsi/scsi-disk.c    | 15 +++++++++++----
 hw/scsi/scsi-generic.c | 12 ++++++++----
 include/hw/scsi/scsi.h |  1 +
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f5574469c8..206000d873 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -690,6 +690,7 @@ SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint32_t lun,
 
     req->cmd = cmd;
     req->resid = req->cmd.xfer;
+    req->timeout = d->timeout;
 
     switch (buf[0]) {
     case INQUIRY:
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4ac4c872fe..6a6f091a9c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2503,7 +2503,9 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
         printf("\n");
     }
 #endif
-
+    if (req) {
+        req->timeout = d->timeout;
+    }
     return req;
 }
 
@@ -2679,7 +2681,7 @@ static BlockAIOCB *scsi_block_do_sgio(SCSIBlockReq *req,
     /* The rest is as in scsi-generic.c.  */
     io_header->mx_sb_len = sizeof(r->req.sense);
     io_header->sbp = r->req.sense;
-    io_header->timeout = s->qdev.timeout;
+    io_header->timeout = r->req.timeout;
     io_header->usr_ptr = r;
     io_header->flags |= SG_FLAG_DIRECT_IO;
 
@@ -2812,14 +2814,19 @@ static SCSIRequest *scsi_block_new_request(SCSIDevice *d, uint32_t tag,
                                            void *hba_private)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, d);
+    struct SCSIRequest *req;
 
     if (scsi_block_is_passthrough(s, buf)) {
-        return scsi_req_alloc(&scsi_generic_req_ops, &s->qdev, tag, lun,
+        req = scsi_req_alloc(&scsi_generic_req_ops, &s->qdev, tag, lun,
                               hba_private);
     } else {
-        return scsi_req_alloc(&scsi_block_dma_reqops, &s->qdev, tag, lun,
+        req = scsi_req_alloc(&scsi_block_dma_reqops, &s->qdev, tag, lun,
                               hba_private);
     }
+    if (req) {
+        req->timeout = d->timeout;
+    }
+    return req;
 }
 
 static int scsi_block_parse_cdb(SCSIDevice *d, SCSICommand *cmd,
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 998b6a4558..31c3a75bad 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -157,8 +157,6 @@ static int execute_command(BlockBackend *blk,
                            SCSIGenericReq *r, int direction,
                            BlockCompletionFunc *complete)
 {
-    SCSIDevice *s = r->req.dev;
-
     r->io_header.interface_id = 'S';
     r->io_header.dxfer_direction = direction;
     r->io_header.dxferp = r->buf;
@@ -167,7 +165,7 @@ static int execute_command(BlockBackend *blk,
     r->io_header.cmd_len = r->req.cmd.len;
     r->io_header.mx_sb_len = sizeof(r->req.sense);
     r->io_header.sbp = r->req.sense;
-    r->io_header.timeout = s->timeout;
+    r->io_header.timeout = r->req.timeout;
     r->io_header.usr_ptr = r;
     r->io_header.flags |= SG_FLAG_DIRECT_IO;
 
@@ -596,7 +594,13 @@ const SCSIReqOps scsi_generic_req_ops = {
 static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
                                      uint8_t *buf, void *hba_private)
 {
-    return scsi_req_alloc(&scsi_generic_req_ops, d, tag, lun, hba_private);
+    struct SCSIRequest *req;
+
+    req = scsi_req_alloc(&scsi_generic_req_ops, d, tag, lun, hba_private);
+    if (req) {
+        req->timeout = d->timeout;
+    }
+    return req;
 }
 
 static Property scsi_generic_properties[] = {
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index a976e85cfa..6c51ddc3ef 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -51,6 +51,7 @@ struct SCSIRequest {
     uint32_t          tag;
     uint32_t          lun;
     uint32_t          status;
+    uint32_t          timeout;
     void              *hba_private;
     size_t            resid;
     SCSICommand       cmd;
-- 
2.12.0
