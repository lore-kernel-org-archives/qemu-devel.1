Received: from eggs.gnu.org ([2001:4830:134:3::10]:32975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfo-000210-FP
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfm-0006To-Sq
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:56 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfm-0006SG-JU
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:54 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfl-0003sy-Bb
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:53 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:20 +0100
Message-Id: <20180615142521.19143-43-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 42/43] exec.c: Handle IOMMUs in
 address_space_translate_for_iotlb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently we don't support board configurations that put an IOMMU
in the path of the CPU's memory transactions, and instead just
assert() if the memory region fonud in address_space_translate_for_iotlb()
is an IOMMUMemoryRegion.

Remove this limitation by having the function handle IOMMUs.
This is mostly straightforward, but we must make sure we have
a notifier registered for every IOMMU that a transaction has
passed through, so that we can flush the TLB appropriately
when any of the IOMMUs change their mappings.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180604152941.20374-5-peter.maydell@linaro.org
---
 include/exec/exec-all.h |   3 +-
 include/qom/cpu.h       |   3 +
 accel/tcg/cputlb.c      |   3 +-
 exec.c                  | 135 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 140 insertions(+), 4 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index aed55aaaa7d..8bbea787a91 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -478,7 +478,8 @@ void tb_flush_jmp_cache(CPUState *cpu, target_ulong addr);
 
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
-                                  hwaddr *xlat, hwaddr *plen);
+                                  hwaddr *xlat, hwaddr *plen,
+                                  MemTxAttrs attrs, int *prot);
 hwaddr memory_region_section_get_iotlb(CPUState *cpu,
                                        MemoryRegionSection *section,
                                        target_ulong vaddr,
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 9d3afc6c759..cce2fd6acc2 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -429,6 +429,9 @@ struct CPUState {
     uint16_t pending_tlb_flush;
 
     int hvf_fd;
+
+    /* track IOMMUs whose translations we've cached in the TCG TLB */
+    GArray *iommu_notifiers;
 };
 
 QTAILQ_HEAD(CPUTailQ, CPUState);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 1768fcdc473..0a721bb9c40 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -632,7 +632,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     }
 
     sz = size;
-    section = address_space_translate_for_iotlb(cpu, asidx, paddr, &xlat, &sz);
+    section = address_space_translate_for_iotlb(cpu, asidx, paddr, &xlat, &sz,
+                                                attrs, &prot);
     assert(sz >= TARGET_PAGE_SIZE);
 
     tlb_debug("vaddr=" TARGET_FMT_lx " paddr=0x" TARGET_FMT_plx
diff --git a/exec.c b/exec.c
index ecdf1929949..ebadc0e302a 100644
--- a/exec.c
+++ b/exec.c
@@ -653,18 +653,144 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
     return mr;
 }
 
+typedef struct TCGIOMMUNotifier {
+    IOMMUNotifier n;
+    MemoryRegion *mr;
+    CPUState *cpu;
+    int iommu_idx;
+    bool active;
+} TCGIOMMUNotifier;
+
+static void tcg_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+{
+    TCGIOMMUNotifier *notifier = container_of(n, TCGIOMMUNotifier, n);
+
+    if (!notifier->active) {
+        return;
+    }
+    tlb_flush(notifier->cpu);
+    notifier->active = false;
+    /* We leave the notifier struct on the list to avoid reallocating it later.
+     * Generally the number of IOMMUs a CPU deals with will be small.
+     * In any case we can't unregister the iommu notifier from a notify
+     * callback.
+     */
+}
+
+static void tcg_register_iommu_notifier(CPUState *cpu,
+                                        IOMMUMemoryRegion *iommu_mr,
+                                        int iommu_idx)
+{
+    /* Make sure this CPU has an IOMMU notifier registered for this
+     * IOMMU/IOMMU index combination, so that we can flush its TLB
+     * when the IOMMU tells us the mappings we've cached have changed.
+     */
+    MemoryRegion *mr = MEMORY_REGION(iommu_mr);
+    TCGIOMMUNotifier *notifier;
+    int i;
+
+    for (i = 0; i < cpu->iommu_notifiers->len; i++) {
+        notifier = &g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier, i);
+        if (notifier->mr == mr && notifier->iommu_idx == iommu_idx) {
+            break;
+        }
+    }
+    if (i == cpu->iommu_notifiers->len) {
+        /* Not found, add a new entry at the end of the array */
+        cpu->iommu_notifiers = g_array_set_size(cpu->iommu_notifiers, i + 1);
+        notifier = &g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier, i);
+
+        notifier->mr = mr;
+        notifier->iommu_idx = iommu_idx;
+        notifier->cpu = cpu;
+        /* Rather than trying to register interest in the specific part
+         * of the iommu's address space that we've accessed and then
+         * expand it later as subsequent accesses touch more of it, we
+         * just register interest in the whole thing, on the assumption
+         * that iommu reconfiguration will be rare.
+         */
+        iommu_notifier_init(&notifier->n,
+                            tcg_iommu_unmap_notify,
+                            IOMMU_NOTIFIER_UNMAP,
+                            0,
+                            HWADDR_MAX,
+                            iommu_idx);
+        memory_region_register_iommu_notifier(notifier->mr, &notifier->n);
+    }
+
+    if (!notifier->active) {
+        notifier->active = true;
+    }
+}
+
+static void tcg_iommu_free_notifier_list(CPUState *cpu)
+{
+    /* Destroy the CPU's notifier list */
+    int i;
+    TCGIOMMUNotifier *notifier;
+
+    for (i = 0; i < cpu->iommu_notifiers->len; i++) {
+        notifier = &g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier, i);
+        memory_region_unregister_iommu_notifier(notifier->mr, &notifier->n);
+    }
+    g_array_free(cpu->iommu_notifiers, true);
+}
+
 /* Called from RCU critical section */
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
-                                  hwaddr *xlat, hwaddr *plen)
+                                  hwaddr *xlat, hwaddr *plen,
+                                  MemTxAttrs attrs, int *prot)
 {
     MemoryRegionSection *section;
+    IOMMUMemoryRegion *iommu_mr;
+    IOMMUMemoryRegionClass *imrc;
+    IOMMUTLBEntry iotlb;
+    int iommu_idx;
     AddressSpaceDispatch *d = atomic_rcu_read(&cpu->cpu_ases[asidx].memory_dispatch);
 
-    section = address_space_translate_internal(d, addr, xlat, plen, false);
+    for (;;) {
+        section = address_space_translate_internal(d, addr, &addr, plen, false);
+
+        iommu_mr = memory_region_get_iommu(section->mr);
+        if (!iommu_mr) {
+            break;
+        }
+
+        imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
+
+        iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
+        tcg_register_iommu_notifier(cpu, iommu_mr, iommu_idx);
+        /* We need all the permissions, so pass IOMMU_NONE so the IOMMU
+         * doesn't short-cut its translation table walk.
+         */
+        iotlb = imrc->translate(iommu_mr, addr, IOMMU_NONE, iommu_idx);
+        addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
+                | (addr & iotlb.addr_mask));
+        /* Update the caller's prot bits to remove permissions the IOMMU
+         * is giving us a failure response for. If we get down to no
+         * permissions left at all we can give up now.
+         */
+        if (!(iotlb.perm & IOMMU_RO)) {
+            *prot &= ~(PAGE_READ | PAGE_EXEC);
+        }
+        if (!(iotlb.perm & IOMMU_WO)) {
+            *prot &= ~PAGE_WRITE;
+        }
+
+        if (!*prot) {
+            goto translate_fail;
+        }
+
+        d = flatview_to_dispatch(address_space_to_flatview(iotlb.target_as));
+    }
 
     assert(!memory_region_is_iommu(section->mr));
+    *xlat = addr;
     return section;
+
+translate_fail:
+    return &d->map.sections[PHYS_SECTION_UNASSIGNED];
 }
 #endif
 
@@ -823,6 +949,9 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
         vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
     }
+#ifndef CONFIG_USER_ONLY
+    tcg_iommu_free_notifier_list(cpu);
+#endif
 }
 
 Property cpu_common_props[] = {
@@ -870,6 +999,8 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
     if (cc->vmsd != NULL) {
         vmstate_register(NULL, cpu->cpu_index, cc->vmsd, cpu);
     }
+
+    cpu->iommu_notifiers = g_array_new(false, true, sizeof(TCGIOMMUNotifier));
 #endif
 }
 
-- 
2.17.1
