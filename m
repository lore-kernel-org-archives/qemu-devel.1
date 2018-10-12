Received: from eggs.gnu.org ([2001:4830:134:3::10]:54903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0XR-00012w-3R
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0XP-00051g-G6
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:43:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46751 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gB0XP-00050D-3E
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:43:43 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 12 Oct 2018 18:39:21 +0200
Message-Id: <1539362376-12010-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 13/28] target/mips: Implement hardware page
 table walker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Yongbok Kim <yongbok.kim@mips.com>

Implement hardware page table walker.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/helper.c    | 369 +++++++++++++++++++++++++++++++++++++++++++++++-
 target/mips/internal.h  |   1 +
 target/mips/op_helper.c |   7 +-
 3 files changed, 374 insertions(+), 3 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index f0c268b..2b166cc 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -537,6 +537,346 @@ hwaddr mips_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 }
 #endif
 
+#if !defined(CONFIG_USER_ONLY)
+#if !defined(TARGET_MIPS64)
+
+/* Perform hardware page table walk
+*
+* Memory accesses are performed using the KERNEL privilege level.
+* Synchronous exceptions detected on memory accesses cause a silent exit
+* from page table walking, resulting in a TLB or XTLB Refill exception.
+*
+* Implementations are not required to support page table walk memory
+* accesses from mapped memory regions. When an unsupported access is
+* attempted, a silent exit is taken, resulting in a TLB or XTLB Refill
+* exception.
+*
+* Note that if an exception is caused by AddressTranslation or LoadMemory
+* functions, the exception is not taken, a silent exit is taken,
+* resulting in a TLB or XTLB Refill exception.
+*/
+
+static bool get_pte(CPUMIPSState *env, uint64_t vaddr, int entry_size,
+        uint64_t *pte)
+{
+    if ((vaddr & ((entry_size >> 3) - 1)) != 0) {
+        return false;
+    }
+    if (entry_size == 64) {
+        *pte = cpu_ldq_code(env, vaddr);
+    } else {
+        *pte = cpu_ldl_code(env, vaddr);
+    }
+    return true;
+}
+
+static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
+        int entry_size, int ptei)
+{
+    uint64_t result = entry;
+    uint64_t rixi;
+    if (ptei > entry_size) {
+        ptei -= 32;
+    }
+    result >>= (ptei - 2);
+    rixi = result & 3;
+    result >>= 2;
+    result |= rixi << CP0EnLo_XI;
+    return result;
+}
+
+static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
+        int directory_index, bool *huge_page, bool *hgpg_directory_hit,
+        uint64_t *pw_entrylo0, uint64_t *pw_entrylo1)
+{
+    int dph = (env->CP0_PWCtl >> CP0PC_DPH) & 0x1;
+    int psn = (env->CP0_PWCtl >> CP0PC_PSN) & 0x3F;
+    int hugepg = (env->CP0_PWCtl >> CP0PC_HUGEPG) & 0x1;
+    int ptei = (env->CP0_PWField >> CP0PF_PTEI) & 0x3F;
+    int ptew = (env->CP0_PWSize >> CP0PS_PTEW) & 0x3F;
+    int native_shift = (((env->CP0_PWSize >> CP0PS_PS) & 1) == 0) ? 2 : 3;
+    int directory_shift = (ptew > 1) ? -1 :
+            (hugepg && (ptew == 1)) ? native_shift + 1 : native_shift;
+    int leaf_shift = (ptew > 1) ? -1 :
+            (ptew == 1) ? native_shift + 1 : native_shift;
+    uint32_t direntry_size = 1 << (directory_shift + 3);
+    uint32_t leafentry_size = 1 << (leaf_shift + 3);
+
+    uint64_t entry;
+    uint64_t paddr;
+    int prot;
+    uint64_t lsb = 0;
+    uint64_t w = 0;
+
+    if (get_physical_address(env, &paddr, &prot, *vaddr, MMU_DATA_LOAD,
+                             ACCESS_INT, cpu_mmu_index(env, false))
+   != TLBRET_MATCH) {
+        /* wrong base address */
+        return 0;
+    }
+    if (!get_pte(env, *vaddr, direntry_size, &entry)) {
+        return 0;
+    }
+
+    if ((entry & (1 << psn)) && hugepg) {
+        *huge_page = true;
+        *hgpg_directory_hit = true;
+        entry = get_tlb_entry_layout(env, entry, leafentry_size,
+                ptei);
+        w = directory_index - 1;
+        if (directory_index & 0x1) {
+            /* generate adjacent page from same PTE for odd TLB page */
+            lsb = (1 << w) >> 6;
+            *pw_entrylo0 = entry & ~lsb; /* even page */
+            *pw_entrylo1 = entry | lsb; /* odd page */
+        } else if (dph) {
+            int oddpagebit = 1 << leaf_shift;
+            uint64_t vaddr2 = *vaddr ^ oddpagebit;
+            if (*vaddr & oddpagebit) {
+                *pw_entrylo1 = entry;
+            } else {
+                *pw_entrylo0 = entry;
+            }
+            if (get_physical_address(env, &paddr, &prot, vaddr2,
+                    MMU_DATA_LOAD, ACCESS_INT,
+                                     cpu_mmu_index(env, false))
+                != TLBRET_MATCH) {
+                return 0;
+            }
+            if (!get_pte(env, vaddr2, leafentry_size, &entry)) {
+                return 0;
+            }
+            entry = get_tlb_entry_layout(env, entry,
+                    leafentry_size, ptei);
+            if (*vaddr & oddpagebit) {
+                *pw_entrylo0 = entry;
+            } else {
+                *pw_entrylo1 = entry;
+            }
+        } else {
+            return 0;
+        }
+        return 1;
+    } else {
+        *vaddr = entry;
+        return 2;
+    }
+}
+
+static bool page_table_walk_refill(CPUMIPSState *env, vaddr address, int rw,
+        int mmu_idx)
+{
+    int gdw = (env->CP0_PWSize >> CP0PS_GDW) & 0x3f;
+    int udw = (env->CP0_PWSize >> CP0PS_UDW) & 0x3f;
+    int mdw = (env->CP0_PWSize >> CP0PS_MDW) & 0x3f;
+    int ptw = (env->CP0_PWSize >> CP0PS_PTW) & 0x3F;
+
+    /* Initial values */
+    bool huge_page = false;
+    bool hgpg_bdhit = false;
+    bool hgpg_gdhit = false;
+    bool hgpg_udhit = false;
+    bool hgpg_mdhit = false;
+
+    int32_t pw_pagemask = 0;
+    target_ulong pw_entryhi = 0;
+    uint64_t pw_entrylo0 = 0;
+    uint64_t pw_entrylo1 = 0;
+
+    /* Native pointer size */
+    /*For the 32-bit architectures, this bit is fixed to 0.*/
+    int native_shift = (((env->CP0_PWSize >> CP0PS_PS) & 1) == 0) ? 2 : 3;
+
+    /* Indices from PWField */
+    int gdi = (env->CP0_PWField >> CP0PF_GDI) & 0x3F;
+    int udi = (env->CP0_PWField >> CP0PF_UDI) & 0x3F;
+    int mdi = (env->CP0_PWField >> CP0PF_MDI) & 0x3F;
+    int pti = (env->CP0_PWField >> CP0PF_PTI) & 0x3F;
+    int ptei = (env->CP0_PWField >> CP0PF_PTEI) & 0x3F;
+    int ptew = (env->CP0_PWSize >> CP0PS_PTEW) & 0x3F;
+
+    /* Indices computed from faulting address */
+    int gindex = (address >> gdi) & ((1 << gdw) - 1);
+    int uindex = (address >> udi) & ((1 << udw) - 1);
+    int mindex = (address >> mdi) & ((1 << mdw) - 1);
+    int ptindex = (address >> pti) & ((1 << ptw) - 1);
+
+    /* Other HTW configs */
+    int hugepg = (env->CP0_PWCtl >> CP0PC_HUGEPG) & 0x1;
+
+    /* HTW Shift values (depend on entry size) */
+    int directory_shift = (ptew > 1) ? -1 :
+            (hugepg && (ptew == 1)) ? native_shift + 1 : native_shift;
+    int leaf_shift = (ptew > 1) ? -1 :
+            (ptew == 1) ? native_shift + 1 : native_shift;
+
+    /* Offsets into tables */
+    int goffset = gindex << directory_shift;
+    int uoffset = uindex << directory_shift;
+    int moffset = mindex << directory_shift;
+    int ptoffset0 = (ptindex >> 1) << (leaf_shift + 1);
+    int ptoffset1 = ptoffset0 | (1 << (leaf_shift));
+
+    uint32_t leafentry_size = 1 << (leaf_shift + 3);
+
+    /* Starting address - Page Table Base */
+    uint64_t vaddr = env->CP0_PWBase;
+
+    uint64_t dir_entry;
+    uint64_t paddr;
+    int prot;
+    int m;
+
+    if (!(env->CP0_Config3 & (1 << CP0C3_PW))) {
+        /* walker is unimplemented */
+        return false;
+    }
+    if (!(env->CP0_PWCtl & (1 << CP0PC_PWEN))) {
+        /* walker is disabled */
+        return false;
+    }
+    if (!(gdw > 0 || udw > 0 || mdw > 0)) {
+        /* no structure to walk */
+        return false;
+    }
+    if ((directory_shift == -1) || (leaf_shift == -1)) {
+        return false;
+    }
+
+    /* Global Directory */
+    if (gdw > 0) {
+        vaddr |= goffset;
+        switch (walk_directory(env, &vaddr,
+                gdi, &huge_page, &hgpg_gdhit,
+                &pw_entrylo0, &pw_entrylo1)) {
+        case 0:
+            return false;
+        case 1:
+            goto refill;
+        case 2:
+        default:
+            break;
+        }
+    }
+
+    /* Upper directory */
+    if (udw > 0) {
+        vaddr |= uoffset;
+        switch (walk_directory(env, &vaddr,
+                udi, &huge_page, &hgpg_udhit,
+                &pw_entrylo0, &pw_entrylo1)) {
+        case 0:
+            return false;
+        case 1:
+            goto refill;
+        case 2:
+        default:
+            break;
+        }
+    }
+
+    /* Middle directory */
+    if (mdw > 0) {
+        vaddr |= moffset;
+        switch (walk_directory(env, &vaddr,
+                mdi, &huge_page, &hgpg_mdhit,
+                &pw_entrylo0, &pw_entrylo1)) {
+        case 0:
+            return false;
+        case 1:
+            goto refill;
+        case 2:
+        default:
+            break;
+        }
+    }
+
+    /* Leaf Level Page Table - First half of PTE pair */
+    vaddr |= ptoffset0;
+    if (get_physical_address(env, &paddr, &prot, vaddr,
+                             MMU_DATA_LOAD, ACCESS_INT,
+                             cpu_mmu_index(env, false))
+   != TLBRET_MATCH) {
+        return false;
+    }
+    if (!get_pte(env, vaddr, leafentry_size, &dir_entry)) {
+        return false;
+    }
+    dir_entry = get_tlb_entry_layout(env, dir_entry, leafentry_size, ptei);
+    pw_entrylo0 = dir_entry;
+
+    /* Leaf Level Page Table - Second half of PTE pair */
+    vaddr |= ptoffset1;
+    if (get_physical_address(env, &paddr, &prot, vaddr,
+                             MMU_DATA_LOAD, ACCESS_INT,
+                             cpu_mmu_index(env, false)) != TLBRET_MATCH) {
+        return false;
+    }
+    if (!get_pte(env, vaddr, leafentry_size, &dir_entry)) {
+        return false;
+    }
+    dir_entry = get_tlb_entry_layout(env, dir_entry, leafentry_size, ptei);
+    pw_entrylo1 = dir_entry;
+
+refill:
+    m = (1 << pti) - 1;
+
+    if (huge_page) {
+        switch (hgpg_bdhit << 3 | hgpg_gdhit << 2 | hgpg_udhit << 1 |
+                hgpg_mdhit) {
+        case 4:
+            m = (1 << gdi) - 1;
+            if (gdi & 1) {
+                m >>= 1;
+            }
+            break;
+        case 2:
+            m = (1 << udi) - 1;
+            if (udi & 1) {
+                m >>= 1;
+            }
+            break;
+        case 1:
+            m = (1 << mdi) - 1;
+            if (mdi & 1) {
+                m >>= 1;
+            }
+            break;
+        }
+    }
+
+    pw_pagemask = m >> 12;
+    update_pagemask(env, pw_pagemask << 13, &pw_pagemask);
+    pw_entryhi = (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
+
+    {
+        target_ulong tmp_entryhi = env->CP0_EntryHi;
+        int32_t tmp_pagemask = env->CP0_PageMask;
+        uint64_t tmp_entrylo0 = env->CP0_EntryLo0;
+        uint64_t tmp_entrylo1 = env->CP0_EntryLo1;
+
+        env->CP0_EntryHi = pw_entryhi;
+        env->CP0_PageMask = pw_pagemask;
+        env->CP0_EntryLo0 = pw_entrylo0;
+        env->CP0_EntryLo1 = pw_entrylo1;
+
+        /*
+         * The hardware page walker inserts a page into the TLB in a manner
+         * identical to a TLBWR instruction as executed by the software refill
+         * handler.
+         */
+        r4k_helper_tlbwr(env);
+
+        env->CP0_EntryHi = tmp_entryhi;
+        env->CP0_PageMask = tmp_pagemask;
+        env->CP0_EntryLo0 = tmp_entrylo0;
+        env->CP0_EntryLo1 = tmp_entrylo1;
+    }
+    return true;
+}
+#endif
+#endif
+
 int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                               int mmu_idx)
 {
@@ -558,8 +898,7 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
 
     /* data access */
 #if !defined(CONFIG_USER_ONLY)
-    /* XXX: put correct access by using cpu_restore_state()
-       correctly */
+    /* XXX: put correct access by using cpu_restore_state() correctly */
     access_type = ACCESS_INT;
     ret = get_physical_address(env, &physical, &prot,
                                address, rw, access_type, mmu_idx);
@@ -583,6 +922,32 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     } else if (ret < 0)
 #endif
     {
+#if !defined(CONFIG_USER_ONLY)
+#if !defined(TARGET_MIPS64)
+        if ((ret == TLBRET_NOMATCH) && (env->tlb->nb_tlb > 1)) {
+            /*
+             * Memory reads during hardware page table walking are performed
+             * as if they were kernel-mode load instructions.
+             */
+            int mode = (env->hflags & MIPS_HFLAG_KSU);
+            bool ret_walker;
+            env->hflags &= ~MIPS_HFLAG_KSU;
+            ret_walker = page_table_walk_refill(env, address, rw, mmu_idx);
+            env->hflags |= mode;
+            if (ret_walker) {
+                ret = get_physical_address(env, &physical, &prot,
+                                           address, rw, access_type, mmu_idx);
+                if (ret == TLBRET_MATCH) {
+                    tlb_set_page(cs, address & TARGET_PAGE_MASK,
+                            physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
+                            mmu_idx, TARGET_PAGE_SIZE);
+                    ret = 0;
+                    return ret;
+                }
+            }
+        }
+#endif
+#endif
         raise_mmu_exception(env, address, rw, ret);
         ret = 1;
     }
diff --git a/target/mips/internal.h b/target/mips/internal.h
index e41051f..2898bfc 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -211,6 +211,7 @@ uint64_t float_class_d(uint64_t arg, float_status *fst);
 
 extern unsigned int ieee_rm[];
 int ieee_ex_to_mips(int xcpt);
+void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask);
 
 static inline void restore_rounding_mode(CPUMIPSState *env)
 {
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index e649bd0..af130f6 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1400,7 +1400,7 @@ void helper_mtc0_context(CPUMIPSState *env, target_ulong arg1)
     env->CP0_Context = (env->CP0_Context & 0x007FFFFF) | (arg1 & ~0x007FFFFF);
 }
 
-void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
+void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
 {
     uint64_t mask = arg1 >> (TARGET_PAGE_BITS + 1);
     if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 == ~0) ||
@@ -1411,6 +1411,11 @@ void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
+void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
+{
+    update_pagemask(env, arg1, &env->CP0_PageMask);
+}
+
 void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
 {
     /* SmartMIPS not implemented */
-- 
2.7.4
