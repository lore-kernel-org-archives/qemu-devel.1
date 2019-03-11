Received: from eggs.gnu.org ([209.51.188.92]:60913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODf-0007EW-Gg
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODe-0003Sn-GM
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:07 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODe-0003NE-1W
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:06 -0400
Received: by mail-wr1-x431.google.com with SMTP id t18so5945020wrx.2
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:56:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:28 +0100
Message-Id: <1552323335-46779-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 24/31] lsi: use enum type for s->msg_action
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
Message-Id: <20190305195519.24303-4-svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index c17bb4f..d67584e 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -201,6 +201,13 @@ enum {
     LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
 };
 
+enum {
+    LSI_MSG_ACTION_COMMAND = 0,
+    LSI_MSG_ACTION_DISCONNECT = 1,
+    LSI_MSG_ACTION_DOUT = 2,
+    LSI_MSG_ACTION_DIN = 3,
+};
+
 typedef struct {
     /*< private >*/
     PCIDevice parent_obj;
@@ -214,8 +221,6 @@ typedef struct {
 
     int carry; /* ??? Should this be an a visible register somewhere?  */
     int status;
-    /* Action to take at the end of a MSG IN phase.
-       0 = COMMAND, 1 = disconnect, 2 = DATA OUT, 3 = DATA IN.  */
     int msg_action;
     int msg_len;
     uint8_t msg[LSI_MAX_MSGIN_LEN];
@@ -323,7 +328,7 @@ static void lsi_soft_reset(LSIState *s)
     trace_lsi_reset();
     s->carry = 0;
 
-    s->msg_action = 0;
+    s->msg_action = LSI_MSG_ACTION_COMMAND;
     s->msg_len = 0;
     s->waiting = LSI_NOWAIT;
     s->dsa = 0;
@@ -686,7 +691,7 @@ static void lsi_reselect(LSIState *s, lsi_request *p)
     trace_lsi_reselect(id);
     s->scntl1 |= LSI_SCNTL1_CON;
     lsi_set_phase(s, PHASE_MI);
-    s->msg_action = p->out ? 2 : 3;
+    s->msg_action = p->out ? LSI_MSG_ACTION_DOUT : LSI_MSG_ACTION_DIN;
     s->current->dma_len = p->pending;
     lsi_add_msg_byte(s, 0x80);
     if (s->current->tag & LSI_TAG_VALID) {
@@ -857,7 +862,7 @@ static void lsi_do_command(LSIState *s)
             lsi_add_msg_byte(s, 4); /* DISCONNECT */
             /* wait data */
             lsi_set_phase(s, PHASE_MI);
-            s->msg_action = 1;
+            s->msg_action = LSI_MSG_ACTION_DISCONNECT;
             lsi_queue_command(s);
         } else {
             /* wait command complete */
@@ -878,7 +883,7 @@ static void lsi_do_status(LSIState *s)
     s->sfbr = status;
     pci_dma_write(PCI_DEVICE(s), s->dnad, &status, 1);
     lsi_set_phase(s, PHASE_MI);
-    s->msg_action = 1;
+    s->msg_action = LSI_MSG_ACTION_DISCONNECT;
     lsi_add_msg_byte(s, 0); /* COMMAND COMPLETE */
 }
 
@@ -901,16 +906,16 @@ static void lsi_do_msgin(LSIState *s)
         /* ??? Check if ATN (not yet implemented) is asserted and maybe
            switch to PHASE_MO.  */
         switch (s->msg_action) {
-        case 0:
+        case LSI_MSG_ACTION_COMMAND:
             lsi_set_phase(s, PHASE_CMD);
             break;
-        case 1:
+        case LSI_MSG_ACTION_DISCONNECT:
             lsi_disconnect(s);
             break;
-        case 2:
+        case LSI_MSG_ACTION_DOUT:
             lsi_set_phase(s, PHASE_DO);
             break;
-        case 3:
+        case LSI_MSG_ACTION_DIN:
             lsi_set_phase(s, PHASE_DI);
             break;
         default:
@@ -1062,7 +1067,7 @@ bad:
     qemu_log_mask(LOG_UNIMP, "Unimplemented message 0x%02x\n", msg);
     lsi_set_phase(s, PHASE_MI);
     lsi_add_msg_byte(s, 7); /* MESSAGE REJECT */
-    s->msg_action = 0;
+    s->msg_action = LSI_MSG_ACTION_COMMAND;
 }
 
 #define LSI_BUF_SIZE 4096
-- 
1.8.3.1
