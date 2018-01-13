Received: from eggs.gnu.org ([2001:4830:134:3::10]:60426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eaJls-0008Qg-Ib
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 06:14:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eaJlp-0007GR-BQ
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 06:14:44 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:50239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eaJlp-0007Fn-18
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 06:14:41 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 13 Jan 2018 12:14:26 +0100
Message-Id: <20180113111428.7066-6-laurent@vivier.eu>
In-Reply-To: <20180113111428.7066-1-laurent@vivier.eu>
References: <20180113111428.7066-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3 5/7] target/m68k: add moves
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

and introduce SFC and DFC control registers.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
v2: copy bit 2 of SFC and DFC to tb->flags to
    inline memory access in moves decoder.

 target/m68k/cpu.h       | 10 ++++--
 target/m68k/helper.c    | 10 ++++++
 target/m68k/monitor.c   |  2 ++
 target/m68k/op_helper.c |  4 +--
 target/m68k/qregs.def   |  2 ++
 target/m68k/translate.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++--
 6 files changed, 109 insertions(+), 7 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 5e48103d3f..af24f061f5 100644
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
@@ -547,8 +549,12 @@ static inline void cpu_get_tb_cpu_state(CPUM68KState *env, target_ulong *pc,
 {
     *pc = env->pc;
     *cs_base = 0;
-    *flags = (env->sr & SR_S)                   /* Bit  13 */
-            | ((env->macsr >> 4) & 0xf);        /* Bits 0-3 */
+    *flags = (env->macsr >> 4) & 0xf;           /* Bits 0-3 */
+    if (env->sr & SR_S) {
+        *flags |= SR_S;                         /* Bit  13 */
+        *flags |= (env->sfc & 4) << 12;         /* Bit  14 */
+        *flags |= (env->dfc & 4) << 13;         /* Bit  15 */
+    }
 }
 
 #endif
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index f1d50e54b1..c1bd0e9681 100644
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
diff --git a/target/m68k/qregs.def b/target/m68k/qregs.def
index 1aadc622db..efe2bf90ee 100644
--- a/target/m68k/qregs.def
+++ b/target/m68k/qregs.def
@@ -1,5 +1,7 @@
 DEFO32(PC, pc)
 DEFO32(SR, sr)
+DEFO32(DFC, dfc)
+DEFO32(SFC, sfc)
 DEFO32(CC_OP, cc_op)
 DEFO32(CC_X, cc_x)
 DEFO32(CC_C, cc_c)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 00a5bce6a3..694de43106 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -48,6 +48,8 @@ static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
 static TCGv cpu_dregs[8];
 static TCGv cpu_aregs[8];
 static TCGv_i64 cpu_macc[4];
+static TCGv QEMU_DFC;
+static TCGv QEMU_SFC;
 
 #define REG(insn, pos)  (((insn) >> (pos)) & 7)
 #define DREG(insn, pos) cpu_dregs[REG(insn, pos)]
@@ -103,6 +105,10 @@ void m68k_tcg_init(void)
         p += 5;
     }
 
+    QEMU_DFC = tcg_global_mem_new(cpu_env, offsetof(CPUM68KState, dfc),
+                                  "DFC");
+    QEMU_SFC = tcg_global_mem_new(cpu_env, offsetof(CPUM68KState, sfc),
+                                  "SFC");
     NULL_QREG = tcg_global_mem_new(cpu_env, -4, "NULL");
     store_dummy = tcg_global_mem_new(cpu_env, -8, "NULL");
 }
@@ -115,7 +121,9 @@ typedef struct DisasContext {
     int is_jmp;
     CCOp cc_op; /* Current CC operation */
     int cc_op_synced;
-    int user;
+#if defined(CONFIG_SOFTMMU)
+    uint32_t user;
+#endif
     struct TranslationBlock *tb;
     int singlestep_enabled;
     TCGv_i64 mactmp;
@@ -178,7 +186,15 @@ static void do_writebacks(DisasContext *s)
 #if defined(CONFIG_USER_ONLY)
 #define IS_USER(s) 1
 #else
-#define IS_USER(s) s->user
+#define M68K_USER_FROM_MSR 0x01
+#define M68K_USER_FROM_SFC 0x02
+#define M68K_USER_FROM_DFC 0x04
+
+#define IS_USER(s)   (!!(s->user & M68K_USER_FROM_MSR))
+#define SFC_INDEX(s) ((s->user & M68K_USER_FROM_SFC) ? \
+                      MMU_USER_IDX : MMU_KERNEL_IDX)
+#define DFC_INDEX(s) ((s->user & M68K_USER_FROM_DFC) ? \
+                      MMU_USER_IDX : MMU_KERNEL_IDX)
 #endif
 
 typedef void (*disas_proc)(CPUM68KState *env, DisasContext *s, uint16_t insn);
@@ -4454,6 +4470,64 @@ DISAS_INSN(move_from_sr)
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
@@ -5608,6 +5682,9 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(bitop_im,  08c0, ffc0);
     INSN(arith_im,  0a80, fff8, CF_ISA_A);
     INSN(arith_im,  0a00, ff00, M68000);
+#if defined(CONFIG_SOFTMMU)
+    INSN(moves,     0e00, ff00, M68000);
+#endif
     INSN(cas,       0ac0, ffc0, CAS);
     INSN(cas,       0cc0, ffc0, CAS);
     INSN(cas,       0ec0, ffc0, CAS);
@@ -5829,7 +5906,11 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     dc->cc_op = CC_OP_DYNAMIC;
     dc->cc_op_synced = 1;
     dc->singlestep_enabled = cs->singlestep_enabled;
-    dc->user = (env->sr & SR_S) == 0;
+#if defined(CONFIG_SOFTMMU)
+    dc->user = (env->sr & SR_S) == 0 ? M68K_USER_FROM_MSR : 0;
+    dc->user |= (env->sfc & 4) == 0 ? M68K_USER_FROM_SFC : 0;
+    dc->user |= (env->dfc & 4) == 0 ? M68K_USER_FROM_DFC : 0;
+#endif
     dc->done_mac = 0;
     dc->writeback_mask = 0;
     num_insns = 0;
@@ -5988,6 +6069,7 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                env->current_sp == M68K_USP ? "->" : "  ", env->sp[M68K_USP],
                env->current_sp == M68K_ISP ? "->" : "  ", env->sp[M68K_ISP]);
     cpu_fprintf(f, "VBR = 0x%08x\n", env->vbr);
+    cpu_fprintf(f, "SFC = %x DFC %x\n", env->sfc, env->dfc);
     cpu_fprintf(f, "SSW %08x TCR %08x URP %08x SRP %08x\n",
                 env->mmu.ssw, env->mmu.tcr, env->mmu.urp, env->mmu.srp);
     cpu_fprintf(f, "DTTR0/1: %08x/%08x ITTR0/1: %08x/%08x\n",
-- 
2.14.3
