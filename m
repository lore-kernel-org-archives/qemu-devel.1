Received: from eggs.gnu.org ([2001:4830:134:3::10]:57596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1d7fHp-0004ta-Lt
	for qemu-devel@nongnu.org; Mon, 08 May 2017 05:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1d7fHk-0008Ek-PK
	for qemu-devel@nongnu.org; Mon, 08 May 2017 05:49:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1d7fHk-0008EY-Fr
	for qemu-devel@nongnu.org; Mon, 08 May 2017 05:48:56 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v489mrDs003162
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 05:48:55 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aaky5r4ht-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 05:48:54 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Mon, 8 May 2017 19:09:48 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Mon,  8 May 2017 14:36:17 +0530
In-Reply-To: <1494234377-1773-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1494234377-1773-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1494234377-1773-3-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 2/2] spapr: Fix migration of Radix guests
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

Currently HTAB savevm handlers get registered by default and migration
of radix guest will fail.

- Ensure that HTAB savevm handlers are not registered for radix case.
- Ensure that we issue KVM_PPC_CONFIGURE_V3_MMU for radix case post
  migration.

TODO: Right now I have delayed the HTAB savevm handler registration
to CAS call where we know if the guest is radix or hash. Another approach
is to let the HTAB handlers to be registered by default (as it is being
done currently, but unregister them from CAS when we discover radix
capability).

Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         | 18 +++++++++++++++---
 hw/ppc/spapr_hcall.c   |  5 +++++
 include/hw/ppc/spapr.h |  3 +++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e2dc77c..e14f55c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1436,6 +1436,14 @@ static int spapr_post_load(void *opaque, int version_id)
         err = spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
     }
 
+    if (spapr->patb_entry && (spapr->patb_flags & SPAPR_PROC_TABLE_RADIX) &&
+        kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
+        err = kvmppc_configure_v3_mmu(POWERPC_CPU(first_cpu),
+                                      spapr->patb_flags &
+                                      SPAPR_PROC_TABLE_RADIX,
+                                      spapr->patb_flags & SPAPR_PROC_TABLE_GTSE,
+                                      spapr->patb_entry);
+    }
     return err;
 }
 
@@ -1520,6 +1528,7 @@ static const VMStateDescription vmstate_spapr_patb_entry = {
     .needed = spapr_patb_entry_needed,
     .fields = (VMStateField[]) {
         VMSTATE_UINT64(patb_entry, sPAPRMachineState),
+        VMSTATE_UINT64(patb_flags, sPAPRMachineState),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -1869,6 +1878,12 @@ static SaveVMHandlers savevm_htab_handlers = {
     .load_state = htab_load,
 };
 
+void spapr_htab_savevm_register(sPAPRMachineState *spapr)
+{
+    register_savevm_live(NULL, "spapr/htab", -1, 1,
+                         &savevm_htab_handlers, spapr);
+}
+
 static void spapr_boot_set(void *opaque, const char *boot_device,
                            Error **errp)
 {
@@ -2331,9 +2346,6 @@ static void ppc_spapr_init(MachineState *machine)
      * interface, this is a legacy from the sPAPREnvironment structure
      * which predated MachineState but had a similar function */
     vmstate_register(NULL, 0, &vmstate_spapr, spapr);
-    register_savevm_live(NULL, "spapr/htab", -1, 1,
-                         &savevm_htab_handlers, spapr);
-
     /* used by RTAS */
     QTAILQ_INIT(&spapr->ccs_list);
     qemu_register_reset(spapr_ccs_reset_hook, spapr);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 3600b0e..fa03ca0 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -988,6 +988,7 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
     spapr_check_setup_free_hpt(spapr, spapr->patb_entry, cproc);
 
     spapr->patb_entry = cproc; /* Save new process table */
+    spapr->patb_flags = flags; /* Save the flags */
 
     /* Update the UPRT and GTSE bits in the LPCR for all cpus */
     CPU_FOREACH(cs) {
@@ -1169,6 +1170,10 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         }
     }
 
+    /* Register savevm handlers for HTAB case */
+    if (!guest_radix || !kvmppc_has_cap_mmu_radix()) {
+        spapr_htab_savevm_register(spapr);
+    }
     return H_SUCCESS;
 }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a692e63..0d0e9e4 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -75,6 +75,7 @@ struct sPAPRMachineState {
     void *htab;
     uint32_t htab_shift;
     uint64_t patb_entry; /* Process tbl registed in H_REGISTER_PROCESS_TABLE */
+    uint64_t patb_flags;
     hwaddr rma_size;
     int vrma_adjust;
     ssize_t rtas_size;
@@ -691,4 +692,6 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 #define SPAPR_PROC_TABLE_HPT_PT      0x02
 #define SPAPR_PROC_TABLE_GTSE        0x01
 
+void spapr_htab_savevm_register(sPAPRMachineState *spapr);
+
 #endif /* HW_SPAPR_H */
-- 
2.7.4
