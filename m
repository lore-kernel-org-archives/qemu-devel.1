Received: from eggs.gnu.org ([2001:4830:134:3::10]:42848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQN-0002tx-JN
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQG-0000zS-Nr
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:31 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 15:03:52 +0100
Message-Id: <20180521140402.23318-18-peter.maydell@linaro.org>
In-Reply-To: <20180521140402.23318-1-peter.maydell@linaro.org>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 17/27] exec.c: Handle IOMMUs in
 address_space_translate_for_iotlb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
---
 include/exec/exec-all.h |   3 +-
 include/qom/cpu.h       |   3 +
 accel/tcg/cputlb.c      |   3 +-
 exec.c                  | 147 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 152 insertions(+), 4 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4d09eaba72..e0ff19b711 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -469,7 +469,8 @@ void tb_flush_jmp_cache(CPUState *cpu, target_ulong addr);
 
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
-                                  hwaddr *xlat, hwaddr *plen);
+                                  hwaddr *xlat, hwaddr *plen,
+                                  MemTxAttrs attrs, int *prot);
 hwaddr memory_region_section_get_iotlb(CPUState *cpu,
                                        MemoryRegionSection *section,
                                        target_ulong vaddr,
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 9d3afc6c75..d4a30149dd 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -429,6 +429,9 @@ struct CPUState {
     uint16_t pending_tlb_flush;
 
     int hvf_fd;
+
+    /* track IOMMUs whose translations we've cached in the TCG TLB */
+    GSList *iommu_notifiers;
 };
 
 QTAILQ_HEAD(CPUTailQ, CPUState);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 05439039e9..c8acaf21e9 100644
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
index c9285c9c39..6c8f2dcc3f 100644
--- a/exec.c
+++ b/exec.c
@@ -650,18 +650,158 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
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
+static gint tcg_iommu_find_notifier(gconstpointer a, gconstpointer b)
+{
+    TCGIOMMUNotifier *notifier = (TCGIOMMUNotifier *)a;
+    TCGIOMMUNotifier *seeking = (TCGIOMMUNotifier *)b;
+
+    if (notifier->mr == seeking->mr &&
+        notifier->iommu_idx == seeking->iommu_idx) {
+        return 0;
+    }
+    return 1;
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
+    TCGIOMMUNotifier seeking = {
+        .mr = MEMORY_REGION(iommu_mr),
+        .iommu_idx = iommu_idx,
+    };
+    TCGIOMMUNotifier *notifier;
+    GSList *found = g_slist_find_custom(cpu->iommu_notifiers,
+                                        &seeking,
+                                        tcg_iommu_find_notifier);
+    if (found) {
+        notifier = found->data;
+    } else {
+        notifier = g_new0(TCGIOMMUNotifier, 1);
+        notifier->mr = seeking.mr;
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
+        cpu->iommu_notifiers = g_slist_prepend(cpu->iommu_notifiers,
+                                               notifier);
+    }
+    if (!notifier->active) {
+        notifier->active = true;
+    }
+}
+
+static void tcg_iommu_notifier_destroy(gpointer data)
+{
+    TCGIOMMUNotifier *notifier = data;
+
+    if (notifier->active) {
+        memory_region_unregister_iommu_notifier(notifier->mr, &notifier->n);
+    }
+    g_free(notifier);
+}
+
+static void tcg_iommu_free_notifier_list(CPUState *cpu)
+{
+    /* Destroy the CPU's notifier list */
+    g_slist_free_full(cpu->iommu_notifiers, tcg_iommu_notifier_destroy);
+    cpu->iommu_notifiers = NULL;
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
 
@@ -820,6 +960,9 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
         vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
     }
+#ifndef CONFIG_USER_ONLY
+    tcg_iommu_free_notifier_list(cpu);
+#endif
 }
 
 Property cpu_common_props[] = {
-- 
2.17.0
