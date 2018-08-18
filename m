Received: from eggs.gnu.org ([2001:4830:134:3::10]:55355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Tw-0005U9-Bp
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Tr-0007K2-Ja
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:52 -0400
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:33382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6Tr-0007Ji-7Q
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:47 -0400
Received: by mail-pl0-x229.google.com with SMTP id b90-v6so5180594plb.0
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:18 -0700
Message-Id: <20180818190118.12911-17-richard.henderson@linaro.org>
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
References: <20180818190118.12911-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 16/16] linux-user: Split out some process
 syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

This includes clone, getgroups, gettid, setfsgid, setfsuid,
setgroups, setsid, setuid, fork, getegid, getegid32, geteuid,
geteuid32, getgid, getgid32, getgroups32, getpgrp, getpid,
getppid, getresgid, getresgid32, getresuid, getresuid32,
getuid, getuid32, getxgid, getxpid, getxuid, setfsgid32,
setgsuid32, setgid32, setgroups32, setregid, setregid32,
setresgid, setresgid32, setresuid, setresuid32, setreuid,
setreuid32, setuid32, vfork.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.h          |  38 ++
 linux-user/strace.c           |  36 +-
 linux-user/syscall-proc.inc.c | 909 ++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 861 +++++---------------------------
 linux-user/strace.list        | 144 ------
 5 files changed, 1070 insertions(+), 918 deletions(-)
 create mode 100644 linux-user/syscall-proc.inc.c

diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 117f025d20..71c5c0cba0 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -55,6 +55,7 @@ typedef enum {
     /* These print as sets of flags.  */
     ARG_ATDIRFD,
     ARG_ATFLAG,
+    ARG_CLONEFLAG,
     ARG_MMAPFLAG,
     ARG_MMAPPROT,
     ARG_MODEFLAG,
@@ -160,3 +161,40 @@ static inline uint64_t target_offset64(abi_ulong word0, abi_ulong word1)
     return word0;
 #endif
 }
+
+#ifdef USE_UID16
+static inline int high2lowuid(int uid)
+{
+    return MAX(uid, 65534);
+}
+
+static inline int high2lowgid(int gid)
+{
+    return MAX(gid, 65534);
+}
+
+static inline int low2highuid(int uid)
+{
+    return (int16_t)uid == -1 ? -1 : uid;
+}
+
+static inline int low2highgid(int gid)
+{
+    return (int16_t)gid == -1 ? -1 : gid;
+}
+
+static inline int tswapid(int id)
+{
+    return tswap16(id);
+}
+
+#define put_user_id(x, gaddr) put_user_u16(x, gaddr)
+#else
+static inline int high2lowuid(int uid) { return uid; }
+static inline int high2lowgid(int gid) { return gid; }
+static inline int low2highuid(int uid) { return uid; }
+static inline int low2highgid(int gid) { return gid; }
+static inline int tswapid(int id) { return tswap32(id); }
+
+#define put_user_id(x, gaddr) put_user_u32(x, gaddr)
+#endif /* USE_UID16 */
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 0d7195b3f7..d752b21bbb 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -836,7 +836,7 @@ static struct flags const mmap_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags clone_flags[] = {
+static struct flags const clone_flags[] = {
     FLAG_GENERIC(CLONE_VM),
     FLAG_GENERIC(CLONE_FS),
     FLAG_GENERIC(CLONE_FILES),
@@ -1218,37 +1218,6 @@ print_clock_adjtime(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_clone
-static void do_print_clone(unsigned int flags, abi_ulong newsp,
-                           abi_ulong parent_tidptr, target_ulong newtls,
-                           abi_ulong child_tidptr)
-{
-    print_flags(clone_flags, flags, 0);
-    print_raw_param("child_stack=0x" TARGET_ABI_FMT_lx, newsp, 0);
-    print_raw_param("parent_tidptr=0x" TARGET_ABI_FMT_lx, parent_tidptr, 0);
-    print_raw_param("tls=0x" TARGET_ABI_FMT_lx, newtls, 0);
-    print_raw_param("child_tidptr=0x" TARGET_ABI_FMT_lx, child_tidptr, 1);
-}
-
-static void
-print_clone(const struct syscallname *name,
-    abi_long arg1, abi_long arg2, abi_long arg3,
-    abi_long arg4, abi_long arg5, abi_long arg6)
-{
-    print_syscall_prologue(name);
-#if defined(TARGET_MICROBLAZE)
-    do_print_clone(arg1, arg2, arg4, arg6, arg5);
-#elif defined(TARGET_CLONE_BACKWARDS)
-    do_print_clone(arg1, arg2, arg3, arg4, arg5);
-#elif defined(TARGET_CLONE_BACKWARDS2)
-    do_print_clone(arg2, arg1, arg3, arg5, arg4);
-#else
-    do_print_clone(arg1, arg2, arg3, arg5, arg4);
-#endif
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_creat
 static void
 print_creat(const struct syscallname *name,
@@ -2551,6 +2520,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_ATFLAG:
             len = add_flags(b, rest, at_file_flags, arg, false);
             break;
+        case ARG_CLONEFLAG:
+            len = add_flags(b, rest, clone_flags, arg, false);
+            break;
         case ARG_MMAPFLAG:
             len = add_flags(b, rest, mmap_flags, arg, false);
             break;
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
new file mode 100644
index 0000000000..cdca552e0a
--- /dev/null
+++ b/linux-user/syscall-proc.inc.c
@@ -0,0 +1,909 @@
+/*
+ *  Linux process related syscalls
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+
+/*
+ * We must do direct syscalls for setting UID/GID, because we want to
+ * implement the Linux system call semantics of "change only for this thread",
+ * not the libc/POSIX semantics of "change for all threads in process".
+ * (See http://ewontfix.com/17/ for more details.)
+ * We use the 32-bit version of the syscalls if present; if it is not
+ * then either the host architecture supports 32-bit UIDs natively with
+ * the standard syscall, or the 16-bit UID is the best we can do.
+ */
+#ifdef __NR_setuid32
+#define __NR_sys_setuid __NR_setuid32
+#else
+#define __NR_sys_setuid __NR_setuid
+#endif
+#ifdef __NR_setgid32
+#define __NR_sys_setgid __NR_setgid32
+#else
+#define __NR_sys_setgid __NR_setgid
+#endif
+#ifdef __NR_setresuid32
+#define __NR_sys_setresuid __NR_setresuid32
+#else
+#define __NR_sys_setresuid __NR_setresuid
+#endif
+#ifdef __NR_setresgid32
+#define __NR_sys_setresgid __NR_setresgid32
+#else
+#define __NR_sys_setresgid __NR_setresgid
+#endif
+
+_syscall1(int, sys_setuid, uid_t, uid)
+_syscall1(int, sys_setgid, gid_t, gid)
+_syscall3(int, sys_setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
+_syscall3(int, sys_setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
+
+#ifndef __NR_gettid
+#define __NR_gettid  -1
+#endif
+_syscall0(int, gettid)
+
+#ifndef __NR_set_tid_address
+#define __NR_set_tid_address  -1
+#endif
+_syscall1(int, set_tid_address, int *, tidptr)
+
+
+/*
+ * CLONE_VFORK is special cased early in do_fork(). The other flag bits
+ * have almost all been allocated. We cannot support any of
+ * CLONE_NEWNS, CLONE_NEWCGROUP, CLONE_NEWUTS, CLONE_NEWIPC,
+ * CLONE_NEWUSER, CLONE_NEWPID, CLONE_NEWNET, CLONE_PTRACE, CLONE_UNTRACED.
+ * The checks against the invalid thread masks above will catch these.
+ * (The one remaining unallocated bit is 0x1000 which used to be CLONE_PID.)
+ */
+
+#ifndef CLONE_IO
+#define CLONE_IO                0x80000000      /* Clone io context */
+#endif
+
+/*
+ * We can't directly call the host clone syscall, because this will
+ * badly confuse libc (breaking mutexes, for example). So we must
+ * divide clone flags into:
+ *  * flag combinations that look like pthread_create()
+ *  * flag combinations that look like fork()
+ *  * flags we can implement within QEMU itself
+ *  * flags we can't support and will return an error for
+ *
+ * For thread creation, all these flags must be present; for
+ * fork, none must be present.
+ */
+#define CLONE_THREAD_FLAGS                              \
+    (CLONE_VM | CLONE_FS | CLONE_FILES |                \
+     CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM)
+
+/*
+ * These flags are ignored:
+ * CLONE_DETACHED is now ignored by the kernel;
+ * CLONE_IO is just an optimisation hint to the I/O scheduler
+ */
+#define CLONE_IGNORED_FLAGS                     \
+    (CLONE_DETACHED | CLONE_IO)
+
+/* Flags for fork which we can implement within QEMU itself */
+#define CLONE_OPTIONAL_FORK_FLAGS               \
+    (CLONE_SETTLS | CLONE_PARENT_SETTID |       \
+     CLONE_CHILD_CLEARTID | CLONE_CHILD_SETTID)
+
+/* Flags for thread creation which we can implement within QEMU itself */
+#define CLONE_OPTIONAL_THREAD_FLAGS                             \
+    (CLONE_SETTLS | CLONE_PARENT_SETTID |                       \
+     CLONE_CHILD_CLEARTID | CLONE_CHILD_SETTID | CLONE_PARENT)
+
+#define CLONE_INVALID_FORK_FLAGS                                        \
+    (~(CSIGNAL | CLONE_OPTIONAL_FORK_FLAGS | CLONE_IGNORED_FLAGS))
+
+#define CLONE_INVALID_THREAD_FLAGS                                      \
+    (~(CSIGNAL | CLONE_THREAD_FLAGS | CLONE_OPTIONAL_THREAD_FLAGS |     \
+       CLONE_IGNORED_FLAGS))
+
+#define NEW_STACK_SIZE 0x40000
+
+static pthread_mutex_t clone_lock = PTHREAD_MUTEX_INITIALIZER;
+typedef struct {
+    CPUArchState *env;
+    pthread_mutex_t mutex;
+    pthread_cond_t cond;
+    pthread_t thread;
+    uint32_t tid;
+    abi_ulong child_tidptr;
+    abi_ulong parent_tidptr;
+    sigset_t sigmask;
+} new_thread_info;
+
+static void *clone_func(void *arg)
+{
+    new_thread_info *info = arg;
+    CPUArchState *env = info->env;
+    CPUState *cpu = ENV_GET_CPU(env);
+    TaskState *ts = (TaskState *)cpu->opaque;
+
+    rcu_register_thread();
+    tcg_register_thread();
+    thread_cpu = cpu;
+    info->tid = gettid();
+    task_settid(ts);
+    if (info->child_tidptr) {
+        put_user_u32(info->tid, info->child_tidptr);
+    }
+    if (info->parent_tidptr) {
+        put_user_u32(info->tid, info->parent_tidptr);
+    }
+    /* Enable signals.  */
+    sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
+    /* Signal to the parent that we're ready.  */
+    pthread_mutex_lock(&info->mutex);
+    pthread_cond_broadcast(&info->cond);
+    pthread_mutex_unlock(&info->mutex);
+    /* Wait until the parent has finished initializing the tls state.  */
+    pthread_mutex_lock(&clone_lock);
+    pthread_mutex_unlock(&clone_lock);
+    cpu_loop(env);
+    /* never exits */
+    return NULL;
+}
+
+static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
+                   abi_ulong parent_tidptr, abi_ulong child_tidptr,
+                   target_ulong newtls)
+{
+    CPUState *cpu = ENV_GET_CPU(env);
+    int ret;
+    TaskState *ts;
+    CPUState *new_cpu;
+    CPUArchState *new_env;
+    sigset_t sigmask;
+
+    flags &= ~CLONE_IGNORED_FLAGS;
+
+    /* Emulate vfork() with fork() */
+    if (flags & CLONE_VFORK) {
+        flags &= ~(CLONE_VFORK | CLONE_VM);
+    }
+
+    if (flags & CLONE_VM) {
+        TaskState *parent_ts = (TaskState *)cpu->opaque;
+        new_thread_info info;
+        pthread_attr_t attr;
+
+        if (((flags & CLONE_THREAD_FLAGS) != CLONE_THREAD_FLAGS) ||
+            (flags & CLONE_INVALID_THREAD_FLAGS)) {
+            return -TARGET_EINVAL;
+        }
+
+        ts = g_new0(TaskState, 1);
+        init_task_state(ts);
+
+        /* Grab a mutex so that thread setup appears atomic.  */
+        pthread_mutex_lock(&clone_lock);
+
+        /* we create a new CPU instance. */
+        new_env = cpu_copy(env);
+        /* Init regs that differ from the parent.  */
+        cpu_clone_regs(new_env, newsp);
+        new_cpu = ENV_GET_CPU(new_env);
+        new_cpu->opaque = ts;
+        ts->bprm = parent_ts->bprm;
+        ts->info = parent_ts->info;
+        ts->signal_mask = parent_ts->signal_mask;
+
+        if (flags & CLONE_CHILD_CLEARTID) {
+            ts->child_tidptr = child_tidptr;
+        }
+
+        if (flags & CLONE_SETTLS) {
+            cpu_set_tls(new_env, newtls);
+        }
+
+        memset(&info, 0, sizeof(info));
+        pthread_mutex_init(&info.mutex, NULL);
+        pthread_mutex_lock(&info.mutex);
+        pthread_cond_init(&info.cond, NULL);
+        info.env = new_env;
+        if (flags & CLONE_CHILD_SETTID) {
+            info.child_tidptr = child_tidptr;
+        }
+        if (flags & CLONE_PARENT_SETTID) {
+            info.parent_tidptr = parent_tidptr;
+        }
+
+        ret = pthread_attr_init(&attr);
+        ret = pthread_attr_setstacksize(&attr, NEW_STACK_SIZE);
+        ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+        /* It is not safe to deliver signals until the child has finished
+           initializing, so temporarily block all signals.  */
+        sigfillset(&sigmask);
+        sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
+
+        /* If this is our first additional thread, we need to ensure we
+         * generate code for parallel execution and flush old translations.
+         */
+        if (!parallel_cpus) {
+            parallel_cpus = true;
+            tb_flush(cpu);
+        }
+
+        ret = pthread_create(&info.thread, &attr, clone_func, &info);
+
+        /* TODO: Free new CPU state if thread creation failed.  */
+
+        sigprocmask(SIG_SETMASK, &info.sigmask, NULL);
+        pthread_attr_destroy(&attr);
+        if (ret == 0) {
+            /* Wait for the child to initialize.  */
+            pthread_cond_wait(&info.cond, &info.mutex);
+            ret = info.tid;
+        } else {
+            ret = -host_to_target_errno(ret);
+        }
+        pthread_mutex_unlock(&info.mutex);
+        pthread_cond_destroy(&info.cond);
+        pthread_mutex_destroy(&info.mutex);
+        pthread_mutex_unlock(&clone_lock);
+    } else {
+        /* if no CLONE_VM, we consider it is a fork */
+        if (flags & CLONE_INVALID_FORK_FLAGS) {
+            return -TARGET_EINVAL;
+        }
+
+        /* We can't support custom termination signals */
+        if ((flags & CSIGNAL) != TARGET_SIGCHLD) {
+            return -TARGET_EINVAL;
+        }
+
+        if (block_signals()) {
+            return -TARGET_ERESTARTSYS;
+        }
+
+        fork_start();
+        ret = fork();
+        if (ret < 0) {
+            return get_errno(-1);
+        }
+        if (ret == 0) {
+            /* Child Process.  */
+            cpu_clone_regs(env, newsp);
+            fork_end(1);
+            /* There is a race condition here.  The parent process could
+               theoretically read the TID in the child process before the child
+               tid is set.  This would require using either ptrace
+               (not implemented) or having *_tidptr to point at a shared memory
+               mapping.  We can't repeat the spinlock hack used above because
+               the child process gets its own copy of the lock.  */
+            if (flags & CLONE_CHILD_SETTID) {
+                put_user_u32(gettid(), child_tidptr);
+            }
+            if (flags & CLONE_PARENT_SETTID) {
+                put_user_u32(gettid(), parent_tidptr);
+            }
+            ts = (TaskState *)cpu->opaque;
+            if (flags & CLONE_SETTLS) {
+                cpu_set_tls(env, newtls);
+            }
+            if (flags & CLONE_CHILD_CLEARTID) {
+                ts->child_tidptr = child_tidptr;
+            }
+        } else {
+            fork_end(0);
+        }
+    }
+    return ret;
+}
+
+SYSCALL_ARGS(clone)
+{
+    abi_ulong fl, sp, ptid, ctid, tls;
+
+    /* Linux manages to have three different orderings for its
+     * arguments to clone(); the BACKWARDS and BACKWARDS2 defines
+     * match the kernel's CONFIG_CLONE_* settings.
+     * Microblaze is further special in that it uses a sixth
+     * implicit argument to clone for the TLS pointer.
+     */
+#if defined(TARGET_MICROBLAZE)
+    fl = in[0], sp = in[1], ptid = in[3], ctid = in[4], tls = in[5];
+#elif defined(TARGET_CLONE_BACKWARDS)
+    fl = in[0], sp = in[1], ptid = in[2], tls = in[3], ctid = in[4];
+#elif defined(TARGET_CLONE_BACKWARDS2)
+    sp = in[0], fl = in[1], ptid = in[2], ctid = in[3], tls = in[4];
+#else
+    fl = in[0], sp = in[1], ptid = in[2], ctid = in[3], tls = in[4];
+#endif
+    out[0] = fl, out[1] = sp, out[2] = ptid, out[3] = ctid, out[4] = tls;
+    return def;
+}
+
+SYSCALL_IMPL(clone)
+{
+    /* We've done all of the odd ABI adjustment above.  */
+    return do_fork(cpu_env, arg1, arg2, arg3, arg4, arg5);
+}
+SYSCALL_DEF_ARGS(clone, ARG_CLONEFLAG, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR);
+
+#ifdef TARGET_NR_fork
+SYSCALL_IMPL(fork)
+{
+    return do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0);
+}
+SYSCALL_DEF(fork);
+#endif
+
+#ifdef TARGET_NR_vfork
+SYSCALL_IMPL(vfork)
+{
+    return do_fork(cpu_env, CLONE_VFORK | CLONE_VM | TARGET_SIGCHLD,
+                   0, 0, 0, 0);
+}
+SYSCALL_DEF(vfork);
+#endif
+
+#ifdef TARGET_NR_getegid
+SYSCALL_IMPL(getegid)
+{
+    return get_errno(high2lowgid(getegid()));
+}
+SYSCALL_DEF(getegid);
+#endif
+
+#ifdef TARGET_NR_getegid32
+SYSCALL_IMPL(getegid32)
+{
+    return get_errno(getegid());
+}
+SYSCALL_DEF(getegid32);
+#endif
+
+#ifdef TARGET_NR_geteuid
+SYSCALL_IMPL(geteuid)
+{
+    return get_errno(high2lowuid(geteuid()));
+}
+SYSCALL_DEF(geteuid);
+#endif
+
+#ifdef TARGET_NR_geteuid32
+SYSCALL_IMPL(geteuid32)
+{
+    return get_errno(geteuid());
+}
+SYSCALL_DEF(geteuid32);
+#endif
+
+#ifdef TARGET_NR_getgid
+SYSCALL_IMPL(getgid)
+{
+    return get_errno(high2lowgid(getgid()));
+}
+SYSCALL_DEF(getgid);
+#endif
+
+#ifdef TARGET_NR_getgid32
+SYSCALL_IMPL(getgid32)
+{
+    return get_errno(getgid());
+}
+SYSCALL_DEF(getgid32);
+#endif
+
+SYSCALL_IMPL(getgroups)
+{
+    int gidsetsize = arg1;
+    gid_t *grouplist;
+    abi_long ret;
+
+    grouplist = g_try_new(gid_t, gidsetsize);
+    if (!grouplist) {
+        return -TARGET_ENOMEM;
+    }
+    ret = get_errno(getgroups(gidsetsize, grouplist));
+
+    if (!is_error(ret) && gidsetsize != 0) {
+        size_t target_grouplist_size = gidsetsize * sizeof(target_id);
+        target_id *target_grouplist
+            = lock_user(VERIFY_WRITE, arg2, target_grouplist_size, 0);
+        if (target_grouplist) {
+            int i;
+            for (i = 0; i < ret; i++) {
+                target_grouplist[i] = tswapid(high2lowgid(grouplist[i]));
+            }
+            unlock_user(target_grouplist, arg2, target_grouplist_size);
+        } else {
+            ret = -TARGET_EFAULT;
+        }
+    }
+    g_free(grouplist);
+    return ret;
+}
+SYSCALL_DEF(getgroups, ARG_DEC, ARG_PTR);
+
+#ifdef TARGET_NR_getgroups32
+SYSCALL_IMPL(getgroups32)
+{
+    int gidsetsize = arg1;
+    gid_t *grouplist;
+    abi_long ret;
+
+    grouplist = g_try_new(gid_t, gidsetsize);
+    if (!grouplist) {
+        return -TARGET_ENOMEM;
+    }
+    ret = get_errno(getgroups(gidsetsize, grouplist));
+
+    if (!is_error(ret) && gidsetsize != 0) {
+        uint32_t *target_grouplist
+            = lock_user(VERIFY_WRITE, arg2, gidsetsize * 4, 0);
+        if (target_grouplist) {
+            int i;
+            for (i = 0; i < ret; i++) {
+                target_grouplist[i] = tswap32(grouplist[i]);
+            }
+            unlock_user(target_grouplist, arg2, gidsetsize * 4);
+        } else {
+            ret = -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+SYSCALL_DEF(getgroups32, ARG_DEC, ARG_PTR);
+#endif
+
+#ifdef TARGET_NR_getresgid
+SYSCALL_IMPL(getresgid)
+{
+    gid_t rgid, egid, sgid;
+    abi_long ret = get_errno(getresgid(&rgid, &egid, &sgid));
+
+    if (!is_error(ret) &&
+        (put_user_id(high2lowgid(rgid), arg1) ||
+         put_user_id(high2lowgid(egid), arg2) ||
+         put_user_id(high2lowgid(sgid), arg3))) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+SYSCALL_DEF(getresgid, ARG_PTR, ARG_PTR, ARG_PTR);
+#endif
+
+#ifdef TARGET_NR_getresgid32
+SYSCALL_IMPL(getresgid32)
+{
+    gid_t rgid, egid, sgid;
+    abi_long ret = get_errno(getresgid(&rgid, &egid, &sgid));
+
+    if (!is_error(ret) &&
+        (put_user_u32(rgid, arg1) ||
+         put_user_u32(egid, arg2) ||
+         put_user_u32(sgid, arg3))) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+SYSCALL_DEF(getresgid32, ARG_PTR, ARG_PTR, ARG_PTR);
+#endif
+
+#ifdef TARGET_NR_getresuid
+SYSCALL_IMPL(getresuid)
+{
+    uid_t ruid, euid, suid;
+    abi_long ret = get_errno(getresuid(&ruid, &euid, &suid));
+
+    if (!is_error(ret) &&
+        (put_user_id(high2lowuid(ruid), arg1) ||
+         put_user_id(high2lowuid(euid), arg2) ||
+         put_user_id(high2lowuid(suid), arg3))) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+SYSCALL_DEF(getresuid, ARG_PTR, ARG_PTR, ARG_PTR);
+#endif
+
+#ifdef TARGET_NR_getresuid32
+SYSCALL_IMPL(getresuid32)
+{
+    uid_t ruid, euid, suid;
+    abi_long ret = get_errno(getresuid(&ruid, &euid, &suid));
+
+    if (!is_error(ret) &&
+        (put_user_u32(ruid, arg1) ||
+         put_user_u32(euid, arg2) ||
+         put_user_u32(suid, arg3))) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+SYSCALL_DEF(getresuid32, ARG_PTR, ARG_PTR, ARG_PTR);
+#endif
+
+#ifdef TARGET_NR_getpgrp
+SYSCALL_IMPL(getpgrp)
+{
+    return get_errno(getpgrp());
+}
+SYSCALL_DEF(getpgrp);
+#endif
+
+#ifdef TARGET_NR_getpid
+SYSCALL_IMPL(getpid)
+{
+    return get_errno(getpid());
+}
+SYSCALL_DEF(getpid);
+#endif
+
+#ifdef TARGET_NR_getppid
+SYSCALL_IMPL(getppid)
+{
+    return get_errno(getppid());
+}
+SYSCALL_DEF(getppid);
+#endif
+
+SYSCALL_IMPL(gettid)
+{
+    return get_errno(gettid());
+}
+SYSCALL_DEF(gettid);
+
+#ifdef TARGET_NR_getuid
+SYSCALL_IMPL(getuid)
+{
+    return get_errno(high2lowuid(getuid()));
+}
+SYSCALL_DEF(getuid);
+#endif
+
+#ifdef TARGET_NR_getuid32
+SYSCALL_IMPL(getuid32)
+{
+    return get_errno(getuid());
+}
+SYSCALL_DEF(getuid32);
+#endif
+
+#ifdef TARGET_NR_getxgid
+SYSCALL_IMPL(getxgid)
+{
+    /* Alpha specific */
+    cpu_env->ir[IR_A4] = getegid();
+    return get_errno(getgid());
+}
+SYSCALL_DEF(getxgid);
+#endif
+
+#ifdef TARGET_NR_getxpid
+SYSCALL_IMPL(getxpid)
+{
+    /* Alpha specific */
+    cpu_env->ir[IR_A4] = getppid();
+    return get_errno(getpid());
+}
+SYSCALL_DEF(getxpid);
+#endif
+
+#ifdef TARGET_NR_getxuid
+SYSCALL_IMPL(getxuid)
+{
+    /* Alpha specific */
+    cpu_env->ir[IR_A4] = geteuid();
+    return get_errno(getuid());
+}
+SYSCALL_DEF(getxuid);
+#endif
+
+SYSCALL_IMPL(setfsgid)
+{
+    return get_errno(setfsgid(arg1));
+}
+SYSCALL_DEF(setfsgid, ARG_DEC);
+
+#ifdef TARGET_NR_setfsgid32
+SYSCALL_IMPL(setfsgid32)
+{
+    return get_errno(setfsgid(arg1));
+}
+SYSCALL_DEF(setfsgid32, ARG_DEC);
+#endif
+
+SYSCALL_IMPL(setfsuid)
+{
+    return get_errno(setfsuid(arg1));
+}
+SYSCALL_DEF(setfsuid, ARG_DEC);
+
+#ifdef TARGET_NR_setfsuid32
+SYSCALL_IMPL(setfsuid32)
+{
+    return get_errno(setfsuid(arg1));
+}
+SYSCALL_DEF(setfsuid32, ARG_DEC);
+#endif
+
+SYSCALL_IMPL(setgid)
+{
+    return get_errno(sys_setgid(low2highgid(arg1)));
+}
+SYSCALL_DEF(setgid, ARG_DEC);
+
+#ifdef TARGET_NR_setgid32
+SYSCALL_IMPL(setgid32)
+{
+    return get_errno(sys_setgid(arg1));
+}
+SYSCALL_DEF(setgid32, ARG_DEC);
+#endif
+
+SYSCALL_IMPL(setgroups)
+{
+    int gidsetsize = arg1;
+    gid_t *grouplist = NULL;
+    abi_long ret;
+
+    if (gidsetsize != 0) {
+        size_t target_grouplist_size = gidsetsize * sizeof(target_id);
+        target_id *target_grouplist
+            = lock_user(VERIFY_READ, arg2, target_grouplist_size, 1);
+        int i;
+
+        if (!target_grouplist) {
+            return -TARGET_EFAULT;
+        }
+        grouplist = g_try_new(gid_t, gidsetsize);
+        if (!grouplist) {
+            unlock_user(target_grouplist, arg2, 0);
+            return -TARGET_ENOMEM;
+        }
+
+        for (i = 0; i < gidsetsize; i++) {
+            grouplist[i] = low2highgid(tswapid(target_grouplist[i]));
+        }
+        unlock_user(target_grouplist, arg2, 0);
+    }
+    ret = get_errno(setgroups(gidsetsize, grouplist));
+    g_free(grouplist);
+    return ret;
+}
+SYSCALL_DEF(setgroups, ARG_DEC, ARG_PTR);
+
+#ifdef TARGET_NR_setgroups32
+SYSCALL_IMPL(setgroups32)
+{
+    int gidsetsize = arg1;
+    gid_t *grouplist = NULL;
+    abi_long ret;
+
+    if (gidsetsize != 0) {
+        uint32_t *target_grouplist
+            = lock_user(VERIFY_READ, arg2, gidsetsize * 4, 1);
+        int i;
+
+        if (!target_grouplist) {
+            return -TARGET_EFAULT;
+        }
+        grouplist = g_try_new(gid_t, gidsetsize);
+        if (!grouplist) {
+            unlock_user(target_grouplist, arg2, 0);
+            return -TARGET_ENOMEM;
+        }
+
+        for (i = 0; i < gidsetsize; i++) {
+            grouplist[i] = tswap32(target_grouplist[i]);
+        }
+        unlock_user(target_grouplist, arg2, 0);
+    }
+    ret = get_errno(setgroups(gidsetsize, grouplist));
+    g_free(grouplist);
+    return ret;
+}
+SYSCALL_DEF(setgroups32, ARG_DEC, ARG_PTR);
+#endif
+
+SYSCALL_IMPL(setregid)
+{
+    return get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
+}
+SYSCALL_DEF(setregid, ARG_DEC, ARG_DEC);
+
+#ifdef TARGET_NR_setregid32
+SYSCALL_IMPL(setregid32)
+{
+    return get_errno(setregid(arg1, arg2));
+}
+SYSCALL_DEF(setregid32, ARG_DEC, ARG_DEC);
+#endif
+
+#ifdef TARGET_NR_setresgid
+SYSCALL_IMPL(setresgid)
+{
+    return get_errno(sys_setresgid(low2highgid(arg1),
+                                   low2highgid(arg2),
+                                   low2highgid(arg3)));
+}
+SYSCALL_DEF(setresgid, ARG_DEC, ARG_DEC, ARG_DEC);
+#endif
+
+#ifdef TARGET_NR_setresgid32
+SYSCALL_IMPL(setresgid32)
+{
+    return get_errno(sys_setresgid(arg1, arg2, arg3));
+}
+SYSCALL_DEF(setresgid32, ARG_DEC, ARG_DEC, ARG_DEC);
+#endif
+
+#ifdef TARGET_NR_setresuid
+SYSCALL_IMPL(setresuid)
+{
+    return get_errno(sys_setresuid(low2highuid(arg1),
+                                   low2highuid(arg2),
+                                   low2highuid(arg3)));
+}
+SYSCALL_DEF(setresuid, ARG_DEC, ARG_DEC, ARG_DEC);
+#endif
+
+#ifdef TARGET_NR_setresuid32
+SYSCALL_IMPL(setresuid32)
+{
+    return get_errno(sys_setresuid(arg1, arg2, arg3));
+}
+SYSCALL_DEF(setresuid32, ARG_DEC, ARG_DEC, ARG_DEC);
+#endif
+
+SYSCALL_IMPL(setreuid)
+{
+    return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
+}
+SYSCALL_DEF(setreuid, ARG_DEC, ARG_DEC);
+
+#ifdef TARGET_NR_setreuid32
+SYSCALL_IMPL(setreuid32)
+{
+    return get_errno(setreuid(arg1, arg2));
+}
+SYSCALL_DEF(setreuid32, ARG_DEC, ARG_DEC);
+#endif
+
+SYSCALL_IMPL(setsid)
+{
+    return get_errno(setsid());
+}
+SYSCALL_DEF(setsid);
+
+SYSCALL_IMPL(setuid)
+{
+    return get_errno(sys_setuid(low2highuid(arg1)));
+}
+SYSCALL_DEF(setuid, ARG_DEC);
+
+#ifdef TARGET_NR_setuid32
+SYSCALL_IMPL(setuid32)
+{
+    return get_errno(sys_setuid(arg1));
+}
+SYSCALL_DEF(setuid32, ARG_DEC);
+#endif
+
+#ifdef TARGET_NR_get_thread_area
+#if defined(TARGET_I386) && defined(TARGET_ABI32)
+static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
+{
+    struct target_modify_ldt_ldt_s *target_ldt_info;
+    uint64_t *gdt_table = g2h(env->gdt.base);
+    uint32_t base_addr, limit, flags;
+    int seg_32bit, contents, read_exec_only, limit_in_pages, idx;
+    int seg_not_present, useable, lm;
+    uint32_t *lp, entry_1, entry_2;
+
+    lock_user_struct(VERIFY_WRITE, target_ldt_info, ptr, 1);
+    if (!target_ldt_info) {
+        return -TARGET_EFAULT;
+    }
+    idx = tswap32(target_ldt_info->entry_number);
+    if (idx < TARGET_GDT_ENTRY_TLS_MIN ||
+        idx > TARGET_GDT_ENTRY_TLS_MAX) {
+        unlock_user_struct(target_ldt_info, ptr, 1);
+        return -TARGET_EINVAL;
+    }
+    lp = (uint32_t *)(gdt_table + idx);
+    entry_1 = tswap32(lp[0]);
+    entry_2 = tswap32(lp[1]);
+
+    read_exec_only = ((entry_2 >> 9) & 1) ^ 1;
+    contents = (entry_2 >> 10) & 3;
+    seg_not_present = ((entry_2 >> 15) & 1) ^ 1;
+    seg_32bit = (entry_2 >> 22) & 1;
+    limit_in_pages = (entry_2 >> 23) & 1;
+    useable = (entry_2 >> 20) & 1;
+#ifdef TARGET_ABI32
+    lm = 0;
+#else
+    lm = (entry_2 >> 21) & 1;
+#endif
+    flags = (seg_32bit << 0) | (contents << 1) |
+        (read_exec_only << 3) | (limit_in_pages << 4) |
+        (seg_not_present << 5) | (useable << 6) | (lm << 7);
+    limit = (entry_1 & 0xffff) | (entry_2  & 0xf0000);
+    base_addr = (entry_1 >> 16) |
+        (entry_2 & 0xff000000) |
+        ((entry_2 & 0xff) << 16);
+    target_ldt_info->base_addr = tswapal(base_addr);
+    target_ldt_info->limit = tswap32(limit);
+    target_ldt_info->flags = tswap32(flags);
+    unlock_user_struct(target_ldt_info, ptr, 1);
+    return 0;
+}
+#endif
+
+SYSCALL_IMPL(get_thread_area)
+{
+#if defined(TARGET_I386) && defined(TARGET_ABI32)
+    return do_get_thread_area(cpu_env, arg1);
+#elif defined(TARGET_M68K)
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    TaskState *ts = cpu->opaque;
+    return ts->tp_value;
+#else
+    return -TARGET_ENOSYS;
+#endif
+}
+
+static const SyscallDef def_get_thread_area = {
+    .name = "get_thread_area",
+    .impl = impl_get_thread_area,
+    .print_ret = print_syscall_ptr_ret,
+#if defined(TARGET_I386) && defined(TARGET_ABI32)
+    .arg_type = { ARG_PTR }
+#endif
+};
+#endif
+
+#ifdef TARGET_NR_set_thread_area
+SYSCALL_IMPL(set_thread_area)
+{
+#if defined(TARGET_MIPS)
+    cpu_env->active_tc.CP0_UserLocal = arg1;
+    return 0;
+#elif defined(TARGET_CRIS)
+    if (arg1 & 0xff) {
+        return -TARGET_EINVAL;
+    }
+    cpu_env->pregs[PR_PID] = arg1;
+    return 0;
+#elif defined(TARGET_I386) && defined(TARGET_ABI32)
+    return do_set_thread_area(cpu_env, arg1);
+#elif defined(TARGET_M68K)
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    TaskState *ts = cpu->opaque;
+    ts->tp_value = arg1;
+    return 0;
+#else
+    return -TARGET_ENOSYS;
+#endif
+}
+SYSCALL_DEF(set_thread_area, ARG_PTR);
+#endif
+
+SYSCALL_IMPL(set_tid_address)
+{
+    return get_errno(set_tid_address((int *)g2h(arg1)));
+}
+SYSCALL_DEF(set_tid_address, ARG_PTR);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f4556124e5..381a79d97f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -113,57 +113,6 @@
 #include "qemu.h"
 #include "syscall.h"
 
-#ifndef CLONE_IO
-#define CLONE_IO                0x80000000      /* Clone io context */
-#endif
-
-/* We can't directly call the host clone syscall, because this will
- * badly confuse libc (breaking mutexes, for example). So we must
- * divide clone flags into:
- *  * flag combinations that look like pthread_create()
- *  * flag combinations that look like fork()
- *  * flags we can implement within QEMU itself
- *  * flags we can't support and will return an error for
- */
-/* For thread creation, all these flags must be present; for
- * fork, none must be present.
- */
-#define CLONE_THREAD_FLAGS                              \
-    (CLONE_VM | CLONE_FS | CLONE_FILES |                \
-     CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM)
-
-/* These flags are ignored:
- * CLONE_DETACHED is now ignored by the kernel;
- * CLONE_IO is just an optimisation hint to the I/O scheduler
- */
-#define CLONE_IGNORED_FLAGS                     \
-    (CLONE_DETACHED | CLONE_IO)
-
-/* Flags for fork which we can implement within QEMU itself */
-#define CLONE_OPTIONAL_FORK_FLAGS               \
-    (CLONE_SETTLS | CLONE_PARENT_SETTID |       \
-     CLONE_CHILD_CLEARTID | CLONE_CHILD_SETTID)
-
-/* Flags for thread creation which we can implement within QEMU itself */
-#define CLONE_OPTIONAL_THREAD_FLAGS                             \
-    (CLONE_SETTLS | CLONE_PARENT_SETTID |                       \
-     CLONE_CHILD_CLEARTID | CLONE_CHILD_SETTID | CLONE_PARENT)
-
-#define CLONE_INVALID_FORK_FLAGS                                        \
-    (~(CSIGNAL | CLONE_OPTIONAL_FORK_FLAGS | CLONE_IGNORED_FLAGS))
-
-#define CLONE_INVALID_THREAD_FLAGS                                      \
-    (~(CSIGNAL | CLONE_THREAD_FLAGS | CLONE_OPTIONAL_THREAD_FLAGS |     \
-       CLONE_IGNORED_FLAGS))
-
-/* CLONE_VFORK is special cased early in do_fork(). The other flag bits
- * have almost all been allocated. We cannot support any of
- * CLONE_NEWNS, CLONE_NEWCGROUP, CLONE_NEWUTS, CLONE_NEWIPC,
- * CLONE_NEWUSER, CLONE_NEWPID, CLONE_NEWNET, CLONE_PTRACE, CLONE_UNTRACED.
- * The checks against the invalid thread masks above will catch these.
- * (The one remaining unallocated bit is 0x1000 which used to be CLONE_PID.)
- */
-
 /* Define DEBUG_ERESTARTSYS to force every syscall to be restarted
  * once. This exercises the codepaths for restart.
  */
@@ -250,16 +199,6 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define TARGET_NR__llseek TARGET_NR_llseek
 #endif
 
-#ifdef __NR_gettid
-_syscall0(int, gettid)
-#else
-/* This is a replacement for the host gettid() and must return a host
-   errno. */
-static int gettid(void) {
-    return -ENOSYS;
-}
-#endif
-
 /* For the 64-bit guest on 32-bit host case we must emulate
  * getdents using getdents64, because otherwise the host
  * might hand us back more dirent records than we can fit
@@ -289,9 +228,6 @@ _syscall3(int,sys_syslog,int,type,char*,bufp,int,len)
 #ifdef __NR_exit_group
 _syscall1(int,exit_group,int,error_code)
 #endif
-#if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
-_syscall1(int,set_tid_address,int *,tidptr)
-#endif
 #if defined(TARGET_NR_futex) && defined(__NR_futex)
 _syscall6(int,sys_futex,int *,uaddr,int,op,int,val,
           const struct timespec *,timeout,int *,uaddr2,int,val3)
@@ -5278,53 +5214,6 @@ install:
     lp[1] = tswap32(entry_2);
     return 0;
 }
-
-static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
-{
-    struct target_modify_ldt_ldt_s *target_ldt_info;
-    uint64_t *gdt_table = g2h(env->gdt.base);
-    uint32_t base_addr, limit, flags;
-    int seg_32bit, contents, read_exec_only, limit_in_pages, idx;
-    int seg_not_present, useable, lm;
-    uint32_t *lp, entry_1, entry_2;
-
-    lock_user_struct(VERIFY_WRITE, target_ldt_info, ptr, 1);
-    if (!target_ldt_info)
-        return -TARGET_EFAULT;
-    idx = tswap32(target_ldt_info->entry_number);
-    if (idx < TARGET_GDT_ENTRY_TLS_MIN ||
-        idx > TARGET_GDT_ENTRY_TLS_MAX) {
-        unlock_user_struct(target_ldt_info, ptr, 1);
-        return -TARGET_EINVAL;
-    }
-    lp = (uint32_t *)(gdt_table + idx);
-    entry_1 = tswap32(lp[0]);
-    entry_2 = tswap32(lp[1]);
-    
-    read_exec_only = ((entry_2 >> 9) & 1) ^ 1;
-    contents = (entry_2 >> 10) & 3;
-    seg_not_present = ((entry_2 >> 15) & 1) ^ 1;
-    seg_32bit = (entry_2 >> 22) & 1;
-    limit_in_pages = (entry_2 >> 23) & 1;
-    useable = (entry_2 >> 20) & 1;
-#ifdef TARGET_ABI32
-    lm = 0;
-#else
-    lm = (entry_2 >> 21) & 1;
-#endif
-    flags = (seg_32bit << 0) | (contents << 1) |
-        (read_exec_only << 3) | (limit_in_pages << 4) |
-        (seg_not_present << 5) | (useable << 6) | (lm << 7);
-    limit = (entry_1 & 0xffff) | (entry_2  & 0xf0000);
-    base_addr = (entry_1 >> 16) | 
-        (entry_2 & 0xff000000) | 
-        ((entry_2 & 0xff) << 16);
-    target_ldt_info->base_addr = tswapal(base_addr);
-    target_ldt_info->limit = tswap32(limit);
-    target_ldt_info->flags = tswap32(flags);
-    unlock_user_struct(target_ldt_info, ptr, 1);
-    return 0;
-}
 #endif /* TARGET_I386 && TARGET_ABI32 */
 
 #ifndef TARGET_ABI32
@@ -5364,194 +5253,6 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 
 #endif /* defined(TARGET_I386) */
 
-#define NEW_STACK_SIZE 0x40000
-
-
-static pthread_mutex_t clone_lock = PTHREAD_MUTEX_INITIALIZER;
-typedef struct {
-    CPUArchState *env;
-    pthread_mutex_t mutex;
-    pthread_cond_t cond;
-    pthread_t thread;
-    uint32_t tid;
-    abi_ulong child_tidptr;
-    abi_ulong parent_tidptr;
-    sigset_t sigmask;
-} new_thread_info;
-
-static void *clone_func(void *arg)
-{
-    new_thread_info *info = arg;
-    CPUArchState *env;
-    CPUState *cpu;
-    TaskState *ts;
-
-    rcu_register_thread();
-    tcg_register_thread();
-    env = info->env;
-    cpu = ENV_GET_CPU(env);
-    thread_cpu = cpu;
-    ts = (TaskState *)cpu->opaque;
-    info->tid = gettid();
-    task_settid(ts);
-    if (info->child_tidptr)
-        put_user_u32(info->tid, info->child_tidptr);
-    if (info->parent_tidptr)
-        put_user_u32(info->tid, info->parent_tidptr);
-    /* Enable signals.  */
-    sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
-    /* Signal to the parent that we're ready.  */
-    pthread_mutex_lock(&info->mutex);
-    pthread_cond_broadcast(&info->cond);
-    pthread_mutex_unlock(&info->mutex);
-    /* Wait until the parent has finished initializing the tls state.  */
-    pthread_mutex_lock(&clone_lock);
-    pthread_mutex_unlock(&clone_lock);
-    cpu_loop(env);
-    /* never exits */
-    return NULL;
-}
-
-/* do_fork() Must return host values and target errnos (unlike most
-   do_*() functions). */
-static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
-                   abi_ulong parent_tidptr, target_ulong newtls,
-                   abi_ulong child_tidptr)
-{
-    CPUState *cpu = ENV_GET_CPU(env);
-    int ret;
-    TaskState *ts;
-    CPUState *new_cpu;
-    CPUArchState *new_env;
-    sigset_t sigmask;
-
-    flags &= ~CLONE_IGNORED_FLAGS;
-
-    /* Emulate vfork() with fork() */
-    if (flags & CLONE_VFORK)
-        flags &= ~(CLONE_VFORK | CLONE_VM);
-
-    if (flags & CLONE_VM) {
-        TaskState *parent_ts = (TaskState *)cpu->opaque;
-        new_thread_info info;
-        pthread_attr_t attr;
-
-        if (((flags & CLONE_THREAD_FLAGS) != CLONE_THREAD_FLAGS) ||
-            (flags & CLONE_INVALID_THREAD_FLAGS)) {
-            return -TARGET_EINVAL;
-        }
-
-        ts = g_new0(TaskState, 1);
-        init_task_state(ts);
-
-        /* Grab a mutex so that thread setup appears atomic.  */
-        pthread_mutex_lock(&clone_lock);
-
-        /* we create a new CPU instance. */
-        new_env = cpu_copy(env);
-        /* Init regs that differ from the parent.  */
-        cpu_clone_regs(new_env, newsp);
-        new_cpu = ENV_GET_CPU(new_env);
-        new_cpu->opaque = ts;
-        ts->bprm = parent_ts->bprm;
-        ts->info = parent_ts->info;
-        ts->signal_mask = parent_ts->signal_mask;
-
-        if (flags & CLONE_CHILD_CLEARTID) {
-            ts->child_tidptr = child_tidptr;
-        }
-
-        if (flags & CLONE_SETTLS) {
-            cpu_set_tls (new_env, newtls);
-        }
-
-        memset(&info, 0, sizeof(info));
-        pthread_mutex_init(&info.mutex, NULL);
-        pthread_mutex_lock(&info.mutex);
-        pthread_cond_init(&info.cond, NULL);
-        info.env = new_env;
-        if (flags & CLONE_CHILD_SETTID) {
-            info.child_tidptr = child_tidptr;
-        }
-        if (flags & CLONE_PARENT_SETTID) {
-            info.parent_tidptr = parent_tidptr;
-        }
-
-        ret = pthread_attr_init(&attr);
-        ret = pthread_attr_setstacksize(&attr, NEW_STACK_SIZE);
-        ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
-        /* It is not safe to deliver signals until the child has finished
-           initializing, so temporarily block all signals.  */
-        sigfillset(&sigmask);
-        sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
-
-        /* If this is our first additional thread, we need to ensure we
-         * generate code for parallel execution and flush old translations.
-         */
-        if (!parallel_cpus) {
-            parallel_cpus = true;
-            tb_flush(cpu);
-        }
-
-        ret = pthread_create(&info.thread, &attr, clone_func, &info);
-        /* TODO: Free new CPU state if thread creation failed.  */
-
-        sigprocmask(SIG_SETMASK, &info.sigmask, NULL);
-        pthread_attr_destroy(&attr);
-        if (ret == 0) {
-            /* Wait for the child to initialize.  */
-            pthread_cond_wait(&info.cond, &info.mutex);
-            ret = info.tid;
-        } else {
-            ret = -1;
-        }
-        pthread_mutex_unlock(&info.mutex);
-        pthread_cond_destroy(&info.cond);
-        pthread_mutex_destroy(&info.mutex);
-        pthread_mutex_unlock(&clone_lock);
-    } else {
-        /* if no CLONE_VM, we consider it is a fork */
-        if (flags & CLONE_INVALID_FORK_FLAGS) {
-            return -TARGET_EINVAL;
-        }
-
-        /* We can't support custom termination signals */
-        if ((flags & CSIGNAL) != TARGET_SIGCHLD) {
-            return -TARGET_EINVAL;
-        }
-
-        if (block_signals()) {
-            return -TARGET_ERESTARTSYS;
-        }
-
-        fork_start();
-        ret = fork();
-        if (ret == 0) {
-            /* Child Process.  */
-            cpu_clone_regs(env, newsp);
-            fork_end(1);
-            /* There is a race condition here.  The parent process could
-               theoretically read the TID in the child process before the child
-               tid is set.  This would require using either ptrace
-               (not implemented) or having *_tidptr to point at a shared memory
-               mapping.  We can't repeat the spinlock hack used above because
-               the child process gets its own copy of the lock.  */
-            if (flags & CLONE_CHILD_SETTID)
-                put_user_u32(gettid(), child_tidptr);
-            if (flags & CLONE_PARENT_SETTID)
-                put_user_u32(gettid(), parent_tidptr);
-            ts = (TaskState *)cpu->opaque;
-            if (flags & CLONE_SETTLS)
-                cpu_set_tls (env, newtls);
-            if (flags & CLONE_CHILD_CLEARTID)
-                ts->child_tidptr = child_tidptr;
-        } else {
-            fork_end(0);
-        }
-    }
-    return ret;
-}
-
 /* warning : doesn't handle linux specific flags... */
 static int target_to_host_fcntl_cmd(int cmd)
 {
@@ -5921,106 +5622,6 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
     return ret;
 }
 
-#ifdef USE_UID16
-
-static inline int high2lowuid(int uid)
-{
-    if (uid > 65535)
-        return 65534;
-    else
-        return uid;
-}
-
-static inline int high2lowgid(int gid)
-{
-    if (gid > 65535)
-        return 65534;
-    else
-        return gid;
-}
-
-static inline int low2highuid(int uid)
-{
-    if ((int16_t)uid == -1)
-        return -1;
-    else
-        return uid;
-}
-
-static inline int low2highgid(int gid)
-{
-    if ((int16_t)gid == -1)
-        return -1;
-    else
-        return gid;
-}
-static inline int tswapid(int id)
-{
-    return tswap16(id);
-}
-
-#define put_user_id(x, gaddr) put_user_u16(x, gaddr)
-
-#else /* !USE_UID16 */
-static inline int high2lowuid(int uid)
-{
-    return uid;
-}
-static inline int high2lowgid(int gid)
-{
-    return gid;
-}
-static inline int low2highuid(int uid)
-{
-    return uid;
-}
-static inline int low2highgid(int gid)
-{
-    return gid;
-}
-static inline int tswapid(int id)
-{
-    return tswap32(id);
-}
-
-#define put_user_id(x, gaddr) put_user_u32(x, gaddr)
-
-#endif /* USE_UID16 */
-
-/* We must do direct syscalls for setting UID/GID, because we want to
- * implement the Linux system call semantics of "change only for this thread",
- * not the libc/POSIX semantics of "change for all threads in process".
- * (See http://ewontfix.com/17/ for more details.)
- * We use the 32-bit version of the syscalls if present; if it is not
- * then either the host architecture supports 32-bit UIDs natively with
- * the standard syscall, or the 16-bit UID is the best we can do.
- */
-#ifdef __NR_setuid32
-#define __NR_sys_setuid __NR_setuid32
-#else
-#define __NR_sys_setuid __NR_setuid
-#endif
-#ifdef __NR_setgid32
-#define __NR_sys_setgid __NR_setgid32
-#else
-#define __NR_sys_setgid __NR_setgid
-#endif
-#ifdef __NR_setresuid32
-#define __NR_sys_setresuid __NR_setresuid32
-#else
-#define __NR_sys_setresuid __NR_setresuid
-#endif
-#ifdef __NR_setresgid32
-#define __NR_sys_setresgid __NR_setresgid32
-#else
-#define __NR_sys_setresgid __NR_setresgid
-#endif
-
-_syscall1(int, sys_setuid, uid_t, uid)
-_syscall1(int, sys_setgid, gid_t, gid)
-_syscall3(int, sys_setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
-_syscall3(int, sys_setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
-
 void syscall_init(void)
 {
     IOCTLEntry *ie;
@@ -6682,10 +6283,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return 0; /* avoid warning */
     case TARGET_NR_brk:
         return do_brk(arg1);
-#ifdef TARGET_NR_fork
-    case TARGET_NR_fork:
-        return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
-#endif
 #ifdef TARGET_NR_waitpid
     case TARGET_NR_waitpid:
         {
@@ -6911,16 +6508,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_lseek
     case TARGET_NR_lseek:
         return get_errno(lseek(arg1, arg2, arg3));
-#endif
-#if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
-    /* Alpha specific */
-    case TARGET_NR_getxpid:
-        ((CPUAlphaState *)cpu_env)->ir[IR_A4] = getppid();
-        return get_errno(getpid());
-#endif
-#ifdef TARGET_NR_getpid
-    case TARGET_NR_getpid:
-        return get_errno(getpid());
 #endif
     case TARGET_NR_mount:
         {
@@ -7261,16 +6848,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
-#ifdef TARGET_NR_getppid /* not on alpha */
-    case TARGET_NR_getppid:
-        return get_errno(getppid());
-#endif
-#ifdef TARGET_NR_getpgrp
-    case TARGET_NR_getpgrp:
-        return get_errno(getpgrp());
-#endif
-    case TARGET_NR_setsid:
-        return get_errno(setsid());
 #ifdef TARGET_NR_sigaction
     case TARGET_NR_sigaction:
         {
@@ -8361,23 +7938,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_fsync:
         return get_errno(fsync(arg1));
-    case TARGET_NR_clone:
-        /* Linux manages to have three different orderings for its
-         * arguments to clone(); the BACKWARDS and BACKWARDS2 defines
-         * match the kernel's CONFIG_CLONE_* settings.
-         * Microblaze is further special in that it uses a sixth
-         * implicit argument to clone for the TLS pointer.
-         */
-#if defined(TARGET_MICROBLAZE)
-        ret = get_errno(do_fork(cpu_env, arg1, arg2, arg4, arg6, arg5));
-#elif defined(TARGET_CLONE_BACKWARDS)
-        ret = get_errno(do_fork(cpu_env, arg1, arg2, arg3, arg4, arg5));
-#elif defined(TARGET_CLONE_BACKWARDS2)
-        ret = get_errno(do_fork(cpu_env, arg2, arg1, arg3, arg5, arg4));
-#else
-        ret = get_errno(do_fork(cpu_env, arg1, arg2, arg3, arg5, arg4));
-#endif
-        return ret;
 #ifdef __NR_exit_group
         /* new thread calls */
     case TARGET_NR_exit_group:
@@ -9130,12 +8690,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     }
 #endif
 #endif
-#ifdef TARGET_NR_vfork
-    case TARGET_NR_vfork:
-        return get_errno(do_fork(cpu_env,
-                         CLONE_VFORK | CLONE_VM | TARGET_SIGCHLD,
-                         0, 0, 0, 0));
-#endif
 #ifdef TARGET_NR_ugetrlimit
     case TARGET_NR_ugetrlimit:
     {
@@ -9218,66 +8772,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg1, 0);
         return ret;
 #endif
-#ifdef TARGET_NR_getuid
-    case TARGET_NR_getuid:
-        return get_errno(high2lowuid(getuid()));
-#endif
-#ifdef TARGET_NR_getgid
-    case TARGET_NR_getgid:
-        return get_errno(high2lowgid(getgid()));
-#endif
-#ifdef TARGET_NR_geteuid
-    case TARGET_NR_geteuid:
-        return get_errno(high2lowuid(geteuid()));
-#endif
-#ifdef TARGET_NR_getegid
-    case TARGET_NR_getegid:
-        return get_errno(high2lowgid(getegid()));
-#endif
-    case TARGET_NR_setreuid:
-        return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
-    case TARGET_NR_setregid:
-        return get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
-    case TARGET_NR_getgroups:
-        {
-            int gidsetsize = arg1;
-            target_id *target_grouplist;
-            gid_t *grouplist;
-            int i;
-
-            grouplist = alloca(gidsetsize * sizeof(gid_t));
-            ret = get_errno(getgroups(gidsetsize, grouplist));
-            if (gidsetsize == 0)
-                return ret;
-            if (!is_error(ret)) {
-                target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * sizeof(target_id), 0);
-                if (!target_grouplist)
-                    return -TARGET_EFAULT;
-                for(i = 0;i < ret; i++)
-                    target_grouplist[i] = tswapid(high2lowgid(grouplist[i]));
-                unlock_user(target_grouplist, arg2, gidsetsize * sizeof(target_id));
-            }
-        }
-        return ret;
-    case TARGET_NR_setgroups:
-        {
-            int gidsetsize = arg1;
-            target_id *target_grouplist;
-            gid_t *grouplist = NULL;
-            int i;
-            if (gidsetsize) {
-                grouplist = alloca(gidsetsize * sizeof(gid_t));
-                target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * sizeof(target_id), 1);
-                if (!target_grouplist) {
-                    return -TARGET_EFAULT;
-                }
-                for (i = 0; i < gidsetsize; i++) {
-                    grouplist[i] = low2highgid(tswapid(target_grouplist[i]));
-                }
-                unlock_user(target_grouplist, arg2, 0);
-            }
-            return get_errno(setgroups(gidsetsize, grouplist));
-        }
     case TARGET_NR_fchown:
         return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
 #if defined(TARGET_NR_fchownat)
@@ -9289,46 +8783,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg2, 0);
         return ret;
 #endif
-#ifdef TARGET_NR_setresuid
-    case TARGET_NR_setresuid:
-        return get_errno(sys_setresuid(low2highuid(arg1),
-                                       low2highuid(arg2),
-                                       low2highuid(arg3)));
-#endif
-#ifdef TARGET_NR_getresuid
-    case TARGET_NR_getresuid:
-        {
-            uid_t ruid, euid, suid;
-            ret = get_errno(getresuid(&ruid, &euid, &suid));
-            if (!is_error(ret)) {
-                if (put_user_id(high2lowuid(ruid), arg1)
-                    || put_user_id(high2lowuid(euid), arg2)
-                    || put_user_id(high2lowuid(suid), arg3))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_getresgid
-    case TARGET_NR_setresgid:
-        return get_errno(sys_setresgid(low2highgid(arg1),
-                                       low2highgid(arg2),
-                                       low2highgid(arg3)));
-#endif
-#ifdef TARGET_NR_getresgid
-    case TARGET_NR_getresgid:
-        {
-            gid_t rgid, egid, sgid;
-            ret = get_errno(getresgid(&rgid, &egid, &sgid));
-            if (!is_error(ret)) {
-                if (put_user_id(high2lowgid(rgid), arg1)
-                    || put_user_id(high2lowgid(egid), arg2)
-                    || put_user_id(high2lowgid(sgid), arg3))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_chown
     case TARGET_NR_chown:
         if (!(p = lock_user_string(arg1)))
@@ -9337,15 +8791,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg1, 0);
         return ret;
 #endif
-    case TARGET_NR_setuid:
-        return get_errno(sys_setuid(low2highuid(arg1)));
-    case TARGET_NR_setgid:
-        return get_errno(sys_setgid(low2highgid(arg1)));
-    case TARGET_NR_setfsuid:
-        return get_errno(setfsuid(arg1));
-    case TARGET_NR_setfsgid:
-        return get_errno(setfsgid(arg1));
-
 #ifdef TARGET_NR_lchown32
     case TARGET_NR_lchown32:
         if (!(p = lock_user_string(arg1)))
@@ -9354,31 +8799,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg1, 0);
         return ret;
 #endif
-#ifdef TARGET_NR_getuid32
-    case TARGET_NR_getuid32:
-        return get_errno(getuid());
-#endif
-
-#if defined(TARGET_NR_getxuid) && defined(TARGET_ALPHA)
-   /* Alpha specific */
-    case TARGET_NR_getxuid:
-         {
-            uid_t euid;
-            euid=geteuid();
-            ((CPUAlphaState *)cpu_env)->ir[IR_A4]=euid;
-         }
-        return get_errno(getuid());
-#endif
-#if defined(TARGET_NR_getxgid) && defined(TARGET_ALPHA)
-   /* Alpha specific */
-    case TARGET_NR_getxgid:
-         {
-            uid_t egid;
-            egid=getegid();
-            ((CPUAlphaState *)cpu_env)->ir[IR_A4]=egid;
-         }
-        return get_errno(getgid());
-#endif
 #if defined(TARGET_NR_osf_getsysinfo) && defined(TARGET_ALPHA)
     /* Alpha specific */
     case TARGET_NR_osf_getsysinfo:
@@ -9539,110 +8959,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
-
-#ifdef TARGET_NR_getgid32
-    case TARGET_NR_getgid32:
-        return get_errno(getgid());
-#endif
-#ifdef TARGET_NR_geteuid32
-    case TARGET_NR_geteuid32:
-        return get_errno(geteuid());
-#endif
-#ifdef TARGET_NR_getegid32
-    case TARGET_NR_getegid32:
-        return get_errno(getegid());
-#endif
-#ifdef TARGET_NR_setreuid32
-    case TARGET_NR_setreuid32:
-        return get_errno(setreuid(arg1, arg2));
-#endif
-#ifdef TARGET_NR_setregid32
-    case TARGET_NR_setregid32:
-        return get_errno(setregid(arg1, arg2));
-#endif
-#ifdef TARGET_NR_getgroups32
-    case TARGET_NR_getgroups32:
-        {
-            int gidsetsize = arg1;
-            uint32_t *target_grouplist;
-            gid_t *grouplist;
-            int i;
-
-            grouplist = alloca(gidsetsize * sizeof(gid_t));
-            ret = get_errno(getgroups(gidsetsize, grouplist));
-            if (gidsetsize == 0)
-                return ret;
-            if (!is_error(ret)) {
-                target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * 4, 0);
-                if (!target_grouplist) {
-                    return -TARGET_EFAULT;
-                }
-                for(i = 0;i < ret; i++)
-                    target_grouplist[i] = tswap32(grouplist[i]);
-                unlock_user(target_grouplist, arg2, gidsetsize * 4);
-            }
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_setgroups32
-    case TARGET_NR_setgroups32:
-        {
-            int gidsetsize = arg1;
-            uint32_t *target_grouplist;
-            gid_t *grouplist;
-            int i;
-
-            grouplist = alloca(gidsetsize * sizeof(gid_t));
-            target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * 4, 1);
-            if (!target_grouplist) {
-                return -TARGET_EFAULT;
-            }
-            for(i = 0;i < gidsetsize; i++)
-                grouplist[i] = tswap32(target_grouplist[i]);
-            unlock_user(target_grouplist, arg2, 0);
-            return get_errno(setgroups(gidsetsize, grouplist));
-        }
-#endif
 #ifdef TARGET_NR_fchown32
     case TARGET_NR_fchown32:
         return get_errno(fchown(arg1, arg2, arg3));
 #endif
-#ifdef TARGET_NR_setresuid32
-    case TARGET_NR_setresuid32:
-        return get_errno(sys_setresuid(arg1, arg2, arg3));
-#endif
-#ifdef TARGET_NR_getresuid32
-    case TARGET_NR_getresuid32:
-        {
-            uid_t ruid, euid, suid;
-            ret = get_errno(getresuid(&ruid, &euid, &suid));
-            if (!is_error(ret)) {
-                if (put_user_u32(ruid, arg1)
-                    || put_user_u32(euid, arg2)
-                    || put_user_u32(suid, arg3))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_setresgid32
-    case TARGET_NR_setresgid32:
-        return get_errno(sys_setresgid(arg1, arg2, arg3));
-#endif
-#ifdef TARGET_NR_getresgid32
-    case TARGET_NR_getresgid32:
-        {
-            gid_t rgid, egid, sgid;
-            ret = get_errno(getresgid(&rgid, &egid, &sgid));
-            if (!is_error(ret)) {
-                if (put_user_u32(rgid, arg1)
-                    || put_user_u32(egid, arg2)
-                    || put_user_u32(sgid, arg3))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_chown32
     case TARGET_NR_chown32:
         if (!(p = lock_user_string(arg1)))
@@ -9651,22 +8971,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg1, 0);
         return ret;
 #endif
-#ifdef TARGET_NR_setuid32
-    case TARGET_NR_setuid32:
-        return get_errno(sys_setuid(arg1));
-#endif
-#ifdef TARGET_NR_setgid32
-    case TARGET_NR_setgid32:
-        return get_errno(sys_setgid(arg1));
-#endif
-#ifdef TARGET_NR_setfsuid32
-    case TARGET_NR_setfsuid32:
-        return get_errno(setfsuid(arg1));
-#endif
-#ifdef TARGET_NR_setfsgid32
-    case TARGET_NR_setfsgid32:
-        return get_errno(setfsgid(arg1));
-#endif
 #ifdef TARGET_NR_mincore
     case TARGET_NR_mincore:
         {
@@ -9825,8 +9129,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_getpagesize:
         return TARGET_PAGE_SIZE;
 #endif
-    case TARGET_NR_gettid:
-        return get_errno(gettid());
 #ifdef TARGET_NR_readahead
     case TARGET_NR_readahead:
 #if TARGET_ABI_BITS == 32
@@ -10003,44 +9305,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
 #endif
 #endif /* CONFIG_ATTR */
-#ifdef TARGET_NR_set_thread_area
-    case TARGET_NR_set_thread_area:
-#if defined(TARGET_MIPS)
-      ((CPUMIPSState *) cpu_env)->active_tc.CP0_UserLocal = arg1;
-      return 0;
-#elif defined(TARGET_CRIS)
-      if (arg1 & 0xff)
-          ret = -TARGET_EINVAL;
-      else {
-          ((CPUCRISState *) cpu_env)->pregs[PR_PID] = arg1;
-          ret = 0;
-      }
-      return ret;
-#elif defined(TARGET_I386) && defined(TARGET_ABI32)
-      return do_set_thread_area(cpu_env, arg1);
-#elif defined(TARGET_M68K)
-      {
-          TaskState *ts = cpu->opaque;
-          ts->tp_value = arg1;
-          return 0;
-      }
-#else
-      return -TARGET_ENOSYS;
-#endif
-#endif
-#ifdef TARGET_NR_get_thread_area
-    case TARGET_NR_get_thread_area:
-#if defined(TARGET_I386) && defined(TARGET_ABI32)
-        return do_get_thread_area(cpu_env, arg1);
-#elif defined(TARGET_M68K)
-        {
-            TaskState *ts = cpu->opaque;
-            return ts->tp_value;
-        }
-#else
-        return -TARGET_ENOSYS;
-#endif
-#endif
 #ifdef TARGET_NR_getdomainname
     case TARGET_NR_getdomainname:
         return -TARGET_ENOSYS;
@@ -10100,12 +9364,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
-
-#if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
-    case TARGET_NR_set_tid_address:
-        return get_errno(set_tid_address((int *)g2h(arg1)));
-#endif
-
     case TARGET_NR_tkill:
         return get_errno(safe_tkill((int)arg1, target_to_host_signal(arg2)));
 
@@ -10794,6 +10052,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #include "syscall-file.inc.c"
 #include "syscall-ipc.inc.c"
 #include "syscall-mem.inc.c"
+#include "syscall-proc.inc.c"
 
 static const SyscallDef *syscall_table(int num)
 {
@@ -10803,7 +10062,10 @@ static const SyscallDef *syscall_table(int num)
     /*
      * Unconditional syscalls.
      */
+    S(clone);
     S(close);
+    S(getgroups);
+    S(gettid);
     S(mlock);
     S(mlockall);
     S(mprotect);
@@ -10819,12 +10081,82 @@ static const SyscallDef *syscall_table(int num)
     S(pwritev);
     S(read);
     S(readv);
+    S(setfsgid);
+    S(setfsuid);
+    S(setgid);
+    S(setgroups);
+    S(setsid);
+    S(setuid);
+    S(set_tid_address);
     S(write);
     S(writev);
 
     /*
      * Conditional syscalls.
      */
+#ifdef TARGET_NR_fork
+    S(fork);
+#endif
+#ifdef TARGET_NR_getegid
+    S(getegid);
+#endif
+#ifdef TARGET_NR_getegid32
+    S(getegid32);
+#endif
+#ifdef TARGET_NR_geteuid
+    S(geteuid);
+#endif
+#ifdef TARGET_NR_geteuid32
+    S(geteuid32);
+#endif
+#ifdef TARGET_NR_getgid
+    S(getgid);
+#endif
+#ifdef TARGET_NR_getgid32
+    S(getgid32);
+#endif
+#ifdef TARGET_NR_getgroups32
+    S(getgroups32);
+#endif
+#ifdef TARGET_NR_getpgrp
+    S(getpgrp);
+#endif
+#ifdef TARGET_NR_getpid
+    S(getpid);
+#endif
+#ifdef TARGET_NR_getppid
+    S(getppid);
+#endif
+#ifdef TARGET_NR_getresgid
+    S(getresgid);
+#endif
+#ifdef TARGET_NR_getresgid32
+    S(getresgid32);
+#endif
+#ifdef TARGET_NR_getresuid
+    S(getresuid);
+#endif
+#ifdef TARGET_NR_getresuid32
+    S(getresuid32);
+#endif
+#ifdef TARGET_NR_getuid
+    S(getuid);
+#endif
+#ifdef TARGET_NR_getuid32
+    S(getuid32);
+#endif
+#ifdef TARGET_NR_getxgid
+    S(getxgid);
+#endif
+#ifdef TARGET_NR_getxpid
+    S(getxpid);
+#endif
+#ifdef TARGET_NR_getxuid
+    S(getxuid);
+#endif
+#ifdef TARGET_NR_get_thread_area
+    S(get_thread_area);
+#endif
 #ifdef TARGET_NR_ipc
     S(ipc);
 #endif
@@ -10870,6 +10202,48 @@ static const SyscallDef *syscall_table(int num)
 #ifdef TARGET_NR_semop
     S(semop);
 #endif
+#ifdef TARGET_NR_setfsgid32
+    S(setfsgid32);
+#endif
+#ifdef TARGET_NR_setfsuid32
+    S(setfsuid32);
+#endif
+#ifdef TARGET_NR_setgid32
+    S(setgid32);
+#endif
+#ifdef TARGET_NR_setgroups32
+    S(setgroups32);
+#endif
+#ifdef TARGET_NR_setregid
+    S(setregid);
+#endif
+#ifdef TARGET_NR_setregid32
+    S(setregid32);
+#endif
+#ifdef TARGET_NR_setresgid
+    S(setresgid);
+#endif
+#ifdef TARGET_NR_setresgid32
+    S(setresgid32);
+#endif
+#ifdef TARGET_NR_setresuid
+    S(setresuid);
+#endif
+#ifdef TARGET_NR_setresuid32
+    S(setresuid32);
+#endif
+#ifdef TARGET_NR_setreuid
+    S(setreuid);
+#endif
+#ifdef TARGET_NR_setreuid32
+    S(setreuid32);
+#endif
+#ifdef TARGET_NR_setuid32
+    S(setuid32);
+#endif
+#ifdef TARGET_NR_set_thread_area
+    S(set_thread_area);
+#endif
 #ifdef TARGET_NR_shmat
     S(shmat);
 #endif
@@ -10881,6 +10255,9 @@ static const SyscallDef *syscall_table(int num)
 #endif
 #ifdef TARGET_NR_shmget
     S(shmget);
+#endif
+#ifdef TARGET_NR_vfork
+    S(vfork);
 #endif
     }
     return NULL;
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d0160f841f..f19f27e4b6 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -94,9 +94,6 @@
 #ifdef TARGET_NR_clock_settime
 { TARGET_NR_clock_settime, "clock_settime" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_clone
-{ TARGET_NR_clone, "clone" , NULL, print_clone, NULL },
-#endif
 #ifdef TARGET_NR_connect
 { TARGET_NR_connect, "connect" , "%s(%d,%#x,%d)", NULL, NULL },
 #endif
@@ -223,9 +220,6 @@
 #ifdef TARGET_NR_flock
 { TARGET_NR_flock, "flock" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_fork
-{ TARGET_NR_fork, "fork" , "%s()", NULL, NULL },
-#endif
 #ifdef TARGET_NR_fremovexattr
 { TARGET_NR_fremovexattr, "fremovexattr" , NULL, NULL, NULL },
 #endif
@@ -280,30 +274,6 @@
 #ifdef TARGET_NR_getdtablesize
 { TARGET_NR_getdtablesize, "getdtablesize" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getegid
-{ TARGET_NR_getegid, "getegid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getegid32
-{ TARGET_NR_getegid32, "getegid32" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_geteuid
-{ TARGET_NR_geteuid, "geteuid" , "%s()", NULL, NULL },
-#endif
-#ifdef TARGET_NR_geteuid32
-{ TARGET_NR_geteuid32, "geteuid32" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getgid
-{ TARGET_NR_getgid, "getgid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getgid32
-{ TARGET_NR_getgid32, "getgid32" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getgroups
-{ TARGET_NR_getgroups, "getgroups" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getgroups32
-{ TARGET_NR_getgroups32, "getgroups32" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_gethostname
 { TARGET_NR_gethostname, "gethostname" , NULL, NULL, NULL },
 #endif
@@ -322,39 +292,15 @@
 #ifdef TARGET_NR_getpeername
 { TARGET_NR_getpeername, "getpeername" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getpgid
-{ TARGET_NR_getpgid, "getpgid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getpgrp
-{ TARGET_NR_getpgrp, "getpgrp" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getpid
-{ TARGET_NR_getpid, "getpid" , "%s()", NULL, NULL },
-#endif
 #ifdef TARGET_NR_getpmsg
 { TARGET_NR_getpmsg, "getpmsg" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getppid
-{ TARGET_NR_getppid, "getppid" , "%s()", NULL, NULL },
-#endif
 #ifdef TARGET_NR_getpriority
 { TARGET_NR_getpriority, "getpriority", "%s(%#x,%#x)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getrandom
 { TARGET_NR_getrandom, "getrandom", NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getresgid
-{ TARGET_NR_getresgid, "getresgid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getresgid32
-{ TARGET_NR_getresgid32, "getresgid32" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getresuid
-{ TARGET_NR_getresuid, "getresuid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getresuid32
-{ TARGET_NR_getresuid32, "getresuid32" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_getrlimit
 { TARGET_NR_getrlimit, "getrlimit" , NULL, NULL, NULL },
 #endif
@@ -364,9 +310,6 @@
 #ifdef TARGET_NR_getrusage
 { TARGET_NR_getrusage, "getrusage" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getsid
-{ TARGET_NR_getsid, "getsid" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_getsockname
 { TARGET_NR_getsockname, "getsockname" , NULL, NULL, NULL },
 #endif
@@ -377,30 +320,12 @@
 { TARGET_NR_get_thread_area, "get_thread_area", "%s(0x"TARGET_ABI_FMT_lx")",
   NULL, NULL },
 #endif
-#ifdef TARGET_NR_gettid
-{ TARGET_NR_gettid, "gettid" , "%s()", NULL, NULL },
-#endif
 #ifdef TARGET_NR_gettimeofday
 { TARGET_NR_gettimeofday, "gettimeofday" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getuid
-{ TARGET_NR_getuid, "getuid" , "%s()", NULL, NULL },
-#endif
-#ifdef TARGET_NR_getuid32
-{ TARGET_NR_getuid32, "getuid32" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_getxattr
 { TARGET_NR_getxattr, "getxattr" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getxgid
-{ TARGET_NR_getxgid, "getxgid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getxpid
-{ TARGET_NR_getxpid, "getxpid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getxuid
-{ TARGET_NR_getxuid, "getxuid" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_gtty
 { TARGET_NR_gtty, "gtty" , NULL, NULL, NULL },
 #endif
@@ -632,9 +557,6 @@
 #ifdef TARGET_NR_osf_alt_plock
 { TARGET_NR_osf_alt_plock, "osf_alt_plock" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_osf_alt_setsid
-{ TARGET_NR_osf_alt_setsid, "osf_alt_setsid" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_osf_alt_sigpending
 { TARGET_NR_osf_alt_sigpending, "osf_alt_sigpending" , NULL, NULL, NULL },
 #endif
@@ -1154,30 +1076,6 @@
 #ifdef TARGET_NR_setdomainname
 { TARGET_NR_setdomainname, "setdomainname" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_setfsgid
-{ TARGET_NR_setfsgid, "setfsgid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setfsgid32
-{ TARGET_NR_setfsgid32, "setfsgid32" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setfsuid
-{ TARGET_NR_setfsuid, "setfsuid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setfsuid32
-{ TARGET_NR_setfsuid32, "setfsuid32" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setgid
-{ TARGET_NR_setgid, "setgid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setgid32
-{ TARGET_NR_setgid32, "setgid32" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setgroups
-{ TARGET_NR_setgroups, "setgroups" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setgroups32
-{ TARGET_NR_setgroups32, "setgroups32" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_sethae
 { TARGET_NR_sethae, "sethae" , NULL, NULL, NULL },
 #endif
@@ -1193,48 +1091,15 @@
 #ifdef TARGET_NR_setns
 { TARGET_NR_setns, "setns" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_setpgid
-{ TARGET_NR_setpgid, "setpgid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setpgrp
-{ TARGET_NR_setpgrp, "setpgrp" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_setpriority
 { TARGET_NR_setpriority, "setpriority" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_setregid
-{ TARGET_NR_setregid, "setregid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setregid32
-{ TARGET_NR_setregid32, "setregid32" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setresgid
-{ TARGET_NR_setresgid, "setresgid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setresgid32
-{ TARGET_NR_setresgid32, "setresgid32" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setresuid
-{ TARGET_NR_setresuid, "setresuid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setresuid32
-{ TARGET_NR_setresuid32, "setresuid32" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setreuid
-{ TARGET_NR_setreuid, "setreuid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setreuid32
-{ TARGET_NR_setreuid32, "setreuid32" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_setrlimit
 { TARGET_NR_setrlimit, "setrlimit" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_set_robust_list
 { TARGET_NR_set_robust_list, "set_robust_list" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_setsid
-{ TARGET_NR_setsid, "setsid" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_setsockopt
 { TARGET_NR_setsockopt, "setsockopt" , NULL, NULL, NULL },
 #endif
@@ -1248,12 +1113,6 @@
 #ifdef TARGET_NR_settimeofday
 { TARGET_NR_settimeofday, "settimeofday" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_setuid
-{ TARGET_NR_setuid, "setuid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_setuid32
-{ TARGET_NR_setuid32, "setuid32" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_setxattr
 { TARGET_NR_setxattr, "setxattr" , NULL, NULL, NULL },
 #endif
@@ -1488,9 +1347,6 @@
 #ifdef TARGET_NR_utrap_install
 { TARGET_NR_utrap_install, "utrap_install" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_vfork
-{ TARGET_NR_vfork, "vfork" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_vhangup
 { TARGET_NR_vhangup, "vhangup" , NULL, NULL, NULL },
 #endif
-- 
2.17.1
