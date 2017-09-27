Received: from eggs.gnu.org ([2001:4830:134:3::10]:60016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxFhU-0006bM-33
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxFhQ-00064n-0r
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxFhP-00064E-Ou
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:00:39 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 27 Sep 2017 19:00:25 +0200
Message-Id: <20170927170027.8539-2-david@redhat.com>
In-Reply-To: <20170927170027.8539-1-david@redhat.com>
References: <20170927170027.8539-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 1/3] accel/tcg: allow to invalidate a write
 TLB entry immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>

Background: s390x implements Low-Address Protection (LAP). If LAP is
enabled, writing to effective addresses (before any transaltion)
0-511 and 4096-4607 triggers a protection exception.

So we have subpage protection on the first two pages of every address
space (where the lowcore - the CPU private data resides).

By immediately invalidating the write entry but allowing the caller to
continue, we force every write access onto these first two pages into
the slow path. we will get a tlb fault with the specific accessed
addresses and can then evaluate if protection applies or not.

We have to make sure to ignore the invalid bit if tlb_fill() succeeds.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/tcg/cputlb.c           | 5 ++++-
 accel/tcg/softmmu_template.h | 4 ++--
 include/exec/cpu-all.h       | 3 +++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index bcbcc4db6c..5bc4233961 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -683,6 +683,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         } else {
             tn.addr_write = address;
         }
+        if (prot & PAGE_WRITE_INV) {
+            tn.addr_write |= TLB_INVALID_MASK;
+        }
     }
 
     /* Pairs with flag setting in tlb_reset_dirty_range */
@@ -967,7 +970,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
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
index ffe43d5654..24b9509604 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -247,6 +247,9 @@ extern intptr_t qemu_host_page_mask;
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
2.13.5
