Received: from eggs.gnu.org ([2001:4830:134:3::10]:36032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gG83e-0002od-8A
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gG83Z-00051g-Fy
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:46:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gG83B-0004rw-5Q
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:46:05 -0400
From: P J P <ppandit@redhat.com>
Date: Sat, 27 Oct 2018 01:13:14 +0530
Message-Id: <20181026194314.18663-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v1] lsi53c895a: check message length value is
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
Cc: Mark Kanda <mark.kanda@oracle.com>, Ameya More <ameya.more@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While writing a message in 'lsi_do_msgin', message length value
in 'msg_len' could be invalid. Add check to avoid OOB access issue.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/scsi/lsi53c895a.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

Update v1: add .post_load routine and an assert() call
  -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05730.html

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d1e6534311..3a40e62853 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -861,12 +861,13 @@ static void lsi_do_status(LSIState *s)
 
 static void lsi_do_msgin(LSIState *s)
 {
-    int len;
+    uint8_t len;
     trace_lsi_do_msgin(s->dbc, s->msg_len);
     s->sfbr = s->msg[0];
     len = s->msg_len;
     if (len > s->dbc)
         len = s->dbc;
+    assert(len <= LSI_MAX_MSGIN_LEN);
     pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
     /* Linux drivers rely on the last byte being in the SIDL.  */
     s->sidl = s->msg[len - 1];
@@ -2103,11 +2104,23 @@ static int lsi_pre_save(void *opaque)
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
