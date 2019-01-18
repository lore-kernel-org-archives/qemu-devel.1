Received: from eggs.gnu.org ([209.51.188.92]:55949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkM-00057Q-SZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkK-0004bw-2e
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:14 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkJ-0004b4-Hh
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:11 -0500
Received: by mail-pl1-x642.google.com with SMTP id gn14so6875725plb.10
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:51 +1100
Message-Id: <20190118213122.22865-18-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 18/49] linux-user: Split out clone, fork,
 vfork
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

Rename do_fork to do_clone, since that is what it does.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |   8 ++
 linux-user/syscall.h          |   1 +
 linux-user/strace.c           |  36 +----
 linux-user/syscall-proc.inc.c | 259 ++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 218 ----------------------------
 linux-user/strace.list        |   9 --
 6 files changed, 272 insertions(+), 259 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index c3ed22ff16..6f6f77927b 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -19,8 +19,12 @@
 SYSCALL_DEF_FULL(brk, .impl = impl_brk,
                  .print_ret = print_syscall_ptr_ret,
                  .arg_type = { ARG_PTR });
+SYSCALL_DEF_ARGS(clone, ARG_CLONEFLAG, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(close, ARG_DEC);
 SYSCALL_DEF(exit, ARG_DEC);
+#ifdef TARGET_NR_fork
+SYSCALL_DEF(fork);
+#endif
 #ifdef TARGET_NR_ipc
 SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 #endif
@@ -110,5 +114,9 @@ SYSCALL_DEF(shmdt, ARG_PTR);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_shmget)
 SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
+#ifdef TARGET_NR_vfork
+/* Emulate vfork() with fork().  */
+SYSCALL_DEF_FULL(vfork, .impl = impl_fork);
+#endif
 SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(writev, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 8175de4c31..f75cd3ddd0 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -58,6 +58,7 @@ typedef enum {
     /* These print as sets of flags.  */
     ARG_ATDIRFD,
     ARG_ATFLAG,
+    ARG_CLONEFLAG,
     ARG_MMAPFLAG,
     ARG_MMAPPROT,
     ARG_MODEFLAG,
diff --git a/linux-user/strace.c b/linux-user/strace.c
index ba541432eb..d7847e7cd6 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -813,7 +813,7 @@ static struct flags const mmap_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags clone_flags[] = {
+static struct flags const clone_flags[] = {
     FLAG_GENERIC(CLONE_VM),
     FLAG_GENERIC(CLONE_FS),
     FLAG_GENERIC(CLONE_FILES),
@@ -1183,37 +1183,6 @@ print_clock_adjtime(const struct syscallname *name,
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
@@ -2521,6 +2490,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
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
index 96ad363c1a..b89ac56552 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -16,6 +16,258 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
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
+/*
+ * CLONE_VFORK is special cased early in do_fork(). The other flag bits
+ * have almost all been allocated. We cannot support any of
+ * CLONE_NEWNS, CLONE_NEWCGROUP, CLONE_NEWUTS, CLONE_NEWIPC,
+ * CLONE_NEWUSER, CLONE_NEWPID, CLONE_NEWNET, CLONE_PTRACE, CLONE_UNTRACED.
+ * The checks against the invalid thread masks above will catch these.
+ * (The one remaining unallocated bit is 0x1000 which used to be CLONE_PID.)
+ */
+
+/**
+ * do_clone:
+ * Arguments as for clone(2), returns target errnos.
+ */
+static abi_long do_clone(CPUArchState *env, unsigned int flags,
+                         abi_ulong newsp, abi_ulong parent_tidptr,
+                         abi_ulong child_tidptr, target_ulong newtls)
+{
+    CPUState *cpu = ENV_GET_CPU(env);
+    abi_long ret;
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
+        /* If CLONE_VM, we consider it a new thread.  */
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
+        /* Create a new CPU instance.  */
+        new_env = cpu_copy(env);
+
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
+
+        /*
+         * It is not safe to deliver signals until the child has finished
+         * initializing, so temporarily block all signals.
+         */
+        sigfillset(&sigmask);
+        sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
+
+        /*
+         * If this is our first additional thread, we need to ensure we
+         * generate code for parallel execution and flush old translations.
+         */
+        if (!parallel_cpus) {
+            parallel_cpus = true;
+            tb_flush(cpu);
+        }
+
+        ret = pthread_create(&info.thread, &attr, clone_func, &info);
+        /* TODO: Free new CPU state if thread creation failed.  */
+
+        sigprocmask(SIG_SETMASK, &info.sigmask, NULL);
+        pthread_attr_destroy(&attr);
+        if (ret == 0) {
+            /* Wait for the child to initialize.  */
+            pthread_cond_wait(&info.cond, &info.mutex);
+            ret = info.tid;
+        } else {
+            ret = host_to_target_errno(ret);
+        }
+        pthread_mutex_unlock(&info.mutex);
+        pthread_cond_destroy(&info.cond);
+        pthread_mutex_destroy(&info.mutex);
+        pthread_mutex_unlock(&clone_lock);
+    } else {
+        /* If no CLONE_VM, we consider it a fork.  */
+        if (flags & CLONE_INVALID_FORK_FLAGS) {
+            return -TARGET_EINVAL;
+        }
+
+        /* We can't support custom termination signals.  */
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
+        if (ret == 0) {
+            /* Child Process.  */
+            cpu_clone_regs(env, newsp);
+            fork_end(1);
+            /*
+             * There is a race condition here.  The parent process could
+             * theoretically read the TID in the child process before the
+             * child tid is set.  This would require using either ptrace
+             * (not implemented) or having *_tidptr to point at a shared
+             * memory mapping.  We can't repeat the spinlock hack used
+             * above because the child process gets its own copy of the lock.
+             */
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
+            ret = get_errno(ret);
+        }
+    }
+    return ret;
+}
+
+#if defined(TARGET_MICROBLAZE) || \
+    defined(TARGET_CLONE_BACKWARDS) || \
+    defined(TARGET_CLONE_BACKWARDS2)
+SYSCALL_ARGS(clone)
+{
+    /*
+     * Linux manages to have three "standard" orderings for its
+     * arguments to clone(); the BACKWARDS and BACKWARDS2 defines
+     * match the kernel's CONFIG_CLONE_* settings.
+     * Microblaze is further special in that it uses a sixth
+     * implicit argument to clone for the TLS pointer.
+     *
+     * Standardize on the non-BACKWARDS ordering.
+     */
+# if defined(TARGET_MICROBLAZE)
+    /* We have already assigned out[0-1].  */
+    out[2] = in[3];
+    out[3] = in[4];
+    out[4] = in[5];
+# elif defined(TARGET_CLONE_BACKWARDS)
+    /* We have already assigned out[0-2].  */
+    out[3] = in[4];
+    out[4] = in[3];
+# elif defined(TARGET_CLONE_BACKWARDS2)
+    out[0] = in[1];
+    out[1] = in[0];
+    out[2] = in[2];
+    out[3] = in[4];
+    out[4] = in[3];
+# else
+#  error Missing case
+# endif
+    return def;
+}
+#else
+#define args_clone NULL
+#endif
+
+SYSCALL_IMPL(clone)
+{
+    return do_clone(cpu_env, arg1, arg2, arg3, arg4, arg5);
+}
 
 SYSCALL_IMPL(exit)
 {
@@ -59,3 +311,10 @@ SYSCALL_IMPL(exit)
     preexit_cleanup(cpu_env, status);
     _exit(status);
 }
+
+#if defined(TARGET_NR_fork) || defined(TARGET_NR_vfork)
+SYSCALL_IMPL(fork)
+{
+    return do_clone(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0);
+}
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fbca989021..1d18d28fbe 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -113,57 +113,6 @@
 #include "fd-trans.h"
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
@@ -4397,146 +4346,6 @@ static void *clone_func(void *arg)
     return NULL;
 }
 
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
@@ -5535,10 +5344,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_fork
-    case TARGET_NR_fork:
-        return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
-#endif
 #ifdef TARGET_NR_waitpid
     case TARGET_NR_waitpid:
         {
@@ -7228,23 +7033,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8079,12 +7867,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
diff --git a/linux-user/strace.list b/linux-user/strace.list
index bdc1401b01..0d978ea580 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -91,9 +91,6 @@
 #ifdef TARGET_NR_clock_settime
 { TARGET_NR_clock_settime, "clock_settime" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_clone
-{ TARGET_NR_clone, "clone" , NULL, print_clone, NULL },
-#endif
 #ifdef TARGET_NR_connect
 { TARGET_NR_connect, "connect" , "%s(%d,%#x,%d)", NULL, NULL },
 #endif
@@ -220,9 +217,6 @@
 #ifdef TARGET_NR_flock
 { TARGET_NR_flock, "flock" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_fork
-{ TARGET_NR_fork, "fork" , "%s()", NULL, NULL },
-#endif
 #ifdef TARGET_NR_fremovexattr
 { TARGET_NR_fremovexattr, "fremovexattr" , NULL, NULL, NULL },
 #endif
@@ -1485,9 +1479,6 @@
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
2.17.2
