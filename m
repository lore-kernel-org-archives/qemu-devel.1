Received: from eggs.gnu.org ([2001:4830:134:3::10]:56329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApyy-0004GE-Om
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApyx-0000sX-RE
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49090
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dApyx-0000rl-MV
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:39 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4H3hiNa142551
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:50:39 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ag58n0mx6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:50:38 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 17 May 2017 13:50:35 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 09:19:21 +0530
In-Reply-To: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1494992962-6929-6-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 5/6] spapr: Unregister HPT savevm
 handlers for radix guests
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

HPT gets created by default and later when the guest turns out to be
a radix guest, the HPT is destroyed when guest does H_REGISTER_PROC_TBL
hcall. Let HTAB savevm handlers registration and unregistration follow
the same model so that we don't end up having unrequired HTAB savevm
handlers for radix guests.

This also ensures that HTAB savevm handlers seemlessly get destroyed and
recreated like HTAB itself when hash guest reboots.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         | 15 +++++++++++++--
 hw/ppc/spapr_hcall.c   |  1 +
 include/hw/ppc/spapr.h |  2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 521eef1..05abfc1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1237,6 +1237,7 @@ static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
 
     /* Clean up any HPT info from a previous boot */
     spapr_free_hpt(spapr);
+    spapr_htab_savevm_unregister(spapr);
 
     rc = kvmppc_reset_htab(shift);
     if (rc < 0) {
@@ -1275,6 +1276,7 @@ static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
             DIRTY_HPTE(HPTE(spapr->htab, i));
         }
     }
+    spapr_htab_savevm_register(spapr);
 }
 
 void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
@@ -1874,6 +1876,17 @@ static SaveVMHandlers savevm_htab_handlers = {
     .load_state = htab_load,
 };
 
+void spapr_htab_savevm_register(sPAPRMachineState *spapr)
+{
+    register_savevm_live(NULL, "spapr/htab", -1, 1,
+                         &savevm_htab_handlers, spapr);
+}
+
+void spapr_htab_savevm_unregister(sPAPRMachineState *spapr)
+{
+    unregister_savevm_live(NULL, "spapr/htab", spapr);
+}
+
 static void spapr_boot_set(void *opaque, const char *boot_device,
                            Error **errp)
 {
@@ -2336,8 +2349,6 @@ static void ppc_spapr_init(MachineState *machine)
      * interface, this is a legacy from the sPAPREnvironment structure
      * which predated MachineState but had a similar function */
     vmstate_register(NULL, 0, &vmstate_spapr, spapr);
-    register_savevm_live(NULL, "spapr/htab", -1, 1,
-                         &savevm_htab_handlers, spapr);
 
     /* used by RTAS */
     QTAILQ_INIT(&spapr->ccs_list);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index be79e3d..768aa57 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -914,6 +914,7 @@ static void spapr_check_setup_free_hpt(sPAPRMachineState *spapr,
     } else if (!(patbe_old & PATBE1_GR)) {
         /* HASH->RADIX : Free HPT */
         spapr_free_hpt(spapr);
+        spapr_htab_savevm_unregister(spapr);
     } else if (!(patbe_new & PATBE1_GR)) {
         /* RADIX->HASH || NOTHING->HASH : Allocate HPT */
         spapr_setup_hpt_and_vrma(spapr);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6f9cb85..5b39a26 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -636,6 +636,8 @@ void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
                                                uint32_t count, uint32_t index);
 void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
                                     sPAPRMachineState *spapr);
+void spapr_htab_savevm_register(sPAPRMachineState *spapr);
+void spapr_htab_savevm_unregister(sPAPRMachineState *spapr);
 
 /* rtas-configure-connector state */
 struct sPAPRConfigureConnectorState {
-- 
2.7.4
