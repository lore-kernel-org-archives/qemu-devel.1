Received: from eggs.gnu.org ([2001:4830:134:3::10]:57513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgiqo-0004Pe-EF
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgiql-0007ZV-8D
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:09:46 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 23 Feb 2017 13:09:31 +1100
Message-Id: <20170223020936.29220-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170223020936.29220-1-david@gibson.dropbear.id.au>
References: <20170223020936.29220-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 1/6] pseries: Minor cleanups to HPT management
 hypercalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, aik@ozlabs.ru, sjitindarsingh@gmail.com
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>

 * Standardize on 'ptex' instead of 'pte_index' for HPTE index variables
   for consistency and brevity
 * Avoid variables named 'index'; shadowing index(3) from libc can lead to
   surprising bugs if the variable is removed, because compiler errors
   might not appear for remaining references
 * Clarify index calculations in h_enter() - we have two cases, H_EXACT
   where the exact HPTE slot is given, and !H_EXACT where we search for
   an empty slot within the hash bucket.  Make the calculation more
   consistent between the cases.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 58 +++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 42d20e0..3298a14 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -47,12 +47,12 @@ static bool has_spr(PowerPCCPU *cpu, int spr)
     return cpu->env.spr_cb[spr].name != NULL;
 }
 
-static inline bool valid_pte_index(CPUPPCState *env, target_ulong pte_index)
+static inline bool valid_ptex(PowerPCCPU *cpu, target_ulong ptex)
 {
     /*
      * hash value/pteg group index is normalized by htab_mask
      */
-    if (((pte_index & ~7ULL) / HPTES_PER_GROUP) & ~env->htab_mask) {
+    if (((ptex & ~7ULL) / HPTES_PER_GROUP) & ~cpu->env.htab_mask) {
         return false;
     }
     return true;
@@ -77,14 +77,13 @@ static bool is_ram_address(sPAPRMachineState *spapr, hwaddr addr)
 static target_ulong h_enter(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                             target_ulong opcode, target_ulong *args)
 {
-    CPUPPCState *env = &cpu->env;
     target_ulong flags = args[0];
-    target_ulong pte_index = args[1];
+    target_ulong ptex = args[1];
     target_ulong pteh = args[2];
     target_ulong ptel = args[3];
     unsigned apshift;
     target_ulong raddr;
-    target_ulong index;
+    target_ulong slot;
     uint64_t token;
 
     apshift = ppc_hash64_hpte_page_shift_noslb(cpu, pteh, ptel);
@@ -116,25 +115,26 @@ static target_ulong h_enter(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 
     pteh &= ~0x60ULL;
 
-    if (!valid_pte_index(env, pte_index)) {
+    if (!valid_ptex(cpu, ptex)) {
         return H_PARAMETER;
     }
 
-    index = 0;
+    slot = ptex & 7ULL;
+    ptex = ptex & ~7ULL;
+
     if (likely((flags & H_EXACT) == 0)) {
-        pte_index &= ~7ULL;
-        token = ppc_hash64_start_access(cpu, pte_index);
-        for (; index < 8; index++) {
-            if (!(ppc_hash64_load_hpte0(cpu, token, index) & HPTE64_V_VALID)) {
+        token = ppc_hash64_start_access(cpu, ptex);
+        for (slot = 0; slot < 8; slot++) {
+            if (!(ppc_hash64_load_hpte0(cpu, token, slot) & HPTE64_V_VALID)) {
                 break;
             }
         }
         ppc_hash64_stop_access(cpu, token);
-        if (index == 8) {
+        if (slot == 8) {
             return H_PTEG_FULL;
         }
     } else {
-        token = ppc_hash64_start_access(cpu, pte_index);
+        token = ppc_hash64_start_access(cpu, ptex);
         if (ppc_hash64_load_hpte0(cpu, token, 0) & HPTE64_V_VALID) {
             ppc_hash64_stop_access(cpu, token);
             return H_PTEG_FULL;
@@ -142,10 +142,9 @@ static target_ulong h_enter(PowerPCCPU *cpu, sPAPRMachineState *spapr,
         ppc_hash64_stop_access(cpu, token);
     }
 
-    ppc_hash64_store_hpte(cpu, pte_index + index,
-                          pteh | HPTE64_V_HPTE_DIRTY, ptel);
+    ppc_hash64_store_hpte(cpu, ptex + slot, pteh | HPTE64_V_HPTE_DIRTY, ptel);
 
-    args[0] = pte_index + index;
+    args[0] = ptex + slot;
     return H_SUCCESS;
 }
 
@@ -161,11 +160,10 @@ static RemoveResult remove_hpte(PowerPCCPU *cpu, target_ulong ptex,
                                 target_ulong flags,
                                 target_ulong *vp, target_ulong *rp)
 {
-    CPUPPCState *env = &cpu->env;
     uint64_t token;
     target_ulong v, r;
 
-    if (!valid_pte_index(env, ptex)) {
+    if (!valid_ptex(cpu, ptex)) {
         return REMOVE_PARM;
     }
 
@@ -191,11 +189,11 @@ static target_ulong h_remove(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 {
     CPUPPCState *env = &cpu->env;
     target_ulong flags = args[0];
-    target_ulong pte_index = args[1];
+    target_ulong ptex = args[1];
     target_ulong avpn = args[2];
     RemoveResult ret;
 
-    ret = remove_hpte(cpu, pte_index, avpn, flags,
+    ret = remove_hpte(cpu, ptex, avpn, flags,
                       &args[0], &args[1]);
 
     switch (ret) {
@@ -291,16 +289,16 @@ static target_ulong h_protect(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 {
     CPUPPCState *env = &cpu->env;
     target_ulong flags = args[0];
-    target_ulong pte_index = args[1];
+    target_ulong ptex = args[1];
     target_ulong avpn = args[2];
     uint64_t token;
     target_ulong v, r;
 
-    if (!valid_pte_index(env, pte_index)) {
+    if (!valid_ptex(cpu, ptex)) {
         return H_PARAMETER;
     }
 
-    token = ppc_hash64_start_access(cpu, pte_index);
+    token = ppc_hash64_start_access(cpu, ptex);
     v = ppc_hash64_load_hpte0(cpu, token, 0);
     r = ppc_hash64_load_hpte1(cpu, token, 0);
     ppc_hash64_stop_access(cpu, token);
@@ -315,13 +313,13 @@ static target_ulong h_protect(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     r |= (flags << 55) & HPTE64_R_PP0;
     r |= (flags << 48) & HPTE64_R_KEY_HI;
     r |= flags & (HPTE64_R_PP | HPTE64_R_N | HPTE64_R_KEY_LO);
-    ppc_hash64_store_hpte(cpu, pte_index,
+    ppc_hash64_store_hpte(cpu, ptex,
                           (v & ~HPTE64_V_VALID) | HPTE64_V_HPTE_DIRTY, 0);
-    ppc_hash64_tlb_flush_hpte(cpu, pte_index, v, r);
+    ppc_hash64_tlb_flush_hpte(cpu, ptex, v, r);
     /* Flush the tlb */
     check_tlb_flush(env, true);
     /* Don't need a memory barrier, due to qemu's global lock */
-    ppc_hash64_store_hpte(cpu, pte_index, v | HPTE64_V_HPTE_DIRTY, r);
+    ppc_hash64_store_hpte(cpu, ptex, v | HPTE64_V_HPTE_DIRTY, r);
     return H_SUCCESS;
 }
 
@@ -330,21 +328,21 @@ static target_ulong h_read(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 {
     CPUPPCState *env = &cpu->env;
     target_ulong flags = args[0];
-    target_ulong pte_index = args[1];
+    target_ulong ptex = args[1];
     uint8_t *hpte;
     int i, ridx, n_entries = 1;
 
-    if (!valid_pte_index(env, pte_index)) {
+    if (!valid_ptex(cpu, ptex)) {
         return H_PARAMETER;
     }
 
     if (flags & H_READ_4) {
         /* Clear the two low order bits */
-        pte_index &= ~(3ULL);
+        ptex &= ~(3ULL);
         n_entries = 4;
     }
 
-    hpte = env->external_htab + (pte_index * HASH_PTE_SIZE_64);
+    hpte = env->external_htab + (ptex * HASH_PTE_SIZE_64);
 
     for (i = 0, ridx = 0; i < n_entries; i++) {
         args[ridx++] = ldq_p(hpte);
-- 
2.9.3
