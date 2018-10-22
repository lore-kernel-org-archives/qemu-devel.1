Received: from eggs.gnu.org ([2001:4830:134:3::10]:54116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1gEhms-0004Mv-1T
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1gEhmo-0002PU-NZ
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:30:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <george.kennedy@oracle.com>)
	id 1gEhmo-0002Lv-Bg
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:30:54 -0400
From: George Kennedy <george.kennedy@oracle.com>
Date: Mon, 22 Oct 2018 17:28:24 -0400
Message-Id: <1540243704-17090-1-git-send-email-george.kennedy@oracle.com>
Subject: [Qemu-devel] [PATCH v2] lsi: Reselection needed to remove pending
 commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, george.kennedy@oracle.com

Under heavy IO (e.g. fio) the queue is not checked frequently enough for
pending commands. As a result some pending commands are timed out by the
linux sym53c8xx driver, which sends SCSI Abort messages for the timed out
commands. The SCSI Abort messages result in linux errors, which show up
in /var/log/messages.

e.g.
sd 0:0:3:0: [sdd] tag#33 ABORT operation started
scsi target0:0:3: control msgout:
80 20 47 d
sd 0:0:3:0: ABORT operation complete.
scsi target0:0:4: message d sent on bad reselection

Add a deadline along with the command when it is added to the queue.
When the current command completes, check the queue for pending commands
that have exceeded the deadline and if so, simulate a Wait Reselect
to handle the pending commands on the queue.

When a Wait Reselect is needed, intercept and save the current DMA Scripts
Ptr (DSP) contents and load it instead with the pointer to the Reselection
Scripts.  When Reselection has completed, restore the original DSP contents.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
Thank you for reviewing, Paolo,

As you suggested I moved the loading of "s->resel_dsp" down to the "Wait Reselect"
case. The address of the Reselection Scripts, though, is contained in "s->dsp - 8"
and not in s->dnad.

The reason the timeout is needed is that under heavy IO some pending commands
stay on the pending queue longer than the 30 second command timeout set by the
linux upper layer scsi driver (sym53c8xx). When command timeouts occur, the
upper layer scsi driver sends SCSI Abort messages to remove the timed out
commands. The command timeouts are caused by the fact that under heavy IO,
lsi_reselect() in qemu "hw/scsi/lsi53c895a.c" is not being called before the
upper layer scsi driver 30 second command timeout goes off.

If lsi_reselect() were called more frequently, the command timeout problem would
probably not occur. There are a number of places where lsi_reselect() is supposed
to get called (e.g. at the end of lsi_update_irq()), but the only place that I
have observed lsi_reselect() being called is from lsi_execute_script() when
lsi_wait_reselect() is called because of a SCRIPT "Wait Select" IO Instruction.

The proposed patch adds a deadline timeout for each pending command added to the
pending queue. The timeout is an arbitrary value (less than the upper layer
command timeout) that gets checked after each command is completed when the
pending queue is checked. If the deadline is exceeded, a flag is set indicating
that a SCRIPT "Wait Select" IO Instruction is needed, which will result in
lsi_wait_reselect() and lsi_reselect() being called to remove a command from 
the pending queue, reselect the target, continue and complete the command.

 hw/scsi/lsi53c895a.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 996b406..8474399 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -198,6 +198,7 @@ typedef struct lsi_request {
     uint32_t dma_len;
     uint8_t *dma_buf;
     uint32_t pending;
+    uint64_t deadline;
     int out;
     QTAILQ_ENTRY(lsi_request) next;
 } lsi_request;
@@ -232,6 +233,9 @@ typedef struct {
     int command_complete;
     QTAILQ_HEAD(, lsi_request) queue;
     lsi_request *current;
+    int want_resel;     /* need resel to handle queued completed cmds */
+    uint32_t resel_dsp; /* DMA Scripts Ptr (DSP) of reselection scsi scripts */
+    uint32_t next_dsp;  /* if want_resel, will be loaded with above */
 
     uint32_t dsa;
     uint32_t temp;
@@ -311,6 +315,20 @@ static inline int lsi_irq_on_rsl(LSIState *s)
     return (s->sien0 & LSI_SIST0_RSL) && (s->scid & LSI_SCID_RRE);
 }
 
+static int pending_past_deadline(LSIState *s)
+{
+    lsi_request *p;
+
+    QTAILQ_FOREACH(p, &s->queue, next) {
+        if (p->pending) {
+            if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > p->deadline) {
+                return 1;
+            }
+        }
+    }
+    return 0;
+}
+
 static void lsi_soft_reset(LSIState *s)
 {
     DPRINTF("Reset\n");
@@ -634,15 +652,22 @@ static void lsi_do_dma(LSIState *s, int out)
     }
 }
 
+/* Max time a completed command can be on the queue before Reselection needed */
+#define LSI_DEADLINE    1000
 
 /* Add a command to the queue.  */
 static void lsi_queue_command(LSIState *s)
 {
     lsi_request *p = s->current;
+    uint64_t timeout_ms = LSI_DEADLINE;
 
     DPRINTF("Queueing tag=0x%x\n", p->tag);
     assert(s->current != NULL);
     assert(s->current->dma_len == 0);
+
+    p->deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
+        timeout_ms * 1000000ULL;
+
     QTAILQ_INSERT_TAIL(&s->queue, s->current, next);
     s->current = NULL;
 
@@ -775,6 +800,9 @@ static void lsi_command_complete(SCSIRequest *req, uint32_t status, size_t resid
         lsi_request_free(s, s->current);
         scsi_req_unref(req);
     }
+    if (pending_past_deadline(s)) {
+        s->want_resel = 1;
+    }
     lsi_resume_script(s);
 }
 
@@ -987,7 +1015,7 @@ static void lsi_do_msgout(LSIState *s)
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             break;
         case 0x22: /* ORDERED queue */
-            BADF("ORDERED queue not implemented\n");
+            DPRINTF("ORDERED queue not implemented\n");
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             break;
         case 0x0d:
@@ -1078,6 +1106,9 @@ static void lsi_wait_reselect(LSIState *s)
 
     DPRINTF("Wait Reselect\n");
 
+    if (s->current)
+        return;
+
     QTAILQ_FOREACH(p, &s->queue, next) {
         if (p->pending) {
             lsi_reselect(s, p);
@@ -1089,6 +1120,8 @@ static void lsi_wait_reselect(LSIState *s)
     }
 }
 
+#define SCRIPTS_LOAD_AND_STORE  0xe2340004
+
 static void lsi_execute_script(LSIState *s)
 {
     PCIDevice *pci_dev = PCI_DEVICE(s);
@@ -1096,10 +1129,16 @@ static void lsi_execute_script(LSIState *s)
     uint32_t addr, addr_high;
     int opcode;
     int insn_processed = 0;
+    uint32_t save_dsp = 0;
 
     s->istat1 |= LSI_ISTAT1_SRUN;
 again:
     insn_processed++;
+    if (s->next_dsp) {
+        save_dsp = s->dsp;
+        s->dsp = s->next_dsp;
+        DPRINTF("lsi_execute_script: setting up for wait_reselection...\n");
+    }
     insn = read_dword(s, s->dsp);
     if (!insn) {
         /* If we receive an empty opcode increment the DSP by 4 bytes
@@ -1107,6 +1146,12 @@ again:
         s->dsp += 4;
         goto again;
     }
+    if (s->want_resel && s->resel_dsp && (insn == SCRIPTS_LOAD_AND_STORE)) {
+        /* Reselection follows Load and Store */
+        DPRINTF("lsi_execute_script: detects want_resel...\n");
+        s->next_dsp = s->resel_dsp;
+        s->want_resel = 0;
+    }
     addr = read_dword(s, s->dsp + 4);
     addr_high = 0;
     DPRINTF("SCRIPTS dsp=%08x opcode %08x arg %08x\n", s->dsp, insn, addr);
@@ -1273,7 +1318,14 @@ again:
                 s->scntl1 &= ~LSI_SCNTL1_CON;
                 break;
             case 2: /* Wait Reselect */
+                if (!s->resel_dsp) {
+                    s->resel_dsp = s->dsp - 8;
+                }
                 if (!lsi_irq_on_rsl(s)) {
+                    if (save_dsp) {
+                        s->dsp = save_dsp;
+                        save_dsp = s->next_dsp = 0;
+                    }
                     lsi_wait_reselect(s);
                 }
                 break;
-- 
1.8.3.1
