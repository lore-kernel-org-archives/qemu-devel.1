Received: from eggs.gnu.org ([2001:4830:134:3::10]:56418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVd7U-0003xm-AY
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVd7Q-0004ks-99
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:25:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59530 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fVd7Q-0004kW-34
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:25:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1178F7A7E8
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 13:25:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Jun 2018 15:25:46 +0200
Message-Id: <20180620132546.27128-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] ahci: fix FIS I bit and PIO Setup FIS interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, jsnow@redhat.com

The "I" bit in PIO Setup and D2H FISes is exclusively a device concept
and the irqstatus register in the controller does not matter.  The SATA
spec says when it should be one; for D2H FISes in practice it is always
set, while the PIO Setup FIS has several subcases that are documented in
the patch.

Also, the PIO Setup FIS interrupt is actually generated _after_ data
has been received.

Someone should probably spend some time reading the SATA specification and
figuring out the more obscure fields in the PIO Setup FIS, but this is enough
to fix SeaBIOS booting from ATAPI CD-ROMs over an AHCI controller.

Fixes: 956556e131e35f387ac482ad7b41151576fef057
Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/ahci.c       | 28 +++++++++++++++++++++-------
 tests/libqos/ahci.c | 20 +++++++++++---------
 tests/libqos/ahci.h |  2 +-
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index f7852be842..acb90f41f3 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -801,7 +801,7 @@ static void ahci_write_fis_sdb(AHCIState *s, NCQTransferState *ncq_tfs)
     }
 }
 
-static void ahci_write_fis_pio(AHCIDevice *ad, uint16_t len)
+static void ahci_write_fis_pio(AHCIDevice *ad, uint16_t len, bool pio_fis_i)
 {
     AHCIPortRegs *pr = &ad->port_regs;
     uint8_t *pio_fis;
@@ -814,7 +814,7 @@ static void ahci_write_fis_pio(AHCIDevice *ad, uint16_t len)
     pio_fis = &ad->res_fis[RES_FIS_PSFIS];
 
     pio_fis[0] = SATA_FIS_TYPE_PIO_SETUP;
-    pio_fis[1] = (ad->hba->control_regs.irqstatus ? (1 << 6) : 0);
+    pio_fis[1] = (pio_fis_i ? (1 << 6) : 0);
     pio_fis[2] = s->status;
     pio_fis[3] = s->error;
 
@@ -842,8 +842,6 @@ static void ahci_write_fis_pio(AHCIDevice *ad, uint16_t len)
     if (pio_fis[2] & ERR_STAT) {
         ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
     }
-
-    ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_PSS);
 }
 
 static bool ahci_write_fis_d2h(AHCIDevice *ad)
@@ -860,7 +858,7 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad)
     d2h_fis = &ad->res_fis[RES_FIS_RFIS];
 
     d2h_fis[0] = SATA_FIS_TYPE_REGISTER_D2H;
-    d2h_fis[1] = (ad->hba->control_regs.irqstatus ? (1 << 6) : 0);
+    d2h_fis[1] = (1 << 6); /* interrupt bit */
     d2h_fis[2] = s->status;
     d2h_fis[3] = s->error;
 
@@ -1351,9 +1349,20 @@ static void ahci_pio_transfer(IDEDMA *dma)
     int is_write = opts & AHCI_CMD_WRITE;
     int is_atapi = opts & AHCI_CMD_ATAPI;
     int has_sglist = 0;
+    bool pio_fis_i;
 
-    /* PIO FIS gets written prior to transfer */
-    ahci_write_fis_pio(ad, size);
+    /* The PIO Setup FIS is received prior to transfer, but the interrupt
+     * is only triggered after data is received.
+     *
+     * The device only sets the 'I' bit in the PIO Setup FIS for device->host
+     * requests (see "DPIOI1" in the SATA spec), or for host->device PIO requests
+     * after the first (see "DPIOO1").  The latter is consistent with the spec's
+     * description of the PACKET protocol, where the command part of ATAPI requests
+     * ("DPKT0") has the 'I' bit clear, while the data part of PIO ATAPI requests
+     * ("DPKT4a" and "DPKT7") has the 'I' bit set for both directions.
+     */
+    pio_fis_i = is_atapi ? ad->done_atapi_packet : !is_write;
+    ahci_write_fis_pio(ad, size, pio_fis_i);
 
     if (is_atapi && !ad->done_atapi_packet) {
         /* already prepopulated iobuffer */
@@ -1379,9 +1388,14 @@ static void ahci_pio_transfer(IDEDMA *dma)
 
     /* Update number of transferred bytes, destroy sglist */
     dma_buf_commit(s, size);
+
 out:
     /* declare that we processed everything */
     s->data_ptr = s->data_end;
+
+    if (pio_fis_i) {
+        ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_PSS);
+    }
 }
 
 static void ahci_start_dma(IDEDMA *dma, IDEState *s,
diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index 7264e085d0..0e295ce31a 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -651,10 +651,7 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
     /* Command creation */
     if (opts->atapi) {
         uint16_t bcl = opts->set_bcl ? opts->bcl : ATAPI_SECTOR_SIZE;
-        cmd = ahci_atapi_command_create(op, bcl);
-        if (opts->atapi_dma) {
-            ahci_command_enable_atapi_dma(cmd);
-        }
+        cmd = ahci_atapi_command_create(op, bcl, opts->atapi_dma);
     } else {
         cmd = ahci_command_create(op);
     }
@@ -874,7 +871,7 @@ AHCICommand *ahci_command_create(uint8_t command_name)
     /* cmd->interrupts |= props->data ? AHCI_PX_IS_DPS : 0; */
     /* BUG: We expect the DMA Setup interrupt for DMA commands */
     /* cmd->interrupts |= props->dma ? AHCI_PX_IS_DSS : 0; */
-    cmd->interrupts |= props->pio ? AHCI_PX_IS_PSS : 0;
+    cmd->interrupts |= (props->pio && props->read) ? AHCI_PX_IS_PSS : 0;
     cmd->interrupts |= props->ncq ? AHCI_PX_IS_SDBS : 0;
 
     command_header_init(cmd);
@@ -883,19 +880,24 @@ AHCICommand *ahci_command_create(uint8_t command_name)
     return cmd;
 }
 
-AHCICommand *ahci_atapi_command_create(uint8_t scsi_cmd, uint16_t bcl)
+AHCICommand *ahci_atapi_command_create(uint8_t scsi_cmd, uint16_t bcl, bool dma)
 {
     AHCICommand *cmd = ahci_command_create(CMD_PACKET);
     cmd->atapi_cmd = g_malloc0(16);
     cmd->atapi_cmd[0] = scsi_cmd;
     stw_le_p(&cmd->fis.lba_lo[1], bcl);
+    if (dma) {
+        ahci_command_enable_atapi_dma(cmd);
+    } else {
+        cmd->interrupts |= bcl ? AHCI_PX_IS_PSS : 0;
+    }
     return cmd;
 }
 
 void ahci_atapi_test_ready(AHCIQState *ahci, uint8_t port,
                            bool ready, uint8_t expected_sense)
 {
-    AHCICommand *cmd = ahci_atapi_command_create(CMD_ATAPI_TEST_UNIT_READY, 0);
+    AHCICommand *cmd = ahci_atapi_command_create(CMD_ATAPI_TEST_UNIT_READY, 0, false);
     ahci_command_set_size(cmd, 0);
     if (!ready) {
         cmd->interrupts |= AHCI_PX_IS_TFES;
@@ -937,7 +939,7 @@ void ahci_atapi_get_sense(AHCIQState *ahci, uint8_t port,
 
 void ahci_atapi_eject(AHCIQState *ahci, uint8_t port)
 {
-    AHCICommand *cmd = ahci_atapi_command_create(CMD_ATAPI_START_STOP_UNIT, 0);
+    AHCICommand *cmd = ahci_atapi_command_create(CMD_ATAPI_START_STOP_UNIT, 0, false);
     ahci_command_set_size(cmd, 0);
 
     cmd->atapi_cmd[4] = 0x02; /* loej = true */
@@ -949,7 +951,7 @@ void ahci_atapi_eject(AHCIQState *ahci, uint8_t port)
 
 void ahci_atapi_load(AHCIQState *ahci, uint8_t port)
 {
-    AHCICommand *cmd = ahci_atapi_command_create(CMD_ATAPI_START_STOP_UNIT, 0);
+    AHCICommand *cmd = ahci_atapi_command_create(CMD_ATAPI_START_STOP_UNIT, 0, false);
     ahci_command_set_size(cmd, 0);
 
     cmd->atapi_cmd[4] = 0x03; /* loej,start = true */
diff --git a/tests/libqos/ahci.h b/tests/libqos/ahci.h
index 13f6d87b75..f05b3e5fce 100644
--- a/tests/libqos/ahci.h
+++ b/tests/libqos/ahci.h
@@ -622,7 +622,7 @@ void ahci_atapi_load(AHCIQState *ahci, uint8_t port);
 
 /* Command: Fine-grained lifecycle */
 AHCICommand *ahci_command_create(uint8_t command_name);
-AHCICommand *ahci_atapi_command_create(uint8_t scsi_cmd, uint16_t bcl);
+AHCICommand *ahci_atapi_command_create(uint8_t scsi_cmd, uint16_t bcl, bool dma);
 void ahci_command_commit(AHCIQState *ahci, AHCICommand *cmd, uint8_t port);
 void ahci_command_issue(AHCIQState *ahci, AHCICommand *cmd);
 void ahci_command_issue_async(AHCIQState *ahci, AHCICommand *cmd);
-- 
2.17.0
