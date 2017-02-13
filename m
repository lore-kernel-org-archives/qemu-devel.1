Received: from eggs.gnu.org ([2001:4830:134:3::10]:45388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8h-0004rZ-DP
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8e-0001Ro-Qw
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:27 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8e-0001RT-Lo
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:24 -0500
Received: by mail-qt0-x241.google.com with SMTP id w20so14930709qtb.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:24 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:24 +1100
Message-Id: <20170213212536.31871-13-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 12/24] target/openrisc: Keep SR_F in a separate
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This avoids having to keep merging and extracting the flag from SR.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/elfload.c               |   3 +-
 linux-user/main.c                  |   3 +-
 target/openrisc/cpu.h              |  15 +++++-
 target/openrisc/gdbstub.c          |   4 +-
 target/openrisc/interrupt.c        |   2 +-
 target/openrisc/interrupt_helper.c |   2 +-
 target/openrisc/machine.c          |  38 +++++++++++++-
 target/openrisc/sys_helper.c       |   5 +-
 target/openrisc/translate.c        | 104 ++++++++++++++-----------------------
 9 files changed, 98 insertions(+), 78 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c66cbbe..8271227 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1054,9 +1054,8 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
     for (i = 0; i < 32; i++) {
         (*regs)[i] = tswapreg(env->gpr[i]);
     }
-
     (*regs)[32] = tswapreg(env->pc);
-    (*regs)[33] = tswapreg(env->sr);
+    (*regs)[33] = tswapreg(cpu_get_sr(env));
 }
 #define ELF_HWCAP 0
 #define ELF_PLATFORM NULL
diff --git a/linux-user/main.c b/linux-user/main.c
index 001f71c..4fd49ce 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4765,9 +4765,8 @@ int main(int argc, char **argv, char **envp)
         for (i = 0; i < 32; i++) {
             env->gpr[i] = regs->gpr[i];
         }
-
-        env->sr = regs->sr;
         env->pc = regs->pc;
+        cpu_set_sr(env, regs->sr);
     }
 #elif defined(TARGET_SH4)
     {
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index ef90e49..bb5d363 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -286,7 +286,8 @@ typedef struct CPUOpenRISCState {
     target_ulong epcr;        /* Exception PC register */
     target_ulong eear;        /* Exception EA register */
 
-    uint32_t sr;              /* Supervisor register */
+    target_ulong sr_f;        /* the SR_F bit, values 0, 1.  */
+    uint32_t sr;              /* Supervisor register, without SR_F */
     uint32_t vr;              /* Version register */
     uint32_t upr;             /* Unit presence register */
     uint32_t cpucfgr;         /* CPU configure register */
@@ -301,7 +302,6 @@ typedef struct CPUOpenRISCState {
 
     uint32_t flags;           /* cpu_flags, we only use it for exception
                                  in solt so far.  */
-    uint32_t btaken;          /* the SR_F bit */
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
@@ -412,6 +412,17 @@ static inline int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
     return (env->sr & SR_SM) == 0 ? MMU_USER_IDX : MMU_SUPERVISOR_IDX;
 }
 
+static inline uint32_t cpu_get_sr(const CPUOpenRISCState *env)
+{
+    return env->sr + env->sr_f * SR_F;
+}
+
+static inline void cpu_set_sr(CPUOpenRISCState *env, uint32_t val)
+{
+    env->sr_f = (val & SR_F) != 0;
+    env->sr = (val & ~SR_F) | SR_FO;
+}
+
 #define CPU_INTERRUPT_TIMER   CPU_INTERRUPT_TGT_INT_0
 
 #endif /* OPENRISC_CPU_H */
diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index cb16e76..31ea013 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -38,7 +38,7 @@ int openrisc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
             return gdb_get_reg32(mem_buf, env->npc);
 
         case 34:    /* SR */
-            return gdb_get_reg32(mem_buf, env->sr);
+            return gdb_get_reg32(mem_buf, cpu_get_sr(env));
 
         default:
             break;
@@ -73,7 +73,7 @@ int openrisc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             break;
 
         case 34: /* SR */
-            env->sr = tmp;
+            cpu_set_sr(env, tmp);
             break;
 
         default:
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index a981638..042506f 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -54,7 +54,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
        we need flush TLB when we enter&exit EXCP.  */
     tlb_flush(cs);
 
-    env->esr = env->sr;
+    env->esr = cpu_get_sr(env);
     env->sr &= ~SR_DME;
     env->sr &= ~SR_IME;
     env->sr |= SR_SM;
diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
index a6d4df3..c7fa97a 100644
--- a/target/openrisc/interrupt_helper.c
+++ b/target/openrisc/interrupt_helper.c
@@ -33,7 +33,7 @@ void HELPER(rfe)(CPUOpenRISCState *env)
 #endif
     cpu->env.pc = cpu->env.epcr;
     cpu->env.npc = cpu->env.epcr;
-    cpu->env.sr = cpu->env.esr;
+    cpu_set_sr(&cpu->env, cpu->env.esr);
     cpu->env.lock_addr = -1;
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index d0b47ef..b723138 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -24,6 +24,27 @@
 #include "hw/boards.h"
 #include "migration/cpu.h"
 
+static int get_sr(QEMUFile *f, void *opaque, size_t size, VMStateField *field)
+{
+    CPUOpenRISCState *env = opaque;
+    cpu_set_sr(env, qemu_get_be32(f));
+    return 0;
+}
+
+static int put_sr(QEMUFile *f, void *opaque, size_t size,
+                  VMStateField *field, QJSON *vmdesc)
+{
+    CPUOpenRISCState *env = opaque;
+    qemu_put_be32(f, cpu_get_sr(env));
+    return 0;
+}
+
+static const VMStateInfo vmstate_sr = {
+    .name = "sr",
+    .get = get_sr,
+    .put = put_sr,
+};
+
 static const VMStateDescription vmstate_env = {
     .name = "env",
     .version_id = 2,
@@ -38,7 +59,22 @@ static const VMStateDescription vmstate_env = {
         VMSTATE_UINTTL(lock_value, CPUOpenRISCState),
         VMSTATE_UINTTL(epcr, CPUOpenRISCState),
         VMSTATE_UINTTL(eear, CPUOpenRISCState),
-        VMSTATE_UINT32(sr, CPUOpenRISCState),
+
+        /* Save the architecture value of the SR, not the internally
+           expanded version.  Since this architecture value does not
+           exist in memory to be stored, this requires a but of hoop
+           jumping.  We want OFFSET=0 so that we effectively pass ENV
+           to the helper functions, and we need to fill in the name by
+           hand since there's no field of that name.  */
+        {
+            .name = "sr",
+            .version_id = 0,
+            .size = sizeof(uint32_t),
+            .info = &vmstate_sr,
+            .flags = VMS_SINGLE,
+            .offset = 0
+        },
+
         VMSTATE_UINT32(vr, CPUOpenRISCState),
         VMSTATE_UINT32(upr, CPUOpenRISCState),
         VMSTATE_UINT32(cpucfgr, CPUOpenRISCState),
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index daea902..4a59728 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -49,8 +49,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
             (rb & (SR_IME | SR_DME | SR_SM))) {
             tlb_flush(cs);
         }
-        env->sr = rb;
-        env->sr |= SR_FO;      /* FO is const equal to 1 */
+        cpu_set_sr(env, rb);
         if (env->sr & SR_DME) {
             env->tlb->cpu_openrisc_map_address_data =
                 &cpu_openrisc_get_phys_data;
@@ -200,7 +199,7 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
         return env->npc;
 
     case TO_SPR(0, 17): /* SR */
-        return env->sr;
+        return cpu_get_sr(env);
 
     case TO_SPR(0, 18): /* PPC */
         return env->ppc;
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 1f3f22c..405a1a0 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -54,7 +54,7 @@ static TCGv cpu_pc;
 static TCGv jmp_pc;            /* l.jr/l.jalr temp pc */
 static TCGv cpu_npc;
 static TCGv cpu_ppc;
-static TCGv_i32 env_btaken;    /* bf/bnf , F flag taken */
+static TCGv cpu_sr_f;           /* bf/bnf, F flag taken */
 static TCGv cpu_lock_addr;
 static TCGv cpu_lock_value;
 static TCGv_i32 fpcsr;
@@ -88,9 +88,8 @@ void openrisc_translate_init(void)
                                  offsetof(CPUOpenRISCState, ppc), "ppc");
     jmp_pc = tcg_global_mem_new(cpu_env,
                                 offsetof(CPUOpenRISCState, jmp_pc), "jmp_pc");
-    env_btaken = tcg_global_mem_new_i32(cpu_env,
-                                        offsetof(CPUOpenRISCState, btaken),
-                                        "btaken");
+    cpu_sr_f = tcg_global_mem_new(cpu_env,
+                                  offsetof(CPUOpenRISCState, sr_f), "sr_f");
     cpu_lock_addr = tcg_global_mem_new(cpu_env,
                                        offsetof(CPUOpenRISCState, lock_addr),
                                        "lock_addr");
@@ -119,16 +118,6 @@ void openrisc_translate_init(void)
     }
 }
 
-/* Writeback SR_F translation space to execution space.  */
-static inline void wb_SR_F(void)
-{
-    TCGLabel *label = gen_new_label();
-    tcg_gen_andi_tl(cpu_sr, cpu_sr, ~SR_F);
-    tcg_gen_brcondi_tl(TCG_COND_EQ, env_btaken, 0, label);
-    tcg_gen_ori_tl(cpu_sr, cpu_sr, SR_F);
-    gen_set_label(label);
-}
-
 static inline void gen_sync_flags(DisasContext *dc)
 {
     /* Sync the tb dependent flag between translate and runtime.  */
@@ -220,14 +209,11 @@ static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
     case 0x04:     /* l.bf  */
         {
             TCGLabel *lab = gen_new_label();
-            TCGv sr_f = tcg_temp_new();
             tcg_gen_movi_tl(jmp_pc, dc->pc+8);
-            tcg_gen_andi_tl(sr_f, cpu_sr, SR_F);
-            tcg_gen_brcondi_i32(op0 == 0x03 ? TCG_COND_EQ : TCG_COND_NE,
-                                sr_f, SR_F, lab);
+            tcg_gen_brcondi_tl(op0 == 0x03 ? TCG_COND_NE : TCG_COND_EQ,
+                               cpu_sr_f, 0, lab);
             tcg_gen_movi_tl(jmp_pc, tmp_pc);
             gen_set_label(lab);
-            tcg_temp_free(sr_f);
         }
         break;
     case 0x11:     /* l.jr */
@@ -441,17 +427,16 @@ static void gen_swa(DisasContext *dc, TCGv rb, TCGv ra, int32_t ofs)
     val = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
                               rb, dc->mem_idx, MO_TEUL);
-    tcg_gen_setcond_tl(TCG_COND_EQ, env_btaken, val, cpu_lock_value);
+    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
     tcg_temp_free(val);
 
     tcg_gen_br(lab_done);
 
     gen_set_label(lab_fail);
-    tcg_gen_movi_tl(env_btaken, 0);
+    tcg_gen_movi_tl(cpu_sr_f, 0);
 
     gen_set_label(lab_done);
     tcg_gen_movi_tl(cpu_lock_addr, -1);
-    wb_SR_F();
 }
 
 static void dec_calc(DisasContext *dc, uint32_t insn)
@@ -558,14 +543,11 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
             {
                 TCGLabel *lab = gen_new_label();
                 TCGv res = tcg_temp_local_new();
-                TCGv sr_f = tcg_temp_new();
-                tcg_gen_andi_tl(sr_f, cpu_sr, SR_F);
                 tcg_gen_mov_tl(res, cpu_R[rb]);
-                tcg_gen_brcondi_tl(TCG_COND_NE, sr_f, SR_F, lab);
+                tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_sr_f, 0, lab);
                 tcg_gen_mov_tl(res, cpu_R[ra]);
                 gen_set_label(lab);
                 tcg_gen_mov_tl(cpu_R[rd], res);
-                tcg_temp_free(sr_f);
                 tcg_temp_free(res);
             }
             return;
@@ -1046,7 +1028,6 @@ static void dec_comp(DisasContext *dc, uint32_t insn)
     ra = extract32(insn, 16, 5);
     rb = extract32(insn, 11, 5);
 
-    tcg_gen_movi_i32(env_btaken, 0x0);
     /* unsigned integers  */
     tcg_gen_ext32u_tl(cpu_R[ra], cpu_R[ra]);
     tcg_gen_ext32u_tl(cpu_R[rb], cpu_R[rb]);
@@ -1054,59 +1035,58 @@ static void dec_comp(DisasContext *dc, uint32_t insn)
     switch (op0) {
     case 0x0:    /* l.sfeq */
         LOG_DIS("l.sfeq  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_EQ, env_btaken, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x1:    /* l.sfne */
         LOG_DIS("l.sfne  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_NE, env_btaken, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_setcond_tl(TCG_COND_NE, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x2:    /* l.sfgtu */
         LOG_DIS("l.sfgtu  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_GTU, env_btaken, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_setcond_tl(TCG_COND_GTU, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x3:    /* l.sfgeu */
         LOG_DIS("l.sfgeu  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_GEU, env_btaken, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_setcond_tl(TCG_COND_GEU, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x4:    /* l.sfltu */
         LOG_DIS("l.sfltu  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_LTU, env_btaken, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_setcond_tl(TCG_COND_LTU, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x5:    /* l.sfleu */
         LOG_DIS("l.sfleu  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_LEU, env_btaken, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_setcond_tl(TCG_COND_LEU, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0xa:    /* l.sfgts */
         LOG_DIS("l.sfgts  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_GT, env_btaken, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_setcond_tl(TCG_COND_GT, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0xb:    /* l.sfges */
         LOG_DIS("l.sfges  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_GE, env_btaken, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_setcond_tl(TCG_COND_GE, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0xc:    /* l.sflts */
         LOG_DIS("l.sflts  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_LT, env_btaken, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_setcond_tl(TCG_COND_LT, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0xd:    /* l.sfles */
         LOG_DIS("l.sfles  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_LE, env_btaken, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_setcond_tl(TCG_COND_LE, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
         break;
 
     default:
         gen_illegal_exception(dc);
         break;
     }
-    wb_SR_F();
 }
 
 static void dec_compi(DisasContext *dc, uint32_t insn)
@@ -1118,64 +1098,61 @@ static void dec_compi(DisasContext *dc, uint32_t insn)
     ra = extract32(insn, 16, 5);
     I16 = sextract32(insn, 0, 16);
 
-    tcg_gen_movi_i32(env_btaken, 0x0);
-
     switch (op0) {
     case 0x0:    /* l.sfeqi */
         LOG_DIS("l.sfeqi  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_EQ, env_btaken, cpu_R[ra], I16);
+        tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_f, cpu_R[ra], I16);
         break;
 
     case 0x1:    /* l.sfnei */
         LOG_DIS("l.sfnei  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_NE, env_btaken, cpu_R[ra], I16);
+        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_sr_f, cpu_R[ra], I16);
         break;
 
     case 0x2:    /* l.sfgtui */
         LOG_DIS("l.sfgtui  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_GTU, env_btaken, cpu_R[ra], I16);
+        tcg_gen_setcondi_tl(TCG_COND_GTU, cpu_sr_f, cpu_R[ra], I16);
         break;
 
     case 0x3:    /* l.sfgeui */
         LOG_DIS("l.sfgeui  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_GEU, env_btaken, cpu_R[ra], I16);
+        tcg_gen_setcondi_tl(TCG_COND_GEU, cpu_sr_f, cpu_R[ra], I16);
         break;
 
     case 0x4:    /* l.sfltui */
         LOG_DIS("l.sfltui  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_LTU, env_btaken, cpu_R[ra], I16);
+        tcg_gen_setcondi_tl(TCG_COND_LTU, cpu_sr_f, cpu_R[ra], I16);
         break;
 
     case 0x5:    /* l.sfleui */
         LOG_DIS("l.sfleui  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_LEU, env_btaken, cpu_R[ra], I16);
+        tcg_gen_setcondi_tl(TCG_COND_LEU, cpu_sr_f, cpu_R[ra], I16);
         break;
 
     case 0xa:    /* l.sfgtsi */
         LOG_DIS("l.sfgtsi  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_GT, env_btaken, cpu_R[ra], I16);
+        tcg_gen_setcondi_tl(TCG_COND_GT, cpu_sr_f, cpu_R[ra], I16);
         break;
 
     case 0xb:    /* l.sfgesi */
         LOG_DIS("l.sfgesi  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_GE, env_btaken, cpu_R[ra], I16);
+        tcg_gen_setcondi_tl(TCG_COND_GE, cpu_sr_f, cpu_R[ra], I16);
         break;
 
     case 0xc:    /* l.sfltsi */
         LOG_DIS("l.sfltsi  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_LT, env_btaken, cpu_R[ra], I16);
+        tcg_gen_setcondi_tl(TCG_COND_LT, cpu_sr_f, cpu_R[ra], I16);
         break;
 
     case 0xd:    /* l.sflesi */
         LOG_DIS("l.sflesi  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_LE, env_btaken, cpu_R[ra], I16);
+        tcg_gen_setcondi_tl(TCG_COND_LE, cpu_sr_f, cpu_R[ra], I16);
         break;
 
     default:
         gen_illegal_exception(dc);
         break;
     }
-    wb_SR_F();
 }
 
 static void dec_sys(DisasContext *dc, uint32_t insn)
@@ -1308,32 +1285,32 @@ static void dec_float(DisasContext *dc, uint32_t insn)
 
     case 0x08:    /* lf.sfeq.s */
         LOG_DIS("lf.sfeq.s r%d, r%d\n", ra, rb);
-        gen_helper_float_eq_s(env_btaken, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_eq_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x09:    /* lf.sfne.s */
         LOG_DIS("lf.sfne.s r%d, r%d\n", ra, rb);
-        gen_helper_float_ne_s(env_btaken, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_ne_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x0a:    /* lf.sfgt.s */
         LOG_DIS("lf.sfgt.s r%d, r%d\n", ra, rb);
-        gen_helper_float_gt_s(env_btaken, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_gt_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x0b:    /* lf.sfge.s */
         LOG_DIS("lf.sfge.s r%d, r%d\n", ra, rb);
-        gen_helper_float_ge_s(env_btaken, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_ge_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x0c:    /* lf.sflt.s */
         LOG_DIS("lf.sflt.s r%d, r%d\n", ra, rb);
-        gen_helper_float_lt_s(env_btaken, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_lt_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x0d:    /* lf.sfle.s */
         LOG_DIS("lf.sfle.s r%d, r%d\n", ra, rb);
-        gen_helper_float_le_s(env_btaken, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_le_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
 /* not used yet, open it when we need or64.  */
@@ -1394,37 +1371,37 @@ static void dec_float(DisasContext *dc, uint32_t insn)
     case 0x18:     lf.sfeq.d
         LOG_DIS("lf.sfeq.d r%d, r%d\n", ra, rb);
         check_of64s(dc);
-        gen_helper_float_eq_d(env_btaken, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_eq_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x1a:     lf.sfgt.d
         LOG_DIS("lf.sfgt.d r%d, r%d\n", ra, rb);
         check_of64s(dc);
-        gen_helper_float_gt_d(env_btaken, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_gt_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x1b:     lf.sfge.d
         LOG_DIS("lf.sfge.d r%d, r%d\n", ra, rb);
         check_of64s(dc);
-        gen_helper_float_ge_d(env_btaken, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_ge_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x19:     lf.sfne.d
         LOG_DIS("lf.sfne.d r%d, r%d\n", ra, rb);
         check_of64s(dc);
-        gen_helper_float_ne_d(env_btaken, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_ne_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x1c:     lf.sflt.d
         LOG_DIS("lf.sflt.d r%d, r%d\n", ra, rb);
         check_of64s(dc);
-        gen_helper_float_lt_d(env_btaken, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_lt_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x1d:     lf.sfle.d
         LOG_DIS("lf.sfle.d r%d, r%d\n", ra, rb);
         check_of64s(dc);
-        gen_helper_float_le_d(env_btaken, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_le_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
         break;
 #endif*/
 
@@ -1432,7 +1409,6 @@ static void dec_float(DisasContext *dc, uint32_t insn)
         gen_illegal_exception(dc);
         break;
     }
-    wb_SR_F();
 }
 
 static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
-- 
2.9.3
