Received: from eggs.gnu.org ([2001:4830:134:3::10]:47092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFG-0002KZ-Kx
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFD-0006df-NN
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFD-0006dS-Gk
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:51 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EBA7C056790
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 10:13:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:25 +0200
Message-Id: <20170505101337.4650-10-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/21] vmw_pvscsi: check message ring page count
 at initialisation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>

From: P J P <ppandit@redhat.com>

A guest could set the message ring page count to zero, resulting in
infinite loop. Add check to avoid it.

Reported-by: YY Z <bigbird475958471@gmail.com>
Signed-off-by: P J P <ppandit@redhat.com>
Message-Id: <20170425130623.3649-1-ppandit@redhat.com>
Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/vmw_pvscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 75575461e2..4a106da856 100644
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
2.12.2
