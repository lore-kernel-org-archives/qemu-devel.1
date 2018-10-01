Received: from eggs.gnu.org ([2001:4830:134:3::10]:44348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1g75Ce-00064T-HL
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 16:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1g759Y-0004Vr-79
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 16:50:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <george.kennedy@oracle.com>)
	id 1g759X-0004VL-TO
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 16:50:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w91KmoGM023864
	for <qemu-devel@nongnu.org>; Mon, 1 Oct 2018 20:50:49 GMT
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp2120.oracle.com with ESMTP id 2mt1bpsycj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 20:50:49 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w91KomD1010246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Mon, 1 Oct 2018 20:50:48 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w91Kom8r017538
	for <qemu-devel@nongnu.org>; Mon, 1 Oct 2018 20:50:48 GMT
From: George Kennedy <george.kennedy@oracle.com>
Date: Mon,  1 Oct 2018 16:48:19 -0400
Message-Id: <1538426899-17560-1-git-send-email-george.kennedy@oracle.com>
Subject: [Qemu-devel] [PATCH] lsi: Reselection needed to remove pending
 commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
 hw/scsi/lsi53c895a.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 996b406..1e38ceb 100644
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
@@ -310,6 +314,44 @@ static inline int lsi_irq_on_rsl(LSIState *s)
 {
     return (s->sien0 & LSI_SIST0_RSL) && (s->scid & LSI_SCID_RRE);
 }
+#ifdef DEBUG_LSI
+static void showq(LSIState *s)
+{
+    lsi_request *p;
+    int count = 0;
+
+    QTAILQ_FOREACH(p, &s->queue, next) {
+        DPRINTF("%d: tag=%x, pending=%x, deadline=%lx\n",
+            count++, p->tag, p->pending, p->deadline);
+    }
+}
+
+static int get_pending_count(LSIState *s)
+{
+    lsi_request *p;
+    int count = 0;
+
+    QTAILQ_FOREACH(p, &s->queue, next) {
+        if (p->pending) {
+            count++;
+        }
+    }
+    return count;
+}
+#endif
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
 
 static void lsi_soft_reset(LSIState *s)
 {
@@ -634,15 +676,22 @@ static void lsi_do_dma(LSIState *s, int out)
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
 
@@ -668,6 +717,8 @@ static void lsi_reselect(LSIState *s, lsi_request *p)
 
     assert(s->current == NULL);
     QTAILQ_REMOVE(&s->queue, p, next);
+    DPRINTF("lsi_reselect: p->tag=%x, p->pending=%x, p->deadline=%lx\n",
+        p->tag, p->pending, p->deadline);
     s->current = p;
 
     id = (p->tag >> 8) & 0xf;
@@ -775,6 +826,10 @@ static void lsi_command_complete(SCSIRequest *req, uint32_t status, size_t resid
         lsi_request_free(s, s->current);
         scsi_req_unref(req);
     }
+    if (pending_past_deadline(s)) {
+        DPRINTF("lsi_command_complete: want_resel = 1\n");
+        s->want_resel = 1;
+    }
     lsi_resume_script(s);
 }
 
@@ -987,7 +1042,7 @@ static void lsi_do_msgout(LSIState *s)
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             break;
         case 0x22: /* ORDERED queue */
-            BADF("ORDERED queue not implemented\n");
+            DPRINTF("ORDERED queue not implemented\n");
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             break;
         case 0x0d:
@@ -1075,8 +1130,17 @@ static void lsi_memcpy(LSIState *s, uint32_t dest, uint32_t src, int count)
 static void lsi_wait_reselect(LSIState *s)
 {
     lsi_request *p;
+#ifdef DEBUG_LSI
+    int pending_count = get_pending_count(s);
 
-    DPRINTF("Wait Reselect\n");
+    if (pending_count) {
+        DPRINTF("Wait Reselect, s->current=%p, pending_count=%d\n",
+            s->current, pending_count);
+        showq(s);
+    }
+#endif
+    if (s->current)
+        return;
 
     QTAILQ_FOREACH(p, &s->queue, next) {
         if (p->pending) {
@@ -1089,6 +1153,9 @@ static void lsi_wait_reselect(LSIState *s)
     }
 }
 
+#define SCRIPTS_LOAD_AND_STORE  0xe2340004
+#define SCRIPTS_WAIT_RESELECT   0x50000000
+
 static void lsi_execute_script(LSIState *s)
 {
     PCIDevice *pci_dev = PCI_DEVICE(s);
@@ -1096,10 +1163,16 @@ static void lsi_execute_script(LSIState *s)
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
@@ -1107,9 +1180,18 @@ again:
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
-    DPRINTF("SCRIPTS dsp=%08x opcode %08x arg %08x\n", s->dsp, insn, addr);
+    if ((insn == SCRIPTS_WAIT_RESELECT) && !s->resel_dsp) {
+        s->resel_dsp = s->dsp;    /* save resel dsp for later use */
+        DPRINTF("lsi_execute_script: s->resel_dsp=%x\n", s->resel_dsp);
+    }
     s->dsps = addr;
     s->dcmd = insn >> 24;
     s->dsp += 8;
@@ -1273,7 +1355,13 @@ again:
                 s->scntl1 &= ~LSI_SCNTL1_CON;
                 break;
             case 2: /* Wait Reselect */
+                DPRINTF("Wait Reselect\n");
                 if (!lsi_irq_on_rsl(s)) {
+                    if (save_dsp) {
+                        DPRINTF("Restore original s->dsp=%x\n", save_dsp);
+                        s->dsp = save_dsp;
+                        save_dsp = s->next_dsp = 0;
+                    }
                     lsi_wait_reselect(s);
                 }
                 break;
-- 
1.8.3.1
