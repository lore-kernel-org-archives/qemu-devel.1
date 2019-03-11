Received: from eggs.gnu.org ([209.51.188.92]:60898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODe-0007B7-Nd
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODd-0003O0-Jw
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:06 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:55571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODc-0003JH-WC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:05 -0400
Received: by mail-wm1-x32f.google.com with SMTP id 4so289917wmf.5
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:56:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:27 +0100
Message-Id: <1552323335-46779-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 23/31] lsi: use enum type for s->waiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>

From: Sven Schnelle <svens@stackframe.org>

This makes the code easier to read - no functional change.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190305195519.24303-3-svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 402b785..c17bb4f 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -194,6 +194,13 @@ typedef struct lsi_request {
     QTAILQ_ENTRY(lsi_request) next;
 } lsi_request;
 
+enum {
+    LSI_NOWAIT, /* SCRIPTS are running or stopped */
+    LSI_WAIT_RESELECT, /* Wait Reselect instruction has been issued */
+    LSI_DMA_SCRIPTS, /* processing DMA from lsi_execute_script */
+    LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
+};
+
 typedef struct {
     /*< private >*/
     PCIDevice parent_obj;
@@ -212,10 +219,6 @@ typedef struct {
     int msg_action;
     int msg_len;
     uint8_t msg[LSI_MAX_MSGIN_LEN];
-    /* 0 if SCRIPTS are running or stopped.
-     * 1 if a Wait Reselect instruction has been issued.
-     * 2 if processing DMA from lsi_execute_script.
-     * 3 if a DMA operation is in progress.  */
     int waiting;
     SCSIBus bus;
     int current_lun;
@@ -322,7 +325,7 @@ static void lsi_soft_reset(LSIState *s)
 
     s->msg_action = 0;
     s->msg_len = 0;
-    s->waiting = 0;
+    s->waiting = LSI_NOWAIT;
     s->dsa = 0;
     s->dnad = 0;
     s->dbc = 0;
@@ -564,10 +567,10 @@ static void lsi_bad_phase(LSIState *s, int out, int new_phase)
 static void lsi_resume_script(LSIState *s)
 {
     if (s->waiting != 2) {
-        s->waiting = 0;
+        s->waiting = LSI_NOWAIT;
         lsi_execute_script(s);
     } else {
-        s->waiting = 0;
+        s->waiting = LSI_NOWAIT;
     }
 }
 
@@ -744,7 +747,7 @@ static int lsi_queue_req(LSIState *s, SCSIRequest *req, uint32_t len)
        Since no interrupt stacking is implemented in the emulation, it
        is also required that there are no pending interrupts waiting
        for service from the device driver. */
-    if (s->waiting == 1 ||
+    if (s->waiting == LSI_WAIT_RESELECT ||
         (lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON) &&
          !(s->istat0 & (LSI_ISTAT0_SIP | LSI_ISTAT0_DIP)))) {
         /* Reselect device.  */
@@ -789,7 +792,7 @@ static void lsi_transfer_data(SCSIRequest *req, uint32_t len)
     int out;
 
     assert(req->hba_private);
-    if (s->waiting == 1 || req->hba_private != s->current ||
+    if (s->waiting == LSI_WAIT_RESELECT || req->hba_private != s->current ||
         (lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON))) {
         if (lsi_queue_req(s, req, len)) {
             return;
@@ -803,7 +806,7 @@ static void lsi_transfer_data(SCSIRequest *req, uint32_t len)
     s->current->dma_len = len;
     s->command_complete = 1;
     if (s->waiting) {
-        if (s->waiting == 1 || s->dbc == 0) {
+        if (s->waiting == LSI_WAIT_RESELECT || s->dbc == 0) {
             lsi_resume_script(s);
         } else {
             lsi_do_dma(s, out);
@@ -1093,7 +1096,7 @@ static void lsi_wait_reselect(LSIState *s)
         lsi_reselect(s, p);
     }
     if (s->current == NULL) {
-        s->waiting = 1;
+        s->waiting = LSI_WAIT_RESELECT;
     }
 }
 
@@ -1202,16 +1205,16 @@ again:
         s->dnad64 = addr_high;
         switch (s->sstat1 & 0x7) {
         case PHASE_DO:
-            s->waiting = 2;
+            s->waiting = LSI_DMA_SCRIPTS;
             lsi_do_dma(s, 1);
             if (s->waiting)
-                s->waiting = 3;
+                s->waiting = LSI_DMA_IN_PROGRESS;
             break;
         case PHASE_DI:
-            s->waiting = 2;
+            s->waiting = LSI_DMA_SCRIPTS;
             lsi_do_dma(s, 0);
             if (s->waiting)
-                s->waiting = 3;
+                s->waiting = LSI_DMA_IN_PROGRESS;
             break;
         case PHASE_CMD:
             lsi_do_command(s);
@@ -1278,6 +1281,7 @@ again:
                 }
                 s->sbcl |= LSI_SBCL_BSY;
                 lsi_set_phase(s, PHASE_MO);
+                s->waiting = LSI_NOWAIT;
                 break;
             case 1: /* Disconnect */
                 trace_lsi_execute_script_io_disconnect();
@@ -1544,7 +1548,7 @@ again:
             }
         }
     }
-    if (insn_processed > 10000 && !s->waiting) {
+    if (insn_processed > 10000 && s->waiting == LSI_NOWAIT) {
         /* Some windows drivers make the device spin waiting for a memory
            location to change.  If we have been executed a lot of code then
            assume this is the case and force an unexpected device disconnect.
@@ -1556,7 +1560,7 @@ again:
         }
         lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
         lsi_disconnect(s);
-    } else if (s->istat1 & LSI_ISTAT1_SRUN && !s->waiting) {
+    } else if (s->istat1 & LSI_ISTAT1_SRUN && s->waiting == LSI_NOWAIT) {
         if (s->dcntl & LSI_DCNTL_SSM) {
             lsi_script_dma_interrupt(s, LSI_DSTAT_SSI);
         } else {
@@ -1887,9 +1891,9 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
             s->istat0 &= ~LSI_ISTAT0_INTF;
             lsi_update_irq(s);
         }
-        if (s->waiting == 1 && val & LSI_ISTAT0_SIGP) {
+        if (s->waiting == LSI_WAIT_RESELECT && val & LSI_ISTAT0_SIGP) {
             trace_lsi_awoken();
-            s->waiting = 0;
+            s->waiting = LSI_NOWAIT;
             s->dsp = s->dnad;
             lsi_execute_script(s);
         }
-- 
1.8.3.1
