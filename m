Received: from eggs.gnu.org ([2001:4830:134:3::10]:39626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFm1v-0001Vp-7c
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFlz0-00058w-Ad
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:11:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFlz0-00056g-4t
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:11:54 -0400
From: P J P <ppandit@redhat.com>
Date: Fri, 26 Oct 2018 01:39:44 +0530
Message-Id: <20181025200944.12113-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] lsi53c895a: check message length value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Ameya More <ameya.more@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While writing a message in 'lsi_do_msgin', message length value
in msg_len could be invalid, add check to avoid OOB access issue.

Reported-by: Ameya More <ameya.more@oracle.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/scsi/lsi53c895a.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d1e6534311..a266c5a113 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -205,7 +205,7 @@ typedef struct {
     /* Action to take at the end of a MSG IN phase.
        0 = COMMAND, 1 = disconnect, 2 = DATA OUT, 3 = DATA IN.  */
     int msg_action;
-    int msg_len;
+    uint8_t msg_len;
     uint8_t msg[LSI_MAX_MSGIN_LEN];
     /* 0 if SCRIPTS are running or stopped.
      * 1 if a Wait Reselect instruction has been issued.
@@ -861,12 +861,15 @@ static void lsi_do_status(LSIState *s)
 
 static void lsi_do_msgin(LSIState *s)
 {
-    int len;
+    uint8_t len;
     trace_lsi_do_msgin(s->dbc, s->msg_len);
     s->sfbr = s->msg[0];
     len = s->msg_len;
     if (len > s->dbc)
         len = s->dbc;
+    if (len > LSI_MAX_MSGIN_LEN) {
+        len = LSI_MAX_MSGIN_LEN;
+    }
     pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
     /* Linux drivers rely on the last byte being in the SIDL.  */
     s->sidl = s->msg[len - 1];
@@ -2114,7 +2117,7 @@ static const VMStateDescription vmstate_lsi_scsi = {
         VMSTATE_INT32(carry, LSIState),
         VMSTATE_INT32(status, LSIState),
         VMSTATE_INT32(msg_action, LSIState),
-        VMSTATE_INT32(msg_len, LSIState),
+        VMSTATE_UINT8(msg_len, LSIState),
         VMSTATE_BUFFER(msg, LSIState),
         VMSTATE_INT32(waiting, LSIState),
 
-- 
2.17.2
