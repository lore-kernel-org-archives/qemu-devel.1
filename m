Received: from eggs.gnu.org ([2001:4830:134:3::10]:56000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI1-0001JY-OA
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI0-0003JG-04
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:58:49 +1000
Message-Id: <20170424015927.8933-10-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/47] target/ppc: Implement
 H_REGISTER_PROCESS_TABLE H_CALL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The H_REGISTER_PROCESS_TABLE H_CALL is used by a guest to indicate to the
hypervisor where in memory its process table is and how translation should
be performed using this process table.

Provide the implementation of this H_CALL for a guest.

We first check for invalid flags, then parse the flags to determine the
operation, and then check the other parameters for valid values based on
the operation (register new table/deregister table/maintain registration).
The process table is then stored in the appropriate location and registered
with the hypervisor (if running under KVM), and the LPCR_[UPRT/GTSE] bits
are updated as required.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
[dwg: Correct missing prototype and uninitialized variable]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         |  35 +++++++++------
 hw/ppc/spapr_hcall.c   | 113 +++++++++++++++++++++++++++++++++++++++++++++++--
 include/hw/ppc/spapr.h |   2 +
 target/ppc/kvm.c       |  31 ++++++++++++++
 target/ppc/kvm_ppc.h   |  10 +++++
 5 files changed, 176 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ea247e6..54391a1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -40,6 +40,7 @@
 #include "kvm_ppc.h"
 #include "migration/migration.h"
 #include "mmu-hash64.h"
+#include "mmu-book3s-v3.h"
 #include "qom/cpu.h"
 
 #include "hw/boards.h"
@@ -1113,7 +1114,7 @@ static int get_htab_fd(sPAPRMachineState *spapr)
     return spapr->htab_fd;
 }
 
-static void close_htab_fd(sPAPRMachineState *spapr)
+void close_htab_fd(sPAPRMachineState *spapr)
 {
     if (spapr->htab_fd >= 0) {
         close(spapr->htab_fd);
@@ -1240,6 +1241,19 @@ static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
     }
 }
 
+void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
+{
+    spapr_reallocate_hpt(spapr,
+                     spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram_size),
+                     &error_fatal);
+    if (spapr->vrma_adjust) {
+        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(),
+                                          spapr->htab_shift);
+    }
+    /* We're setting up a hash table, so that means we're not radix */
+    spapr->patb_entry = 0;
+}
+
 static void find_unknown_sysbus_device(SysBusDevice *sbdev, void *opaque)
 {
     bool matched = false;
@@ -1268,17 +1282,14 @@ static void ppc_spapr_reset(void)
     /* Check for unknown sysbus devices */
     foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
 
-    spapr->patb_entry = 0;
-
-    /* Allocate and/or reset the hash page table */
-    spapr_reallocate_hpt(spapr,
-                         spapr_hpt_shift_for_ramsize(machine->maxram_size),
-                         &error_fatal);
-
-    /* Update the RMA size if necessary */
-    if (spapr->vrma_adjust) {
-        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(),
-                                          spapr->htab_shift);
+    if (kvm_enabled() && kvmppc_has_cap_mmu_radix()) {
+        /* If using KVM with radix mode available, VCPUs can be started
+         * without a HPT because KVM will start them in radix mode.
+         * Set the GR bit in PATB so that we know there is no HPT. */
+        spapr->patb_entry = PATBE1_GR;
+    } else {
+        spapr->patb_entry = 0;
+        spapr_setup_hpt_and_vrma(spapr);
     }
 
     qemu_devices_reset();
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 7952129..a958fee 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -12,6 +12,8 @@
 #include "trace.h"
 #include "kvm_ppc.h"
 #include "hw/ppc/spapr_ovec.h"
+#include "qemu/error-report.h"
+#include "mmu-book3s-v3.h"
 
 struct SPRSyncState {
     int spr;
@@ -894,14 +896,119 @@ static target_ulong h_invalidate_pid(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     return H_FUNCTION;
 }
 
+static void spapr_check_setup_free_hpt(sPAPRMachineState *spapr,
+                                       uint64_t patbe_old, uint64_t patbe_new)
+{
+    /*
+     * We have 4 Options:
+     * HASH->HASH || RADIX->RADIX || NOTHING->RADIX : Do Nothing
+     * HASH->RADIX                                  : Free HPT
+     * RADIX->HASH                                  : Allocate HPT
+     * NOTHING->HASH                                : Allocate HPT
+     * Note: NOTHING implies the case where we said the guest could choose
+     *       later and so assumed radix and now it's called H_REG_PROC_TBL
+     */
+
+    if ((patbe_old & PATBE1_GR) == (patbe_new & PATBE1_GR)) {
+        /* We assume RADIX, so this catches all the "Do Nothing" cases */
+    } else if (!(patbe_old & PATBE1_GR)) {
+        /* HASH->RADIX : Free HPT */
+        g_free(spapr->htab);
+        spapr->htab = NULL;
+        spapr->htab_shift = 0;
+        close_htab_fd(spapr);
+    } else if (!(patbe_new & PATBE1_GR)) {
+        /* RADIX->HASH || NOTHING->HASH : Allocate HPT */
+        spapr_setup_hpt_and_vrma(spapr);
+    }
+    return;
+}
+
+#define FLAGS_MASK              0x01FULL
+#define FLAG_MODIFY             0x10
+#define FLAG_REGISTER           0x08
+#define FLAG_RADIX              0x04
+#define FLAG_HASH_PROC_TBL      0x02
+#define FLAG_GTSE               0x01
+
 static target_ulong h_register_process_table(PowerPCCPU *cpu,
                                              sPAPRMachineState *spapr,
                                              target_ulong opcode,
                                              target_ulong *args)
 {
-    qemu_log_mask(LOG_UNIMP, "Unimplemented SPAPR hcall 0x"TARGET_FMT_lx"%s\n",
-                  opcode, " (H_REGISTER_PROC_TBL)");
-    return H_FUNCTION;
+    CPUPPCState *env = &cpu->env;
+    target_ulong flags = args[0];
+    target_ulong proc_tbl = args[1];
+    target_ulong page_size = args[2];
+    target_ulong table_size = args[3];
+    uint64_t cproc;
+
+    if (flags & ~FLAGS_MASK) { /* Check no reserved bits are set */
+        return H_PARAMETER;
+    }
+    if (flags & FLAG_MODIFY) {
+        if (flags & FLAG_REGISTER) {
+            if (flags & FLAG_RADIX) { /* Register new RADIX process table */
+                if (proc_tbl & 0xfff || proc_tbl >> 60) {
+                    return H_P2;
+                } else if (page_size) {
+                    return H_P3;
+                } else if (table_size > 24) {
+                    return H_P4;
+                }
+                cproc = PATBE1_GR | proc_tbl | table_size;
+            } else { /* Register new HPT process table */
+                if (flags & FLAG_HASH_PROC_TBL) { /* Hash with Segment Tables */
+                    /* TODO - Not Supported */
+                    /* Technically caused by flag bits => H_PARAMETER */
+                    return H_PARAMETER;
+                } else { /* Hash with SLB */
+                    if (proc_tbl >> 38) {
+                        return H_P2;
+                    } else if (page_size & ~0x7) {
+                        return H_P3;
+                    } else if (table_size > 24) {
+                        return H_P4;
+                    }
+                }
+                cproc = (proc_tbl << 25) | page_size << 5 | table_size;
+            }
+
+        } else { /* Deregister current process table */
+            /* Set to benign value: (current GR) | 0. This allows
+             * deregistration in KVM to succeed even if the radix bit in flags
+             * doesn't match the radix bit in the old PATB. */
+            cproc = spapr->patb_entry & PATBE1_GR;
+        }
+    } else { /* Maintain current registration */
+        if (!(flags & FLAG_RADIX) != !(spapr->patb_entry & PATBE1_GR)) {
+            /* Technically caused by flag bits => H_PARAMETER */
+            return H_PARAMETER; /* Existing Process Table Mismatch */
+        }
+        cproc = spapr->patb_entry;
+    }
+
+    /* Check if we need to setup OR free the hpt */
+    spapr_check_setup_free_hpt(spapr, spapr->patb_entry, cproc);
+
+    spapr->patb_entry = cproc; /* Save new process table */
+    if ((flags & FLAG_RADIX) || (flags & FLAG_HASH_PROC_TBL)) {
+        /* Use Process TBL */
+        env->spr[SPR_LPCR] |= LPCR_UPRT;
+    } else {
+        env->spr[SPR_LPCR] &= ~LPCR_UPRT;
+    }
+    if (flags & FLAG_GTSE) { /* Partition Uses Guest Translation Shootdwn */
+        env->spr[SPR_LPCR] |= LPCR_GTSE;
+    } else {
+        env->spr[SPR_LPCR] &= ~LPCR_GTSE;
+    }
+
+    if (kvm_enabled()) {
+        return kvmppc_configure_v3_mmu(cpu, flags & FLAG_RADIX,
+                                       flags & FLAG_GTSE, cproc);
+    }
+    return H_SUCCESS;
 }
 
 #define H_SIGNAL_SYS_RESET_ALL         -1
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 342f7a6..d234efc 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -608,6 +608,8 @@ void spapr_dt_events(sPAPRMachineState *sm, void *fdt);
 int spapr_h_cas_compose_response(sPAPRMachineState *sm,
                                  target_ulong addr, target_ulong size,
                                  sPAPROptionVector *ov5_updates);
+void close_htab_fd(sPAPRMachineState *spapr);
+void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr);
 sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn);
 void spapr_tce_table_enable(sPAPRTCETable *tcet,
                             uint32_t page_shift, uint64_t bus_offset,
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 38db27b..c959b90 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -362,6 +362,37 @@ struct ppc_radix_page_info *kvm_get_radix_page_info(void)
     return radix_page_info;
 }
 
+target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
+                                     bool radix, bool gtse,
+                                     uint64_t proc_tbl)
+{
+    CPUState *cs = CPU(cpu);
+    int ret;
+    uint64_t flags = 0;
+    struct kvm_ppc_mmuv3_cfg cfg = {
+        .process_table = proc_tbl,
+    };
+
+    if (radix) {
+        flags |= KVM_PPC_MMUV3_RADIX;
+    }
+    if (gtse) {
+        flags |= KVM_PPC_MMUV3_GTSE;
+    }
+    cfg.flags = flags;
+    ret = kvm_vm_ioctl(cs->kvm_state, KVM_PPC_CONFIGURE_V3_MMU, &cfg);
+    switch (ret) {
+    case 0:
+        return H_SUCCESS;
+    case -EINVAL:
+        return H_PARAMETER;
+    case -ENODEV:
+        return H_NOT_AVAILABLE;
+    default:
+        return H_HARDWARE;
+    }
+}
+
 static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint32_t shift)
 {
     if (!(flags & KVM_PPC_PAGE_SIZES_REAL)) {
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 64189a4..4b2fd9a 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -33,6 +33,9 @@ int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
 int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
 int kvmppc_set_tcr(PowerPCCPU *cpu);
 int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
+target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
+                                     bool radix, bool gtse,
+                                     uint64_t proc_tbl);
 #ifndef CONFIG_USER_ONLY
 off_t kvmppc_alloc_rma(void **rma);
 bool kvmppc_spapr_use_multitce(void);
@@ -159,6 +162,13 @@ static inline int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu)
     return -1;
 }
 
+static inline target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
+                                     bool radix, bool gtse,
+                                     uint64_t proc_tbl)
+{
+    return 0;
+}
+
 #ifndef CONFIG_USER_ONLY
 static inline off_t kvmppc_alloc_rma(void **rma)
 {
-- 
2.9.3
