Received: from eggs.gnu.org ([2001:4830:134:3::10]:42731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1gL8bm-0001gX-Uv
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1gL8bj-0004lP-P4
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:22:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <george.kennedy@oracle.com>)
	id 1gL8bj-0004Xy-F5
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:22:03 -0500
From: George Kennedy <george.kennedy@oracle.com>
Date: Fri,  9 Nov 2018 10:18:12 -0500
Message-Id: <1541776692-12271-1-git-send-email-george.kennedy@oracle.com>
Subject: [Qemu-devel] [PATCH v7] lsi: Reselection needed to remove pending
 commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, boris.ostrovsky@oracle.com

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
---
Thanks again Paolo,

Your latest suggested fix reduces the patch even further. Now there's
no need for a "pending" flag.

(Will try to find the intermediary patches and mail them offlist).

 hw/scsi/lsi53c895a.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d1e6534..959b893 100644
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
@@ -477,12 +488,12 @@ static void lsi_update_irq(LSIState *s)
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
@@ -1064,11 +1075,12 @@ static void lsi_wait_reselect(LSIState *s)
 
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
@@ -1258,6 +1270,12 @@ again:
             case 1: /* Disconnect */
                 trace_lsi_execute_script_io_disconnect();
                 s->scntl1 &= ~LSI_SCNTL1_CON;
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
