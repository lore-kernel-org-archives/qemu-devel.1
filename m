Received: from eggs.gnu.org ([2001:4830:134:3::10]:53220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gHQQB-0000oI-CG
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gHQQ7-0003zk-A5
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:34:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gHQQ7-0003wl-3h
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:34:43 -0400
From: P J P <ppandit@redhat.com>
Date: Tue, 30 Oct 2018 15:02:32 +0530
Message-Id: <20181030093232.15660-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v3] lsi53c895a: check message length value is
 valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Ameya More <ameya.more@oracle.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While writing a message in 'lsi_do_msgin', message length value
in 'msg_len' could be invalid. Add check to avoid OOB access issue.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/scsi/lsi53c895a.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

Update v3: modify assert to say s->msg_len > 0
  -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06392.html

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d1e6534311..3f207f607c 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -861,10 +861,11 @@ static void lsi_do_status(LSIState *s)
 
 static void lsi_do_msgin(LSIState *s)
 {
-    int len;
+    uint8_t len;
     trace_lsi_do_msgin(s->dbc, s->msg_len);
     s->sfbr = s->msg[0];
     len = s->msg_len;
+    assert(len > 0 && len <= LSI_MAX_MSGIN_LEN);
     if (len > s->dbc)
         len = s->dbc;
     pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
@@ -1705,8 +1706,10 @@ static uint8_t lsi_reg_readb(LSIState *s, int offset)
         break;
     case 0x58: /* SBDL */
         /* Some drivers peek at the data bus during the MSG IN phase.  */
-        if ((s->sstat1 & PHASE_MASK) == PHASE_MI)
+        if ((s->sstat1 & PHASE_MASK) == PHASE_MI) {
+            assert(s->msg_len > 0);
             return s->msg[0];
+        }
         ret = 0;
         break;
     case 0x59: /* SBDL high */
@@ -2103,11 +2106,23 @@ static int lsi_pre_save(void *opaque)
     return 0;
 }
 
+static int lsi_post_load(void *opaque, int version_id)
+{
+    LSIState *s = opaque;
+
+    if (s->msg_len < 0 || s->msg_len > LSI_MAX_MSGIN_LEN) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_lsi_scsi = {
     .name = "lsiscsi",
     .version_id = 0,
     .minimum_version_id = 0,
     .pre_save = lsi_pre_save,
+    .post_load = lsi_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, LSIState),
 
-- 
2.17.2
