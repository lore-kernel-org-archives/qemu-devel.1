Received: from eggs.gnu.org ([2001:4830:134:3::10]:58986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d92lD-000475-Kr
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d92lC-0008M2-7U
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:05:03 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 12 May 2017 15:04:50 +1000
Message-Id: <20170512050451.9979-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170512050451.9979-1-david@gibson.dropbear.id.au>
References: <20170512050451.9979-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv6 4/5] pseries: Use smaller default hash page
 tables when guest can resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, aik@ozlabs.ru
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de, benh@kernel.crashing.org, David Gibson <david@gibson.dropbear.id.au>

We've now implemented a PAPR extension allowing PAPR guest to resize
their hash page table (HPT) during runtime.

This patch makes use of that facility to allocate smaller HPTs by default.
Specifically when a guest is aware of the HPT resize facility, qemu sizes
the HPT to the initial memory size, rather than the maximum memory size on
the assumption that the guest will resize its HPT if necessary for hot
plugged memory.

When the initial memory size is much smaller than the maximum memory size
(a common configuration with e.g. oVirt / RHEV) then this can save
significant memory on the HPT.

If the guest does *not* advertise HPT resize awareness when it makes the
ibm,client-architecture-support call, qemu resizes the HPT for maxmimum
memory size (unless it's been configured not to allow such guests at all).

For now we make that reallocation assuming the guest has not yet used the
HPT at all.  That's true in practice, but not, strictly, an architectural
or PAPR requirement.  If we need to in future we can fix this by having
the client-architecture-support call reboot the guest with the revised
HPT size (the client-architecture-support call is explicitly permitted to
trigger a reboot in this way).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c              | 23 ++++++++++++++++++-----
 hw/ppc/spapr_hcall.c        | 28 ++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h      |  2 ++
 include/hw/ppc/spapr_ovec.h |  1 +
 4 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a0f5139..785bfdb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1225,8 +1225,8 @@ int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
     return shift;
 }
 
-static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
-                                 Error **errp)
+void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
+                          Error **errp)
 {
     long rc;
 
@@ -1277,9 +1277,17 @@ static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
 
 void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
 {
-    spapr_reallocate_hpt(spapr,
-                     spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram_size),
-                     &error_fatal);
+    int hpt_shift;
+
+    if ((spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED)
+        || (spapr->cas_reboot
+            && !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE))) {
+        hpt_shift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram_size);
+    } else {
+        hpt_shift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)->ram_size);
+    }
+    spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
+
     if (spapr->vrma_adjust) {
         spapr->rma_size = kvmppc_rma_size(spapr_node0_size(),
                                           spapr->htab_shift);
@@ -2151,6 +2159,11 @@ static void ppc_spapr_init(MachineState *machine)
         spapr_ovec_set(spapr->ov5, OV5_HP_EVT);
     }
 
+    /* advertise support for HPT resizing */
+    if (spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) {
+        spapr_ovec_set(spapr->ov5, OV5_HPT_RESIZE);
+    }
+
     /* init CPUs */
     if (machine->cpu_model == NULL) {
         machine->cpu_model = kvm_enabled() ? "host" : smc->tcg_default_cpu;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 2979208..f79db2d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1452,6 +1452,34 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     guest_radix = spapr_ovec_test(ov5_guest, OV5_MMU_RADIX_300);
     spapr_ovec_clear(ov5_guest, OV5_MMU_RADIX_300);
 
+    /*
+     * HPT resizing is a bit of a special case, because when enabled
+     * we assume the guest will support it until it says it doesn't,
+     * instead of assuming it won't support it until it says it does.
+     * Strictly speaking that approach could break for guests which
+     * don't make a CAS call, but those are so old we don't care about
+     * them.  Without that assumption we'd have to make at least a
+     * temporary allocation of an HPT sized for max memory, which
+     * could be impossibly difficult under KVM HV if maxram is large.
+     */
+    if (!spapr_ovec_test(ov5_guest, OV5_HPT_RESIZE)) {
+        int maxshift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram_size);
+
+        if (spapr->resize_hpt == SPAPR_RESIZE_HPT_REQUIRED) {
+            error_report(
+                "h_client_architecture_support: Guest doesn't support HPT resizing, but resize-hpt=required");
+            exit(1);
+        }
+
+        if (spapr->htab_shift < maxshift) {
+            /* Guest doesn't know about HPT resizing, so we
+             * pre-emptively resize for the maximum permitted RAM.  At
+             * the point this is called, nothing should have been
+             * entered into the existing HPT */
+            spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
+        }
+    }
+
     /* NOTE: there are actually a number of ov5 bits where input from the
      * guest is always zero, and the platform/QEMU enables them independently
      * of guest input. To model these properly we'd want some sort of mask,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index e1b402b..b4253a7 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -650,6 +650,8 @@ void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
 void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
                                     sPAPRMachineState *spapr);
 int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
+void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
+                          Error **errp);
 
 /* rtas-configure-connector state */
 struct sPAPRConfigureConnectorState {
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index f088833..658b8f7 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -50,6 +50,7 @@ typedef struct sPAPROptionVector sPAPROptionVector;
 #define OV5_DRCONF_MEMORY       OV_BIT(2, 2)
 #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
 #define OV5_HP_EVT              OV_BIT(6, 5)
+#define OV5_HPT_RESIZE          OV_BIT(6, 7)
 
 /* ISA 3.00 MMU features: */
 #define OV5_MMU_BOTH            OV_BIT(24, 0) /* Radix and hash */
-- 
2.9.3
