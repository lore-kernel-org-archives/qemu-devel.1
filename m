Received: from eggs.gnu.org ([2001:4830:134:3::10]:56366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApz0-0004Im-TL
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApyv-0000qQ-Sz
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48970
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dApyv-0000po-Nq
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4H3hhv5142499
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:50:37 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ag58n0mwc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:50:36 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 17 May 2017 13:50:34 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 09:19:20 +0530
In-Reply-To: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1494992962-6929-5-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 4/6] spapr: Consolidate HPT freeing code
 into a routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

Consolidate the code that frees HPT into a separate routine
spapr_free_hpt() as the same chunk of code is called from two places.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         | 13 +++++++++----
 hw/ppc/spapr_hcall.c   |  5 +----
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1b7cada..521eef1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1222,16 +1222,21 @@ static int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
     return shift;
 }
 
+void spapr_free_hpt(sPAPRMachineState *spapr)
+{
+    g_free(spapr->htab);
+    spapr->htab = NULL;
+    spapr->htab_shift = 0;
+    close_htab_fd(spapr);
+}
+
 static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
                                  Error **errp)
 {
     long rc;
 
     /* Clean up any HPT info from a previous boot */
-    g_free(spapr->htab);
-    spapr->htab = NULL;
-    spapr->htab_shift = 0;
-    close_htab_fd(spapr);
+    spapr_free_hpt(spapr);
 
     rc = kvmppc_reset_htab(shift);
     if (rc < 0) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 3600b0e..be79e3d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -913,10 +913,7 @@ static void spapr_check_setup_free_hpt(sPAPRMachineState *spapr,
         /* We assume RADIX, so this catches all the "Do Nothing" cases */
     } else if (!(patbe_old & PATBE1_GR)) {
         /* HASH->RADIX : Free HPT */
-        g_free(spapr->htab);
-        spapr->htab = NULL;
-        spapr->htab_shift = 0;
-        close_htab_fd(spapr);
+        spapr_free_hpt(spapr);
     } else if (!(patbe_new & PATBE1_GR)) {
         /* RADIX->HASH || NOTHING->HASH : Allocate HPT */
         spapr_setup_hpt_and_vrma(spapr);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a692e63..6f9cb85 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -610,6 +610,7 @@ int spapr_h_cas_compose_response(sPAPRMachineState *sm,
                                  sPAPROptionVector *ov5_updates);
 void close_htab_fd(sPAPRMachineState *spapr);
 void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr);
+void spapr_free_hpt(sPAPRMachineState *spapr);
 sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn);
 void spapr_tce_table_enable(sPAPRTCETable *tcet,
                             uint32_t page_shift, uint64_t bus_offset,
-- 
2.7.4
