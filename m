Received: from eggs.gnu.org ([2001:4830:134:3::10]:54359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1gHbqU-0004A6-R1
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1gHbq9-00050m-Jq
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:46:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <george.kennedy@oracle.com>)
	id 1gHbq8-0004uy-0p
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:46:21 -0400
From: George Kennedy <george.kennedy@oracle.com>
Date: Tue, 30 Oct 2018 17:42:47 -0400
Message-Id: <1540935767-21467-1-git-send-email-george.kennedy@oracle.com>
Subject: [Qemu-devel] [PATCH v3] lsi_scsi: Reselection needed to remove
 pending commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, george.kennedy@oracle.com, boris.ostrovsky@oracle.com

Under heavy IO (e.g. fio) the queue is not checked frequently enough for
pending commands. As a result some pending commands are timed out by the
linux sym53c8xx driver, which sends SCSI Abort messages for the timed out
commands. The SCSI Abort messages result in linux errors, which show up
on the console and in /var/log/messages.

e.g.
sd 0:0:3:0: [sdd] tag#33 ABORT operation started
scsi target0:0:3: control msgout:
80 20 47 d
sd 0:0:3:0: ABORT operation complete.
scsi target0:0:4: message d sent on bad reselection

When the current command completes, check if there is a pending command
on the queue and if a pending command exists, set a flag indicating
that a Wait Reselect command is needed to handle a queued pending command.

When a Wait Reselect is needed, intercept and save the current DMA Scripts
Ptr (DSP) contents and load it instead with the pointer to the Reselection
Scripts.  When Reselection has completed, restore the original DSP contents.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 hw/scsi/lsi53c895a.c | 51 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d1e6534..b783d72 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -219,6 +219,8 @@ typedef struct {
     int command_complete;
     QTAILQ_HEAD(, lsi_request) queue;
     lsi_request *current;
+    bool want_resel;    /* need resel to handle queued completed cmds */
+    uint32_t resel_dsp; /* DMA Scripts Ptr (DSP) of reselection scsi scripts */
 
     uint32_t dsa;
     uint32_t temp;
@@ -298,6 +300,18 @@ static inline int lsi_irq_on_rsl(LSIState *s)
     return (s->sien0 & LSI_SIST0_RSL) && (s->scid & LSI_SCID_RRE);
 }
 
+static lsi_request *get_pending_req(LSIState *s)
+{
+    lsi_request *p;
+
+    QTAILQ_FOREACH(p, &s->queue, next) {
+        if (p->pending) {
+            return p;
+        }
+    }
+    return NULL;
+}
+
 static void lsi_soft_reset(LSIState *s)
 {
     trace_lsi_reset();
@@ -446,7 +460,6 @@ static void lsi_update_irq(LSIState *s)
 {
     int level;
     static int last_level;
-    lsi_request *p;
 
     /* It's unclear whether the DIP/SIP bits should be cleared when the
        Interrupt Status Registers are cleared or when istat0 is read.
@@ -477,12 +490,12 @@ static void lsi_update_irq(LSIState *s)
     lsi_set_irq(s, level);
 
     if (!level && lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON)) {
+        lsi_request *p;
+
         trace_lsi_update_irq_disconnected();
-        QTAILQ_FOREACH(p, &s->queue, next) {
-            if (p->pending) {
-                lsi_reselect(s, p);
-                break;
-            }
+        p = get_pending_req(s);
+        if (p) {
+            lsi_reselect(s, p);
         }
     }
 }
@@ -759,6 +772,8 @@ static void lsi_command_complete(SCSIRequest *req, uint32_t status, size_t resid
         lsi_request_free(s, s->current);
         scsi_req_unref(req);
     }
+    s->want_resel = get_pending_req(s) ? true : false;
+
     lsi_resume_script(s);
 }
 
@@ -1064,11 +1079,13 @@ static void lsi_wait_reselect(LSIState *s)
 
     trace_lsi_wait_reselect();
 
-    QTAILQ_FOREACH(p, &s->queue, next) {
-        if (p->pending) {
-            lsi_reselect(s, p);
-            break;
-        }
+    if (s->current) {
+        return;
+    }
+
+    p = get_pending_req(s);
+    if (p) {
+        lsi_reselect(s, p);
     }
     if (s->current == NULL) {
         s->waiting = 1;
@@ -1082,6 +1099,7 @@ static void lsi_execute_script(LSIState *s)
     uint32_t addr, addr_high;
     int opcode;
     int insn_processed = 0;
+    uint32_t save_dsp = 0;
 
     s->istat1 |= LSI_ISTAT1_SRUN;
 again:
@@ -1260,7 +1278,14 @@ again:
                 s->scntl1 &= ~LSI_SCNTL1_CON;
                 break;
             case 2: /* Wait Reselect */
+                if (!s->resel_dsp) {
+                    s->resel_dsp = s->dsp - 8;
+                }
                 if (!lsi_irq_on_rsl(s)) {
+                    if (save_dsp) {
+                        s->dsp = save_dsp;
+                        save_dsp = 0;
+                    }
                     lsi_wait_reselect(s);
                 }
                 break;
@@ -1476,6 +1501,10 @@ again:
 
             if (insn & (1 << 28)) {
                 addr = s->dsa + sextract32(addr, 0, 24);
+            } else if (s->want_resel && s->resel_dsp && !(insn & (1 << 24))) {
+                save_dsp = s->dsp;
+                s->dsp = s->resel_dsp;
+                s->want_resel = false;
             }
             n = (insn & 7);
             reg = (insn >> 16) & 0xff;
-- 
1.8.3.1
