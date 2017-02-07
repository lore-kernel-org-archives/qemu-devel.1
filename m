Received: from eggs.gnu.org ([2001:4830:134:3::10]:51878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavz5-0005Oe-RI
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavz2-0002xN-QE
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35009
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cavz2-0002x8-LF
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:20 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v172rx2Q137402
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 21:58:20 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28f0efag3k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 21:58:19 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 7 Feb 2017 12:58:17 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue,  7 Feb 2017 13:56:48 +1100
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
Message-Id: <f04bb6a57aa50c7c75762e3479252f2ee3fa385a.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 5/9] spapr: Only setup HTP if necessary.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Because KVM cannot support radix and hash modes concurrently, QEMU can
avoid allocating a hash page table if KVM supports radix mode.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/ppc/spapr.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d629e2630c..1411e470c0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1150,15 +1150,17 @@ static void ppc_spapr_reset(void)
     /* Check for unknown sysbus devices */
     foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
 
-    /* Allocate and/or reset the hash page table */
-    spapr_reallocate_hpt(spapr,
+    if (!kvmppc_has_cap_mmu_radix()) {
+        /* Allocate and/or reset the hash page table */
+        spapr_reallocate_hpt(spapr,
                          spapr_hpt_shift_for_ramsize(machine->maxram_size),
                          &error_fatal);
 
-    /* Update the RMA size if necessary */
-    if (spapr->vrma_adjust) {
-        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(),
-                                          spapr->htab_shift);
+        /* Update the RMA size if necessary */
+        if (spapr->vrma_adjust) {
+            spapr->rma_size = kvmppc_rma_size(spapr_node0_size(),
+                                              spapr->htab_shift);
+        }
     }
 
     qemu_devices_reset();
-- 
2.11.0
