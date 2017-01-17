Received: from eggs.gnu.org ([2001:4830:134:3::10]:33954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTHtD-0002Rz-TF
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 19:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTHt9-0005ar-4z
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 19:44:43 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:57004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cTHt8-0005aK-Kr
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 19:44:39 -0500
From: Marek Vasut <marex@denx.de>
Date: Tue, 17 Jan 2017 01:44:05 +0100
Message-Id: <20170117004409.28532-4-marex@denx.de>
In-Reply-To: <20170117004409.28532-1-marex@denx.de>
References: <20170117004409.28532-1-marex@denx.de>
Subject: [Qemu-devel] [PATCH V5 3/7] nios2: Add usermode binaries emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>, Jeff Da Silva <jdasilva@altera.com>, Ley Foon Tan <lftan@altera.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>

Add missing bits for qemu-user required for emulating Altera Nios2
userspace binaries.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: Jeff Da Silva <jdasilva@altera.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Sandra Loosemore <sandra@codesourcery.com>
Cc: Yves Vandervennet <yvanderv@altera.com>
Reviewed-by: Alexander Graf <agraf@suse.de>
---
V3: Checkpatch cleanup
V4: Rebase on top of qemu/master
V5: Rebase on top of qemu/master
---
 include/elf.h                     |   2 +
 linux-user/elfload.c              |  57 +++++++
 linux-user/main.c                 | 140 +++++++++++++++-
 linux-user/nios2/syscall_nr.h     | 329 ++++++++++++++++++++++++++++++++++++++
 linux-user/nios2/target_cpu.h     |  39 +++++
 linux-user/nios2/target_signal.h  |  26 +++
 linux-user/nios2/target_structs.h |  58 +++++++
 linux-user/nios2/target_syscall.h |  37 +++++
 linux-user/nios2/termbits.h       | 220 +++++++++++++++++++++++++
 linux-user/signal.c               | 238 ++++++++++++++++++++++++++-
 linux-user/syscall_defs.h         |   8 +-
 11 files changed, 1147 insertions(+), 7 deletions(-)
 create mode 100644 linux-user/nios2/syscall_nr.h
 create mode 100644 linux-user/nios2/target_cpu.h
 create mode 100644 linux-user/nios2/target_signal.h
 create mode 100644 linux-user/nios2/target_structs.h
 create mode 100644 linux-user/nios2/target_syscall.h
 create mode 100644 linux-user/nios2/termbits.h

diff --git a/include/elf.h b/include/elf.h
index 1c2975dc82..0dbd3e968b 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -126,6 +126,8 @@ typedef int64_t  Elf64_Sxword;
  */
 #define EM_S390_OLD     0xA390
 
+#define EM_ALTERA_NIOS2 113     /* Altera Nios II soft-core processor */
+
 #define EM_MICROBLAZE      189
 #define EM_MICROBLAZE_OLD  0xBAAB
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 547053c27a..17f7766bff 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -967,6 +967,63 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
 
 #endif /* TARGET_MICROBLAZE */
 
+#ifdef TARGET_NIOS2
+
+#define ELF_START_MMAP 0x80000000
+
+#define elf_check_arch(x) ((x) == EM_ALTERA_NIOS2)
+
+#define ELF_CLASS   ELFCLASS32
+#define ELF_ARCH    EM_ALTERA_NIOS2
+
+static void init_thread(struct target_pt_regs *regs, struct image_info *infop)
+{
+    regs->ea = infop->entry;
+    regs->sp = infop->start_stack;
+    regs->estatus = 0x3;
+}
+
+#define ELF_EXEC_PAGESIZE        4096
+
+#define USE_ELF_CORE_DUMP
+#define ELF_NREG 49
+typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+
+/* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUNios2State *env)
+{
+    int i;
+
+    (*regs)[0] = -1;
+    for (i = 1; i < 8; i++)    /* r0-r7 */
+        (*regs)[i] = tswapreg(env->regs[i + 7]);
+
+    for (i = 8; i < 16; i++)   /* r8-r15 */
+        (*regs)[i] = tswapreg(env->regs[i - 8]);
+
+    for (i = 16; i < 24; i++)  /* r16-r23 */
+        (*regs)[i] = tswapreg(env->regs[i + 7]);
+    (*regs)[24] = -1;    /* R_ET */
+    (*regs)[25] = -1;    /* R_BT */
+    (*regs)[26] = tswapreg(env->regs[R_GP]);
+    (*regs)[27] = tswapreg(env->regs[R_SP]);
+    (*regs)[28] = tswapreg(env->regs[R_FP]);
+    (*regs)[29] = tswapreg(env->regs[R_EA]);
+    (*regs)[30] = -1;    /* R_SSTATUS */
+    (*regs)[31] = tswapreg(env->regs[R_RA]);
+
+    (*regs)[32] = tswapreg(env->regs[R_PC]);
+
+    (*regs)[33] = -1; /* R_STATUS */
+    (*regs)[34] = tswapreg(env->regs[CR_ESTATUS]);
+
+    for (i = 35; i < 49; i++)    /* ... */
+        (*regs)[i] = -1;
+}
+
+#endif /* TARGET_NIOS2 */
+
 #ifdef TARGET_OPENRISC
 
 #define ELF_START_MMAP 0x08000000
diff --git a/linux-user/main.c b/linux-user/main.c
index c1d5eb4d6f..32b71151dd 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -68,8 +68,11 @@ do {                                                                    \
  * This way we will never overlap with our own libraries or binaries or stack
  * or anything else that QEMU maps.
  */
-# ifdef TARGET_MIPS
-/* MIPS only supports 31 bits of virtual address space for user space */
+# if defined(TARGET_MIPS) || defined(TARGET_NIOS2)
+/*
+ * MIPS only supports 31 bits of virtual address space for user space.
+ * Nios2 also only supports 31 bits.
+ */
 unsigned long reserved_va = 0x77000000;
 # else
 unsigned long reserved_va = 0xf7000000;
@@ -2462,6 +2465,109 @@ error:
 }
 #endif
 
+#ifdef TARGET_NIOS2
+
+void cpu_loop(CPUNios2State *env)
+{
+    CPUState *cs = ENV_GET_CPU(env);
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    target_siginfo_t info;
+    int trapnr, gdbsig, ret;
+
+    for (;;) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        gdbsig = 0;
+
+        switch (trapnr) {
+        case EXCP_INTERRUPT:
+            /* just indicate that signals should be handled asap */
+            break;
+        case EXCP_TRAP:
+            if (env->regs[R_AT] == 0) {
+                abi_long ret;
+                qemu_log_mask(CPU_LOG_INT, "\nSyscall\n");
+
+                ret = do_syscall(env, env->regs[2],
+                                 env->regs[4], env->regs[5], env->regs[6],
+                                 env->regs[7], env->regs[8], env->regs[9],
+                                 0, 0);
+
+                if (env->regs[2] == 0) {    /* FIXME: syscall 0 workaround */
+                    ret = 0;
+                }
+
+                env->regs[2] = abs(ret);
+                /* Return value is 0..4096 */
+                env->regs[7] = (ret > 0xfffffffffffff000ULL);
+                env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
+                env->regs[CR_STATUS] &= ~0x3;
+                env->regs[R_EA] = env->regs[R_PC] + 4;
+                env->regs[R_PC] += 4;
+                break;
+            } else {
+                qemu_log_mask(CPU_LOG_INT, "\nTrap\n");
+
+                env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
+                env->regs[CR_STATUS] &= ~0x3;
+                env->regs[R_EA] = env->regs[R_PC] + 4;
+                env->regs[R_PC] = cpu->exception_addr;
+
+                gdbsig = TARGET_SIGTRAP;
+                break;
+            }
+        case 0xaa:
+            switch (env->regs[R_PC]) {
+            /*case 0x1000:*/  /* TODO:__kuser_helper_version */
+            case 0x1004:      /* __kuser_cmpxchg */
+                start_exclusive();
+                if (env->regs[4] & 0x3) {
+                    goto kuser_fail;
+                }
+                ret = get_user_u32(env->regs[2], env->regs[4]);
+                if (ret) {
+                    end_exclusive();
+                    goto kuser_fail;
+                }
+                env->regs[2] -= env->regs[5];
+                if (env->regs[2] == 0) {
+                    put_user_u32(env->regs[6], env->regs[4]);
+                }
+                end_exclusive();
+                env->regs[R_PC] = env->regs[R_RA];
+                break;
+            /*case 0x1040:*/  /* TODO:__kuser_sigtramp */
+            default:
+                ;
+kuser_fail:
+                info.si_signo = TARGET_SIGSEGV;
+                info.si_errno = 0;
+                /* TODO: check env->error_code */
+                info.si_code = TARGET_SEGV_MAPERR;
+                info._sifields._sigfault._addr = env->regs[R_PC];
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            }
+            break;
+        default:
+            EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x - aborting\n",
+                     trapnr);
+            gdbsig = TARGET_SIGILL;
+            break;
+        }
+        if (gdbsig) {
+            gdb_handlesig(cs, gdbsig);
+            if (gdbsig != TARGET_SIGTRAP) {
+                exit(EXIT_FAILURE);
+            }
+        }
+
+        process_pending_signals(env);
+    }
+}
+
+#endif /* TARGET_NIOS2 */
+
 #ifdef TARGET_OPENRISC
 
 void cpu_loop(CPUOpenRISCState *env)
@@ -4468,6 +4574,36 @@ int main(int argc, char **argv, char **envp)
             restore_snan_bit_mode(env);
         }
     }
+#elif defined(TARGET_NIOS2)
+    {
+        env->regs[0] = 0;
+        env->regs[1] = regs->r1;
+        env->regs[2] = regs->r2;
+        env->regs[3] = regs->r3;
+        env->regs[4] = regs->r4;
+        env->regs[5] = regs->r5;
+        env->regs[6] = regs->r6;
+        env->regs[7] = regs->r7;
+        env->regs[8] = regs->r8;
+        env->regs[9] = regs->r9;
+        env->regs[10] = regs->r10;
+        env->regs[11] = regs->r11;
+        env->regs[12] = regs->r12;
+        env->regs[13] = regs->r13;
+        env->regs[14] = regs->r14;
+        env->regs[15] = regs->r15;
+        /* TODO: unsigned long  orig_r2; */
+        env->regs[R_RA] = regs->ra;
+        env->regs[R_FP] = regs->fp;
+        env->regs[R_SP] = regs->sp;
+        env->regs[R_GP] = regs->gp;
+        env->regs[CR_ESTATUS] = regs->estatus;
+        env->regs[R_EA] = regs->ea;
+        /* TODO: unsigned long  orig_r7; */
+
+        /* Emulate eret when starting thread. */
+        env->regs[R_PC] = regs->ea;
+    }
 #elif defined(TARGET_OPENRISC)
     {
         int i;
diff --git a/linux-user/nios2/syscall_nr.h b/linux-user/nios2/syscall_nr.h
new file mode 100644
index 0000000000..8b46763673
--- /dev/null
+++ b/linux-user/nios2/syscall_nr.h
@@ -0,0 +1,329 @@
+#define TARGET_NR_io_setup                  0
+#define TARGET_NR_io_destroy                1
+#define TARGET_NR_io_submit                 2
+#define TARGET_NR_io_cancel                 3
+#define TARGET_NR_io_getevents              4
+#define TARGET_NR_setxattr                  5
+#define TARGET_NR_lsetxattr                 6
+#define TARGET_NR_fsetxattr                 7
+#define TARGET_NR_getxattr                  8
+#define TARGET_NR_lgetxattr                 9
+#define TARGET_NR_fgetxattr                 10
+#define TARGET_NR_listxattr                 11
+#define TARGET_NR_llistxattr                12
+#define TARGET_NR_flistxattr                13
+#define TARGET_NR_removexattr               14
+#define TARGET_NR_lremovexattr              15
+#define TARGET_NR_fremovexattr              16
+#define TARGET_NR_getcwd                    17
+#define TARGET_NR_lookup_dcookie            18
+#define TARGET_NR_eventfd2                  19
+#define TARGET_NR_epoll_create1             20
+#define TARGET_NR_epoll_ctl                 21
+#define TARGET_NR_epoll_pwait               22
+#define TARGET_NR_dup                       23
+#define TARGET_NR_dup3                      24
+#define TARGET_NR_fcntl64                   25
+#define TARGET_NR_inotify_init1             26
+#define TARGET_NR_inotify_add_watch         27
+#define TARGET_NR_inotify_rm_watch          28
+#define TARGET_NR_ioctl                     29
+#define TARGET_NR_ioprio_set                30
+#define TARGET_NR_ioprio_get                31
+#define TARGET_NR_flock                     32
+#define TARGET_NR_mknodat                   33
+#define TARGET_NR_mkdirat                   34
+#define TARGET_NR_unlinkat                  35
+#define TARGET_NR_symlinkat                 36
+#define TARGET_NR_linkat                    37
+#define TARGET_NR_renameat                  38
+#define TARGET_NR_umount2                   39
+#define TARGET_NR_mount                     40
+#define TARGET_NR_pivot_root                41
+#define TARGET_NR_nfsservctl                42
+#define TARGET_NR_statfs64                  43
+#define TARGET_NR_fstatfs64                 44
+#define TARGET_NR_truncate64                45
+#define TARGET_NR_ftruncate64               46
+#define TARGET_NR_fallocate                 47
+#define TARGET_NR_faccessat                 48
+#define TARGET_NR_chdir                     49
+#define TARGET_NR_fchdir                    50
+#define TARGET_NR_chroot                    51
+#define TARGET_NR_fchmod                    52
+#define TARGET_NR_fchmodat                  53
+#define TARGET_NR_fchownat                  54
+#define TARGET_NR_fchown                    55
+#define TARGET_NR_openat                    56
+#define TARGET_NR_close                     57
+#define TARGET_NR_vhangup                   58
+#define TARGET_NR_pipe2                     59
+#define TARGET_NR_quotactl                  60
+#define TARGET_NR_getdents64                61
+#define TARGET_NR_read                      63
+#define TARGET_NR_write                     64
+#define TARGET_NR_readv                     65
+#define TARGET_NR_writev                    66
+#define TARGET_NR_pread64                   67
+#define TARGET_NR_pwrite64                  68
+#define TARGET_NR_preadv                    69
+#define TARGET_NR_pwritev                   70
+#define TARGET_NR_sendfile64                71
+#define TARGET_NR_pselect6                  72
+#define TARGET_NR_ppoll                     73
+#define TARGET_NR_signalfd4                 74
+#define TARGET_NR_vmsplice                  75
+#define TARGET_NR_splice                    76
+#define TARGET_NR_tee                       77
+#define TARGET_NR_readlinkat                78
+#define TARGET_NR_fstatat64                 79
+#define TARGET_NR_fstat64                   80
+#define TARGET_NR_sync                      81
+#define TARGET_NR_fsync                     82
+#define TARGET_NR_fdatasync                 83
+#define TARGET_NR_sync_file_range           84
+#define TARGET_NR_timerfd_create            85
+#define TARGET_NR_timerfd_settime           86
+#define TARGET_NR_timerfd_gettime           87
+#define TARGET_NR_utimensat                 88
+#define TARGET_NR_acct                      89
+#define TARGET_NR_capget                    90
+#define TARGET_NR_capset                    91
+#define TARGET_NR_personality               92
+#define TARGET_NR_exit                      93
+#define TARGET_NR_exit_group                94
+#define TARGET_NR_waitid                    95
+#define TARGET_NR_set_tid_address           96
+#define TARGET_NR_unshare                   97
+#define TARGET_NR_futex                     98
+#define TARGET_NR_set_robust_list           99
+#define TARGET_NR_get_robust_list           100
+#define TARGET_NR_nanosleep                 101
+#define TARGET_NR_getitimer                 102
+#define TARGET_NR_setitimer                 103
+#define TARGET_NR_kexec_load                104
+#define TARGET_NR_init_module               105
+#define TARGET_NR_delete_module             106
+#define TARGET_NR_timer_create              107
+#define TARGET_NR_timer_gettime             108
+#define TARGET_NR_timer_getoverrun          109
+#define TARGET_NR_timer_settime             110
+#define TARGET_NR_timer_delete              111
+#define TARGET_NR_clock_settime             112
+#define TARGET_NR_clock_gettime             113
+#define TARGET_NR_clock_getres              114
+#define TARGET_NR_clock_nanosleep           115
+#define TARGET_NR_syslog                    116
+#define TARGET_NR_ptrace                    117
+#define TARGET_NR_sched_setparam            118
+#define TARGET_NR_sched_setscheduler        119
+#define TARGET_NR_sched_getscheduler        120
+#define TARGET_NR_sched_getparam            121
+#define TARGET_NR_sched_setaffinity         122
+#define TARGET_NR_sched_getaffinity         123
+#define TARGET_NR_sched_yield               124
+#define TARGET_NR_sched_get_priority_max    125
+#define TARGET_NR_sched_get_priority_min    126
+#define TARGET_NR_sched_rr_get_interval     127
+#define TARGET_NR_restart_syscall           128
+#define TARGET_NR_kill                      129
+#define TARGET_NR_tkill                     130
+#define TARGET_NR_tgkill                    131
+#define TARGET_NR_sigaltstack               132
+#define TARGET_NR_rt_sigsuspend             133
+#define TARGET_NR_rt_sigaction              134
+#define TARGET_NR_rt_sigprocmask            135
+#define TARGET_NR_rt_sigpending             136
+#define TARGET_NR_rt_sigtimedwait           137
+#define TARGET_NR_rt_sigqueueinfo           138
+#define TARGET_NR_rt_sigreturn              139
+#define TARGET_NR_setpriority               140
+#define TARGET_NR_getpriority               141
+#define TARGET_NR_reboot                    142
+#define TARGET_NR_setregid                  143
+#define TARGET_NR_setgid                    144
+#define TARGET_NR_setreuid                  145
+#define TARGET_NR_setuid                    146
+#define TARGET_NR_setresuid                 147
+#define TARGET_NR_getresuid                 148
+#define TARGET_NR_setresgid                 149
+#define TARGET_NR_getresgid                 150
+#define TARGET_NR_setfsuid                  151
+#define TARGET_NR_setfsgid                  152
+#define TARGET_NR_times                     153
+#define TARGET_NR_setpgid                   154
+#define TARGET_NR_getpgid                   155
+#define TARGET_NR_getsid                    156
+#define TARGET_NR_setsid                    157
+#define TARGET_NR_getgroups                 158
+#define TARGET_NR_setgroups                 159
+#define TARGET_NR_uname                     160
+#define TARGET_NR_sethostname               161
+#define TARGET_NR_setdomainname             162
+#define TARGET_NR_getrlimit                 163
+#define TARGET_NR_setrlimit                 164
+#define TARGET_NR_getrusage                 165
+#define TARGET_NR_umask                     166
+#define TARGET_NR_prctl                     167
+#define TARGET_NR_getcpu                    168
+#define TARGET_NR_gettimeofday              169
+#define TARGET_NR_settimeofday              170
+#define TARGET_NR_adjtimex                  171
+#define TARGET_NR_getpid                    172
+#define TARGET_NR_getppid                   173
+#define TARGET_NR_getuid                    174
+#define TARGET_NR_geteuid                   175
+#define TARGET_NR_getgid                    176
+#define TARGET_NR_getegid                   177
+#define TARGET_NR_gettid                    178
+#define TARGET_NR_sysinfo                   179
+#define TARGET_NR_mq_open                   180
+#define TARGET_NR_mq_unlink                 181
+#define TARGET_NR_mq_timedsend              182
+#define TARGET_NR_mq_timedreceive           183
+#define TARGET_NR_mq_notify                 184
+#define TARGET_NR_mq_getsetattr             185
+#define TARGET_NR_msgget                    186
+#define TARGET_NR_msgctl                    187
+#define TARGET_NR_msgrcv                    188
+#define TARGET_NR_msgsnd                    189
+#define TARGET_NR_semget                    190
+#define TARGET_NR_semctl                    191
+#define TARGET_NR_semtimedop                192
+#define TARGET_NR_semop                     193
+#define TARGET_NR_shmget                    194
+#define TARGET_NR_shmctl                    195
+#define TARGET_NR_shmat                     196
+#define TARGET_NR_shmdt                     197
+#define TARGET_NR_socket                    198
+#define TARGET_NR_socketpair                199
+#define TARGET_NR_bind                      200
+#define TARGET_NR_listen                    201
+#define TARGET_NR_accept                    202
+#define TARGET_NR_connect                   203
+#define TARGET_NR_getsockname               204
+#define TARGET_NR_getpeername               205
+#define TARGET_NR_sendto                    206
+#define TARGET_NR_recvfrom                  207
+#define TARGET_NR_setsockopt                208
+#define TARGET_NR_getsockopt                209
+#define TARGET_NR_shutdown                  210
+#define TARGET_NR_sendmsg                   211
+#define TARGET_NR_recvmsg                   212
+#define TARGET_NR_readahead                 213
+#define TARGET_NR_brk                       214
+#define TARGET_NR_munmap                    215
+#define TARGET_NR_mremap                    216
+#define TARGET_NR_add_key                   217
+#define TARGET_NR_request_key               218
+#define TARGET_NR_keyctl                    219
+#define TARGET_NR_clone                     220
+#define TARGET_NR_execve                    221
+#define TARGET_NR_mmap2                     222
+#define TARGET_NR_fadvise64_64              223
+#define TARGET_NR_swapon                    224
+#define TARGET_NR_swapoff                   225
+#define TARGET_NR_mprotect                  226
+#define TARGET_NR_msync                     227
+#define TARGET_NR_mlock                     228
+#define TARGET_NR_munlock                   229
+#define TARGET_NR_mlockall                  230
+#define TARGET_NR_munlockall                231
+#define TARGET_NR_mincore                   232
+#define TARGET_NR_madvise                   233
+#define TARGET_NR_remap_file_pages          234
+#define TARGET_NR_mbind                     235
+#define TARGET_NR_get_mempolicy             236
+#define TARGET_NR_set_mempolicy             237
+#define TARGET_NR_migrate_pages             238
+#define TARGET_NR_move_pages                239
+#define TARGET_NR_rt_tgsigqueueinfo         240
+#define TARGET_NR_perf_event_open           241
+#define TARGET_NR_accept4                   242
+#define TARGET_NR_recvmmsg                  243
+#define TARGET_NR_cacheflush                244
+#define TARGET_NR_arch_specific_syscall     244
+#define TARGET_NR_wait4                     260
+#define TARGET_NR_prlimit64                 261
+#define TARGET_NR_fanotify_init             262
+#define TARGET_NR_fanotify_mark             263
+#define TARGET_NR_name_to_handle_at         264
+#define TARGET_NR_open_by_handle_at         265
+#define TARGET_NR_clock_adjtime             266
+#define TARGET_NR_syncfs                    267
+#define TARGET_NR_setns                     268
+#define TARGET_NR_sendmmsg                  269
+#define TARGET_NR_process_vm_readv          270
+#define TARGET_NR_process_vm_writev         271
+#define TARGET_NR_kcmp                      272
+#define TARGET_NR_finit_module              273
+#define TARGET_NR_sched_setattr             274
+#define TARGET_NR_sched_getattr             275
+#define TARGET_NR_renameat2                 276
+#define TARGET_NR_seccomp                   277
+#define TARGET_NR_getrandom                 278
+#define TARGET_NR_memfd_create              279
+#define TARGET_NR_bpf                       280
+#define TARGET_NR_execveat                  281
+#define TARGET_NR_userfaultfd               282
+#define TARGET_NR_membarrier                283
+#define TARGET_NR_mlock2                    284
+#define TARGET_NR_copy_file_range           285
+#define TARGET_NR_preadv2                   286
+#define TARGET_NR_pwritev2                  287
+#define TARGET_NR_open                      1024
+#define TARGET_NR_link                      1025
+#define TARGET_NR_unlink                    1026
+#define TARGET_NR_mknod                     1027
+#define TARGET_NR_chmod                     1028
+#define TARGET_NR_chown                     1029
+#define TARGET_NR_mkdir                     1030
+#define TARGET_NR_rmdir                     1031
+#define TARGET_NR_lchown                    1032
+#define TARGET_NR_access                    1033
+#define TARGET_NR_rename                    1034
+#define TARGET_NR_readlink                  1035
+#define TARGET_NR_symlink                   1036
+#define TARGET_NR_utimes                    1037
+#define TARGET_NR_3264_stat                 1038
+#define TARGET_NR_3264_lstat                1039
+#define TARGET_NR_pipe                      1040
+#define TARGET_NR_dup2                      1041
+#define TARGET_NR_epoll_create              1042
+#define TARGET_NR_inotify_init              1043
+#define TARGET_NR_eventfd                   1044
+#define TARGET_NR_signalfd                  1045
+#define TARGET_NR_sendfile                  1046
+#define TARGET_NR_ftruncate                 1047
+#define TARGET_NR_truncate                  1048
+#define TARGET_NR_stat                      1049
+#define TARGET_NR_lstat                     1050
+#define TARGET_NR_fstat                     1051
+#define TARGET_NR_fcntl                     1052
+#define TARGET_NR_fadvise64                 1053
+#define TARGET_NR_newfstatat                1054
+#define TARGET_NR_fstatfs                   1055
+#define TARGET_NR_statfs                    1056
+#define TARGET_NR_lseek                     1057
+#define TARGET_NR_mmap                      1058
+#define TARGET_NR_alarm                     1059
+#define TARGET_NR_getpgrp                   1060
+#define TARGET_NR_pause                     1061
+#define TARGET_NR_time                      1062
+#define TARGET_NR_utime                     1063
+#define TARGET_NR_creat                     1064
+#define TARGET_NR_getdents                  1065
+#define TARGET_NR_futimesat                 1066
+#define TARGET_NR_select                    1067
+#define TARGET_NR_poll                      1068
+#define TARGET_NR_epoll_wait                1069
+#define TARGET_NR_ustat                     1070
+#define TARGET_NR_vfork                     1071
+#define TARGET_NR_oldwait4                  1072
+#define TARGET_NR_recv                      1073
+#define TARGET_NR_send                      1074
+#define TARGET_NR_bdflush                   1075
+#define TARGET_NR_umount                    1076
+#define TARGET_NR_uselib                    1077
+#define TARGET_NR__sysctl                   1078
+#define TARGET_NR_fork                      1079
diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
new file mode 100644
index 0000000000..20ab4790a9
--- /dev/null
+++ b/linux-user/nios2/target_cpu.h
@@ -0,0 +1,39 @@
+/*
+ * Nios2 specific CPU ABI and functions for linux-user
+ *
+ * Copyright (c) 2016 Marek Vasut <marex@denx.de>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_CPU_H
+#define TARGET_CPU_H
+
+static inline void cpu_clone_regs(CPUNios2State *env, target_ulong newsp)
+{
+    if (newsp) {
+        env->regs[R_SP] = newsp;
+    }
+    env->regs[R_RET0] = 0;
+}
+
+static inline void cpu_set_tls(CPUNios2State *env, target_ulong newtls)
+{
+    /*
+     * Linux kernel 3.10 does not pay any attention to CLONE_SETTLS
+     * in copy_thread(), so QEMU need not do so either.
+     */
+}
+
+#endif
diff --git a/linux-user/nios2/target_signal.h b/linux-user/nios2/target_signal.h
new file mode 100644
index 0000000000..23a8267696
--- /dev/null
+++ b/linux-user/nios2/target_signal.h
@@ -0,0 +1,26 @@
+#ifndef TARGET_SIGNAL_H
+#define TARGET_SIGNAL_H
+
+#include "cpu.h"
+
+/* this struct defines a stack used during syscall handling */
+
+typedef struct target_sigaltstack {
+    abi_long ss_sp;
+    abi_ulong ss_size;
+    abi_long ss_flags;
+} target_stack_t;
+
+/* sigaltstack controls  */
+#define TARGET_SS_ONSTACK     1
+#define TARGET_SS_DISABLE     2
+
+#define TARGET_MINSIGSTKSZ    2048
+#define TARGET_SIGSTKSZ       8192
+
+static inline abi_ulong get_sp_from_cpustate(CPUNios2State *state)
+{
+    return state->regs[R_SP];
+}
+
+#endif /* TARGET_SIGNAL_H */
diff --git a/linux-user/nios2/target_structs.h b/linux-user/nios2/target_structs.h
new file mode 100644
index 0000000000..8713772089
--- /dev/null
+++ b/linux-user/nios2/target_structs.h
@@ -0,0 +1,58 @@
+/*
+ * Nios2 specific structures for linux-user
+ *
+ * Copyright (c) 2016 Marek Vasut <marex@denx.de>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef TARGET_STRUCTS_H
+#define TARGET_STRUCTS_H
+
+struct target_ipc_perm {
+    abi_int __key;                      /* Key.  */
+    abi_uint uid;                       /* Owner's user ID.  */
+    abi_uint gid;                       /* Owner's group ID.  */
+    abi_uint cuid;                      /* Creator's user ID.  */
+    abi_uint cgid;                      /* Creator's group ID.  */
+    abi_ushort mode;                    /* Read/write permission.  */
+    abi_ushort __pad1;
+    abi_ushort __seq;                   /* Sequence number.  */
+    abi_ushort __pad2;
+    abi_ulong __unused1;
+    abi_ulong __unused2;
+};
+
+struct target_shmid_ds {
+    struct target_ipc_perm shm_perm;    /* operation permission struct */
+    abi_long shm_segsz;                 /* size of segment in bytes */
+    abi_ulong shm_atime;                /* time of last shmat() */
+#if TARGET_ABI_BITS == 32
+    abi_ulong __unused1;
+#endif
+    abi_ulong shm_dtime;                /* time of last shmdt() */
+#if TARGET_ABI_BITS == 32
+    abi_ulong __unused2;
+#endif
+    abi_ulong shm_ctime;                /* time of last change by shmctl() */
+#if TARGET_ABI_BITS == 32
+    abi_ulong __unused3;
+#endif
+    abi_int shm_cpid;                   /* pid of creator */
+    abi_int shm_lpid;                   /* pid of last shmop */
+    abi_ulong shm_nattch;               /* number of current attaches */
+    abi_ulong __unused4;
+    abi_ulong __unused5;
+};
+
+#endif
diff --git a/linux-user/nios2/target_syscall.h b/linux-user/nios2/target_syscall.h
new file mode 100644
index 0000000000..ca6b7e69f6
--- /dev/null
+++ b/linux-user/nios2/target_syscall.h
@@ -0,0 +1,37 @@
+#ifndef TARGET_SYSCALL_H
+#define TARGET_SYSCALL_H
+
+#define UNAME_MACHINE "nios2"
+#define UNAME_MINIMUM_RELEASE "3.19.0"
+
+struct target_pt_regs {
+    unsigned long  r8;    /* r8-r15 Caller-saved GP registers */
+    unsigned long  r9;
+    unsigned long  r10;
+    unsigned long  r11;
+    unsigned long  r12;
+    unsigned long  r13;
+    unsigned long  r14;
+    unsigned long  r15;
+    unsigned long  r1;    /* Assembler temporary */
+    unsigned long  r2;    /* Retval LS 32bits */
+    unsigned long  r3;    /* Retval MS 32bits */
+    unsigned long  r4;    /* r4-r7 Register arguments */
+    unsigned long  r5;
+    unsigned long  r6;
+    unsigned long  r7;
+    unsigned long  orig_r2;    /* Copy of r2 ?? */
+    unsigned long  ra;    /* Return address */
+    unsigned long  fp;    /* Frame pointer */
+    unsigned long  sp;    /* Stack pointer */
+    unsigned long  gp;    /* Global pointer */
+    unsigned long  estatus;
+    unsigned long  ea;    /* Exception return address (pc) */
+    unsigned long  orig_r7;
+};
+
+#define TARGET_MINSIGSTKSZ 2048
+#define TARGET_MLOCKALL_MCL_CURRENT 1
+#define TARGET_MLOCKALL_MCL_FUTURE  2
+
+#endif  /* TARGET_SYSCALL_H */
diff --git a/linux-user/nios2/termbits.h b/linux-user/nios2/termbits.h
new file mode 100644
index 0000000000..b64ba974cf
--- /dev/null
+++ b/linux-user/nios2/termbits.h
@@ -0,0 +1,220 @@
+/* from asm/termbits.h */
+/* NOTE: exactly the same as i386 */
+
+#define TARGET_NCCS 19
+
+struct target_termios {
+    unsigned int c_iflag;               /* input mode flags */
+    unsigned int c_oflag;               /* output mode flags */
+    unsigned int c_cflag;               /* control mode flags */
+    unsigned int c_lflag;               /* local mode flags */
+    unsigned char c_line;                    /* line discipline */
+    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+};
+
+/* c_iflag bits */
+#define TARGET_IGNBRK  0000001
+#define TARGET_BRKINT  0000002
+#define TARGET_IGNPAR  0000004
+#define TARGET_PARMRK  0000010
+#define TARGET_INPCK   0000020
+#define TARGET_ISTRIP  0000040
+#define TARGET_INLCR   0000100
+#define TARGET_IGNCR   0000200
+#define TARGET_ICRNL   0000400
+#define TARGET_IUCLC   0001000
+#define TARGET_IXON    0002000
+#define TARGET_IXANY   0004000
+#define TARGET_IXOFF   0010000
+#define TARGET_IMAXBEL 0020000
+#define TARGET_IUTF8   0040000
+
+/* c_oflag bits */
+#define TARGET_OPOST   0000001
+#define TARGET_OLCUC   0000002
+#define TARGET_ONLCR   0000004
+#define TARGET_OCRNL   0000010
+#define TARGET_ONOCR   0000020
+#define TARGET_ONLRET  0000040
+#define TARGET_OFILL   0000100
+#define TARGET_OFDEL   0000200
+#define TARGET_NLDLY   0000400
+#define   TARGET_NL0   0000000
+#define   TARGET_NL1   0000400
+#define TARGET_CRDLY   0003000
+#define   TARGET_CR0   0000000
+#define   TARGET_CR1   0001000
+#define   TARGET_CR2   0002000
+#define   TARGET_CR3   0003000
+#define TARGET_TABDLY  0014000
+#define   TARGET_TAB0  0000000
+#define   TARGET_TAB1  0004000
+#define   TARGET_TAB2  0010000
+#define   TARGET_TAB3  0014000
+#define   TARGET_XTABS 0014000
+#define TARGET_BSDLY   0020000
+#define   TARGET_BS0   0000000
+#define   TARGET_BS1   0020000
+#define TARGET_VTDLY   0040000
+#define   TARGET_VT0   0000000
+#define   TARGET_VT1   0040000
+#define TARGET_FFDLY   0100000
+#define   TARGET_FF0   0000000
+#define   TARGET_FF1   0100000
+
+/* c_cflag bit meaning */
+#define TARGET_CBAUD   0010017
+#define  TARGET_B0     0000000         /* hang up */
+#define  TARGET_B50    0000001
+#define  TARGET_B75    0000002
+#define  TARGET_B110   0000003
+#define  TARGET_B134   0000004
+#define  TARGET_B150   0000005
+#define  TARGET_B200   0000006
+#define  TARGET_B300   0000007
+#define  TARGET_B600   0000010
+#define  TARGET_B1200  0000011
+#define  TARGET_B1800  0000012
+#define  TARGET_B2400  0000013
+#define  TARGET_B4800  0000014
+#define  TARGET_B9600  0000015
+#define  TARGET_B19200 0000016
+#define  TARGET_B38400 0000017
+#define TARGET_EXTA B19200
+#define TARGET_EXTB B38400
+#define TARGET_CSIZE   0000060
+#define   TARGET_CS5   0000000
+#define   TARGET_CS6   0000020
+#define   TARGET_CS7   0000040
+#define   TARGET_CS8   0000060
+#define TARGET_CSTOPB  0000100
+#define TARGET_CREAD   0000200
+#define TARGET_PARENB  0000400
+#define TARGET_PARODD  0001000
+#define TARGET_HUPCL   0002000
+#define TARGET_CLOCAL  0004000
+#define TARGET_CBAUDEX 0010000
+#define  TARGET_B57600  0010001
+#define  TARGET_B115200 0010002
+#define  TARGET_B230400 0010003
+#define  TARGET_B460800 0010004
+#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
+#define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
+#define TARGET_CRTSCTS   020000000000  /* flow control */
+
+/* c_lflag bits */
+#define TARGET_ISIG    0000001
+#define TARGET_ICANON  0000002
+#define TARGET_XCASE   0000004
+#define TARGET_ECHO    0000010
+#define TARGET_ECHOE   0000020
+#define TARGET_ECHOK   0000040
+#define TARGET_ECHONL  0000100
+#define TARGET_NOFLSH  0000200
+#define TARGET_TOSTOP  0000400
+#define TARGET_ECHOCTL 0001000
+#define TARGET_ECHOPRT 0002000
+#define TARGET_ECHOKE  0004000
+#define TARGET_FLUSHO  0010000
+#define TARGET_PENDIN  0040000
+#define TARGET_IEXTEN  0100000
+
+/* c_cc character offsets */
+#define TARGET_VINTR    0
+#define TARGET_VQUIT    1
+#define TARGET_VERASE   2
+#define TARGET_VKILL    3
+#define TARGET_VEOF     4
+#define TARGET_VTIME    5
+#define TARGET_VMIN     6
+#define TARGET_VSWTC    7
+#define TARGET_VSTART   8
+#define TARGET_VSTOP    9
+#define TARGET_VSUSP    10
+#define TARGET_VEOL     11
+#define TARGET_VREPRINT 12
+#define TARGET_VDISCARD 13
+#define TARGET_VWERASE  14
+#define TARGET_VLNEXT   15
+#define TARGET_VEOL2    16
+
+/* ioctls */
+
+#define TARGET_TCGETS           0x5401
+#define TARGET_TCSETS           0x5402
+#define TARGET_TCSETSW          0x5403
+#define TARGET_TCSETSF          0x5404
+#define TARGET_TCGETA           0x5405
+#define TARGET_TCSETA           0x5406
+#define TARGET_TCSETAW          0x5407
+#define TARGET_TCSETAF          0x5408
+#define TARGET_TCSBRK           0x5409
+#define TARGET_TCXONC           0x540A
+#define TARGET_TCFLSH           0x540B
+
+#define TARGET_TIOCEXCL         0x540C
+#define TARGET_TIOCNXCL         0x540D
+#define TARGET_TIOCSCTTY        0x540E
+#define TARGET_TIOCGPGRP        0x540F
+#define TARGET_TIOCSPGRP        0x5410
+#define TARGET_TIOCOUTQ         0x5411
+#define TARGET_TIOCSTI          0x5412
+#define TARGET_TIOCGWINSZ       0x5413
+#define TARGET_TIOCSWINSZ       0x5414
+#define TARGET_TIOCMGET         0x5415
+#define TARGET_TIOCMBIS         0x5416
+#define TARGET_TIOCMBIC         0x5417
+#define TARGET_TIOCMSET         0x5418
+#define TARGET_TIOCGSOFTCAR     0x5419
+#define TARGET_TIOCSSOFTCAR     0x541A
+#define TARGET_FIONREAD         0x541B
+#define TARGET_TIOCINQ          TARGET_FIONREAD
+#define TARGET_TIOCLINUX        0x541C
+#define TARGET_TIOCCONS         0x541D
+#define TARGET_TIOCGSERIAL      0x541E
+#define TARGET_TIOCSSERIAL      0x541F
+#define TARGET_TIOCPKT          0x5420
+#define TARGET_FIONBIO          0x5421
+#define TARGET_TIOCNOTTY        0x5422
+#define TARGET_TIOCSETD         0x5423
+#define TARGET_TIOCGETD         0x5424
+#define TARGET_TCSBRKP          0x5425 /* Needed for POSIX tcsendbreak() */
+#define TARGET_TIOCTTYGSTRUCT   0x5426 /* For debugging only */
+#define TARGET_TIOCSBRK         0x5427 /* BSD compatibility */
+#define TARGET_TIOCCBRK         0x5428 /* BSD compatibility */
+#define TARGET_TIOCGSID         0x5429 /* Return the session ID of FD */
+#define TARGET_TIOCGPTN         TARGET_IOR('T', 0x30, unsigned int)
+        /* Get Pty Number (of pty-mux device) */
+#define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
+        /* Lock/unlock Pty */
+
+#define TARGET_FIONCLEX         0x5450  /* these numbers need to be adjusted. */
+#define TARGET_FIOCLEX          0x5451
+#define TARGET_FIOASYNC         0x5452
+#define TARGET_TIOCSERCONFIG    0x5453
+#define TARGET_TIOCSERGWILD     0x5454
+#define TARGET_TIOCSERSWILD     0x5455
+#define TARGET_TIOCGLCKTRMIOS   0x5456
+#define TARGET_TIOCSLCKTRMIOS   0x5457
+#define TARGET_TIOCSERGSTRUCT   0x5458 /* For debugging only */
+#define TARGET_TIOCSERGETLSR    0x5459 /* Get line status register */
+#define TARGET_TIOCSERGETMULTI  0x545A /* Get multiport config  */
+#define TARGET_TIOCSERSETMULTI  0x545B /* Set multiport config */
+
+#define TARGET_TIOCMIWAIT      0x545C
+        /* wait for a change on serial input line(s) */
+#define TARGET_TIOCGICOUNT     0x545D
+        /* read serial port inline interrupt counts */
+#define TARGET_TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
+#define TARGET_TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
+
+/* Used for packet mode */
+#define TARGET_TIOCPKT_DATA              0
+#define TARGET_TIOCPKT_FLUSHREAD         1
+#define TARGET_TIOCPKT_FLUSHWRITE        2
+#define TARGET_TIOCPKT_STOP              4
+#define TARGET_TIOCPKT_START             8
+#define TARGET_TIOCPKT_NOSTOP           16
+#define TARGET_TIOCPKT_DOSTOP           32
+
+#define TARGET_TIOCSER_TEMT    0x01 /* Transmitter physically empty */
diff --git a/linux-user/signal.c b/linux-user/signal.c
index c750053edd..4e4115b6f2 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -254,7 +254,7 @@ int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
 }
 
 #if !defined(TARGET_OPENRISC) && !defined(TARGET_UNICORE32) && \
-    !defined(TARGET_X86_64)
+    !defined(TARGET_X86_64) && !defined(TARGET_NIOS2)
 /* Just set the guest's signal mask to the specified value; the
  * caller is assumed to have called block_signals() already.
  */
@@ -3922,6 +3922,240 @@ long do_rt_sigreturn(CPUCRISState *env)
     return -TARGET_ENOSYS;
 }
 
+#elif defined(TARGET_NIOS2)
+
+#define MCONTEXT_VERSION 2
+
+struct target_sigcontext {
+    int version;
+    unsigned long gregs[32];
+};
+
+struct target_ucontext {
+    abi_ulong tuc_flags;
+    abi_ulong tuc_link;
+    target_stack_t tuc_stack;
+    struct target_sigcontext tuc_mcontext;
+    target_sigset_t tuc_sigmask;   /* mask last for extensibility */
+};
+
+struct target_rt_sigframe {
+    struct target_siginfo info;
+    struct target_ucontext uc;
+};
+
+static unsigned long sigsp(unsigned long sp, struct target_sigaction *ka)
+{
+    if (unlikely((ka->sa_flags & SA_ONSTACK)) && !sas_ss_flags(sp)) {
+#ifdef CONFIG_STACK_GROWSUP
+        return target_sigaltstack_used.ss_sp;
+#else
+        return target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+#endif
+    }
+    return sp;
+}
+
+static int rt_setup_ucontext(struct target_ucontext *uc, CPUNios2State *env)
+{
+    unsigned long *gregs = uc->tuc_mcontext.gregs;
+
+    __put_user(MCONTEXT_VERSION, &uc->tuc_mcontext.version);
+    __put_user(env->regs[1], &gregs[0]);
+    __put_user(env->regs[2], &gregs[1]);
+    __put_user(env->regs[3], &gregs[2]);
+    __put_user(env->regs[4], &gregs[3]);
+    __put_user(env->regs[5], &gregs[4]);
+    __put_user(env->regs[6], &gregs[5]);
+    __put_user(env->regs[7], &gregs[6]);
+    __put_user(env->regs[8], &gregs[7]);
+    __put_user(env->regs[9], &gregs[8]);
+    __put_user(env->regs[10], &gregs[9]);
+    __put_user(env->regs[11], &gregs[10]);
+    __put_user(env->regs[12], &gregs[11]);
+    __put_user(env->regs[13], &gregs[12]);
+    __put_user(env->regs[14], &gregs[13]);
+    __put_user(env->regs[15], &gregs[14]);
+    __put_user(env->regs[16], &gregs[15]);
+    __put_user(env->regs[17], &gregs[16]);
+    __put_user(env->regs[18], &gregs[17]);
+    __put_user(env->regs[19], &gregs[18]);
+    __put_user(env->regs[20], &gregs[19]);
+    __put_user(env->regs[21], &gregs[20]);
+    __put_user(env->regs[22], &gregs[21]);
+    __put_user(env->regs[23], &gregs[22]);
+    __put_user(env->regs[R_RA], &gregs[23]);
+    __put_user(env->regs[R_FP], &gregs[24]);
+    __put_user(env->regs[R_GP], &gregs[25]);
+    __put_user(env->regs[R_EA], &gregs[27]);
+    __put_user(env->regs[R_SP], &gregs[28]);
+
+    return 0;
+}
+
+static int rt_restore_ucontext(CPUNios2State *env, struct target_ucontext *uc,
+                               int *pr2)
+{
+    int temp;
+    abi_ulong off, frame_addr = env->regs[R_SP];
+    unsigned long *gregs = uc->tuc_mcontext.gregs;
+    int err;
+
+    /* Always make any pending restarted system calls return -EINTR */
+    /* current->restart_block.fn = do_no_restart_syscall; */
+
+    __get_user(temp, &uc->tuc_mcontext.version);
+    if (temp != MCONTEXT_VERSION) {
+        return 1;
+    }
+
+    /* restore passed registers */
+    __get_user(env->regs[1], &gregs[0]);
+    __get_user(env->regs[2], &gregs[1]);
+    __get_user(env->regs[3], &gregs[2]);
+    __get_user(env->regs[4], &gregs[3]);
+    __get_user(env->regs[5], &gregs[4]);
+    __get_user(env->regs[6], &gregs[5]);
+    __get_user(env->regs[7], &gregs[6]);
+    __get_user(env->regs[8], &gregs[7]);
+    __get_user(env->regs[9], &gregs[8]);
+    __get_user(env->regs[10], &gregs[9]);
+    __get_user(env->regs[11], &gregs[10]);
+    __get_user(env->regs[12], &gregs[11]);
+    __get_user(env->regs[13], &gregs[12]);
+    __get_user(env->regs[14], &gregs[13]);
+    __get_user(env->regs[15], &gregs[14]);
+    __get_user(env->regs[16], &gregs[15]);
+    __get_user(env->regs[17], &gregs[16]);
+    __get_user(env->regs[18], &gregs[17]);
+    __get_user(env->regs[19], &gregs[18]);
+    __get_user(env->regs[20], &gregs[19]);
+    __get_user(env->regs[21], &gregs[20]);
+    __get_user(env->regs[22], &gregs[21]);
+    __get_user(env->regs[23], &gregs[22]);
+    /* gregs[23] is handled below */
+    /* Verify, should this be settable */
+    __get_user(env->regs[R_FP], &gregs[24]);
+    /* Verify, should this be settable */
+    __get_user(env->regs[R_GP], &gregs[25]);
+    /* Not really necessary no user settable bits */
+    __get_user(temp, &gregs[26]);
+    __get_user(env->regs[R_EA], &gregs[27]);
+
+    __get_user(env->regs[R_RA], &gregs[23]);
+    __get_user(env->regs[R_SP], &gregs[28]);
+
+    off = offsetof(struct target_rt_sigframe, uc.tuc_stack);
+    err = do_sigaltstack(frame_addr + off, 0, get_sp_from_cpustate(env));
+    if (err == -EFAULT) {
+        return 1;
+    }
+
+    *pr2 = env->regs[2];
+    return 0;
+}
+
+static void *get_sigframe(struct target_sigaction *ka, CPUNios2State *env,
+                          size_t frame_size)
+{
+    unsigned long usp;
+
+    /* Default to using normal stack.  */
+    usp = env->regs[R_SP];
+
+    /* This is the X/Open sanctioned signal stack switching.  */
+    usp = sigsp(usp, ka);
+
+    /* Verify, is it 32 or 64 bit aligned */
+    return (void *)((usp - frame_size) & -8UL);
+}
+
+static void setup_rt_frame(int sig, struct target_sigaction *ka,
+                           target_siginfo_t *info,
+                           target_sigset_t *set,
+                           CPUNios2State *env)
+{
+    struct target_rt_sigframe *frame;
+    int i, err = 0;
+
+    frame = get_sigframe(ka, env, sizeof(*frame));
+
+    if (ka->sa_flags & SA_SIGINFO) {
+        tswap_siginfo(&frame->info, info);
+    }
+
+    /* Create the ucontext.  */
+    __put_user(0, &frame->uc.tuc_flags);
+    __put_user(0, &frame->uc.tuc_link);
+    __put_user(target_sigaltstack_used.ss_sp, &frame->uc.tuc_stack.ss_sp);
+    __put_user(sas_ss_flags(env->regs[R_SP]), &frame->uc.tuc_stack.ss_flags);
+    __put_user(target_sigaltstack_used.ss_size, &frame->uc.tuc_stack.ss_size);
+    err |= rt_setup_ucontext(&frame->uc, env);
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
+        __put_user((abi_ulong)set->sig[i],
+            (abi_ulong *)&frame->uc.tuc_sigmask.sig[i]);
+    }
+
+    if (err) {
+        goto give_sigsegv;
+    }
+
+    /* Set up to return from userspace; jump to fixed address sigreturn
+       trampoline on kuser page.  */
+    env->regs[R_RA] = (unsigned long) (0x1044);
+
+    /* Set up registers for signal handler */
+    env->regs[R_SP] = (unsigned long) frame;
+    env->regs[4] = (unsigned long) sig;
+    env->regs[5] = (unsigned long) &frame->info;
+    env->regs[6] = (unsigned long) &frame->uc;
+    env->regs[R_EA] = (unsigned long) ka->_sa_handler;
+    return;
+
+give_sigsegv:
+    if (sig == TARGET_SIGSEGV) {
+        ka->_sa_handler = TARGET_SIG_DFL;
+    }
+    force_sigsegv(sig);
+    return;
+}
+
+long do_sigreturn(CPUNios2State *env)
+{
+    trace_user_do_sigreturn(env, 0);
+    fprintf(stderr, "do_sigreturn: not implemented\n");
+    return -TARGET_ENOSYS;
+}
+
+long do_rt_sigreturn(CPUNios2State *env)
+{
+    /* Verify, can we follow the stack back */
+    abi_ulong frame_addr = env->regs[R_SP];
+    struct target_rt_sigframe *frame;
+    sigset_t set;
+    int rval;
+
+    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+        goto badframe;
+    }
+
+    target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
+    do_sigprocmask(SIG_SETMASK, &set, NULL);
+
+    if (rt_restore_ucontext(env, &frame->uc, &rval)) {
+        goto badframe;
+    }
+
+    unlock_user_struct(frame, frame_addr, 0);
+    return rval;
+
+badframe:
+    unlock_user_struct(frame, frame_addr, 0);
+    force_sig(TARGET_SIGSEGV);
+    return 0;
+}
+/* TARGET_NIOS2 */
+
 #elif defined(TARGET_OPENRISC)
 
 struct target_sigcontext {
@@ -5989,7 +6223,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
         /* prepare the stack frame of the virtual CPU */
 #if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64) \
         || defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) \
-        || defined(TARGET_PPC64)
+        || defined(TARGET_PPC64) || defined(TARGET_NIOS2)
         /* These targets do not have traditional signals.  */
         setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
 #else
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 0b15466743..b83e7a58c5 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -70,7 +70,8 @@
 #if defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_SH4) \
     || defined(TARGET_M68K) || defined(TARGET_CRIS) \
     || defined(TARGET_UNICORE32) || defined(TARGET_S390X) \
-    || defined(TARGET_OPENRISC) || defined(TARGET_TILEGX)
+    || defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) \
+    || defined(TARGET_NIOS2)
 
 #define TARGET_IOC_SIZEBITS	14
 #define TARGET_IOC_DIRBITS	2
@@ -417,7 +418,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     || defined(TARGET_M68K) || defined(TARGET_ALPHA) || defined(TARGET_CRIS) \
     || defined(TARGET_MICROBLAZE) || defined(TARGET_UNICORE32) \
     || defined(TARGET_S390X) || defined(TARGET_OPENRISC) \
-    || defined(TARGET_TILEGX)
+    || defined(TARGET_TILEGX) || defined(TARGET_NIOS2)
 
 #if defined(TARGET_SPARC)
 #define TARGET_SA_NOCLDSTOP    8u
@@ -1974,7 +1975,8 @@ struct target_stat {
     abi_ulong  target_st_ctime_nsec;
     unsigned int __unused[2];
 };
-#elif defined(TARGET_OPENRISC) || defined(TARGET_TILEGX)
+#elif defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) || \
+      defined(TARGET_NIOS2)
 
 /* These are the asm-generic versions of the stat and stat64 structures */
 
-- 
2.11.0
