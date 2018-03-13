Received: from eggs.gnu.org ([2001:4830:134:3::10]:55290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoX-0008Qv-N3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoU-0007j2-7b
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:17 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnoT-0007hb-MC
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:14 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:38 +0100
Message-Id: <20180313173355.4468-2-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 01/18] linux-user: Drop unicore32 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

We dropped the unicore32-linux-user target in commit 5e2b40f7271cf9
in 2016. Nobody has made any attempt to fix the issues that
caused us to drop it, so remove the associated code.
(The system emulation parts of unicore32 remain.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180308144733.25615-2-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c                  |  72 -------
 linux-user/main.c                     |  99 +--------
 linux-user/qemu.h                     |   5 +-
 linux-user/signal.c                   |   5 +-
 linux-user/syscall_defs.h             |   6 +-
 linux-user/unicore32/syscall_nr.h     | 371 ----------------------------------
 linux-user/unicore32/target_cpu.h     |  27 ---
 linux-user/unicore32/target_elf.h     |  14 --
 linux-user/unicore32/target_signal.h  |  30 ---
 linux-user/unicore32/target_structs.h |  58 ------
 linux-user/unicore32/target_syscall.h |  62 ------
 linux-user/unicore32/termbits.h       |   2 -
 12 files changed, 6 insertions(+), 745 deletions(-)
 delete mode 100644 linux-user/unicore32/syscall_nr.h
 delete mode 100644 linux-user/unicore32/target_cpu.h
 delete mode 100644 linux-user/unicore32/target_elf.h
 delete mode 100644 linux-user/unicore32/target_signal.h
 delete mode 100644 linux-user/unicore32/target_structs.h
 delete mode 100644 linux-user/unicore32/target_syscall.h
 delete mode 100644 linux-user/unicore32/termbits.h

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5fc130cc20..85462d30db 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -563,78 +563,6 @@ static uint32_t get_elf_hwcap(void)
 #endif /* not TARGET_AARCH64 */
 #endif /* TARGET_ARM */
 
-#ifdef TARGET_UNICORE32
-
-#define ELF_START_MMAP          0x80000000
-
-#define ELF_CLASS               ELFCLASS32
-#define ELF_DATA                ELFDATA2LSB
-#define ELF_ARCH                EM_UNICORE32
-
-static inline void init_thread(struct target_pt_regs *regs,
-        struct image_info *infop)
-{
-    abi_long stack = infop->start_stack;
-    memset(regs, 0, sizeof(*regs));
-    regs->UC32_REG_asr = 0x10;
-    regs->UC32_REG_pc = infop->entry & 0xfffffffe;
-    regs->UC32_REG_sp = infop->start_stack;
-    /* FIXME - what to for failure of get_user()? */
-    get_user_ual(regs->UC32_REG_02, stack + 8); /* envp */
-    get_user_ual(regs->UC32_REG_01, stack + 4); /* envp */
-    /* XXX: it seems that r0 is zeroed after ! */
-    regs->UC32_REG_00 = 0;
-}
-
-#define ELF_NREG    34
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
-
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUUniCore32State *env)
-{
-    (*regs)[0] = env->regs[0];
-    (*regs)[1] = env->regs[1];
-    (*regs)[2] = env->regs[2];
-    (*regs)[3] = env->regs[3];
-    (*regs)[4] = env->regs[4];
-    (*regs)[5] = env->regs[5];
-    (*regs)[6] = env->regs[6];
-    (*regs)[7] = env->regs[7];
-    (*regs)[8] = env->regs[8];
-    (*regs)[9] = env->regs[9];
-    (*regs)[10] = env->regs[10];
-    (*regs)[11] = env->regs[11];
-    (*regs)[12] = env->regs[12];
-    (*regs)[13] = env->regs[13];
-    (*regs)[14] = env->regs[14];
-    (*regs)[15] = env->regs[15];
-    (*regs)[16] = env->regs[16];
-    (*regs)[17] = env->regs[17];
-    (*regs)[18] = env->regs[18];
-    (*regs)[19] = env->regs[19];
-    (*regs)[20] = env->regs[20];
-    (*regs)[21] = env->regs[21];
-    (*regs)[22] = env->regs[22];
-    (*regs)[23] = env->regs[23];
-    (*regs)[24] = env->regs[24];
-    (*regs)[25] = env->regs[25];
-    (*regs)[26] = env->regs[26];
-    (*regs)[27] = env->regs[27];
-    (*regs)[28] = env->regs[28];
-    (*regs)[29] = env->regs[29];
-    (*regs)[30] = env->regs[30];
-    (*regs)[31] = env->regs[31];
-
-    (*regs)[32] = cpu_asr_read((CPUUniCore32State *)env);
-    (*regs)[33] = env->regs[0]; /* XXX */
-}
-
-#define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE               4096
-
-#define ELF_HWCAP                       (UC32_HWCAP_CMOV | UC32_HWCAP_UCF64)
-
-#endif
-
 #ifdef TARGET_SPARC
 #ifdef TARGET_SPARC64
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 7bc9bc79b0..b5d5e9cf4d 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -884,95 +884,6 @@ void cpu_loop(CPUARMState *env)
 
 #endif
 
-#ifdef TARGET_UNICORE32
-
-void cpu_loop(CPUUniCore32State *env)
-{
-    CPUState *cs = CPU(uc32_env_get_cpu(env));
-    int trapnr;
-    unsigned int n, insn;
-    target_siginfo_t info;
-
-    for (;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
-
-        switch (trapnr) {
-        case UC32_EXCP_PRIV:
-            {
-                /* system call */
-                get_user_u32(insn, env->regs[31] - 4);
-                n = insn & 0xffffff;
-
-                if (n >= UC32_SYSCALL_BASE) {
-                    /* linux syscall */
-                    n -= UC32_SYSCALL_BASE;
-                    if (n == UC32_SYSCALL_NR_set_tls) {
-                            cpu_set_tls(env, env->regs[0]);
-                            env->regs[0] = 0;
-                    } else {
-                        abi_long ret = do_syscall(env,
-                                                  n,
-                                                  env->regs[0],
-                                                  env->regs[1],
-                                                  env->regs[2],
-                                                  env->regs[3],
-                                                  env->regs[4],
-                                                  env->regs[5],
-                                                  0, 0);
-                        if (ret == -TARGET_ERESTARTSYS) {
-                            env->regs[31] -= 4;
-                        } else if (ret != -TARGET_QEMU_ESIGRETURN) {
-                            env->regs[0] = ret;
-                        }
-                    }
-                } else {
-                    goto error;
-                }
-            }
-            break;
-        case UC32_EXCP_DTRAP:
-        case UC32_EXCP_ITRAP:
-            info.si_signo = TARGET_SIGSEGV;
-            info.si_errno = 0;
-            /* XXX: check env->error_code */
-            info.si_code = TARGET_SEGV_MAPERR;
-            info._sifields._sigfault._addr = env->cp0.c4_faultaddr;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_INTERRUPT:
-            /* just indicate that signals should be handled asap */
-            break;
-        case EXCP_DEBUG:
-            {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig) {
-                    info.si_signo = sig;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                }
-            }
-            break;
-        case EXCP_ATOMIC:
-            cpu_exec_step_atomic(cs);
-            break;
-        default:
-            goto error;
-        }
-        process_pending_signals(env);
-    }
-
-error:
-    EXCP_DUMP(env, "qemu: unhandled CPU exception 0x%x - aborting\n", trapnr);
-    abort();
-}
-#endif
-
 #ifdef TARGET_SPARC
 #define SPARC64_STACK_BIAS 2047
 
@@ -4737,14 +4648,6 @@ int main(int argc, char **argv, char **envp)
         }
 #endif
     }
-#elif defined(TARGET_UNICORE32)
-    {
-        int i;
-        cpu_asr_write(env, regs->uregs[32], 0xffffffff);
-        for (i = 0; i < 32; i++) {
-            env->regs[i] = regs->uregs[i];
-        }
-    }
 #elif defined(TARGET_SPARC)
     {
         int i;
@@ -4974,7 +4877,7 @@ int main(int argc, char **argv, char **envp)
 #error unsupported target CPU
 #endif
 
-#if defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_UNICORE32)
+#if defined(TARGET_ARM) || defined(TARGET_M68K)
     ts->stack_base = info->start_stack;
     ts->heap_base = info->brk;
     /* This will be filled in on the first SYS_HEAPINFO call.  */
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index f4b4ca72ad..7a1a1ff57a 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -100,9 +100,6 @@ typedef struct TaskState {
 # endif
     int swi_errno;
 #endif
-#ifdef TARGET_UNICORE32
-    int swi_errno;
-#endif
 #if defined(TARGET_I386) && !defined(TARGET_X86_64)
     abi_ulong target_v86;
     struct vm86_saved_state vm86_saved_regs;
@@ -115,7 +112,7 @@ typedef struct TaskState {
     int sim_syscalls;
     abi_ulong tp_value;
 #endif
-#if defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_UNICORE32)
+#if defined(TARGET_ARM) || defined(TARGET_M68K)
     /* Extra fields for semihosted binaries.  */
     abi_ulong heap_base;
     abi_ulong heap_limit;
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 4d3f244612..3a5bd2732a 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -253,8 +253,7 @@ int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
     return 0;
 }
 
-#if !defined(TARGET_OPENRISC) && !defined(TARGET_UNICORE32) && \
-    !defined(TARGET_NIOS2)
+#if !defined(TARGET_OPENRISC) && !defined(TARGET_NIOS2)
 /* Just set the guest's signal mask to the specified value; the
  * caller is assumed to have called block_signals() already.
  */
@@ -512,7 +511,6 @@ void signal_init(void)
     }
 }
 
-#ifndef TARGET_UNICORE32
 /* Force a synchronously taken signal. The kernel force_sig() function
  * also forces the signal to "not blocked, not ignored", but for QEMU
  * that work is done in process_pending_signals().
@@ -546,7 +544,6 @@ static void force_sigsegv(int oldsig)
     }
     force_sig(TARGET_SIGSEGV);
 }
-#endif
 
 #endif
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index e00e1b3862..13aa70b93b 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -69,7 +69,7 @@
 
 #if defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_SH4) \
     || defined(TARGET_M68K) || defined(TARGET_CRIS) \
-    || defined(TARGET_UNICORE32) || defined(TARGET_S390X) \
+    || defined(TARGET_S390X) \
     || defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) \
     || defined(TARGET_NIOS2) || defined(TARGET_RISCV)
 
@@ -433,7 +433,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #if defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_SPARC) \
     || defined(TARGET_PPC) || defined(TARGET_MIPS) || defined(TARGET_SH4) \
     || defined(TARGET_M68K) || defined(TARGET_ALPHA) || defined(TARGET_CRIS) \
-    || defined(TARGET_MICROBLAZE) || defined(TARGET_UNICORE32) \
+    || defined(TARGET_MICROBLAZE) \
     || defined(TARGET_S390X) || defined(TARGET_OPENRISC) \
     || defined(TARGET_TILEGX) || defined(TARGET_HPPA) || defined(TARGET_NIOS2) \
     || defined(TARGET_RISCV)
@@ -1409,7 +1409,7 @@ struct target_winsize {
 
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) \
     || (defined(TARGET_ARM) && defined(TARGET_ABI32)) \
-    || defined(TARGET_CRIS) || defined(TARGET_UNICORE32)
+    || defined(TARGET_CRIS)
 struct target_stat {
 	unsigned short st_dev;
 	unsigned short __pad1;
diff --git a/linux-user/unicore32/syscall_nr.h b/linux-user/unicore32/syscall_nr.h
deleted file mode 100644
index 486b8c45a0..0000000000
--- a/linux-user/unicore32/syscall_nr.h
+++ /dev/null
@@ -1,371 +0,0 @@
-/*
- * This file contains the system call numbers for UniCore32 oldabi.
- *
- * Copyright (C) 2010-2011 GUAN Xue-tao
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#define TARGET_NR_restart_syscall               0
-#define TARGET_NR_exit                          1
-#define TARGET_NR_fork                          2
-#define TARGET_NR_read                          3
-#define TARGET_NR_write                         4
-#define TARGET_NR_open                          5
-#define TARGET_NR_close                         6
-#define TARGET_NR_waitpid                       7
-#define TARGET_NR_creat                         8
-#define TARGET_NR_link                          9
-#define TARGET_NR_unlink                        10
-#define TARGET_NR_execve                        11
-#define TARGET_NR_chdir                         12
-#define TARGET_NR_time                          13
-#define TARGET_NR_mknod                         14
-#define TARGET_NR_chmod                         15
-#define TARGET_NR_lchown                        16
-#define TARGET_NR_break                         17
-                                                /* 18 */
-#define TARGET_NR_lseek                         19
-#define TARGET_NR_getpid                        20
-#define TARGET_NR_mount                         21
-#define TARGET_NR_umount                        22
-#define TARGET_NR_setuid                        23
-#define TARGET_NR_getuid                        24
-#define TARGET_NR_stime                         25
-#define TARGET_NR_ptrace                        26
-#define TARGET_NR_alarm                         27
-                                                /* 28 */
-#define TARGET_NR_pause                         29
-#define TARGET_NR_utime                         30
-#define TARGET_NR_stty                          31
-#define TARGET_NR_gtty                          32
-#define TARGET_NR_access                        33
-#define TARGET_NR_nice                          34
-#define TARGET_NR_ftime                         35
-#define TARGET_NR_sync                          36
-#define TARGET_NR_kill                          37
-#define TARGET_NR_rename                        38
-#define TARGET_NR_mkdir                         39
-#define TARGET_NR_rmdir                         40
-#define TARGET_NR_dup                           41
-#define TARGET_NR_pipe                          42
-#define TARGET_NR_times                         43
-#define TARGET_NR_prof                          44
-#define TARGET_NR_brk                           45
-#define TARGET_NR_setgid                        46
-#define TARGET_NR_getgid                        47
-#define TARGET_NR_signal                        48
-#define TARGET_NR_geteuid                       49
-#define TARGET_NR_getegid                       50
-#define TARGET_NR_acct                          51
-#define TARGET_NR_umount2                       52
-#define TARGET_NR_lock                          53
-#define TARGET_NR_ioctl                         54
-#define TARGET_NR_fcntl                         55
-#define TARGET_NR_mpx                           56
-#define TARGET_NR_setpgid                       57
-#define TARGET_NR_ulimit                        58
-                                                /* 59 */
-#define TARGET_NR_umask                         60
-#define TARGET_NR_chroot                        61
-#define TARGET_NR_ustat                         62
-#define TARGET_NR_dup2                          63
-#define TARGET_NR_getppid                       64
-#define TARGET_NR_getpgrp                       65
-#define TARGET_NR_setsid                        66
-#define TARGET_NR_sigaction                     67
-#define TARGET_NR_sgetmask                      68
-#define TARGET_NR_ssetmask                      69
-#define TARGET_NR_setreuid                      70
-#define TARGET_NR_setregid                      71
-#define TARGET_NR_sigsuspend                    72
-#define TARGET_NR_sigpending                    73
-#define TARGET_NR_sethostname                   74
-#define TARGET_NR_setrlimit                     75
-#define TARGET_NR_getrlimit                     76
-#define TARGET_NR_getrusage                     77
-#define TARGET_NR_gettimeofday                  78
-#define TARGET_NR_settimeofday                  79
-#define TARGET_NR_getgroups                     80
-#define TARGET_NR_setgroups                     81
-#define TARGET_NR_select                        82
-#define TARGET_NR_symlink                       83
-                                                /* 84 */
-#define TARGET_NR_readlink                      85
-#define TARGET_NR_uselib                        86
-#define TARGET_NR_swapon                        87
-#define TARGET_NR_reboot                        88
-#define TARGET_NR_readdir                       89
-#define TARGET_NR_mmap                          90
-#define TARGET_NR_munmap                        91
-#define TARGET_NR_truncate                      92
-#define TARGET_NR_ftruncate                     93
-#define TARGET_NR_fchmod                        94
-#define TARGET_NR_fchown                        95
-#define TARGET_NR_getpriority                   96
-#define TARGET_NR_setpriority                   97
-#define TARGET_NR_profil                        98
-#define TARGET_NR_statfs                        99
-#define TARGET_NR_fstatfs                       100
-#define TARGET_NR_ioperm                        101
-#define TARGET_NR_socketcall                    102
-#define TARGET_NR_syslog                        103
-#define TARGET_NR_setitimer                     104
-#define TARGET_NR_getitimer                     105
-#define TARGET_NR_stat                          106
-#define TARGET_NR_lstat                         107
-#define TARGET_NR_fstat                         108
-                                                /* 109 */
-                                                /* 110 */
-#define TARGET_NR_vhangup                       111
-#define TARGET_NR_idle                          112
-#define TARGET_NR_syscall                       113
-#define TARGET_NR_wait4                         114
-#define TARGET_NR_swapoff                       115
-#define TARGET_NR_sysinfo                       116
-#define TARGET_NR_ipc                           117
-#define TARGET_NR_fsync                         118
-#define TARGET_NR_sigreturn                     119
-#define TARGET_NR_clone                         120
-#define TARGET_NR_setdomainname                 121
-#define TARGET_NR_uname                         122
-#define TARGET_NR_modify_ldt                    123
-#define TARGET_NR_adjtimex                      124
-#define TARGET_NR_mprotect                      125
-#define TARGET_NR_sigprocmask                   126
-#define TARGET_NR_create_module                 127
-#define TARGET_NR_init_module                   128
-#define TARGET_NR_delete_module                 129
-#define TARGET_NR_get_kernel_syms               130
-#define TARGET_NR_quotactl                      131
-#define TARGET_NR_getpgid                       132
-#define TARGET_NR_fchdir                        133
-#define TARGET_NR_bdflush                       134
-#define TARGET_NR_sysfs                         135
-#define TARGET_NR_personality                   136
-#define TARGET_NR_afs_syscall                   137
-#define TARGET_NR_setfsuid                      138
-#define TARGET_NR_setfsgid                      139
-#define TARGET_NR__llseek                       140
-#define TARGET_NR_getdents                      141
-#define TARGET_NR__newselect                    142
-#define TARGET_NR_flock                         143
-#define TARGET_NR_msync                         144
-#define TARGET_NR_readv                         145
-#define TARGET_NR_writev                        146
-#define TARGET_NR_getsid                        147
-#define TARGET_NR_fdatasync                     148
-#define TARGET_NR__sysctl                       149
-#define TARGET_NR_mlock                         150
-#define TARGET_NR_munlock                       151
-#define TARGET_NR_mlockall                      152
-#define TARGET_NR_munlockall                    153
-#define TARGET_NR_sched_setparam                154
-#define TARGET_NR_sched_getparam                155
-#define TARGET_NR_sched_setscheduler            156
-#define TARGET_NR_sched_getscheduler            157
-#define TARGET_NR_sched_yield                   158
-#define TARGET_NR_sched_get_priority_max        159
-#define TARGET_NR_sched_get_priority_min        160
-#define TARGET_NR_sched_rr_get_interval         161
-#define TARGET_NR_nanosleep                     162
-#define TARGET_NR_mremap                        163
-#define TARGET_NR_setresuid                     164
-#define TARGET_NR_getresuid                     165
-#define TARGET_NR_vm86                          166
-#define TARGET_NR_query_module                  167
-#define TARGET_NR_poll                          168
-#define TARGET_NR_nfsservctl                    169
-#define TARGET_NR_setresgid                     170
-#define TARGET_NR_getresgid                     171
-#define TARGET_NR_prctl                         172
-#define TARGET_NR_rt_sigreturn                  173
-#define TARGET_NR_rt_sigaction                  174
-#define TARGET_NR_rt_sigprocmask                175
-#define TARGET_NR_rt_sigpending                 176
-#define TARGET_NR_rt_sigtimedwait               177
-#define TARGET_NR_rt_sigqueueinfo               178
-#define TARGET_NR_rt_sigsuspend                 179
-#define TARGET_NR_pread64                       180
-#define TARGET_NR_pwrite64                      181
-#define TARGET_NR_chown                         182
-#define TARGET_NR_getcwd                        183
-#define TARGET_NR_capget                        184
-#define TARGET_NR_capset                        185
-#define TARGET_NR_sigaltstack                   186
-#define TARGET_NR_sendfile                      187
-                                                /* 188 */
-                                                /* 189 */
-#define TARGET_NR_vfork                         190
-#define TARGET_NR_ugetrlimit                    191
-#define TARGET_NR_mmap2                         192
-#define TARGET_NR_truncate64                    193
-#define TARGET_NR_ftruncate64                   194
-#define TARGET_NR_stat64                        195
-#define TARGET_NR_lstat64                       196
-#define TARGET_NR_fstat64                       197
-#define TARGET_NR_lchown32                      198
-#define TARGET_NR_getuid32                      199
-#define TARGET_NR_getgid32                      200
-#define TARGET_NR_geteuid32                     201
-#define TARGET_NR_getegid32                     202
-#define TARGET_NR_setreuid32                    203
-#define TARGET_NR_setregid32                    204
-#define TARGET_NR_getgroups32                   205
-#define TARGET_NR_setgroups32                   206
-#define TARGET_NR_fchown32                      207
-#define TARGET_NR_setresuid32                   208
-#define TARGET_NR_getresuid32                   209
-#define TARGET_NR_setresgid32                   210
-#define TARGET_NR_getresgid32                   211
-#define TARGET_NR_chown32                       212
-#define TARGET_NR_setuid32                      213
-#define TARGET_NR_setgid32                      214
-#define TARGET_NR_setfsuid32                    215
-#define TARGET_NR_setfsgid32                    216
-#define TARGET_NR_getdents64                    217
-#define TARGET_NR_pivot_root                    218
-#define TARGET_NR_mincore                       219
-#define TARGET_NR_madvise                       220
-#define TARGET_NR_fcntl64                       221
-                                                /* 222 */
-                                                /* 223 */
-#define TARGET_NR_gettid                        224
-#define TARGET_NR_readahead                     225
-#define TARGET_NR_setxattr                      226
-#define TARGET_NR_lsetxattr                     227
-#define TARGET_NR_fsetxattr                     228
-#define TARGET_NR_getxattr                      229
-#define TARGET_NR_lgetxattr                     230
-#define TARGET_NR_fgetxattr                     231
-#define TARGET_NR_listxattr                     232
-#define TARGET_NR_llistxattr                    233
-#define TARGET_NR_flistxattr                    234
-#define TARGET_NR_removexattr                   235
-#define TARGET_NR_lremovexattr                  236
-#define TARGET_NR_fremovexattr                  237
-#define TARGET_NR_tkill                         238
-#define TARGET_NR_sendfile64                    239
-#define TARGET_NR_futex                         240
-#define TARGET_NR_sched_setaffinity             241
-#define TARGET_NR_sched_getaffinity             242
-#define TARGET_NR_io_setup                      243
-#define TARGET_NR_io_destroy                    244
-#define TARGET_NR_io_getevents                  245
-#define TARGET_NR_io_submit                     246
-#define TARGET_NR_io_cancel                     247
-#define TARGET_NR_exit_group                    248
-#define TARGET_NR_lookup_dcookie                249
-#define TARGET_NR_epoll_create                  250
-#define TARGET_NR_epoll_ctl                     251
-#define TARGET_NR_epoll_wait                    252
-#define TARGET_NR_remap_file_pages              253
-                                                /* 254 */
-                                                /* 255 */
-                                                /* 256 */
-#define TARGET_NR_set_tid_address               256
-#define TARGET_NR_timer_create                  257
-#define TARGET_NR_timer_settime                 258
-#define TARGET_NR_timer_gettime                 259
-#define TARGET_NR_timer_getoverrun              260
-#define TARGET_NR_timer_delete                  261
-#define TARGET_NR_clock_settime                 262
-#define TARGET_NR_clock_gettime                 263
-#define TARGET_NR_clock_getres                  264
-#define TARGET_NR_clock_nanosleep               265
-#define TARGET_NR_statfs64                      266
-#define TARGET_NR_fstatfs64                     267
-#define TARGET_NR_tgkill                        268
-#define TARGET_NR_utimes                        269
-#define TARGET_NR_fadvise64_64                  270
-#define TARGET_NR_pciconfig_iobase              271
-#define TARGET_NR_pciconfig_read                272
-#define TARGET_NR_pciconfig_write               273
-#define TARGET_NR_mq_open                       274
-#define TARGET_NR_mq_unlink                     275
-#define TARGET_NR_mq_timedsend                  276
-#define TARGET_NR_mq_timedreceive               277
-#define TARGET_NR_mq_notify                     278
-#define TARGET_NR_mq_getsetattr                 279
-#define TARGET_NR_waitid                        280
-#define TARGET_NR_socket                        281
-#define TARGET_NR_bind                          282
-#define TARGET_NR_connect                       283
-#define TARGET_NR_listen                        284
-#define TARGET_NR_accept                        285
-#define TARGET_NR_getsockname                   286
-#define TARGET_NR_getpeername                   287
-#define TARGET_NR_socketpair                    288
-#define TARGET_NR_send                          289
-#define TARGET_NR_sendto                        290
-#define TARGET_NR_recv                          291
-#define TARGET_NR_recvfrom                      292
-#define TARGET_NR_shutdown                      293
-#define TARGET_NR_setsockopt                    294
-#define TARGET_NR_getsockopt                    295
-#define TARGET_NR_sendmsg                       296
-#define TARGET_NR_recvmsg                       297
-#define TARGET_NR_semop                         298
-#define TARGET_NR_semget                        299
-#define TARGET_NR_semctl                        300
-#define TARGET_NR_msgsnd                        301
-#define TARGET_NR_msgrcv                        302
-#define TARGET_NR_msgget                        303
-#define TARGET_NR_msgctl                        304
-#define TARGET_NR_shmat                         305
-#define TARGET_NR_shmdt                         306
-#define TARGET_NR_shmget                        307
-#define TARGET_NR_shmctl                        308
-#define TARGET_NR_add_key                       309
-#define TARGET_NR_request_key                   310
-#define TARGET_NR_keyctl                        311
-#define TARGET_NR_semtimedop                    312
-#define TARGET_NR_vserver                       313
-#define TARGET_NR_ioprio_set                    314
-#define TARGET_NR_ioprio_get                    315
-#define TARGET_NR_inotify_init                  316
-#define TARGET_NR_inotify_add_watch             317
-#define TARGET_NR_inotify_rm_watch              318
-#define TARGET_NR_mbind                         319
-#define TARGET_NR_get_mempolicy                 320
-#define TARGET_NR_set_mempolicy                 321
-#define TARGET_NR_openat                        322
-#define TARGET_NR_mkdirat                       323
-#define TARGET_NR_mknodat                       324
-#define TARGET_NR_fchownat                      325
-#define TARGET_NR_futimesat                     326
-#define TARGET_NR_fstatat64                     327
-#define TARGET_NR_unlinkat                      328
-#define TARGET_NR_renameat                      329
-#define TARGET_NR_linkat                        330
-#define TARGET_NR_symlinkat                     331
-#define TARGET_NR_readlinkat                    332
-#define TARGET_NR_fchmodat                      333
-#define TARGET_NR_faccessat                     334
-                                                /* 335 */
-                                                /* 336 */
-#define TARGET_NR_unshare                       337
-#define TARGET_NR_set_robust_list               338
-#define TARGET_NR_get_robust_list               339
-#define TARGET_NR_splice                        340
-#define TARGET_NR_sync_file_range2              341
-#define TARGET_NR_tee                           342
-#define TARGET_NR_vmsplice                      343
-#define TARGET_NR_move_pages                    344
-#define TARGET_NR_getcpu                        345
-                                                /* 346 */
-#define TARGET_NR_kexec_load                    347
-#define TARGET_NR_utimensat                     348
-#define TARGET_NR_signalfd                      349
-#define TARGET_NR_timerfd                       350
-#define TARGET_NR_eventfd                       351
-#define TARGET_NR_fallocate                     352
-#define TARGET_NR_timerfd_settime               353
-#define TARGET_NR_timerfd_gettime               354
-#define TARGET_NR_signalfd4                     355
-#define TARGET_NR_eventfd2                      356
-#define TARGET_NR_epoll_create1                 357
-#define TARGET_NR_dup3                          358
-#define TARGET_NR_pipe2                         359
-#define TARGET_NR_inotify_init1                 360
diff --git a/linux-user/unicore32/target_cpu.h b/linux-user/unicore32/target_cpu.h
deleted file mode 100644
index d7d2e7b083..0000000000
--- a/linux-user/unicore32/target_cpu.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * UniCore32 specific CPU ABI and functions for linux-user
- *
- * Copyright (C) 2010-2012 Guan Xuetao
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation, or (at your option) any
- * later version. See the COPYING file in the top-level directory.
- */
-#ifndef UNICORE32_TARGET_CPU_H
-#define UNICORE32_TARGET_CPU_H
-
-static inline void cpu_clone_regs(CPUUniCore32State *env, target_ulong newsp)
-{
-    if (newsp) {
-        env->regs[29] = newsp;
-    }
-    env->regs[0] = 0;
-}
-
-static inline void cpu_set_tls(CPUUniCore32State *env, target_ulong newtls)
-{
-    env->regs[16] = newtls;
-}
-
-#endif
diff --git a/linux-user/unicore32/target_elf.h b/linux-user/unicore32/target_elf.h
deleted file mode 100644
index e2bfcb2ca3..0000000000
--- a/linux-user/unicore32/target_elf.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation, or (at your option) any
- * later version. See the COPYING file in the top-level directory.
- */
-
-#ifndef UNICORE32_TARGET_ELF_H
-#define UNICORE32_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "any";
-}
-#endif
diff --git a/linux-user/unicore32/target_signal.h b/linux-user/unicore32/target_signal.h
deleted file mode 100644
index c6496fb9ea..0000000000
--- a/linux-user/unicore32/target_signal.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2010-2011 GUAN Xue-tao
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef UNICORE32_TARGET_SIGNAL_H
-#define UNICORE32_TARGET_SIGNAL_H
-
-/* this struct defines a stack used during syscall handling */
-typedef struct target_sigaltstack {
-    abi_ulong ss_sp;
-    abi_ulong ss_flags;
-    abi_ulong ss_size;
-} target_stack_t;
-
-/*
- * sigaltstack controls
- */
-#define TARGET_SS_ONSTACK               1
-#define TARGET_SS_DISABLE               2
-
-static inline abi_ulong get_sp_from_cpustate(CPUUniCore32State *state)
-{
-    return state->regs[29];
-}
-
-
-#endif /* UNICORE32_TARGET_SIGNAL_H */
diff --git a/linux-user/unicore32/target_structs.h b/linux-user/unicore32/target_structs.h
deleted file mode 100644
index fbd4fa3f53..0000000000
--- a/linux-user/unicore32/target_structs.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * UniCore32 specific structures for linux-user
- *
- * Copyright (c) 2013 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef UNICORE32_TARGET_STRUCTS_H
-#define UNICORE32_TARGET_STRUCTS_H
-
-struct target_ipc_perm {
-    abi_int __key;                      /* Key.  */
-    abi_uint uid;                       /* Owner's user ID.  */
-    abi_uint gid;                       /* Owner's group ID.  */
-    abi_uint cuid;                      /* Creator's user ID.  */
-    abi_uint cgid;                      /* Creator's group ID.  */
-    abi_ushort mode;                    /* Read/write permission.  */
-    abi_ushort __pad1;
-    abi_ushort __seq;                   /* Sequence number.  */
-    abi_ushort __pad2;
-    abi_ulong __unused1;
-    abi_ulong __unused2;
-};
-
-struct target_shmid_ds {
-    struct target_ipc_perm shm_perm;    /* operation permission struct */
-    abi_long shm_segsz;                 /* size of segment in bytes */
-    abi_ulong shm_atime;                /* time of last shmat() */
-#if TARGET_ABI_BITS == 32
-    abi_ulong __unused1;
-#endif
-    abi_ulong shm_dtime;                /* time of last shmdt() */
-#if TARGET_ABI_BITS == 32
-    abi_ulong __unused2;
-#endif
-    abi_ulong shm_ctime;                /* time of last change by shmctl() */
-#if TARGET_ABI_BITS == 32
-    abi_ulong __unused3;
-#endif
-    abi_int shm_cpid;                   /* pid of creator */
-    abi_int shm_lpid;                   /* pid of last shmop */
-    abi_ulong shm_nattch;               /* number of current attaches */
-    abi_ulong __unused4;
-    abi_ulong __unused5;
-};
-
-#endif
diff --git a/linux-user/unicore32/target_syscall.h b/linux-user/unicore32/target_syscall.h
deleted file mode 100644
index 346b207700..0000000000
--- a/linux-user/unicore32/target_syscall.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Copyright (C) 2010-2011 GUAN Xue-tao
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef UNICORE32_TARGET_SYSCALL_H
-#define UNICORE32_TARGET_SYSCALL_H
-
-struct target_pt_regs {
-    abi_ulong uregs[34];
-};
-
-#define UC32_REG_pc             uregs[31]
-#define UC32_REG_lr             uregs[30]
-#define UC32_REG_sp             uregs[29]
-#define UC32_REG_ip             uregs[28]
-#define UC32_REG_fp             uregs[27]
-#define UC32_REG_26             uregs[26]
-#define UC32_REG_25             uregs[25]
-#define UC32_REG_24             uregs[24]
-#define UC32_REG_23             uregs[23]
-#define UC32_REG_22             uregs[22]
-#define UC32_REG_21             uregs[21]
-#define UC32_REG_20             uregs[20]
-#define UC32_REG_19             uregs[19]
-#define UC32_REG_18             uregs[18]
-#define UC32_REG_17             uregs[17]
-#define UC32_REG_16             uregs[16]
-#define UC32_REG_15             uregs[15]
-#define UC32_REG_14             uregs[14]
-#define UC32_REG_13             uregs[13]
-#define UC32_REG_12             uregs[12]
-#define UC32_REG_11             uregs[11]
-#define UC32_REG_10             uregs[10]
-#define UC32_REG_09             uregs[9]
-#define UC32_REG_08             uregs[8]
-#define UC32_REG_07             uregs[7]
-#define UC32_REG_06             uregs[6]
-#define UC32_REG_05             uregs[5]
-#define UC32_REG_04             uregs[4]
-#define UC32_REG_03             uregs[3]
-#define UC32_REG_02             uregs[2]
-#define UC32_REG_01             uregs[1]
-#define UC32_REG_00             uregs[0]
-#define UC32_REG_asr            uregs[32]
-#define UC32_REG_ORIG_00        uregs[33]
-
-#define UC32_SYSCALL_BASE               0x900000
-#define UC32_SYSCALL_ARCH_BASE          0xf0000
-#define UC32_SYSCALL_NR_set_tls         (UC32_SYSCALL_ARCH_BASE + 5)
-
-#define UNAME_MACHINE "UniCore-II"
-#define UNAME_MINIMUM_RELEASE "2.6.32"
-
-#define TARGET_MINSIGSTKSZ 2048
-#define TARGET_MLOCKALL_MCL_CURRENT 1
-#define TARGET_MLOCKALL_MCL_FUTURE  2
-
-#endif /* UNICORE32_TARGET_SYSCALL_H */
diff --git a/linux-user/unicore32/termbits.h b/linux-user/unicore32/termbits.h
deleted file mode 100644
index a5fcd64abf..0000000000
--- a/linux-user/unicore32/termbits.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* NOTE: exactly the same as i386 */
-#include "../i386/termbits.h"
-- 
2.14.3
