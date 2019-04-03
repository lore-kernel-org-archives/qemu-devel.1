Received: from eggs.gnu.org ([209.51.188.92]:48878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpb-0003IX-EL
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpZ-0000Sj-DL
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:55 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpY-0000RY-UT
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:53 -0400
Received: by mail-pg1-x542.google.com with SMTP id g8so7596681pgf.2
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:52 -0700 (PDT)
Received: from cloudburst.imgcgcw.net ([147.50.13.10])
	by smtp.gmail.com with ESMTPSA id
	z6sm26753214pgo.31.2019.04.02.20.44.49 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 02 Apr 2019 20:44:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:56 +0700
Message-Id: <20190403034358.21999-25-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 24/26] tcg: Use CPUClass::tlb_fill in cputlb.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We can now use the CPUClass hook instead of a named function.

Create a static tlb_fill function to avoid other changes within
cputlb.c.  This also which also isolates the asserts implied.
Remove the named tlb_fill function from all of the targets.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h    |  9 ---------
 accel/tcg/cputlb.c         | 19 +++++++++++++++++++
 target/alpha/helper.c      |  8 --------
 target/arm/helper.c        |  8 --------
 target/cris/helper.c       |  6 ------
 target/hppa/mem_helper.c   |  6 ------
 target/i386/excp_helper.c  |  8 --------
 target/lm32/helper.c       |  6 ------
 target/m68k/helper.c       |  8 --------
 target/microblaze/helper.c |  8 --------
 target/mips/helper.c       |  6 ------
 target/moxie/helper.c      |  6 ------
 target/nios2/helper.c      |  8 --------
 target/openrisc/mmu.c      |  6 ------
 target/ppc/mmu_helper.c    |  6 ------
 target/riscv/cpu_helper.c  |  6 ------
 target/s390x/excp_helper.c |  6 ------
 target/sh4/helper.c        |  8 --------
 target/sparc/mmu_helper.c  |  8 --------
 target/tricore/helper.c    |  6 ------
 target/unicore32/softmmu.c |  6 ------
 target/xtensa/helper.c     |  6 ------
 22 files changed, 19 insertions(+), 145 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 97b90cb0db..66e67caad7 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -474,15 +474,6 @@ static inline void assert_no_pages_locked(void)
  */
 struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
                                              hwaddr index, MemTxAttrs attrs);
-
-/*
- * Note: tlb_fill() can trigger a resize of the TLB. This means that all of the
- * caller's prior references to the TLB table (e.g. CPUTLBEntry pointers) must
- * be discarded and looked up again (e.g. via tlb_entry()).
- */
-void tlb_fill(CPUState *cpu, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
-
 #endif
 
 #if defined(CONFIG_USER_ONLY)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 88cc8389e9..7f59d815db 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -855,6 +855,25 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
     return ram_addr;
 }
 
+/*
+ * Note: tlb_fill() can trigger a resize of the TLB. This means that all of the
+ * caller's prior references to the TLB table (e.g. CPUTLBEntry pointers) must
+ * be discarded and looked up again (e.g. via tlb_entry()).
+ */
+static void tlb_fill(CPUState *cpu, target_ulong addr, int size,
+                     MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    bool ok;
+
+    /*
+     * This is not a probe, so only valid return is success; failure
+     * should result in exception + longjmp to the cpu loop.
+     */
+    ok = cc->tlb_fill(cpu, addr, size, access_type, mmu_idx, false, retaddr);
+    g_assert(ok);
+}
+
 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                          int mmu_idx,
                          target_ulong addr, uintptr_t retaddr,
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index e54197d5fb..726104a308 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -272,14 +272,6 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    alpha_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-#endif
-
 void alpha_cpu_do_interrupt(CPUState *cs)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0fc4abc651..db8c825a4b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12404,14 +12404,6 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    arm_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-#endif
-
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
     /* Implement DC ZVA, which zeroes a fixed-length block of memory.
diff --git a/target/cris/helper.c b/target/cris/helper.c
index 69464837c8..b5159b8357 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -123,12 +123,6 @@ bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit(cs);
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    cris_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 void crisv10_cpu_do_interrupt(CPUState *cs)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f61b0fdb9f..75b7082e0a 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -261,12 +261,6 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     return true;
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType type, int mmu_idx, uintptr_t retaddr)
-{
-    hppa_cpu_tlb_fill(cs, addr, size, type, mmu_idx, false, retaddr);
-}
-
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
 void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index 6f59b7bafc..79635d7539 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -700,11 +700,3 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     return true;
 #endif
 }
-
-#if !defined(CONFIG_USER_ONLY)
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    x86_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-#endif
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 1db9a5562e..20ea17ba23 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -44,12 +44,6 @@ bool lm32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     return true;
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    lm32_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 hwaddr lm32_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     LM32CPU *cpu = LM32_CPU(cs);
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 9768b4517f..2e34c684ba 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -893,14 +893,6 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-#ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    m68k_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-#endif
-
 uint32_t HELPER(bitrev)(uint32_t x)
 {
     x = ((x >> 1) & 0x55555555u) | ((x << 1) & 0xaaaaaaaau);
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 2d1d10e6cf..650897a20b 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -89,14 +89,6 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-#ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    mb_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-#endif
-
 #ifdef CONFIG_USER_ONLY
 
 void mb_cpu_do_interrupt(CPUState *cs)
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 7fe0ba4754..520f89407c 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -944,12 +944,6 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 }
 
 #ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    mips_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address, int rw)
 {
     hwaddr physical;
diff --git a/target/moxie/helper.c b/target/moxie/helper.c
index 216cef057e..f5c1d4181c 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -26,12 +26,6 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    moxie_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 void helper_raise_exception(CPUMoxieState *env, int ex)
 {
     CPUState *cs = CPU(moxie_env_get_cpu(env));
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index d075ef1965..34ad6987b7 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -294,11 +294,3 @@ bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     env->regs[CR_BADADDR] = address;
     cpu_loop_exit_restore(cs, retaddr);
 }
-
-#ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    nios2_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-#endif
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 991f3fafe8..4e190514ca 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -178,10 +178,4 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         return phys_addr;
     }
 }
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    openrisc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, 0, retaddr);
-}
 #endif
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 6865c0ca37..b8b44b2323 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -3049,9 +3049,3 @@ bool ppc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     }
     return true;
 }
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    ppc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2535435260..41d6db41c3 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -378,12 +378,6 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     env->badaddr = addr;
     riscv_raise_exception(env, cs->exception_index, retaddr);
 }
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-        MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    riscv_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
 #endif
 
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index aeeaeb523d..ec03d9f7d3 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -76,12 +76,6 @@ void s390_cpu_do_interrupt(CPUState *cs)
 
 #else /* !CONFIG_USER_ONLY */
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    s390_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
 {
     switch (mmu_idx) {
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 1df1e02a14..074c74f337 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -872,11 +872,3 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
     cpu_loop_exit_restore(cs, retaddr);
 }
-
-#ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    superh_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-#endif
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index b0fdabbea3..ae9b7a0eb3 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -858,11 +858,3 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     cpu_loop_exit_restore(cs, retaddr);
 }
-
-#ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    sparc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-#endif
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 3c99a8c22b..157c8caf4b 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -84,12 +84,6 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    tricore_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 static void tricore_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index 13678df4d7..27f218abf0 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -275,12 +275,6 @@ bool uc32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    uc32_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 hwaddr uc32_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     error_report("function uc32_cpu_get_phys_page_debug not "
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 3dcab54fbf..62d8dd1227 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -275,12 +275,6 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 }
 
 #ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    xtensa_cpu_tlb_fill(cs, vaddr, size, access_type, mmu_idx, false, retaddr);
-}
-
 void xtensa_cpu_do_unaligned_access(CPUState *cs,
                                     vaddr addr, MMUAccessType access_type,
                                     int mmu_idx, uintptr_t retaddr)
-- 
2.17.1
