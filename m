Received: from eggs.gnu.org ([2001:4830:134:3::10]:59271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYga8-0000VS-3C
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYga2-0001Lx-JA
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:11:52 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  9 Jan 2018 00:10:43 +0100
Message-Id: <20180108231048.23966-2-laurent@vivier.eu>
In-Reply-To: <20180108231048.23966-1-laurent@vivier.eu>
References: <20180108231048.23966-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/6] accel/tcg: add size paremeter in tlb_fill()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Stafford Horne <shorne@gmail.com>, Alexander Graf <agraf@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

The MC68040 MMU provides the size of the access that
triggers the page fault.

This size is set in the Special Status Word which
is written in the stack frame of the access fault
exception.

So we need the size in m68k_cpu_unassigned_access() and
m68k_cpu_handle_mmu_fault().

To be able to do that, this patch modifies the prototype of
handle_mmu_fault handler, tlb_fill() and probe_write().
do_unassigned_access() already includes a size parameter.

This patch also updates handle_mmu_fault handlers and
tlb_fill() of all targets (only parameter, no code change).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
CC: Richard Henderson <richard.henderson@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Edgar E. Iglesias <edgar.iglesias@gmail.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Michael Walle <michael@walle.cc>
CC: Aurelien Jarno <aurelien@aurel32.net>
CC: Anthony Green <green@moxielogic.com>
CC: Chris Wulff <crwulff@gmail.com>
CC: Stafford Horne <shorne@gmail.com>
CC: Alexander Graf <agraf@suse.de>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
CC: Max Filippov <jcmvbkbc@gmail.com>
CC: qemu-arm@nongnu.org
CC: qemu-ppc@nongnu.org
CC: qemu-s390x@nongnu.org

 accel/tcg/cputlb.c            | 13 ++++++++-----
 accel/tcg/softmmu_template.h  | 14 ++++++++------
 accel/tcg/user-exec.c         |  2 +-
 include/exec/exec-all.h       |  6 +++---
 include/qom/cpu.h             |  2 +-
 target/alpha/cpu.h            |  2 +-
 target/alpha/helper.c         |  4 ++--
 target/alpha/mem_helper.c     |  6 +++---
 target/arm/cpu.c              |  4 ++--
 target/arm/op_helper.c        |  4 ++--
 target/cris/cpu.h             |  2 +-
 target/cris/helper.c          |  4 ++--
 target/cris/op_helper.c       |  6 +++---
 target/hppa/cpu.h             |  3 ++-
 target/hppa/helper.c          |  2 +-
 target/hppa/op_helper.c       |  2 +-
 target/i386/cpu.h             |  2 +-
 target/i386/excp_helper.c     |  4 ++--
 target/i386/mem_helper.c      |  6 +++---
 target/lm32/cpu.h             |  2 +-
 target/lm32/helper.c          |  2 +-
 target/lm32/op_helper.c       |  6 +++---
 target/m68k/cpu.h             |  2 +-
 target/m68k/helper.c          |  4 ++--
 target/m68k/op_helper.c       |  6 +++---
 target/microblaze/cpu.h       |  2 +-
 target/microblaze/helper.c    |  4 ++--
 target/microblaze/op_helper.c |  6 +++---
 target/mips/helper.c          |  2 +-
 target/mips/internal.h        |  2 +-
 target/mips/op_helper.c       | 10 +++++-----
 target/moxie/cpu.h            |  2 +-
 target/moxie/helper.c         | 10 +++++-----
 target/nios2/cpu.h            |  2 +-
 target/nios2/helper.c         |  6 ++++--
 target/nios2/mmu.c            |  6 +++---
 target/openrisc/cpu.h         |  2 +-
 target/openrisc/mmu.c         |  8 ++++----
 target/openrisc/mmu_helper.c  |  6 +++---
 target/ppc/cpu.h              |  2 +-
 target/ppc/mmu_helper.c       |  4 ++--
 target/ppc/user_only_helper.c |  2 +-
 target/s390x/excp_helper.c    |  4 ++--
 target/s390x/internal.h       |  2 +-
 target/s390x/mem_helper.c     |  8 ++++----
 target/sh4/cpu.h              |  2 +-
 target/sh4/helper.c           |  4 ++--
 target/sh4/op_helper.c        |  6 +++---
 target/sparc/cpu.h            |  2 +-
 target/sparc/ldst_helper.c    |  6 +++---
 target/sparc/mmu_helper.c     |  6 +++---
 target/tilegx/cpu.c           |  4 ++--
 target/tricore/op_helper.c    |  4 ++--
 target/unicore32/cpu.h        |  2 +-
 target/unicore32/helper.c     |  2 +-
 target/unicore32/op_helper.c  |  6 +++---
 target/unicore32/softmmu.c    |  2 +-
 target/xtensa/op_helper.c     |  4 ++--
 58 files changed, 129 insertions(+), 121 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 8fd84209df..0ab9942a5f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -880,7 +880,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=
                  (addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK)))) {
         if (!VICTIM_TLB_HIT(addr_read, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, MMU_INST_FETCH, mmu_idx, 0);
+            tlb_fill(ENV_GET_CPU(env), addr, 1, MMU_INST_FETCH, mmu_idx, 0);
         }
     }
     iotlbentry = &env->iotlb[mmu_idx][index];
@@ -928,7 +928,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
  * Otherwise the function will return, and there will be a valid
  * entry in the TLB for this access.
  */
-void probe_write(CPUArchState *env, target_ulong addr, int mmu_idx,
+void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
                  uintptr_t retaddr)
 {
     int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
@@ -938,7 +938,8 @@ void probe_write(CPUArchState *env, target_ulong addr, int mmu_idx,
         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
         /* TLB entry is for a different page */
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_STORE, mmu_idx, retaddr);
+            tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
         }
     }
 }
@@ -981,7 +982,8 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     if ((addr & TARGET_PAGE_MASK)
         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_STORE, mmu_idx, retaddr);
+            tlb_fill(ENV_GET_CPU(env), addr, 1 << s_bits, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
         }
         tlb_addr = tlbe->addr_write & ~TLB_INVALID_MASK;
     }
@@ -995,7 +997,8 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 
     /* Let the guest notice RMW on a write-only page.  */
     if (unlikely(tlbe->addr_read != (tlb_addr & ~TLB_NOTDIRTY))) {
-        tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_LOAD, mmu_idx, retaddr);
+        tlb_fill(ENV_GET_CPU(env), addr, 1 << s_bits, MMU_DATA_LOAD,
+                 mmu_idx, retaddr);
         /* Since we don't support reads and writes to different addresses,
            and we do have the proper page loaded for write, this shouldn't
            ever return.  But just in case, handle via stop-the-world.  */
diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index 3fc5144316..239ea6692b 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -124,7 +124,7 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
     if ((addr & TARGET_PAGE_MASK)
          != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
         if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
+            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
                      mmu_idx, retaddr);
         }
         tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
@@ -191,7 +191,7 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
     if ((addr & TARGET_PAGE_MASK)
          != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
         if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
+            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
                      mmu_idx, retaddr);
         }
         tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
@@ -283,7 +283,8 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
     if ((addr & TARGET_PAGE_MASK)
         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_STORE, mmu_idx, retaddr);
+            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
         }
         tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
     }
@@ -316,7 +317,7 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
         if (page2 != (tlb_addr2 & (TARGET_PAGE_MASK | TLB_INVALID_MASK))
             && !VICTIM_TLB_HIT(addr_write, page2)) {
-            tlb_fill(ENV_GET_CPU(env), page2, MMU_DATA_STORE,
+            tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
 
@@ -359,7 +360,8 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
     if ((addr & TARGET_PAGE_MASK)
         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_STORE, mmu_idx, retaddr);
+            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
         }
         tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
     }
@@ -392,7 +394,7 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
         if (page2 != (tlb_addr2 & (TARGET_PAGE_MASK | TLB_INVALID_MASK))
             && !VICTIM_TLB_HIT(addr_write, page2)) {
-            tlb_fill(ENV_GET_CPU(env), page2, MMU_DATA_STORE,
+            tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f42285ea1c..2548f4d394 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -137,7 +137,7 @@ static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
     cc = CPU_GET_CLASS(cpu);
     /* see if it is an MMU fault */
     g_assert(cc->handle_mmu_fault);
-    ret = cc->handle_mmu_fault(cpu, address, is_write, MMU_USER_IDX);
+    ret = cc->handle_mmu_fault(cpu, address, 1, is_write, MMU_USER_IDX);
 
     if (ret == 0) {
         /* The MMU fault was handled without causing real CPU fault.
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index b37f7d8d92..e5afd2e6d3 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -253,7 +253,7 @@ void tlb_set_page(CPUState *cpu, target_ulong vaddr,
                   hwaddr paddr, int prot,
                   int mmu_idx, target_ulong size);
 void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr);
-void probe_write(CPUArchState *env, target_ulong addr, int mmu_idx,
+void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
                  uintptr_t retaddr);
 #else
 static inline void tlb_flush_page(CPUState *cpu, target_ulong addr)
@@ -436,8 +436,8 @@ void tb_lock_reset(void);
 struct MemoryRegion *iotlb_to_region(CPUState *cpu,
                                      hwaddr index, MemTxAttrs attrs);
 
-void tlb_fill(CPUState *cpu, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr);
+void tlb_fill(CPUState *cpu, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
 
 #endif
 
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 93bd546879..aff88fa16f 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -174,7 +174,7 @@ typedef struct CPUClass {
                                Error **errp);
     void (*set_pc)(CPUState *cpu, vaddr value);
     void (*synchronize_from_tb)(CPUState *cpu, struct TranslationBlock *tb);
-    int (*handle_mmu_fault)(CPUState *cpu, vaddr address, int rw,
+    int (*handle_mmu_fault)(CPUState *cpu, vaddr address, int size, int rw,
                             int mmu_index);
     hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
     hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 0a9ad35f06..09720c2f3b 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -479,7 +479,7 @@ void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf);
    is returned if the signal was handled by the virtual CPU.  */
 int cpu_alpha_signal_handler(int host_signum, void *pinfo,
                              void *puc);
-int alpha_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+int alpha_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                                int mmu_idx);
 void QEMU_NORETURN dynamic_excp(CPUAlphaState *, uintptr_t, int, int);
 void QEMU_NORETURN arith_excp(CPUAlphaState *, uintptr_t, int, uint64_t);
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 36407f77f5..bbf72cadfb 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -103,7 +103,7 @@ void cpu_alpha_store_gr(CPUAlphaState *env, unsigned reg, uint64_t val)
 }
 
 #if defined(CONFIG_USER_ONLY)
-int alpha_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
+int alpha_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
                                int rw, int mmu_idx)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
@@ -247,7 +247,7 @@ hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return (fail >= 0 ? -1 : phys);
 }
 
-int alpha_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int rw,
+int alpha_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size, int rw,
                                int mmu_idx)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 430eea470b..e19ab91ec9 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -69,12 +69,12 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
    NULL, it means that the function was called in C code (i.e. not
    from generated code or from helper.c) */
 /* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-    ret = alpha_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = alpha_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (unlikely(ret != 0)) {
         /* Exception index and error code are already set */
         cpu_loop_exit_restore(cs, retaddr);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index cc1856c32b..9da6ea505c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1689,8 +1689,8 @@ static Property arm_cpu_properties[] = {
 };
 
 #ifdef CONFIG_USER_ONLY
-static int arm_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
-                                    int mmu_idx)
+static int arm_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
+                                    int rw, int mmu_idx)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index b36206343d..e8da1b8590 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -172,8 +172,8 @@ static void deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
  * NULL, it means that the function was called in C code (i.e. not
  * from generated code or from helper.c)
  */
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     bool ret;
     ARMMMUFaultInfo fi = {};
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index b64fa3542c..764b35cbae 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -283,7 +283,7 @@ static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
 	return !!(env->pregs[PR_CCS] & U_FLAG);
 }
 
-int cris_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+int cris_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                               int mmu_idx);
 
 /* Support function regs.  */
diff --git a/target/cris/helper.c b/target/cris/helper.c
index af78cca8b9..d2ec349191 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -53,7 +53,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
     cris_cpu_do_interrupt(cs);
 }
 
-int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                               int mmu_idx)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
@@ -76,7 +76,7 @@ static void cris_shift_ccs(CPUCRISState *env)
     env->pregs[PR_CCS] = ccs;
 }
 
-int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                               int mmu_idx)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index e92505c907..becd831b6b 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -41,8 +41,8 @@
 /* Try to fill the TLB and return an exception if error. If retaddr is
    NULL, it means that the function was called in C code (i.e. not
    from generated code or from helper.c) */
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
@@ -50,7 +50,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
 
     D_LOG("%s pc=%x tpc=%x ra=%p\n", __func__,
           env->pc, env->pregs[PR_EDA], (void *)retaddr);
-    ret = cris_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = cris_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (unlikely(ret)) {
         if (retaddr) {
             /* now we have a real cpu fault */
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8d14077763..1a35eae1fa 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -132,7 +132,8 @@ void cpu_hppa_loaded_fr0(CPUHPPAState *env);
 #define cpu_signal_handler cpu_hppa_signal_handler
 
 int cpu_hppa_signal_handler(int host_signum, void *pinfo, void *puc);
-int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw, int midx);
+int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
+                              int rw, int midx);
 int hppa_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index ba04a9a52b..23f7af7018 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -65,7 +65,7 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
     env->psw_cb = cb;
 }
 
-int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
+int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
                               int rw, int mmu_idx)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 3104404e8d..106a2fd448 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -139,7 +139,7 @@ static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ulong val,
         /* Nothing is stored, but protection is checked and the
            cacheline is marked dirty.  */
 #ifndef CONFIG_USER_ONLY
-        probe_write(env, addr, cpu_mmu_index(env, 0), ra);
+        probe_write(env, addr, 1, cpu_mmu_index(env, 0), ra);
 #endif
         break;
     }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 62c4742703..ac4fa2127c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1497,7 +1497,7 @@ void host_cpuid(uint32_t function, uint32_t count,
 void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
 
 /* helper.c */
-int x86_cpu_handle_mmu_fault(CPUState *cpu, vaddr addr,
+int x86_cpu_handle_mmu_fault(CPUState *cpu, vaddr addr, int size,
                              int is_write, int mmu_idx);
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index cef44495ab..cb4d1b7d33 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -138,7 +138,7 @@ void raise_exception_ra(CPUX86State *env, int exception_index, uintptr_t retaddr
 }
 
 #if defined(CONFIG_USER_ONLY)
-int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
+int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
                              int is_write, int mmu_idx)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -162,7 +162,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
  * 0  = nothing more to do
  * 1  = generate PF fault
  */
-int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
+int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
                              int is_write1, int mmu_idx)
 {
     X86CPU *cpu = X86_CPU(cs);
diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
index 70f67668ab..a8ae694a9c 100644
--- a/target/i386/mem_helper.c
+++ b/target/i386/mem_helper.c
@@ -199,12 +199,12 @@ void helper_boundl(CPUX86State *env, target_ulong a0, int v)
  * from generated code or from helper.c)
  */
 /* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-    ret = x86_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = x86_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (ret) {
         X86CPU *cpu = X86_CPU(cs);
         CPUX86State *env = &cpu->env;
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 2279594f40..ce0a2f24c4 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -263,7 +263,7 @@ bool lm32_cpu_do_semihosting(CPUState *cs);
 #define cpu_list lm32_cpu_list
 #define cpu_signal_handler cpu_lm32_signal_handler
 
-int lm32_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+int lm32_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                               int mmu_idx);
 
 #include "exec/cpu-all.h"
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 929cc36c14..a039a993ff 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -25,7 +25,7 @@
 #include "exec/semihost.h"
 #include "exec/log.h"
 
-int lm32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int lm32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                               int mmu_idx)
 {
     LM32CPU *cpu = LM32_CPU(cs);
diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index 30f670eee8..577f8306e3 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -144,12 +144,12 @@ uint32_t HELPER(rcsr_jrx)(CPULM32State *env)
  * NULL, it means that the function was called in C code (i.e. not
  * from generated code or from helper.c)
  */
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-    ret = lm32_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = lm32_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (unlikely(ret)) {
         /* now we have a real cpu fault */
         cpu_loop_exit_restore(cs, retaddr);
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 2985b039e1..c60564a047 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -418,7 +418,7 @@ static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
     return (env->sr & SR_S) == 0 ? 1 : 0;
 }
 
-int m68k_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+int m68k_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                               int mmu_idx);
 
 #include "exec/cpu-all.h"
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index a999389e9a..ef0ec5dadf 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -308,7 +308,7 @@ void m68k_switch_sp(CPUM68KState *env)
 
 #if defined(CONFIG_USER_ONLY)
 
-int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                               int mmu_idx)
 {
     M68kCPU *cpu = M68K_CPU(cs);
@@ -328,7 +328,7 @@ hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return addr;
 }
 
-int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                               int mmu_idx)
 {
     int prot;
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index c61ca9392f..67697d4e6d 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -39,12 +39,12 @@ static inline void do_interrupt_m68k_hardirq(CPUM68KState *env)
 /* Try to fill the TLB and return an exception if error. If retaddr is
    NULL, it means that the function was called in C code (i.e. not
    from generated code or from helper.c) */
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-    ret = m68k_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = m68k_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (unlikely(ret)) {
         /* now we have a real cpu fault */
         cpu_loop_exit_restore(cs, retaddr);
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 52b6b6aec7..f3e7405a62 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -367,7 +367,7 @@ static inline int cpu_mmu_index (CPUMBState *env, bool ifetch)
         return MMU_KERNEL_IDX;
 }
 
-int mb_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+int mb_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                             int mmu_idx);
 
 #include "exec/cpu-all.h"
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index da394d1dfc..fac6ee9263 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -38,7 +38,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
     env->regs[14] = env->sregs[SR_PC];
 }
 
-int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                             int mmu_idx)
 {
     cs->exception_index = 0xaa;
@@ -48,7 +48,7 @@ int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
 
 #else /* !CONFIG_USER_ONLY */
 
-int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                             int mmu_idx)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 4cf51568df..869072a2d1 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -33,12 +33,12 @@
  * NULL, it means that the function was called in C code (i.e. not
  * from generated code or from helper.c)
  */
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-    ret = mb_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = mb_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (unlikely(ret)) {
         /* now we have a real cpu fault */
         cpu_loop_exit_restore(cs, retaddr);
diff --git a/target/mips/helper.c b/target/mips/helper.c
index ea076261af..8cf91ce339 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -535,7 +535,7 @@ hwaddr mips_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 }
 #endif
 
-int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                               int mmu_idx)
 {
     MIPSCPU *cpu = MIPS_CPU(cs);
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 45ded3484c..e41051f8e6 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -202,7 +202,7 @@ void cpu_mips_start_count(CPUMIPSState *env);
 void cpu_mips_stop_count(CPUMIPSState *env);
 
 /* helper.c */
-int mips_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+int mips_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                               int mmu_idx);
 
 /* op_helper.c */
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index e537a8bfd8..293574d53e 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2451,12 +2451,12 @@ void mips_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     do_raise_exception_err(env, excp, error_code, retaddr);
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-    ret = mips_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = mips_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (ret) {
         MIPSCPU *cpu = MIPS_CPU(cs);
         CPUMIPSState *env = &cpu->env;
@@ -4190,10 +4190,10 @@ static inline void ensure_writable_pages(CPUMIPSState *env,
     target_ulong page_addr;
     if (unlikely(MSA_PAGESPAN(addr))) {
         /* first page */
-        probe_write(env, addr, mmu_idx, retaddr);
+        probe_write(env, addr, 1, mmu_idx, retaddr);
         /* second page */
         page_addr = (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-        probe_write(env, page_addr, mmu_idx, retaddr);
+        probe_write(env, page_addr, 1, mmu_idx, retaddr);
     }
 #endif
 }
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index d37e6a5572..a01f480821 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -142,7 +142,7 @@ static inline void cpu_get_tb_cpu_state(CPUMoxieState *env, target_ulong *pc,
     *flags = 0;
 }
 
-int moxie_cpu_handle_mmu_fault(CPUState *cpu, vaddr address,
+int moxie_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
                                int rw, int mmu_idx);
 
 #endif /* MOXIE_CPU_H */
diff --git a/target/moxie/helper.c b/target/moxie/helper.c
index 6890ffd71c..b8e86560da 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -29,12 +29,12 @@
 /* Try to fill the TLB and return an exception if error. If retaddr is
    NULL, it means that the function was called in C code (i.e. not
    from generated code or from helper.c) */
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-    ret = moxie_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = moxie_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (unlikely(ret)) {
         cpu_loop_exit_restore(cs, retaddr);
     }
@@ -94,7 +94,7 @@ void moxie_cpu_do_interrupt(CPUState *cs)
     cs->exception_index = -1;
 }
 
-int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
+int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
                                int rw, int mmu_idx)
 {
     MoxieCPU *cpu = MOXIE_CPU(cs);
@@ -107,7 +107,7 @@ int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
 
 #else /* !CONFIG_USER_ONLY */
 
-int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
+int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
                                int rw, int mmu_idx)
 {
     MoxieCPU *cpu = MOXIE_CPU(cs);
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 88823a6d4d..204b39add7 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -252,7 +252,7 @@ static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
                                                   MMU_SUPERVISOR_IDX;
 }
 
-int nios2_cpu_handle_mmu_fault(CPUState *env, vaddr address,
+int nios2_cpu_handle_mmu_fault(CPUState *env, vaddr address, int size,
                                int rw, int mmu_idx);
 
 static inline int cpu_interrupts_enabled(CPUNios2State *env)
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index 9f741a8f19..a169c91eaa 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -37,7 +37,8 @@ void nios2_cpu_do_interrupt(CPUState *cs)
     env->regs[R_EA] = env->regs[R_PC] + 4;
 }
 
-int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int mmu_idx)
+int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
+                               int rw, int mmu_idx)
 {
     cs->exception_index = 0xaa;
     /* Page 0x1000 is kuser helper */
@@ -232,7 +233,8 @@ static int cpu_nios2_handle_virtual_page(
     return 1;
 }
 
-int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int mmu_idx)
+int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
+                               int rw, int mmu_idx)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
     CPUNios2State *env = &cpu->env;
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
index 0cd8647510..69b71cba4a 100644
--- a/target/nios2/mmu.c
+++ b/target/nios2/mmu.c
@@ -35,12 +35,12 @@
 #define MMU_LOG(x)
 #endif
 
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-    ret = nios2_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = nios2_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (unlikely(ret)) {
         /* now we have a real cpu fault */
         cpu_loop_exit_restore(cs, retaddr);
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index cc22dc8871..fb46cc9986 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -356,7 +356,7 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int openrisc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void openrisc_translate_init(void);
-int openrisc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address,
+int openrisc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
                                   int rw, int mmu_idx);
 int cpu_openrisc_signal_handler(int host_signum, void *pinfo, void *puc);
 
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index ce2a29dd1a..2bd782f89b 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -178,8 +178,8 @@ static void cpu_openrisc_raise_mmu_exception(OpenRISCCPU *cpu,
 }
 
 #ifndef CONFIG_USER_ONLY
-int openrisc_cpu_handle_mmu_fault(CPUState *cs,
-                                  vaddr address, int rw, int mmu_idx)
+int openrisc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
+                                  int rw, int mmu_idx)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     int ret = 0;
@@ -202,8 +202,8 @@ int openrisc_cpu_handle_mmu_fault(CPUState *cs,
     return ret;
 }
 #else
-int openrisc_cpu_handle_mmu_fault(CPUState *cs,
-                                  vaddr address, int rw, int mmu_idx)
+int openrisc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
+                                  int rw, int mmu_idx)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     int ret = 0;
diff --git a/target/openrisc/mmu_helper.c b/target/openrisc/mmu_helper.c
index a3e182c42d..97e1d17b5a 100644
--- a/target/openrisc/mmu_helper.c
+++ b/target/openrisc/mmu_helper.c
@@ -25,12 +25,12 @@
 
 #ifndef CONFIG_USER_ONLY
 
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-    ret = openrisc_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = openrisc_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
 
     if (ret) {
         /* Raise Exception.  */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 370b05e76e..3e06e1706b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1291,7 +1291,7 @@ void ppc_translate_init(void);
 int cpu_ppc_signal_handler (int host_signum, void *pinfo,
                             void *puc);
 #if defined(CONFIG_USER_ONLY)
-int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                              int mmu_idx);
 #endif
 
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 2a1f9902c9..6c822bc533 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -2903,8 +2903,8 @@ void helper_check_tlb_flush_global(CPUPPCState *env)
    NULL, it means that the function was called in C code (i.e. not
    from generated code or from helper.c) */
 /* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
diff --git a/target/ppc/user_only_helper.c b/target/ppc/user_only_helper.c
index 6aff34713f..2f1477f102 100644
--- a/target/ppc/user_only_helper.c
+++ b/target/ppc/user_only_helper.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 
-int ppc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int ppc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                              int mmu_idx)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index f4697a884d..e8f7a40c2b 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -55,7 +55,7 @@ void s390_cpu_do_interrupt(CPUState *cs)
     cs->exception_index = -1;
 }
 
-int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
+int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
                               int rw, int mmu_idx)
 {
     S390CPU *cpu = S390_CPU(cs);
@@ -83,7 +83,7 @@ static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
     }
 }
 
-int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
+int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr, int size,
                               int rw, int mmu_idx)
 {
     S390CPU *cpu = S390_CPU(cs);
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 1a88e4beb4..fea165ffe4 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -323,7 +323,7 @@ ObjectClass *s390_cpu_class_by_name(const char *name);
 void s390x_cpu_debug_excp_handler(CPUState *cs);
 void s390_cpu_do_interrupt(CPUState *cpu);
 bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
-int s390_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+int s390_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                               int mmu_idx);
 void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                    MMUAccessType access_type,
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 2625d843b3..692aa2bc98 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -39,10 +39,10 @@
    NULL, it means that the function was called in C code (i.e. not
    from generated code or from helper.c) */
 /* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
-    int ret = s390_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    int ret = s390_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (unlikely(ret != 0)) {
         cpu_loop_exit_restore(cs, retaddr);
     }
@@ -1440,7 +1440,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
 
     /* Sanity check writability of the store address.  */
 #ifndef CONFIG_USER_ONLY
-    probe_write(env, a2, mem_idx, ra);
+    probe_write(env, a2, 1, mem_idx, ra);
 #endif
 
     /* Note that the compare-and-swap is atomic, and the store is atomic, but
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index a2c26e0597..52a4568dd5 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -246,7 +246,7 @@ void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 void sh4_translate_init(void);
 int cpu_sh4_signal_handler(int host_signum, void *pinfo,
                            void *puc);
-int superh_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+int superh_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                                 int mmu_idx);
 
 void sh4_cpu_list(FILE *f, fprintf_function cpu_fprintf);
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 680b583e53..2ff0cf4060 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -34,7 +34,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
     cs->exception_index = -1;
 }
 
-int superh_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int superh_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                                 int mmu_idx)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
@@ -458,7 +458,7 @@ static int get_physical_address(CPUSH4State * env, target_ulong * physical,
     return get_mmu_address(env, physical, prot, address, rw, access_type);
 }
 
-int superh_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int superh_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                                 int mmu_idx)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index d798f239cf..4b8bbf63b4 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -40,12 +40,12 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-    ret = superh_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = superh_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (ret) {
         /* now we have a real cpu fault */
         cpu_loop_exit_restore(cs, retaddr);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 9fde547fac..3eaffb354e 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -582,7 +582,7 @@ void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t) QEMU_NORETURN;
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
 void sparc_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 /* mmu_helper.c */
-int sparc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+int sparc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                                int mmu_idx);
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUSPARCState *env);
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index fb489cb5fd..5bc090213c 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1929,12 +1929,12 @@ void QEMU_NORETURN sparc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
    NULL, it means that the function was called in C code (i.e. not
    from generated code or from helper.c) */
 /* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-    ret = sparc_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = sparc_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (ret) {
         cpu_loop_exit_restore(cs, retaddr);
     }
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index d5b6c1e48c..a0426ade43 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -27,7 +27,7 @@
 
 #if defined(CONFIG_USER_ONLY)
 
-int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                                int mmu_idx)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
@@ -208,7 +208,7 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
 }
 
 /* Perform address translation */
-int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                                int mmu_idx)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
@@ -713,7 +713,7 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
 }
 
 /* Perform address translation */
-int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
+int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                                int mmu_idx)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index 2ef8ea7daa..c140b461ac 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -112,8 +112,8 @@ static void tilegx_cpu_do_interrupt(CPUState *cs)
     cs->exception_index = -1;
 }
 
-static int tilegx_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
-                                       int mmu_idx)
+static int tilegx_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
+                                       int rw, int mmu_idx)
 {
     TileGXCPU *cpu = TILEGX_CPU(cs);
 
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 40ed229486..098f217c2a 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2806,8 +2806,8 @@ static inline void QEMU_NORETURN do_raise_exception_err(CPUTriCoreState *env,
     cpu_loop_exit_restore(cs, pc);
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
     ret = cpu_tricore_handle_mmu_fault(cs, addr, access_type, mmu_idx);
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 3dc6fbc6c7..a3cc71416d 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -181,7 +181,7 @@ static inline void cpu_get_tb_cpu_state(CPUUniCore32State *env, target_ulong *pc
     }
 }
 
-int uc32_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+int uc32_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                               int mmu_idx);
 void uc32_translate_init(void);
 void switch_mode(CPUUniCore32State *, int);
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index 3393d2c020..a5ff2ddb74 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -230,7 +230,7 @@ void uc32_cpu_do_interrupt(CPUState *cs)
     cpu_abort(cs, "NO interrupt in user mode\n");
 }
 
-int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
+int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
                               int access_type, int mmu_idx)
 {
     cpu_abort(cs, "NO mmu fault in user mode\n");
diff --git a/target/unicore32/op_helper.c b/target/unicore32/op_helper.c
index 8788642a7f..e0a15882d3 100644
--- a/target/unicore32/op_helper.c
+++ b/target/unicore32/op_helper.c
@@ -244,12 +244,12 @@ uint32_t HELPER(ror_cc)(CPUUniCore32State *env, uint32_t x, uint32_t i)
 }
 
 #ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     int ret;
 
-    ret = uc32_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    ret = uc32_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
     if (unlikely(ret)) {
         /* now we have a real cpu fault */
         cpu_loop_exit_restore(cs, retaddr);
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index d8d76968f3..00c7e0d028 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -215,7 +215,7 @@ do_fault:
     return code;
 }
 
-int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
+int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
                               int access_type, int mmu_idx)
 {
     UniCore32CPU *cpu = UNICORE32_CPU(cs);
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 3d990c0caa..0bc3ce6d8f 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -50,8 +50,8 @@ void xtensa_cpu_do_unaligned_access(CPUState *cs,
     }
 }
 
-void tlb_fill(CPUState *cs, target_ulong vaddr, MMUAccessType access_type,
-              int mmu_idx, uintptr_t retaddr)
+void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
-- 
2.14.3
