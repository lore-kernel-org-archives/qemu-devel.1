Received: from eggs.gnu.org ([2001:4830:134:3::10]:41987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBY-0001lW-Od
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBV-000117-Lo
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53919
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBV-00010l-Et
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:09 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0haM9084806
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:08 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdme90ra-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:08 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:08 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:04 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-11-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 10/67] scsi: pvscsi: limit process IO loop to
 ring size
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

Vmware Paravirtual SCSI emulator while processing IO requests
could run into an infinite loop if 'pvscsi_ring_pop_req_descr'
always returned positive value. Limit IO loop to the ring size.

Cc: qemu-stable@nongnu.org
Reported-by: Li Qiang <liqiang6-s@360.cn>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-Id: <1473845952-30785-1-git-send-email-ppandit@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d251157ac1928191af851d199a9ff255d330bec9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/vmw_pvscsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 5116f4a..aaaae0a 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -251,8 +251,11 @@ static hwaddr
 pvscsi_ring_pop_req_descr(PVSCSIRingInfo *mgr)
 {
     uint32_t ready_ptr = RS_GET_FIELD(mgr, reqProdIdx);
+    uint32_t ring_size = PVSCSI_MAX_NUM_PAGES_REQ_RING
+                            * PVSCSI_MAX_NUM_REQ_ENTRIES_PER_PAGE;
 
-    if (ready_ptr != mgr->consumed_ptr) {
+    if (ready_ptr != mgr->consumed_ptr
+        && ready_ptr - mgr->consumed_ptr < ring_size) {
         uint32_t next_ready_ptr =
             mgr->consumed_ptr++ & mgr->txr_len_mask;
         uint32_t next_ready_page =
-- 
1.9.1
