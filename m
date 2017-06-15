Received: from eggs.gnu.org ([2001:4830:134:3::10]:40867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP3-0008Ec-3U
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP0-0007YO-Nu
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:29 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSP0-0007Y9-F9
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:26 -0400
Received: by mail-wr0-x243.google.com with SMTP id x23so2767646wrb.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:26 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51])
	by smtp.gmail.com with ESMTPSA id f21sm3258597wra.5.2017.06.15.03.53.23
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 15 Jun 2017 03:53:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:33 +0200
Message-Id: <1497523981-38449-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/41] megasas: always store SCSIRequest* into
 MegasasCmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This ensures that the request is unref'ed properly, and avoids a
segmentation fault in the new qtest testcase that is added.
This is CVE-2017-9503.

Reported-by: Zhangyanyu <zyy4013@stu.ouc.edu.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c    | 31 ++++++++++++++++---------------
 tests/megasas-test.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 135662d..734fdae 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -609,6 +609,9 @@ static void megasas_reset_frames(MegasasState *s)
 static void megasas_abort_command(MegasasCmd *cmd)
 {
     /* Never abort internal commands.  */
+    if (cmd->dcmd_opcode != -1) {
+        return;
+    }
     if (cmd->req != NULL) {
         scsi_req_cancel(cmd->req);
     }
@@ -1017,7 +1020,6 @@ static int megasas_pd_get_info_submit(SCSIDevice *sdev, int lun,
     uint64_t pd_size;
     uint16_t pd_id = ((sdev->id & 0xFF) << 8) | (lun & 0xFF);
     uint8_t cmdbuf[6];
-    SCSIRequest *req;
     size_t len, resid;
 
     if (!cmd->iov_buf) {
@@ -1026,8 +1028,8 @@ static int megasas_pd_get_info_submit(SCSIDevice *sdev, int lun,
         info->inquiry_data[0] = 0x7f; /* Force PQual 0x3, PType 0x1f */
         info->vpd_page83[0] = 0x7f;
         megasas_setup_inquiry(cmdbuf, 0, sizeof(info->inquiry_data));
-        req = scsi_req_new(sdev, cmd->index, lun, cmdbuf, cmd);
-        if (!req) {
+        cmd->req = scsi_req_new(sdev, cmd->index, lun, cmdbuf, cmd);
+        if (!cmd->req) {
             trace_megasas_dcmd_req_alloc_failed(cmd->index,
                                                 "PD get info std inquiry");
             g_free(cmd->iov_buf);
@@ -1036,26 +1038,26 @@ static int megasas_pd_get_info_submit(SCSIDevice *sdev, int lun,
         }
         trace_megasas_dcmd_internal_submit(cmd->index,
                                            "PD get info std inquiry", lun);
-        len = scsi_req_enqueue(req);
+        len = scsi_req_enqueue(cmd->req);
         if (len > 0) {
             cmd->iov_size = len;
-            scsi_req_continue(req);
+            scsi_req_continue(cmd->req);
         }
         return MFI_STAT_INVALID_STATUS;
     } else if (info->inquiry_data[0] != 0x7f && info->vpd_page83[0] == 0x7f) {
         megasas_setup_inquiry(cmdbuf, 0x83, sizeof(info->vpd_page83));
-        req = scsi_req_new(sdev, cmd->index, lun, cmdbuf, cmd);
-        if (!req) {
+        cmd->req = scsi_req_new(sdev, cmd->index, lun, cmdbuf, cmd);
+        if (!cmd->req) {
             trace_megasas_dcmd_req_alloc_failed(cmd->index,
                                                 "PD get info vpd inquiry");
             return MFI_STAT_FLASH_ALLOC_FAIL;
         }
         trace_megasas_dcmd_internal_submit(cmd->index,
                                            "PD get info vpd inquiry", lun);
-        len = scsi_req_enqueue(req);
+        len = scsi_req_enqueue(cmd->req);
         if (len > 0) {
             cmd->iov_size = len;
-            scsi_req_continue(req);
+            scsi_req_continue(cmd->req);
         }
         return MFI_STAT_INVALID_STATUS;
     }
@@ -1217,7 +1219,6 @@ static int megasas_ld_get_info_submit(SCSIDevice *sdev, int lun,
     struct mfi_ld_info *info = cmd->iov_buf;
     size_t dcmd_size = sizeof(struct mfi_ld_info);
     uint8_t cdb[6];
-    SCSIRequest *req;
     ssize_t len, resid;
     uint16_t sdev_id = ((sdev->id & 0xFF) << 8) | (lun & 0xFF);
     uint64_t ld_size;
@@ -1226,8 +1227,8 @@ static int megasas_ld_get_info_submit(SCSIDevice *sdev, int lun,
         cmd->iov_buf = g_malloc0(dcmd_size);
         info = cmd->iov_buf;
         megasas_setup_inquiry(cdb, 0x83, sizeof(info->vpd_page83));
-        req = scsi_req_new(sdev, cmd->index, lun, cdb, cmd);
-        if (!req) {
+        cmd->req = scsi_req_new(sdev, cmd->index, lun, cdb, cmd);
+        if (!cmd->req) {
             trace_megasas_dcmd_req_alloc_failed(cmd->index,
                                                 "LD get info vpd inquiry");
             g_free(cmd->iov_buf);
@@ -1236,10 +1237,10 @@ static int megasas_ld_get_info_submit(SCSIDevice *sdev, int lun,
         }
         trace_megasas_dcmd_internal_submit(cmd->index,
                                            "LD get info vpd inquiry", lun);
-        len = scsi_req_enqueue(req);
+        len = scsi_req_enqueue(cmd->req);
         if (len > 0) {
             cmd->iov_size = len;
-            scsi_req_continue(req);
+            scsi_req_continue(cmd->req);
         }
         return MFI_STAT_INVALID_STATUS;
     }
@@ -1851,7 +1852,7 @@ static void megasas_command_complete(SCSIRequest *req, uint32_t status,
         return;
     }
 
-    if (cmd->req == NULL) {
+    if (cmd->dcmd_opcode != -1) {
         /*
          * Internal command complete
          */
diff --git a/tests/megasas-test.c b/tests/megasas-test.c
index a9e56a2..ce960e7 100644
--- a/tests/megasas-test.c
+++ b/tests/megasas-test.c
@@ -42,10 +42,45 @@ static void pci_nop(void)
     qmegasas_stop(qs);
 }
 
+/* This used to cause a NULL pointer dereference.  */
+static void megasas_pd_get_info_fuzz(void)
+{
+    QPCIDevice *dev;
+    QOSState *qs;
+    QPCIBar bar;
+    uint32_t context[256];
+    uint64_t context_pa;
+    int i;
+
+    qs = qmegasas_start(NULL);
+    dev = qpci_device_find(qs->pcibus, QPCI_DEVFN(4,0));
+    g_assert(dev != NULL);
+
+    qpci_device_enable(dev);
+    bar = qpci_iomap(dev, 0, NULL);
+
+    memset(context, 0, sizeof(context));
+    context[0] = cpu_to_le32(0x05050505);
+    context[1] = cpu_to_le32(0x01010101);
+    for (i = 2; i < ARRAY_SIZE(context); i++) {
+        context[i] = cpu_to_le32(0x41414141);
+    }
+    context[6] = cpu_to_le32(0x02020000);
+    context[7] = cpu_to_le32(0);
+
+    context_pa = qmalloc(qs, sizeof(context));
+    memwrite(context_pa, context, sizeof(context));
+    qpci_io_writel(dev, bar, 0x40, context_pa);
+
+    g_free(dev);
+    qmegasas_stop(qs);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/megasas/pci/nop", pci_nop);
+    qtest_add_func("/megasas/dcmd/pd-get-info/fuzz", megasas_pd_get_info_fuzz);
 
     return g_test_run();
 }
-- 
1.8.3.1
