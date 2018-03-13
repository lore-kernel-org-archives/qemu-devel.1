Received: from eggs.gnu.org ([2001:4830:134:3::10]:38901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1evn1j-0006oQ-Du
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1evn1e-0007dH-CV
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:43:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38270
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1evn1e-0007cz-68
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:43:46 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2DGeWHg056643
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 12:43:45 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gph28v6r6-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 12:43:44 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 13 Mar 2018 10:43:44 -0600
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 13:43:34 -0300
Message-Id: <20180313164334.20340-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/1] hw/scsi: support SCSI-2 passthrough
 without PI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

QEMU SCSI code makes assumptions about how the PROTECT and BYTCHK
works in the protocol, denying support for PI (Protection
Information) in case the guest OS requests it. However, in SCSI versions 2
and older, there is no PI concept in the protocol.

This means that when dealing with such devices:

- there is no PROTECT bit in byte 5 of the standard INQUIRY response. The
whole byte is marked as "Reserved";

- there is no RDPROTECT in byte 2 of READ. We have 'Logical Unit Number'
in this field instead;

- there is no VRPROTECT in byte 2 of VERIFY. We have 'Logical Unit Number'
in this field instead. This also means that the BYTCHK bit in this case
is not related to PI.

Since QEMU does not consider these changes, a SCSI passthrough using
a SCSI-2 device will not work. It will mistake these fields with
PI information and return Illegal Request SCSI SENSE thinking
that the driver is asking for PI support.

This patch fixes it by adding a new attribute called 'scsi_version'
that is read from the standard INQUIRY response of passthrough
devices. This allows for a version verification before applying
conditions related to PI that doesn't apply for older versions.

Reported-by: Dac Nguyen <dacng@us.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---

Changes in v2:
- removed "scsi_version" as a property
- scsi_version is now initialized with -1 in scsi_realize (that is
used by scsi_hd_realize, scsi_cd_realize, scsi_disk_realize and
scsi_block_realize) and scsi_generic_realize


 hw/scsi/scsi-disk.c    | 14 +++++++++++---
 hw/scsi/scsi-generic.c | 42 +++++++++++++++++++++++++++++++-----------
 include/hw/scsi/scsi.h |  1 +
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 49d2559d93..80b1eb92ae 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2176,7 +2176,7 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
     case READ_12:
     case READ_16:
         DPRINTF("Read (sector %" PRId64 ", count %u)\n", r->req.cmd.lba, len);
-        if (r->req.cmd.buf[1] & 0xe0) {
+        if ((r->req.cmd.buf[1] & 0xe0) && (s->qdev.scsi_version > 2)) {
             goto illegal_request;
         }
         if (!check_lba_range(s, r->req.cmd.lba, len)) {
@@ -2206,8 +2206,12 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
         /* We get here only for BYTCHK == 0x01 and only for scsi-block.
          * As far as DMA is concerned, we can treat it the same as a write;
          * scsi_block_do_sgio will send VERIFY commands.
+         *
+         * For scsi versions 2 and older, the BYTCHK isn't related
+         * to VRPROTECT (in fact, there is no VRPROTECT). Skip
+         * this check in these versions.
          */
-        if (r->req.cmd.buf[1] & 0xe0) {
+        if ((r->req.cmd.buf[1] & 0xe0) && (s->qdev.scsi_version > 2)) {
             goto illegal_request;
         }
         if (!check_lba_range(s, r->req.cmd.lba, len)) {
@@ -2383,6 +2387,8 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
         return;
     }
 
+    dev->scsi_version = -1;
+
     if ((s->features & (1 << SCSI_DISK_F_REMOVABLE)) &&
             !(s->features & (1 << SCSI_DISK_F_NO_REMOVABLE_DEVOPS))) {
         blk_set_dev_ops(s->qdev.conf.blk, &scsi_disk_removable_block_ops, s);
@@ -2796,6 +2802,8 @@ static bool scsi_block_is_passthrough(SCSIDiskState *s, uint8_t *buf)
 static int32_t scsi_block_dma_command(SCSIRequest *req, uint8_t *buf)
 {
     SCSIBlockReq *r = (SCSIBlockReq *)req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
     r->cmd = req->cmd.buf[0];
     switch (r->cmd >> 5) {
     case 0:
@@ -2821,7 +2829,7 @@ static int32_t scsi_block_dma_command(SCSIRequest *req, uint8_t *buf)
         abort();
     }
 
-    if (r->cdb1 & 0xe0) {
+    if ((r->cdb1 & 0xe0) && (s->qdev.scsi_version > 2)) {
         /* Protection information is not supported.  */
         scsi_check_condition(&r->req, SENSE_CODE(INVALID_FIELD));
         return 0;
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 7414fe2d67..5cc5598983 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -194,17 +194,35 @@ static void scsi_read_complete(void * opaque, int ret)
             r->buf[3] |= 0x80;
         }
     }
-    if (s->type == TYPE_DISK &&
-        r->req.cmd.buf[0] == INQUIRY &&
-        r->req.cmd.buf[2] == 0xb0) {
-        uint32_t max_transfer =
-            blk_get_max_transfer(s->conf.blk) / s->blocksize;
-
-        assert(max_transfer);
-        stl_be_p(&r->buf[8], max_transfer);
-        /* Also take care of the opt xfer len. */
-        stl_be_p(&r->buf[12],
-                 MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+    if (r->req.cmd.buf[0] == INQUIRY) {
+        /*
+         *  EVPD set to zero returns the standard INQUIRY data.
+         *
+         *  Check if scsi_version is unset (-1) to avoid re-defining it
+         *  each time an INQUIRY with standard data is received.
+         *
+         *  On SCSI-2 and older, first 3 bits of byte 2 is the
+         *  ANSI-approved version, while on later versions the
+         *  whole byte 2 contains the version. Check if we're dealing
+         *  with a newer version and, in that case, assign the
+         *  whole byte.
+         */
+        if ((s->scsi_version == -1) && ((r->req.cmd.buf[1] & 0x01) == 0)) {
+            s->scsi_version = r->buf[2] & 0x07;
+            if (s->scsi_version > 2) {
+                s->scsi_version = r->buf[2];
+            }
+        }
+        if (s->type == TYPE_DISK && r->req.cmd.buf[2] == 0xb0) {
+            uint32_t max_transfer =
+                blk_get_max_transfer(s->conf.blk) / s->blocksize;
+
+            assert(max_transfer);
+            stl_be_p(&r->buf[8], max_transfer);
+            /* Also take care of the opt xfer len. */
+            stl_be_p(&r->buf[12],
+                     MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+        }
     }
     scsi_req_data(&r->req, len);
     scsi_req_unref(&r->req);
@@ -525,6 +543,8 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
     s->type = scsiid.scsi_type;
     DPRINTF("device type %d\n", s->type);
 
+    s->scsi_version = -1;
+
     switch (s->type) {
     case TYPE_TAPE:
         s->blocksize = get_stream_blocksize(s->conf.blk);
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 7ecaddac9d..a698c7f60c 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -85,6 +85,7 @@ struct SCSIDevice
     uint64_t max_lba;
     uint64_t wwn;
     uint64_t port_wwn;
+    int scsi_version;
 };
 
 extern const VMStateDescription vmstate_scsi_device;
-- 
2.14.3
