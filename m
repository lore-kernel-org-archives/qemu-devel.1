Received: from eggs.gnu.org ([2001:4830:134:3::10]:53290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMO-0006NA-Pn
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMN-00022K-79
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:12 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:17 +1100
Message-Id: <1484288903-18807-12-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 11/17] target/ppc/POWER9: Update to new pte
 format for POWER9 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The page table entry format was updated for the POWER9 processor.

It was decided that kernels would used the old format irrespective
with the translation occuring at the hypervisor level. Thus we convert
between the old and new format when accessing the ptes. Since we need the
whole pte to perform this conversion, we remove the old functions which
accessed either the first or second doubleword and introduce a new
functions which access the entire pte, returning the entry converted
back to the old format (if required). Update call sites accordingly.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_hcall.c    | 51 ++++++++++++++++++-----------------
 target/ppc/mmu-hash64.c | 13 +++++----
 target/ppc/mmu-hash64.h | 71 ++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 86 insertions(+), 49 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 9a9bedf..9f0c20d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -125,7 +125,8 @@ static target_ulong h_enter(PowerPCCPU *cpu, sPAPRMachineState *spapr,
         pte_index &= ~7ULL;
         token = ppc_hash64_start_access(cpu, pte_index);
         for (; index < 8; index++) {
-            if (!(ppc_hash64_load_hpte0(cpu, token, index) & HPTE64_V_VALID)) {
+            ppc_hash_pte64_t pte = ppc_hash64_load_hpte(cpu, token, index);
+            if (!(pte.pte0 & HPTE64_V_VALID)) {
                 break;
             }
         }
@@ -134,8 +135,10 @@ static target_ulong h_enter(PowerPCCPU *cpu, sPAPRMachineState *spapr,
             return H_PTEG_FULL;
         }
     } else {
+        ppc_hash_pte64_t pte;
         token = ppc_hash64_start_access(cpu, pte_index);
-        if (ppc_hash64_load_hpte0(cpu, token, 0) & HPTE64_V_VALID) {
+        pte = ppc_hash64_load_hpte(cpu, token, 0);
+        if (pte.pte0 & HPTE64_V_VALID) {
             ppc_hash64_stop_access(cpu, token);
             return H_PTEG_FULL;
         }
@@ -163,26 +166,25 @@ static RemoveResult remove_hpte(PowerPCCPU *cpu, target_ulong ptex,
 {
     CPUPPCState *env = &cpu->env;
     uint64_t token;
-    target_ulong v, r;
+    ppc_hash_pte64_t pte;
 
     if (!valid_pte_index(env, ptex)) {
         return REMOVE_PARM;
     }
 
     token = ppc_hash64_start_access(cpu, ptex);
-    v = ppc_hash64_load_hpte0(cpu, token, 0);
-    r = ppc_hash64_load_hpte1(cpu, token, 0);
+    pte = ppc_hash64_load_hpte(cpu, token, 0);
     ppc_hash64_stop_access(cpu, token);
 
-    if ((v & HPTE64_V_VALID) == 0 ||
-        ((flags & H_AVPN) && (v & ~0x7fULL) != avpn) ||
-        ((flags & H_ANDCOND) && (v & avpn) != 0)) {
+    if ((pte.pte0 & HPTE64_V_VALID) == 0 ||
+        ((flags & H_AVPN) && (pte.pte0 & ~0x7fULL) != avpn) ||
+        ((flags & H_ANDCOND) && (pte.pte0 & avpn) != 0)) {
         return REMOVE_NOT_FOUND;
     }
-    *vp = v;
-    *rp = r;
+    *vp = pte.pte0;
+    *rp = pte.pte1;
     ppc_hash64_store_hpte(cpu, ptex, HPTE64_V_HPTE_DIRTY, 0);
-    ppc_hash64_tlb_flush_hpte(cpu, ptex, v, r);
+    ppc_hash64_tlb_flush_hpte(cpu, ptex, pte.pte0, pte.pte1);
     return REMOVE_SUCCESS;
 }
 
@@ -293,35 +295,36 @@ static target_ulong h_protect(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     target_ulong flags = args[0];
     target_ulong pte_index = args[1];
     target_ulong avpn = args[2];
+    ppc_hash_pte64_t pte;
     uint64_t token;
-    target_ulong v, r;
 
     if (!valid_pte_index(env, pte_index)) {
         return H_PARAMETER;
     }
 
     token = ppc_hash64_start_access(cpu, pte_index);
-    v = ppc_hash64_load_hpte0(cpu, token, 0);
-    r = ppc_hash64_load_hpte1(cpu, token, 0);
+    pte = ppc_hash64_load_hpte(cpu, token, 0);
     ppc_hash64_stop_access(cpu, token);
 
-    if ((v & HPTE64_V_VALID) == 0 ||
-        ((flags & H_AVPN) && (v & ~0x7fULL) != avpn)) {
+    if ((pte.pte0 & HPTE64_V_VALID) == 0 ||
+        ((flags & H_AVPN) && (pte.pte0 & ~0x7fULL) != avpn)) {
         return H_NOT_FOUND;
     }
 
-    r &= ~(HPTE64_R_PP0 | HPTE64_R_PP | HPTE64_R_N |
-           HPTE64_R_KEY_HI | HPTE64_R_KEY_LO);
-    r |= (flags << 55) & HPTE64_R_PP0;
-    r |= (flags << 48) & HPTE64_R_KEY_HI;
-    r |= flags & (HPTE64_R_PP | HPTE64_R_N | HPTE64_R_KEY_LO);
+    pte.pte1 &= ~(HPTE64_R_PP0 | HPTE64_R_PP | HPTE64_R_N |
+                  HPTE64_R_KEY_HI | HPTE64_R_KEY_LO);
+    pte.pte1 |= (flags << 55) & HPTE64_R_PP0;
+    pte.pte1 |= (flags << 48) & HPTE64_R_KEY_HI;
+    pte.pte1 |= flags & (HPTE64_R_PP | HPTE64_R_N | HPTE64_R_KEY_LO);
     ppc_hash64_store_hpte(cpu, pte_index,
-                          (v & ~HPTE64_V_VALID) | HPTE64_V_HPTE_DIRTY, 0);
-    ppc_hash64_tlb_flush_hpte(cpu, pte_index, v, r);
+                          (pte.pte0 & ~HPTE64_V_VALID) | HPTE64_V_HPTE_DIRTY,
+                          0);
+    ppc_hash64_tlb_flush_hpte(cpu, pte_index, pte.pte0, pte.pte1);
     /* Flush the tlb */
     check_tlb_flush(env, true);
     /* Don't need a memory barrier, due to qemu's global lock */
-    ppc_hash64_store_hpte(cpu, pte_index, v | HPTE64_V_HPTE_DIRTY, r);
+    ppc_hash64_store_hpte(cpu, pte_index, pte.pte0 | HPTE64_V_HPTE_DIRTY,
+                          pte.pte1);
     return H_SUCCESS;
 }
 
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index b476b3f..03607d5 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -515,7 +515,6 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu, hwaddr hash,
     CPUPPCState *env = &cpu->env;
     int i;
     uint64_t token;
-    target_ulong pte0, pte1;
     target_ulong pte_index;
 
     pte_index = (hash & env->htab_mask) * HPTES_PER_GROUP;
@@ -524,12 +523,11 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu, hwaddr hash,
         return -1;
     }
     for (i = 0; i < HPTES_PER_GROUP; i++) {
-        pte0 = ppc_hash64_load_hpte0(cpu, token, i);
-        pte1 = ppc_hash64_load_hpte1(cpu, token, i);
+        ppc_hash_pte64_t entry = ppc_hash64_load_hpte(cpu, token, i);
 
         /* This compares V, B, H (secondary) and the AVPN */
-        if (HPTE64_V_COMPARE(pte0, ptem)) {
-            *pshift = hpte_page_shift(sps, pte0, pte1);
+        if (HPTE64_V_COMPARE(entry.pte0, ptem)) {
+            *pshift = hpte_page_shift(sps, entry.pte0, entry.pte1);
             /*
              * If there is no match, ignore the PTE, it could simply
              * be for a different segment size encoding and the
@@ -543,8 +541,7 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu, hwaddr hash,
             /* We don't do anything with pshift yet as qemu TLB only deals
              * with 4K pages anyway
              */
-            pte->pte0 = pte0;
-            pte->pte1 = pte1;
+            *pte = entry;
             ppc_hash64_stop_access(cpu, token);
             return (pte_index + i) * HASH_PTE_SIZE_64;
         }
@@ -924,6 +921,8 @@ void ppc_hash64_store_hpte(PowerPCCPU *cpu,
 {
     CPUPPCState *env = &cpu->env;
 
+    ppc_hash64_hpte_old_to_new(env, &pte0, &pte1);
+
     if (env->external_htab == MMU_HASH64_KVM_MANAGED_HPT) {
         kvmppc_hash64_write_pte(env, pte_index, pte0, pte1);
         return;
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index ab5d347..73d7ce4 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -60,6 +60,7 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
 #define HASH_PTE_SIZE_64        16
 #define HASH_PTEG_SIZE_64       (HASH_PTE_SIZE_64 * HPTES_PER_GROUP)
 
+#define HPTE64_V_3_00_COMMON    0x000fffffffffffffULL
 #define HPTE64_V_SSIZE_SHIFT    62
 #define HPTE64_V_AVPN_SHIFT     7
 #define HPTE64_V_AVPN           0x3fffffffffffff80ULL
@@ -69,9 +70,12 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
 #define HPTE64_V_SECONDARY      0x0000000000000002ULL
 #define HPTE64_V_VALID          0x0000000000000001ULL
 
+#define HPTE64_R_3_00_COMMON    0xf1ffffffffffffffULL
 #define HPTE64_R_PP0            0x8000000000000000ULL
 #define HPTE64_R_TS             0x4000000000000000ULL
 #define HPTE64_R_KEY_HI         0x3000000000000000ULL
+#define HPTE64_R_SSIZE_SHIFT    58
+#define HPTE64_R_SSIZE_MASK     (3ULL << HPTE64_R_SSIZE_SHIFT)
 #define HPTE64_R_RPN_SHIFT      12
 #define HPTE64_R_RPN            0x0ffffffffffff000ULL
 #define HPTE64_R_FLAGS          0x00000000000003ffULL
@@ -91,6 +95,10 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
 #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
 #define HPTE64_V_VRMA_MASK      0x4001ffffff000000ULL
 
+typedef struct {
+    uint64_t pte0, pte1;
+} ppc_hash_pte64_t;
+
 void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
                          Error **errp);
 void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
@@ -99,37 +107,64 @@ void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
 uint64_t ppc_hash64_start_access(PowerPCCPU *cpu, target_ulong pte_index);
 void ppc_hash64_stop_access(PowerPCCPU *cpu, uint64_t token);
 
-static inline target_ulong ppc_hash64_load_hpte0(PowerPCCPU *cpu,
-                                                 uint64_t token, int index)
+static inline void ppc_hash64_hpte_old_to_new(CPUPPCState *env,
+                                              target_ulong *pte0,
+                                              target_ulong *pte1)
 {
-    CPUPPCState *env = &cpu->env;
-    uint64_t addr;
+    switch (env->mmu_model) {
+    case POWERPC_MMU_3_00:
+        /*
+         * v3.00 of the ISA moved the B field to the second doubleword and
+         * shortened the abbreviated virtual address and abbreviated real page
+         * number fields
+         */
+        *pte1 = (*pte1 & HPTE64_R_3_00_COMMON) |
+                ((*pte0 >> HPTE64_V_SSIZE_SHIFT) << HPTE64_R_SSIZE_SHIFT);
+        *pte0 = *pte0 & HPTE64_V_3_00_COMMON;
+    default:
+        ;
+    }
+}
 
-    addr = token + (index * HASH_PTE_SIZE_64);
-    if (env->external_htab) {
-        return  ldq_p((const void *)(uintptr_t)addr);
-    } else {
-        return ldq_phys(CPU(cpu)->as, addr);
+static inline void ppc_hash64_hpte_new_to_old(CPUPPCState *env,
+                                              target_ulong *pte0,
+                                              target_ulong *pte1)
+{
+    switch (env->mmu_model) {
+    case POWERPC_MMU_3_00:
+        /*
+         * v3.00 of the ISA moved the B field to the second doubleword and
+         * shortened the abbreviated virtual address and abbreviated real page
+         * number fields
+         */
+        *pte0 = (*pte0 & HPTE64_V_3_00_COMMON) | ((*pte1 & HPTE64_R_SSIZE_MASK)
+                << (HPTE64_V_SSIZE_SHIFT - HPTE64_R_SSIZE_SHIFT));
+        *pte1 = *pte1 & HPTE64_R_3_00_COMMON;
+    default:
+        ;
     }
 }
 
-static inline target_ulong ppc_hash64_load_hpte1(PowerPCCPU *cpu,
-                                                 uint64_t token, int index)
+static inline ppc_hash_pte64_t ppc_hash64_load_hpte(PowerPCCPU *cpu,
+                                                    uint64_t token,
+                                                    int index)
 {
     CPUPPCState *env = &cpu->env;
+    ppc_hash_pte64_t pte;
     uint64_t addr;
 
-    addr = token + (index * HASH_PTE_SIZE_64) + HASH_PTE_SIZE_64/2;
+    addr = token + (index * HASH_PTE_SIZE_64);
     if (env->external_htab) {
-        return  ldq_p((const void *)(uintptr_t)addr);
+        pte.pte0 = ldq_p((const void *)(uintptr_t)addr);
+        pte.pte1 = ldq_p((const void *)(uintptr_t)addr + HASH_PTE_SIZE_64/2);
     } else {
-        return ldq_phys(CPU(cpu)->as, addr);
+        pte.pte0 = ldq_phys(CPU(cpu)->as, addr);
+        pte.pte1 = ldq_phys(CPU(cpu)->as, addr + HASH_PTE_SIZE_64/2);
     }
-}
 
-typedef struct {
-    uint64_t pte0, pte1;
-} ppc_hash_pte64_t;
+    ppc_hash64_hpte_new_to_old(env, &pte.pte0, &pte.pte1);
+    return pte;
+}
 
 #endif /* CONFIG_USER_ONLY */
 
-- 
2.5.5
