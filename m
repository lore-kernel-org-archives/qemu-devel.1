Received: from eggs.gnu.org ([2001:4830:134:3::10]:53090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gS93W-0006hT-NU
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 18:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gS93P-0002lv-CO
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 18:15:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:43617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
	id 1gS93L-0002eN-H2
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 18:15:33 -0500
Message-ID: <f4349b9ee95cbd9d5b16e9033fdf0d7c9e99aebf.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 29 Nov 2018 10:15:20 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC/PATCH] i386: Atomically update PTEs with mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Afaik, this isn't well documented (at least it wasn't when I last looked)
but OSes such as Linux rely on this behaviour:

The HW updates to the page tables need to be done atomically with the
checking of the present bit (and other permissions).

This is what allows Linux to do simple xchg of PTEs with 0 and assume
the value read has "final" stable dirty and accessed bits (the TLB
invalidation is deferred).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This is lightly tested at this point, mostly to gather comments on the
approach.

I noticed that RiscV is attempting to do something similar but with endian
bugs, at least from my reading of the code.

 include/exec/memory_ldst.inc.h |   3 +
 memory_ldst.inc.c              |  38 ++++++++++++
 target/i386/excp_helper.c      | 104 +++++++++++++++++++++++++--------
 3 files changed, 121 insertions(+), 24 deletions(-)

diff --git a/include/exec/memory_ldst.inc.h b/include/exec/memory_ldst.inc.h
index 272c20f02e..b7a41a0ad4 100644
--- a/include/exec/memory_ldst.inc.h
+++ b/include/exec/memory_ldst.inc.h
@@ -28,6 +28,9 @@ extern uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 extern void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+extern uint32_t glue(address_space_cmpxchgl_notdirty, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t old, uint32_t new, MemTxAttrs attrs,
+    MemTxResult *result);
 extern void glue(address_space_stw, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 extern void glue(address_space_stl, SUFFIX)(ARG1_DECL,
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index acf865b900..63af8f7dd2 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -320,6 +320,44 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     RCU_READ_UNLOCK();
 }
 
+/* This is meant to be used for atomic PTE updates under MT-TCG */
+uint32_t glue(address_space_cmpxchgl_notdirty, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t old, uint32_t new, MemTxAttrs attrs, MemTxResult *result)
+{
+    uint8_t *ptr;
+    MemoryRegion *mr;
+    hwaddr l = 4;
+    hwaddr addr1;
+    MemTxResult r;
+    uint8_t dirty_log_mask;
+
+    /* Must test result */
+    assert(result);
+
+    RCU_READ_LOCK();
+    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
+    if (l < 4 || !memory_access_is_direct(mr, true)) {
+        r = MEMTX_ERROR;
+    } else {
+        uint32_t orig = old;
+
+        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
+        old = atomic_cmpxchg(ptr, orig, new);
+
+        if (old == orig) {
+            dirty_log_mask = memory_region_get_dirty_log_mask(mr);
+            dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
+            cpu_physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
+                                                4, dirty_log_mask);
+        }
+        r = MEMTX_OK;
+    }
+    *result = r;
+    RCU_READ_UNLOCK();
+
+    return old;
+}
+
 /* warning: addr must be aligned */
 static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs,
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index 49231f6b69..5ccb9d6d6a 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -157,11 +157,45 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
 
 #else
 
+static inline uint64_t update_entry(CPUState *cs, target_ulong addr,
+                                    uint64_t orig_entry, uint32_t bits)
+{
+    uint64_t new_entry = orig_entry | bits;
+
+    /* Write the updated bottom 32-bits */
+    if (qemu_tcg_mttcg_enabled()) {
+        uint32_t old_le = cpu_to_le32(orig_entry);
+        uint32_t new_le = cpu_to_le32(new_entry);
+        MemTxResult result;
+        uint32_t old_ret;
+
+        old_ret = address_space_cmpxchgl_notdirty(cs->as, addr,
+                                                  old_le, new_le,
+                                                  MEMTXATTRS_UNSPECIFIED,
+                                                  &result);
+        if (result == MEMTX_OK) {
+            if (old_ret != old_le) {
+                new_entry = 0;
+            }
+            return new_entry;
+        }
+
+        /* Do we need to support this case where PTEs aren't in RAM ?
+         *
+         * For now fallback to non-atomic case
+         */
+    }
+
+    x86_stl_phys_notdirty(cs, addr, new_entry);
+
+    return new_entry;
+}
+
 static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
                         int *prot)
 {
     CPUX86State *env = &X86_CPU(cs)->env;
-    uint64_t rsvd_mask = PG_HI_RSVD_MASK;
+    uint64_t rsvd_mask;
     uint64_t ptep, pte;
     uint64_t exit_info_1 = 0;
     target_ulong pde_addr, pte_addr;
@@ -172,6 +206,8 @@ static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
         return gphys;
     }
 
+ restart:
+    rsvd_mask = PG_HI_RSVD_MASK;
     if (!(env->nested_pg_mode & SVM_NPT_NXE)) {
         rsvd_mask |= PG_NX_MASK;
     }
@@ -198,8 +234,10 @@ static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
                 goto do_fault_rsvd;
             }
             if (!(pml4e & PG_ACCESSED_MASK)) {
-                pml4e |= PG_ACCESSED_MASK;
-                x86_stl_phys_notdirty(cs, pml4e_addr, pml4e);
+                pml4e = update_entry(cs, pml4e_addr, pml4e, PG_ACCESSED_MASK);
+                if (!pml4e) {
+                    goto restart;
+                }
             }
             ptep &= pml4e ^ PG_NX_MASK;
             pdpe_addr = (pml4e & PG_ADDRESS_MASK) +
@@ -213,8 +251,10 @@ static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
             }
             ptep &= pdpe ^ PG_NX_MASK;
             if (!(pdpe & PG_ACCESSED_MASK)) {
-                pdpe |= PG_ACCESSED_MASK;
-                x86_stl_phys_notdirty(cs, pdpe_addr, pdpe);
+                pdpe = update_entry(cs, pdpe_addr, pdpe, PG_ACCESSED_MASK);
+                if (!pdpe) {
+                    goto restart;
+                }
             }
             if (pdpe & PG_PSE_MASK) {
                 /* 1 GB page */
@@ -256,8 +296,10 @@ static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
         }
         /* 4 KB page */
         if (!(pde & PG_ACCESSED_MASK)) {
-            pde |= PG_ACCESSED_MASK;
-            x86_stl_phys_notdirty(cs, pde_addr, pde);
+            pde = update_entry(cs, pde_addr, pde, PG_ACCESSED_MASK);
+            if (!pde) {
+                goto restart;
+            }
         }
         pte_addr = (pde & PG_ADDRESS_MASK) + (((gphys >> 12) & 0x1ff) << 3);
         pte = x86_ldq_phys(cs, pte_addr);
@@ -295,8 +337,10 @@ static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
         }
 
         if (!(pde & PG_ACCESSED_MASK)) {
-            pde |= PG_ACCESSED_MASK;
-            x86_stl_phys_notdirty(cs, pde_addr, pde);
+            pde = update_entry(cs, pde_addr, pde, PG_ACCESSED_MASK);
+            if (!pde) {
+                goto restart;
+            }
         }
 
         /* page directory entry */
@@ -376,7 +420,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
     int error_code = 0;
     int is_dirty, prot, page_size, is_write, is_user;
     hwaddr paddr;
-    uint64_t rsvd_mask = PG_HI_RSVD_MASK;
+    uint64_t rsvd_mask;
     uint32_t page_offset;
     target_ulong vaddr;
 
@@ -401,6 +445,8 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
         goto do_mapping;
     }
 
+ restart:
+    rsvd_mask = PG_HI_RSVD_MASK;
     if (!(env->efer & MSR_EFER_NXE)) {
         rsvd_mask |= PG_NX_MASK;
     }
@@ -436,8 +482,10 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
                     goto do_fault_rsvd;
                 }
                 if (!(pml5e & PG_ACCESSED_MASK)) {
-                    pml5e |= PG_ACCESSED_MASK;
-                    x86_stl_phys_notdirty(cs, pml5e_addr, pml5e);
+                    pml5e = update_entry(cs, pml5e_addr, pml5e, PG_ACCESSED_MASK);
+                    if (!pml5e) {
+                        goto restart;
+                    }
                 }
                 ptep = pml5e ^ PG_NX_MASK;
             } else {
@@ -456,8 +504,10 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
                 goto do_fault_rsvd;
             }
             if (!(pml4e & PG_ACCESSED_MASK)) {
-                pml4e |= PG_ACCESSED_MASK;
-                x86_stl_phys_notdirty(cs, pml4e_addr, pml4e);
+                pml4e = update_entry(cs, pml4e_addr, pml4e, PG_ACCESSED_MASK);
+                if (!pml4e) {
+                    goto restart;
+                }
             }
             ptep &= pml4e ^ PG_NX_MASK;
             pdpe_addr = ((pml4e & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3)) &
@@ -472,8 +522,10 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
             }
             ptep &= pdpe ^ PG_NX_MASK;
             if (!(pdpe & PG_ACCESSED_MASK)) {
-                pdpe |= PG_ACCESSED_MASK;
-                x86_stl_phys_notdirty(cs, pdpe_addr, pdpe);
+                pdpe = update_entry(cs, pdpe_addr, pdpe, PG_ACCESSED_MASK);
+                if (!pdpe) {
+                    goto restart;
+                }
             }
             if (pdpe & PG_PSE_MASK) {
                 /* 1 GB page */
@@ -520,8 +572,10 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
         }
         /* 4 KB page */
         if (!(pde & PG_ACCESSED_MASK)) {
-            pde |= PG_ACCESSED_MASK;
-            x86_stl_phys_notdirty(cs, pde_addr, pde);
+            pde = update_entry(cs, pde_addr, pde, PG_ACCESSED_MASK);
+            if (!pde) {
+                goto restart;
+            }
         }
         pte_addr = ((pde & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3)) &
             a20_mask;
@@ -563,8 +617,10 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
         }
 
         if (!(pde & PG_ACCESSED_MASK)) {
-            pde |= PG_ACCESSED_MASK;
-            x86_stl_phys_notdirty(cs, pde_addr, pde);
+            pde = update_entry(cs, pde_addr, pde, PG_ACCESSED_MASK);
+            if (!pde) {
+                goto restart;
+            }
         }
 
         /* page directory entry */
@@ -634,11 +690,11 @@ do_check_protect_pse36:
     /* yes, it can! */
     is_dirty = is_write && !(pte & PG_DIRTY_MASK);
     if (!(pte & PG_ACCESSED_MASK) || is_dirty) {
-        pte |= PG_ACCESSED_MASK;
-        if (is_dirty) {
-            pte |= PG_DIRTY_MASK;
+        pte = update_entry(cs, pte_addr, pte,
+                           PG_ACCESSED_MASK | (is_dirty ? PG_DIRTY_MASK : 0));
+        if (!pte) {
+            goto restart;
         }
-        x86_stl_phys_notdirty(cs, pte_addr, pte);
     }
 
     if (!(pte & PG_DIRTY_MASK)) {
