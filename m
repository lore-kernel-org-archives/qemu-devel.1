Received: from eggs.gnu.org ([2001:4830:134:3::10]:48520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eejFi-0006El-7d
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eejFe-0000kk-W8
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:15:46 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eejFe-0000js-MB
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:15:42 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 25 Jan 2018 16:15:33 +0100
Message-Id: <20180125151535.25256-7-laurent@vivier.eu>
In-Reply-To: <20180125151535.25256-1-laurent@vivier.eu>
References: <20180125151535.25256-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 6/8] target/m68k: add moves
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

and introduce SFC and DFC control registers.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180118193846.24953-6-laurent@vivier.eu>
---
 target/m68k/cpu.h       | 19 ++++++++++++--
 target/m68k/helper.c    | 10 +++++++
 target/m68k/monitor.c   |  2 ++
 target/m68k/op_helper.c |  4 +--
 target/m68k/translate.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 1c2bbac56d..cc1759bb5d 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -138,6 +138,8 @@ typedef struct CPUM68KState {
     uint32_t mbar;
     uint32_t rambar0;
     uint32_t cacr;
+    uint32_t sfc;
+    uint32_t dfc;
 
     int pending_vector;
     int pending_level;
@@ -544,13 +546,26 @@ void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr,
 
 #include "exec/cpu-all.h"
 
+/* TB flags */
+#define TB_FLAGS_MACSR          0x0f
+#define TB_FLAGS_MSR_S_BIT      13
+#define TB_FLAGS_MSR_S          (1 << TB_FLAGS_MSR_S_BIT)
+#define TB_FLAGS_SFC_S_BIT      14
+#define TB_FLAGS_SFC_S          (1 << TB_FLAGS_SFC_S_BIT)
+#define TB_FLAGS_DFC_S_BIT      15
+#define TB_FLAGS_DFC_S          (1 << TB_FLAGS_DFC_S_BIT)
+
 static inline void cpu_get_tb_cpu_state(CPUM68KState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
     *cs_base = 0;
-    *flags = (env->sr & SR_S)                   /* Bit  13 */
-            | ((env->macsr >> 4) & 0xf);        /* Bits 0-3 */
+    *flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
+    if (env->sr & SR_S) {
+        *flags |= TB_FLAGS_MSR_S;
+        *flags |= (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) & TB_FLAGS_SFC_S;
+        *flags |= (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) & TB_FLAGS_DFC_S;
+    }
 }
 
 #endif
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 58528f64ff..80db0b75b0 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -203,6 +203,12 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
 
     switch (reg) {
     /* MC680[1234]0 */
+    case M68K_CR_SFC:
+        env->sfc = val & 7;
+        return;
+    case M68K_CR_DFC:
+        env->dfc = val & 7;
+        return;
     case M68K_CR_VBR:
         env->vbr = val;
         return;
@@ -254,6 +260,10 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
 
     switch (reg) {
     /* MC680[1234]0 */
+    case M68K_CR_SFC:
+        return env->sfc;
+    case M68K_CR_DFC:
+        return env->dfc;
     case M68K_CR_VBR:
         return env->vbr;
     /* MC680[234]0 */
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index a20af6b09c..c31feb4b02 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -31,6 +31,8 @@ static const MonitorDef monitor_defs[] = {
     { "ssp", offsetof(CPUM68KState, sp[0]) },
     { "usp", offsetof(CPUM68KState, sp[1]) },
     { "isp", offsetof(CPUM68KState, sp[2]) },
+    { "sfc", offsetof(CPUM68KState, sfc) },
+    { "dfc", offsetof(CPUM68KState, dfc) },
     { "urp", offsetof(CPUM68KState, mmu.urp) },
     { "srp", offsetof(CPUM68KState, mmu.srp) },
     { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index f023901061..4609caa546 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -399,8 +399,8 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
         env->mmu.fault = false;
         if (qemu_loglevel_mask(CPU_LOG_INT)) {
             qemu_log("            "
-                     "ssw:  %08x ea:   %08x\n",
-                     env->mmu.ssw, env->mmu.ar);
+                     "ssw:  %08x ea:   %08x sfc:  %d    dfc: %d\n",
+                     env->mmu.ssw, env->mmu.ar, env->sfc, env->dfc);
         }
     } else if (cs->exception_index == EXCP_ADDRESS) {
         do_stack_frame(env, &sp, 2, oldsr, 0, retaddr);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ecb89e4239..c0edaa533c 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -115,7 +115,6 @@ typedef struct DisasContext {
     int is_jmp;
     CCOp cc_op; /* Current CC operation */
     int cc_op_synced;
-    int user;
     struct TranslationBlock *tb;
     int singlestep_enabled;
     TCGv_i64 mactmp;
@@ -178,7 +177,11 @@ static void do_writebacks(DisasContext *s)
 #if defined(CONFIG_USER_ONLY)
 #define IS_USER(s) 1
 #else
-#define IS_USER(s) s->user
+#define IS_USER(s)   (!(s->tb->flags & TB_FLAGS_MSR_S))
+#define SFC_INDEX(s) ((s->tb->flags & TB_FLAGS_SFC_S) ? \
+                      MMU_KERNEL_IDX : MMU_USER_IDX)
+#define DFC_INDEX(s) ((s->tb->flags & TB_FLAGS_DFC_S) ? \
+                      MMU_KERNEL_IDX : MMU_USER_IDX)
 #endif
 
 typedef void (*disas_proc)(CPUM68KState *env, DisasContext *s, uint16_t insn);
@@ -4453,6 +4456,64 @@ DISAS_INSN(move_from_sr)
 }
 
 #if defined(CONFIG_SOFTMMU)
+DISAS_INSN(moves)
+{
+    int opsize;
+    uint16_t ext;
+    TCGv reg;
+    TCGv addr;
+    int extend;
+
+    if (IS_USER(s)) {
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        return;
+    }
+
+    ext = read_im16(env, s);
+
+    opsize = insn_opsize(insn);
+
+    if (ext & 0x8000) {
+        /* address register */
+        reg = AREG(ext, 12);
+        extend = 1;
+    } else {
+        /* data register */
+        reg = DREG(ext, 12);
+        extend = 0;
+    }
+
+    addr = gen_lea(env, s, insn, opsize);
+    if (IS_NULL_QREG(addr)) {
+        gen_addr_fault(s);
+        return;
+    }
+
+    if (ext & 0x0800) {
+        /* from reg to ea */
+        gen_store(s, opsize, addr, reg, DFC_INDEX(s));
+    } else {
+        /* from ea to reg */
+        TCGv tmp = gen_load(s, opsize, addr, 0, SFC_INDEX(s));
+        if (extend) {
+            gen_ext(reg, tmp, opsize, 1);
+        } else {
+            gen_partset_reg(opsize, reg, tmp);
+        }
+    }
+    switch (extract32(insn, 3, 3)) {
+    case 3: /* Indirect postincrement.  */
+        tcg_gen_addi_i32(AREG(insn, 0), addr,
+                         REG(insn, 0) == 7 && opsize == OS_BYTE
+                         ? 2
+                         : opsize_bytes(opsize));
+        break;
+    case 4: /* Indirect predecrememnt.  */
+        tcg_gen_mov_i32(AREG(insn, 0), addr);
+        break;
+    }
+}
+
 DISAS_INSN(move_to_sr)
 {
     if (IS_USER(s)) {
@@ -5607,6 +5668,9 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(bitop_im,  08c0, ffc0);
     INSN(arith_im,  0a80, fff8, CF_ISA_A);
     INSN(arith_im,  0a00, ff00, M68000);
+#if defined(CONFIG_SOFTMMU)
+    INSN(moves,     0e00, ff00, M68000);
+#endif
     INSN(cas,       0ac0, ffc0, CAS);
     INSN(cas,       0cc0, ffc0, CAS);
     INSN(cas,       0ec0, ffc0, CAS);
@@ -5828,7 +5892,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     dc->cc_op = CC_OP_DYNAMIC;
     dc->cc_op_synced = 1;
     dc->singlestep_enabled = cs->singlestep_enabled;
-    dc->user = (env->sr & SR_S) == 0;
     dc->done_mac = 0;
     dc->writeback_mask = 0;
     num_insns = 0;
@@ -5987,6 +6050,7 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                env->current_sp == M68K_USP ? "->" : "  ", env->sp[M68K_USP],
                env->current_sp == M68K_ISP ? "->" : "  ", env->sp[M68K_ISP]);
     cpu_fprintf(f, "VBR = 0x%08x\n", env->vbr);
+    cpu_fprintf(f, "SFC = %x DFC %x\n", env->sfc, env->dfc);
     cpu_fprintf(f, "SSW %08x TCR %08x URP %08x SRP %08x\n",
                 env->mmu.ssw, env->mmu.tcr, env->mmu.urp, env->mmu.srp);
     cpu_fprintf(f, "DTTR0/1: %08x/%08x ITTR0/1: %08x/%08x\n",
-- 
2.14.3
