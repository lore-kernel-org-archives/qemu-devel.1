Received: from eggs.gnu.org ([2001:4830:134:3::10]:42205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBi-0002Bn-6y
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBf-000198-3z
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBe-00018F-Q8
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hcvn016318
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:17 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm514ww-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:17 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:16 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:12 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-19-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 18/67] scsi-disk: Cleaning up around tray open
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Fam Zheng <famz@redhat.com>

Even if tray is not open, it can be empty (blk_is_inserted() == false).
Handle both cases correctly by replacing the s->tray_open checks with
blk_is_available(), which is an AND of the two.

Also simplify successive checks of them into blk_is_available(), in a
couple cases.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <1473848224-24809-2-git-send-email-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit cd723b85601baa7a0eeffbac83421357a70d81ee)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/scsi-disk.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 0e1bb68..f1b115c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -396,7 +396,7 @@ static void scsi_read_data(SCSIRequest *req)
         return;
     }
 
-    if (s->tray_open) {
+    if (!blk_is_available(req->dev->conf.blk)) {
         scsi_read_complete(r, -ENOMEDIUM);
         return;
     }
@@ -519,7 +519,7 @@ static void scsi_write_data(SCSIRequest *req)
         scsi_write_complete_noio(r, 0);
         return;
     }
-    if (s->tray_open) {
+    if (!blk_is_available(req->dev->conf.blk)) {
         scsi_write_complete_noio(r, -ENOMEDIUM);
         return;
     }
@@ -792,10 +792,7 @@ static inline bool media_is_dvd(SCSIDiskState *s)
     if (s->qdev.type != TYPE_ROM) {
         return false;
     }
-    if (!blk_is_inserted(s->qdev.conf.blk)) {
-        return false;
-    }
-    if (s->tray_open) {
+    if (!blk_is_available(s->qdev.conf.blk)) {
         return false;
     }
     blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
@@ -808,10 +805,7 @@ static inline bool media_is_cd(SCSIDiskState *s)
     if (s->qdev.type != TYPE_ROM) {
         return false;
     }
-    if (!blk_is_inserted(s->qdev.conf.blk)) {
-        return false;
-    }
-    if (s->tray_open) {
+    if (!blk_is_available(s->qdev.conf.blk)) {
         return false;
     }
     blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
@@ -875,7 +869,7 @@ static int scsi_read_dvd_structure(SCSIDiskState *s, SCSIDiskReq *r,
     }
 
     if (format != 0xff) {
-        if (s->tray_open || !blk_is_inserted(s->qdev.conf.blk)) {
+        if (!blk_is_available(s->qdev.conf.blk)) {
             scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
             return -1;
         }
@@ -1857,7 +1851,7 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
         break;
 
     default:
-        if (s->tray_open || !blk_is_inserted(s->qdev.conf.blk)) {
+        if (!blk_is_available(s->qdev.conf.blk)) {
             scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
             return 0;
         }
@@ -1886,7 +1880,7 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
     memset(outbuf, 0, r->buflen);
     switch (req->cmd.buf[0]) {
     case TEST_UNIT_READY:
-        assert(!s->tray_open && blk_is_inserted(s->qdev.conf.blk));
+        assert(blk_is_available(s->qdev.conf.blk));
         break;
     case INQUIRY:
         buflen = scsi_disk_emulate_inquiry(req, outbuf);
@@ -2126,7 +2120,7 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
 
     command = buf[0];
 
-    if (s->tray_open || !blk_is_inserted(s->qdev.conf.blk)) {
+    if (!blk_is_available(s->qdev.conf.blk)) {
         scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
         return 0;
     }
-- 
1.9.1
