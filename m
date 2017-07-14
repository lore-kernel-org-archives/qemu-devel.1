Received: from eggs.gnu.org ([2001:4830:134:3::10]:43773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtt7-0001Bs-SS
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtt3-0002BH-JG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Jul 2017 16:15:18 +1000
Message-Id: <20170714061521.28300-16-david@gibson.dropbear.id.au>
In-Reply-To: <20170714061521.28300-1-david@gibson.dropbear.id.au>
References: <20170714061521.28300-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/18] pseries: Implement HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, groug@kaod.org, sjitindarsingh@gmail.com, sbobroff@au1.ibm.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

This patch implements hypercalls allowing a PAPR guest to resize its own
hash page table.  This will eventually allow for more flexible memory
hotplug.

The implementation is partially asynchronous, handled in a special thread
running the hpt_prepare_thread() function.  The state of a pending resize
is stored in SPAPR_MACHINE->pending_hpt.

The H_RESIZE_HPT_PREPARE hypercall will kick off creation of a new HPT, or,
if one is already in progress, monitor it for completion.  If there is an
existing HPT resize in progress that doesn't match the size specified in
the call, it will cancel it, replacing it with a new one matching the
given size.

The H_RESIZE_HPT_COMMIT completes transition to a resized HPT, and can only
be called successfully once H_RESIZE_HPT_PREPARE has successfully
completed initialization of a new HPT.  The guest must ensure that there
are no concurrent accesses to the existing HPT while this is called (this
effectively means stop_machine() for Linux guests).

For now H_RESIZE_HPT_COMMIT goes through the whole old HPT, rehashing each
HPTE into the new HPT.  This can have quite high latency, but it seems to
be of the order of typical migration downtime latencies for HPTs of size
up to ~2GiB (which would be used in a 256GiB guest).

In future we probably want to move more of the rehashing to the "prepare"
phase, by having H_ENTER and other hcalls update both current and
pending HPTs.  That's a project for another day, but should be possible
without any changes to the guest interface.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c          |   4 +-
 hw/ppc/spapr_hcall.c    | 314 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/ppc/spapr.h  |   6 +
 target/ppc/mmu-hash64.h |   4 +
 4 files changed, 322 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0923058f9b..322540b393 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -98,8 +98,6 @@
 
 #define PHANDLE_XICP            0x00001111
 
-#define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
-
 static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
                                   const char *type_ics,
                                   int nr_irqs, Error **errp)
@@ -1269,7 +1267,7 @@ static void spapr_store_hpte(PPCVirtualHypervisor *vhyp, hwaddr ptex,
     }
 }
 
-static int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
+int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
 {
     int shift;
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 6ea8fa7394..f69ce4f60c 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -3,6 +3,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "helper_regs.h"
@@ -354,20 +355,291 @@ static target_ulong h_read(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     return H_SUCCESS;
 }
 
+struct sPAPRPendingHPT {
+    /* These fields are read-only after initialization */
+    int shift;
+    QemuThread thread;
+
+    /* These fields are protected by the BQL */
+    bool complete;
+
+    /* These fields are private to the preparation thread if
+     * !complete, otherwise protected by the BQL */
+    int ret;
+    void *hpt;
+};
+
+static void free_pending_hpt(sPAPRPendingHPT *pending)
+{
+    if (pending->hpt) {
+        qemu_vfree(pending->hpt);
+    }
+
+    g_free(pending);
+}
+
+static void *hpt_prepare_thread(void *opaque)
+{
+    sPAPRPendingHPT *pending = opaque;
+    size_t size = 1ULL << pending->shift;
+
+    pending->hpt = qemu_memalign(size, size);
+    if (pending->hpt) {
+        memset(pending->hpt, 0, size);
+        pending->ret = H_SUCCESS;
+    } else {
+        pending->ret = H_NO_MEM;
+    }
+
+    qemu_mutex_lock_iothread();
+
+    if (SPAPR_MACHINE(qdev_get_machine())->pending_hpt == pending) {
+        /* Ready to go */
+        pending->complete = true;
+    } else {
+        /* We've been cancelled, clean ourselves up */
+        free_pending_hpt(pending);
+    }
+
+    qemu_mutex_unlock_iothread();
+    return NULL;
+}
+
+/* Must be called with BQL held */
+static void cancel_hpt_prepare(sPAPRMachineState *spapr)
+{
+    sPAPRPendingHPT *pending = spapr->pending_hpt;
+
+    /* Let the thread know it's cancelled */
+    spapr->pending_hpt = NULL;
+
+    if (!pending) {
+        /* Nothing to do */
+        return;
+    }
+
+    if (!pending->complete) {
+        /* thread will clean itself up */
+        return;
+    }
+
+    free_pending_hpt(pending);
+}
+
 static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
                                          sPAPRMachineState *spapr,
                                          target_ulong opcode,
                                          target_ulong *args)
 {
     target_ulong flags = args[0];
-    target_ulong shift = args[1];
+    int shift = args[1];
+    sPAPRPendingHPT *pending = spapr->pending_hpt;
+    uint64_t current_ram_size = MACHINE(spapr)->ram_size;
 
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
         return H_AUTHORITY;
     }
 
+    if (!spapr->htab_shift) {
+        /* Radix guest, no HPT */
+        return H_NOT_AVAILABLE;
+    }
+
     trace_spapr_h_resize_hpt_prepare(flags, shift);
-    return H_HARDWARE;
+
+    if (flags != 0) {
+        return H_PARAMETER;
+    }
+
+    if (shift && ((shift < 18) || (shift > 46))) {
+        return H_PARAMETER;
+    }
+
+    current_ram_size = pc_existing_dimms_capacity(&error_fatal);
+
+    /* We only allow the guest to allocate an HPT one order above what
+     * we'd normally give them (to stop a small guest claiming a huge
+     * chunk of resources in the HPT */
+    if (shift > (spapr_hpt_shift_for_ramsize(current_ram_size) + 1)) {
+        return H_RESOURCE;
+    }
+
+    if (pending) {
+        /* something already in progress */
+        if (pending->shift == shift) {
+            /* and it's suitable */
+            if (pending->complete) {
+                return pending->ret;
+            } else {
+                return H_LONG_BUSY_ORDER_100_MSEC;
+            }
+        }
+
+        /* not suitable, cancel and replace */
+        cancel_hpt_prepare(spapr);
+    }
+
+    if (!shift) {
+        /* nothing to do */
+        return H_SUCCESS;
+    }
+
+    /* start new prepare */
+
+    pending = g_new0(sPAPRPendingHPT, 1);
+    pending->shift = shift;
+    pending->ret = H_HARDWARE;
+
+    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
+                       hpt_prepare_thread, pending, QEMU_THREAD_DETACHED);
+
+    spapr->pending_hpt = pending;
+
+    /* In theory we could estimate the time more accurately based on
+     * the new size, but there's not much point */
+    return H_LONG_BUSY_ORDER_100_MSEC;
+}
+
+static uint64_t new_hpte_load0(void *htab, uint64_t pteg, int slot)
+{
+    uint8_t *addr = htab;
+
+    addr += pteg * HASH_PTEG_SIZE_64;
+    addr += slot * HASH_PTE_SIZE_64;
+    return  ldq_p(addr);
+}
+
+static void new_hpte_store(void *htab, uint64_t pteg, int slot,
+                           uint64_t pte0, uint64_t pte1)
+{
+    uint8_t *addr = htab;
+
+    addr += pteg * HASH_PTEG_SIZE_64;
+    addr += slot * HASH_PTE_SIZE_64;
+
+    stq_p(addr, pte0);
+    stq_p(addr + HASH_PTE_SIZE_64 / 2, pte1);
+}
+
+static int rehash_hpte(PowerPCCPU *cpu,
+                       const ppc_hash_pte64_t *hptes,
+                       void *old_hpt, uint64_t oldsize,
+                       void *new_hpt, uint64_t newsize,
+                       uint64_t pteg, int slot)
+{
+    uint64_t old_hash_mask = (oldsize >> 7) - 1;
+    uint64_t new_hash_mask = (newsize >> 7) - 1;
+    target_ulong pte0 = ppc_hash64_hpte0(cpu, hptes, slot);
+    target_ulong pte1;
+    uint64_t avpn;
+    unsigned base_pg_shift;
+    uint64_t hash, new_pteg, replace_pte0;
+
+    if (!(pte0 & HPTE64_V_VALID) || !(pte0 & HPTE64_V_BOLTED)) {
+        return H_SUCCESS;
+    }
+
+    pte1 = ppc_hash64_hpte1(cpu, hptes, slot);
+
+    base_pg_shift = ppc_hash64_hpte_page_shift_noslb(cpu, pte0, pte1);
+    assert(base_pg_shift); /* H_ENTER shouldn't allow a bad encoding */
+    avpn = HPTE64_V_AVPN_VAL(pte0) & ~(((1ULL << base_pg_shift) - 1) >> 23);
+
+    if (pte0 & HPTE64_V_SECONDARY) {
+        pteg = ~pteg;
+    }
+
+    if ((pte0 & HPTE64_V_SSIZE) == HPTE64_V_SSIZE_256M) {
+        uint64_t offset, vsid;
+
+        /* We only have 28 - 23 bits of offset in avpn */
+        offset = (avpn & 0x1f) << 23;
+        vsid = avpn >> 5;
+        /* We can find more bits from the pteg value */
+        if (base_pg_shift < 23) {
+            offset |= ((vsid ^ pteg) & old_hash_mask) << base_pg_shift;
+        }
+
+        hash = vsid ^ (offset >> base_pg_shift);
+    } else if ((pte0 & HPTE64_V_SSIZE) == HPTE64_V_SSIZE_1T) {
+        uint64_t offset, vsid;
+
+        /* We only have 40 - 23 bits of seg_off in avpn */
+        offset = (avpn & 0x1ffff) << 23;
+        vsid = avpn >> 17;
+        if (base_pg_shift < 23) {
+            offset |= ((vsid ^ (vsid << 25) ^ pteg) & old_hash_mask)
+                << base_pg_shift;
+        }
+
+        hash = vsid ^ (vsid << 25) ^ (offset >> base_pg_shift);
+    } else {
+        error_report("rehash_pte: Bad segment size in HPTE");
+        return H_HARDWARE;
+    }
+
+    new_pteg = hash & new_hash_mask;
+    if (pte0 & HPTE64_V_SECONDARY) {
+        assert(~pteg == (hash & old_hash_mask));
+        new_pteg = ~new_pteg;
+    } else {
+        assert(pteg == (hash & old_hash_mask));
+    }
+    assert((oldsize != newsize) || (pteg == new_pteg));
+    replace_pte0 = new_hpte_load0(new_hpt, new_pteg, slot);
+    /*
+     * Strictly speaking, we don't need all these tests, since we only
+     * ever rehash bolted HPTEs.  We might in future handle non-bolted
+     * HPTEs, though so make the logic correct for those cases as
+     * well.
+     */
+    if (replace_pte0 & HPTE64_V_VALID) {
+        assert(newsize < oldsize);
+        if (replace_pte0 & HPTE64_V_BOLTED) {
+            if (pte0 & HPTE64_V_BOLTED) {
+                /* Bolted collision, nothing we can do */
+                return H_PTEG_FULL;
+            } else {
+                /* Discard this hpte */
+                return H_SUCCESS;
+            }
+        }
+    }
+
+    new_hpte_store(new_hpt, new_pteg, slot, pte0, pte1);
+    return H_SUCCESS;
+}
+
+static int rehash_hpt(PowerPCCPU *cpu,
+                      void *old_hpt, uint64_t oldsize,
+                      void *new_hpt, uint64_t newsize)
+{
+    uint64_t n_ptegs = oldsize >> 7;
+    uint64_t pteg;
+    int slot;
+    int rc;
+
+    for (pteg = 0; pteg < n_ptegs; pteg++) {
+        hwaddr ptex = pteg * HPTES_PER_GROUP;
+        const ppc_hash_pte64_t *hptes
+            = ppc_hash64_map_hptes(cpu, ptex, HPTES_PER_GROUP);
+
+        if (!hptes) {
+            return H_HARDWARE;
+        }
+
+        for (slot = 0; slot < HPTES_PER_GROUP; slot++) {
+            rc = rehash_hpte(cpu, hptes, old_hpt, oldsize, new_hpt, newsize,
+                             pteg, slot);
+            if (rc != H_SUCCESS) {
+                ppc_hash64_unmap_hptes(cpu, hptes, ptex, HPTES_PER_GROUP);
+                return rc;
+            }
+        }
+        ppc_hash64_unmap_hptes(cpu, hptes, ptex, HPTES_PER_GROUP);
+    }
+
+    return H_SUCCESS;
 }
 
 static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
@@ -377,13 +649,49 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
 {
     target_ulong flags = args[0];
     target_ulong shift = args[1];
+    sPAPRPendingHPT *pending = spapr->pending_hpt;
+    int rc;
+    size_t newsize;
 
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
         return H_AUTHORITY;
     }
 
     trace_spapr_h_resize_hpt_commit(flags, shift);
-    return H_HARDWARE;
+
+    if (flags != 0) {
+        return H_PARAMETER;
+    }
+
+    if (!pending || (pending->shift != shift)) {
+        /* no matching prepare */
+        return H_CLOSED;
+    }
+
+    if (!pending->complete) {
+        /* prepare has not completed */
+        return H_BUSY;
+    }
+
+    /* Shouldn't have got past PREPARE without an HPT */
+    g_assert(spapr->htab_shift);
+
+    newsize = 1ULL << pending->shift;
+    rc = rehash_hpt(cpu, spapr->htab, HTAB_SIZE(spapr),
+                    pending->hpt, newsize);
+    if (rc == H_SUCCESS) {
+        qemu_vfree(spapr->htab);
+        spapr->htab = pending->hpt;
+        spapr->htab_shift = pending->shift;
+
+        pending->hpt = NULL; /* so it's not free()d */
+    }
+
+    /* Clean up */
+    spapr->pending_hpt = NULL;
+    free_pending_hpt(pending);
+
+    return rc;
 }
 
 static target_ulong h_set_sprg0(PowerPCCPU *cpu, sPAPRMachineState *spapr,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 32bf550adc..f6f564064b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -13,6 +13,7 @@ struct sPAPRPHBState;
 struct sPAPRNVRAM;
 typedef struct sPAPREventLogEntry sPAPREventLogEntry;
 typedef struct sPAPREventSource sPAPREventSource;
+typedef struct sPAPRPendingHPT sPAPRPendingHPT;
 
 #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
 #define SPAPR_ENTRY_POINT       0x100
@@ -85,6 +86,8 @@ struct sPAPRMachineState {
     void *htab;
     uint32_t htab_shift;
     uint64_t patb_entry; /* Process tbl registed in H_REGISTER_PROCESS_TABLE */
+    sPAPRPendingHPT *pending_hpt; /* in-progress resize */
+
     hwaddr rma_size;
     int vrma_adjust;
     ssize_t rtas_size;
@@ -651,6 +654,7 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPRDRConnectorType drc_type,
 void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
                                                uint32_t count, uint32_t index);
 void spapr_cpu_parse_features(sPAPRMachineState *spapr);
+int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
 
 /* CPU and LMB DRC release callbacks. */
 void spapr_core_release(DeviceState *dev);
@@ -691,4 +695,6 @@ int spapr_rng_populate_dt(void *fdt);
 
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 
+#define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
+
 #endif /* HW_SPAPR_H */
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 54f1e37655..d297b97d37 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -63,11 +63,15 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
 #define HASH_PTE_SIZE_64        16
 #define HASH_PTEG_SIZE_64       (HASH_PTE_SIZE_64 * HPTES_PER_GROUP)
 
+#define HPTE64_V_SSIZE          SLB_VSID_B
+#define HPTE64_V_SSIZE_256M     SLB_VSID_B_256M
+#define HPTE64_V_SSIZE_1T       SLB_VSID_B_1T
 #define HPTE64_V_SSIZE_SHIFT    62
 #define HPTE64_V_AVPN_SHIFT     7
 #define HPTE64_V_AVPN           0x3fffffffffffff80ULL
 #define HPTE64_V_AVPN_VAL(x)    (((x) & HPTE64_V_AVPN) >> HPTE64_V_AVPN_SHIFT)
 #define HPTE64_V_COMPARE(x, y)  (!(((x) ^ (y)) & 0xffffffffffffff83ULL))
+#define HPTE64_V_BOLTED         0x0000000000000010ULL
 #define HPTE64_V_LARGE          0x0000000000000004ULL
 #define HPTE64_V_SECONDARY      0x0000000000000002ULL
 #define HPTE64_V_VALID          0x0000000000000001ULL
-- 
2.13.0
