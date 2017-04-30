Received: from eggs.gnu.org ([2001:4830:134:3::10]:60466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3c-00025f-Fr
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3Y-0006dX-Fn
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:12 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d4y3Y-0006bn-6u
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:08 -0400
Received: by mail-pf0-x244.google.com with SMTP id g23so25781588pfj.1
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 16:15:08 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  1 May 2017 08:14:21 +0900
Message-Id: <954c36a45feb9e2a8fac76ef2866b734d8eac91f.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
Subject: [Qemu-devel] [PULL 07/11] target/openrisc: implement shadow
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: QEMU Development <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

Shadow registers are part of the openrisc spec along with sr[cid], as
part of the fast context switching feature.  When exceptions occur,
instead of having to save registers to the stack if enabled the CID will
increment and a new set of registers will be available.

This patch only implements shadow registers which can be used as extra
scratch registers via the mfspr and mtspr if required.  This is
implemented in a way where it would be easy to add on the fast context
switching, currently cid is hardcoded to 0.

This is need for openrisc linux smp kernels to boot correctly.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 linux-user/elfload.c                |  2 +-
 linux-user/main.c                   | 18 +++++++++---------
 linux-user/openrisc/target_cpu.h    |  6 +++---
 linux-user/openrisc/target_signal.h |  2 +-
 linux-user/signal.c                 | 16 ++++++++--------
 target/openrisc/cpu.c               |  4 +++-
 target/openrisc/cpu.h               | 15 +++++++++++++--
 target/openrisc/gdbstub.c           |  4 ++--
 target/openrisc/machine.c           |  6 +++---
 target/openrisc/sys_helper.c        |  9 +++++++++
 target/openrisc/translate.c         |  5 +++--
 11 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f520d77..ce77317 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1052,7 +1052,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
     int i;
 
     for (i = 0; i < 32; i++) {
-        (*regs)[i] = tswapreg(env->gpr[i]);
+        (*regs)[i] = tswapreg(cpu_get_gpr(env, i));
     }
     (*regs)[32] = tswapreg(env->pc);
     (*regs)[33] = tswapreg(cpu_get_sr(env));
diff --git a/linux-user/main.c b/linux-user/main.c
index 10a3bb3..79d621b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -2590,17 +2590,17 @@ void cpu_loop(CPUOpenRISCState *env)
         case EXCP_SYSCALL:
             env->pc += 4;   /* 0xc00; */
             ret = do_syscall(env,
-                             env->gpr[11], /* return value       */
-                             env->gpr[3],  /* r3 - r7 are params */
-                             env->gpr[4],
-                             env->gpr[5],
-                             env->gpr[6],
-                             env->gpr[7],
-                             env->gpr[8], 0, 0);
+                             cpu_get_gpr(env, 11), /* return value       */
+                             cpu_get_gpr(env, 3),  /* r3 - r7 are params */
+                             cpu_get_gpr(env, 4),
+                             cpu_get_gpr(env, 5),
+                             cpu_get_gpr(env, 6),
+                             cpu_get_gpr(env, 7),
+                             cpu_get_gpr(env, 8), 0, 0);
             if (ret == -TARGET_ERESTARTSYS) {
                 env->pc -= 4;
             } else if (ret != -TARGET_QEMU_ESIGRETURN) {
-                env->gpr[11] = ret;
+                cpu_set_gpr(env, 11, ret);
             }
             break;
         case EXCP_DPF:
@@ -4765,7 +4765,7 @@ int main(int argc, char **argv, char **envp)
         int i;
 
         for (i = 0; i < 32; i++) {
-            env->gpr[i] = regs->gpr[i];
+            cpu_set_gpr(env, i, regs->gpr[i]);
         }
         env->pc = regs->pc;
         cpu_set_sr(env, regs->sr);
diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
index f283d96..606ad6f 100644
--- a/linux-user/openrisc/target_cpu.h
+++ b/linux-user/openrisc/target_cpu.h
@@ -23,14 +23,14 @@
 static inline void cpu_clone_regs(CPUOpenRISCState *env, target_ulong newsp)
 {
     if (newsp) {
-        env->gpr[1] = newsp;
+        cpu_set_gpr(env, 1, newsp);
     }
-    env->gpr[11] = 0;
+    cpu_set_gpr(env, 11, 0);
 }
 
 static inline void cpu_set_tls(CPUOpenRISCState *env, target_ulong newtls)
 {
-    env->gpr[10] = newtls;
+    cpu_set_gpr(env, 10, newtls);
 }
 
 #endif
diff --git a/linux-user/openrisc/target_signal.h b/linux-user/openrisc/target_signal.h
index 9f2c493..95a733e 100644
--- a/linux-user/openrisc/target_signal.h
+++ b/linux-user/openrisc/target_signal.h
@@ -20,7 +20,7 @@ typedef struct target_sigaltstack {
 
 static inline abi_ulong get_sp_from_cpustate(CPUOpenRISCState *state)
 {
-    return state->gpr[1];
+    return cpu_get_gpr(state, 1);
 }
 
 
diff --git a/linux-user/signal.c b/linux-user/signal.c
index a67db04..eb6cb9f 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -4411,7 +4411,7 @@ static void setup_sigcontext(struct target_sigcontext *sc,
                              CPUOpenRISCState *regs,
                              unsigned long mask)
 {
-    unsigned long usp = regs->gpr[1];
+    unsigned long usp = cpu_get_gpr(regs, 1);
 
     /* copy the regs. they are first in sc so we can use sc directly */
 
@@ -4436,7 +4436,7 @@ static inline abi_ulong get_sigframe(struct target_sigaction *ka,
                                      CPUOpenRISCState *regs,
                                      size_t frame_size)
 {
-    unsigned long sp = regs->gpr[1];
+    unsigned long sp = cpu_get_gpr(regs, 1);
     int onsigstack = on_sig_stack(sp);
 
     /* redzone */
@@ -4489,7 +4489,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     __put_user(0, &frame->uc.tuc_link);
     __put_user(target_sigaltstack_used.ss_sp,
                &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(env->gpr[1]), &frame->uc.tuc_stack.ss_flags);
+    __put_user(sas_ss_flags(cpu_get_gpr(env, 1)), &frame->uc.tuc_stack.ss_flags);
     __put_user(target_sigaltstack_used.ss_size,
                &frame->uc.tuc_stack.ss_size);
     setup_sigcontext(&frame->sc, env, set->sig[0]);
@@ -4512,13 +4512,13 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     /* Set up registers for signal handler */
     env->pc = (unsigned long)ka->_sa_handler; /* what we enter NOW */
-    env->gpr[9] = (unsigned long)return_ip;     /* what we enter LATER */
-    env->gpr[3] = (unsigned long)sig;           /* arg 1: signo */
-    env->gpr[4] = (unsigned long)&frame->info;  /* arg 2: (siginfo_t*) */
-    env->gpr[5] = (unsigned long)&frame->uc;    /* arg 3: ucontext */
+    cpu_set_gpr(env, 9, (unsigned long)return_ip);     /* what we enter LATER */
+    cpu_set_gpr(env, 3, (unsigned long)sig);           /* arg 1: signo */
+    cpu_set_gpr(env, 4, (unsigned long)&frame->info);  /* arg 2: (siginfo_t*) */
+    cpu_set_gpr(env, 5, (unsigned long)&frame->uc);    /* arg 3: ucontext */
 
     /* actually move the usp to reflect the stacked frame */
-    env->gpr[1] = (unsigned long)frame;
+    cpu_set_gpr(env, 1, (unsigned long)frame);
 
     return;
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 1524ed9..6c1ed07 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -52,7 +52,7 @@ static void openrisc_cpu_reset(CPUState *s)
     s->exception_index = -1;
 
     cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP;
-    cpu->env.cpucfgr = CPUCFGR_OB32S | CPUCFGR_OF32S;
+    cpu->env.cpucfgr = CPUCFGR_OB32S | CPUCFGR_OF32S | CPUCFGR_NSGF;
     cpu->env.dmmucfgr = (DMMUCFGR_NTW & (0 << 2)) | (DMMUCFGR_NTS & (6 << 2));
     cpu->env.immucfgr = (IMMUCFGR_NTW & (0 << 2)) | (IMMUCFGR_NTS & (6 << 2));
 
@@ -132,6 +132,7 @@ static void or1200_initfn(Object *obj)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
+    set_feature(cpu, OPENRISC_FEATURE_NSGF);
     set_feature(cpu, OPENRISC_FEATURE_OB32S);
     set_feature(cpu, OPENRISC_FEATURE_OF32S);
     set_feature(cpu, OPENRISC_FEATURE_EVBAR);
@@ -141,6 +142,7 @@ static void openrisc_any_initfn(Object *obj)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
+    set_feature(cpu, OPENRISC_FEATURE_NSGF);
     set_feature(cpu, OPENRISC_FEATURE_OB32S);
     set_feature(cpu, OPENRISC_FEATURE_EVBAR);
 }
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 1958b72..e159b22 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -275,7 +275,8 @@ typedef struct CPUOpenRISCTLBContext {
 #endif
 
 typedef struct CPUOpenRISCState {
-    target_ulong gpr[32];     /* General registers */
+    target_ulong shadow_gpr[16][32]; /* Shadow registers */
+
     target_ulong pc;          /* Program counter */
     target_ulong ppc;         /* Prev PC */
     target_ulong jmp_pc;      /* Jump PC */
@@ -399,6 +400,16 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
 #define TB_FLAGS_R0_0  2
 #define TB_FLAGS_OVE   SR_OVE
 
+static inline uint32_t cpu_get_gpr(const CPUOpenRISCState *env, int i)
+{
+    return env->shadow_gpr[0][i];
+}
+
+static inline void cpu_set_gpr(CPUOpenRISCState *env, int i, uint32_t val)
+{
+    env->shadow_gpr[0][i] = val;
+}
+
 static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env,
                                         target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
@@ -406,7 +417,7 @@ static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env,
     *pc = env->pc;
     *cs_base = 0;
     *flags = (env->dflag
-              | (env->gpr[0] == 0 ? TB_FLAGS_R0_0 : 0)
+              | (cpu_get_gpr(env, 0) == 0 ? TB_FLAGS_R0_0 : 0)
               | (env->sr & SR_OVE));
 }
 
diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index b18c7e9..f9af650 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -28,7 +28,7 @@ int openrisc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUOpenRISCState *env = &cpu->env;
 
     if (n < 32) {
-        return gdb_get_reg32(mem_buf, env->gpr[n]);
+        return gdb_get_reg32(mem_buf, cpu_get_gpr(env, n));
     } else {
         switch (n) {
         case 32:    /* PPC */
@@ -61,7 +61,7 @@ int openrisc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     tmp = ldl_p(mem_buf);
 
     if (n < 32) {
-        env->gpr[n] = tmp;
+        cpu_set_gpr(env, n, tmp);
     } else {
         switch (n) {
         case 32: /* PPC */
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 686eaa3..2bf71c3 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -47,10 +47,10 @@ static const VMStateInfo vmstate_sr = {
 
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 4,
-    .minimum_version_id = 4,
+    .version_id = 5,
+    .minimum_version_id = 5,
     .fields = (VMStateField[]) {
-        VMSTATE_UINTTL_ARRAY(gpr, CPUOpenRISCState, 32),
+        VMSTATE_UINTTL_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
         VMSTATE_UINTTL(pc, CPUOpenRISCState),
         VMSTATE_UINTTL(ppc, CPUOpenRISCState),
         VMSTATE_UINTTL(jmp_pc, CPUOpenRISCState),
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index e13666b..fa3d6a4 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -92,6 +92,11 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
     case TO_SPR(0, 64): /* ESR */
         env->esr = rb;
         break;
+
+    case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
+        idx = (spr - 1024);
+        env->shadow_gpr[idx / 32][idx % 32] = rb;
+
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
         if (!(rb & 1)) {
@@ -239,6 +244,10 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
     case TO_SPR(0, 129): /* NUMCORES */
         return 1;
 
+    case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
+        idx = (spr - 1024);
+        return env->shadow_gpr[idx / 32][idx % 32];
+
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
         return env->tlb->dtlb[0][idx].mr;
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7c4cbf2..e49518e 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -107,7 +107,8 @@ void openrisc_translate_init(void)
                                      "mac");
     for (i = 0; i < 32; i++) {
         cpu_R[i] = tcg_global_mem_new(cpu_env,
-                                      offsetof(CPUOpenRISCState, gpr[i]),
+                                      offsetof(CPUOpenRISCState,
+                                               shadow_gpr[0][i]),
                                       regnames[i]);
     }
     cpu_R0 = cpu_R[0];
@@ -1662,7 +1663,7 @@ void openrisc_cpu_dump_state(CPUState *cs, FILE *f,
 
     cpu_fprintf(f, "PC=%08x\n", env->pc);
     for (i = 0; i < 32; ++i) {
-        cpu_fprintf(f, "R%02d=%08x%c", i, env->gpr[i],
+        cpu_fprintf(f, "R%02d=%08x%c", i, cpu_get_gpr(env, i),
                     (i % 4) == 3 ? '\n' : ' ');
     }
 }
-- 
2.9.3
