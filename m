Received: from eggs.gnu.org ([2001:4830:134:3::10]:52267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MZ-0000q8-AN
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MX-0000E6-7Q
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:51 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MW-00005O-Ra
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:49 -0500
Received: by mail-wr1-x432.google.com with SMTP id r10so18076389wrs.10
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:38 +0100
Message-Id: <1544628195-37728-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/54] scsi: esp: Defer command completion until
 previous interrupts have been handled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>

From: Guenter Roeck <linux@roeck-us.net>

The guest OS reads RSTAT, RSEQ, and RINTR, and expects those registers
to reflect a consistent state. However, it is possible that the registers
can change after RSTAT was read, but before RINTR is read, when
esp_command_complete() is called.

Guest OS		qemu
--------		----
[handle interrupt]
Read RSTAT
			esp_command_complete()
			 RSTAT = STAT_ST
			 esp_dma_done()
			  RSTAT |= STAT_TC
			  RSEQ = 0
			  RINTR = INTR_BS

Read RSEQ
Read RINTR		RINTR = 0
			RSTAT &= ~STAT_TC
			RSEQ = SEQ_CD

The guest OS would then try to handle INTR_BS combined with an old
value of RSTAT. This sometimes resulted in lost events, spurious
interrupts, guest OS confusion, and stalled SCSI operations.
A typical guest error log (observed with various versions of Linux)
looks as follows.

scsi host1: Spurious irq, sreg=13.
...
scsi host1: Aborting command [84531f10:2a]
scsi host1: Current command [f882eea8:35]
scsi host1: Queued command [84531f10:2a]
scsi host1:  Active command [f882eea8:35]
scsi host1: Dumping command log
scsi host1: ent[15] CMD val[44] sreg[90] seqreg[00] sreg2[00] ireg[20] ss[00] event[0c]
scsi host1: ent[16] CMD val[01] sreg[90] seqreg[00] sreg2[00] ireg[20] ss[02] event[0c]
scsi host1: ent[17] CMD val[43] sreg[90] seqreg[00] sreg2[00] ireg[20] ss[02] event[0c]
scsi host1: ent[18] EVENT val[0d] sreg[92] seqreg[04] sreg2[00] ireg[18] ss[00] event[0c]
...

Defer handling command completion until previous interrupts have been
handled to fix the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/scsi/esp-pci.c     |  4 ++--
 hw/scsi/esp.c         | 33 ++++++++++++++++++++++++++-------
 hw/scsi/trace-events  |  1 +
 include/hw/scsi/esp.h |  2 ++
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index d956909..6b0bbb9 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -313,8 +313,8 @@ static void esp_pci_hard_reset(DeviceState *dev)
 
 static const VMStateDescription vmstate_esp_pci_scsi = {
     .name = "pciespscsi",
-    .version_id = 0,
-    .minimum_version_id = 0,
+    .version_id = 1,
+    .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCIESPState),
         VMSTATE_BUFFER_UNSAFE(dma_regs, PCIESPState, 0, 8 * sizeof(uint32_t)),
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 630d923..ca8b36c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -286,11 +286,8 @@ static void esp_do_dma(ESPState *s)
     esp_dma_done(s);
 }
 
-void esp_command_complete(SCSIRequest *req, uint32_t status,
-                                 size_t resid)
+static void esp_report_command_complete(ESPState *s, uint32_t status)
 {
-    ESPState *s = req->hba_private;
-
     trace_esp_command_complete();
     if (s->ti_size != 0) {
         trace_esp_command_complete_unexpected();
@@ -311,6 +308,23 @@ void esp_command_complete(SCSIRequest *req, uint32_t status,
     }
 }
 
+void esp_command_complete(SCSIRequest *req, uint32_t status,
+                          size_t resid)
+{
+    ESPState *s = req->hba_private;
+
+    if (s->rregs[ESP_RSTAT] & STAT_INT) {
+        /* Defer handling command complete until the previous
+         * interrupt has been handled.
+         */
+        trace_esp_command_complete_deferred();
+        s->deferred_status = status;
+        s->deferred_complete = true;
+        return;
+    }
+    esp_report_command_complete(s, status);
+}
+
 void esp_transfer_data(SCSIRequest *req, uint32_t len)
 {
     ESPState *s = req->hba_private;
@@ -422,7 +436,10 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
         s->rregs[ESP_RSEQ] = SEQ_CD;
         esp_lower_irq(s);
-
+        if (s->deferred_complete) {
+            esp_report_command_complete(s, s->deferred_status);
+            s->deferred_complete = false;
+        }
         return old_val;
     case ESP_TCHI:
         /* Return the unique id if the value has never been written */
@@ -582,6 +599,8 @@ const VMStateDescription vmstate_esp = {
         VMSTATE_UINT32(ti_wptr, ESPState),
         VMSTATE_BUFFER(ti_buf, ESPState),
         VMSTATE_UINT32(status, ESPState),
+        VMSTATE_UINT32(deferred_status, ESPState),
+        VMSTATE_BOOL(deferred_complete, ESPState),
         VMSTATE_UINT32(dma, ESPState),
         VMSTATE_PARTIAL_BUFFER(cmdbuf, ESPState, 16),
         VMSTATE_BUFFER_START_MIDDLE_V(cmdbuf, ESPState, 16, 4),
@@ -671,8 +690,8 @@ static void sysbus_esp_hard_reset(DeviceState *dev)
 
 static const VMStateDescription vmstate_sysbus_esp_scsi = {
     .name = "sysbusespscsi",
-    .version_id = 0,
-    .minimum_version_id = 0,
+    .version_id = 1,
+    .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_STRUCT(esp, SysBusESPState, 0, vmstate_esp, ESPState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 0fb6a99..2fe8a7c 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -167,6 +167,7 @@ esp_handle_satn_stop(uint32_t cmdlen) "cmdlen %d"
 esp_write_response(uint32_t status) "Transfer status (status=%d)"
 esp_do_dma(uint32_t cmdlen, uint32_t len) "command len %d + %d"
 esp_command_complete(void) "SCSI Command complete"
+esp_command_complete_deferred(void) "SCSI Command complete deferred"
 esp_command_complete_unexpected(void) "SCSI command completed unexpectedly"
 esp_command_complete_fail(void) "Command failed"
 esp_transfer_data(uint32_t dma_left, int32_t ti_size) "transfer %d/%d"
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 682a0d2..adab63d 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -23,6 +23,8 @@ struct ESPState {
     int32_t ti_size;
     uint32_t ti_rptr, ti_wptr;
     uint32_t status;
+    uint32_t deferred_status;
+    bool deferred_complete;
     uint32_t dma;
     uint8_t ti_buf[TI_BUFSZ];
     SCSIBus bus;
-- 
1.8.3.1
