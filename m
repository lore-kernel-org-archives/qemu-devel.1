Received: from eggs.gnu.org ([2001:4830:134:3::10]:42080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBc-0001v4-KO
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBa-00015G-1V
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBZ-000145-P7
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:13 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0haOi064443
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:12 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bgh8h34y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:12 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:11 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:07 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-14-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 13/67] vmw_pvscsi: check page count while
 initialising descriptor rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Prasad J Pandit <pjp@fedoraproject.org>

Vmware Paravirtual SCSI emulation uses command descriptors to
process SCSI commands. These descriptors come with their ring
buffers. A guest could set the page count for these rings to
an arbitrary value, leading to infinite loop or OOB access.
Add check to avoid it.

Reported-by: Tom Victor <vv474172261@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-Id: <1472626169-12989-1-git-send-email-ppandit@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 7f61f4690dd153be98900a2a508b88989e692753)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/vmw_pvscsi.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index aaaae0a..4d94b36 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -152,7 +152,7 @@ pvscsi_log2(uint32_t input)
     return log;
 }
 
-static int
+static void
 pvscsi_ring_init_data(PVSCSIRingInfo *m, PVSCSICmdDescSetupRings *ri)
 {
     int i;
@@ -160,10 +160,6 @@ pvscsi_ring_init_data(PVSCSIRingInfo *m, PVSCSICmdDescSetupRings *ri)
     uint32_t req_ring_size, cmp_ring_size;
     m->rs_pa = ri->ringsStatePPN << VMW_PAGE_SHIFT;
 
-    if ((ri->reqRingNumPages > PVSCSI_SETUP_RINGS_MAX_NUM_PAGES)
-        || (ri->cmpRingNumPages > PVSCSI_SETUP_RINGS_MAX_NUM_PAGES)) {
-        return -1;
-    }
     req_ring_size = ri->reqRingNumPages * PVSCSI_MAX_NUM_REQ_ENTRIES_PER_PAGE;
     cmp_ring_size = ri->cmpRingNumPages * PVSCSI_MAX_NUM_CMP_ENTRIES_PER_PAGE;
     txr_len_log2 = pvscsi_log2(req_ring_size - 1);
@@ -195,8 +191,6 @@ pvscsi_ring_init_data(PVSCSIRingInfo *m, PVSCSICmdDescSetupRings *ri)
 
     /* Flush ring state page changes */
     smp_wmb();
-
-    return 0;
 }
 
 static int
@@ -749,7 +743,7 @@ pvscsi_dbg_dump_tx_rings_config(PVSCSICmdDescSetupRings *rc)
 
     trace_pvscsi_tx_rings_num_pages("Confirm Ring", rc->cmpRingNumPages);
     for (i = 0; i < rc->cmpRingNumPages; i++) {
-        trace_pvscsi_tx_rings_ppn("Confirm Ring", rc->reqRingPPNs[i]);
+        trace_pvscsi_tx_rings_ppn("Confirm Ring", rc->cmpRingPPNs[i]);
     }
 }
 
@@ -782,11 +776,16 @@ pvscsi_on_cmd_setup_rings(PVSCSIState *s)
 
     trace_pvscsi_on_cmd_arrived("PVSCSI_CMD_SETUP_RINGS");
 
-    pvscsi_dbg_dump_tx_rings_config(rc);
-    if (pvscsi_ring_init_data(&s->rings, rc) < 0) {
+    if (!rc->reqRingNumPages
+        || rc->reqRingNumPages > PVSCSI_SETUP_RINGS_MAX_NUM_PAGES
+        || !rc->cmpRingNumPages
+        || rc->cmpRingNumPages > PVSCSI_SETUP_RINGS_MAX_NUM_PAGES) {
         return PVSCSI_COMMAND_PROCESSING_FAILED;
     }
 
+    pvscsi_dbg_dump_tx_rings_config(rc);
+    pvscsi_ring_init_data(&s->rings, rc);
+
     s->rings_info_valid = TRUE;
     return PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
 }
-- 
1.9.1
