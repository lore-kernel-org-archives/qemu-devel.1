Received: from eggs.gnu.org ([2001:4830:134:3::10]:60883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnf6R-0001Pl-Sl
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnf6Q-0002iR-KI
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:34:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 14 Mar 2017 16:34:21 +1100
Message-Id: <20170314053422.10922-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170314053422.10922-1-david@gibson.dropbear.id.au>
References: <20170314053422.10922-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 for-2.10 4/5] pseries: Use smaller default
 hash page tables when guest can resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, benh@kernel.crashing.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

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
 hw/ppc/spapr.c              | 21 ++++++++++++++++-----
 hw/ppc/spapr_hcall.c        | 28 ++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h      |  2 ++
 include/hw/ppc/spapr_ovec.h |  1 +
 4 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a6a1c93..295d654 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1180,8 +1180,8 @@ int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
     return shift;
 }
 
-static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
-                                 Error **errp)
+void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
+                          Error **errp)
 {
     long rc;
 
@@ -1254,6 +1254,7 @@ static void ppc_spapr_reset(void)
     hwaddr rtas_addr, fdt_addr;
     void *fdt;
     int rc;
+    int hpt_shift;
 
     /* Check for unknown sysbus devices */
     foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
@@ -1261,9 +1262,14 @@ static void ppc_spapr_reset(void)
     spapr->patb_entry = 0;
 
     /* Allocate and/or reset the hash page table */
-    spapr_reallocate_hpt(spapr,
-                         spapr_hpt_shift_for_ramsize(machine->maxram_size),
-                         &error_fatal);
+    if ((spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED)
+        || (spapr->cas_reboot
+            && !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE))) {
+        hpt_shift = spapr_hpt_shift_for_ramsize(machine->maxram_size);
+    } else {
+        hpt_shift = spapr_hpt_shift_for_ramsize(machine->ram_size);
+    }
+    spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
 
     /* Update the RMA size if necessary */
     if (spapr->vrma_adjust) {
@@ -2092,6 +2098,11 @@ static void ppc_spapr_init(MachineState *machine)
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
index cdafc3f..5893647 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1314,6 +1314,34 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     ov5_guest = spapr_ovec_parse_vector(ov_table, 5);
 
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
index ba5c7d5..d4a9ed7 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -645,6 +645,8 @@ void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
 void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
                                     sPAPRMachineState *spapr);
 int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
+void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
+                          Error **errp);
 
 /* rtas-configure-connector state */
 struct sPAPRConfigureConnectorState {
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 355a344..f5fed87 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -47,6 +47,7 @@ typedef struct sPAPROptionVector sPAPROptionVector;
 #define OV5_DRCONF_MEMORY       OV_BIT(2, 2)
 #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
 #define OV5_HP_EVT              OV_BIT(6, 5)
+#define OV5_HPT_RESIZE          OV_BIT(6, 7)
 
 /* interfaces */
 sPAPROptionVector *spapr_ovec_new(void);
-- 
2.9.3
