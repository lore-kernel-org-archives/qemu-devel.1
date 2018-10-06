Received: from eggs.gnu.org ([2001:4830:134:3::10]:34473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uO8-0000AX-Vj
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uO5-0007FD-O9
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38521)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g8uO2-00075d-0k
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:23 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  6 Oct 2018 17:45:05 -0400
Message-Id: <20181006214508.5331-4-cota@braap.org>
In-Reply-To: <20181006214508.5331-1-cota@braap.org>
References: <20181006214508.5331-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 3/6] cputlb: track TLB use rates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This paves the way for implementing a dynamically-sized softmmu.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/cpu-defs.h |  1 +
 accel/tcg/cputlb.c      | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index fa95a4257e..af9fe04b0b 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -144,6 +144,7 @@ typedef struct CPUIOTLBEntry {
 typedef struct CPUTLBDesc {
     size_t size;
     size_t mask; /* (.size - 1) << CPU_TLB_ENTRY_BITS for TLB fast path */
+    size_t used;
 } CPUTLBDesc;
 
 #define CPU_COMMON_TLB  \
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 0e2c149d6b..ed19ac0e40 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -84,6 +84,7 @@ void tlb_init(CPUState *cpu)
 
         desc->size = CPU_TLB_SIZE;
         desc->mask = (desc->size - 1) << CPU_TLB_ENTRY_BITS;
+        desc->used = 0;
         env->tlb_table[i] = g_new(CPUTLBEntry, desc->size);
         env->iotlb[i] = g_new0(CPUIOTLBEntry, desc->size);
     }
@@ -152,6 +153,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
     for (i = 0; i < NB_MMU_MODES; i++) {
         memset(env->tlb_table[i], -1,
                env->tlb_desc[i].size * sizeof(CPUTLBEntry));
+        env->tlb_desc[i].used = 0;
     }
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
     qemu_spin_unlock(&env->tlb_lock);
@@ -216,6 +218,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
             memset(env->tlb_table[mmu_idx], -1,
                    env->tlb_desc[mmu_idx].size * sizeof(CPUTLBEntry));
             memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
+            env->tlb_desc[mmu_idx].used = 0;
         }
     }
     qemu_spin_unlock(&env->tlb_lock);
@@ -276,12 +279,14 @@ static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
 }
 
 /* Called with tlb_lock held */
-static inline void tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
+static inline bool tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
                                           target_ulong page)
 {
     if (tlb_hit_page_anyprot(tlb_entry, page)) {
         memset(tlb_entry, -1, sizeof(*tlb_entry));
+        return true;
     }
+    return false;
 }
 
 /* Called with tlb_lock held */
@@ -321,7 +326,9 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         int i = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
 
-        tlb_flush_entry_locked(&env->tlb_table[mmu_idx][i], addr);
+        if (tlb_flush_entry_locked(&env->tlb_table[mmu_idx][i], addr)) {
+            env->tlb_desc[mmu_idx].used--;
+        }
         tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
     }
     qemu_spin_unlock(&env->tlb_lock);
@@ -365,7 +372,9 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
 
         page = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);
         if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
-            tlb_flush_entry_locked(&env->tlb_table[mmu_idx][page], addr);
+            if (tlb_flush_entry_locked(&env->tlb_table[mmu_idx][page], addr)) {
+                env->tlb_desc[mmu_idx].used--;
+            }
             tlb_flush_vtlb_page_locked(env, mmu_idx, addr);
         }
     }
@@ -702,6 +711,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         /* Evict the old entry into the victim tlb.  */
         copy_tlb_helper_locked(tv, te);
         env->iotlb_v[mmu_idx][vidx] = env->iotlb[mmu_idx][index];
+        env->tlb_desc[mmu_idx].used--;
     }
 
     /* refill the tlb */
@@ -753,6 +763,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     }
 
     copy_tlb_helper_locked(te, &tn);
+    env->tlb_desc[mmu_idx].used++;
     qemu_spin_unlock(&env->tlb_lock);
 }
 
-- 
2.17.1
