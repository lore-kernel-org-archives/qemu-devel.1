Received: from eggs.gnu.org ([209.51.188.92]:48120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gyqrl-0000fj-2v
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 23:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gyqrj-0008Uc-1k
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 23:30:44 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 27 Feb 2019 15:30:06 +1100
Message-Id: <20190227043008.12059-2-sjitindarsingh@gmail.com>
In-Reply-To: <20190227043008.12059-1-sjitindarsingh@gmail.com>
References: <20190227043008.12059-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [QEMU-PPC] [PATCH v2 2/4] target/ppc: Implement large
 decrementer support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, clg@kaod.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Prior to POWER9 the decrementer was a 32-bit register which decremented
with each tick of the timebase. From POWER9 onwards the decrementer can
be set to operate in a mode called large decrementer where it acts as a
n-bit decrementing register which is visible as a 64-bit register, that
is the value of the decrementer is sign extended to 64 bits (where n is
implementation dependant).

The mode in which the decrementer operates is controlled by the LPCR_LD
bit in the logical paritition control register (LPCR).

>From POWER9 onwards the HDEC (hypervisor decrementer) was enlarged to
h-bits, also sign extended to 64 bits (where h is implementation
dependant). Note this isn't configurable and is always enabled.

On POWER9 the large decrementer and hdec are both 56 bits, as
represented by the lrg_decr_bits cpu class property. Since they are the
same size we only add one property for now, which could be extended in
the case they ever differ in the future.

We also add the lrg_decr_bits property for POWER5+/7/8 since it is used
to determine the size of the hdec, which is only generated on the
POWER5+ processor and later. On these processors it is 32 bits.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/ppc.c                    | 85 ++++++++++++++++++++++++++++-------------
 hw/ppc/spapr.c                  |  8 ++++
 hw/ppc/spapr_caps.c             | 31 ++++++++++++++-
 target/ppc/cpu-qom.h            |  1 +
 target/ppc/cpu.h                |  8 ++--
 target/ppc/mmu-hash64.c         |  2 +-
 target/ppc/translate.c          |  2 +-
 target/ppc/translate_init.inc.c |  4 ++
 8 files changed, 108 insertions(+), 33 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index d1e3d4cd20..9145aeddcb 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -744,11 +744,10 @@ bool ppc_decr_clear_on_delivery(CPUPPCState *env)
     return ((tb_env->flags & flags) == PPC_DECR_UNDERFLOW_TRIGGERED);
 }
 
-static inline uint32_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
+static inline int64_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
 {
     ppc_tb_t *tb_env = env->tb_env;
-    uint32_t decr;
-    int64_t diff;
+    int64_t decr, diff;
 
     diff = next - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     if (diff >= 0) {
@@ -758,27 +757,47 @@ static inline uint32_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
     }  else {
         decr = -muldiv64(-diff, tb_env->decr_freq, NANOSECONDS_PER_SECOND);
     }
-    LOG_TB("%s: %08" PRIx32 "\n", __func__, decr);
+    LOG_TB("%s: %016" PRIx64 "\n", __func__, decr);
 
     return decr;
 }
 
-uint32_t cpu_ppc_load_decr (CPUPPCState *env)
+target_ulong cpu_ppc_load_decr (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
+    uint64_t decr;
 
     if (kvm_enabled()) {
         return env->spr[SPR_DECR];
     }
 
-    return _cpu_ppc_load_decr(env, tb_env->decr_next);
+    decr = _cpu_ppc_load_decr(env, tb_env->decr_next);
+
+    /*
+     * If large decrementer is enabled then the decrementer is signed extened
+     * to 64 bits, otherwise it is a 32 bit value.
+     */
+    if (env->spr[SPR_LPCR] & LPCR_LD)
+        return decr;
+    return (uint32_t) decr;
 }
 
-uint32_t cpu_ppc_load_hdecr (CPUPPCState *env)
+target_ulong cpu_ppc_load_hdecr (CPUPPCState *env)
 {
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     ppc_tb_t *tb_env = env->tb_env;
+    uint64_t hdecr;
 
-    return _cpu_ppc_load_decr(env, tb_env->hdecr_next);
+    hdecr =  _cpu_ppc_load_decr(env, tb_env->hdecr_next);
+
+    /*
+     * If we have a large decrementer (POWER9 or later) then hdecr is sign
+     * extended to 64 bits, otherwise it is 32 bits.
+     */
+    if (pcc->lrg_decr_bits > 32)
+        return hdecr;
+    return (uint32_t) hdecr;
 }
 
 uint64_t cpu_ppc_load_purr (CPUPPCState *env)
@@ -832,13 +851,21 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
                                  QEMUTimer *timer,
                                  void (*raise_excp)(void *),
                                  void (*lower_excp)(PowerPCCPU *),
-                                 uint32_t decr, uint32_t value)
+                                 target_ulong decr, target_ulong value,
+                                 int nr_bits)
 {
     CPUPPCState *env = &cpu->env;
     ppc_tb_t *tb_env = env->tb_env;
     uint64_t now, next;
+    bool negative;
+
+    /* Truncate value to decr_width and sign extend for simplicity */
+    value &= ((1ULL << nr_bits) - 1);
+    negative = !!(value & (1ULL << (nr_bits - 1)));
+    if (negative)
+        value |= (0xFFFFFFFFULL << nr_bits);
 
-    LOG_TB("%s: %08" PRIx32 " => %08" PRIx32 "\n", __func__,
+    LOG_TB("%s: " TARGET_FMT_lx " => " TARGET_FMT_lx "\n", __func__,
                 decr, value);
 
     if (kvm_enabled()) {
@@ -860,15 +887,15 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
      * an edge interrupt, so raise it here too.
      */
     if ((value < 3) ||
-        ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && (value & 0x80000000)) ||
-        ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && (value & 0x80000000)
-          && !(decr & 0x80000000))) {
+        ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && negative) ||
+        ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && negative
+          && !(decr & (1ULL << (nr_bits - 1))))) {
         (*raise_excp)(cpu);
         return;
     }
 
     /* On MSB level based systems a 0 for the MSB stops interrupt delivery */
-    if (!(value & 0x80000000) && (tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL)) {
+    if (!negative && (tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL)) {
         (*lower_excp)(cpu);
     }
 
@@ -881,21 +908,25 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
     timer_mod(timer, next);
 }
 
-static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, uint32_t decr,
-                                       uint32_t value)
+static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, target_ulong decr,
+                                       target_ulong value, int nr_bits)
 {
     ppc_tb_t *tb_env = cpu->env.tb_env;
 
     __cpu_ppc_store_decr(cpu, &tb_env->decr_next, tb_env->decr_timer,
                          tb_env->decr_timer->cb, &cpu_ppc_decr_lower, decr,
-                         value);
+                         value, nr_bits);
 }
 
-void cpu_ppc_store_decr (CPUPPCState *env, uint32_t value)
+void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = ppc_env_get_cpu(env);
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    int nr_bits = 32;
+    if (env->spr[SPR_LPCR] & LPCR_LD)
+        nr_bits = pcc->lrg_decr_bits;
 
-    _cpu_ppc_store_decr(cpu, cpu_ppc_load_decr(env), value);
+    _cpu_ppc_store_decr(cpu, cpu_ppc_load_decr(env), value, nr_bits);
 }
 
 static void cpu_ppc_decr_cb(void *opaque)
@@ -905,23 +936,25 @@ static void cpu_ppc_decr_cb(void *opaque)
     cpu_ppc_decr_excp(cpu);
 }
 
-static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, uint32_t hdecr,
-                                        uint32_t value)
+static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, target_ulong hdecr,
+                                        target_ulong value, int nr_bits)
 {
     ppc_tb_t *tb_env = cpu->env.tb_env;
 
     if (tb_env->hdecr_timer != NULL) {
         __cpu_ppc_store_decr(cpu, &tb_env->hdecr_next, tb_env->hdecr_timer,
                              tb_env->hdecr_timer->cb, &cpu_ppc_hdecr_lower,
-                             hdecr, value);
+                             hdecr, value, nr_bits);
     }
 }
 
-void cpu_ppc_store_hdecr (CPUPPCState *env, uint32_t value)
+void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = ppc_env_get_cpu(env);
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-    _cpu_ppc_store_hdecr(cpu, cpu_ppc_load_hdecr(env), value);
+    _cpu_ppc_store_hdecr(cpu, cpu_ppc_load_hdecr(env), value,
+                         pcc->lrg_decr_bits);
 }
 
 static void cpu_ppc_hdecr_cb(void *opaque)
@@ -951,8 +984,8 @@ static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
      * if a decrementer exception is pending when it enables msr_ee at startup,
      * it's not ready to handle it...
      */
-    _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF);
-    _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF);
+    _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
+    _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
     cpu_ppc_store_purr(cpu, 0x0000000000000000ULL);
 }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index acf62a2b9f..ff5ba59cc0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -557,6 +557,14 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
                           pcc->radix_page_info->count *
                           sizeof(radix_AP_encodings[0]))));
     }
+
+    /*
+     * We set this property to let the guest know that it can use the large
+     * decrementer and its width in bits.
+     */
+    if (spapr_get_cap(spapr, SPAPR_CAP_LARGE_DECREMENTER))
+        _FDT((fdt_setprop_u32(fdt, offset, "ibm,dec-bits",
+                              pcc->lrg_decr_bits)));
 }
 
 static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 3f90f5823e..32f68cbd9e 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -393,8 +393,36 @@ static void cap_nested_kvm_hv_apply(sPAPRMachineState *spapr,
 static void cap_large_decr_apply(sPAPRMachineState *spapr,
                                  uint8_t val, Error **errp)
 {
-    if (val)
+    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+
+    if (!val)
+        return; /* Disabled by default */
+
+    if (tcg_enabled()) {
+        if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
+                              spapr->max_compat_pvr)) {
+            error_setg(errp,
+                "Large decrementer only supported on POWER9, try -cpu POWER9");
+            return;
+        }
+    } else {
         error_setg(errp, "No large decrementer support, try cap-large-decr=off");
+    }
+}
+
+static void cap_large_decr_cpu_apply(sPAPRMachineState *spapr,
+                                     PowerPCCPU *cpu,
+                                     uint8_t val, Error **errp)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong lpcr = env->spr[SPR_LPCR];
+
+    if (val)
+        lpcr |= LPCR_LD;
+    else
+        lpcr &= ~LPCR_LD;
+    ppc_store_lpcr(cpu, lpcr);
 }
 
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
@@ -483,6 +511,7 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .set = spapr_cap_set_bool,
         .type = "bool",
         .apply = cap_large_decr_apply,
+        .cpu_apply = cap_large_decr_cpu_apply,
     },
 };
 
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index ae51fe754e..be9b4c30c3 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -190,6 +190,7 @@ typedef struct PowerPCCPUClass {
 #endif
     const PPCHash64Options *hash64_opts;
     struct ppc_radix_page_info *radix_page_info;
+    uint32_t lrg_decr_bits;
     void (*init_proc)(CPUPPCState *env);
     int  (*check_pow)(CPUPPCState *env);
     int (*handle_mmu_fault)(PowerPCCPU *cpu, vaddr eaddr, int rwx, int mmu_idx);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 26604ddf98..81763d72f9 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1321,10 +1321,10 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState *env);
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
index c431303eff..a2b1ec5040 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1109,7 +1109,7 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
     case POWERPC_MMU_3_00: /* P9 */
         lpcr = val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
                       (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
-                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR |
+                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
                       (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
                       LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPCR_TC |
                       LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 819221f246..b156be4d98 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7417,7 +7417,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 #if !defined(NO_TIMER_DUMP)
     cpu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
 #if !defined(CONFIG_USER_ONLY)
-                " DECR %08" PRIu32
+                " DECR " TARGET_FMT_lu
 #endif
                 "\n",
                 cpu_ppc_load_tbu(env), cpu_ppc_load_tbl(env)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 58542c0fe0..af70a3b78c 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8376,6 +8376,7 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
 #if defined(CONFIG_SOFTMMU)
     pcc->handle_mmu_fault = ppc_hash64_handle_mmu_fault;
     pcc->hash64_opts = &ppc_hash64_opts_basic;
+    pcc->lrg_decr_bits = 32;
 #endif
     pcc->excp_model = POWERPC_EXCP_970;
     pcc->bus_model = PPC_FLAGS_INPUT_970;
@@ -8550,6 +8551,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
 #if defined(CONFIG_SOFTMMU)
     pcc->handle_mmu_fault = ppc_hash64_handle_mmu_fault;
     pcc->hash64_opts = &ppc_hash64_opts_POWER7;
+    pcc->lrg_decr_bits = 32;
 #endif
     pcc->excp_model = POWERPC_EXCP_POWER7;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER7;
@@ -8718,6 +8720,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
 #if defined(CONFIG_SOFTMMU)
     pcc->handle_mmu_fault = ppc_hash64_handle_mmu_fault;
     pcc->hash64_opts = &ppc_hash64_opts_POWER7;
+    pcc->lrg_decr_bits = 32;
 #endif
     pcc->excp_model = POWERPC_EXCP_POWER8;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER7;
@@ -8926,6 +8929,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     /* segment page size remain the same */
     pcc->hash64_opts = &ppc_hash64_opts_POWER7;
     pcc->radix_page_info = &POWER9_radix_page_info;
+    pcc->lrg_decr_bits = 56;
 #endif
     pcc->excp_model = POWERPC_EXCP_POWER9;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
-- 
2.13.6
