Received: from eggs.gnu.org ([2001:4830:134:3::10]:45028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ7P-0006PK-LG
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ7F-0000WJ-QH
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:15 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:43837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZQ7F-0000Ut-4x
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:05 -0500
Received: by mail-pg0-x242.google.com with SMTP id f14so1092392pga.10
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 15:49:04 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 15:46:29 -0800
Message-Id: <1515628000-93285-11-git-send-email-mjc@sifive.com>
In-Reply-To: <1515628000-93285-1-git-send-email-mjc@sifive.com>
References: <1515628000-93285-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 10/21] RISC-V Linux User Emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches+subscribe@groups.riscv.org>

Implementation of linux user emulation for RISC-V.

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 linux-user/elfload.c              |  22 +++
 linux-user/main.c                 | 114 +++++++++++++++
 linux-user/riscv/syscall_nr.h     | 275 +++++++++++++++++++++++++++++++++++
 linux-user/riscv/target_cpu.h     |  18 +++
 linux-user/riscv/target_signal.h  |  23 +++
 linux-user/riscv/target_structs.h |  46 ++++++
 linux-user/riscv/target_syscall.h |  56 ++++++++
 linux-user/riscv/termbits.h       | 220 ++++++++++++++++++++++++++++
 linux-user/signal.c               | 203 +++++++++++++++++++++++++-
 linux-user/syscall.c              |   2 +
 linux-user/syscall_defs.h         |  13 +-
 target/riscv/cpu_user.h           |  26 ++++
 target/riscv/user_atomic.c        | 291 ++++++++++++++++++++++++++++++++++++++
 13 files changed, 1303 insertions(+), 6 deletions(-)
 create mode 100644 linux-user/riscv/syscall_nr.h
 create mode 100644 linux-user/riscv/target_cpu.h
 create mode 100644 linux-user/riscv/target_signal.h
 create mode 100644 linux-user/riscv/target_structs.h
 create mode 100644 linux-user/riscv/target_syscall.h
 create mode 100644 linux-user/riscv/termbits.h
 create mode 100644 target/riscv/cpu_user.h
 create mode 100644 target/riscv/user_atomic.c

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 20f3d8c..178af56 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1272,6 +1272,28 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #endif /* TARGET_TILEGX */
 
+#ifdef TARGET_RISCV
+
+#define ELF_START_MMAP 0x80000000
+#define ELF_ARCH  EM_RISCV
+
+#ifdef TARGET_RISCV32
+#define ELF_CLASS ELFCLASS32
+#else
+#define ELF_CLASS ELFCLASS64
+#endif
+
+static inline void init_thread(struct target_pt_regs *regs,
+                               struct image_info *infop)
+{
+    regs->sepc = infop->entry;
+    regs->sp = infop->start_stack;
+}
+
+#define ELF_EXEC_PAGESIZE 4096
+
+#endif /* TARGET_RISCV */
+
 #ifdef TARGET_HPPA
 
 #define ELF_START_MMAP  0x80000000
diff --git a/linux-user/main.c b/linux-user/main.c
index 99a551b..2b8fcc2 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -3647,6 +3647,115 @@ void cpu_loop(CPUTLGState *env)
 
 #endif
 
+#ifdef TARGET_RISCV
+
+void cpu_loop(CPURISCVState *env)
+{
+    CPUState *cs = CPU(riscv_env_get_cpu(env));
+    int trapnr, signum, sigcode;
+    target_ulong sigaddr;
+    target_ulong ret;
+
+    for (;;) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+
+        signum = 0;
+        sigcode = 0;
+        sigaddr = 0;
+
+        switch (trapnr) {
+        case EXCP_INTERRUPT:
+            /* just indicate that signals should be handled asap */
+            break;
+        case RISCV_EXCP_U_ECALL:
+            env->pc += 4;
+            if (env->gpr[xA7] == TARGET_NR_arch_specific_syscall + 15) {
+                /* riscv_flush_icache_syscall is a no-op in QEMU as
+                   self-modifying code is automatically detected */
+                ret = 0;
+            } else {
+                ret = do_syscall(env,
+                                 env->gpr[xA7],
+                                 env->gpr[xA0],
+                                 env->gpr[xA1],
+                                 env->gpr[xA2],
+                                 env->gpr[xA3],
+                                 env->gpr[xA4],
+                                 env->gpr[xA5],
+                                 0, 0);
+            }
+            if (ret == -TARGET_ERESTARTSYS) {
+                env->pc -= 4;
+            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
+                env->gpr[xA0] = ret;
+            }
+            if (cs->singlestep_enabled) {
+                goto gdbstep;
+            }
+            break;
+        case QEMU_USER_EXCP_ATOMIC:
+            start_exclusive();
+            switch (riscv_cpu_do_usermode_amo(cs)) {
+            case RISCV_AMO_OK:
+                env->pc += 4;
+                break;
+            case RISCV_AMO_BADADDR:
+                signum = TARGET_SIGSEGV;
+                sigcode = TARGET_SEGV_MAPERR;
+                sigaddr = env->badaddr;
+                break;
+            case RISCV_AMO_BADINSN:
+            default:
+                signum = TARGET_SIGILL;
+                sigcode = TARGET_ILL_ILLOPC;
+            }
+            end_exclusive();
+            if (cs->singlestep_enabled) {
+                goto gdbstep;
+            }
+            break;
+        case RISCV_EXCP_ILLEGAL_INST:
+            signum = TARGET_SIGILL;
+            sigcode = TARGET_ILL_ILLOPC;
+            break;
+        case RISCV_EXCP_BREAKPOINT:
+            signum = TARGET_SIGTRAP;
+            sigcode = TARGET_TRAP_BRKPT;
+            sigaddr = env->pc;
+            break;
+        case QEMU_USER_EXCP_FAULT:
+            signum = TARGET_SIGSEGV;
+            sigcode = TARGET_SEGV_MAPERR;
+            break;
+        case EXCP_DEBUG:
+        gdbstep:
+            signum = gdb_handlesig(cs, TARGET_SIGTRAP);
+            sigcode = TARGET_TRAP_BRKPT;
+            break;
+        default:
+            EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x - aborting\n",
+                     trapnr);
+            exit(EXIT_FAILURE);
+        }
+
+        if (signum) {
+            target_siginfo_t info = {
+                .si_signo = signum,
+                .si_errno = 0,
+                .si_code = sigcode,
+                ._sifields._sigfault._addr = sigaddr
+            };
+            queue_signal(env, info.si_signo, QEMU_SI_KILL, &info);
+        }
+
+        process_pending_signals(env);
+    }
+}
+
+#endif /* TARGET_RISCV */
+
 #ifdef TARGET_HPPA
 
 static abi_ulong hppa_lws(CPUHPPAState *env)
@@ -4809,6 +4918,11 @@ int main(int argc, char **argv, char **envp)
         env->pc = regs->pc;
         cpu_set_sr(env, regs->sr);
     }
+#elif defined(TARGET_RISCV)
+    {
+        env->pc = regs->sepc;
+        env->gpr[xSP] = regs->sp;
+    }
 #elif defined(TARGET_SH4)
     {
         int i;
diff --git a/linux-user/riscv/syscall_nr.h b/linux-user/riscv/syscall_nr.h
new file mode 100644
index 0000000..bd164ef
--- /dev/null
+++ b/linux-user/riscv/syscall_nr.h
@@ -0,0 +1,275 @@
+/*
+ * Syscall numbers from asm-generic, common for most
+ * of recently-added arches including RISC-V.
+ */
+
+#define TARGET_NR_io_setup 0
+#define TARGET_NR_io_destroy 1
+#define TARGET_NR_io_submit 2
+#define TARGET_NR_io_cancel 3
+#define TARGET_NR_io_getevents 4
+#define TARGET_NR_setxattr 5
+#define TARGET_NR_lsetxattr 6
+#define TARGET_NR_fsetxattr 7
+#define TARGET_NR_getxattr 8
+#define TARGET_NR_lgetxattr 9
+#define TARGET_NR_fgetxattr 10
+#define TARGET_NR_listxattr 11
+#define TARGET_NR_llistxattr 12
+#define TARGET_NR_flistxattr 13
+#define TARGET_NR_removexattr 14
+#define TARGET_NR_lremovexattr 15
+#define TARGET_NR_fremovexattr 16
+#define TARGET_NR_getcwd 17
+#define TARGET_NR_lookup_dcookie 18
+#define TARGET_NR_eventfd2 19
+#define TARGET_NR_epoll_create1 20
+#define TARGET_NR_epoll_ctl 21
+#define TARGET_NR_epoll_pwait 22
+#define TARGET_NR_dup 23
+#define TARGET_NR_dup3 24
+#ifdef TARGET_RISCV32
+#define TARGET_NR_fcntl64 25
+#else
+#define TARGET_NR_fcntl 25
+#endif
+#define TARGET_NR_inotify_init1 26
+#define TARGET_NR_inotify_add_watch 27
+#define TARGET_NR_inotify_rm_watch 28
+#define TARGET_NR_ioctl 29
+#define TARGET_NR_ioprio_set 30
+#define TARGET_NR_ioprio_get 31
+#define TARGET_NR_flock 32
+#define TARGET_NR_mknodat 33
+#define TARGET_NR_mkdirat 34
+#define TARGET_NR_unlinkat 35
+#define TARGET_NR_symlinkat 36
+#define TARGET_NR_linkat 37
+#define TARGET_NR_renameat 38
+#define TARGET_NR_umount2 39
+#define TARGET_NR_mount 40
+#define TARGET_NR_pivot_root 41
+#define TARGET_NR_nfsservctl 42
+#define TARGET_NR_statfs 43
+#define TARGET_NR_fstatfs 44
+#define TARGET_NR_truncate 45
+#define TARGET_NR_ftruncate 46
+#define TARGET_NR_fallocate 47
+#define TARGET_NR_faccessat 48
+#define TARGET_NR_chdir 49
+#define TARGET_NR_fchdir 50
+#define TARGET_NR_chroot 51
+#define TARGET_NR_fchmod 52
+#define TARGET_NR_fchmodat 53
+#define TARGET_NR_fchownat 54
+#define TARGET_NR_fchown 55
+#define TARGET_NR_openat 56
+#define TARGET_NR_close 57
+#define TARGET_NR_vhangup 58
+#define TARGET_NR_pipe2 59
+#define TARGET_NR_quotactl 60
+#define TARGET_NR_getdents64 61
+#define TARGET_NR_lseek 62
+#define TARGET_NR_read 63
+#define TARGET_NR_write 64
+#define TARGET_NR_readv 65
+#define TARGET_NR_writev 66
+#define TARGET_NR_pread64 67
+#define TARGET_NR_pwrite64 68
+#define TARGET_NR_preadv 69
+#define TARGET_NR_pwritev 70
+#define TARGET_NR_sendfile 71
+#define TARGET_NR_pselect6 72
+#define TARGET_NR_ppoll 73
+#define TARGET_NR_signalfd4 74
+#define TARGET_NR_vmsplice 75
+#define TARGET_NR_splice 76
+#define TARGET_NR_tee 77
+#define TARGET_NR_readlinkat 78
+#define TARGET_NR_newfstatat 79
+#define TARGET_NR_fstat 80
+#define TARGET_NR_sync 81
+#define TARGET_NR_fsync 82
+#define TARGET_NR_fdatasync 83
+#define TARGET_NR_sync_file_range 84
+#define TARGET_NR_timerfd_create 85
+#define TARGET_NR_timerfd_settime 86
+#define TARGET_NR_timerfd_gettime 87
+#define TARGET_NR_utimensat 88
+#define TARGET_NR_acct 89
+#define TARGET_NR_capget 90
+#define TARGET_NR_capset 91
+#define TARGET_NR_personality 92
+#define TARGET_NR_exit 93
+#define TARGET_NR_exit_group 94
+#define TARGET_NR_waitid 95
+#define TARGET_NR_set_tid_address 96
+#define TARGET_NR_unshare 97
+#define TARGET_NR_futex 98
+#define TARGET_NR_set_robust_list 99
+#define TARGET_NR_get_robust_list 100
+#define TARGET_NR_nanosleep 101
+#define TARGET_NR_getitimer 102
+#define TARGET_NR_setitimer 103
+#define TARGET_NR_kexec_load 104
+#define TARGET_NR_init_module 105
+#define TARGET_NR_delete_module 106
+#define TARGET_NR_timer_create 107
+#define TARGET_NR_timer_gettime 108
+#define TARGET_NR_timer_getoverrun 109
+#define TARGET_NR_timer_settime 110
+#define TARGET_NR_timer_delete 111
+#define TARGET_NR_clock_settime 112
+#define TARGET_NR_clock_gettime 113
+#define TARGET_NR_clock_getres 114
+#define TARGET_NR_clock_nanosleep 115
+#define TARGET_NR_syslog 116
+#define TARGET_NR_ptrace 117
+#define TARGET_NR_sched_setparam 118
+#define TARGET_NR_sched_setscheduler 119
+#define TARGET_NR_sched_getscheduler 120
+#define TARGET_NR_sched_getparam 121
+#define TARGET_NR_sched_setaffinity 122
+#define TARGET_NR_sched_getaffinity 123
+#define TARGET_NR_sched_yield 124
+#define TARGET_NR_sched_get_priority_max 125
+#define TARGET_NR_sched_get_priority_min 126
+#define TARGET_NR_sched_rr_get_interval 127
+#define TARGET_NR_restart_syscall 128
+#define TARGET_NR_kill 129
+#define TARGET_NR_tkill 130
+#define TARGET_NR_tgkill 131
+#define TARGET_NR_sigaltstack 132
+#define TARGET_NR_rt_sigsuspend 133
+#define TARGET_NR_rt_sigaction 134
+#define TARGET_NR_rt_sigprocmask 135
+#define TARGET_NR_rt_sigpending 136
+#define TARGET_NR_rt_sigtimedwait 137
+#define TARGET_NR_rt_sigqueueinfo 138
+#define TARGET_NR_rt_sigreturn 139
+#define TARGET_NR_setpriority 140
+#define TARGET_NR_getpriority 141
+#define TARGET_NR_reboot 142
+#define TARGET_NR_setregid 143
+#define TARGET_NR_setgid 144
+#define TARGET_NR_setreuid 145
+#define TARGET_NR_setuid 146
+#define TARGET_NR_setresuid 147
+#define TARGET_NR_getresuid 148
+#define TARGET_NR_setresgid 149
+#define TARGET_NR_getresgid 150
+#define TARGET_NR_setfsuid 151
+#define TARGET_NR_setfsgid 152
+#define TARGET_NR_times 153
+#define TARGET_NR_setpgid 154
+#define TARGET_NR_getpgid 155
+#define TARGET_NR_getsid 156
+#define TARGET_NR_setsid 157
+#define TARGET_NR_getgroups 158
+#define TARGET_NR_setgroups 159
+#define TARGET_NR_uname 160
+#define TARGET_NR_sethostname 161
+#define TARGET_NR_setdomainname 162
+#define TARGET_NR_getrlimit 163
+#define TARGET_NR_setrlimit 164
+#define TARGET_NR_getrusage 165
+#define TARGET_NR_umask 166
+#define TARGET_NR_prctl 167
+#define TARGET_NR_getcpu 168
+#define TARGET_NR_gettimeofday 169
+#define TARGET_NR_settimeofday 170
+#define TARGET_NR_adjtimex 171
+#define TARGET_NR_getpid 172
+#define TARGET_NR_getppid 173
+#define TARGET_NR_getuid 174
+#define TARGET_NR_geteuid 175
+#define TARGET_NR_getgid 176
+#define TARGET_NR_getegid 177
+#define TARGET_NR_gettid 178
+#define TARGET_NR_sysinfo 179
+#define TARGET_NR_mq_open 180
+#define TARGET_NR_mq_unlink 181
+#define TARGET_NR_mq_timedsend 182
+#define TARGET_NR_mq_timedreceive 183
+#define TARGET_NR_mq_notify 184
+#define TARGET_NR_mq_getsetattr 185
+#define TARGET_NR_msgget 186
+#define TARGET_NR_msgctl 187
+#define TARGET_NR_msgrcv 188
+#define TARGET_NR_msgsnd 189
+#define TARGET_NR_semget 190
+#define TARGET_NR_semctl 191
+#define TARGET_NR_semtimedop 192
+#define TARGET_NR_semop 193
+#define TARGET_NR_shmget 194
+#define TARGET_NR_shmctl 195
+#define TARGET_NR_shmat 196
+#define TARGET_NR_shmdt 197
+#define TARGET_NR_socket 198
+#define TARGET_NR_socketpair 199
+#define TARGET_NR_bind 200
+#define TARGET_NR_listen 201
+#define TARGET_NR_accept 202
+#define TARGET_NR_connect 203
+#define TARGET_NR_getsockname 204
+#define TARGET_NR_getpeername 205
+#define TARGET_NR_sendto 206
+#define TARGET_NR_recvfrom 207
+#define TARGET_NR_setsockopt 208
+#define TARGET_NR_getsockopt 209
+#define TARGET_NR_shutdown 210
+#define TARGET_NR_sendmsg 211
+#define TARGET_NR_recvmsg 212
+#define TARGET_NR_readahead 213
+#define TARGET_NR_brk 214
+#define TARGET_NR_munmap 215
+#define TARGET_NR_mremap 216
+#define TARGET_NR_add_key 217
+#define TARGET_NR_request_key 218
+#define TARGET_NR_keyctl 219
+#define TARGET_NR_clone 220
+#define TARGET_NR_execve 221
+#ifdef TARGET_RISCV32
+#define TARGET_NR_mmap2 222
+#define TARGET_NR_fadvise64_64 223
+#else
+#define TARGET_NR_mmap 222
+#define TARGET_NR_fadvise64 223
+#endif
+#define TARGET_NR_swapon 224
+#define TARGET_NR_swapoff 225
+#define TARGET_NR_mprotect 226
+#define TARGET_NR_msync 227
+#define TARGET_NR_mlock 228
+#define TARGET_NR_munlock 229
+#define TARGET_NR_mlockall 230
+#define TARGET_NR_munlockall 231
+#define TARGET_NR_mincore 232
+#define TARGET_NR_madvise 233
+#define TARGET_NR_remap_file_pages 234
+#define TARGET_NR_mbind 235
+#define TARGET_NR_get_mempolicy 236
+#define TARGET_NR_set_mempolicy 237
+#define TARGET_NR_migrate_pages 238
+#define TARGET_NR_move_pages 239
+#define TARGET_NR_rt_tgsigqueueinfo 240
+#define TARGET_NR_perf_event_open 241
+#define TARGET_NR_accept4 242
+#define TARGET_NR_recvmmsg 243
+#define TARGET_NR_arch_specific_syscall 244
+#define TARGET_NR_wait4 260
+#define TARGET_NR_prlimit64 261
+#define TARGET_NR_fanotify_init 262
+#define TARGET_NR_fanotify_mark 263
+#define TARGET_NR_name_to_handle_at 264
+#define TARGET_NR_open_by_handle_at 265
+#define TARGET_NR_clock_adjtime 266
+#define TARGET_NR_syncfs 267
+#define TARGET_NR_setns 268
+#define TARGET_NR_sendmmsg 269
+#define TARGET_NR_process_vm_readv 270
+#define TARGET_NR_process_vm_writev 271
+#define TARGET_NR_kcmp 272
+#define TARGET_NR_finit_module 273
+
+#define TARGET_NR_syscalls (__NR_finit_module + 1)
diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
new file mode 100644
index 0000000..c5549b1
--- /dev/null
+++ b/linux-user/riscv/target_cpu.h
@@ -0,0 +1,18 @@
+#ifndef TARGET_CPU_H
+#define TARGET_CPU_H
+
+static inline void cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
+{
+    if (newsp) {
+        env->gpr[xSP] = newsp;
+    }
+
+    env->gpr[xA0] = 0;
+}
+
+static inline void cpu_set_tls(CPURISCVState *env, target_ulong newtls)
+{
+    env->gpr[xTP] = newtls;
+}
+
+#endif
diff --git a/linux-user/riscv/target_signal.h b/linux-user/riscv/target_signal.h
new file mode 100644
index 0000000..ce77f75
--- /dev/null
+++ b/linux-user/riscv/target_signal.h
@@ -0,0 +1,23 @@
+#ifndef TARGET_SIGNAL_H
+#define TARGET_SIGNAL_H
+
+#include "cpu.h"
+
+typedef struct target_sigaltstack {
+    abi_ulong ss_sp;
+    abi_int ss_flags;
+    abi_ulong ss_size;
+} target_stack_t;
+
+#define TARGET_SS_ONSTACK 1
+#define TARGET_SS_DISABLE 2
+
+#define TARGET_MINSIGSTKSZ 2048
+#define TARGET_SIGSTKSZ 8192
+
+static inline abi_ulong get_sp_from_cpustate(CPURISCVState *state)
+{
+   return state->gpr[xSP];
+}
+
+#endif /* TARGET_SIGNAL_H */
diff --git a/linux-user/riscv/target_structs.h b/linux-user/riscv/target_structs.h
new file mode 100644
index 0000000..4f0462c
--- /dev/null
+++ b/linux-user/riscv/target_structs.h
@@ -0,0 +1,46 @@
+/*
+ * RISC-V specific structures for linux-user
+ *
+ * This is a copy of ../aarch64/target_structs.h atm.
+ *
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
diff --git a/linux-user/riscv/target_syscall.h b/linux-user/riscv/target_syscall.h
new file mode 100644
index 0000000..d4e109a
--- /dev/null
+++ b/linux-user/riscv/target_syscall.h
@@ -0,0 +1,56 @@
+/*
+ * This struct defines the way the registers are stored on the
+ *  stack during a system call.
+ *
+ * Reference: linux/arch/riscv/include/uapi/asm/ptrace.h
+ */
+
+struct target_pt_regs {
+    abi_long sepc;
+    abi_long ra;
+    abi_long sp;
+    abi_long gp;
+    abi_long tp;
+    abi_long t0;
+    abi_long t1;
+    abi_long t2;
+    abi_long s0;
+    abi_long s1;
+    abi_long a0;
+    abi_long a1;
+    abi_long a2;
+    abi_long a3;
+    abi_long a4;
+    abi_long a5;
+    abi_long a6;
+    abi_long a7;
+    abi_long s2;
+    abi_long s3;
+    abi_long s4;
+    abi_long s5;
+    abi_long s6;
+    abi_long s7;
+    abi_long s8;
+    abi_long s9;
+    abi_long s10;
+    abi_long s11;
+    abi_long t3;
+    abi_long t4;
+    abi_long t5;
+    abi_long t6;
+};
+
+#ifdef TARGET_RISCV32
+#define UNAME_MACHINE "riscv32"
+#else
+#define UNAME_MACHINE "riscv64"
+#endif
+#define UNAME_MINIMUM_RELEASE "3.8.0"
+
+#define TARGET_MINSIGSTKSZ 2048
+#define TARGET_MLOCKALL_MCL_CURRENT 1
+#define TARGET_MLOCKALL_MCL_FUTURE  2
+
+/* clone(flags, newsp, ptidptr, tls, ctidptr) for RISC-V */
+/* This comes from linux/kernel/fork.c, CONFIG_CLONE_BACKWARDS */
+#define TARGET_CLONE_BACKWARDS
diff --git a/linux-user/riscv/termbits.h b/linux-user/riscv/termbits.h
new file mode 100644
index 0000000..ec49dbf
--- /dev/null
+++ b/linux-user/riscv/termbits.h
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
+    unsigned char c_line;               /* line discipline */
+    unsigned char c_cc[TARGET_NCCS];    /* control characters */
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
index 74fa03f..f4668f0 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -535,6 +535,7 @@ static void force_sig(int sig)
  * up the signal frame. oldsig is the signal we were trying to handle
  * at the point of failure.
  */
+#if !defined(TARGET_RISCV)
 static void force_sigsegv(int oldsig)
 {
     if (oldsig == SIGSEGV) {
@@ -547,6 +548,8 @@ static void force_sigsegv(int oldsig)
 }
 #endif
 
+#endif
+
 /* abort execution with signal */
 static void QEMU_NORETURN dump_core_and_abort(int target_sig)
 {
@@ -6379,6 +6382,203 @@ long do_rt_sigreturn(CPUTLGState *env)
     return -TARGET_QEMU_ESIGRETURN;
 }
 
+#elif defined(TARGET_RISCV)
+
+/* Signal handler invocation must be transparent for the code being
+   interrupted. Complete CPU (hart) state is saved on entry and restored
+   before returning from the handler. Process sigmask is also saved to block
+   signals while the handler is running. The handler gets its own stack,
+   which also doubles as storage for the CPU state and sigmask.
+
+   The code below is qemu re-implementation of arch/riscv/kernel/signal.c */
+
+struct target_sigcontext {
+    abi_long pc;
+    abi_long gpr[31]; /* x0 is not present, so all offsets must be -1 */
+    uint64_t fpr[32];
+    uint32_t fcsr;
+}; /* cf. riscv-linux:arch/riscv/include/uapi/asm/ptrace.h */
+
+struct target_ucontext {
+    unsigned long uc_flags;
+    struct target_ucontext *uc_link;
+    target_stack_t uc_stack;
+    struct target_sigcontext uc_mcontext;
+    target_sigset_t uc_sigmask;
+};
+
+struct target_rt_sigframe {
+    uint32_t tramp[2]; /* not in kernel, which uses VDSO instead */
+    struct target_siginfo info;
+    struct target_ucontext uc;
+};
+
+static abi_ulong get_sigframe(struct target_sigaction *ka,
+                              CPURISCVState *regs, size_t framesize)
+{
+    abi_ulong sp = regs->gpr[xSP];
+    int onsigstack = on_sig_stack(sp);
+
+    /* redzone */
+    /* This is the X/Open sanctioned signal stack switching.  */
+    if ((ka->sa_flags & TARGET_SA_ONSTACK) != 0 && !onsigstack) {
+        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+    }
+
+    sp -= framesize;
+    sp &= ~3UL; /* align sp on 4-byte boundary */
+
+    /* If we are on the alternate signal stack and would overflow it, don't.
+       Return an always-bogus address instead so we will die with SIGSEGV. */
+    if (onsigstack && !likely(on_sig_stack(sp))) {
+        return -1L;
+    }
+
+    return sp;
+}
+
+static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
+{
+    int i;
+
+    __put_user(env->pc, &sc->pc);
+
+    for (i = 1; i < 32; i++) {
+        __put_user(env->gpr[i], &sc->gpr[i - 1]);
+    }
+    for (i = 0; i < 32; i++) {
+        __put_user(env->fpr[i], &sc->fpr[i]);
+    }
+
+    uint32_t fcsr = csr_read_helper(env, CSR_FCSR); /*riscv_get_fcsr(env);*/
+    __put_user(fcsr, &sc->fcsr);
+}
+
+static void setup_ucontext(struct target_ucontext *uc,
+                           CPURISCVState *env, target_sigset_t *set)
+{
+    abi_ulong ss_sp = (target_ulong)target_sigaltstack_used.ss_sp;
+    abi_ulong ss_flags = sas_ss_flags(env->gpr[xSP]);
+    abi_ulong ss_size = target_sigaltstack_used.ss_size;
+
+    __put_user(0,    &(uc->uc_flags));
+    __put_user(0,    &(uc->uc_link));
+
+    __put_user(ss_sp,    &(uc->uc_stack.ss_sp));
+    __put_user(ss_flags, &(uc->uc_stack.ss_flags));
+    __put_user(ss_size,  &(uc->uc_stack.ss_size));
+
+    int i;
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
+        __put_user(set->sig[i], &(uc->uc_sigmask.sig[i]));
+    }
+
+    setup_sigcontext(&uc->uc_mcontext, env);
+}
+
+static inline void install_sigtramp(uint32_t *tramp)
+{
+    __put_user(0x08b00893, tramp + 0);  /* li a7, 139 = __NR_rt_sigreturn */
+    __put_user(0x00000073, tramp + 1);  /* ecall */
+}
+
+static void setup_rt_frame(int sig, struct target_sigaction *ka,
+                           target_siginfo_t *info,
+                           target_sigset_t *set, CPURISCVState *env)
+{
+    abi_ulong frame_addr;
+    struct target_rt_sigframe *frame;
+
+    frame_addr = get_sigframe(ka, env, sizeof(*frame));
+    trace_user_setup_rt_frame(env, frame_addr);
+
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+        goto badframe;
+    }
+
+    setup_ucontext(&frame->uc, env, set);
+    tswap_siginfo(&frame->info, info);
+    install_sigtramp(frame->tramp);
+
+    env->pc = ka->_sa_handler;
+    env->gpr[xSP] = frame_addr;
+    env->gpr[xA0] = sig;
+    env->gpr[xA1] = frame_addr + offsetof(struct target_rt_sigframe, info);
+    env->gpr[xA2] = frame_addr + offsetof(struct target_rt_sigframe, uc);
+    env->gpr[xRA] = frame_addr + offsetof(struct target_rt_sigframe, tramp);
+
+    return;
+
+badframe:
+    unlock_user_struct(frame, frame_addr, 1);
+    if (sig == TARGET_SIGSEGV) {
+        ka->_sa_handler = TARGET_SIG_DFL;
+    }
+    force_sig(TARGET_SIGSEGV);
+}
+
+static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
+{
+    int i;
+
+    __get_user(env->pc, &sc->pc);
+
+    for (i = 1; i < 32; ++i) {
+        __get_user(env->gpr[i], &sc->gpr[i - 1]);
+    }
+    for (i = 0; i < 32; ++i) {
+        __get_user(env->fpr[i], &sc->fpr[i]);
+    }
+
+    uint32_t fcsr;
+    __get_user(fcsr, &sc->fcsr);
+    csr_write_helper(env, fcsr, CSR_FCSR);
+}
+
+static void restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
+{
+    sigset_t blocked;
+    target_sigset_t target_set;
+    int i;
+
+    target_sigemptyset(&target_set);
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
+        __get_user(target_set.sig[i], &(uc->uc_sigmask.sig[i]));
+    }
+
+    target_to_host_sigset_internal(&blocked, &target_set);
+    set_sigmask(&blocked);
+
+    restore_sigcontext(env, &uc->uc_mcontext);
+}
+
+long do_rt_sigreturn(CPURISCVState *env)
+{
+    struct target_rt_sigframe *frame;
+    abi_ulong frame_addr;
+
+    frame_addr = env->gpr[xSP];
+    trace_user_do_sigreturn(env, frame_addr);
+    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+        goto badframe;
+    }
+
+    restore_ucontext(env, &frame->uc);
+
+    if (do_sigaltstack(frame_addr + offsetof(struct target_rt_sigframe,
+            uc.uc_stack), 0, get_sp_from_cpustate(env)) == -EFAULT) {
+        goto badframe;
+    }
+
+    unlock_user_struct(frame, frame_addr, 0);
+    return -TARGET_QEMU_ESIGRETURN;
+
+badframe:
+    unlock_user_struct(frame, frame_addr, 0);
+    force_sig(TARGET_SIGSEGV);
+    return 0;
+}
+
 #elif defined(TARGET_HPPA)
 
 struct target_sigcontext {
@@ -6670,7 +6870,8 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
 #if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64) \
         || defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) \
         || defined(TARGET_PPC64) || defined(TARGET_HPPA) \
-        || defined(TARGET_NIOS2) || defined(TARGET_X86_64)
+        || defined(TARGET_NIOS2) || defined(TARGET_X86_64) \
+        || defined(TARGET_RISCV)
         /* These targets do not have traditional signals.  */
         setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
 #else
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11c9116..5e54889 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8434,9 +8434,11 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_ioctl:
         ret = do_ioctl(arg1, arg2, arg3);
         break;
+#ifdef TARGET_NR_fcntl
     case TARGET_NR_fcntl:
         ret = do_fcntl(arg1, arg2, arg3);
         break;
+#endif
 #ifdef TARGET_NR_mpx
     case TARGET_NR_mpx:
         goto unimplemented;
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index bec3680..e62112a 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -71,7 +71,7 @@
     || defined(TARGET_M68K) || defined(TARGET_CRIS) \
     || defined(TARGET_UNICORE32) || defined(TARGET_S390X) \
     || defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) \
-    || defined(TARGET_NIOS2)
+    || defined(TARGET_NIOS2) || defined(TARGET_RISCV)
 
 #define TARGET_IOC_SIZEBITS	14
 #define TARGET_IOC_DIRBITS	2
@@ -435,7 +435,8 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     || defined(TARGET_M68K) || defined(TARGET_ALPHA) || defined(TARGET_CRIS) \
     || defined(TARGET_MICROBLAZE) || defined(TARGET_UNICORE32) \
     || defined(TARGET_S390X) || defined(TARGET_OPENRISC) \
-    || defined(TARGET_TILEGX) || defined(TARGET_HPPA) || defined(TARGET_NIOS2)
+    || defined(TARGET_TILEGX) || defined(TARGET_HPPA) || defined(TARGET_NIOS2) \
+    || defined(TARGET_RISCV)
 
 #if defined(TARGET_SPARC)
 #define TARGET_SA_NOCLDSTOP    8u
@@ -2093,7 +2094,7 @@ struct target_stat {
     unsigned int __unused[2];
 };
 #elif defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) || \
-      defined(TARGET_NIOS2)
+      defined(TARGET_NIOS2) || defined(TARGET_RISCV)
 
 /* These are the asm-generic versions of the stat and stat64 structures */
 
@@ -2120,6 +2121,7 @@ struct target_stat {
     unsigned int __unused5;
 };
 
+#if !defined(TARGET_RISCV64)
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
     uint64_t st_dev;
@@ -2143,6 +2145,7 @@ struct target_stat64 {
     unsigned int __unused4;
     unsigned int __unused5;
 };
+#endif
 
 #elif defined(TARGET_HPPA)
 
@@ -2258,8 +2261,8 @@ struct target_statfs64 {
 	uint32_t	f_spare[6];
 };
 #elif (defined(TARGET_PPC64) || defined(TARGET_X86_64) || \
-       defined(TARGET_SPARC64) || defined(TARGET_AARCH64)) && \
-       !defined(TARGET_ABI32)
+       defined(TARGET_SPARC64) || defined(TARGET_AARCH64) || \
+       defined(TARGET_RISCV)) && !defined(TARGET_ABI32)
 struct target_statfs {
 	abi_long f_type;
 	abi_long f_bsize;
diff --git a/target/riscv/cpu_user.h b/target/riscv/cpu_user.h
new file mode 100644
index 0000000..c6e89bd
--- /dev/null
+++ b/target/riscv/cpu_user.h
@@ -0,0 +1,26 @@
+/* Return codes for riscv_cpu_do_userspace_amo */
+#define RISCV_AMO_OK      0
+#define RISCV_AMO_BADINSN 1
+#define RISCV_AMO_BADADDR 2
+
+/* not RISC-V exception codes - this is for qemu user-mode */
+#define QEMU_USER_EXCP_ATOMIC              0xc
+#define QEMU_USER_EXCP_FAULT               0xd
+
+#define xRA 1   /* return address (aka link register) */
+#define xSP 2   /* stack pointer */
+#define xGP 3   /* global pointer */
+#define xTP 4   /* thread pointer */
+
+#define xA0 10  /* gpr[10-17] are syscall arguments */
+#define xA1 11
+#define xA2 12
+#define xA3 13
+#define xA4 14
+#define xA5 15
+#define xA6 16
+#define xA7 17  /* syscall number goes here */
+
+#ifdef CONFIG_USER_ONLY
+int riscv_cpu_do_usermode_amo(CPUState *cs);
+#endif
diff --git a/target/riscv/user_atomic.c b/target/riscv/user_atomic.c
new file mode 100644
index 0000000..b1646d7
--- /dev/null
+++ b/target/riscv/user_atomic.c
@@ -0,0 +1,291 @@
+/*
+ * RISC-V user-mode atomic memory ops
+ *
+ * Copyright (c) 2016 Alex Suykov <alex.suykov@gmail.com>
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
+#include "qemu/osdep.h"
+#include "cpu.h"
+
+#ifdef CONFIG_USER_ONLY
+
+#include "qemu.h"
+
+/* The code in this file runs outside of cpu_loop and may not raise
+   any exceptions. Instead, it should return one of RISCV_AMO_* consts.
+
+   See comments around cpu_list_mutex in linux-user/main.c
+   on why exclusive memory ops are done this way.
+
+   Some other arches put AMO handling right into main.c,
+   but for RISC-V there's just too many ops to handle and too much code,
+   so it's all here instead. */
+
+#define BITFIELD(src, end, start) \
+            (((src) >> start) & ((1 << (end - start + 1)) - 1))
+
+#define ENV CPURISCVState *env
+
+/* Load-Reserve: rd = [rs1], creating reservation for [rs1]. */
+
+static int rv_do_lr(ENV, int rd, int rs1, int rs2, int width)
+{
+    int64_t val64;
+    int32_t val32;
+    target_long val;
+    int fault;
+
+    target_long addr = env->gpr[rs1];
+
+    if (rs2) {
+        return RISCV_AMO_BADINSN;
+    }
+
+    switch (width) {
+    case /* 010 */ 2:
+        fault = get_user_s32(val32, addr);
+        val = val32;
+        break;
+    case /* 011 */ 3:
+        fault = get_user_s64(val64, addr);
+        val = val64;
+        break;
+    default:
+        return RISCV_AMO_BADINSN;
+    }
+
+    if (fault) {
+        return RISCV_AMO_BADADDR;
+    }
+
+    if (rd) {
+        env->gpr[rd] = val;
+    }
+
+    env->amoaddr = addr;
+    env->amotest = val;
+
+    return RISCV_AMO_OK;
+}
+
+/* Store-Conditional: [rs1] = rs2, rd = 0 if reservation is intact,
+   otherwise rd = 1. */
+
+static int rv_do_sc(ENV, int rd, int rs1, int rs2, int width)
+{
+    int64_t val64;
+    int32_t val32;
+    target_long val;
+    int fault;
+
+    target_long addr = env->gpr[rs1];
+    target_long resaddr = env->amoaddr;
+    target_long restest = env->amotest;
+
+    if (addr != resaddr) {
+        goto fail; /* no reservation for this address */
+    }
+
+    /* Load and test */
+    switch (width) {
+    case /* 010 */ 2:
+        fault = get_user_s32(val32, addr);
+        val = val32;
+        break;
+    case /* 011 */ 3:
+        fault = get_user_s64(val64, addr);
+        val = val64;
+        break;
+    default:
+        return RISCV_AMO_BADINSN;
+    }
+
+    if (fault) {
+        return RISCV_AMO_BADADDR;
+    }
+    if (val != restest) {
+        goto fail;
+    }
+
+    /* Store */
+    val = env->gpr[rs2];
+    switch (width) {
+    case /* 010 */ 2:
+        val32 = val;
+        fault = put_user_s32(val32, addr);
+        break;
+    case /* 011 */ 3:
+        val64 = val;
+        fault = put_user_s64(val64, addr);
+        break;
+    default:
+        return RISCV_AMO_BADINSN; /* should not happen */
+    }
+
+    if (fault) {
+        return RISCV_AMO_BADADDR;
+    }
+
+    if (rd) {
+        env->gpr[rd] = 0;
+    }
+    return RISCV_AMO_OK;
+
+fail:
+    if (rd) {
+        env->gpr[rd] = 1;
+    }
+    return RISCV_AMO_OK;
+}
+
+/* Tricky signed-unsigned minmaxes */
+#define DEFMINMAX(type, name, ret) \
+    static inline type name(type a, type b) { return ret; }
+DEFMINMAX(target_long, rv_min, a < b ? a : b);
+DEFMINMAX(target_long, rv_max, a > b ? a : b);
+DEFMINMAX(target_ulong, rv_minu, a < b ? a : b);
+DEFMINMAX(target_ulong, rv_maxu, a > b ? a : b);
+
+/* Atomic memory ops: [rs1] = rd = [rs1] op rs2;
+   amoswap, amoadd, amoxor, amoor, amomin, amomax, amominu, amomaxu. */
+
+static int rv_do_amo(ENV, int func, int rd, int rs1, int rs2, int width)
+{
+    int64_t val64;
+    int32_t val32;
+    int fault = 0;
+    target_long addr = env->gpr[rs1];
+    target_long arg = env->gpr[rs2];
+
+    target_long val;    /* read/written */
+
+    /* Load, but do not report BADADDR yet */
+    switch (width) {
+    case /* 010 */ 2:
+        fault = get_user_s32(val32, addr);
+        val = val32;
+        break;
+    case /* 011 */ 3:
+        fault = get_user_s64(val64, addr);
+        val = val64;
+        break;
+    default:
+        return RISCV_AMO_BADINSN;
+    }
+
+    target_long vrd = val;
+
+    switch (func) {
+    case /* 00001 */ 0x01:
+        val = arg;
+        break;
+    case /* 00000 */ 0x00:
+        val += arg;
+        break;
+    case /* 00100 */ 0x04:
+        val ^= arg;
+        break;
+    case /* 01100 */ 0x0C:
+        val &= arg;
+        break;
+    case /* 01000 */ 0x08:
+        val |= arg;
+        break;
+    case /* 10000 */ 0x10:
+        val = rv_min(val, arg);
+        break;
+    case /* 10100 */ 0x14:
+        val = rv_max(val, arg);
+        break;
+    case /* 11000 */ 0x18:
+        val = rv_minu(val, arg);
+        break;
+    case /* 11100 */ 0x1C:
+        val = rv_maxu(val, arg);
+        break;
+    default:
+        return RISCV_AMO_BADINSN;
+    }
+
+    /* No BADINSN during decoding, ok to report BADADDR */
+    if (fault) {
+        return RISCV_AMO_BADADDR;
+    }
+    /* No BADINSN on decoding and no BADADDR on read, ok to write rd */
+    if (rd) {
+        env->gpr[rd] = vrd;
+    }
+
+    switch (width) {
+    case /* 010 */ 2:
+        val32 = val;
+        fault = put_user_s32(val32, addr);
+        break;
+    case /* 011 */ 3:
+        val64 = val;
+        fault = put_user_s64(val64, addr);
+        break;
+    default:
+        return RISCV_AMO_BADINSN; /* should not happen */
+    }
+
+    if (fault) {
+        return RISCV_AMO_BADADDR;
+    }
+
+    return RISCV_AMO_OK;
+}
+
+int riscv_cpu_do_usermode_amo(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    uint64_t insn = env->amoinsn;
+    /* Major opcode must always be 0101111 AMO here */
+    if (BITFIELD(insn, 6, 0) != /* 0101111 */ 0x2F) {
+        return RISCV_AMO_BADINSN;
+    }
+    env->amoinsn = 0; /* clear amo request, just in case */
+
+    int func = BITFIELD(insn, 31, 27);
+    int rd = BITFIELD(insn, 11, 7);
+    int width = BITFIELD(insn, 14, 12);
+    int rs1 = BITFIELD(insn, 19, 15);
+    int rs2 = BITFIELD(insn, 24, 20);
+
+    int ret;
+
+    switch (func) {
+    case /* 00010 */ 2:
+        ret = rv_do_lr(env, rd, rs1, rs2, width);
+        break;
+    case /* 00011 */ 3:
+        ret = rv_do_sc(env, rd, rs1, rs2, width);
+        break;
+    default:
+        ret = rv_do_amo(env, func, rd, rs1, rs2, width);
+        break;
+    }
+
+    if (ret == RISCV_AMO_BADADDR) {
+        env->badaddr = rs1;
+    }
+
+    return ret;
+}
+
+#endif
-- 
2.7.0
