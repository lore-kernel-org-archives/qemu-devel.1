Received: from eggs.gnu.org ([2001:4830:134:3::10]:45145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkN-00081D-Uh
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkN-0004IE-31
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:43 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gRMkM-0004Hv-TT
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:43 -0500
Received: by mail-wr1-x42e.google.com with SMTP id t27so12265244wra.6
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:40:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Nov 2018 20:40:23 +0100
Message-Id: <1543261235-2834-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
References: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/15] lsi: Reselection needed to remove pending
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
Cc: George Kennedy <george.kennedy@oracle.com>

From: George Kennedy <george.kennedy@oracle.com>

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

Now following a WAIT DISCONNECT Script instruction, and if there is no
current command, check for a pending command on the queue and if one
exists call lsi_reselect().

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Message-Id: <1541776692-12271-1-git-send-email-george.kennedy@oracle.com>
[For safety, add a s->current check in lsi_update_irq - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 3f207f6..52a3893 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -298,6 +298,18 @@ static inline int lsi_irq_on_rsl(LSIState *s)
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
@@ -446,7 +458,6 @@ static void lsi_update_irq(LSIState *s)
 {
     int level;
     static int last_level;
-    lsi_request *p;
 
     /* It's unclear whether the DIP/SIP bits should be cleared when the
        Interrupt Status Registers are cleared or when istat0 is read.
@@ -476,13 +487,13 @@ static void lsi_update_irq(LSIState *s)
     }
     lsi_set_irq(s, level);
 
-    if (!level && lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON)) {
+    if (!s->current && !level && lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON)) {
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
@@ -1065,11 +1076,12 @@ static void lsi_wait_reselect(LSIState *s)
 
     trace_lsi_wait_reselect();
 
-    QTAILQ_FOREACH(p, &s->queue, next) {
-        if (p->pending) {
-            lsi_reselect(s, p);
-            break;
-        }
+    if (s->current) {
+        return;
+    }
+    p = get_pending_req(s);
+    if (p) {
+        lsi_reselect(s, p);
     }
     if (s->current == NULL) {
         s->waiting = 1;
@@ -1259,6 +1271,18 @@ again:
             case 1: /* Disconnect */
                 trace_lsi_execute_script_io_disconnect();
                 s->scntl1 &= ~LSI_SCNTL1_CON;
+                /* FIXME: this is not entirely correct; the target need not ask
+                 * for reselection until it has to send data, while here we force a
+                 * reselection as soon as the bus is free.  The correct flow would
+                 * reselect before lsi_transfer_data and disconnect as soon as
+                 * DMA ends.
+                 */
+                if (!s->current) {
+                    lsi_request *p = get_pending_req(s);
+                    if (p) {
+                        lsi_reselect(s, p);
+                    }
+                }
                 break;
             case 2: /* Wait Reselect */
                 if (!lsi_irq_on_rsl(s)) {
-- 
1.8.3.1
