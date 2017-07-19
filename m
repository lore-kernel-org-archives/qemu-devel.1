Received: from eggs.gnu.org ([2001:4830:134:3::10]:34266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dXkkv-0002uo-W1
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dXkks-0004iH-AR
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:54:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dXkks-0004hb-0j
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:54:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6J8siLK025732
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:54:48 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bsxfjd8nk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:54:47 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 19 Jul 2017 18:54:23 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 19 Jul 2017 14:24:09 +0530
Message-Id: <1500454449-29557-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [FIX PATCH] spapr: Fix QEMU abort during memory unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, Bharata B Rao <bharata@linux.vnet.ibm.com>

Commit 0cffce56 (hw/ppc/spapr.c: adding pending_dimm_unplugs to
sPAPRMachineState) introduced a new way to track pending LMBs of DIMM
device that is marked for removal. Since this commit we can hit the
assert in spapr_pending_dimm_unplugs_add() in the following situation:

- DIMM device removal fails as the guest doesn't allow the removal.
- Subsequent attempt to remove the same DIMM would hit the assert
  as the corresponding sPAPRDIMMState is still part of the
  pending_dimm_unplugs list.

Fix this by removing the assert and conditionally adding the
sPAPRDIMMState to pending_dimm_unplugs list only when it is not
already present.

Fixes: 0cffce56ae3501c5783d779f97993ce478acf856
Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1cb09e7..990bb2d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2853,8 +2853,9 @@ static sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState *s,
 static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
                                            sPAPRDIMMState *dimm_state)
 {
-    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm));
-    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
+    if (!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm)) {
+        QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
+    }
 }
 
 static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
-- 
2.7.4
