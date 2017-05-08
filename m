Received: from eggs.gnu.org ([2001:4830:134:3::10]:57510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1d7fHR-0004eQ-CM
	for qemu-devel@nongnu.org; Mon, 08 May 2017 05:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1d7fHM-00089z-EQ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 05:48:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33048
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1d7fHM-00089U-8Q
	for qemu-devel@nongnu.org; Mon, 08 May 2017 05:48:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v489YD9M046468
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 05:48:30 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aamkwwntj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 05:48:30 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Mon, 8 May 2017 19:09:46 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Mon,  8 May 2017 14:36:16 +0530
In-Reply-To: <1494234377-1773-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1494234377-1773-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1494234377-1773-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 1/2] spapr: Make h_register_process_table
 hcall flags global
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

The flags used in h_register_process_table hcall are needed in spapr.c
and hence move them to a header file. While doing so, give them
slightly specific names.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr_hcall.c   | 31 ++++++++++++++-----------------
 include/hw/ppc/spapr.h | 10 ++++++++++
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 0d608d6..3600b0e 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -924,13 +924,6 @@ static void spapr_check_setup_free_hpt(sPAPRMachineState *spapr,
     return;
 }
 
-#define FLAGS_MASK              0x01FULL
-#define FLAG_MODIFY             0x10
-#define FLAG_REGISTER           0x08
-#define FLAG_RADIX              0x04
-#define FLAG_HASH_PROC_TBL      0x02
-#define FLAG_GTSE               0x01
-
 static target_ulong h_register_process_table(PowerPCCPU *cpu,
                                              sPAPRMachineState *spapr,
                                              target_ulong opcode,
@@ -943,12 +936,13 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
     target_ulong table_size = args[3];
     uint64_t cproc;
 
-    if (flags & ~FLAGS_MASK) { /* Check no reserved bits are set */
+    if (flags & ~SPAPR_PROC_TABLE_MASK) { /* Check no reserved bits are set */
         return H_PARAMETER;
     }
-    if (flags & FLAG_MODIFY) {
-        if (flags & FLAG_REGISTER) {
-            if (flags & FLAG_RADIX) { /* Register new RADIX process table */
+    if (flags & SPAPR_PROC_TABLE_MODIFY) {
+        if (flags & SPAPR_PROC_TABLE_REGISTER) {
+            if (flags & SPAPR_PROC_TABLE_RADIX) {
+                /* Register new RADIX process table */
                 if (proc_tbl & 0xfff || proc_tbl >> 60) {
                     return H_P2;
                 } else if (page_size) {
@@ -958,7 +952,8 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
                 }
                 cproc = PATBE1_GR | proc_tbl | table_size;
             } else { /* Register new HPT process table */
-                if (flags & FLAG_HASH_PROC_TBL) { /* Hash with Segment Tables */
+                if (flags & SPAPR_PROC_TABLE_HPT_PT) {
+                    /* Hash with Segment Tables */
                     /* TODO - Not Supported */
                     /* Technically caused by flag bits => H_PARAMETER */
                     return H_PARAMETER;
@@ -981,7 +976,8 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
             cproc = spapr->patb_entry & PATBE1_GR;
         }
     } else { /* Maintain current registration */
-        if (!(flags & FLAG_RADIX) != !(spapr->patb_entry & PATBE1_GR)) {
+        if (!(flags & SPAPR_PROC_TABLE_RADIX) !=
+            !(spapr->patb_entry & PATBE1_GR)) {
             /* Technically caused by flag bits => H_PARAMETER */
             return H_PARAMETER; /* Existing Process Table Mismatch */
         }
@@ -996,13 +992,14 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
     /* Update the UPRT and GTSE bits in the LPCR for all cpus */
     CPU_FOREACH(cs) {
         set_spr(cs, SPR_LPCR, LPCR_UPRT | LPCR_GTSE,
-                ((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ? LPCR_UPRT : 0) |
-                ((flags & FLAG_GTSE) ? LPCR_GTSE : 0));
+                ((flags & (SPAPR_PROC_TABLE_RADIX | SPAPR_PROC_TABLE_HPT_PT)) ?
+                LPCR_UPRT : 0) | ((flags & SPAPR_PROC_TABLE_GTSE) ?
+                SPAPR_PROC_TABLE_GTSE : 0));
     }
 
     if (kvm_enabled()) {
-        return kvmppc_configure_v3_mmu(cpu, flags & FLAG_RADIX,
-                                       flags & FLAG_GTSE, cproc);
+        return kvmppc_configure_v3_mmu(cpu, flags & SPAPR_PROC_TABLE_RADIX,
+                                       flags & SPAPR_PROC_TABLE_GTSE, cproc);
     }
     return H_SUCCESS;
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5802f88..a692e63 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -681,4 +681,14 @@ int spapr_rng_populate_dt(void *fdt);
 
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 
+/*
+ * Defines for flag value used in H_REGISTER_PROC_TBL hcall.
+ */
+#define SPAPR_PROC_TABLE_MASK        0x01FULL
+#define SPAPR_PROC_TABLE_MODIFY      0x10
+#define SPAPR_PROC_TABLE_REGISTER    0x08
+#define SPAPR_PROC_TABLE_RADIX       0x04
+#define SPAPR_PROC_TABLE_HPT_PT      0x02
+#define SPAPR_PROC_TABLE_GTSE        0x01
+
 #endif /* HW_SPAPR_H */
-- 
2.7.4
