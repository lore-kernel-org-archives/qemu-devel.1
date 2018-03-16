Received: from eggs.gnu.org ([2001:4830:134:3::10]:56413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ewsfu-0004VN-Sm
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ewsfn-0003UT-H2
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:57:50 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:46590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ewsfm-0003Td-QC
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:57:43 -0400
Received: by mail-lf0-x242.google.com with SMTP id w16-v6so16293874lfc.13
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 09:57:42 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 16 Mar 2018 09:57:22 -0700
Message-Id: <20180316165722.26560-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v7 09/11] target/xtensa: add linux-user support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Import list of syscalls from the kernel source. Conditionalize code/data
that is only used with softmmu. Implement exception handlers. Implement
signal hander (only the core registers for now, no coprocessors or TIE).

Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v6->v7:
- fix vaddr print format from %lx to %VADDR_PRIx

Changes v1->v2:
- add definition of TARGET_TIOCGPTPEER to linux-user/xtensa/termbits.h
- Cc linux-user maintainers

 default-configs/xtensa-linux-user.mak   |   1 +
 default-configs/xtensaeb-linux-user.mak |   1 +
 linux-user/elfload.c                    |  58 +++++
 linux-user/main.c                       | 245 ++++++++++++++++++
 linux-user/signal.c                     | 256 ++++++++++++++++++-
 linux-user/syscall.c                    |   2 +
 linux-user/syscall_defs.h               |  65 ++++-
 linux-user/xtensa/syscall.h             |   0
 linux-user/xtensa/syscall_nr.h          | 437 ++++++++++++++++++++++++++++++++
 linux-user/xtensa/target_cpu.h          |  22 ++
 linux-user/xtensa/target_elf.h          |  16 ++
 linux-user/xtensa/target_signal.h       |  28 ++
 linux-user/xtensa/target_structs.h      |  28 ++
 linux-user/xtensa/target_syscall.h      |  49 ++++
 linux-user/xtensa/termbits.h            | 328 ++++++++++++++++++++++++
 target/xtensa/Makefile.objs             |   3 +-
 target/xtensa/cpu.c                     |  26 +-
 target/xtensa/cpu.h                     |  56 ++--
 target/xtensa/helper.c                  |  31 +++
 target/xtensa/helper.h                  |   4 +
 target/xtensa/op_helper.c               |  50 +++-
 target/xtensa/translate.c               |  43 +++-
 22 files changed, 1705 insertions(+), 44 deletions(-)
 create mode 100644 default-configs/xtensa-linux-user.mak
 create mode 100644 default-configs/xtensaeb-linux-user.mak
 create mode 100644 linux-user/xtensa/syscall.h
 create mode 100644 linux-user/xtensa/syscall_nr.h
 create mode 100644 linux-user/xtensa/target_cpu.h
 create mode 100644 linux-user/xtensa/target_elf.h
 create mode 100644 linux-user/xtensa/target_signal.h
 create mode 100644 linux-user/xtensa/target_structs.h
 create mode 100644 linux-user/xtensa/target_syscall.h
 create mode 100644 linux-user/xtensa/termbits.h

diff --git a/default-configs/xtensa-linux-user.mak b/default-configs/xtensa-linux-user.mak
new file mode 100644
index 000000000000..fd1d350ee944
--- /dev/null
+++ b/default-configs/xtensa-linux-user.mak
@@ -0,0 +1 @@
+# Default configuration for xtensa-linux-user
diff --git a/default-configs/xtensaeb-linux-user.mak b/default-configs/xtensaeb-linux-user.mak
new file mode 100644
index 000000000000..fd1d350ee944
--- /dev/null
+++ b/default-configs/xtensaeb-linux-user.mak
@@ -0,0 +1 @@
+# Default configuration for xtensa-linux-user
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5fc130cc20ca..fe7a5bc5663b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1341,6 +1341,64 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #endif /* TARGET_HPPA */
 
+#ifdef TARGET_XTENSA
+
+#define ELF_START_MMAP 0x20000000
+
+#define ELF_CLASS       ELFCLASS32
+#define ELF_ARCH        EM_XTENSA
+
+static inline void init_thread(struct target_pt_regs *regs,
+                               struct image_info *infop)
+{
+    regs->windowbase = 0;
+    regs->windowstart = 1;
+    regs->areg[1] = infop->start_stack;
+    regs->pc = infop->entry;
+}
+
+/* See linux kernel: arch/xtensa/include/asm/elf.h.  */
+#define ELF_NREG 128
+typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+
+enum {
+    TARGET_REG_PC,
+    TARGET_REG_PS,
+    TARGET_REG_LBEG,
+    TARGET_REG_LEND,
+    TARGET_REG_LCOUNT,
+    TARGET_REG_SAR,
+    TARGET_REG_WINDOWSTART,
+    TARGET_REG_WINDOWBASE,
+    TARGET_REG_THREADPTR,
+    TARGET_REG_AR0 = 64,
+};
+
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUXtensaState *env)
+{
+    unsigned i;
+
+    (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
+    (*regs)[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
+    (*regs)[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
+    (*regs)[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
+    (*regs)[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
+    (*regs)[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
+    (*regs)[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
+    (*regs)[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
+    (*regs)[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
+    xtensa_sync_phys_from_window((CPUXtensaState *)env);
+    for (i = 0; i < env->config->nareg; ++i) {
+        (*regs)[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
+    }
+}
+
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE       4096
+
+#endif /* TARGET_XTENSA */
+
 #ifndef ELF_PLATFORM
 #define ELF_PLATFORM (NULL)
 #endif
diff --git a/linux-user/main.c b/linux-user/main.c
index 7bc9bc79b052..25b4dfdbcb7a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -3930,6 +3930,242 @@ void cpu_loop(CPUHPPAState *env)
 
 #endif /* TARGET_HPPA */
 
+#ifdef TARGET_XTENSA
+
+static void xtensa_rfw(CPUXtensaState *env)
+{
+    xtensa_restore_owb(env);
+    env->pc = env->sregs[EPC1];
+}
+
+static void xtensa_rfwu(CPUXtensaState *env)
+{
+    env->sregs[WINDOW_START] |= (1 << env->sregs[WINDOW_BASE]);
+    xtensa_rfw(env);
+}
+
+static void xtensa_rfwo(CPUXtensaState *env)
+{
+    env->sregs[WINDOW_START] &= ~(1 << env->sregs[WINDOW_BASE]);
+    xtensa_rfw(env);
+}
+
+static void xtensa_overflow4(CPUXtensaState *env)
+{
+    put_user_ual(env->regs[0], env->regs[5] - 16);
+    put_user_ual(env->regs[1], env->regs[5] - 12);
+    put_user_ual(env->regs[2], env->regs[5] -  8);
+    put_user_ual(env->regs[3], env->regs[5] -  4);
+    xtensa_rfwo(env);
+}
+
+static void xtensa_underflow4(CPUXtensaState *env)
+{
+    get_user_ual(env->regs[0], env->regs[5] - 16);
+    get_user_ual(env->regs[1], env->regs[5] - 12);
+    get_user_ual(env->regs[2], env->regs[5] -  8);
+    get_user_ual(env->regs[3], env->regs[5] -  4);
+    xtensa_rfwu(env);
+}
+
+static void xtensa_overflow8(CPUXtensaState *env)
+{
+    put_user_ual(env->regs[0], env->regs[9] - 16);
+    get_user_ual(env->regs[0], env->regs[1] - 12);
+    put_user_ual(env->regs[1], env->regs[9] - 12);
+    put_user_ual(env->regs[2], env->regs[9] -  8);
+    put_user_ual(env->regs[3], env->regs[9] -  4);
+    put_user_ual(env->regs[4], env->regs[0] - 32);
+    put_user_ual(env->regs[5], env->regs[0] - 28);
+    put_user_ual(env->regs[6], env->regs[0] - 24);
+    put_user_ual(env->regs[7], env->regs[0] - 20);
+    xtensa_rfwo(env);
+}
+
+static void xtensa_underflow8(CPUXtensaState *env)
+{
+    get_user_ual(env->regs[0], env->regs[9] - 16);
+    get_user_ual(env->regs[1], env->regs[9] - 12);
+    get_user_ual(env->regs[2], env->regs[9] -  8);
+    get_user_ual(env->regs[7], env->regs[1] - 12);
+    get_user_ual(env->regs[3], env->regs[9] -  4);
+    get_user_ual(env->regs[4], env->regs[7] - 32);
+    get_user_ual(env->regs[5], env->regs[7] - 28);
+    get_user_ual(env->regs[6], env->regs[7] - 24);
+    get_user_ual(env->regs[7], env->regs[7] - 20);
+    xtensa_rfwu(env);
+}
+
+static void xtensa_overflow12(CPUXtensaState *env)
+{
+    put_user_ual(env->regs[0],  env->regs[13] - 16);
+    get_user_ual(env->regs[0],  env->regs[1]  - 12);
+    put_user_ual(env->regs[1],  env->regs[13] - 12);
+    put_user_ual(env->regs[2],  env->regs[13] -  8);
+    put_user_ual(env->regs[3],  env->regs[13] -  4);
+    put_user_ual(env->regs[4],  env->regs[0]  - 48);
+    put_user_ual(env->regs[5],  env->regs[0]  - 44);
+    put_user_ual(env->regs[6],  env->regs[0]  - 40);
+    put_user_ual(env->regs[7],  env->regs[0]  - 36);
+    put_user_ual(env->regs[8],  env->regs[0]  - 32);
+    put_user_ual(env->regs[9],  env->regs[0]  - 28);
+    put_user_ual(env->regs[10], env->regs[0]  - 24);
+    put_user_ual(env->regs[11], env->regs[0]  - 20);
+    xtensa_rfwo(env);
+}
+
+static void xtensa_underflow12(CPUXtensaState *env)
+{
+    get_user_ual(env->regs[0],  env->regs[13] - 16);
+    get_user_ual(env->regs[1],  env->regs[13] - 12);
+    get_user_ual(env->regs[2],  env->regs[13] -  8);
+    get_user_ual(env->regs[11], env->regs[1]  - 12);
+    get_user_ual(env->regs[3],  env->regs[13] -  4);
+    get_user_ual(env->regs[4],  env->regs[11] - 48);
+    get_user_ual(env->regs[5],  env->regs[11] - 44);
+    get_user_ual(env->regs[6],  env->regs[11] - 40);
+    get_user_ual(env->regs[7],  env->regs[11] - 36);
+    get_user_ual(env->regs[8],  env->regs[11] - 32);
+    get_user_ual(env->regs[9],  env->regs[11] - 28);
+    get_user_ual(env->regs[10], env->regs[11] - 24);
+    get_user_ual(env->regs[11], env->regs[11] - 20);
+    xtensa_rfwu(env);
+}
+
+void cpu_loop(CPUXtensaState *env)
+{
+    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    target_siginfo_t info;
+    abi_ulong ret;
+    int trapnr;
+
+    while (1) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        env->sregs[PS] &= ~PS_EXCM;
+        switch (trapnr) {
+        case EXCP_INTERRUPT:
+            break;
+
+        case EXC_WINDOW_OVERFLOW4:
+            xtensa_overflow4(env);
+            break;
+        case EXC_WINDOW_UNDERFLOW4:
+            xtensa_underflow4(env);
+            break;
+        case EXC_WINDOW_OVERFLOW8:
+            xtensa_overflow8(env);
+            break;
+        case EXC_WINDOW_UNDERFLOW8:
+            xtensa_underflow8(env);
+            break;
+        case EXC_WINDOW_OVERFLOW12:
+            xtensa_overflow12(env);
+            break;
+        case EXC_WINDOW_UNDERFLOW12:
+            xtensa_underflow12(env);
+            break;
+
+        case EXC_USER:
+            switch (env->sregs[EXCCAUSE]) {
+            case ILLEGAL_INSTRUCTION_CAUSE:
+            case PRIVILEGED_CAUSE:
+                info.si_signo = TARGET_SIGILL;
+                info.si_errno = 0;
+                info.si_code =
+                    env->sregs[EXCCAUSE] == ILLEGAL_INSTRUCTION_CAUSE ?
+                    TARGET_ILL_ILLOPC : TARGET_ILL_PRVOPC;
+                info._sifields._sigfault._addr = env->sregs[EPC1];
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
+
+            case SYSCALL_CAUSE:
+                env->pc += 3;
+                ret = do_syscall(env, env->regs[2],
+                                 env->regs[6], env->regs[3],
+                                 env->regs[4], env->regs[5],
+                                 env->regs[8], env->regs[9], 0, 0);
+                switch (ret) {
+                default:
+                    env->regs[2] = ret;
+                    break;
+
+                case -TARGET_ERESTARTSYS:
+                case -TARGET_QEMU_ESIGRETURN:
+                    break;
+                }
+                break;
+
+            case ALLOCA_CAUSE:
+                env->sregs[PS] = deposit32(env->sregs[PS],
+                                           PS_OWB_SHIFT,
+                                           PS_OWB_LEN,
+                                           env->sregs[WINDOW_BASE]);
+
+                switch (env->regs[0] & 0xc0000000) {
+                case 0x00000000:
+                case 0x40000000:
+                    xtensa_rotate_window(env, -1);
+                    xtensa_underflow4(env);
+                    break;
+
+                case 0x80000000:
+                    xtensa_rotate_window(env, -2);
+                    xtensa_underflow8(env);
+                    break;
+
+                case 0xc0000000:
+                    xtensa_rotate_window(env, -3);
+                    xtensa_underflow12(env);
+                    break;
+                }
+                break;
+
+            case INTEGER_DIVIDE_BY_ZERO_CAUSE:
+                info.si_signo = TARGET_SIGFPE;
+                info.si_errno = 0;
+                info.si_code = TARGET_FPE_INTDIV;
+                info._sifields._sigfault._addr = env->sregs[EPC1];
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
+
+            case LOAD_PROHIBITED_CAUSE:
+            case STORE_PROHIBITED_CAUSE:
+                info.si_signo = TARGET_SIGSEGV;
+                info.si_errno = 0;
+                info.si_code = TARGET_SEGV_ACCERR;
+                info._sifields._sigfault._addr = env->sregs[EXCVADDR];
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
+
+            default:
+                fprintf(stderr, "exccause = %d\n", env->sregs[EXCCAUSE]);
+                g_assert_not_reached();
+            }
+            break;
+        case EXCP_DEBUG:
+            trapnr = gdb_handlesig(cs, TARGET_SIGTRAP);
+            if (trapnr) {
+                info.si_signo = trapnr;
+                info.si_errno = 0;
+                info.si_code = TARGET_TRAP_BRKPT;
+                queue_signal(env, trapnr, QEMU_SI_FAULT, &info);
+            }
+            break;
+        case EXC_DEBUG:
+        default:
+            fprintf(stderr, "trapnr = %d\n", trapnr);
+            g_assert_not_reached();
+        }
+        process_pending_signals(env);
+    }
+}
+
+#endif /* TARGET_XTENSA */
+
 __thread CPUState *thread_cpu;
 
 bool qemu_cpu_is_self(CPUState *cpu)
@@ -4970,6 +5206,15 @@ int main(int argc, char **argv, char **envp)
         env->iaoq_f = regs->iaoq[0];
         env->iaoq_b = regs->iaoq[1];
     }
+#elif defined(TARGET_XTENSA)
+    {
+        int i;
+        for (i = 0; i < 16; ++i) {
+            env->regs[i] = regs->areg[i];
+        }
+        env->sregs[WINDOW_START] = regs->windowstart;
+        env->pc = regs->pc;
+    }
 #else
 #error unsupported target CPU
 #endif
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 2ce5d7a3c7e3..24b6f38b42a5 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -7051,6 +7051,260 @@ long do_rt_sigreturn(CPUArchState *env)
     return -TARGET_QEMU_ESIGRETURN;
 }
 
+#elif defined(TARGET_XTENSA)
+
+struct target_sigcontext {
+    abi_ulong sc_pc;
+    abi_ulong sc_ps;
+    abi_ulong sc_lbeg;
+    abi_ulong sc_lend;
+    abi_ulong sc_lcount;
+    abi_ulong sc_sar;
+    abi_ulong sc_acclo;
+    abi_ulong sc_acchi;
+    abi_ulong sc_a[16];
+    abi_ulong sc_xtregs;
+};
+
+struct target_ucontext {
+    abi_ulong tuc_flags;
+    abi_ulong tuc_link;
+    target_stack_t tuc_stack;
+    struct target_sigcontext tuc_mcontext;
+    target_sigset_t tuc_sigmask;
+};
+
+struct target_rt_sigframe {
+    target_siginfo_t info;
+    struct target_ucontext uc;
+    /* TODO: xtregs */
+    uint8_t retcode[6];
+    abi_ulong window[4];
+};
+
+static abi_ulong get_sigframe(struct target_sigaction *sa,
+                              CPUXtensaState *env,
+                              unsigned long framesize)
+{
+    abi_ulong sp = env->regs[1];
+
+    /* This is the X/Open sanctioned signal stack switching.  */
+    if ((sa->sa_flags & TARGET_SA_ONSTACK) != 0 && !sas_ss_flags(sp)) {
+        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+    }
+    return (sp - framesize) & -16;
+}
+
+static int flush_window_regs(CPUXtensaState *env)
+{
+    const uint32_t nareg_mask = env->config->nareg - 1;
+    uint32_t wb = env->sregs[WINDOW_BASE];
+    uint32_t ws = (xtensa_replicate_windowstart(env) >> (wb + 1)) &
+        ((1 << env->config->nareg / 4) - 1);
+    uint32_t d = ctz32(ws) + 1;
+    uint32_t sp;
+    abi_long ret = 0;
+
+    wb += d;
+    ws >>= d;
+
+    xtensa_sync_phys_from_window(env);
+    sp = env->phys_regs[(wb * 4 + 1) & nareg_mask];
+
+    while (ws && ret == 0) {
+        int d;
+        int i;
+        int idx;
+
+        if (ws & 0x1) {
+            ws >>= 1;
+            d = 1;
+        } else if (ws & 0x2) {
+            ws >>= 2;
+            d = 2;
+            for (i = 0; i < 4; ++i) {
+                idx = (wb * 4 + 4 + i) & nareg_mask;
+                ret |= put_user_ual(env->phys_regs[idx], sp + (i - 12) * 4);
+            }
+        } else if (ws & 0x4) {
+            ws >>= 3;
+            d = 3;
+            for (i = 0; i < 8; ++i) {
+                idx = (wb * 4 + 4 + i) & nareg_mask;
+                ret |= put_user_ual(env->phys_regs[idx], sp + (i - 16) * 4);
+            }
+        } else {
+            g_assert_not_reached();
+        }
+        sp = env->phys_regs[((wb + d) * 4 + 1) & nareg_mask];
+        for (i = 0; i < 4; ++i) {
+            idx = (wb * 4 + i) & nareg_mask;
+            ret |= put_user_ual(env->phys_regs[idx], sp + (i - 4) * 4);
+        }
+        wb += d;
+    }
+    return ret == 0;
+}
+
+static int setup_sigcontext(struct target_rt_sigframe *frame,
+                            CPUXtensaState *env)
+{
+    struct target_sigcontext *sc = &frame->uc.tuc_mcontext;
+    int i;
+
+    __put_user(env->pc, &sc->sc_pc);
+    __put_user(env->sregs[PS], &sc->sc_ps);
+    __put_user(env->sregs[LBEG], &sc->sc_lbeg);
+    __put_user(env->sregs[LEND], &sc->sc_lend);
+    __put_user(env->sregs[LCOUNT], &sc->sc_lcount);
+    if (!flush_window_regs(env)) {
+        return 0;
+    }
+    for (i = 0; i < 16; ++i) {
+        __put_user(env->regs[i], sc->sc_a + i);
+    }
+    __put_user(0, &sc->sc_xtregs);
+    /* TODO: xtregs */
+    return 1;
+}
+
+static void setup_rt_frame(int sig, struct target_sigaction *ka,
+                           target_siginfo_t *info,
+                           target_sigset_t *set, CPUXtensaState *env)
+{
+    abi_ulong frame_addr;
+    struct target_rt_sigframe *frame;
+    uint32_t ra;
+    int i;
+
+    frame_addr = get_sigframe(ka, env, sizeof(*frame));
+    trace_user_setup_rt_frame(env, frame_addr);
+
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+        goto give_sigsegv;
+    }
+
+    if (ka->sa_flags & SA_SIGINFO) {
+        tswap_siginfo(&frame->info, info);
+    }
+
+    __put_user(0, &frame->uc.tuc_flags);
+    __put_user(0, &frame->uc.tuc_link);
+    __put_user(target_sigaltstack_used.ss_sp,
+               &frame->uc.tuc_stack.ss_sp);
+    __put_user(sas_ss_flags(env->regs[1]),
+               &frame->uc.tuc_stack.ss_flags);
+    __put_user(target_sigaltstack_used.ss_size,
+               &frame->uc.tuc_stack.ss_size);
+    if (!setup_sigcontext(frame, env)) {
+        unlock_user_struct(frame, frame_addr, 0);
+        goto give_sigsegv;
+    }
+    for (i = 0; i < TARGET_NSIG_WORDS; ++i) {
+        __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
+    }
+
+    if (ka->sa_flags & TARGET_SA_RESTORER) {
+        ra = ka->sa_restorer;
+    } else {
+        ra = frame_addr + offsetof(struct target_rt_sigframe, retcode);
+#ifdef TARGET_WORDS_BIGENDIAN
+        /* Generate instruction:  MOVI a2, __NR_rt_sigreturn */
+        __put_user(0x22, &frame->retcode[0]);
+        __put_user(0x0a, &frame->retcode[1]);
+        __put_user(TARGET_NR_rt_sigreturn, &frame->retcode[2]);
+        /* Generate instruction:  SYSCALL */
+        __put_user(0x00, &frame->retcode[3]);
+        __put_user(0x05, &frame->retcode[4]);
+        __put_user(0x00, &frame->retcode[5]);
+#else
+        /* Generate instruction:  MOVI a2, __NR_rt_sigreturn */
+        __put_user(0x22, &frame->retcode[0]);
+        __put_user(0xa0, &frame->retcode[1]);
+        __put_user(TARGET_NR_rt_sigreturn, &frame->retcode[2]);
+        /* Generate instruction:  SYSCALL */
+        __put_user(0x00, &frame->retcode[3]);
+        __put_user(0x50, &frame->retcode[4]);
+        __put_user(0x00, &frame->retcode[5]);
+#endif
+    }
+    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_WINDOWED_REGISTER)) {
+        env->sregs[PS] |= PS_WOE | (1 << PS_CALLINC_SHIFT);
+    }
+    memset(env->regs, 0, sizeof(env->regs));
+    env->pc = ka->_sa_handler;
+    env->regs[1] = frame_addr;
+    env->sregs[WINDOW_BASE] = 0;
+    env->sregs[WINDOW_START] = 1;
+
+    env->regs[4] = (ra & 0x3fffffff) | 0x40000000;
+    env->regs[6] = sig;
+    env->regs[7] = frame_addr + offsetof(struct target_rt_sigframe, info);
+    env->regs[8] = frame_addr + offsetof(struct target_rt_sigframe, uc);
+    unlock_user_struct(frame, frame_addr, 1);
+    return;
+
+give_sigsegv:
+    force_sigsegv(sig);
+    return;
+}
+
+static void restore_sigcontext(CPUXtensaState *env,
+                               struct target_rt_sigframe *frame)
+{
+    struct target_sigcontext *sc = &frame->uc.tuc_mcontext;
+    uint32_t ps;
+    int i;
+
+    __get_user(env->pc, &sc->sc_pc);
+    __get_user(ps, &sc->sc_ps);
+    __get_user(env->sregs[LBEG], &sc->sc_lbeg);
+    __get_user(env->sregs[LEND], &sc->sc_lend);
+    __get_user(env->sregs[LCOUNT], &sc->sc_lcount);
+
+    env->sregs[WINDOW_BASE] = 0;
+    env->sregs[WINDOW_START] = 1;
+    env->sregs[PS] = deposit32(env->sregs[PS],
+                               PS_CALLINC_SHIFT,
+                               PS_CALLINC_LEN,
+                               extract32(ps, PS_CALLINC_SHIFT,
+                                         PS_CALLINC_LEN));
+    for (i = 0; i < 16; ++i) {
+        __get_user(env->regs[i], sc->sc_a + i);
+    }
+    /* TODO: xtregs */
+}
+
+long do_rt_sigreturn(CPUXtensaState *env)
+{
+    abi_ulong frame_addr = env->regs[1];
+    struct target_rt_sigframe *frame;
+    sigset_t set;
+
+    trace_user_do_rt_sigreturn(env, frame_addr);
+    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+        goto badframe;
+    }
+    target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
+    set_sigmask(&set);
+
+    restore_sigcontext(env, frame);
+
+    if (do_sigaltstack(frame_addr +
+                       offsetof(struct target_rt_sigframe, uc.tuc_stack),
+                       0, get_sp_from_cpustate(env)) == -TARGET_EFAULT) {
+        goto badframe;
+    }
+    unlock_user_struct(frame, frame_addr, 0);
+    return -TARGET_QEMU_ESIGRETURN;
+
+badframe:
+    unlock_user_struct(frame, frame_addr, 0);
+    force_sig(TARGET_SIGSEGV);
+    return -TARGET_QEMU_ESIGRETURN;
+}
+
 #else
 
 static void setup_frame(int sig, struct target_sigaction *ka,
@@ -7154,7 +7408,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
         || defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) \
         || defined(TARGET_PPC64) || defined(TARGET_HPPA) \
         || defined(TARGET_NIOS2) || defined(TARGET_X86_64) \
-        || defined(TARGET_RISCV)
+        || defined(TARGET_RISCV) || defined(TARGET_XTENSA)
         /* These targets do not have traditional signals.  */
         setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
 #else
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 19d5445c3197..e864a1d72a27 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -709,6 +709,8 @@ static inline int regpairs_aligned(void *cpu_env, int num)
         return 0;
     }
 }
+#elif defined(TARGET_XTENSA)
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
 #else
 static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index e00e1b38628e..b034fa8d54f8 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -71,7 +71,8 @@
     || defined(TARGET_M68K) || defined(TARGET_CRIS) \
     || defined(TARGET_UNICORE32) || defined(TARGET_S390X) \
     || defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) \
-    || defined(TARGET_NIOS2) || defined(TARGET_RISCV)
+    || defined(TARGET_NIOS2) || defined(TARGET_RISCV) \
+    || defined(TARGET_XTENSA)
 
 #define TARGET_IOC_SIZEBITS	14
 #define TARGET_IOC_DIRBITS	2
@@ -436,7 +437,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     || defined(TARGET_MICROBLAZE) || defined(TARGET_UNICORE32) \
     || defined(TARGET_S390X) || defined(TARGET_OPENRISC) \
     || defined(TARGET_TILEGX) || defined(TARGET_HPPA) || defined(TARGET_NIOS2) \
-    || defined(TARGET_RISCV)
+    || defined(TARGET_RISCV) || defined(TARGET_XTENSA)
 
 #if defined(TARGET_SPARC)
 #define TARGET_SA_NOCLDSTOP    8u
@@ -1392,6 +1393,18 @@ struct target_winsize {
 #define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
 #define TARGET_MAP_STACK        0x40000         /* ignored */
 #define TARGET_MAP_HUGETLB      0x80000         /* create a huge page mapping */
+#elif defined(TARGET_XTENSA)
+#define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
+#define TARGET_MAP_ANONYMOUS	0x0800		/* don't use a file */
+#define TARGET_MAP_GROWSDOWN	0x1000		/* stack-like segment */
+#define TARGET_MAP_DENYWRITE	0x2000		/* ETXTBSY */
+#define TARGET_MAP_EXECUTABLE	0x4000		/* mark it as an executable */
+#define TARGET_MAP_LOCKED	0x8000		/* pages are locked */
+#define TARGET_MAP_NORESERVE	0x0400		/* don't check for reservations */
+#define TARGET_MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
+#define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define TARGET_MAP_STACK	0x40000
+#define TARGET_MAP_HUGETLB  0x80000         /* create a huge page mapping */
 #else
 #define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
 #define TARGET_MAP_ANONYMOUS	0x20		/* don't use a file */
@@ -2093,6 +2106,51 @@ struct target_stat {
     abi_ulong  target_st_ctime_nsec;
     unsigned int __unused[2];
 };
+#elif defined(TARGET_XTENSA)
+struct target_stat {
+    abi_ulong       st_dev;
+    abi_ulong       st_ino;
+    unsigned int    st_mode;
+    unsigned int    st_nlink;
+    unsigned int    st_uid;
+    unsigned int    st_gid;
+    abi_ulong       st_rdev;
+    abi_long        st_size;
+    abi_ulong       st_blksize;
+    abi_ulong       st_blocks;
+    abi_ulong       target_st_atime;
+    abi_ulong       target_st_atime_nsec;
+    abi_ulong       target_st_mtime;
+    abi_ulong       target_st_mtime_nsec;
+    abi_ulong       target_st_ctime;
+    abi_ulong       target_st_ctime_nsec;
+    abi_ulong       __unused4;
+    abi_ulong       __unused5;
+};
+
+#define TARGET_HAS_STRUCT_STAT64
+struct target_stat64  {
+    uint64_t st_dev;            /* Device */
+    uint64_t st_ino;            /* File serial number */
+    unsigned int  st_mode;      /* File mode. */
+    unsigned int  st_nlink;     /* Link count. */
+    unsigned int  st_uid;       /* User ID of the file's owner. */
+    unsigned int  st_gid;       /* Group ID of the file's group. */
+    uint64_t st_rdev;           /* Device number, if device. */
+    int64_t st_size;            /* Size of file, in bytes. */
+    abi_ulong st_blksize;       /* Optimal block size for I/O. */
+    abi_ulong __unused2;
+    uint64_t st_blocks;         /* Number 512-byte blocks allocated. */
+    abi_ulong target_st_atime;  /* Time of last access. */
+    abi_ulong target_st_atime_nsec;
+    abi_ulong target_st_mtime;  /* Time of last modification. */
+    abi_ulong target_st_mtime_nsec;
+    abi_ulong target_st_ctime;  /* Time of last status change. */
+    abi_ulong target_st_ctime_nsec;
+    abi_ulong __unused4;
+    abi_ulong __unused5;
+};
+
 #elif defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) || \
       defined(TARGET_NIOS2) || defined(TARGET_RISCV)
 
@@ -2593,7 +2651,8 @@ struct target_flock64 {
     short  l_whence;
 #if defined(TARGET_PPC) || defined(TARGET_X86_64) || defined(TARGET_MIPS) \
     || defined(TARGET_SPARC) || defined(TARGET_HPPA) \
-    || defined(TARGET_MICROBLAZE) || defined(TARGET_TILEGX)
+    || defined(TARGET_MICROBLAZE) || defined(TARGET_TILEGX) \
+    || defined(TARGET_XTENSA)
     int __pad;
 #endif
     abi_llong l_start;
diff --git a/linux-user/xtensa/syscall.h b/linux-user/xtensa/syscall.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/linux-user/xtensa/syscall_nr.h b/linux-user/xtensa/syscall_nr.h
new file mode 100644
index 000000000000..cd5ef45f8436
--- /dev/null
+++ b/linux-user/xtensa/syscall_nr.h
@@ -0,0 +1,437 @@
+/*
+ * include/asm-xtensa/unistd.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2001 - 2009 Tensilica Inc.
+ */
+
+#ifndef _XTENSA_UNISTD_H
+#define _XTENSA_UNISTD_H
+
+#define TARGET_NR_spill                                0
+#define TARGET_NR_xtensa                               1
+#define TARGET_NR_available4                           2
+#define TARGET_NR_available5                           3
+#define TARGET_NR_available6                           4
+#define TARGET_NR_available7                           5
+#define TARGET_NR_available8                           6
+#define TARGET_NR_available9                           7
+
+/* File Operations */
+
+#define TARGET_NR_open                                 8
+#define TARGET_NR_close                                9
+#define TARGET_NR_dup                                 10
+#define TARGET_NR_dup2                                11
+#define TARGET_NR_read                                12
+#define TARGET_NR_write                               13
+#define TARGET_NR_select                              14
+#define TARGET_NR_lseek                               15
+#define TARGET_NR_poll                                16
+#define TARGET_NR__llseek                             17
+#define TARGET_NR_epoll_wait                          18
+#define TARGET_NR_epoll_ctl                           19
+#define TARGET_NR_epoll_create                        20
+#define TARGET_NR_creat                               21
+#define TARGET_NR_truncate                            22
+#define TARGET_NR_ftruncate                           23
+#define TARGET_NR_readv                               24
+#define TARGET_NR_writev                              25
+#define TARGET_NR_fsync                               26
+#define TARGET_NR_fdatasync                           27
+#define TARGET_NR_truncate64                          28
+#define TARGET_NR_ftruncate64                         29
+#define TARGET_NR_pread64                             30
+#define TARGET_NR_pwrite64                            31
+
+#define TARGET_NR_link                                32
+#define TARGET_NR_rename                              33
+#define TARGET_NR_symlink                             34
+#define TARGET_NR_readlink                            35
+#define TARGET_NR_mknod                               36
+#define TARGET_NR_pipe                                37
+#define TARGET_NR_unlink                              38
+#define TARGET_NR_rmdir                               39
+
+#define TARGET_NR_mkdir                               40
+#define TARGET_NR_chdir                               41
+#define TARGET_NR_fchdir                              42
+#define TARGET_NR_getcwd                              43
+
+#define TARGET_NR_chmod                               44
+#define TARGET_NR_chown                               45
+#define TARGET_NR_stat                                46
+#define TARGET_NR_stat64                              47
+
+#define TARGET_NR_lchown                              48
+#define TARGET_NR_lstat                               49
+#define TARGET_NR_lstat64                             50
+#define TARGET_NR_available51                         51
+
+#define TARGET_NR_fchmod                              52
+#define TARGET_NR_fchown                              53
+#define TARGET_NR_fstat                               54
+#define TARGET_NR_fstat64                             55
+
+#define TARGET_NR_flock                               56
+#define TARGET_NR_access                              57
+#define TARGET_NR_umask                               58
+#define TARGET_NR_getdents                            59
+#define TARGET_NR_getdents64                          60
+#define TARGET_NR_fcntl64                             61
+#define TARGET_NR_fallocate                           62
+#define TARGET_NR_fadvise64_64                        63
+#define TARGET_NR_utime                               64     /* glibc 2.3.3 ?? */
+#define TARGET_NR_utimes                              65
+#define TARGET_NR_ioctl                               66
+#define TARGET_NR_fcntl                               67
+
+#define TARGET_NR_setxattr                            68
+#define TARGET_NR_getxattr                            69
+#define TARGET_NR_listxattr                           70
+#define TARGET_NR_removexattr                         71
+#define TARGET_NR_lsetxattr                           72
+#define TARGET_NR_lgetxattr                           73
+#define TARGET_NR_llistxattr                          74
+#define TARGET_NR_lremovexattr                        75
+#define TARGET_NR_fsetxattr                           76
+#define TARGET_NR_fgetxattr                           77
+#define TARGET_NR_flistxattr                          78
+#define TARGET_NR_fremovexattr                        79
+
+/* File Map / Shared Memory Operations */
+
+#define TARGET_NR_mmap2                               80
+#define TARGET_NR_munmap                              81
+#define TARGET_NR_mprotect                            82
+#define TARGET_NR_brk                                 83
+#define TARGET_NR_mlock                               84
+#define TARGET_NR_munlock                             85
+#define TARGET_NR_mlockall                            86
+#define TARGET_NR_munlockall                          87
+#define TARGET_NR_mremap                              88
+#define TARGET_NR_msync                               89
+#define TARGET_NR_mincore                             90
+#define TARGET_NR_madvise                             91
+#define TARGET_NR_shmget                              92
+#define TARGET_NR_shmat                               93
+#define TARGET_NR_shmctl                              94
+#define TARGET_NR_shmdt                               95
+
+/* Socket Operations */
+
+#define TARGET_NR_socket                              96
+#define TARGET_NR_setsockopt                          97
+#define TARGET_NR_getsockopt                          98
+#define TARGET_NR_shutdown                            99
+
+#define TARGET_NR_bind                               100
+#define TARGET_NR_connect                            101
+#define TARGET_NR_listen                             102
+#define TARGET_NR_accept                             103
+
+#define TARGET_NR_getsockname                        104
+#define TARGET_NR_getpeername                        105
+#define TARGET_NR_sendmsg                            106
+#define TARGET_NR_recvmsg                            107
+#define TARGET_NR_send                               108
+#define TARGET_NR_recv                               109
+#define TARGET_NR_sendto                             110
+#define TARGET_NR_recvfrom                           111
+
+#define TARGET_NR_socketpair                         112
+#define TARGET_NR_sendfile                           113
+#define TARGET_NR_sendfile64                         114
+#define TARGET_NR_sendmmsg                           115
+
+/* Process Operations */
+
+#define TARGET_NR_clone                              116
+#define TARGET_NR_execve                             117
+#define TARGET_NR_exit                               118
+#define TARGET_NR_exit_group                         119
+#define TARGET_NR_getpid                             120
+#define TARGET_NR_wait4                              121
+#define TARGET_NR_waitid                             122
+#define TARGET_NR_kill                               123
+#define TARGET_NR_tkill                              124
+#define TARGET_NR_tgkill                             125
+#define TARGET_NR_set_tid_address                    126
+#define TARGET_NR_gettid                             127
+#define TARGET_NR_setsid                             128
+#define TARGET_NR_getsid                             129
+#define TARGET_NR_prctl                              130
+#define TARGET_NR_personality                        131
+#define TARGET_NR_getpriority                        132
+#define TARGET_NR_setpriority                        133
+#define TARGET_NR_setitimer                          134
+#define TARGET_NR_getitimer                          135
+#define TARGET_NR_setuid                             136
+#define TARGET_NR_getuid                             137
+#define TARGET_NR_setgid                             138
+#define TARGET_NR_getgid                             139
+#define TARGET_NR_geteuid                            140
+#define TARGET_NR_getegid                            141
+#define TARGET_NR_setreuid                           142
+#define TARGET_NR_setregid                           143
+#define TARGET_NR_setresuid                          144
+#define TARGET_NR_getresuid                          145
+#define TARGET_NR_setresgid                          146
+#define TARGET_NR_getresgid                          147
+#define TARGET_NR_setpgid                            148
+#define TARGET_NR_getpgid                            149
+#define TARGET_NR_getppid                            150
+#define TARGET_NR_getpgrp                            151
+
+#define TARGET_NR_reserved152                        152     /* set_thread_area */
+#define TARGET_NR_reserved153                        153     /* get_thread_area */
+#define TARGET_NR_times                              154
+#define TARGET_NR_acct                               155
+#define TARGET_NR_sched_setaffinity                  156
+#define TARGET_NR_sched_getaffinity                  157
+#define TARGET_NR_capget                             158
+#define TARGET_NR_capset                             159
+#define TARGET_NR_ptrace                             160
+#define TARGET_NR_semtimedop                         161
+#define TARGET_NR_semget                             162
+#define TARGET_NR_semop                              163
+#define TARGET_NR_semctl                             164
+#define TARGET_NR_available165                       165
+#define TARGET_NR_msgget                             166
+#define TARGET_NR_msgsnd                             167
+#define TARGET_NR_msgrcv                             168
+#define TARGET_NR_msgctl                             169
+#define TARGET_NR_available170                       170
+
+/* File System */
+
+#define TARGET_NR_umount2                            171
+#define TARGET_NR_mount                              172
+#define TARGET_NR_swapon                             173
+#define TARGET_NR_chroot                             174
+#define TARGET_NR_pivot_root                         175
+#define TARGET_NR_umount                             176
+#define TARGET_NR_swapoff                            177
+#define TARGET_NR_sync                               178
+#define TARGET_NR_syncfs                             179
+#define TARGET_NR_setfsuid                           180
+#define TARGET_NR_setfsgid                           181
+#define TARGET_NR_sysfs                              182
+#define TARGET_NR_ustat                              183
+#define TARGET_NR_statfs                             184
+#define TARGET_NR_fstatfs                            185
+#define TARGET_NR_statfs64                           186
+#define TARGET_NR_fstatfs64                          187
+
+/* System */
+
+#define TARGET_NR_setrlimit                          188
+#define TARGET_NR_getrlimit                          189
+#define TARGET_NR_getrusage                          190
+#define TARGET_NR_futex                              191
+#define TARGET_NR_gettimeofday                       192
+#define TARGET_NR_settimeofday                       193
+#define TARGET_NR_adjtimex                           194
+#define TARGET_NR_nanosleep                          195
+#define TARGET_NR_getgroups                          196
+#define TARGET_NR_setgroups                          197
+#define TARGET_NR_sethostname                        198
+#define TARGET_NR_setdomainname                      199
+#define TARGET_NR_syslog                             200
+#define TARGET_NR_vhangup                            201
+#define TARGET_NR_uselib                             202
+#define TARGET_NR_reboot                             203
+#define TARGET_NR_quotactl                           204
+#define TARGET_NR_nfsservctl                         205
+#define TARGET_NR__sysctl                            206
+#define TARGET_NR_bdflush                            207
+#define TARGET_NR_uname                              208
+#define TARGET_NR_sysinfo                            209
+#define TARGET_NR_init_module                        210
+#define TARGET_NR_delete_module                      211
+
+#define TARGET_NR_sched_setparam                     212
+#define TARGET_NR_sched_getparam                     213
+#define TARGET_NR_sched_setscheduler                 214
+#define TARGET_NR_sched_getscheduler                 215
+#define TARGET_NR_sched_get_priority_max             216
+#define TARGET_NR_sched_get_priority_min             217
+#define TARGET_NR_sched_rr_get_interval              218
+#define TARGET_NR_sched_yield                        219
+#define TARGET_NR_available222                       222
+
+/* Signal Handling */
+
+#define TARGET_NR_restart_syscall                    223
+#define TARGET_NR_sigaltstack                        224
+#define TARGET_NR_rt_sigreturn                       225
+#define TARGET_NR_rt_sigaction                       226
+#define TARGET_NR_rt_sigprocmask                     227
+#define TARGET_NR_rt_sigpending                      228
+#define TARGET_NR_rt_sigtimedwait                    229
+#define TARGET_NR_rt_sigqueueinfo                    230
+#define TARGET_NR_rt_sigsuspend                      231
+
+/* Message */
+
+#define TARGET_NR_mq_open                            232
+#define TARGET_NR_mq_unlink                          233
+#define TARGET_NR_mq_timedsend                       234
+#define TARGET_NR_mq_timedreceive                    235
+#define TARGET_NR_mq_notify                          236
+#define TARGET_NR_mq_getsetattr                      237
+#define TARGET_NR_available238                       238
+
+/* IO */
+
+#define TARGET_NR_io_setup                           239
+#define TARGET_NR_io_destroy                         240
+#define TARGET_NR_io_submit                          241
+#define TARGET_NR_io_getevents                       242
+#define TARGET_NR_io_cancel                          243
+#define TARGET_NR_clock_settime                      244
+#define TARGET_NR_clock_gettime                      245
+#define TARGET_NR_clock_getres                       246
+#define TARGET_NR_clock_nanosleep                    247
+
+/* Timer */
+
+#define TARGET_NR_timer_create                       248
+#define TARGET_NR_timer_delete                       249
+#define TARGET_NR_timer_settime                      250
+#define TARGET_NR_timer_gettime                      251
+#define TARGET_NR_timer_getoverrun                   252
+
+/* System */
+
+#define TARGET_NR_reserved253                        253
+#define TARGET_NR_lookup_dcookie                     254
+#define TARGET_NR_available255                       255
+#define TARGET_NR_add_key                            256
+#define TARGET_NR_request_key                        257
+#define TARGET_NR_keyctl                             258
+#define TARGET_NR_available259                       259
+
+
+#define TARGET_NR_readahead                          260
+#define TARGET_NR_remap_file_pages                   261
+#define TARGET_NR_migrate_pages                      262
+#define TARGET_NR_mbind                              263
+#define TARGET_NR_get_mempolicy                      264
+#define TARGET_NR_set_mempolicy                      265
+#define TARGET_NR_unshare                            266
+#define TARGET_NR_move_pages                         267
+#define TARGET_NR_splice                             268
+#define TARGET_NR_tee                                269
+#define TARGET_NR_vmsplice                           270
+#define TARGET_NR_available271                       271
+
+#define TARGET_NR_pselect6                           272
+#define TARGET_NR_ppoll                              273
+#define TARGET_NR_epoll_pwait                        274
+#define TARGET_NR_epoll_create1                      275
+
+#define TARGET_NR_inotify_init                       276
+#define TARGET_NR_inotify_add_watch                  277
+#define TARGET_NR_inotify_rm_watch                   278
+#define TARGET_NR_inotify_init1                      279
+
+#define TARGET_NR_getcpu                             280
+#define TARGET_NR_kexec_load                         281
+
+#define TARGET_NR_ioprio_set                         282
+#define TARGET_NR_ioprio_get                         283
+
+#define TARGET_NR_set_robust_list                    284
+#define TARGET_NR_get_robust_list                    285
+#define TARGET_NR_available286                       286
+#define TARGET_NR_available287                       287
+
+/* Relative File Operations */
+
+#define TARGET_NR_openat                             288
+#define TARGET_NR_mkdirat                            289
+#define TARGET_NR_mknodat                            290
+#define TARGET_NR_unlinkat                           291
+#define TARGET_NR_renameat                           292
+#define TARGET_NR_linkat                             293
+#define TARGET_NR_symlinkat                          294
+#define TARGET_NR_readlinkat                         295
+#define TARGET_NR_utimensat                          296
+#define TARGET_NR_fchownat                           297
+#define TARGET_NR_futimesat                          298
+#define TARGET_NR_fstatat64                          299
+#define TARGET_NR_fchmodat                           300
+#define TARGET_NR_faccessat                          301
+#define TARGET_NR_available302                       302
+#define TARGET_NR_available303                       303
+
+#define TARGET_NR_signalfd                           304
+/*  305 was TARGET_NR_timerfd  */
+#define TARGET_NR_eventfd                            306
+#define TARGET_NR_recvmmsg                           307
+
+#define TARGET_NR_setns                              308
+#define TARGET_NR_signalfd4                          309
+#define TARGET_NR_dup3                               310
+#define TARGET_NR_pipe2                              311
+
+#define TARGET_NR_timerfd_create                     312
+#define TARGET_NR_timerfd_settime                    313
+#define TARGET_NR_timerfd_gettime                    314
+#define TARGET_NR_available315                       315
+
+#define TARGET_NR_eventfd2                           316
+#define TARGET_NR_preadv                             317
+#define TARGET_NR_pwritev                            318
+#define TARGET_NR_available319                       319
+
+#define TARGET_NR_fanotify_init                      320
+#define TARGET_NR_fanotify_mark                      321
+#define TARGET_NR_process_vm_readv                   322
+#define TARGET_NR_process_vm_writev                  323
+
+#define TARGET_NR_name_to_handle_at                  324
+#define TARGET_NR_open_by_handle_at                  325
+#define TARGET_NR_sync_file_range2                   326
+#define TARGET_NR_perf_event_open                    327
+
+#define TARGET_NR_rt_tgsigqueueinfo                  328
+#define TARGET_NR_clock_adjtime                      329
+#define TARGET_NR_prlimit64                          330
+#define TARGET_NR_kcmp                               331
+
+#define TARGET_NR_finit_module                       332
+
+#define TARGET_NR_accept4                            333
+
+#define TARGET_NR_sched_setattr                      334
+#define TARGET_NR_sched_getattr                      335
+
+#define TARGET_NR_renameat2                          336
+
+#define TARGET_NR_seccomp                            337
+#define TARGET_NR_getrandom                          338
+#define TARGET_NR_memfd_create                       339
+#define TARGET_NR_bpf                                340
+#define TARGET_NR_execveat                           341
+
+#define TARGET_NR_userfaultfd                        342
+#define TARGET_NR_membarrier                         343
+#define TARGET_NR_mlock2                             344
+#define TARGET_NR_copy_file_range                    345
+#define TARGET_NR_preadv2                            346
+#define TARGET_NR_pwritev2                           347
+
+#define TARGET_NR_pkey_mprotect                      348
+#define TARGET_NR_pkey_alloc                         349
+#define TARGET_NR_pkey_free                          350
+
+#define TARGET_NR_statx                              351
+
+#define TARGET_NR_syscall_count                      352
+
+#endif  /* _XTENSA_UNISTD_H */
diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cpu.h
new file mode 100644
index 000000000000..747d82861416
--- /dev/null
+++ b/linux-user/xtensa/target_cpu.h
@@ -0,0 +1,22 @@
+/*
+ * Xtensa-specific CPU ABI and functions for linux-user
+ */
+#ifndef XTENSA_TARGET_CPU_H
+#define XTENSA_TARGET_CPU_H
+
+static inline void cpu_clone_regs(CPUXtensaState *env, target_ulong newsp)
+{
+    if (newsp) {
+        env->regs[1] = newsp;
+        env->sregs[WINDOW_BASE] = 0;
+        env->sregs[WINDOW_START] = 0x1;
+    }
+    env->regs[2] = 0;
+}
+
+static inline void cpu_set_tls(CPUXtensaState *env, target_ulong newtls)
+{
+    env->uregs[THREADPTR] = newtls;
+}
+
+#endif
diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
new file mode 100644
index 000000000000..a9a3fabd89be
--- /dev/null
+++ b/linux-user/xtensa/target_elf.h
@@ -0,0 +1,16 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef XTENSA_TARGET_ELF_H
+#define XTENSA_TARGET_ELF_H
+
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return XTENSA_DEFAULT_CPU_MODEL;
+}
+
+#endif
diff --git a/linux-user/xtensa/target_signal.h b/linux-user/xtensa/target_signal.h
new file mode 100644
index 000000000000..c6962e70afb7
--- /dev/null
+++ b/linux-user/xtensa/target_signal.h
@@ -0,0 +1,28 @@
+#ifndef XTENSA_TARGET_SIGNAL_H
+#define XTENSA_TARGET_SIGNAL_H
+
+#include "cpu.h"
+
+/* this struct defines a stack used during syscall handling */
+
+typedef struct target_sigaltstack {
+    abi_ulong ss_sp;
+    abi_int ss_flags;
+    abi_ulong ss_size;
+} target_stack_t;
+
+/*
+ * sigaltstack controls
+ */
+#define TARGET_SS_ONSTACK     1
+#define TARGET_SS_DISABLE     2
+
+#define TARGET_MINSIGSTKSZ    2048
+#define TARGET_SIGSTKSZ       8192
+
+static inline abi_ulong get_sp_from_cpustate(CPUXtensaState *state)
+{
+    return state->regs[1];
+}
+
+#endif
diff --git a/linux-user/xtensa/target_structs.h b/linux-user/xtensa/target_structs.h
new file mode 100644
index 000000000000..020e20e242fc
--- /dev/null
+++ b/linux-user/xtensa/target_structs.h
@@ -0,0 +1,28 @@
+#ifndef XTENSA_TARGET_STRUCTS_T
+#define XTENSA_TARGET_STRUCTS_T
+
+struct target_ipc_perm {
+    abi_int __key;                      /* Key.  */
+    abi_uint uid;                       /* Owner's user ID.  */
+    abi_uint gid;                       /* Owner's group ID.  */
+    abi_uint cuid;                      /* Creator's user ID.  */
+    abi_uint cgid;                      /* Creator's group ID.  */
+    abi_uint mode;                      /* Read/write permission.  */
+    abi_ushort __seq;                   /* Sequence number.  */
+};
+
+struct target_shmid_ds {
+    struct target_ipc_perm shm_perm;    /* operation permission struct */
+    abi_int shm_segsz;                  /* size of segment in bytes */
+    abi_long shm_atime;                 /* time of last shmat() */
+    abi_long shm_dtime;                 /* time of last shmdt() */
+    abi_long shm_ctime;                 /* time of last change by shmctl() */
+    abi_ushort shm_cpid;                /* pid of creator */
+    abi_ushort shm_lpid;                /* pid of last shmop */
+    abi_ushort shm_nattch;              /* number of current attaches */
+    abi_ushort shm_unused;              /* compatibility */
+    abi_ulong __unused2;
+    abi_ulong __unused3;
+};
+
+#endif
diff --git a/linux-user/xtensa/target_syscall.h b/linux-user/xtensa/target_syscall.h
new file mode 100644
index 000000000000..3866dad84930
--- /dev/null
+++ b/linux-user/xtensa/target_syscall.h
@@ -0,0 +1,49 @@
+#ifndef XTENSA_TARGET_SYSCALL_H
+#define XTENSA_TARGET_SYSCALL_H
+
+#define UNAME_MACHINE "xtensa"
+
+#define UNAME_MINIMUM_RELEASE "3.19"
+#define TARGET_CLONE_BACKWARDS
+
+#define MMAP_SHIFT TARGET_PAGE_BITS
+
+typedef uint32_t xtensa_reg_t;
+typedef struct {
+} xtregs_opt_t; /* TODO */
+
+struct target_pt_regs {
+    xtensa_reg_t pc;            /*   4 */
+    xtensa_reg_t ps;            /*   8 */
+    xtensa_reg_t depc;          /*  12 */
+    xtensa_reg_t exccause;      /*  16 */
+    xtensa_reg_t excvaddr;      /*  20 */
+    xtensa_reg_t debugcause;    /*  24 */
+    xtensa_reg_t wmask;         /*  28 */
+    xtensa_reg_t lbeg;          /*  32 */
+    xtensa_reg_t lend;          /*  36 */
+    xtensa_reg_t lcount;        /*  40 */
+    xtensa_reg_t sar;           /*  44 */
+    xtensa_reg_t windowbase;    /*  48 */
+    xtensa_reg_t windowstart;   /*  52 */
+    xtensa_reg_t syscall;       /*  56 */
+    xtensa_reg_t icountlevel;   /*  60 */
+    xtensa_reg_t scompare1;     /*  64 */
+    xtensa_reg_t threadptr;     /*  68 */
+
+    /* Additional configurable registers that are used by the compiler. */
+    xtregs_opt_t xtregs_opt;
+
+    /* Make sure the areg field is 16 bytes aligned. */
+    int align[0] __attribute__ ((aligned(16)));
+
+    /* current register frame.
+     * Note: The ESF for kernel exceptions ends after 16 registers!
+     */
+    xtensa_reg_t areg[16];
+};
+
+#define TARGET_MLOCKALL_MCL_CURRENT 1
+#define TARGET_MLOCKALL_MCL_FUTURE  2
+
+#endif
diff --git a/linux-user/xtensa/termbits.h b/linux-user/xtensa/termbits.h
new file mode 100644
index 000000000000..eed8286de79b
--- /dev/null
+++ b/linux-user/xtensa/termbits.h
@@ -0,0 +1,328 @@
+/*
+ * include/asm-xtensa/termbits.h
+ *
+ * Copied from SH.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2001 - 2005 Tensilica Inc.
+ */
+
+#ifndef _XTENSA_TERMBITS_H
+#define _XTENSA_TERMBITS_H
+
+#include <linux/posix_types.h>
+
+typedef unsigned char   cc_t;
+typedef unsigned int    speed_t;
+typedef unsigned int    tcflag_t;
+
+#define TARGET_NCCS 19
+struct target_termios {
+    tcflag_t c_iflag;       /* input mode flags */
+    tcflag_t c_oflag;       /* output mode flags */
+    tcflag_t c_cflag;       /* control mode flags */
+    tcflag_t c_lflag;       /* local mode flags */
+    cc_t c_line;            /* line discipline */
+    cc_t c_cc[TARGET_NCCS]; /* control characters */
+};
+
+struct target_termios2 {
+    tcflag_t c_iflag;       /* input mode flags */
+    tcflag_t c_oflag;       /* output mode flags */
+    tcflag_t c_cflag;       /* control mode flags */
+    tcflag_t c_lflag;       /* local mode flags */
+    cc_t c_line;            /* line discipline */
+    cc_t c_cc[TARGET_NCCS]; /* control characters */
+    speed_t c_ispeed;       /* input speed */
+    speed_t c_ospeed;       /* output speed */
+};
+
+struct target_ktermios {
+    tcflag_t c_iflag;       /* input mode flags */
+    tcflag_t c_oflag;       /* output mode flags */
+    tcflag_t c_cflag;       /* control mode flags */
+    tcflag_t c_lflag;       /* local mode flags */
+    cc_t c_line;            /* line discipline */
+    cc_t c_cc[TARGET_NCCS]; /* control characters */
+    speed_t c_ispeed;       /* input speed */
+    speed_t c_ospeed;       /* output speed */
+};
+
+/* c_cc characters */
+
+#define TARGET_VINTR 0
+#define TARGET_VQUIT 1
+#define TARGET_VERASE 2
+#define TARGET_VKILL 3
+#define TARGET_VEOF 4
+#define TARGET_VTIME 5
+#define TARGET_VMIN 6
+#define TARGET_VSWTC 7
+#define TARGET_VSTART 8
+#define TARGET_VSTOP 9
+#define TARGET_VSUSP 10
+#define TARGET_VEOL 11
+#define TARGET_VREPRINT 12
+#define TARGET_VDISCARD 13
+#define TARGET_VWERASE 14
+#define TARGET_VLNEXT 15
+#define TARGET_VEOL2 16
+
+/* c_iflag bits */
+
+#define TARGET_IGNBRK   0000001
+#define TARGET_BRKINT   0000002
+#define TARGET_IGNPAR   0000004
+#define TARGET_PARMRK   0000010
+#define TARGET_INPCK    0000020
+#define TARGET_ISTRIP   0000040
+#define TARGET_INLCR    0000100
+#define TARGET_IGNCR    0000200
+#define TARGET_ICRNL    0000400
+#define TARGET_IUCLC    0001000
+#define TARGET_IXON 0002000
+#define TARGET_IXANY    0004000
+#define TARGET_IXOFF    0010000
+#define TARGET_IMAXBEL  0020000
+#define TARGET_IUTF8    0040000
+
+/* c_oflag bits */
+
+#define TARGET_OPOST    0000001
+#define TARGET_OLCUC    0000002
+#define TARGET_ONLCR    0000004
+#define TARGET_OCRNL    0000010
+#define TARGET_ONOCR    0000020
+#define TARGET_ONLRET   0000040
+#define TARGET_OFILL    0000100
+#define TARGET_OFDEL    0000200
+#define TARGET_NLDLY    0000400
+#define   TARGET_NL0    0000000
+#define   TARGET_NL1    0000400
+#define TARGET_CRDLY    0003000
+#define   TARGET_CR0    0000000
+#define   TARGET_CR1    0001000
+#define   TARGET_CR2    0002000
+#define   TARGET_CR3    0003000
+#define TARGET_TABDLY   0014000
+#define   TARGET_TAB0   0000000
+#define   TARGET_TAB1   0004000
+#define   TARGET_TAB2   0010000
+#define   TARGET_TAB3   0014000
+#define   TARGET_XTABS  0014000
+#define TARGET_BSDLY    0020000
+#define   TARGET_BS0    0000000
+#define   TARGET_BS1    0020000
+#define TARGET_VTDLY    0040000
+#define   TARGET_VT0    0000000
+#define   TARGET_VT1    0040000
+#define TARGET_FFDLY    0100000
+#define   TARGET_FF0    0000000
+#define   TARGET_FF1    0100000
+
+/* c_cflag bit meaning */
+
+#define TARGET_CBAUD    0010017
+#define  TARGET_B0  0000000     /* hang up */
+#define  TARGET_B50 0000001
+#define  TARGET_B75 0000002
+#define  TARGET_B110    0000003
+#define  TARGET_B134    0000004
+#define  TARGET_B150    0000005
+#define  TARGET_B200    0000006
+#define  TARGET_B300    0000007
+#define  TARGET_B600    0000010
+#define  TARGET_B1200   0000011
+#define  TARGET_B1800   0000012
+#define  TARGET_B2400   0000013
+#define  TARGET_B4800   0000014
+#define  TARGET_B9600   0000015
+#define  TARGET_B19200  0000016
+#define  TARGET_B38400  0000017
+#define TARGET_EXTA B19200
+#define TARGET_EXTB B38400
+#define TARGET_CSIZE    0000060
+#define   TARGET_CS5    0000000
+#define   TARGET_CS6    0000020
+#define   TARGET_CS7    0000040
+#define   TARGET_CS8    0000060
+#define TARGET_CSTOPB   0000100
+#define TARGET_CREAD    0000200
+#define TARGET_PARENB   0000400
+#define TARGET_PARODD   0001000
+#define TARGET_HUPCL    0002000
+#define TARGET_CLOCAL   0004000
+#define TARGET_CBAUDEX 0010000
+#define    TARGET_BOTHER 0010000
+#define    TARGET_B57600 0010001
+#define   TARGET_B115200 0010002
+#define   TARGET_B230400 0010003
+#define   TARGET_B460800 0010004
+#define   TARGET_B500000 0010005
+#define   TARGET_B576000 0010006
+#define   TARGET_B921600 0010007
+#define  TARGET_B1000000 0010010
+#define  TARGET_B1152000 0010011
+#define  TARGET_B1500000 0010012
+#define  TARGET_B2000000 0010013
+#define  TARGET_B2500000 0010014
+#define  TARGET_B3000000 0010015
+#define  TARGET_B3500000 0010016
+#define  TARGET_B4000000 0010017
+#define TARGET_CIBAUD     002003600000      /* input baud rate */
+#define TARGET_CMSPAR     010000000000      /* mark or space (stick) parity */
+#define TARGET_CRTSCTS    020000000000      /* flow control */
+
+#define TARGET_IBSHIFT  16      /* Shift from CBAUD to CIBAUD */
+
+/* c_lflag bits */
+
+#define TARGET_ISIG 0000001
+#define TARGET_ICANON   0000002
+#define TARGET_XCASE    0000004
+#define TARGET_ECHO 0000010
+#define TARGET_ECHOE    0000020
+#define TARGET_ECHOK    0000040
+#define TARGET_ECHONL   0000100
+#define TARGET_NOFLSH   0000200
+#define TARGET_TOSTOP   0000400
+#define TARGET_ECHOCTL  0001000
+#define TARGET_ECHOPRT  0002000
+#define TARGET_ECHOKE   0004000
+#define TARGET_FLUSHO   0010000
+#define TARGET_PENDIN   0040000
+#define TARGET_IEXTEN   0100000
+
+/* tcflow() and TCXONC use these */
+
+#define TARGET_TCOOFF       0
+#define TARGET_TCOON        1
+#define TARGET_TCIOFF       2
+#define TARGET_TCION        3
+
+/* tcflush() and TCFLSH use these */
+
+#define TARGET_TCIFLUSH 0
+#define TARGET_TCOFLUSH 1
+#define TARGET_TCIOFLUSH    2
+
+/* tcsetattr uses these */
+
+#define TARGET_TCSANOW      0
+#define TARGET_TCSADRAIN    1
+#define TARGET_TCSAFLUSH    2
+
+/* from arch/xtensa/include/uapi/asm/ioctls.h */
+
+#define TARGET_FIOCLEX     _IO('f', 1)
+#define TARGET_FIONCLEX    _IO('f', 2)
+#define TARGET_FIOASYNC    _IOW('f', 125, int)
+#define TARGET_FIONBIO     _IOW('f', 126, int)
+#define TARGET_FIONREAD    _IOR('f', 127, int)
+#define TARGET_TIOCINQ     FIONREAD
+#define TARGET_FIOQSIZE    _IOR('f', 128, loff_t)
+
+#define TARGET_TCGETS      0x5401
+#define TARGET_TCSETS      0x5402
+#define TARGET_TCSETSW     0x5403
+#define TARGET_TCSETSF     0x5404
+
+#define TARGET_TCGETA      0x80127417  /* _IOR('t', 23, struct termio) */
+#define TARGET_TCSETA      0x40127418  /* _IOW('t', 24, struct termio) */
+#define TARGET_TCSETAW     0x40127419  /* _IOW('t', 25, struct termio) */
+#define TARGET_TCSETAF     0x4012741C  /* _IOW('t', 28, struct termio) */
+
+#define TARGET_TCSBRK      _IO('t', 29)
+#define TARGET_TCXONC      _IO('t', 30)
+#define TARGET_TCFLSH      _IO('t', 31)
+
+#define TARGET_TIOCSWINSZ  0x40087467  /* _IOW('t', 103, struct winsize) */
+#define TARGET_TIOCGWINSZ  0x80087468  /* _IOR('t', 104, struct winsize) */
+#define TARGET_TIOCSTART   _IO('t', 110)       /* start output, like ^Q */
+#define TARGET_TIOCSTOP    _IO('t', 111)       /* stop output, like ^S */
+#define TARGET_TIOCOUTQ        _IOR('t', 115, int)     /* output queue size */
+
+#define TARGET_TIOCSPGRP   _IOW('t', 118, int)
+#define TARGET_TIOCGPGRP   _IOR('t', 119, int)
+
+#define TARGET_TIOCEXCL    _IO('T', 12)
+#define TARGET_TIOCNXCL    _IO('T', 13)
+#define TARGET_TIOCSCTTY   _IO('T', 14)
+
+#define TARGET_TIOCSTI     _IOW('T', 18, char)
+#define TARGET_TIOCMGET    _IOR('T', 21, unsigned int)
+#define TARGET_TIOCMBIS    _IOW('T', 22, unsigned int)
+#define TARGET_TIOCMBIC    _IOW('T', 23, unsigned int)
+#define TARGET_TIOCMSET    _IOW('T', 24, unsigned int)
+# define TARGET_TIOCM_LE   0x001
+# define TARGET_TIOCM_DTR  0x002
+# define TARGET_TIOCM_RTS  0x004
+# define TARGET_TIOCM_ST   0x008
+# define TARGET_TIOCM_SR   0x010
+# define TARGET_TIOCM_CTS  0x020
+# define TARGET_TIOCM_CAR  0x040
+# define TARGET_TIOCM_RNG  0x080
+# define TARGET_TIOCM_DSR  0x100
+# define TARGET_TIOCM_CD   TIOCM_CAR
+# define TARGET_TIOCM_RI   TIOCM_RNG
+
+#define TARGET_TIOCGSOFTCAR    _IOR('T', 25, unsigned int)
+#define TARGET_TIOCSSOFTCAR    _IOW('T', 26, unsigned int)
+#define TARGET_TIOCLINUX   _IOW('T', 28, char)
+#define TARGET_TIOCCONS    _IO('T', 29)
+#define TARGET_TIOCGSERIAL 0x803C541E  /*_IOR('T', 30, struct serial_struct)*/
+#define TARGET_TIOCSSERIAL 0x403C541F  /*_IOW('T', 31, struct serial_struct)*/
+#define TARGET_TIOCPKT     _IOW('T', 32, int)
+# define TARGET_TIOCPKT_DATA        0
+# define TARGET_TIOCPKT_FLUSHREAD   1
+# define TARGET_TIOCPKT_FLUSHWRITE  2
+# define TARGET_TIOCPKT_STOP        4
+# define TARGET_TIOCPKT_START       8
+# define TARGET_TIOCPKT_NOSTOP     16
+# define TARGET_TIOCPKT_DOSTOP     32
+# define TARGET_TIOCPKT_IOCTL      64
+
+
+#define TARGET_TIOCNOTTY   _IO('T', 34)
+#define TARGET_TIOCSETD    _IOW('T', 35, int)
+#define TARGET_TIOCGETD    _IOR('T', 36, int)
+#define TARGET_TCSBRKP     _IOW('T', 37, int)   /* Needed for POSIX tcsendbreak()*/
+#define TARGET_TIOCSBRK    _IO('T', 39)         /* BSD compatibility */
+#define TARGET_TIOCCBRK    _IO('T', 40)         /* BSD compatibility */
+#define TARGET_TIOCGSID    _IOR('T', 41, pid_t) /* Return the session ID of FD*/
+#define TARGET_TCGETS2     _IOR('T', 42, struct termios2)
+#define TARGET_TCSETS2     _IOW('T', 43, struct termios2)
+#define TARGET_TCSETSW2    _IOW('T', 44, struct termios2)
+#define TARGET_TCSETSF2    _IOW('T', 45, struct termios2)
+#define TARGET_TIOCGRS485  _IOR('T', 46, struct serial_rs485)
+#define TARGET_TIOCSRS485  _IOWR('T', 47, struct serial_rs485)
+#define TARGET_TIOCGPTN    _IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
+#define TARGET_TIOCSPTLCK  _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TARGET_TIOCGDEV    _IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
+#define TARGET_TIOCSIG     _IOW('T',0x36, int)  /* Generate signal on Pty slave */
+#define TARGET_TIOCVHANGUP _IO('T', 0x37)
+#define TARGET_TIOCGPKT    _IOR('T', 0x38, int) /* Get packet mode state */
+#define TARGET_TIOCGPTLCK  _IOR('T', 0x39, int) /* Get Pty lock state */
+#define TARGET_TIOCGEXCL   _IOR('T', 0x40, int) /* Get exclusive mode state */
+#define TARGET_TIOCGPTPEER _IO('T', 0x41) /* Safely open the slave */
+
+#define TARGET_TIOCSERCONFIG   _IO('T', 83)
+#define TARGET_TIOCSERGWILD    _IOR('T', 84,  int)
+#define TARGET_TIOCSERSWILD    _IOW('T', 85,  int)
+#define TARGET_TIOCGLCKTRMIOS  0x5456
+#define TARGET_TIOCSLCKTRMIOS  0x5457
+#define TARGET_TIOCSERGSTRUCT  0x5458           /* For debugging only */
+#define TARGET_TIOCSERGETLSR   _IOR('T', 89, unsigned int) /* Get line status reg. */
+/* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
+# define TARGET_TIOCSER_TEMT    0x01            /* Transmitter physically empty */
+#define TARGET_TIOCSERGETMULTI 0x80a8545a /* Get multiport config  */
+/* _IOR('T', 90, struct serial_multiport_struct) */
+#define TARGET_TIOCSERSETMULTI 0x40a8545b /* Set multiport config */
+/* _IOW('T', 91, struct serial_multiport_struct) */
+
+#define TARGET_TIOCMIWAIT  _IO('T', 92) /* wait for a change on serial input line(s) */
+#define TARGET_TIOCGICOUNT 0x545D  /* read serial port inline interrupt counts */
+#endif  /* _XTENSA_TERMBITS_H */
diff --git a/target/xtensa/Makefile.objs b/target/xtensa/Makefile.objs
index e15851521f6d..2fae785cb287 100644
--- a/target/xtensa/Makefile.objs
+++ b/target/xtensa/Makefile.objs
@@ -1,10 +1,9 @@
-obj-y += xtensa-semi.o
 obj-y += core-dc232b.o
 obj-y += core-dc233c.o
 obj-y += core-de212.o
 obj-y += core-fsf.o
 obj-y += core-sample_controller.o
-obj-$(CONFIG_SOFTMMU) += monitor.o
+obj-$(CONFIG_SOFTMMU) += monitor.o xtensa-semi.o
 obj-y += xtensa-isa.o
 obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += gdbstub.o
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 4573388a45fa..2b5b53722265 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -45,9 +45,13 @@ static void xtensa_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool xtensa_cpu_has_work(CPUState *cs)
 {
+#ifndef CONFIG_USER_ONLY
     XtensaCPU *cpu = XTENSA_CPU(cs);
 
     return !cpu->env.runstall && cpu->env.pending_irq_level;
+#else
+    return true;
+#endif
 }
 
 /* CPUClass::reset() */
@@ -62,8 +66,16 @@ static void xtensa_cpu_reset(CPUState *s)
     env->exception_taken = 0;
     env->pc = env->config->exception_vector[EXC_RESET0 + env->static_vectors];
     env->sregs[LITBASE] &= ~1;
+#ifndef CONFIG_USER_ONLY
     env->sregs[PS] = xtensa_option_enabled(env->config,
             XTENSA_OPTION_INTERRUPT) ? 0x1f : 0x10;
+    env->pending_irq_level = 0;
+#else
+    env->sregs[PS] =
+        (xtensa_option_enabled(env->config,
+                               XTENSA_OPTION_WINDOWED_REGISTER) ? PS_WOE : 0) |
+        PS_UM | (3 << PS_RING_SHIFT);
+#endif
     env->sregs[VECBASE] = env->config->vecbase;
     env->sregs[IBREAKENABLE] = 0;
     env->sregs[MEMCTL] = MEMCTL_IL0EN & env->config->memctl_mask;
@@ -73,9 +85,10 @@ static void xtensa_cpu_reset(CPUState *s)
     env->sregs[CONFIGID0] = env->config->configid[0];
     env->sregs[CONFIGID1] = env->config->configid[1];
 
-    env->pending_irq_level = 0;
+#ifndef CONFIG_USER_ONLY
     reset_mmu(env);
     s->halted = env->runstall;
+#endif
 }
 
 static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
@@ -104,11 +117,12 @@ static void xtensa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    XtensaCPU *cpu = XTENSA_CPU(dev);
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    xtensa_irq_init(&cpu->env);
+#ifndef CONFIG_USER_ONLY
+    xtensa_irq_init(&XTENSA_CPU(dev)->env);
+#endif
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
@@ -133,11 +147,13 @@ static void xtensa_cpu_initfn(Object *obj)
     cs->env_ptr = env;
     env->config = xcc->config;
 
+#ifndef CONFIG_USER_ONLY
     env->address_space_er = g_malloc(sizeof(*env->address_space_er));
     env->system_er = g_malloc(sizeof(*env->system_er));
     memory_region_init_io(env->system_er, NULL, NULL, env, "er",
                           UINT64_C(0x100000000));
     address_space_init(env->address_space_er, env->system_er, "ER");
+#endif
 }
 
 static const VMStateDescription vmstate_xtensa_cpu = {
@@ -166,7 +182,9 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = xtensa_cpu_gdb_read_register;
     cc->gdb_write_register = xtensa_cpu_gdb_write_register;
     cc->gdb_stop_before_watchpoint = true;
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_USER_ONLY
+    cc->handle_mmu_fault = xtensa_cpu_handle_mmu_fault;
+#else
     cc->do_unaligned_access = xtensa_cpu_do_unaligned_access;
     cc->get_phys_page_debug = xtensa_cpu_get_phys_page_debug;
     cc->do_unassigned_access = xtensa_cpu_do_unassigned_access;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index d9d3b33a7052..957f0fd59a98 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -44,7 +44,11 @@
 #define NB_MMU_MODES 4
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
+#ifdef CONFIG_USER_ONLY
+#define TARGET_VIRT_ADDR_SPACE_BITS 30
+#else
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
+#endif
 #define TARGET_PAGE_BITS 12
 
 enum {
@@ -176,6 +180,7 @@ enum {
 
 #define PS_OWB 0xf00
 #define PS_OWB_SHIFT 8
+#define PS_OWB_LEN 4
 
 #define PS_CALLINC 0x30000
 #define PS_CALLINC_SHIFT 16
@@ -438,6 +443,7 @@ typedef struct CPUXtensaState {
     } fregs[16];
     float_status fp_status;
 
+#ifndef CONFIG_USER_ONLY
     xtensa_tlb_entry itlb[7][MAX_TLB_WAY_SIZE];
     xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
     unsigned autorefill_idx;
@@ -450,6 +456,7 @@ typedef struct CPUXtensaState {
     uint64_t time_base;
     uint64_t ccount_time;
     uint32_t ccount_base;
+#endif
 
     int exception_taken;
     int yield_needed;
@@ -484,6 +491,9 @@ static inline XtensaCPU *xtensa_env_get_cpu(const CPUXtensaState *env)
 
 #define ENV_OFFSET offsetof(XtensaCPU, env)
 
+
+int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int size,
+                                int mmu_idx);
 void xtensa_cpu_do_interrupt(CPUState *cpu);
 bool xtensa_cpu_exec_interrupt(CPUState *cpu, int interrupt_request);
 void xtensa_cpu_do_unassigned_access(CPUState *cpu, hwaddr addr,
@@ -531,26 +541,9 @@ int cpu_xtensa_signal_handler(int host_signum, void *pinfo, void *puc);
 void xtensa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 void xtensa_sync_window_from_phys(CPUXtensaState *env);
 void xtensa_sync_phys_from_window(CPUXtensaState *env);
-uint32_t xtensa_tlb_get_addr_mask(const CPUXtensaState *env, bool dtlb, uint32_t way);
-void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v, bool dtlb,
-        uint32_t *vpn, uint32_t wi, uint32_t *ei);
-int xtensa_tlb_lookup(const CPUXtensaState *env, uint32_t addr, bool dtlb,
-        uint32_t *pwi, uint32_t *pei, uint8_t *pring);
-void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
-        xtensa_tlb_entry *entry, bool dtlb,
-        unsigned wi, unsigned ei, uint32_t vpn, uint32_t pte);
-void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
-        unsigned wi, unsigned ei, uint32_t vpn, uint32_t pte);
-int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
-        uint32_t vaddr, int is_write, int mmu_idx,
-        uint32_t *paddr, uint32_t *page_size, unsigned *access);
-void reset_mmu(CPUXtensaState *env);
-void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUXtensaState *env);
+void xtensa_rotate_window(CPUXtensaState *env, uint32_t delta);
+void xtensa_restore_owb(CPUXtensaState *env);
 void debug_exception_env(CPUXtensaState *new_env, uint32_t cause);
-static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
-{
-    return env->system_er;
-}
 
 static inline void xtensa_select_static_vectors(CPUXtensaState *env,
                                                 unsigned n)
@@ -604,6 +597,29 @@ static inline int xtensa_get_cring(const CPUXtensaState *env)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+uint32_t xtensa_tlb_get_addr_mask(const CPUXtensaState *env,
+                                  bool dtlb, uint32_t way);
+void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v, bool dtlb,
+        uint32_t *vpn, uint32_t wi, uint32_t *ei);
+int xtensa_tlb_lookup(const CPUXtensaState *env, uint32_t addr, bool dtlb,
+        uint32_t *pwi, uint32_t *pei, uint8_t *pring);
+void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
+        xtensa_tlb_entry *entry, bool dtlb,
+        unsigned wi, unsigned ei, uint32_t vpn, uint32_t pte);
+void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
+        unsigned wi, unsigned ei, uint32_t vpn, uint32_t pte);
+int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
+        uint32_t vaddr, int is_write, int mmu_idx,
+        uint32_t *paddr, uint32_t *page_size, unsigned *access);
+void reset_mmu(CPUXtensaState *env);
+void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUXtensaState *env);
+
+static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
+{
+    return env->system_er;
+}
+
 static inline xtensa_tlb_entry *xtensa_tlb_get_entry(CPUXtensaState *env,
         bool dtlb, unsigned wi, unsigned ei)
 {
@@ -611,6 +627,7 @@ static inline xtensa_tlb_entry *xtensa_tlb_get_entry(CPUXtensaState *env,
         env->dtlb[wi] + ei :
         env->itlb[wi] + ei;
 }
+#endif
 
 static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 {
@@ -623,6 +640,7 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 #define MMU_MODE1_SUFFIX _ring1
 #define MMU_MODE2_SUFFIX _ring2
 #define MMU_MODE3_SUFFIX _ring3
+#define MMU_USER_IDX 3
 
 static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
 {
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 34885038d554..34844eead358 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -173,6 +173,7 @@ void xtensa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 
 hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
+#ifndef CONFIG_USER_ONLY
     XtensaCPU *cpu = XTENSA_CPU(cs);
     uint32_t paddr;
     uint32_t page_size;
@@ -187,8 +188,13 @@ hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         return paddr;
     }
     return ~0;
+#else
+    return addr;
+#endif
 }
 
+#ifndef CONFIG_USER_ONLY
+
 static uint32_t relocated_vector(CPUXtensaState *env, uint32_t vector)
 {
     if (xtensa_option_enabled(env->config,
@@ -298,6 +304,11 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
     }
     check_interrupts(env);
 }
+#else
+void xtensa_cpu_do_interrupt(CPUState *cs)
+{
+}
+#endif
 
 bool xtensa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
@@ -309,6 +320,25 @@ bool xtensa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
+#ifdef CONFIG_USER_ONLY
+
+int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
+                                int mmu_idx)
+{
+    XtensaCPU *cpu = XTENSA_CPU(cs);
+    CPUXtensaState *env = &cpu->env;
+
+    qemu_log_mask(CPU_LOG_INT,
+                  "%s: rw = %d, address = 0x%08" VADDR_PRIx ", size = %d\n",
+                  __func__, rw, address, size);
+    env->sregs[EXCVADDR] = address;
+    env->sregs[EXCCAUSE] = rw ? STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE;
+    cs->exception_index = EXC_USER;
+    return 1;
+}
+
+#else
+
 static void reset_tlb_mmu_all_ways(CPUXtensaState *env,
         const xtensa_tlb *tlb, xtensa_tlb_entry entry[][MAX_TLB_WAY_SIZE])
 {
@@ -769,3 +799,4 @@ void xtensa_runstall(CPUXtensaState *env, bool runstall)
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
     }
 }
+#endif
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index cc751c98fbd0..73444ae02ccd 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -12,9 +12,12 @@ DEF_HELPER_1(restore_owb, void, env)
 DEF_HELPER_2(movsp, void, env, i32)
 DEF_HELPER_2(wsr_lbeg, void, env, i32)
 DEF_HELPER_2(wsr_lend, void, env, i32)
+#ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(simcall, void, env)
+#endif
 DEF_HELPER_1(dump_state, void, env)
 
+#ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(waiti, void, env, i32, i32)
 DEF_HELPER_1(update_ccount, void, env)
 DEF_HELPER_2(wsr_ccount, void, env, i32)
@@ -35,6 +38,7 @@ DEF_HELPER_2(wsr_ibreakenable, void, env, i32)
 DEF_HELPER_3(wsr_ibreaka, void, env, i32, i32)
 DEF_HELPER_3(wsr_dbreaka, void, env, i32, i32)
 DEF_HELPER_3(wsr_dbreakc, void, env, i32, i32)
+#endif
 
 DEF_HELPER_2(wur_fcr, void, env, i32)
 DEF_HELPER_FLAGS_1(abs_s, TCG_CALL_NO_RWG_SE, f32, f32)
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 7486b9979935..d401105d096b 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -36,6 +36,13 @@
 #include "qemu/timer.h"
 #include "fpu/softfloat.h"
 
+#ifdef CONFIG_USER_ONLY
+/* tb_invalidate_phys_range */
+#include "accel/tcg/translate-all.h"
+#endif
+
+#ifndef CONFIG_USER_ONLY
+
 void xtensa_cpu_do_unaligned_access(CPUState *cs,
         vaddr addr, MMUAccessType access_type,
         int mmu_idx, uintptr_t retaddr)
@@ -102,6 +109,17 @@ static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
     }
 }
 
+#else
+
+static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
+{
+    mmap_lock();
+    tb_invalidate_phys_range(vaddr, vaddr + 1);
+    mmap_unlock();
+}
+
+#endif
+
 void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
 {
     CPUState *cs = CPU(xtensa_env_get_cpu(env));
@@ -219,21 +237,21 @@ void xtensa_sync_phys_from_window(CPUXtensaState *env)
     copy_phys_from_window(env, env->sregs[WINDOW_BASE] * 4, 0, 16);
 }
 
-static void rotate_window_abs(CPUXtensaState *env, uint32_t position)
+static void xtensa_rotate_window_abs(CPUXtensaState *env, uint32_t position)
 {
     xtensa_sync_phys_from_window(env);
     env->sregs[WINDOW_BASE] = windowbase_bound(position, env);
     xtensa_sync_window_from_phys(env);
 }
 
-static void rotate_window(CPUXtensaState *env, uint32_t delta)
+void xtensa_rotate_window(CPUXtensaState *env, uint32_t delta)
 {
-    rotate_window_abs(env, env->sregs[WINDOW_BASE] + delta);
+    xtensa_rotate_window_abs(env, env->sregs[WINDOW_BASE] + delta);
 }
 
 void HELPER(wsr_windowbase)(CPUXtensaState *env, uint32_t v)
 {
-    rotate_window_abs(env, v);
+    xtensa_rotate_window_abs(env, v);
 }
 
 void HELPER(entry)(CPUXtensaState *env, uint32_t pc, uint32_t s, uint32_t imm)
@@ -251,7 +269,7 @@ void HELPER(entry)(CPUXtensaState *env, uint32_t pc, uint32_t s, uint32_t imm)
             HELPER(window_check)(env, pc, callinc);
         }
         env->regs[(callinc << 2) | (s & 3)] = env->regs[s] - imm;
-        rotate_window(env, callinc);
+        xtensa_rotate_window(env, callinc);
         env->sregs[WINDOW_START] |=
             windowstart_bit(env->sregs[WINDOW_BASE], env);
     }
@@ -266,7 +284,7 @@ void HELPER(window_check)(CPUXtensaState *env, uint32_t pc, uint32_t w)
 
     assert(n <= w);
 
-    rotate_window(env, n);
+    xtensa_rotate_window(env, n);
     env->sregs[PS] = (env->sregs[PS] & ~PS_OWB) |
         (windowbase << PS_OWB_SHIFT) | PS_EXCM;
     env->sregs[EPC1] = env->pc = pc;
@@ -311,7 +329,7 @@ uint32_t HELPER(retw)(CPUXtensaState *env, uint32_t pc)
 
         ret_pc = (pc & 0xc0000000) | (env->regs[0] & 0x3fffffff);
 
-        rotate_window(env, -n);
+        xtensa_rotate_window(env, -n);
         if (windowstart & windowstart_bit(env->sregs[WINDOW_BASE], env)) {
             env->sregs[WINDOW_START] &= ~windowstart_bit(owb, env);
         } else {
@@ -334,12 +352,17 @@ uint32_t HELPER(retw)(CPUXtensaState *env, uint32_t pc)
 
 void HELPER(rotw)(CPUXtensaState *env, uint32_t imm4)
 {
-    rotate_window(env, imm4);
+    xtensa_rotate_window(env, imm4);
+}
+
+void xtensa_restore_owb(CPUXtensaState *env)
+{
+    xtensa_rotate_window_abs(env, (env->sregs[PS] & PS_OWB) >> PS_OWB_SHIFT);
 }
 
 void HELPER(restore_owb)(CPUXtensaState *env)
 {
-    rotate_window_abs(env, (env->sregs[PS] & PS_OWB) >> PS_OWB_SHIFT);
+    xtensa_restore_owb(env);
 }
 
 void HELPER(movsp)(CPUXtensaState *env, uint32_t pc)
@@ -376,6 +399,8 @@ void HELPER(dump_state)(CPUXtensaState *env)
     cpu_dump_state(CPU(cpu), stderr, fprintf, 0);
 }
 
+#ifndef CONFIG_USER_ONLY
+
 void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
 {
     CPUState *cpu;
@@ -888,6 +913,7 @@ void HELPER(wsr_dbreakc)(CPUXtensaState *env, uint32_t i, uint32_t v)
     }
     env->sregs[DBREAKC + i] = v;
 }
+#endif
 
 void HELPER(wur_fcr)(CPUXtensaState *env, uint32_t v)
 {
@@ -1025,12 +1051,18 @@ void HELPER(ule_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
 
 uint32_t HELPER(rer)(CPUXtensaState *env, uint32_t addr)
 {
+#ifndef CONFIG_USER_ONLY
     return address_space_ldl(env->address_space_er, addr,
                              MEMTXATTRS_UNSPECIFIED, NULL);
+#else
+    return 0;
+#endif
 }
 
 void HELPER(wer)(CPUXtensaState *env, uint32_t data, uint32_t addr)
 {
+#ifndef CONFIG_USER_ONLY
     address_space_stl(env->address_space_er, addr, data,
                       MEMTXATTRS_UNSPECIFIED, NULL);
+#endif
 }
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index c06d30d17960..4f6d03059feb 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -345,12 +345,14 @@ static void gen_debug_exception(DisasContext *dc, uint32_t cause)
 
 static bool gen_check_privilege(DisasContext *dc)
 {
-    if (dc->cring) {
-        gen_exception_cause(dc, PRIVILEGED_CAUSE);
-        dc->is_jmp = DISAS_UPDATE;
-        return false;
+#ifndef CONFIG_USER_ONLY
+    if (!dc->cring) {
+        return true;
     }
-    return true;
+#endif
+    gen_exception_cause(dc, PRIVILEGED_CAUSE);
+    dc->is_jmp = DISAS_UPDATE;
+    return false;
 }
 
 static bool gen_check_cpenable(DisasContext *dc, unsigned cp)
@@ -498,6 +500,7 @@ static bool gen_check_sr(DisasContext *dc, uint32_t sr, unsigned access)
     return true;
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool gen_rsr_ccount(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 {
     if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
@@ -519,14 +522,17 @@ static bool gen_rsr_ptevaddr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
     tcg_gen_andi_i32(d, d, 0xfffffffc);
     return false;
 }
+#endif
 
 static bool gen_rsr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 {
     static bool (* const rsr_handler[256])(DisasContext *dc,
             TCGv_i32 d, uint32_t sr) = {
+#ifndef CONFIG_USER_ONLY
         [CCOUNT] = gen_rsr_ccount,
         [INTSET] = gen_rsr_ccount,
         [PTEVADDR] = gen_rsr_ptevaddr,
+#endif
     };
 
     if (rsr_handler[sr]) {
@@ -582,6 +588,7 @@ static bool gen_wsr_acchi(DisasContext *dc, uint32_t sr, TCGv_i32 s)
     return false;
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool gen_wsr_windowbase(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     gen_helper_wsr_windowbase(cpu_env, v);
@@ -797,6 +804,11 @@ static bool gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     }
     return ret;
 }
+#else
+static void gen_check_interrupts(DisasContext *dc)
+{
+}
+#endif
 
 static bool gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
@@ -808,6 +820,7 @@ static bool gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
         [BR] = gen_wsr_br,
         [LITBASE] = gen_wsr_litbase,
         [ACCHI] = gen_wsr_acchi,
+#ifndef CONFIG_USER_ONLY
         [WINDOW_BASE] = gen_wsr_windowbase,
         [WINDOW_START] = gen_wsr_windowstart,
         [PTEVADDR] = gen_wsr_ptevaddr,
@@ -834,6 +847,7 @@ static bool gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
         [CCOMPARE] = gen_wsr_ccompare,
         [CCOMPARE + 1] = gen_wsr_ccompare,
         [CCOMPARE + 2] = gen_wsr_ccompare,
+#endif
     };
 
     if (wsr_handler[sr]) {
@@ -878,6 +892,7 @@ static void gen_load_store_alignment(DisasContext *dc, int shift,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static void gen_waiti(DisasContext *dc, uint32_t imm4)
 {
     TCGv_i32 pc = tcg_const_i32(dc->next_pc);
@@ -894,6 +909,7 @@ static void gen_waiti(DisasContext *dc, uint32_t imm4)
     tcg_temp_free(intlevel);
     gen_jumpi_check_loop_end(dc, 0);
 }
+#endif
 
 static bool gen_window_check1(DisasContext *dc, unsigned r1)
 {
@@ -1596,12 +1612,14 @@ static void translate_icache(DisasContext *dc, const uint32_t arg[],
 {
     if ((!par[0] || gen_check_privilege(dc)) &&
         gen_window_check1(dc, arg[0]) && par[1]) {
+#ifndef CONFIG_USER_ONLY
         TCGv_i32 addr = tcg_temp_new_i32();
 
         tcg_gen_movi_i32(cpu_pc, dc->pc);
         tcg_gen_addi_i32(addr, cpu_R[arg[0]], arg[1]);
         gen_helper_itlb_hit_test(cpu_env, addr);
         tcg_temp_free(addr);
+#endif
     }
 }
 
@@ -1610,12 +1628,14 @@ static void translate_itlb(DisasContext *dc, const uint32_t arg[],
 {
     if (gen_check_privilege(dc) &&
         gen_window_check1(dc, arg[0])) {
+#ifndef CONFIG_USER_ONLY
         TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
         gen_helper_itlb(cpu_env, cpu_R[arg[0]], dtlb);
         /* This could change memory mapping, so exit tb */
         gen_jumpi_check_loop_end(dc, -1);
         tcg_temp_free(dtlb);
+#endif
     }
 }
 
@@ -1985,11 +2005,13 @@ static void translate_ptlb(DisasContext *dc, const uint32_t arg[],
 {
     if (gen_check_privilege(dc) &&
         gen_window_check2(dc, arg[0], arg[1])) {
+#ifndef CONFIG_USER_ONLY
         TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
         tcg_gen_movi_i32(cpu_pc, dc->pc);
         gen_helper_ptlb(cpu_R[arg[0]], cpu_env, cpu_R[arg[1]], dtlb);
         tcg_temp_free(dtlb);
+#endif
     }
 }
 
@@ -2173,8 +2195,10 @@ static void translate_rtlb(DisasContext *dc, const uint32_t arg[],
 {
     static void (* const helper[])(TCGv_i32 r, TCGv_env env, TCGv_i32 a1,
                                    TCGv_i32 a2) = {
+#ifndef CONFIG_USER_ONLY
         gen_helper_rtlb0,
         gen_helper_rtlb1,
+#endif
     };
 
     if (gen_check_privilege(dc) &&
@@ -2283,11 +2307,14 @@ static void translate_sext(DisasContext *dc, const uint32_t arg[],
 static void translate_simcall(DisasContext *dc, const uint32_t arg[],
                               const uint32_t par[])
 {
+#ifndef CONFIG_USER_ONLY
     if (semihosting_enabled()) {
         if (gen_check_privilege(dc)) {
             gen_helper_simcall(cpu_env);
         }
-    } else {
+    } else
+#endif
+    {
         qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
         gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
     }
@@ -2470,7 +2497,9 @@ static void translate_waiti(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
     if (gen_check_privilege(dc)) {
+#ifndef CONFIG_USER_ONLY
         gen_waiti(dc, arg[0]);
+#endif
     }
 }
 
@@ -2479,12 +2508,14 @@ static void translate_wtlb(DisasContext *dc, const uint32_t arg[],
 {
     if (gen_check_privilege(dc) &&
         gen_window_check2(dc, arg[0], arg[1])) {
+#ifndef CONFIG_USER_ONLY
         TCGv_i32 dtlb = tcg_const_i32(par[0]);
 
         gen_helper_wtlb(cpu_env, cpu_R[arg[0]], cpu_R[arg[1]], dtlb);
         /* This could change memory mapping, so exit tb */
         gen_jumpi_check_loop_end(dc, -1);
         tcg_temp_free(dtlb);
+#endif
     }
 }
 
-- 
2.11.0
