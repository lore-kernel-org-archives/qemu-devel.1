Received: from eggs.gnu.org ([2001:4830:134:3::10]:37694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d8mNc-0001Z3-Pp
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d8mNY-0000cP-Mz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:35:36 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d8mNY-0000bt-D5
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:35:32 -0400
Received: by mail-wr0-x241.google.com with SMTP id 6so3141454wrb.1
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 04:35:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 May 2017 13:35:28 +0200
Message-Id: <1494502528-12670-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] target/i386: enable A20 automatically in
 system management mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, kevin@koconnor.net

Ignore env->a20_mask when running in system management mode.

Reported-by: Anthony Xu <anthony.xu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/arch_memory_mapping.c | 18 +++++++++--------
 target/i386/cpu.h                 |  9 +++++++++
 target/i386/helper.c              | 42 +++++++++++++++++++++------------------
 3 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index 826aee5..647cff2 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -272,25 +272,27 @@ void x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    int32_t a20_mask;
 
     if (!cpu_paging_enabled(cs)) {
         /* paging is disabled */
         return;
     }
 
+    a20_mask = x86_get_a20_mask(env);
     if (env->cr[4] & CR4_PAE_MASK) {
 #ifdef TARGET_X86_64
         if (env->hflags & HF_LMA_MASK) {
             if (env->cr[4] & CR4_LA57_MASK) {
                 hwaddr pml5e_addr;
 
-                pml5e_addr = (env->cr[3] & PLM4_ADDR_MASK) & env->a20_mask;
-                walk_pml5e(list, cs->as, pml5e_addr, env->a20_mask);
+                pml5e_addr = (env->cr[3] & PLM4_ADDR_MASK) & a20_mask;
+                walk_pml5e(list, cs->as, pml5e_addr, a20_mask);
             } else {
                 hwaddr pml4e_addr;
 
-                pml4e_addr = (env->cr[3] & PLM4_ADDR_MASK) & env->a20_mask;
-                walk_pml4e(list, cs->as, pml4e_addr, env->a20_mask,
+                pml4e_addr = (env->cr[3] & PLM4_ADDR_MASK) & a20_mask;
+                walk_pml4e(list, cs->as, pml4e_addr, a20_mask,
                         0xffffULL << 48);
             }
         } else
@@ -298,16 +300,16 @@ void x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
         {
             hwaddr pdpe_addr;
 
-            pdpe_addr = (env->cr[3] & ~0x1f) & env->a20_mask;
-            walk_pdpe2(list, cs->as, pdpe_addr, env->a20_mask);
+            pdpe_addr = (env->cr[3] & ~0x1f) & a20_mask;
+            walk_pdpe2(list, cs->as, pdpe_addr, a20_mask);
         }
     } else {
         hwaddr pde_addr;
         bool pse;
 
-        pde_addr = (env->cr[3] & ~0xfff) & env->a20_mask;
+        pde_addr = (env->cr[3] & ~0xfff) & a20_mask;
         pse = !!(env->cr[4] & CR4_PSE_MASK);
-        walk_pde2(list, cs->as, pde_addr, env->a20_mask, pse);
+        walk_pde2(list, cs->as, pde_addr, a20_mask, pse);
     }
 }
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c4602ca..ff93974 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1624,6 +1624,15 @@ static inline MemTxAttrs cpu_get_mem_attrs(CPUX86State *env)
     return ((MemTxAttrs) { .secure = (env->hflags & HF_SMM_MASK) != 0 });
 }
 
+static int32_t x86_get_a20_mask(CPUX86State *env)
+{
+    if (env->hflags & HF_SMM_MASK) {
+        return -1;
+    } else {
+        return env->a20_mask;
+    }
+}
+
 /* fpu_helper.c */
 void cpu_set_mxcsr(CPUX86State *env, uint32_t val);
 void cpu_set_fpuc(CPUX86State *env, uint16_t val);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index f11cac6..6c16e7c 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -724,6 +724,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     uint64_t ptep, pte;
+    int32_t a20_mask;
     target_ulong pde_addr, pte_addr;
     int error_code = 0;
     int is_dirty, prot, page_size, is_write, is_user;
@@ -739,6 +740,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
 #endif
     is_write = is_write1 & 1;
 
+    a20_mask = x86_get_a20_mask(env);
     if (!(env->cr[0] & CR0_PG_MASK)) {
         pte = addr;
 #ifdef TARGET_X86_64
@@ -777,7 +779,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
 
             if (la57) {
                 pml5e_addr = ((env->cr[3] & ~0xfff) +
-                        (((addr >> 48) & 0x1ff) << 3)) & env->a20_mask;
+                        (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
                 pml5e = x86_ldq_phys(cs, pml5e_addr);
                 if (!(pml5e & PG_PRESENT_MASK)) {
                     goto do_fault;
@@ -796,7 +798,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
             }
 
             pml4e_addr = ((pml5e & PG_ADDRESS_MASK) +
-                    (((addr >> 39) & 0x1ff) << 3)) & env->a20_mask;
+                    (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
             pml4e = x86_ldq_phys(cs, pml4e_addr);
             if (!(pml4e & PG_PRESENT_MASK)) {
                 goto do_fault;
@@ -810,7 +812,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
             }
             ptep &= pml4e ^ PG_NX_MASK;
             pdpe_addr = ((pml4e & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3)) &
-                env->a20_mask;
+                a20_mask;
             pdpe = x86_ldq_phys(cs, pdpe_addr);
             if (!(pdpe & PG_PRESENT_MASK)) {
                 goto do_fault;
@@ -835,7 +837,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
         {
             /* XXX: load them when cr3 is loaded ? */
             pdpe_addr = ((env->cr[3] & ~0x1f) + ((addr >> 27) & 0x18)) &
-                env->a20_mask;
+                a20_mask;
             pdpe = x86_ldq_phys(cs, pdpe_addr);
             if (!(pdpe & PG_PRESENT_MASK)) {
                 goto do_fault;
@@ -848,7 +850,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
         }
 
         pde_addr = ((pdpe & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3)) &
-            env->a20_mask;
+            a20_mask;
         pde = x86_ldq_phys(cs, pde_addr);
         if (!(pde & PG_PRESENT_MASK)) {
             goto do_fault;
@@ -870,7 +872,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
             x86_stl_phys_notdirty(cs, pde_addr, pde);
         }
         pte_addr = ((pde & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3)) &
-            env->a20_mask;
+            a20_mask;
         pte = x86_ldq_phys(cs, pte_addr);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
@@ -886,7 +888,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
 
         /* page directory entry */
         pde_addr = ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) &
-            env->a20_mask;
+            a20_mask;
         pde = x86_ldl_phys(cs, pde_addr);
         if (!(pde & PG_PRESENT_MASK)) {
             goto do_fault;
@@ -913,7 +915,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
 
         /* page directory entry */
         pte_addr = ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) &
-            env->a20_mask;
+            a20_mask;
         pte = x86_ldl_phys(cs, pte_addr);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
@@ -992,7 +994,7 @@ do_check_protect_pse36:
     }
 
  do_mapping:
-    pte = pte & env->a20_mask;
+    pte = pte & a20_mask;
 
     /* align to page_size */
     pte &= PG_ADDRESS_MASK & ~(page_size - 1);
@@ -1039,11 +1041,13 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     CPUX86State *env = &cpu->env;
     target_ulong pde_addr, pte_addr;
     uint64_t pte;
+    int32_t a20_mask;
     uint32_t page_offset;
     int page_size;
 
+    a20_mask = x86_get_a20_mask(env);
     if (!(env->cr[0] & CR0_PG_MASK)) {
-        pte = addr & env->a20_mask;
+        pte = addr & a20_mask;
         page_size = 4096;
     } else if (env->cr[4] & CR4_PAE_MASK) {
         target_ulong pdpe_addr;
@@ -1064,7 +1068,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
             if (la57) {
                 pml5e_addr = ((env->cr[3] & ~0xfff) +
-                        (((addr >> 48) & 0x1ff) << 3)) & env->a20_mask;
+                        (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
                 pml5e = x86_ldq_phys(cs, pml5e_addr);
                 if (!(pml5e & PG_PRESENT_MASK)) {
                     return -1;
@@ -1074,13 +1078,13 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
             }
 
             pml4e_addr = ((pml5e & PG_ADDRESS_MASK) +
-                    (((addr >> 39) & 0x1ff) << 3)) & env->a20_mask;
+                    (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
             pml4e = x86_ldq_phys(cs, pml4e_addr);
             if (!(pml4e & PG_PRESENT_MASK)) {
                 return -1;
             }
             pdpe_addr = ((pml4e & PG_ADDRESS_MASK) +
-                         (((addr >> 30) & 0x1ff) << 3)) & env->a20_mask;
+                         (((addr >> 30) & 0x1ff) << 3)) & a20_mask;
             pdpe = x86_ldq_phys(cs, pdpe_addr);
             if (!(pdpe & PG_PRESENT_MASK)) {
                 return -1;
@@ -1095,14 +1099,14 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 #endif
         {
             pdpe_addr = ((env->cr[3] & ~0x1f) + ((addr >> 27) & 0x18)) &
-                env->a20_mask;
+                a20_mask;
             pdpe = x86_ldq_phys(cs, pdpe_addr);
             if (!(pdpe & PG_PRESENT_MASK))
                 return -1;
         }
 
         pde_addr = ((pdpe & PG_ADDRESS_MASK) +
-                    (((addr >> 21) & 0x1ff) << 3)) & env->a20_mask;
+                    (((addr >> 21) & 0x1ff) << 3)) & a20_mask;
         pde = x86_ldq_phys(cs, pde_addr);
         if (!(pde & PG_PRESENT_MASK)) {
             return -1;
@@ -1114,7 +1118,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         } else {
             /* 4 KB page */
             pte_addr = ((pde & PG_ADDRESS_MASK) +
-                        (((addr >> 12) & 0x1ff) << 3)) & env->a20_mask;
+                        (((addr >> 12) & 0x1ff) << 3)) & a20_mask;
             page_size = 4096;
             pte = x86_ldq_phys(cs, pte_addr);
         }
@@ -1125,7 +1129,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         uint32_t pde;
 
         /* page directory entry */
-        pde_addr = ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) & env->a20_mask;
+        pde_addr = ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
         pde = x86_ldl_phys(cs, pde_addr);
         if (!(pde & PG_PRESENT_MASK))
             return -1;
@@ -1134,14 +1138,14 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
             page_size = 4096 * 1024;
         } else {
             /* page directory entry */
-            pte_addr = ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) & env->a20_mask;
+            pte_addr = ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) & a20_mask;
             pte = x86_ldl_phys(cs, pte_addr);
             if (!(pte & PG_PRESENT_MASK)) {
                 return -1;
             }
             page_size = 4096;
         }
-        pte = pte & env->a20_mask;
+        pte = pte & a20_mask;
     }
 
 #ifdef TARGET_X86_64
-- 
1.8.3.1
