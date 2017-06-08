Received: from eggs.gnu.org ([2001:4830:134:3::10]:57342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIrUZ-0000Wy-2y
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIrUX-0007fM-AM
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:27 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu,  8 Jun 2017 17:03:47 +1000
Message-Id: <20170608070351.1434-2-sjitindarsingh@gmail.com>
In-Reply-To: <20170608070351.1434-1-sjitindarsingh@gmail.com>
References: <20170608070351.1434-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [PATCH 1/5] target/ppc: Implement large decrementer
 support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The large decrementer is an operating mode of the decrementer.
The decrementer is normally a 32-bit register.
When operating in large decrementer mode the decrementer is a d-bit
register which is sign extended to 64-bits (where d is implementation
dependant).

Implement support for a TCG guest to use the decrementer in large
decrementer mode. This means updating the decrementer access functions
to accept larger values under the correct conditions.

The operting mode of the decrementer is controlled by the LPCR_LD bit in
the logical parition control register (LPCR).

The operating mode of the hypervisor decrementer is dependant on the cpu
model, >= POWER9 -> large hypervisor decrementer.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/ppc.c                | 81 +++++++++++++++++++++++++++++++--------------
 target/ppc/cpu-qom.h        |  1 +
 target/ppc/cpu.h            |  8 ++---
 target/ppc/mmu-hash64.c     |  2 +-
 target/ppc/translate.c      |  2 +-
 target/ppc/translate_init.c |  3 ++
 6 files changed, 67 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 224184d..49c52ed 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -649,11 +649,11 @@ bool ppc_decr_clear_on_delivery(CPUPPCState *env)
     return ((tb_env->flags & flags) == PPC_DECR_UNDERFLOW_TRIGGERED);
 }
 
-static inline uint32_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
+static inline target_ulong _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next,
+                                              bool large_decr)
 {
     ppc_tb_t *tb_env = env->tb_env;
-    uint32_t decr;
-    int64_t diff;
+    int64_t decr, diff;
 
     diff = next - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     if (diff >= 0) {
@@ -663,12 +663,16 @@ static inline uint32_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
     }  else {
         decr = -muldiv64(-diff, tb_env->decr_freq, NANOSECONDS_PER_SECOND);
     }
-    LOG_TB("%s: %08" PRIx32 "\n", __func__, decr);
+    LOG_TB("%s: %016" PRIx64 "\n", __func__, decr);
 
-    return decr;
+    /*
+     * If large decrementer is enabled then the decrementer is signed extened
+     * to 64 bits, otherwise it is a 32 bit value.
+     */
+    return large_decr ? decr : (uint32_t) decr;
 }
 
-uint32_t cpu_ppc_load_decr (CPUPPCState *env)
+target_ulong cpu_ppc_load_decr (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
 
@@ -676,14 +680,16 @@ uint32_t cpu_ppc_load_decr (CPUPPCState *env)
         return env->spr[SPR_DECR];
     }
 
-    return _cpu_ppc_load_decr(env, tb_env->decr_next);
+    return _cpu_ppc_load_decr(env, tb_env->decr_next,
+                              env->spr[SPR_LPCR] & LPCR_LD);
 }
 
-uint32_t cpu_ppc_load_hdecr (CPUPPCState *env)
+target_ulong cpu_ppc_load_hdecr (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
 
-    return _cpu_ppc_load_decr(env, tb_env->hdecr_next);
+    return _cpu_ppc_load_decr(env, tb_env->hdecr_next,
+                              env->mmu_model & POWERPC_MMU_V3);
 }
 
 uint64_t cpu_ppc_load_purr (CPUPPCState *env)
@@ -737,13 +743,20 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
                                  QEMUTimer *timer,
                                  void (*raise_excp)(void *),
                                  void (*lower_excp)(PowerPCCPU *),
-                                 uint32_t decr, uint32_t value)
+                                 target_ulong decr, target_ulong value,
+                                 int decr_bits)
 {
     CPUPPCState *env = &cpu->env;
     ppc_tb_t *tb_env = env->tb_env;
     uint64_t now, next;
 
-    LOG_TB("%s: %08" PRIx32 " => %08" PRIx32 "\n", __func__,
+    /* Truncate value to decr_width and sign extend for simplicity */
+    value &= ((1ULL << decr_bits) - 1);
+    if (value & (1ULL << (decr_bits - 1))) { /* Negative */
+        value |= (0xFFFFFFFFULL << decr_bits);
+    }
+
+    LOG_TB("%s: " TARGET_FMT_lx " => " TARGET_FMT_lx "\n", __func__,
                 decr, value);
 
     if (kvm_enabled()) {
@@ -765,15 +778,16 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
      * an edge interrupt, so raise it here too.
      */
     if ((value < 3) ||
-        ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && (value & 0x80000000)) ||
-        ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && (value & 0x80000000)
-          && !(decr & 0x80000000))) {
+        ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && (value & (1ULL << decr_bits))) ||
+        ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && (value & (1ULL << decr_bits))
+          && !(decr & (1ULL << decr_bits)))) {
         (*raise_excp)(cpu);
         return;
     }
 
     /* On MSB level based systems a 0 for the MSB stops interrupt delivery */
-    if (!(value & 0x80000000) && (tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL)) {
+    if (!(value & (1ULL << decr_bits)) && (tb_env->flags &
+                                         PPC_DECR_UNDERFLOW_LEVEL)) {
         (*lower_excp)(cpu);
     }
 
@@ -786,17 +800,24 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
     timer_mod(timer, next);
 }
 
-static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, uint32_t decr,
-                                       uint32_t value)
+static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, target_ulong decr,
+                                       target_ulong value)
 {
     ppc_tb_t *tb_env = cpu->env.tb_env;
+    int bits = 32;
+
+    if (cpu->env.spr[SPR_LPCR] & LPCR_LD) {
+        PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+
+        bits = pcc->large_decr_bits;
+    }
 
     __cpu_ppc_store_decr(cpu, &tb_env->decr_next, tb_env->decr_timer,
                          tb_env->decr_timer->cb, &cpu_ppc_decr_lower, decr,
-                         value);
+                         value, bits);
 }
 
-void cpu_ppc_store_decr (CPUPPCState *env, uint32_t value)
+void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = ppc_env_get_cpu(env);
 
@@ -810,19 +831,26 @@ static void cpu_ppc_decr_cb(void *opaque)
     cpu_ppc_decr_excp(cpu);
 }
 
-static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, uint32_t hdecr,
-                                        uint32_t value)
+static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, target_ulong hdecr,
+                                        target_ulong value)
 {
     ppc_tb_t *tb_env = cpu->env.tb_env;
+    int bits = 32;
+
+    if (cpu->env.mmu_model & POWERPC_MMU_V3) {
+        PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+
+        bits = pcc->large_decr_bits;
+    }
 
     if (tb_env->hdecr_timer != NULL) {
         __cpu_ppc_store_decr(cpu, &tb_env->hdecr_next, tb_env->hdecr_timer,
                              tb_env->hdecr_timer->cb, &cpu_ppc_hdecr_lower,
-                             hdecr, value);
+                             hdecr, value, bits);
     }
 }
 
-void cpu_ppc_store_hdecr (CPUPPCState *env, uint32_t value)
+void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = ppc_env_get_cpu(env);
 
@@ -848,7 +876,9 @@ static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
 {
     CPUPPCState *env = opaque;
     PowerPCCPU *cpu = ppc_env_get_cpu(env);
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     ppc_tb_t *tb_env = env->tb_env;
+    int decr_bits = 32;
 
     tb_env->tb_freq = freq;
     tb_env->decr_freq = freq;
@@ -857,7 +887,10 @@ static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
      * it's not ready to handle it...
      */
     _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF);
-    _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF);
+    if (env->mmu_model & POWERPC_MMU_V3) {
+        decr_bits = pcc->large_decr_bits;
+    }
+    _cpu_ppc_store_hdecr(cpu, (1 << decr_bits) - 1, (1 << decr_bits) - 1);
     cpu_ppc_store_purr(cpu, 0x0000000000000000ULL);
 }
 
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index d0cf6ca..523979c 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -198,6 +198,7 @@ typedef struct PowerPCCPUClass {
     uint32_t l1_dcache_size, l1_icache_size;
     const struct ppc_segment_page_sizes *sps;
     struct ppc_radix_page_info *radix_page_info;
+    uint32_t large_decr_bits;
     void (*init_proc)(CPUPPCState *env);
     int  (*check_pow)(CPUPPCState *env);
     int (*handle_mmu_fault)(PowerPCCPU *cpu, vaddr eaddr, int rwx, int mmu_idx);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 401e10e..f6e86b6 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1309,10 +1309,10 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState *env);
 void cpu_ppc_store_atbl (CPUPPCState *env, uint32_t value);
 void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value);
 bool ppc_decr_clear_on_delivery(CPUPPCState *env);
-uint32_t cpu_ppc_load_decr (CPUPPCState *env);
-void cpu_ppc_store_decr (CPUPPCState *env, uint32_t value);
-uint32_t cpu_ppc_load_hdecr (CPUPPCState *env);
-void cpu_ppc_store_hdecr (CPUPPCState *env, uint32_t value);
+target_ulong cpu_ppc_load_decr (CPUPPCState *env);
+void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value);
+target_ulong cpu_ppc_load_hdecr (CPUPPCState *env);
+void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value);
 uint64_t cpu_ppc_load_purr (CPUPPCState *env);
 uint32_t cpu_ppc601_load_rtcl (CPUPPCState *env);
 uint32_t cpu_ppc601_load_rtcu (CPUPPCState *env);
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 14d34e5..b1e1764 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1081,7 +1081,7 @@ void helper_store_lpcr(CPUPPCState *env, target_ulong val)
     case POWERPC_MMU_VER_3_00: /* P9 */
         lpcr = val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
                       (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
-                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL |
+                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_LD |
                       (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
                       LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPCR_TC |
                       LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c0cd64d..ebe1fa5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7006,7 +7006,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 #if !defined(NO_TIMER_DUMP)
     cpu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
 #if !defined(CONFIG_USER_ONLY)
-                " DECR %08" PRIu32
+                " DECR " TARGET_FMT_lu
 #endif
                 "\n",
                 cpu_ppc_load_tbu(env), cpu_ppc_load_tbl(env)
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 56a0ab2..a0b2934 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8995,6 +8995,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     /* segment page size remain the same */
     pcc->sps = &POWER7_POWER8_sps;
     pcc->radix_page_info = &POWER9_radix_page_info;
+    pcc->large_decr_bits = 56;
 #endif
     pcc->excp_model = POWERPC_EXCP_POWER8;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER7;
@@ -9047,6 +9048,8 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
          * tables and guest translation shootdown by default
          */
         lpcr->default_value &= ~(LPCR_UPRT | LPCR_GTSE);
+        /* Disable Large Decrementer by Default */
+        lpcr->default_value &= ~LPCR_LD;
         lpcr->default_value |= LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE |
                                LPCR_OEE;
         break;
-- 
2.9.4
