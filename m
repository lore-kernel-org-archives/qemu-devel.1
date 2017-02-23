Received: from eggs.gnu.org ([2001:4830:134:3::10]:40524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmTB-00008x-KU
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmT8-0001iU-G7
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42587
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cgmT8-0001hq-AZ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:34 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1N5reUO013186
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:33 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28sqms4v53-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:33 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 23 Feb 2017 16:01:30 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 23 Feb 2017 17:00:01 +1100
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
Message-Id: <034945c1bbc8d4a97e5f568d4d463af2c9a24080.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 08/12] spapr: Only setup HTP if
 necessary.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, sjitindarsingh@gmail.com

If QEMU is using KVM, and KVM is capable of running in radix mode,
guests can be run in real-mode without allocating a HPT (because KVM
will use a minimal RPT). So in this case, we avoid creating the HPT
at reset time and later (during CAS) create it if it is necessary.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
v2:

* This patch has been mostly rewritten to move the late HPT allocation to CAS.
This allows a guest to start in radix mode (when it's in real mode) and then
change to hash, even if it is a legacy guest and will not call
h_register_process_table().
* Added an exported function to spapr.c to perform HPT allocation and adjust
the vrma if necessary. This makes it possible to allocate the HPT from
h_client_architecture_support() in spapr_hcall.c.

 hw/ppc/spapr.c         | 24 +++++++++++++++---------
 hw/ppc/spapr_hcall.c   | 10 ++++++++++
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ca3812555f..dfee0f685f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1123,6 +1123,17 @@ static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
     }
 }
 
+void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
+{
+    spapr_reallocate_hpt(spapr,
+                     spapr_hpt_shift_for_ramsize(MACHINE(qdev_get_machine())->maxram_size),
+                     &error_fatal);
+    if (spapr->vrma_adjust) {
+        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(),
+                                          spapr->htab_shift);
+    }
+}
+
 static void find_unknown_sysbus_device(SysBusDevice *sbdev, void *opaque)
 {
     bool matched = false;
@@ -1151,15 +1162,10 @@ static void ppc_spapr_reset(void)
     /* Check for unknown sysbus devices */
     foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
 
-    /* Allocate and/or reset the hash page table */
-    spapr_reallocate_hpt(spapr,
-                         spapr_hpt_shift_for_ramsize(machine->maxram_size),
-                         &error_fatal);
-
-    /* Update the RMA size if necessary */
-    if (spapr->vrma_adjust) {
-        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(),
-                                          spapr->htab_shift);
+    /* If using KVM with radix mode available, VCPUs can be started
+     * without a HPT because KVM will start them in radix mode. */
+    if (!(kvm_enabled() && kvmppc_has_cap_mmu_radix())) {
+        spapr_setup_hpt_and_vrma(spapr);
     }
 
     qemu_devices_reset();
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 42d20e0b92..cea34073aa 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1002,6 +1002,16 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     ov5_updates = spapr_ovec_new();
     spapr->cas_reboot = spapr_ovec_diff(ov5_updates,
                                         ov5_cas_old, spapr->ov5_cas);
+    if (kvm_enabled()) {
+        if (kvmppc_has_cap_mmu_radix()) {
+            /* If the HPT hasn't yet been set up (see
+             * ppc_spapr_reset()), and it's needed, do it now: */
+            if (!spapr_ovec_test(ov5_updates, OV5_MMU_RADIX)) {
+                /* legacy hash or new hash: */
+                spapr_setup_hpt_and_vrma(spapr);
+            }
+        }
+    }
 
     if (!spapr->cas_reboot) {
         spapr->cas_reboot =
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f9b17d860a..a30cbc485c 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -590,6 +590,7 @@ void spapr_dt_events(sPAPRMachineState *sm, void *fdt);
 int spapr_h_cas_compose_response(sPAPRMachineState *sm,
                                  target_ulong addr, target_ulong size,
                                  sPAPROptionVector *ov5_updates);
+void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr);
 sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn);
 void spapr_tce_table_enable(sPAPRTCETable *tcet,
                             uint32_t page_shift, uint64_t bus_offset,
-- 
2.11.0
