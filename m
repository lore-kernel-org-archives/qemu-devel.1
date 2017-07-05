Received: from eggs.gnu.org ([2001:4830:134:3::10]:46967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeXF-00059N-8E
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeXC-00080d-Nm
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:41 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeXC-000803-C9
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:38 -0400
Received: by mail-wm0-x22f.google.com with SMTP id f67so102829050wmh.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:38 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	y35sm22202793wrc.51.2017.07.05.00.15.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jul 2017 00:15:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:43 +0200
Message-Id: <1499238885-26161-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 40/42] target/i386: move TLB refill function out
 of helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This function calls tlb_set_page_with_attrs, which is not available
when TCG is disabled.  Move it to excp_helper.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/excp_helper.c | 343 +++++++++++++++++++++++++++++++++++++++++++++
 target/i386/helper.c      | 344 +---------------------------------------------
 2 files changed, 344 insertions(+), 343 deletions(-)

diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index b769772..cef4449 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -136,3 +136,346 @@ void raise_exception_ra(CPUX86State *env, int exception_index, uintptr_t retaddr
 {
     raise_interrupt2(env, exception_index, 0, 0, 0, retaddr);
 }
+
+#if defined(CONFIG_USER_ONLY)
+int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
+                             int is_write, int mmu_idx)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    /* user mode only emulation */
+    is_write &= 1;
+    env->cr[2] = addr;
+    env->error_code = (is_write << PG_ERROR_W_BIT);
+    env->error_code |= PG_ERROR_U_MASK;
+    cs->exception_index = EXCP0E_PAGE;
+    env->exception_is_int = 0;
+    env->exception_next_eip = -1;
+    return 1;
+}
+
+#else
+
+/* return value:
+ * -1 = cannot handle fault
+ * 0  = nothing more to do
+ * 1  = generate PF fault
+ */
+int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
+                             int is_write1, int mmu_idx)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    uint64_t ptep, pte;
+    int32_t a20_mask;
+    target_ulong pde_addr, pte_addr;
+    int error_code = 0;
+    int is_dirty, prot, page_size, is_write, is_user;
+    hwaddr paddr;
+    uint64_t rsvd_mask = PG_HI_RSVD_MASK;
+    uint32_t page_offset;
+    target_ulong vaddr;
+
+    is_user = mmu_idx == MMU_USER_IDX;
+#if defined(DEBUG_MMU)
+    printf("MMU fault: addr=%" VADDR_PRIx " w=%d u=%d eip=" TARGET_FMT_lx "\n",
+           addr, is_write1, is_user, env->eip);
+#endif
+    is_write = is_write1 & 1;
+
+    a20_mask = x86_get_a20_mask(env);
+    if (!(env->cr[0] & CR0_PG_MASK)) {
+        pte = addr;
+#ifdef TARGET_X86_64
+        if (!(env->hflags & HF_LMA_MASK)) {
+            /* Without long mode we can only address 32bits in real mode */
+            pte = (uint32_t)pte;
+        }
+#endif
+        prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        page_size = 4096;
+        goto do_mapping;
+    }
+
+    if (!(env->efer & MSR_EFER_NXE)) {
+        rsvd_mask |= PG_NX_MASK;
+    }
+
+    if (env->cr[4] & CR4_PAE_MASK) {
+        uint64_t pde, pdpe;
+        target_ulong pdpe_addr;
+
+#ifdef TARGET_X86_64
+        if (env->hflags & HF_LMA_MASK) {
+            bool la57 = env->cr[4] & CR4_LA57_MASK;
+            uint64_t pml5e_addr, pml5e;
+            uint64_t pml4e_addr, pml4e;
+            int32_t sext;
+
+            /* test virtual address sign extension */
+            sext = la57 ? (int64_t)addr >> 56 : (int64_t)addr >> 47;
+            if (sext != 0 && sext != -1) {
+                env->error_code = 0;
+                cs->exception_index = EXCP0D_GPF;
+                return 1;
+            }
+
+            if (la57) {
+                pml5e_addr = ((env->cr[3] & ~0xfff) +
+                        (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
+                pml5e = x86_ldq_phys(cs, pml5e_addr);
+                if (!(pml5e & PG_PRESENT_MASK)) {
+                    goto do_fault;
+                }
+                if (pml5e & (rsvd_mask | PG_PSE_MASK)) {
+                    goto do_fault_rsvd;
+                }
+                if (!(pml5e & PG_ACCESSED_MASK)) {
+                    pml5e |= PG_ACCESSED_MASK;
+                    x86_stl_phys_notdirty(cs, pml5e_addr, pml5e);
+                }
+                ptep = pml5e ^ PG_NX_MASK;
+            } else {
+                pml5e = env->cr[3];
+                ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
+            }
+
+            pml4e_addr = ((pml5e & PG_ADDRESS_MASK) +
+                    (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
+            pml4e = x86_ldq_phys(cs, pml4e_addr);
+            if (!(pml4e & PG_PRESENT_MASK)) {
+                goto do_fault;
+            }
+            if (pml4e & (rsvd_mask | PG_PSE_MASK)) {
+                goto do_fault_rsvd;
+            }
+            if (!(pml4e & PG_ACCESSED_MASK)) {
+                pml4e |= PG_ACCESSED_MASK;
+                x86_stl_phys_notdirty(cs, pml4e_addr, pml4e);
+            }
+            ptep &= pml4e ^ PG_NX_MASK;
+            pdpe_addr = ((pml4e & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3)) &
+                a20_mask;
+            pdpe = x86_ldq_phys(cs, pdpe_addr);
+            if (!(pdpe & PG_PRESENT_MASK)) {
+                goto do_fault;
+            }
+            if (pdpe & rsvd_mask) {
+                goto do_fault_rsvd;
+            }
+            ptep &= pdpe ^ PG_NX_MASK;
+            if (!(pdpe & PG_ACCESSED_MASK)) {
+                pdpe |= PG_ACCESSED_MASK;
+                x86_stl_phys_notdirty(cs, pdpe_addr, pdpe);
+            }
+            if (pdpe & PG_PSE_MASK) {
+                /* 1 GB page */
+                page_size = 1024 * 1024 * 1024;
+                pte_addr = pdpe_addr;
+                pte = pdpe;
+                goto do_check_protect;
+            }
+        } else
+#endif
+        {
+            /* XXX: load them when cr3 is loaded ? */
+            pdpe_addr = ((env->cr[3] & ~0x1f) + ((addr >> 27) & 0x18)) &
+                a20_mask;
+            pdpe = x86_ldq_phys(cs, pdpe_addr);
+            if (!(pdpe & PG_PRESENT_MASK)) {
+                goto do_fault;
+            }
+            rsvd_mask |= PG_HI_USER_MASK;
+            if (pdpe & (rsvd_mask | PG_NX_MASK)) {
+                goto do_fault_rsvd;
+            }
+            ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
+        }
+
+        pde_addr = ((pdpe & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3)) &
+            a20_mask;
+        pde = x86_ldq_phys(cs, pde_addr);
+        if (!(pde & PG_PRESENT_MASK)) {
+            goto do_fault;
+        }
+        if (pde & rsvd_mask) {
+            goto do_fault_rsvd;
+        }
+        ptep &= pde ^ PG_NX_MASK;
+        if (pde & PG_PSE_MASK) {
+            /* 2 MB page */
+            page_size = 2048 * 1024;
+            pte_addr = pde_addr;
+            pte = pde;
+            goto do_check_protect;
+        }
+        /* 4 KB page */
+        if (!(pde & PG_ACCESSED_MASK)) {
+            pde |= PG_ACCESSED_MASK;
+            x86_stl_phys_notdirty(cs, pde_addr, pde);
+        }
+        pte_addr = ((pde & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3)) &
+            a20_mask;
+        pte = x86_ldq_phys(cs, pte_addr);
+        if (!(pte & PG_PRESENT_MASK)) {
+            goto do_fault;
+        }
+        if (pte & rsvd_mask) {
+            goto do_fault_rsvd;
+        }
+        /* combine pde and pte nx, user and rw protections */
+        ptep &= pte ^ PG_NX_MASK;
+        page_size = 4096;
+    } else {
+        uint32_t pde;
+
+        /* page directory entry */
+        pde_addr = ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) &
+            a20_mask;
+        pde = x86_ldl_phys(cs, pde_addr);
+        if (!(pde & PG_PRESENT_MASK)) {
+            goto do_fault;
+        }
+        ptep = pde | PG_NX_MASK;
+
+        /* if PSE bit is set, then we use a 4MB page */
+        if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
+            page_size = 4096 * 1024;
+            pte_addr = pde_addr;
+
+            /* Bits 20-13 provide bits 39-32 of the address, bit 21 is reserved.
+             * Leave bits 20-13 in place for setting accessed/dirty bits below.
+             */
+            pte = pde | ((pde & 0x1fe000LL) << (32 - 13));
+            rsvd_mask = 0x200000;
+            goto do_check_protect_pse36;
+        }
+
+        if (!(pde & PG_ACCESSED_MASK)) {
+            pde |= PG_ACCESSED_MASK;
+            x86_stl_phys_notdirty(cs, pde_addr, pde);
+        }
+
+        /* page directory entry */
+        pte_addr = ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) &
+            a20_mask;
+        pte = x86_ldl_phys(cs, pte_addr);
+        if (!(pte & PG_PRESENT_MASK)) {
+            goto do_fault;
+        }
+        /* combine pde and pte user and rw protections */
+        ptep &= pte | PG_NX_MASK;
+        page_size = 4096;
+        rsvd_mask = 0;
+    }
+
+do_check_protect:
+    rsvd_mask |= (page_size - 1) & PG_ADDRESS_MASK & ~PG_PSE_PAT_MASK;
+do_check_protect_pse36:
+    if (pte & rsvd_mask) {
+        goto do_fault_rsvd;
+    }
+    ptep ^= PG_NX_MASK;
+
+    /* can the page can be put in the TLB?  prot will tell us */
+    if (is_user && !(ptep & PG_USER_MASK)) {
+        goto do_fault_protect;
+    }
+
+    prot = 0;
+    if (mmu_idx != MMU_KSMAP_IDX || !(ptep & PG_USER_MASK)) {
+        prot |= PAGE_READ;
+        if ((ptep & PG_RW_MASK) || (!is_user && !(env->cr[0] & CR0_WP_MASK))) {
+            prot |= PAGE_WRITE;
+        }
+    }
+    if (!(ptep & PG_NX_MASK) &&
+        (mmu_idx == MMU_USER_IDX ||
+         !((env->cr[4] & CR4_SMEP_MASK) && (ptep & PG_USER_MASK)))) {
+        prot |= PAGE_EXEC;
+    }
+    if ((env->cr[4] & CR4_PKE_MASK) && (env->hflags & HF_LMA_MASK) &&
+        (ptep & PG_USER_MASK) && env->pkru) {
+        uint32_t pk = (pte & PG_PKRU_MASK) >> PG_PKRU_BIT;
+        uint32_t pkru_ad = (env->pkru >> pk * 2) & 1;
+        uint32_t pkru_wd = (env->pkru >> pk * 2) & 2;
+        uint32_t pkru_prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+
+        if (pkru_ad) {
+            pkru_prot &= ~(PAGE_READ | PAGE_WRITE);
+        } else if (pkru_wd && (is_user || env->cr[0] & CR0_WP_MASK)) {
+            pkru_prot &= ~PAGE_WRITE;
+        }
+
+        prot &= pkru_prot;
+        if ((pkru_prot & (1 << is_write1)) == 0) {
+            assert(is_write1 != 2);
+            error_code |= PG_ERROR_PK_MASK;
+            goto do_fault_protect;
+        }
+    }
+
+    if ((prot & (1 << is_write1)) == 0) {
+        goto do_fault_protect;
+    }
+
+    /* yes, it can! */
+    is_dirty = is_write && !(pte & PG_DIRTY_MASK);
+    if (!(pte & PG_ACCESSED_MASK) || is_dirty) {
+        pte |= PG_ACCESSED_MASK;
+        if (is_dirty) {
+            pte |= PG_DIRTY_MASK;
+        }
+        x86_stl_phys_notdirty(cs, pte_addr, pte);
+    }
+
+    if (!(pte & PG_DIRTY_MASK)) {
+        /* only set write access if already dirty... otherwise wait
+           for dirty access */
+        assert(!is_write);
+        prot &= ~PAGE_WRITE;
+    }
+
+ do_mapping:
+    pte = pte & a20_mask;
+
+    /* align to page_size */
+    pte &= PG_ADDRESS_MASK & ~(page_size - 1);
+
+    /* Even if 4MB pages, we map only one 4KB page in the cache to
+       avoid filling it too fast */
+    vaddr = addr & TARGET_PAGE_MASK;
+    page_offset = vaddr & (page_size - 1);
+    paddr = pte + page_offset;
+
+    assert(prot & (1 << is_write1));
+    tlb_set_page_with_attrs(cs, vaddr, paddr, cpu_get_mem_attrs(env),
+                            prot, mmu_idx, page_size);
+    return 0;
+ do_fault_rsvd:
+    error_code |= PG_ERROR_RSVD_MASK;
+ do_fault_protect:
+    error_code |= PG_ERROR_P_MASK;
+ do_fault:
+    error_code |= (is_write << PG_ERROR_W_BIT);
+    if (is_user)
+        error_code |= PG_ERROR_U_MASK;
+    if (is_write1 == 2 &&
+        (((env->efer & MSR_EFER_NXE) &&
+          (env->cr[4] & CR4_PAE_MASK)) ||
+         (env->cr[4] & CR4_SMEP_MASK)))
+        error_code |= PG_ERROR_I_D_MASK;
+    if (env->intercept_exceptions & (1 << EXCP0E_PAGE)) {
+        /* cr2 is not modified in case of exceptions */
+        x86_stq_phys(cs,
+                 env->vm_vmcb + offsetof(struct vmcb, control.exit_info_2),
+                 addr);
+    } else {
+        env->cr[2] = addr;
+    }
+    env->error_code = error_code;
+    cs->exception_index = EXCP0E_PAGE;
+    return 1;
+}
+#endif
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 4d584b5..bcf9b22 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -722,349 +722,7 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
     cpu_sync_bndcs_hflags(env);
 }
 
-#if defined(CONFIG_USER_ONLY)
-
-int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
-                             int is_write, int mmu_idx)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-
-    /* user mode only emulation */
-    is_write &= 1;
-    env->cr[2] = addr;
-    env->error_code = (is_write << PG_ERROR_W_BIT);
-    env->error_code |= PG_ERROR_U_MASK;
-    cs->exception_index = EXCP0E_PAGE;
-    env->exception_is_int = 0;
-    env->exception_next_eip = -1;
-    return 1;
-}
-
-#else
-
-/* return value:
- * -1 = cannot handle fault
- * 0  = nothing more to do
- * 1  = generate PF fault
- */
-int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
-                             int is_write1, int mmu_idx)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-    uint64_t ptep, pte;
-    int32_t a20_mask;
-    target_ulong pde_addr, pte_addr;
-    int error_code = 0;
-    int is_dirty, prot, page_size, is_write, is_user;
-    hwaddr paddr;
-    uint64_t rsvd_mask = PG_HI_RSVD_MASK;
-    uint32_t page_offset;
-    target_ulong vaddr;
-
-    is_user = mmu_idx == MMU_USER_IDX;
-#if defined(DEBUG_MMU)
-    printf("MMU fault: addr=%" VADDR_PRIx " w=%d u=%d eip=" TARGET_FMT_lx "\n",
-           addr, is_write1, is_user, env->eip);
-#endif
-    is_write = is_write1 & 1;
-
-    a20_mask = x86_get_a20_mask(env);
-    if (!(env->cr[0] & CR0_PG_MASK)) {
-        pte = addr;
-#ifdef TARGET_X86_64
-        if (!(env->hflags & HF_LMA_MASK)) {
-            /* Without long mode we can only address 32bits in real mode */
-            pte = (uint32_t)pte;
-        }
-#endif
-        prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        page_size = 4096;
-        goto do_mapping;
-    }
-
-    if (!(env->efer & MSR_EFER_NXE)) {
-        rsvd_mask |= PG_NX_MASK;
-    }
-
-    if (env->cr[4] & CR4_PAE_MASK) {
-        uint64_t pde, pdpe;
-        target_ulong pdpe_addr;
-
-#ifdef TARGET_X86_64
-        if (env->hflags & HF_LMA_MASK) {
-            bool la57 = env->cr[4] & CR4_LA57_MASK;
-            uint64_t pml5e_addr, pml5e;
-            uint64_t pml4e_addr, pml4e;
-            int32_t sext;
-
-            /* test virtual address sign extension */
-            sext = la57 ? (int64_t)addr >> 56 : (int64_t)addr >> 47;
-            if (sext != 0 && sext != -1) {
-                env->error_code = 0;
-                cs->exception_index = EXCP0D_GPF;
-                return 1;
-            }
-
-            if (la57) {
-                pml5e_addr = ((env->cr[3] & ~0xfff) +
-                        (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
-                pml5e = x86_ldq_phys(cs, pml5e_addr);
-                if (!(pml5e & PG_PRESENT_MASK)) {
-                    goto do_fault;
-                }
-                if (pml5e & (rsvd_mask | PG_PSE_MASK)) {
-                    goto do_fault_rsvd;
-                }
-                if (!(pml5e & PG_ACCESSED_MASK)) {
-                    pml5e |= PG_ACCESSED_MASK;
-                    x86_stl_phys_notdirty(cs, pml5e_addr, pml5e);
-                }
-                ptep = pml5e ^ PG_NX_MASK;
-            } else {
-                pml5e = env->cr[3];
-                ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
-            }
-
-            pml4e_addr = ((pml5e & PG_ADDRESS_MASK) +
-                    (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
-            pml4e = x86_ldq_phys(cs, pml4e_addr);
-            if (!(pml4e & PG_PRESENT_MASK)) {
-                goto do_fault;
-            }
-            if (pml4e & (rsvd_mask | PG_PSE_MASK)) {
-                goto do_fault_rsvd;
-            }
-            if (!(pml4e & PG_ACCESSED_MASK)) {
-                pml4e |= PG_ACCESSED_MASK;
-                x86_stl_phys_notdirty(cs, pml4e_addr, pml4e);
-            }
-            ptep &= pml4e ^ PG_NX_MASK;
-            pdpe_addr = ((pml4e & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3)) &
-                a20_mask;
-            pdpe = x86_ldq_phys(cs, pdpe_addr);
-            if (!(pdpe & PG_PRESENT_MASK)) {
-                goto do_fault;
-            }
-            if (pdpe & rsvd_mask) {
-                goto do_fault_rsvd;
-            }
-            ptep &= pdpe ^ PG_NX_MASK;
-            if (!(pdpe & PG_ACCESSED_MASK)) {
-                pdpe |= PG_ACCESSED_MASK;
-                x86_stl_phys_notdirty(cs, pdpe_addr, pdpe);
-            }
-            if (pdpe & PG_PSE_MASK) {
-                /* 1 GB page */
-                page_size = 1024 * 1024 * 1024;
-                pte_addr = pdpe_addr;
-                pte = pdpe;
-                goto do_check_protect;
-            }
-        } else
-#endif
-        {
-            /* XXX: load them when cr3 is loaded ? */
-            pdpe_addr = ((env->cr[3] & ~0x1f) + ((addr >> 27) & 0x18)) &
-                a20_mask;
-            pdpe = x86_ldq_phys(cs, pdpe_addr);
-            if (!(pdpe & PG_PRESENT_MASK)) {
-                goto do_fault;
-            }
-            rsvd_mask |= PG_HI_USER_MASK;
-            if (pdpe & (rsvd_mask | PG_NX_MASK)) {
-                goto do_fault_rsvd;
-            }
-            ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
-        }
-
-        pde_addr = ((pdpe & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3)) &
-            a20_mask;
-        pde = x86_ldq_phys(cs, pde_addr);
-        if (!(pde & PG_PRESENT_MASK)) {
-            goto do_fault;
-        }
-        if (pde & rsvd_mask) {
-            goto do_fault_rsvd;
-        }
-        ptep &= pde ^ PG_NX_MASK;
-        if (pde & PG_PSE_MASK) {
-            /* 2 MB page */
-            page_size = 2048 * 1024;
-            pte_addr = pde_addr;
-            pte = pde;
-            goto do_check_protect;
-        }
-        /* 4 KB page */
-        if (!(pde & PG_ACCESSED_MASK)) {
-            pde |= PG_ACCESSED_MASK;
-            x86_stl_phys_notdirty(cs, pde_addr, pde);
-        }
-        pte_addr = ((pde & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3)) &
-            a20_mask;
-        pte = x86_ldq_phys(cs, pte_addr);
-        if (!(pte & PG_PRESENT_MASK)) {
-            goto do_fault;
-        }
-        if (pte & rsvd_mask) {
-            goto do_fault_rsvd;
-        }
-        /* combine pde and pte nx, user and rw protections */
-        ptep &= pte ^ PG_NX_MASK;
-        page_size = 4096;
-    } else {
-        uint32_t pde;
-
-        /* page directory entry */
-        pde_addr = ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) &
-            a20_mask;
-        pde = x86_ldl_phys(cs, pde_addr);
-        if (!(pde & PG_PRESENT_MASK)) {
-            goto do_fault;
-        }
-        ptep = pde | PG_NX_MASK;
-
-        /* if PSE bit is set, then we use a 4MB page */
-        if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
-            page_size = 4096 * 1024;
-            pte_addr = pde_addr;
-
-            /* Bits 20-13 provide bits 39-32 of the address, bit 21 is reserved.
-             * Leave bits 20-13 in place for setting accessed/dirty bits below.
-             */
-            pte = pde | ((pde & 0x1fe000LL) << (32 - 13));
-            rsvd_mask = 0x200000;
-            goto do_check_protect_pse36;
-        }
-
-        if (!(pde & PG_ACCESSED_MASK)) {
-            pde |= PG_ACCESSED_MASK;
-            x86_stl_phys_notdirty(cs, pde_addr, pde);
-        }
-
-        /* page directory entry */
-        pte_addr = ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) &
-            a20_mask;
-        pte = x86_ldl_phys(cs, pte_addr);
-        if (!(pte & PG_PRESENT_MASK)) {
-            goto do_fault;
-        }
-        /* combine pde and pte user and rw protections */
-        ptep &= pte | PG_NX_MASK;
-        page_size = 4096;
-        rsvd_mask = 0;
-    }
-
-do_check_protect:
-    rsvd_mask |= (page_size - 1) & PG_ADDRESS_MASK & ~PG_PSE_PAT_MASK;
-do_check_protect_pse36:
-    if (pte & rsvd_mask) {
-        goto do_fault_rsvd;
-    }
-    ptep ^= PG_NX_MASK;
-
-    /* can the page can be put in the TLB?  prot will tell us */
-    if (is_user && !(ptep & PG_USER_MASK)) {
-        goto do_fault_protect;
-    }
-
-    prot = 0;
-    if (mmu_idx != MMU_KSMAP_IDX || !(ptep & PG_USER_MASK)) {
-        prot |= PAGE_READ;
-        if ((ptep & PG_RW_MASK) || (!is_user && !(env->cr[0] & CR0_WP_MASK))) {
-            prot |= PAGE_WRITE;
-        }
-    }
-    if (!(ptep & PG_NX_MASK) &&
-        (mmu_idx == MMU_USER_IDX ||
-         !((env->cr[4] & CR4_SMEP_MASK) && (ptep & PG_USER_MASK)))) {
-        prot |= PAGE_EXEC;
-    }
-    if ((env->cr[4] & CR4_PKE_MASK) && (env->hflags & HF_LMA_MASK) &&
-        (ptep & PG_USER_MASK) && env->pkru) {
-        uint32_t pk = (pte & PG_PKRU_MASK) >> PG_PKRU_BIT;
-        uint32_t pkru_ad = (env->pkru >> pk * 2) & 1;
-        uint32_t pkru_wd = (env->pkru >> pk * 2) & 2;
-        uint32_t pkru_prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-
-        if (pkru_ad) {
-            pkru_prot &= ~(PAGE_READ | PAGE_WRITE);
-        } else if (pkru_wd && (is_user || env->cr[0] & CR0_WP_MASK)) {
-            pkru_prot &= ~PAGE_WRITE;
-        }
-
-        prot &= pkru_prot;
-        if ((pkru_prot & (1 << is_write1)) == 0) {
-            assert(is_write1 != 2);
-            error_code |= PG_ERROR_PK_MASK;
-            goto do_fault_protect;
-        }
-    }
-
-    if ((prot & (1 << is_write1)) == 0) {
-        goto do_fault_protect;
-    }
-
-    /* yes, it can! */
-    is_dirty = is_write && !(pte & PG_DIRTY_MASK);
-    if (!(pte & PG_ACCESSED_MASK) || is_dirty) {
-        pte |= PG_ACCESSED_MASK;
-        if (is_dirty) {
-            pte |= PG_DIRTY_MASK;
-        }
-        x86_stl_phys_notdirty(cs, pte_addr, pte);
-    }
-
-    if (!(pte & PG_DIRTY_MASK)) {
-        /* only set write access if already dirty... otherwise wait
-           for dirty access */
-        assert(!is_write);
-        prot &= ~PAGE_WRITE;
-    }
-
- do_mapping:
-    pte = pte & a20_mask;
-
-    /* align to page_size */
-    pte &= PG_ADDRESS_MASK & ~(page_size - 1);
-
-    /* Even if 4MB pages, we map only one 4KB page in the cache to
-       avoid filling it too fast */
-    vaddr = addr & TARGET_PAGE_MASK;
-    page_offset = vaddr & (page_size - 1);
-    paddr = pte + page_offset;
-
-    assert(prot & (1 << is_write1));
-    tlb_set_page_with_attrs(cs, vaddr, paddr, cpu_get_mem_attrs(env),
-                            prot, mmu_idx, page_size);
-    return 0;
- do_fault_rsvd:
-    error_code |= PG_ERROR_RSVD_MASK;
- do_fault_protect:
-    error_code |= PG_ERROR_P_MASK;
- do_fault:
-    error_code |= (is_write << PG_ERROR_W_BIT);
-    if (is_user)
-        error_code |= PG_ERROR_U_MASK;
-    if (is_write1 == 2 &&
-        (((env->efer & MSR_EFER_NXE) &&
-          (env->cr[4] & CR4_PAE_MASK)) ||
-         (env->cr[4] & CR4_SMEP_MASK)))
-        error_code |= PG_ERROR_I_D_MASK;
-    if (env->intercept_exceptions & (1 << EXCP0E_PAGE)) {
-        /* cr2 is not modified in case of exceptions */
-        x86_stq_phys(cs,
-                 env->vm_vmcb + offsetof(struct vmcb, control.exit_info_2),
-                 addr);
-    } else {
-        env->cr[2] = addr;
-    }
-    env->error_code = error_code;
-    cs->exception_index = EXCP0E_PAGE;
-    return 1;
-}
-
+#if !defined(CONFIG_USER_ONLY)
 hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     X86CPU *cpu = X86_CPU(cs);
-- 
1.8.3.1
