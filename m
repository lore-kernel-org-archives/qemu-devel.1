Received: from eggs.gnu.org ([2001:4830:134:3::10]:40709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUGGa-0005cq-QH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUGGV-0001hY-MZ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:12:52 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:34726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUGGV-0001gY-DO
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:12:47 -0500
Received: by mail-wm0-x236.google.com with SMTP id f73so7394261wmf.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:12:47 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:04:57 +0000
Message-Id: <20170119170507.16185-18-alex.bennee@linaro.org>
In-Reply-To: <20170119170507.16185-1-alex.bennee@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 17/27] cputlb: atomically update tlb fields
 used by tlb_reset_dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

The main use case for tlb_reset_dirty is to set the TLB_NOTDIRTY flags
in TLB entries to force the slow-path on writes. This is used to mark
page ranges containing code which has been translated so it can be
invalidated if written to. To do this safely we need to ensure the TLB
entries in question for all vCPUs are updated before we attempt to run
the code otherwise a race could be introduced.

To achieve this we atomically set the flag in tlb_reset_dirty_range and
take care when setting it when the TLB entry is filled.

On 32 bit systems attempting to emulate 64 bit guests we don't even
bother as we might not have the atomic primitives available. MTTCG is
disabled in this case and can't be forced on. The copy_tlb_helper
function helps keep the atomic semantics in one place to avoid
confusion.

The dirty helper function is made static as it isn't used outside of
cputlb.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v6
  - use TARGET_PAGE_BITS_MIN
  - use run_on_cpu helpers
v7
  - fix tlb_debug fmt for 32bit build
  - un-merged the mmuidx async work which got mashed in last round
  - introduced copy_tlb_helper function and made TCG_OVERSIZED_GUEST aware
---
 cputlb.c              | 120 +++++++++++++++++++++++++++++++++++++++-----------
 include/exec/cputlb.h |   2 -
 2 files changed, 95 insertions(+), 27 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 207faf2ea0..856213cbcb 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -384,32 +384,90 @@ void tlb_unprotect_code(ram_addr_t ram_addr)
     cpu_physical_memory_set_dirty_flag(ram_addr, DIRTY_MEMORY_CODE);
 }
 
-static bool tlb_is_dirty_ram(CPUTLBEntry *tlbe)
-{
-    return (tlbe->addr_write & (TLB_INVALID_MASK|TLB_MMIO|TLB_NOTDIRTY)) == 0;
-}
 
-void tlb_reset_dirty_range(CPUTLBEntry *tlb_entry, uintptr_t start,
+/*
+ * Dirty write flag handling
+ *
+ * When the TCG code writes to a location it looks up the address in
+ * the TLB and uses that data to compute the final address. If any of
+ * the lower bits of the address are set then the slow path is forced.
+ * There are a number of reasons to do this but for normal RAM the
+ * most usual is detecting writes to code regions which may invalidate
+ * generated code.
+ *
+ * Because we want other vCPUs to respond to changes straight away we
+ * update the te->addr_write field atomically. If the TLB entry has
+ * been changed by the vCPU in the mean time we skip the update.
+ *
+ * As this function uses atomic accesses we also need to ensure
+ * updates to tlb_entries follow the same access rules. We don't need
+ * to worry about this for oversized guests as MTTCG is disabled for
+ * them.
+ */
+
+static void tlb_reset_dirty_range(CPUTLBEntry *tlb_entry, uintptr_t start,
                            uintptr_t length)
 {
-    uintptr_t addr;
+#if TCG_OVERSIZED_GUEST
+    uintptr_t addr = tlb_entry->addr_write;
 
-    if (tlb_is_dirty_ram(tlb_entry)) {
-        addr = (tlb_entry->addr_write & TARGET_PAGE_MASK) + tlb_entry->addend;
+    if ((addr & (TLB_INVALID_MASK | TLB_MMIO | TLB_NOTDIRTY)) == 0) {
+        addr &= TARGET_PAGE_MASK;
+        addr += tlb_entry->addend;
         if ((addr - start) < length) {
             tlb_entry->addr_write |= TLB_NOTDIRTY;
         }
     }
+#else
+    /* paired with atomic_mb_set in tlb_set_page_with_attrs */
+    uintptr_t orig_addr = atomic_mb_read(&tlb_entry->addr_write);
+    uintptr_t addr = orig_addr;
+
+    if ((addr & (TLB_INVALID_MASK | TLB_MMIO | TLB_NOTDIRTY)) == 0) {
+        addr &= TARGET_PAGE_MASK;
+        addr += atomic_read(&tlb_entry->addend);
+        if ((addr - start) < length) {
+            uintptr_t notdirty_addr = orig_addr | TLB_NOTDIRTY;
+            atomic_cmpxchg(&tlb_entry->addr_write, orig_addr, notdirty_addr);
+        }
+    }
+#endif
+}
+
+/* For atomic correctness when running MTTCG we need to use the right
+ * primitives when copying entries */
+static inline void copy_tlb_helper(CPUTLBEntry *d, CPUTLBEntry *s,
+                                   bool atomic_set)
+{
+#if TCG_OVERSIZED_GUEST
+    *d = *s;
+#else
+    if (atomic_set) {
+        d->addr_read = s->addr_read;
+        d->addr_code = s->addr_code;
+        atomic_set(&d->addend, atomic_read(&s->addend));
+        /* Pairs with flag setting in tlb_reset_dirty_range */
+        atomic_mb_set(&d->addr_write, atomic_read(&s->addr_write));
+    } else {
+        d->addr_read = s->addr_read;
+        d->addr_write = atomic_read(&s->addr_write);
+        d->addr_code = s->addr_code;
+        d->addend = atomic_read(&s->addend);
+    }
+#endif
 }
 
+/* This is a cross vCPU call (i.e. another vCPU resetting the flags of
+ * the target vCPU). As such care needs to be taken that we don't
+ * dangerously race with another vCPU update. The only thing actually
+ * updated is the target TLB entry ->addr_write flags.
+ */
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 {
     CPUArchState *env;
 
     int mmu_idx;
 
-    assert_cpu_is_self(cpu);
-
     env = cpu->env_ptr;
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
@@ -497,7 +555,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     target_ulong address;
     target_ulong code_address;
     uintptr_t addend;
-    CPUTLBEntry *te;
+    CPUTLBEntry *te, *tv, tn;
     hwaddr iotlb, xlat, sz;
     unsigned vidx = env->vtlb_index++ % CPU_VTLB_SIZE;
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
@@ -532,41 +590,50 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
 
     index = (vaddr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     te = &env->tlb_table[mmu_idx][index];
-
     /* do not discard the translation in te, evict it into a victim tlb */
-    env->tlb_v_table[mmu_idx][vidx] = *te;
+    tv = &env->tlb_v_table[mmu_idx][vidx];
+
+    /* addr_write can race with tlb_reset_dirty_range */
+    copy_tlb_helper(tv, te, true);
+
     env->iotlb_v[mmu_idx][vidx] = env->iotlb[mmu_idx][index];
 
     /* refill the tlb */
     env->iotlb[mmu_idx][index].addr = iotlb - vaddr;
     env->iotlb[mmu_idx][index].attrs = attrs;
-    te->addend = addend - vaddr;
+
+    /* Now calculate the new entry */
+    tn.addend = addend - vaddr;
     if (prot & PAGE_READ) {
-        te->addr_read = address;
+        tn.addr_read = address;
     } else {
-        te->addr_read = -1;
+        tn.addr_read = -1;
     }
 
     if (prot & PAGE_EXEC) {
-        te->addr_code = code_address;
+        tn.addr_code = code_address;
     } else {
-        te->addr_code = -1;
+        tn.addr_code = -1;
     }
+
+    tn.addr_write = -1;
     if (prot & PAGE_WRITE) {
         if ((memory_region_is_ram(section->mr) && section->readonly)
             || memory_region_is_romd(section->mr)) {
             /* Write access calls the I/O callback.  */
-            te->addr_write = address | TLB_MMIO;
+            tn.addr_write = address | TLB_MMIO;
         } else if (memory_region_is_ram(section->mr)
                    && cpu_physical_memory_is_clean(
                         memory_region_get_ram_addr(section->mr) + xlat)) {
-            te->addr_write = address | TLB_NOTDIRTY;
+            tn.addr_write = address | TLB_NOTDIRTY;
         } else {
-            te->addr_write = address;
+            tn.addr_write = address;
         }
-    } else {
-        te->addr_write = -1;
     }
+
+    /* Pairs with flag setting in tlb_reset_dirty_range */
+    copy_tlb_helper(te, &tn, true);
+    /* atomic_mb_set(&te->addr_write, write_address); */
 }
 
 /* Add a new TLB entry, but without specifying the memory
@@ -729,10 +796,13 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
         if (cmp == page) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
             CPUTLBEntry tmptlb, *tlb = &env->tlb_table[mmu_idx][index];
+
+            copy_tlb_helper(&tmptlb, tlb, false);
+            copy_tlb_helper(tlb, vtlb, true);
+            copy_tlb_helper(vtlb, &tmptlb, true);
+
             CPUIOTLBEntry tmpio, *io = &env->iotlb[mmu_idx][index];
             CPUIOTLBEntry *vio = &env->iotlb_v[mmu_idx][vidx];
-
-            tmptlb = *tlb; *tlb = *vtlb; *vtlb = tmptlb;
             tmpio = *io; *io = *vio; *vio = tmpio;
             return true;
         }
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index d454c005b7..3f941783c5 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -23,8 +23,6 @@
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
-void tlb_reset_dirty_range(CPUTLBEntry *tlb_entry, uintptr_t start,
-                           uintptr_t length);
 extern int tlb_flush_count;
 
 #endif
-- 
2.11.0
