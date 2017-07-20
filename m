Received: from eggs.gnu.org ([2001:4830:134:3::10]:44749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dY2p6-0004XB-Pp
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 00:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dY2p1-0006Ti-Vz
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 00:12:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dY2p1-0006TB-MB
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 00:12:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6K48rMZ059671
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 00:12:17 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2btc8ft8q9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 00:12:17 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 20 Jul 2017 14:12:15 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Thu, 20 Jul 2017 09:41:19 +0530
Message-Id: <1500523879-23860-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [FIX PATCH v1] spapr: Fix QEMU abort during memory
 unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, danielhb@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

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
Changes in v1:
- Added comment (David Gibson)
- Ensured we free sPAPRDIMMState when corresonding entry already
  exists (Daniel Henrique Barboza)

Daniel had shown another alternative, we can switch over to that
if preferred.

 hw/ppc/spapr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1cb09e7..c6091e2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2853,8 +2853,17 @@ static sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState *s,
 static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
                                            sPAPRDIMMState *dimm_state)
 {
-    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm));
-    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
+    /*
+     * If this request is for a DIMM whose removal had failed earlier
+     * (due to guest's refusal to remove the LMBs), we would have this
+     * dimm_state already in the pending_dimm_unplugs list. In that
+     * case don't add again.
+     */
+    if (!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm)) {
+        QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
+    } else {
+        g_free(dimm_state);
+    }
 }
 
 static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
-- 
2.7.4
