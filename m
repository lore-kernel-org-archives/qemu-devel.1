Received: from eggs.gnu.org ([2001:4830:134:3::10]:48313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa2B-00084D-Cg
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa2A-0002NV-HE
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gHa2A-0002MN-7e
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id u1-v6so14003950wrn.0
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 12:50:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Oct 2018 20:50:11 +0100
Message-Id: <1540929011-19894-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
References: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] lsi53c895a: check message length value is
 valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While writing a message in 'lsi_do_msgin', message length value
in 'msg_len' could be invalid due to an invalid migration stream.
Add an assertion to avoid an out of bounds access, and reject
the incoming migration data if it contains an invalid message
length.

Discovered by Deja vu Security. Reported by Oracle.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-Id: <20181026194314.18663-1-ppandit@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d1e6534..3f207f6 100644
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
1.8.3.1
