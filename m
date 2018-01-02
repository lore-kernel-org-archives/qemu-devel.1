Received: from eggs.gnu.org ([2001:4830:134:3::10]:52456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBX-0007Cf-Cg
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBV-0003Bo-MQ
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:31 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:62548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWWBV-0003BY-B5
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:29 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  3 Jan 2018 00:41:07 +0100
Message-Id: <20180102234108.32713-17-laurent@vivier.eu>
In-Reply-To: <20180102234108.32713-1-laurent@vivier.eu>
References: <20180102234108.32713-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v6 16/17] target/m68k: add the Interrupt Stack
 Pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

Add the third stack pointer, the Interrupt Stack Pointer (ISP)
(680x0 only). This stack will be needed in softmmu mode.

Update movec to set/get the value of the three stacks.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v6: use cpu_m68k_set_sr() to set SR in GDB stub and in m68k_cpu_reset()

 target/m68k/cpu.c       |  8 ++---
 target/m68k/cpu.h       | 70 ++++++++++++++++++++++++++++++++++++++++-
 target/m68k/gdbstub.c   |  2 +-
 target/m68k/helper.c    | 82 ++++++++++++++++++++++++++++++++++++++++++++-----
 target/m68k/helper.h    |  4 ++-
 target/m68k/monitor.c   |  1 +
 target/m68k/translate.c | 40 ++++++++++++++++++++++--
 7 files changed, 190 insertions(+), 17 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 1936efd170..03126ba543 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -55,17 +55,17 @@ static void m68k_cpu_reset(CPUState *s)
     mcc->parent_reset(s);
 
     memset(env, 0, offsetof(CPUM68KState, end_reset_fields));
-#if !defined(CONFIG_USER_ONLY)
-    env->sr = 0x2700;
+#ifdef CONFIG_SOFTMMU
+    cpu_m68k_set_sr(env, SR_S | SR_I);
+#else
+    cpu_m68k_set_sr(env, 0);
 #endif
-    m68k_switch_sp(env);
     for (i = 0; i < 8; i++) {
         env->fregs[i].d = nan;
     }
     cpu_m68k_set_fpcr(env, 0);
     env->fpsr = 0;
 
-    cpu_m68k_set_ccr(env, 0);
     /* TODO: We should set PC from the interrupt vector.  */
     env->pc = 0;
 }
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 2ac4ab191e..759b30d389 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -89,7 +89,7 @@ typedef struct CPUM68KState {
 
     /* SSP and USP.  The current_sp is stored in aregs[7], the other here.  */
     int current_sp;
-    uint32_t sp[2];
+    uint32_t sp[3];
 
     /* Condition flags.  */
     uint32_t cc_op;
@@ -223,6 +223,74 @@ typedef enum {
 
 #define M68K_SSP    0
 #define M68K_USP    1
+#define M68K_ISP    2
+
+/* m68k Control Registers */
+
+/* ColdFire */
+/* Memory Management Control Registers */
+#define M68K_CR_ASID     0x003
+#define M68K_CR_ACR0     0x004
+#define M68K_CR_ACR1     0x005
+#define M68K_CR_ACR2     0x006
+#define M68K_CR_ACR3     0x007
+#define M68K_CR_MMUBAR   0x008
+
+/* Processor Miscellaneous Registers */
+#define M68K_CR_PC       0x80F
+
+/* Local Memory and Module Control Registers */
+#define M68K_CR_ROMBAR0  0xC00
+#define M68K_CR_ROMBAR1  0xC01
+#define M68K_CR_RAMBAR0  0xC04
+#define M68K_CR_RAMBAR1  0xC05
+#define M68K_CR_MPCR     0xC0C
+#define M68K_CR_EDRAMBAR 0xC0D
+#define M68K_CR_SECMBAR  0xC0E
+#define M68K_CR_MBAR     0xC0F
+
+/* Local Memory Address Permutation Control Registers */
+#define M68K_CR_PCR1U0   0xD02
+#define M68K_CR_PCR1L0   0xD03
+#define M68K_CR_PCR2U0   0xD04
+#define M68K_CR_PCR2L0   0xD05
+#define M68K_CR_PCR3U0   0xD06
+#define M68K_CR_PCR3L0   0xD07
+#define M68K_CR_PCR1U1   0xD0A
+#define M68K_CR_PCR1L1   0xD0B
+#define M68K_CR_PCR2U1   0xD0C
+#define M68K_CR_PCR2L1   0xD0D
+#define M68K_CR_PCR3U1   0xD0E
+#define M68K_CR_PCR3L1   0xD0F
+
+/* MC680x0 */
+/* MC680[1234]0/CPU32 */
+#define M68K_CR_SFC      0x000
+#define M68K_CR_DFC      0x001
+#define M68K_CR_USP      0x800
+#define M68K_CR_VBR      0x801 /* + Coldfire */
+
+/* MC680[234]0 */
+#define M68K_CR_CACR     0x002 /* + Coldfire */
+#define M68K_CR_CAAR     0x802 /* MC68020 and MC68030 only */
+#define M68K_CR_MSP      0x803
+#define M68K_CR_ISP      0x804
+
+/* MC68040/MC68LC040 */
+#define M68K_CR_TC       0x003
+#define M68K_CR_ITT0     0x004
+#define M68K_CR_ITT1     0x005
+#define M68K_CR_DTT0     0x006
+#define M68K_CR_DTT1     0x007
+#define M68K_CR_MMUSR    0x805
+#define M68K_CR_URP      0x806
+#define M68K_CR_SRP      0x807
+
+/* MC68EC040 */
+#define M68K_CR_IACR0    0x004
+#define M68K_CR_IACR1    0x005
+#define M68K_CR_DACR0    0x006
+#define M68K_CR_DACR1    0x007
 
 #define M68K_FPIAR_SHIFT  0
 #define M68K_FPIAR        (1 << M68K_FPIAR_SHIFT)
diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index c7f44c9bb3..99e5be8132 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -63,7 +63,7 @@ int m68k_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     } else {
         switch (n) {
         case 16:
-            env->sr = tmp;
+            cpu_m68k_set_sr(env, tmp);
             break;
         case 17:
             env->pc = tmp;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 52b054e1a3..a999389e9a 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -171,28 +171,84 @@ void m68k_cpu_init_gdb(M68kCPU *cpu)
     /* TODO: Add [E]MAC registers.  */
 }
 
-void HELPER(movec)(CPUM68KState *env, uint32_t reg, uint32_t val)
+void HELPER(cf_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
 {
     M68kCPU *cpu = m68k_env_get_cpu(env);
 
     switch (reg) {
-    case 0x02: /* CACR */
+    case M68K_CR_CACR:
         env->cacr = val;
         m68k_switch_sp(env);
         break;
-    case 0x04: case 0x05: case 0x06: case 0x07: /* ACR[0-3] */
+    case M68K_CR_ACR0:
+    case M68K_CR_ACR1:
+    case M68K_CR_ACR2:
+    case M68K_CR_ACR3:
         /* TODO: Implement Access Control Registers.  */
         break;
-    case 0x801: /* VBR */
+    case M68K_CR_VBR:
         env->vbr = val;
         break;
     /* TODO: Implement control registers.  */
     default:
-        cpu_abort(CPU(cpu), "Unimplemented control register write 0x%x = 0x%x\n",
+        cpu_abort(CPU(cpu),
+                  "Unimplemented control register write 0x%x = 0x%x\n",
                   reg, val);
     }
 }
 
+void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
+{
+    M68kCPU *cpu = m68k_env_get_cpu(env);
+
+    switch (reg) {
+    /* MC680[1234]0 */
+    case M68K_CR_VBR:
+        env->vbr = val;
+        return;
+    /* MC680[234]0 */
+    case M68K_CR_CACR:
+        env->cacr = val;
+        m68k_switch_sp(env);
+        return;
+    /* MC680[34]0 */
+    case M68K_CR_USP:
+        env->sp[M68K_USP] = val;
+        return;
+    case M68K_CR_MSP:
+        env->sp[M68K_SSP] = val;
+        return;
+    case M68K_CR_ISP:
+        env->sp[M68K_ISP] = val;
+        return;
+    }
+    cpu_abort(CPU(cpu), "Unimplemented control register write 0x%x = 0x%x\n",
+              reg, val);
+}
+
+uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
+{
+    M68kCPU *cpu = m68k_env_get_cpu(env);
+
+    switch (reg) {
+    /* MC680[1234]0 */
+    case M68K_CR_VBR:
+        return env->vbr;
+    /* MC680[234]0 */
+    case M68K_CR_CACR:
+        return env->cacr;
+    /* MC680[34]0 */
+    case M68K_CR_USP:
+        return env->sp[M68K_USP];
+    case M68K_CR_MSP:
+        return env->sp[M68K_SSP];
+    case M68K_CR_ISP:
+        return env->sp[M68K_ISP];
+    }
+    cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
+              reg);
+}
+
 void HELPER(set_macsr)(CPUM68KState *env, uint32_t val)
 {
     uint32_t acc;
@@ -232,8 +288,20 @@ void m68k_switch_sp(CPUM68KState *env)
     int new_sp;
 
     env->sp[env->current_sp] = env->aregs[7];
-    new_sp = (env->sr & SR_S && env->cacr & M68K_CACR_EUSP)
-             ? M68K_SSP : M68K_USP;
+    if (m68k_feature(env, M68K_FEATURE_M68000)) {
+        if (env->sr & SR_S) {
+            if (env->sr & SR_M) {
+                new_sp = M68K_SSP;
+            } else {
+                new_sp = M68K_ISP;
+            }
+        } else {
+            new_sp = M68K_USP;
+        }
+    } else {
+        new_sp = (env->sr & SR_S && env->cacr & M68K_CACR_EUSP)
+                 ? M68K_SSP : M68K_USP;
+    }
     env->aregs[7] = env->sp[new_sp];
     env->current_sp = new_sp;
 }
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index d27ea37d60..57f210aa14 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -8,7 +8,9 @@ DEF_HELPER_4(divsl, void, env, int, int, s32)
 DEF_HELPER_4(divull, void, env, int, int, i32)
 DEF_HELPER_4(divsll, void, env, int, int, s32)
 DEF_HELPER_2(set_sr, void, env, i32)
-DEF_HELPER_3(movec, void, env, i32, i32)
+DEF_HELPER_3(cf_movec_to, void, env, i32, i32)
+DEF_HELPER_3(m68k_movec_to, void, env, i32, i32)
+DEF_HELPER_2(m68k_movec_from, i32, env, i32)
 DEF_HELPER_4(cas2w, void, env, i32, i32, i32)
 DEF_HELPER_4(cas2l, void, env, i32, i32, i32)
 DEF_HELPER_4(cas2l_parallel, void, env, i32, i32, i32)
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 5605323a81..52781e85f0 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -30,6 +30,7 @@ static const MonitorDef monitor_defs[] = {
     { "sr", offsetof(CPUM68KState, sr) },
     { "ssp", offsetof(CPUM68KState, sp[0]) },
     { "usp", offsetof(CPUM68KState, sp[1]) },
+    { "isp", offsetof(CPUM68KState, sp[2]) },
     { NULL },
 };
 
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 205c3b8f35..9088e87b97 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4515,7 +4515,7 @@ DISAS_INSN(rte)
     gen_exception(s, s->insn_pc, EXCP_RTE);
 }
 
-DISAS_INSN(movec)
+DISAS_INSN(cf_movec)
 {
     uint16_t ext;
     TCGv reg;
@@ -4532,7 +4532,32 @@ DISAS_INSN(movec)
     } else {
         reg = DREG(ext, 12);
     }
-    gen_helper_movec(cpu_env, tcg_const_i32(ext & 0xfff), reg);
+    gen_helper_cf_movec_to(cpu_env, tcg_const_i32(ext & 0xfff), reg);
+    gen_lookup_tb(s);
+}
+
+DISAS_INSN(m68k_movec)
+{
+    uint16_t ext;
+    TCGv reg;
+
+    if (IS_USER(s)) {
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        return;
+    }
+
+    ext = read_im16(env, s);
+
+    if (ext & 0x8000) {
+        reg = AREG(ext, 12);
+    } else {
+        reg = DREG(ext, 12);
+    }
+    if (insn & 1) {
+        gen_helper_m68k_movec_to(cpu_env, tcg_const_i32(ext & 0xfff), reg);
+    } else {
+        gen_helper_m68k_movec_from(reg, cpu_env, tcg_const_i32(ext & 0xfff));
+    }
     gen_lookup_tb(s);
 }
 
@@ -5639,7 +5664,8 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(reset,     4e70, ffff, M68000);
     BASE(stop,      4e72, ffff);
     BASE(rte,       4e73, ffff);
-    INSN(movec,     4e7b, ffff, CF_ISA_A);
+    INSN(cf_movec,  4e7b, ffff, CF_ISA_A);
+    INSN(m68k_movec, 4e7a, fffe, M68000);
 #endif
     BASE(nop,       4e71, ffff);
     INSN(rtd,       4e74, ffff, RTD);
@@ -5946,6 +5972,14 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
         cpu_fprintf(f, "RP ");
         break;
     }
+    cpu_fprintf(f, "\n");
+#ifdef CONFIG_SOFTMMU
+    cpu_fprintf(f, "%sA7(MSP) = %08x %sA7(USP) = %08x %sA7(ISP) = %08x\n",
+               env->current_sp == M68K_SSP ? "->" : "  ", env->sp[M68K_SSP],
+               env->current_sp == M68K_USP ? "->" : "  ", env->sp[M68K_USP],
+               env->current_sp == M68K_ISP ? "->" : "  ", env->sp[M68K_ISP]);
+    cpu_fprintf(f, "VBR = 0x%08x\n", env->vbr);
+#endif
 }
 
 void restore_state_to_opc(CPUM68KState *env, TranslationBlock *tb,
-- 
2.14.3
