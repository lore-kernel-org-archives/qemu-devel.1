Received: from eggs.gnu.org ([2001:4830:134:3::10]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoP-0006Ut-QD
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoO-0007TW-Fk
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:19 +1000
Message-Id: <20170525035132.24268-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/18] spapr: Consolidate HPT freeing code into
 a routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Consolidate the code that frees HPT into a separate routine
spapr_free_hpt() as the same chunk of code is called from two places.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 13 +++++++++----
 hw/ppc/spapr_hcall.c   |  5 +----
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a9471b9..35dceb0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1227,16 +1227,21 @@ static int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
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
index 0d608d6..2daace4 100644
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
index 5802f88..93c4cfc 100644
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
2.9.4
