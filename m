Received: from eggs.gnu.org ([209.51.188.92]:41044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSy-0006EO-7d
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSl-0004LI-Gk
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:43 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:46572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmRSl-0004EU-0C
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:39 -0500
Received: by mail-pg1-x52f.google.com with SMTP id w7so1732816pgp.13
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 14:57:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 23 Jan 2019 14:57:05 -0800
Message-Id: <20190123225705.28963-14-richard.henderson@linaro.org>
In-Reply-To: <20190123225705.28963-1-richard.henderson@linaro.org>
References: <20190123225705.28963-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 13/13] cputlb: Remove static tlb sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

Now that all tcg backends support TCG_TARGET_IMPLEMENTS_DYN_TLB,
remove the define and the old code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h  | 46 ----------------------------------------
 include/exec/cpu_ldst.h  | 14 ------------
 tcg/aarch64/tcg-target.h |  1 -
 tcg/arm/tcg-target.h     |  1 -
 tcg/i386/tcg-target.h    |  1 -
 tcg/mips/tcg-target.h    |  1 -
 tcg/ppc/tcg-target.h     |  1 -
 tcg/riscv/tcg-target.h   |  1 -
 tcg/s390/tcg-target.h    |  1 -
 tcg/sparc/tcg-target.h   |  1 -
 tcg/tci/tcg-target.h     |  1 -
 accel/tcg/cputlb.c       | 21 ------------------
 12 files changed, 90 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 191a1e021f..8f2a848bf5 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -67,11 +67,9 @@ typedef uint64_t target_ulong;
 #define CPU_TLB_ENTRY_BITS 5
 #endif
 
-#if TCG_TARGET_IMPLEMENTS_DYN_TLB
 #define CPU_TLB_DYN_MIN_BITS 6
 #define CPU_TLB_DYN_DEFAULT_BITS 8
 
-
 # if HOST_LONG_BITS == 32
 /* Make sure we do not require a double-word shift for the TLB load */
 #  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
@@ -87,41 +85,6 @@ typedef uint64_t target_ulong;
     MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
 # endif
 
-#else /* !TCG_TARGET_IMPLEMENTS_DYN_TLB */
-
-/* TCG_TARGET_TLB_DISPLACEMENT_BITS is used in CPU_TLB_BITS to ensure that
- * the TLB is not unnecessarily small, but still small enough for the
- * TLB lookup instruction sequence used by the TCG target.
- *
- * TCG will have to generate an operand as large as the distance between
- * env and the tlb_table[NB_MMU_MODES - 1][0].addend.  For simplicity,
- * the TCG targets just round everything up to the next power of two, and
- * count bits.  This works because: 1) the size of each TLB is a largish
- * power of two, 2) and because the limit of the displacement is really close
- * to a power of two, 3) the offset of tlb_table[0][0] inside env is smaller
- * than the size of a TLB.
- *
- * For example, the maximum displacement 0xFFF0 on PPC and MIPS, but TCG
- * just says "the displacement is 16 bits".  TCG_TARGET_TLB_DISPLACEMENT_BITS
- * then ensures that tlb_table at least 0x8000 bytes large ("not unnecessarily
- * small": 2^15).  The operand then will come up smaller than 0xFFF0 without
- * any particular care, because the TLB for a single MMU mode is larger than
- * 0x10000-0xFFF0=16 bytes.  In the end, the maximum value of the operand
- * could be something like 0xC000 (the offset of the last TLB table) plus
- * 0x18 (the offset of the addend field in each TLB entry) plus the offset
- * of tlb_table inside env (which is non-trivial but not huge).
- */
-#define CPU_TLB_BITS                                             \
-    MIN(8,                                                       \
-        TCG_TARGET_TLB_DISPLACEMENT_BITS - CPU_TLB_ENTRY_BITS -  \
-        (NB_MMU_MODES <= 1 ? 0 :                                 \
-         NB_MMU_MODES <= 2 ? 1 :                                 \
-         NB_MMU_MODES <= 4 ? 2 :                                 \
-         NB_MMU_MODES <= 8 ? 3 : 4))
-
-#define CPU_TLB_SIZE (1 << CPU_TLB_BITS)
-#endif /* TCG_TARGET_IMPLEMENTS_DYN_TLB */
-
 typedef struct CPUTLBEntry {
     /* bit TARGET_LONG_BITS to TARGET_PAGE_BITS : virtual address
        bit TARGET_PAGE_BITS-1..4  : Nonzero for accesses that should not
@@ -187,10 +150,8 @@ typedef struct CPUTLBDesc {
     target_ulong large_page_mask;
     /* The next index to use in the tlb victim table.  */
     size_t vindex;
-#if TCG_TARGET_IMPLEMENTS_DYN_TLB
     CPUTLBWindow window;
     size_t n_used_entries;
-#endif
 } CPUTLBDesc;
 
 /*
@@ -215,19 +176,12 @@ typedef struct CPUTLBCommon {
     size_t elide_flush_count;
 } CPUTLBCommon;
 
-#if TCG_TARGET_IMPLEMENTS_DYN_TLB
 # define CPU_TLB                                                        \
     /* tlb_mask[i] contains (n_entries - 1) << CPU_TLB_ENTRY_BITS */    \
     uintptr_t tlb_mask[NB_MMU_MODES];                                   \
     CPUTLBEntry *tlb_table[NB_MMU_MODES];
 # define CPU_IOTLB                              \
     CPUIOTLBEntry *iotlb[NB_MMU_MODES];
-#else
-# define CPU_TLB                                        \
-    CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];
-# define CPU_IOTLB                                      \
-    CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];
-#endif
 
 /*
  * The meaning of each of the MMU modes is defined in the target code.
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 83b2907d86..d78041d7a0 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -135,7 +135,6 @@ static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
 #endif
 }
 
-#if TCG_TARGET_IMPLEMENTS_DYN_TLB
 /* Find the TLB index corresponding to the mmu_idx + address pair.  */
 static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
                                   target_ulong addr)
@@ -149,19 +148,6 @@ static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
 {
     return (env->tlb_mask[mmu_idx] >> CPU_TLB_ENTRY_BITS) + 1;
 }
-#else
-/* Find the TLB index corresponding to the mmu_idx + address pair.  */
-static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
-                                  target_ulong addr)
-{
-    return (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-}
-
-static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
-{
-    return CPU_TLB_SIZE;
-}
-#endif /* TCG_TARGET_IMPLEMENTS_DYN_TLB */
 
 /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
 static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 5085a81060..2d93cf404e 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -15,7 +15,6 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE  4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 24
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 #undef TCG_TARGET_STACK_GROWSUP
 
 typedef enum {
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 679aaf097e..16172f73a3 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -60,7 +60,6 @@ extern int arm_arch;
 #undef TCG_TARGET_STACK_GROWSUP
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 
 typedef enum {
     TCG_REG_R0 = 0,
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index eb40312e67..7995fe3eab 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -27,7 +27,6 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE  1
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 31
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 
 #ifdef __x86_64__
 # define TCG_TARGET_REG_BITS  64
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 40adbe38cb..5cb8672470 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -37,7 +37,6 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 95b735b0bb..52c1bb04b1 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -34,7 +34,6 @@
 #define TCG_TARGET_NB_REGS 32
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 
 typedef enum {
     TCG_REG_R0,  TCG_REG_R1,  TCG_REG_R2,  TCG_REG_R3,
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 83b123ca03..60918cacb4 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -33,7 +33,6 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 20
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 357528dd97..853ed6e7aa 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -27,7 +27,6 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 2
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 19
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 
 typedef enum TCGReg {
     TCG_REG_R0 = 0,
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index 6020a670c0..a0ed2a3342 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -29,7 +29,6 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index d9a28752c1..086f34e69a 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -43,7 +43,6 @@
 #define TCG_TARGET_INTERPRETER 1
 #define TCG_TARGET_INSN_UNIT_SIZE 1
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 
 #if UINTPTR_MAX == UINT32_MAX
 # define TCG_TARGET_REG_BITS 32
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a3a1614f0e..dad9b7796c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -74,7 +74,6 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
 QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
-#if TCG_TARGET_IMPLEMENTS_DYN_TLB
 static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
 {
     return env->tlb_mask[mmu_idx] + (1 << CPU_TLB_ENTRY_BITS);
@@ -235,26 +234,6 @@ static inline void tlb_n_used_entries_dec(CPUArchState *env, uintptr_t mmu_idx)
     env->tlb_d[mmu_idx].n_used_entries--;
 }
 
-#else /* !TCG_TARGET_IMPLEMENTS_DYN_TLB */
-
-static inline void tlb_dyn_init(CPUArchState *env)
-{
-}
-
-static inline void tlb_table_flush_by_mmuidx(CPUArchState *env, int mmu_idx)
-{
-    memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
-}
-
-static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
-{
-}
-
-static inline void tlb_n_used_entries_dec(CPUArchState *env, uintptr_t mmu_idx)
-{
-}
-#endif /* TCG_TARGET_IMPLEMENTS_DYN_TLB */
-
 void tlb_init(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
-- 
2.17.2
