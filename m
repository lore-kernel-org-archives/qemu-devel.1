Received: from eggs.gnu.org ([2001:4830:134:3::10]:49667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX40S-0007m0-Vn
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX40P-0004jW-PD
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:43:49 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX40P-0004jA-CU
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:43:45 -0500
Received: by mail-wm0-x234.google.com with SMTP id c85so110762917wmi.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:43:45 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:34:56 +0000
Message-Id: <20170127103505.18606-17-alex.bennee@linaro.org>
In-Reply-To: <20170127103505.18606-1-alex.bennee@linaro.org>
References: <20170127103505.18606-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 16/25] cputlb and arm/sparc targets: convert
 mmuidx flushes from varg to bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "open list:Overall" <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>

While the vargs approach was flexible the original MTTCG ended up
having munge the bits to a bitmap so the data could be used in
deferred work helpers. Instead of hiding that in cputlb we push the
change to the API to make it take a bitmap of MMU indexes instead.

This change is fairly mechanical but as storing the actual index is
useful for cases like the current running context. As a result the
constants are renamed to ARMMMUBit_foo and a couple of helper
functions added to convert between a single bit and a scalar index.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cputlb.c                   |  60 +++++-------
 include/exec/exec-all.h    |  13 +--
 target/arm/cpu.h           |  41 +++++---
 target/arm/helper.c        | 227 ++++++++++++++++++++++-----------------------
 target/arm/translate-a64.c |  14 +--
 target/arm/translate.c     |  24 +++--
 target/arm/translate.h     |   4 +-
 target/sparc/ldst_helper.c |   8 +-
 8 files changed, 194 insertions(+), 197 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 5dfd3c3ba9..97e5c12de8 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -122,26 +122,25 @@ void tlb_flush(CPUState *cpu)
     }
 }
 
-static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, va_list argp)
+static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
     CPUArchState *env = cpu->env_ptr;
+    unsigned long mmu_idx_bitmask = idxmap;
+    int mmu_idx;
 
     assert_cpu_is_self(cpu);
     tlb_debug("start\n");
 
     tb_lock();
 
-    for (;;) {
-        int mmu_idx = va_arg(argp, int);
-
-        if (mmu_idx < 0) {
-            break;
-        }
+    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
 
-        tlb_debug("%d\n", mmu_idx);
+        if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
+            tlb_debug("%d\n", mmu_idx);
 
-        memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
-        memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
+            memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
+            memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
+        }
     }
 
     memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
@@ -149,12 +148,9 @@ static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, va_list argp)
     tb_unlock();
 }
 
-void tlb_flush_by_mmuidx(CPUState *cpu, ...)
+void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
-    va_list argp;
-    va_start(argp, cpu);
-    v_tlb_flush_by_mmuidx(cpu, argp);
-    va_end(argp);
+    v_tlb_flush_by_mmuidx(cpu, idxmap);
 }
 
 static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong addr)
@@ -219,13 +215,11 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr)
     }
 }
 
-void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...)
+void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
 {
     CPUArchState *env = cpu->env_ptr;
-    int i, k;
-    va_list argp;
-
-    va_start(argp, addr);
+    unsigned long mmu_idx_bitmap = idxmap;
+    int i, page, mmu_idx;
 
     assert_cpu_is_self(cpu);
     tlb_debug("addr "TARGET_FMT_lx"\n", addr);
@@ -236,31 +230,23 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...)
                   TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
                   env->tlb_flush_addr, env->tlb_flush_mask);
 
-        v_tlb_flush_by_mmuidx(cpu, argp);
-        va_end(argp);
+        v_tlb_flush_by_mmuidx(cpu, idxmap);
         return;
     }
 
     addr &= TARGET_PAGE_MASK;
-    i = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
-
-    for (;;) {
-        int mmu_idx = va_arg(argp, int);
+    page = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
 
-        if (mmu_idx < 0) {
-            break;
-        }
-
-        tlb_debug("idx %d\n", mmu_idx);
-
-        tlb_flush_entry(&env->tlb_table[mmu_idx][i], addr);
+    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
+        if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
+            tlb_flush_entry(&env->tlb_table[mmu_idx][page], addr);
 
-        /* check whether there are vltb entries that need to be flushed */
-        for (k = 0; k < CPU_VTLB_SIZE; k++) {
-            tlb_flush_entry(&env->tlb_v_table[mmu_idx][k], addr);
+            /* check whether there are vltb entries that need to be flushed */
+            for (i = 0; i < CPU_VTLB_SIZE; i++) {
+                tlb_flush_entry(&env->tlb_v_table[mmu_idx][i], addr);
+            }
         }
     }
-    va_end(argp);
 
     tb_flush_jmp_cache(cpu, addr);
 }
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index e43cb68355..a6c17ed74a 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -106,21 +106,22 @@ void tlb_flush(CPUState *cpu);
  * tlb_flush_page_by_mmuidx:
  * @cpu: CPU whose TLB should be flushed
  * @addr: virtual address of page to be flushed
- * @...: list of MMU indexes to flush, terminated by a negative value
+ * @idxmap: bitmap of MMU indexes to flush
  *
  * Flush one page from the TLB of the specified CPU, for the specified
  * MMU indexes.
  */
-void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...);
+void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr,
+                              uint16_t idxmap);
 /**
  * tlb_flush_by_mmuidx:
  * @cpu: CPU whose TLB should be flushed
- * @...: list of MMU indexes to flush, terminated by a negative value
+ * @idxmap: bitmap of MMU indexes to flush
  *
  * Flush all entries from the TLB of the specified CPU, for the specified
  * MMU indexes.
  */
-void tlb_flush_by_mmuidx(CPUState *cpu, ...);
+void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
 /**
  * tlb_set_page_with_attrs:
  * @cpu: CPU to add this TLB entry for
@@ -169,11 +170,11 @@ static inline void tlb_flush(CPUState *cpu)
 }
 
 static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
-                                            target_ulong addr, ...)
+                                            target_ulong addr, uint16_t idxmap)
 {
 }
 
-static inline void tlb_flush_by_mmuidx(CPUState *cpu, ...)
+static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
 }
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 151a5d754e..274ef17562 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1954,27 +1954,40 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
  * of the AT/ATS operations.
  * The values used are carefully arranged to make mmu_idx => EL lookup easy.
  */
-typedef enum ARMMMUIdx {
-    ARMMMUIdx_S12NSE0 = 0,
-    ARMMMUIdx_S12NSE1 = 1,
-    ARMMMUIdx_S1E2 = 2,
-    ARMMMUIdx_S1E3 = 3,
-    ARMMMUIdx_S1SE0 = 4,
-    ARMMMUIdx_S1SE1 = 5,
-    ARMMMUIdx_S2NS = 6,
+typedef enum ARMMMUBitMap {
+    ARMMMUBit_S12NSE0 = 1 << 0,
+    ARMMMUBit_S12NSE1 = 1 << 1,
+    ARMMMUBit_S1E2 = 1 << 2,
+    ARMMMUBit_S1E3 = 1 << 3,
+    ARMMMUBit_S1SE0 = 1 << 4,
+    ARMMMUBit_S1SE1 = 1 << 5,
+    ARMMMUBit_S2NS = 1 << 6,
     /* Indexes below here don't have TLBs and are used only for AT system
      * instructions or for the first stage of an S12 page table walk.
      */
-    ARMMMUIdx_S1NSE0 = 7,
-    ARMMMUIdx_S1NSE1 = 8,
-} ARMMMUIdx;
+    ARMMMUBit_S1NSE0 = 1 << 7,
+    ARMMMUBit_S1NSE1 = 1 << 8,
+} ARMMMUBitMap;
 
-#define MMU_USER_IDX 0
+typedef int ARMMMUIdx;
+
+static inline ARMMMUIdx arm_mmu_bit_to_idx(ARMMMUBitMap bit)
+{
+    g_assert(ctpop16(bit) == 1);
+    return ctz32(bit);
+}
+
+static inline ARMMMUBitMap arm_mmu_idx_to_bit(ARMMMUIdx idx)
+{
+    return 1 << idx;
+}
+
+#define MMU_USER_IDX (1 << 0)
 
 /* Return the exception level we're running at if this is our mmu_idx */
 static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
 {
-    assert(mmu_idx < ARMMMUIdx_S2NS);
+    assert(mmu_idx < arm_mmu_bit_to_idx(ARMMMUBit_S2NS));
     return mmu_idx & 3;
 }
 
@@ -1984,7 +1997,7 @@ static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
     int el = arm_current_el(env);
 
     if (el < 2 && arm_is_secure_below_el3(env)) {
-        return ARMMMUIdx_S1SE0 + el;
+        return arm_mmu_bit_to_idx(ARMMMUBit_S1SE0) + el;
     }
     return el;
 }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 84d789be93..0c6fb4add7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -578,8 +578,8 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = ENV_GET_CPU(env);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdx_S12NSE1, ARMMMUIdx_S12NSE0,
-                        ARMMMUIdx_S2NS, -1);
+    tlb_flush_by_mmuidx(cs, ARMMMUBit_S12NSE1 | ARMMMUBit_S12NSE0
+                        | ARMMMUBit_S2NS);
 }
 
 static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -588,8 +588,8 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *other_cs;
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S12NSE1,
-                            ARMMMUIdx_S12NSE0, ARMMMUIdx_S2NS, -1);
+        tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S12NSE1 |
+                            ARMMMUBit_S12NSE0 | ARMMMUBit_S2NS);
     }
 }
 
@@ -611,7 +611,7 @@ static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 40);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S2NS, -1);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUBit_S2NS);
 }
 
 static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -627,7 +627,7 @@ static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pageaddr = sextract64(value << 12, 0, 40);
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S2NS, -1);
+        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S2NS);
     }
 }
 
@@ -636,7 +636,7 @@ static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = ENV_GET_CPU(env);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdx_S1E2, -1);
+    tlb_flush_by_mmuidx(cs, ARMMMUBit_S1E2);
 }
 
 static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -645,7 +645,7 @@ static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *other_cs;
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S1E2, -1);
+        tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S1E2);
     }
 }
 
@@ -655,7 +655,7 @@ static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = ENV_GET_CPU(env);
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S1E2, -1);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUBit_S1E2);
 }
 
 static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -665,7 +665,7 @@ static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S1E2, -1);
+        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S1E2);
     }
 }
 
@@ -2100,7 +2100,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     int access_type = ri->opc2 & 1;
     uint64_t par64;
-    ARMMMUIdx mmu_idx;
+    ARMMMUBitMap mmu_bit;
     int el = arm_current_el(env);
     bool secure = arm_is_secure_below_el3(env);
 
@@ -2109,13 +2109,13 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         /* stage 1 current state PL1: ATS1CPR, ATS1CPW */
         switch (el) {
         case 3:
-            mmu_idx = ARMMMUIdx_S1E3;
+            mmu_bit = ARMMMUBit_S1E3;
             break;
         case 2:
-            mmu_idx = ARMMMUIdx_S1NSE1;
+            mmu_bit = ARMMMUBit_S1NSE1;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S1NSE1;
+            mmu_bit = secure ? ARMMMUBit_S1SE1 : ARMMMUBit_S1NSE1;
             break;
         default:
             g_assert_not_reached();
@@ -2125,13 +2125,13 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         /* stage 1 current state PL0: ATS1CUR, ATS1CUW */
         switch (el) {
         case 3:
-            mmu_idx = ARMMMUIdx_S1SE0;
+            mmu_bit = ARMMMUBit_S1SE0;
             break;
         case 2:
-            mmu_idx = ARMMMUIdx_S1NSE0;
+            mmu_bit = ARMMMUBit_S1NSE0;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
+            mmu_bit = secure ? ARMMMUBit_S1SE0 : ARMMMUBit_S1NSE0;
             break;
         default:
             g_assert_not_reached();
@@ -2139,17 +2139,17 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         break;
     case 4:
         /* stage 1+2 NonSecure PL1: ATS12NSOPR, ATS12NSOPW */
-        mmu_idx = ARMMMUIdx_S12NSE1;
+        mmu_bit = ARMMMUBit_S12NSE1;
         break;
     case 6:
         /* stage 1+2 NonSecure PL0: ATS12NSOUR, ATS12NSOUW */
-        mmu_idx = ARMMMUIdx_S12NSE0;
+        mmu_bit = ARMMMUBit_S12NSE0;
         break;
     default:
         g_assert_not_reached();
     }
 
-    par64 = do_ats_write(env, value, access_type, mmu_idx);
+    par64 = do_ats_write(env, value, access_type, arm_mmu_bit_to_idx(mmu_bit));
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
 }
@@ -2160,7 +2160,8 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
     int access_type = ri->opc2 & 1;
     uint64_t par64;
 
-    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_S2NS);
+    par64 = do_ats_write(env, value, access_type,
+                         arm_mmu_bit_to_idx(ARMMMUBit_S2NS));
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
 }
@@ -2185,26 +2186,26 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     case 0:
         switch (ri->opc1) {
         case 0: /* AT S1E1R, AT S1E1W */
-            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S1NSE1;
+            mmu_idx = secure ? ARMMMUBit_S1SE1 : ARMMMUBit_S1NSE1;
             break;
         case 4: /* AT S1E2R, AT S1E2W */
-            mmu_idx = ARMMMUIdx_S1E2;
+            mmu_idx = ARMMMUBit_S1E2;
             break;
         case 6: /* AT S1E3R, AT S1E3W */
-            mmu_idx = ARMMMUIdx_S1E3;
+            mmu_idx = ARMMMUBit_S1E3;
             break;
         default:
             g_assert_not_reached();
         }
         break;
     case 2: /* AT S1E0R, AT S1E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
+        mmu_idx = secure ? ARMMMUBit_S1SE0 : ARMMMUBit_S1NSE0;
         break;
     case 4: /* AT S12E1R, AT S12E1W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S12NSE1;
+        mmu_idx = secure ? ARMMMUBit_S1SE1 : ARMMMUBit_S12NSE1;
         break;
     case 6: /* AT S12E0R, AT S12E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S12NSE0;
+        mmu_idx = secure ? ARMMMUBit_S1SE0 : ARMMMUBit_S12NSE0;
         break;
     default:
         g_assert_not_reached();
@@ -2499,8 +2500,8 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
     if (raw_read(env, ri) != value) {
-        tlb_flush_by_mmuidx(cs, ARMMMUIdx_S12NSE1, ARMMMUIdx_S12NSE0,
-                            ARMMMUIdx_S2NS, -1);
+        tlb_flush_by_mmuidx(cs, ARMMMUBit_S12NSE1 | ARMMMUBit_S12NSE0 |
+                            ARMMMUBit_S2NS);
         raw_write(env, ri, value);
     }
 }
@@ -2859,9 +2860,9 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
 
     if (arm_is_secure_below_el3(env)) {
-        tlb_flush_by_mmuidx(cs, ARMMMUIdx_S1SE1, ARMMMUIdx_S1SE0, -1);
+        tlb_flush_by_mmuidx(cs, ARMMMUBit_S1SE1 | ARMMMUBit_S1SE0);
     } else {
-        tlb_flush_by_mmuidx(cs, ARMMMUIdx_S12NSE1, ARMMMUIdx_S12NSE0, -1);
+        tlb_flush_by_mmuidx(cs, ARMMMUBit_S12NSE1 | ARMMMUBit_S12NSE0);
     }
 }
 
@@ -2873,10 +2874,10 @@ static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     CPU_FOREACH(other_cs) {
         if (sec) {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S1SE1, ARMMMUIdx_S1SE0, -1);
+            tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S1SE1 | ARMMMUBit_S1SE0);
         } else {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S12NSE1,
-                                ARMMMUIdx_S12NSE0, -1);
+            tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S12NSE1 |
+                                ARMMMUBit_S12NSE0);
         }
     }
 }
@@ -2892,13 +2893,13 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
 
     if (arm_is_secure_below_el3(env)) {
-        tlb_flush_by_mmuidx(cs, ARMMMUIdx_S1SE1, ARMMMUIdx_S1SE0, -1);
+        tlb_flush_by_mmuidx(cs, ARMMMUBit_S1SE1 | ARMMMUBit_S1SE0);
     } else {
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-            tlb_flush_by_mmuidx(cs, ARMMMUIdx_S12NSE1, ARMMMUIdx_S12NSE0,
-                                ARMMMUIdx_S2NS, -1);
+            tlb_flush_by_mmuidx(cs, ARMMMUBit_S12NSE1 | ARMMMUBit_S12NSE0 |
+                                ARMMMUBit_S2NS);
         } else {
-            tlb_flush_by_mmuidx(cs, ARMMMUIdx_S12NSE1, ARMMMUIdx_S12NSE0, -1);
+            tlb_flush_by_mmuidx(cs, ARMMMUBit_S12NSE1 | ARMMMUBit_S12NSE0);
         }
     }
 }
@@ -2909,7 +2910,7 @@ static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = arm_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdx_S1E2, -1);
+    tlb_flush_by_mmuidx(cs, ARMMMUBit_S1E2);
 }
 
 static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2918,7 +2919,7 @@ static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = arm_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdx_S1E3, -1);
+    tlb_flush_by_mmuidx(cs, ARMMMUBit_S1E3);
 }
 
 static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2934,13 +2935,13 @@ static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     CPU_FOREACH(other_cs) {
         if (sec) {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S1SE1, ARMMMUIdx_S1SE0, -1);
+            tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S1SE1 | ARMMMUBit_S1SE0);
         } else if (has_el2) {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S12NSE1,
-                                ARMMMUIdx_S12NSE0, ARMMMUIdx_S2NS, -1);
+            tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S12NSE1 |
+                                ARMMMUBit_S12NSE0 | ARMMMUBit_S2NS);
         } else {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S12NSE1,
-                                ARMMMUIdx_S12NSE0, -1);
+            tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S12NSE1 |
+                                ARMMMUBit_S12NSE0);
         }
     }
 }
@@ -2951,7 +2952,7 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *other_cs;
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S1E2, -1);
+        tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S1E2);
     }
 }
 
@@ -2961,7 +2962,7 @@ static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *other_cs;
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_by_mmuidx(other_cs, ARMMMUIdx_S1E3, -1);
+        tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S1E3);
     }
 }
 
@@ -2978,11 +2979,11 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     if (arm_is_secure_below_el3(env)) {
-        tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S1SE1,
-                                 ARMMMUIdx_S1SE0, -1);
+        tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUBit_S1SE1 |
+                                 ARMMMUBit_S1SE0);
     } else {
-        tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S12NSE1,
-                                 ARMMMUIdx_S12NSE0, -1);
+        tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUBit_S12NSE1 |
+                                 ARMMMUBit_S12NSE0);
     }
 }
 
@@ -2997,7 +2998,7 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S1E2, -1);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUBit_S1E2);
 }
 
 static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3011,7 +3012,7 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S1E3, -1);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUBit_S1E3);
 }
 
 static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3023,11 +3024,11 @@ static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     CPU_FOREACH(other_cs) {
         if (sec) {
-            tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S1SE1,
-                                     ARMMMUIdx_S1SE0, -1);
+            tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S1SE1 |
+                                     ARMMMUBit_S1SE0);
         } else {
-            tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S12NSE1,
-                                     ARMMMUIdx_S12NSE0, -1);
+            tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S12NSE1 |
+                                     ARMMMUBit_S12NSE0);
         }
     }
 }
@@ -3039,7 +3040,7 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S1E2, -1);
+        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S1E2);
     }
 }
 
@@ -3050,7 +3051,7 @@ static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S1E3, -1);
+        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S1E3);
     }
 }
 
@@ -3073,7 +3074,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 48);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdx_S2NS, -1);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUBit_S2NS);
 }
 
 static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3089,7 +3090,7 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pageaddr = sextract64(value << 12, 0, 48);
 
     CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUIdx_S2NS, -1);
+        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S2NS);
     }
 }
 
@@ -6709,41 +6710,33 @@ void arm_cpu_do_interrupt(CPUState *cs)
 /* Return the exception level which controls this address translation regime */
 static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    switch (mmu_idx) {
-    case ARMMMUIdx_S2NS:
-    case ARMMMUIdx_S1E2:
+    ARMMMUBitMap bit = arm_mmu_idx_to_bit(mmu_idx);
+    if (bit & (ARMMMUBit_S2NS | ARMMMUBit_S1E2)) {
         return 2;
-    case ARMMMUIdx_S1E3:
+    } else if (bit & ARMMMUBit_S1E3) {
         return 3;
-    case ARMMMUIdx_S1SE0:
+    } else if (bit & ARMMMUBit_S1SE0) {
         return arm_el_is_aa64(env, 3) ? 1 : 3;
-    case ARMMMUIdx_S1SE1:
-    case ARMMMUIdx_S1NSE0:
-    case ARMMMUIdx_S1NSE1:
+    } else if (bit & (ARMMMUBit_S1SE1 | ARMMMUBit_S1NSE0 | ARMMMUBit_S1NSE1)) {
         return 1;
-    default:
-        g_assert_not_reached();
     }
+
+    g_assert_not_reached();
 }
 
 /* Return true if this address translation regime is secure */
 static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    switch (mmu_idx) {
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
-    case ARMMMUIdx_S1NSE0:
-    case ARMMMUIdx_S1NSE1:
-    case ARMMMUIdx_S1E2:
-    case ARMMMUIdx_S2NS:
+    ARMMMUBitMap bit = arm_mmu_idx_to_bit(mmu_idx);
+
+    if (bit & (ARMMMUBit_S12NSE0 | ARMMMUBit_S12NSE1 | ARMMMUBit_S1NSE0 |
+               ARMMMUBit_S1NSE1 | ARMMMUBit_S1E2 | ARMMMUBit_S2NS)) {
         return false;
-    case ARMMMUIdx_S1E3:
-    case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1SE1:
+    } else if  (bit & (ARMMMUBit_S1E3 | ARMMMUBit_S1SE0 | ARMMMUBit_S1SE1)) {
         return true;
-    default:
-        g_assert_not_reached();
     }
+
+    g_assert_not_reached();
 }
 
 /* Return the SCTLR value which controls this address translation regime */
@@ -6756,7 +6749,7 @@ static inline uint32_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline bool regime_translation_disabled(CPUARMState *env,
                                                ARMMMUIdx mmu_idx)
 {
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S2NS)) {
         return (env->cp15.hcr_el2 & HCR_VM) == 0;
     }
     return (regime_sctlr(env, mmu_idx) & SCTLR_M) == 0;
@@ -6771,7 +6764,7 @@ static inline bool regime_translation_big_endian(CPUARMState *env,
 /* Return the TCR controlling this translation regime */
 static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S2NS)) {
         return &env->cp15.vtcr_el2;
     }
     return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
@@ -6786,8 +6779,9 @@ uint32_t arm_regime_tbi0(CPUARMState *env, ARMMMUIdx mmu_idx)
     /* For EL0 and EL1, TBI is controlled by stage 1's TCR, so convert
        * a stage 1+2 mmu index into the appropriate stage 1 mmu index.
        */
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
-        mmu_idx += ARMMMUIdx_S1NSE0;
+    if (mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S12NSE0) ||
+        mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S12NSE1)) {
+        mmu_idx += arm_mmu_bit_to_idx(ARMMMUBit_S1NSE0);
     }
 
     tcr = regime_tcr(env, mmu_idx);
@@ -6809,8 +6803,9 @@ uint32_t arm_regime_tbi1(CPUARMState *env, ARMMMUIdx mmu_idx)
     /* For EL0 and EL1, TBI is controlled by stage 1's TCR, so convert
        * a stage 1+2 mmu index into the appropriate stage 1 mmu index.
        */
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
-        mmu_idx += ARMMMUIdx_S1NSE0;
+    if (mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S12NSE0) ||
+        mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S12NSE1)) {
+        mmu_idx += arm_mmu_bit_to_idx(ARMMMUBit_S1NSE0);
     }
 
     tcr = regime_tcr(env, mmu_idx);
@@ -6827,7 +6822,7 @@ uint32_t arm_regime_tbi1(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
                                    int ttbrn)
 {
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S2NS)) {
         return env->cp15.vttbr_el2;
     }
     if (ttbrn == 0) {
@@ -6857,8 +6852,9 @@ static inline bool regime_using_lpae_format(CPUARMState *env,
  * on whether the long or short descriptor format is in use. */
 bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
-        mmu_idx += ARMMMUIdx_S1NSE0;
+    if (mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S12NSE0) ||
+        mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S12NSE1)) {
+        mmu_idx += arm_mmu_bit_to_idx(ARMMMUBit_S1NSE0);
     }
 
     return regime_using_lpae_format(env, mmu_idx);
@@ -6866,15 +6862,14 @@ bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
 
 static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    switch (mmu_idx) {
-    case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1NSE0:
+    ARMMMUBitMap bit = arm_mmu_idx_to_bit(mmu_idx);
+
+    if (bit & (ARMMMUBit_S1SE0 | ARMMMUBit_S1NSE0)) {
         return true;
-    default:
-        return false;
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
+    } else if (bit & (ARMMMUBit_S12NSE0 | ARMMMUBit_S12NSE1)) {
         g_assert_not_reached();
+    } else {
+        return false;
     }
 }
 
@@ -7004,7 +6999,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     bool have_wxn;
     int wxn = 0;
 
-    assert(mmu_idx != ARMMMUIdx_S2NS);
+    assert(mmu_idx != ARMMMUBit_S2NS);
 
     user_rw = simple_ap_to_rw_prot_is_user(ap, true);
     if (is_user) {
@@ -7096,14 +7091,15 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                uint32_t *fsr,
                                ARMMMUFaultInfo *fi)
 {
-    if ((mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1) &&
-        !regime_translation_disabled(env, ARMMMUIdx_S2NS)) {
+    if ((mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S1NSE0) ||
+         mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S1NSE1)) &&
+        !regime_translation_disabled(env, arm_mmu_bit_to_idx(ARMMMUBit_S2NS))) {
         target_ulong s2size;
         hwaddr s2pa;
         int s2prot;
         int ret;
 
-        ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_S2NS, &s2pa,
+        ret = get_phys_addr_lpae(env, addr, 0, ARMMMUBit_S2NS, &s2pa,
                                  &txattrs, &s2prot, &s2size, fsr, fi);
         if (ret) {
             fi->s2addr = addr;
@@ -7546,7 +7542,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         level = 0;
         addrsize = 64;
         if (el > 1) {
-            if (mmu_idx != ARMMMUIdx_S2NS) {
+            if (mmu_idx != ARMMMUBit_S2NS) {
                 tbi = extract64(tcr->raw_tcr, 20, 1);
             }
         } else {
@@ -7583,7 +7579,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         t0sz = extract32(tcr->raw_tcr, 0, 6);
         t0sz = MIN(t0sz, 39);
         t0sz = MAX(t0sz, 16);
-    } else if (mmu_idx != ARMMMUIdx_S2NS) {
+    } else if (mmu_idx != ARMMMUBit_S2NS) {
         /* AArch32 stage 1 translation.  */
         t0sz = extract32(tcr->raw_tcr, 0, 3);
     } else {
@@ -7677,7 +7673,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         goto do_fault;
     }
 
-    if (mmu_idx != ARMMMUIdx_S2NS) {
+    if (mmu_idx != ARMMMUBit_S2NS) {
         /* The starting level depends on the virtual address size (which can
          * be up to 48 bits) and the translation granule size. It indicates
          * the number of strides (stride bits at a time) needed to
@@ -7777,7 +7773,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         attrs = extract64(descriptor, 2, 10)
             | (extract64(descriptor, 52, 12) << 10);
 
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S2NS)) {
             /* Stage 2 table descriptors do not include any attribute fields */
             break;
         }
@@ -7805,7 +7801,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     ap = extract32(attrs, 4, 2);
     xn = extract32(attrs, 12, 1);
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S2NS)) {
         ns = true;
         *prot = get_S2prot(env, ap, xn);
     } else {
@@ -7834,7 +7830,7 @@ do_fault:
     /* Long-descriptor format IFSR/DFSR value */
     *fsr = (1 << 9) | (fault_type << 2) | level;
     /* Tag the error as S2 for failed S1 PTW at S2 or ordinary S2.  */
-    fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_S2NS);
+    fi->stage2 = fi->s1ptw || (mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S2NS));
     return true;
 }
 
@@ -8103,7 +8099,8 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
                           target_ulong *page_size, uint32_t *fsr,
                           ARMMMUFaultInfo *fi)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+    if (mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S12NSE0) ||
+        mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S12NSE1)) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
          * translations.
          */
@@ -8113,17 +8110,17 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
             int ret;
 
             ret = get_phys_addr(env, address, access_type,
-                                mmu_idx + ARMMMUIdx_S1NSE0, &ipa, attrs,
+                                mmu_idx + ARMMMUBit_S1NSE0, &ipa, attrs,
                                 prot, page_size, fsr, fi);
 
             /* If S1 fails or S2 is disabled, return early.  */
-            if (ret || regime_translation_disabled(env, ARMMMUIdx_S2NS)) {
+            if (ret || regime_translation_disabled(env, ARMMMUBit_S2NS)) {
                 *phys_ptr = ipa;
                 return ret;
             }
 
             /* S1 is done. Now do S2 translation.  */
-            ret = get_phys_addr_lpae(env, ipa, access_type, ARMMMUIdx_S2NS,
+            ret = get_phys_addr_lpae(env, ipa, access_type, ARMMMUBit_S2NS,
                                      phys_ptr, attrs, &s2_prot,
                                      page_size, fsr, fi);
             fi->s2addr = ipa;
@@ -8134,7 +8131,7 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
             /*
              * For non-EL2 CPUs a stage1+stage2 translation is just stage 1.
              */
-            mmu_idx += ARMMMUIdx_S1NSE0;
+            mmu_idx += arm_mmu_bit_to_idx(ARMMMUBit_S1NSE0);
         }
     }
 
@@ -8148,7 +8145,7 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
     /* Fast Context Switch Extension. This doesn't exist at all in v8.
      * In v7 and earlier it affects all stage 1 translations.
      */
-    if (address < 0x02000000 && mmu_idx != ARMMMUIdx_S2NS
+    if (address < 0x02000000 && mmu_idx != arm_mmu_bit_to_idx(ARMMMUBit_S2NS)
         && !arm_feature(env, ARM_FEATURE_V8)) {
         if (regime_el(env, mmu_idx) == 3) {
             address += env->cp15.fcseidr_s;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d0352e2045..88a4df6959 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -106,14 +106,14 @@ static inline ARMMMUIdx get_a64_user_mem_index(DisasContext *s)
     /* Return the mmu_idx to use for A64 "unprivileged load/store" insns:
      *  if EL1, access as if EL0; otherwise access at current EL
      */
-    switch (s->mmu_idx) {
-    case ARMMMUIdx_S12NSE1:
-        return ARMMMUIdx_S12NSE0;
-    case ARMMMUIdx_S1SE1:
-        return ARMMMUIdx_S1SE0;
-    case ARMMMUIdx_S2NS:
+    ARMMMUBitMap bit = arm_mmu_idx_to_bit(s->mmu_idx);
+    if (bit & ARMMMUBit_S12NSE1) {
+        return ARMMMUBit_S12NSE0;
+    } else if (bit & ARMMMUBit_S1SE1) {
+        return ARMMMUBit_S1SE0;
+    } else if (bit & ARMMMUBit_S2NS) {
         g_assert_not_reached();
-    default:
+    } else {
         return s->mmu_idx;
     }
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c9186b6195..dc67887918 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -109,19 +109,17 @@ static inline ARMMMUIdx get_a32_user_mem_index(DisasContext *s)
      *  if PL2, UNPREDICTABLE (we choose to implement as if PL0)
      *  otherwise, access as if at PL0.
      */
-    switch (s->mmu_idx) {
-    case ARMMMUIdx_S1E2:        /* this one is UNPREDICTABLE */
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
-        return ARMMMUIdx_S12NSE0;
-    case ARMMMUIdx_S1E3:
-    case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1SE1:
-        return ARMMMUIdx_S1SE0;
-    case ARMMMUIdx_S2NS:
-    default:
-        g_assert_not_reached();
-    }
+    ARMMMUBitMap bit = arm_mmu_idx_to_bit(s->mmu_idx);
+    if (bit & (ARMMMUBit_S1E2 |        /* this one is UNPREDICTABLE */
+               ARMMMUBit_S12NSE0 |
+               ARMMMUBit_S12NSE1)) {
+        return arm_mmu_bit_to_idx(ARMMMUBit_S12NSE0);
+    } else if (bit & (ARMMMUBit_S1E3 |
+                      ARMMMUBit_S1SE0 |
+                      ARMMMUBit_S1SE1)) {
+        return arm_mmu_bit_to_idx(ARMMMUBit_S1SE0);
+    }
+    g_assert_not_reached();
 }
 
 static inline TCGv_i32 load_cpu_offset(int offset)
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 285e96f087..8011b8562d 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -100,8 +100,8 @@ static inline int default_exception_el(DisasContext *s)
      * exceptions can only be routed to ELs above 1, so we target the higher of
      * 1 or the current EL.
      */
-    return (s->mmu_idx == ARMMMUIdx_S1SE0 && s->secure_routed_to_el3)
-            ? 3 : MAX(1, s->current_el);
+    return (s->mmu_idx == arm_mmu_bit_to_idx(ARMMMUBit_S1SE0)
+            && s->secure_routed_to_el3) ? 3 : MAX(1, s->current_el);
 }
 
 /* target-specific extra values for is_jmp */
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2c05d6af75..57968d9143 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1768,13 +1768,15 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
           case 1:
               env->dmmu.mmu_primary_context = val;
               env->immu.mmu_primary_context = val;
-              tlb_flush_by_mmuidx(CPU(cpu), MMU_USER_IDX, MMU_KERNEL_IDX, -1);
+              tlb_flush_by_mmuidx(CPU(cpu),
+                                  (1 << MMU_USER_IDX) | (1 << MMU_KERNEL_IDX));
               break;
           case 2:
               env->dmmu.mmu_secondary_context = val;
               env->immu.mmu_secondary_context = val;
-              tlb_flush_by_mmuidx(CPU(cpu), MMU_USER_SECONDARY_IDX,
-                                  MMU_KERNEL_SECONDARY_IDX, -1);
+              tlb_flush_by_mmuidx(CPU(cpu),
+                                  (1 << MMU_USER_SECONDARY_IDX) |
+                                  (1 << MMU_KERNEL_SECONDARY_IDX));
               break;
           default:
               cpu_unassigned_access(cs, addr, true, false, 1, size);
-- 
2.11.0
