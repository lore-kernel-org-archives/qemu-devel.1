Received: from eggs.gnu.org ([2001:4830:134:3::10]:38273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgjF-0002gT-0u
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgjD-00080p-N5
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:53:09 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbgjD-00080f-Dv
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:53:07 -0500
Received: by mail-pg0-x242.google.com with SMTP id v184so16785648pgv.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 20:53:07 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  8 Feb 2017 20:51:53 -0800
Message-Id: <20170209045154.16868-22-rth@twiddle.net>
In-Reply-To: <20170209045154.16868-1-rth@twiddle.net>
References: <20170209045154.16868-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 21/22] target/openrisc: Tidy ppc/npc
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

The NPC SPR is really only supposed to be used for FPGA debugging.
It contains the same contents as PC, unless one plays games.  Follow
the or1ksim implementation in flushing delayed branch state when it
is changed.

The PPC SPR need not be updated every instruction, merely when we
exit the TB or attempt to read its contents.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/cpu.h              |  2 +-
 target/openrisc/gdbstub.c          | 13 +++++++----
 target/openrisc/interrupt_helper.c |  1 -
 target/openrisc/machine.c          |  5 ++---
 target/openrisc/sys_helper.c       | 44 ++++++++++++++------------------------
 target/openrisc/translate.c        | 29 ++++++++++---------------
 6 files changed, 39 insertions(+), 55 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 6426e32..b3d43e1 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -58,6 +58,7 @@ typedef struct OpenRISCCPUClass {
 } OpenRISCCPUClass;
 
 #define NB_MMU_MODES    3
+#define TARGET_INSN_START_EXTRA_WORDS 1
 
 enum {
     MMU_NOMMU_IDX = 0,
@@ -273,7 +274,6 @@ typedef struct CPUOpenRISCTLBContext {
 typedef struct CPUOpenRISCState {
     target_ulong gpr[32];     /* General registers */
     target_ulong pc;          /* Program counter */
-    target_ulong npc;         /* Next PC */
     target_ulong ppc;         /* Prev PC */
     target_ulong jmp_pc;      /* Jump PC */
 
diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index 31ea013..2a4821f 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -34,8 +34,8 @@ int openrisc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         case 32:    /* PPC */
             return gdb_get_reg32(mem_buf, env->ppc);
 
-        case 33:    /* NPC */
-            return gdb_get_reg32(mem_buf, env->npc);
+        case 33:    /* NPC (equals PC) */
+            return gdb_get_reg32(mem_buf, env->pc);
 
         case 34:    /* SR */
             return gdb_get_reg32(mem_buf, cpu_get_sr(env));
@@ -68,8 +68,13 @@ int openrisc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             env->ppc = tmp;
             break;
 
-        case 33: /* NPC */
-            env->npc = tmp;
+        case 33: /* NPC (equals PC) */
+            /* If setting PC to something different,
+               also clear delayed branch status.  */
+            if (env->pc != tmp) {
+                env->pc = tmp;
+                env->flags = 0;
+            }
             break;
 
         case 34: /* SR */
diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
index c7fa97a..56620e0 100644
--- a/target/openrisc/interrupt_helper.c
+++ b/target/openrisc/interrupt_helper.c
@@ -32,7 +32,6 @@ void HELPER(rfe)(CPUOpenRISCState *env)
                          (cpu->env.esr & (SR_SM | SR_IME | SR_DME));
 #endif
     cpu->env.pc = cpu->env.epcr;
-    cpu->env.npc = cpu->env.epcr;
     cpu_set_sr(&cpu->env, cpu->env.esr);
     cpu->env.lock_addr = -1;
 
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 4100957..686eaa3 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -47,12 +47,11 @@ static const VMStateInfo vmstate_sr = {
 
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .fields = (VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(gpr, CPUOpenRISCState, 32),
         VMSTATE_UINTTL(pc, CPUOpenRISCState),
-        VMSTATE_UINTTL(npc, CPUOpenRISCState),
         VMSTATE_UINTTL(ppc, CPUOpenRISCState),
         VMSTATE_UINTTL(jmp_pc, CPUOpenRISCState),
         VMSTATE_UINTTL(lock_addr, CPUOpenRISCState),
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 9841a5b..0968901 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -29,11 +29,10 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
                    target_ulong ra, target_ulong rb, target_ulong offset)
 {
 #ifndef CONFIG_USER_ONLY
-    int spr = (ra | offset);
-    int idx;
-
     OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
+    int spr = (ra | offset);
+    int idx;
 
     switch (spr) {
     case TO_SPR(0, 0): /* VR */
@@ -41,7 +40,14 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
         break;
 
     case TO_SPR(0, 16): /* NPC */
-        env->npc = rb;
+        cpu_restore_state(cs, GETPC());
+        /* ??? Mirror or1ksim in not trashing delayed branch state
+           when "jumping" to the current instruction.  */
+        if (env->pc != rb) {
+            env->pc = rb;
+            env->flags = 0;
+            cpu_loop_exit(cs);
+        }
         break;
 
     case TO_SPR(0, 17): /* SR */
@@ -170,7 +176,6 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
         cpu_openrisc_timer_update(cpu);
         break;
     default:
-
         break;
     }
 #endif
@@ -180,11 +185,11 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
                            target_ulong rd, target_ulong ra, uint32_t offset)
 {
 #ifndef CONFIG_USER_ONLY
+    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
     int spr = (ra | offset);
     int idx;
 
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-
     switch (spr) {
     case TO_SPR(0, 0): /* VR */
         return env->vr & SPR_VR;
@@ -201,13 +206,15 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
     case TO_SPR(0, 4): /* IMMUCFGR */
         return env->immucfgr;
 
-    case TO_SPR(0, 16): /* NPC */
-        return env->npc;
+    case TO_SPR(0, 16): /* NPC (equals PC) */
+        cpu_restore_state(cs, GETPC());
+        return env->pc;
 
     case TO_SPR(0, 17): /* SR */
         return cpu_get_sr(env);
 
     case TO_SPR(0, 18): /* PPC */
+        cpu_restore_state(cs, GETPC());
         return env->ppc;
 
     case TO_SPR(0, 32): /* EPCR */
@@ -276,25 +283,6 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
     }
 #endif
 
-/*If we later need to add tracepoints (or debug printfs) for the return
-value, it may be useful to structure the code like this:
-
-target_ulong ret = 0;
-
-switch() {
-case x:
- ret = y;
- break;
-case z:
- ret = 42;
- break;
-...
-}
-
-later something like trace_spr_read(ret);
-
-return ret;*/
-
     /* for rd is passed in, if rd unchanged, just keep it back.  */
     return rd;
 }
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index cda84b6..10f0633 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -39,7 +39,7 @@
 
 typedef struct DisasContext {
     TranslationBlock *tb;
-    target_ulong pc, ppc, npc;
+    target_ulong pc;
     uint32_t tb_flags, synced_flags, flags;
     uint32_t is_jmp;
     uint32_t mem_idx;
@@ -52,7 +52,6 @@ static TCGv cpu_sr;
 static TCGv cpu_R[32];
 static TCGv cpu_pc;
 static TCGv jmp_pc;            /* l.jr/l.jalr temp pc */
-static TCGv cpu_npc;
 static TCGv cpu_ppc;
 static TCGv cpu_sr_f;           /* bf/bnf, F flag taken */
 static TCGv cpu_sr_cy;          /* carry (unsigned overflow) */
@@ -83,8 +82,6 @@ void openrisc_translate_init(void)
                                        "flags");
     cpu_pc = tcg_global_mem_new(cpu_env,
                                 offsetof(CPUOpenRISCState, pc), "pc");
-    cpu_npc = tcg_global_mem_new(cpu_env,
-                                 offsetof(CPUOpenRISCState, npc), "npc");
     cpu_ppc = tcg_global_mem_new(cpu_env,
                                  offsetof(CPUOpenRISCState, ppc), "ppc");
     jmp_pc = tcg_global_mem_new(cpu_env,
@@ -1514,7 +1511,6 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
     dc->tb = tb;
 
     dc->is_jmp = DISAS_NEXT;
-    dc->ppc = pc_start;
     dc->pc = pc_start;
     dc->flags = cpu->env.cpucfgr;
     dc->mem_idx = cpu_mmu_index(&cpu->env, false);
@@ -1543,7 +1539,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
     gen_tb_start(tb);
 
     do {
-        tcg_gen_insn_start(dc->pc);
+        tcg_gen_insn_start(dc->pc, num_insns != 0);
         num_insns++;
 
         if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
@@ -1561,12 +1557,9 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
             gen_io_start();
         }
-        dc->ppc = dc->pc - 4;
-        dc->npc = dc->pc + 4;
-        tcg_gen_movi_tl(cpu_ppc, dc->ppc);
-        tcg_gen_movi_tl(cpu_npc, dc->npc);
         disas_openrisc_insn(dc, cpu);
-        dc->pc = dc->npc;
+        dc->pc = dc->pc + 4;
+
         /* delay slot */
         if (dc->delayed_branch) {
             dc->delayed_branch--;
@@ -1574,10 +1567,8 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
                 dc->tb_flags &= ~D_FLAG;
                 gen_sync_flags(dc);
                 tcg_gen_mov_tl(cpu_pc, jmp_pc);
-                tcg_gen_mov_tl(cpu_npc, jmp_pc);
-                tcg_gen_movi_tl(jmp_pc, 0);
-                tcg_gen_exit_tb(0);
-                dc->is_jmp = DISAS_JUMP;
+                tcg_gen_discard_tl(jmp_pc);
+                dc->is_jmp = DISAS_UPDATE;
                 break;
             }
         }
@@ -1591,14 +1582,13 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
     if (tb->cflags & CF_LAST_IO) {
         gen_io_end();
     }
+
+    tcg_gen_movi_tl(cpu_ppc, dc->pc - 4);
     if (dc->is_jmp == DISAS_NEXT) {
         dc->is_jmp = DISAS_UPDATE;
         tcg_gen_movi_tl(cpu_pc, dc->pc);
     }
     if (unlikely(cs->singlestep_enabled)) {
-        if (dc->is_jmp == DISAS_NEXT) {
-            tcg_gen_movi_tl(cpu_pc, dc->pc);
-        }
         gen_exception(dc, EXCP_DEBUG);
     } else {
         switch (dc->is_jmp) {
@@ -1651,4 +1641,7 @@ void restore_state_to_opc(CPUOpenRISCState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
     env->pc = data[0];
+    if (data[1]) {
+        env->ppc = env->pc - 4;
+    }
 }
-- 
2.9.3
