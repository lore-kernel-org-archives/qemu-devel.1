Received: from eggs.gnu.org ([2001:4830:134:3::10]:53927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE8OB-0006a7-GX
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE8O7-0002FP-AD
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:10:51 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  3 May 2018 17:10:37 +1000
Message-Id: <20180503071037.31834-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH] spapr: Remove support for explicitly allocated
 RMAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, thuth@redhat.com
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Current POWER cpus allow for a VRMA, a special mapping which describes a
guest's view of memory when in real mode (MMU off, from the guest's point
of view).  Older cpus didn't have that which meant that to support a guest
a special host-contiguous region of memory was needed to give the guest its
Real Mode Area (RMA).

KVM used to provide special calls to allocate a contiguous RMA for those
cases.  This was useful in the early days of KVM on Power to allow it to be
tested on PowerPC 970 chips as used in Macintosh G5 machines.  Now, those
machines are so old as to be almost irrelevant.

The normal qemu deprecation process would require this to be marked
deprecated then removed in 2 releases.  However, this can only be used
with corresponding support in the host kernel - which was dropped
years ago (in c17b98cf "KVM: PPC: Book3S HV: Remove code for PPC970
processors" of 2014-12-03 to be precise).  Therefore it should be ok
to drop this immediately.

Just to be clear this only affects *KVM* guests with PowerPC 970, and those
already require an ancient host kernel.  TCG guests with PowerPC 970 should
still work.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c       | 61 ++++++++++++++------------------------------
 target/ppc/kvm.c     | 38 ---------------------------
 target/ppc/kvm_ppc.h |  6 -----
 3 files changed, 19 insertions(+), 86 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 944bee7a71..a8633fdd67 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2506,9 +2506,6 @@ static void spapr_machine_init(MachineState *machine)
     int i;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
-    MemoryRegion *rma_region;
-    void *rma = NULL;
-    hwaddr rma_alloc_size;
     hwaddr node0_size = spapr_node0_size(machine);
     long load_limit, fw_size;
     char *filename;
@@ -2547,40 +2544,28 @@ static void spapr_machine_init(MachineState *machine)
         exit(1);
     }
 
-    /* Allocate RMA if necessary */
-    rma_alloc_size = kvmppc_alloc_rma(&rma);
+    spapr->rma_size = node0_size;
 
-    if (rma_alloc_size == -1) {
-        error_report("Unable to create RMA");
-        exit(1);
+    /* With KVM, we don't actually know whether KVM supports an
+     * unbounded RMA (PR KVM) or is limited by the hash table size
+     * (HV KVM using VRMA), so we always assume the latter
+     *
+     * In that case, we also limit the initial allocations for RTAS
+     * etc... to 256M since we have no way to know what the VRMA size
+     * is going to be as it depends on the size of the hash table
+     * isn't determined yet.
+     */
+    if (kvm_enabled()) {
+        spapr->vrma_adjust = 1;
+        spapr->rma_size = MIN(spapr->rma_size, 0x10000000);
     }
 
-    if (rma_alloc_size && (rma_alloc_size < node0_size)) {
-        spapr->rma_size = rma_alloc_size;
-    } else {
-        spapr->rma_size = node0_size;
-
-        /* With KVM, we don't actually know whether KVM supports an
-         * unbounded RMA (PR KVM) or is limited by the hash table size
-         * (HV KVM using VRMA), so we always assume the latter
-         *
-         * In that case, we also limit the initial allocations for RTAS
-         * etc... to 256M since we have no way to know what the VRMA size
-         * is going to be as it depends on the size of the hash table
-         * isn't determined yet.
-         */
-        if (kvm_enabled()) {
-            spapr->vrma_adjust = 1;
-            spapr->rma_size = MIN(spapr->rma_size, 0x10000000);
-        }
-
-        /* Actually we don't support unbounded RMA anymore since we
-         * added proper emulation of HV mode. The max we can get is
-         * 16G which also happens to be what we configure for PAPR
-         * mode so make sure we don't do anything bigger than that
-         */
-        spapr->rma_size = MIN(spapr->rma_size, 0x400000000ull);
-    }
+    /* Actually we don't support unbounded RMA anymore since we added
+     * proper emulation of HV mode. The max we can get is 16G which
+     * also happens to be what we configure for PAPR mode so make sure
+     * we don't do anything bigger than that
+     */
+    spapr->rma_size = MIN(spapr->rma_size, 0x400000000ull);
 
     if (spapr->rma_size > node0_size) {
         error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRIx")",
@@ -2641,14 +2626,6 @@ static void spapr_machine_init(MachineState *machine)
                                          machine->ram_size);
     memory_region_add_subregion(sysmem, 0, ram);
 
-    if (rma_alloc_size && rma) {
-        rma_region = g_new(MemoryRegion, 1);
-        memory_region_init_ram_ptr(rma_region, NULL, "ppc_spapr.rma",
-                                   rma_alloc_size, rma);
-        vmstate_register_ram_global(rma_region);
-        memory_region_add_subregion(sysmem, 0, rma_region);
-    }
-
     /* initialize hotplug memory address space */
     if (machine->ram_size < machine->maxram_size) {
         ram_addr_t hotplug_mem_size = machine->maxram_size - machine->ram_size;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 28311a98e0..26fcfb9238 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -72,7 +72,6 @@ static int cap_segstate;
 static int cap_booke_sregs;
 static int cap_ppc_smt;
 static int cap_ppc_smt_possible;
-static int cap_ppc_rma;
 static int cap_spapr_tce;
 static int cap_spapr_tce_64;
 static int cap_spapr_multitce;
@@ -133,7 +132,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_segstate = kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
     cap_booke_sregs = kvm_check_extension(s, KVM_CAP_PPC_BOOKE_SREGS);
     cap_ppc_smt_possible = kvm_vm_check_extension(s, KVM_CAP_PPC_SMT_POSSIBLE);
-    cap_ppc_rma = kvm_check_extension(s, KVM_CAP_PPC_RMA);
     cap_spapr_tce = kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
     cap_spapr_tce_64 = kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
     cap_spapr_multitce = kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE);
@@ -2163,42 +2161,6 @@ void kvmppc_hint_smt_possible(Error **errp)
 
 
 #ifdef TARGET_PPC64
-off_t kvmppc_alloc_rma(void **rma)
-{
-    off_t size;
-    int fd;
-    struct kvm_allocate_rma ret;
-
-    /* If cap_ppc_rma == 0, contiguous RMA allocation is not supported
-     * if cap_ppc_rma == 1, contiguous RMA allocation is supported, but
-     *                      not necessary on this hardware
-     * if cap_ppc_rma == 2, contiguous RMA allocation is needed on this hardware
-     *
-     * FIXME: We should allow the user to force contiguous RMA
-     * allocation in the cap_ppc_rma==1 case.
-     */
-    if (cap_ppc_rma < 2) {
-        return 0;
-    }
-
-    fd = kvm_vm_ioctl(kvm_state, KVM_ALLOCATE_RMA, &ret);
-    if (fd < 0) {
-        fprintf(stderr, "KVM: Error on KVM_ALLOCATE_RMA: %s\n",
-                strerror(errno));
-        return -1;
-    }
-
-    size = MIN(ret.rma_size, 256ul << 20);
-
-    *rma = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
-    if (*rma == MAP_FAILED) {
-        fprintf(stderr, "KVM: Error mapping RMA: %s\n", strerror(errno));
-        return -1;
-    };
-
-    return size;
-}
-
 uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
 {
     struct kvm_ppc_smmu_info info;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 4d2789eef6..e2840e1d33 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -37,7 +37,6 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
                                      bool radix, bool gtse,
                                      uint64_t proc_tbl);
 #ifndef CONFIG_USER_ONLY
-off_t kvmppc_alloc_rma(void **rma);
 bool kvmppc_spapr_use_multitce(void);
 int kvmppc_spapr_enable_inkernel_multitce(void);
 void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
@@ -188,11 +187,6 @@ static inline target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
 }
 
 #ifndef CONFIG_USER_ONLY
-static inline off_t kvmppc_alloc_rma(void **rma)
-{
-    return 0;
-}
-
 static inline bool kvmppc_spapr_use_multitce(void)
 {
     return false;
-- 
2.17.0
