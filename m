Received: from eggs.gnu.org ([2001:4830:134:3::10]:56401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApz4-0004LQ-Rv
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApz0-0000vo-5y
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35173
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dApz0-0000vN-1N
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4H3hjmm172608
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:50:41 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2agemcrpsj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:50:40 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 17 May 2017 13:50:38 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 09:19:22 +0530
In-Reply-To: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1494992962-6929-7-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 6/6] spapr: Fix migration of Radix guests
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

Fix migration of radix guests by ensuring that we issue
KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.

Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         | 15 +++++++++++++++
 hw/ppc/spapr_hcall.c   |  1 +
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 05abfc1..dd1d687 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1443,6 +1443,20 @@ static int spapr_post_load(void *opaque, int version_id)
         err = spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
     }
 
+    if (spapr->patb_entry) {
+        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
+            err = kvmppc_configure_v3_mmu(POWERPC_CPU(first_cpu),
+                                          spapr->patb_flags &
+                                          SPAPR_PROC_TABLE_RADIX,
+                                          spapr->patb_flags &
+                                          SPAPR_PROC_TABLE_GTSE,
+                                          spapr->patb_entry);
+        } else {
+            error_report("Radix guest is unsupported by the host");
+            return -EINVAL;
+        }
+    }
+
     return err;
 }
 
@@ -1527,6 +1541,7 @@ static const VMStateDescription vmstate_spapr_patb_entry = {
     .needed = spapr_patb_entry_needed,
     .fields = (VMStateField[]) {
         VMSTATE_UINT64(patb_entry, sPAPRMachineState),
+        VMSTATE_UINT64(patb_flags, sPAPRMachineState),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 768aa57..b002fae 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -986,6 +986,7 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
     spapr_check_setup_free_hpt(spapr, spapr->patb_entry, cproc);
 
     spapr->patb_entry = cproc; /* Save new process table */
+    spapr->patb_flags = flags; /* Save the flags */
 
     /* Update the UPRT and GTSE bits in the LPCR for all cpus */
     CPU_FOREACH(cs) {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5b39a26..c25a32e 100644
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
-- 
2.7.4
