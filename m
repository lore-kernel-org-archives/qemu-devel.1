Received: from eggs.gnu.org ([2001:4830:134:3::10]:59873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vuv-00040Y-Rj
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vuu-0004EZ-TT
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:45 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:17 +0200
Message-Id: <20171020115418.2050-46-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 45/46] accel/tcg: allow to invalidate a write
 TLB entry immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Background: s390x implements Low-Address Protection (LAP). If LAP is
enabled, writing to effective addresses (before any translation)
0-511 and 4096-4607 triggers a protection exception.

So we have subpage protection on the first two pages of every address
space (where the lowcore - the CPU private data resides).

By immediately invalidating the write entry but allowing the caller to
continue, we force every write access onto these first two pages into
the slow path. we will get a tlb fault with the specific accessed
addresses and can then evaluate if protection applies or not.

We have to make sure to ignore the invalid bit if tlb_fill() succeeds.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171016202358.3633-2-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 accel/tcg/cputlb.c           | 5 ++++-
 accel/tcg/softmmu_template.h | 4 ++--
 include/exec/cpu-all.h       | 3 +++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5b1ef1442c..a23919c3a8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -694,6 +694,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         } else {
             tn.addr_write = address;
         }
+        if (prot & PAGE_WRITE_INV) {
+            tn.addr_write |= TLB_INVALID_MASK;
+        }
     }
 
     /* Pairs with flag setting in tlb_reset_dirty_range */
@@ -978,7 +981,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_STORE, mmu_idx, retaddr);
         }
-        tlb_addr = tlbe->addr_write;
+        tlb_addr = tlbe->addr_write & ~TLB_INVALID_MASK;
     }
 
     /* Check notdirty */
diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index d7563292a5..3fc5144316 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -285,7 +285,7 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_STORE, mmu_idx, retaddr);
         }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
     }
 
     /* Handle an IO access.  */
@@ -361,7 +361,7 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_STORE, mmu_idx, retaddr);
         }
-        tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
     }
 
     /* Handle an IO access.  */
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 778031c3d7..0b141683f0 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -245,6 +245,9 @@ extern intptr_t qemu_host_page_mask;
 /* original state of the write flag (used when tracking self-modifying
    code */
 #define PAGE_WRITE_ORG 0x0010
+/* Invalidate the TLB entry immediately, helpful for s390x
+ * Low-Address-Protection. Used with PAGE_WRITE in tlb_set_page_with_attrs() */
+#define PAGE_WRITE_INV 0x0040
 #if defined(CONFIG_BSD) && defined(CONFIG_USER_ONLY)
 /* FIXME: Code that sets/uses this is broken and needs to go away.  */
 #define PAGE_RESERVED  0x0020
-- 
2.13.6
