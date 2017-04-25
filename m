Received: from eggs.gnu.org ([2001:4830:134:3::10]:35194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d30Ax-0000QQ-0H
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d30Ar-0000uY-02
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:06:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1d30Aq-0000sv-Pw
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:06:32 -0400
From: P J P <ppandit@redhat.com>
Date: Tue, 25 Apr 2017 18:36:23 +0530
Message-Id: <20170425130623.3649-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] vmw_pvscsi: check message ring page count at
 initialisation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, YY Z <bigbird475958471@gmail.com>, Dmitry Fleytman <dmitry@daynix.com>, P J P <ppandit@redhat.com>

Vmware Paravirtual SCSI emulation uses command descriptors to
process SCSI commands. These come with their message ring buffers.
A guest could set the message ring page count to an arbitrary value
resulting in infinite loop. Add check to avoid it.

Reported-by: YY Z <bigbird475958471@gmail.com>
Signed-off-by: P J P <ppandit@redhat.com>
---
 hw/scsi/vmw_pvscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 7557546..4a106da 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -202,7 +202,7 @@ pvscsi_ring_init_msg(PVSCSIRingInfo *m, PVSCSICmdDescSetupMsgRing *ri)
     uint32_t len_log2;
     uint32_t ring_size;
 
-    if (ri->numPages > PVSCSI_SETUP_MSG_RING_MAX_NUM_PAGES) {
+    if (!ri->numPages || ri->numPages > PVSCSI_SETUP_MSG_RING_MAX_NUM_PAGES) {
         return -1;
     }
     ring_size = ri->numPages * PVSCSI_MAX_NUM_MSG_ENTRIES_PER_PAGE;
-- 
2.9.3
