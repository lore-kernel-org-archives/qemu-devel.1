Received: from eggs.gnu.org ([2001:4830:134:3::10]:57421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWk-0005Ue-IS
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWj-0000OY-9H
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:10 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:38620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWj-0000Nm-0x
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:09 -0400
Received: by mail-pl0-x243.google.com with SMTP id c11-v6so14817025plr.5
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:27 -0700
Message-Id: <20180601073050.8054-11-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/33] linux-user: Split out brk, close, exit,
 read, write
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

These are relatively simple unconditionally defined syscalls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 198 ++++++++++++++++++++++++-------------------
 1 file changed, 111 insertions(+), 87 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fc3dc3f40d..b0d268dab7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7984,6 +7984,112 @@ IMPL(enosys)
     return do_unimplemented(num);
 }
 
+IMPL(brk)
+{
+    return do_brk(arg1);
+}
+
+IMPL(close)
+{
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+    fd_trans_unregister(arg1);
+    return get_errno(close(arg1));
+}
+
+IMPL(exit)
+{
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+
+    /* In old applications this may be used to implement _exit(2).
+       However in threaded applictions it is used for thread termination,
+       and _exit_group is used for application termination.
+       Do thread termination if we have more then one thread.  */
+    if (block_signals()) {
+        return -TARGET_ERESTARTSYS;
+    }
+
+    cpu_list_lock();
+
+    if (CPU_NEXT(first_cpu)) {
+        /* Remove the CPU from the list.  */
+        QTAILQ_REMOVE(&cpus, cpu, node);
+        cpu_list_unlock();
+
+        TaskState *ts = cpu->opaque;
+        if (ts->child_tidptr) {
+            put_user_u32(0, ts->child_tidptr);
+            sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
+                      NULL, NULL, 0);
+        }
+        thread_cpu = NULL;
+        object_unref(OBJECT(cpu));
+        g_free(ts);
+        rcu_unregister_thread();
+        pthread_exit(NULL);
+    } else {
+        cpu_list_unlock();
+
+#ifdef TARGET_GPROF
+        _mcleanup();
+#endif
+        gdb_exit(cpu_env, arg1);
+        _exit(arg1);
+    }
+    g_assert_not_reached();
+}
+
+IMPL(read)
+{
+    abi_long ret;
+    char *fn;
+
+    if (arg3 == 0) {
+        return 0;
+    }
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+    fn = lock_user(VERIFY_WRITE, arg2, arg3, 0);
+    if (!fn) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(safe_read(arg1, fn, arg3));
+    if (ret >= 0 && fd_trans_host_to_target_data(arg1)) {
+        ret = fd_trans_host_to_target_data(arg1)(fn, ret);
+    }
+    unlock_user(fn, arg2, ret);
+    return ret;
+}
+
+IMPL(write)
+{
+    abi_long ret;
+    char *fn;
+
+    if (is_hostfd(arg1)) {
+        return -TARGET_EBADF;
+    }
+    fn = lock_user(VERIFY_READ, arg2, arg3, 1);
+    if (!fn) {
+        return -TARGET_EFAULT;
+    }
+    if (fd_trans_target_to_host_data(arg1)) {
+        void *copy = g_malloc(arg3);
+        memcpy(copy, fn, arg3);
+        ret = fd_trans_target_to_host_data(arg1)(copy, arg3);
+        if (ret >= 0) {
+            ret = get_errno(safe_write(arg1, copy, ret));
+        }
+        g_free(copy);
+    } else {
+        ret = get_errno(safe_write(arg1, fn, arg3));
+    }
+    unlock_user(fn, arg2, ret);
+    return ret;
+}
+
 /* This is an internal helper for do_syscall so that it is easier
  * to have a single return point, so that actions, such as logging
  * of syscall results, can be performed.
@@ -7999,83 +8105,6 @@ IMPL(everything_else)
     char *fn;
 
     switch(num) {
-    case TARGET_NR_exit:
-        /* In old applications this may be used to implement _exit(2).
-           However in threaded applictions it is used for thread termination,
-           and _exit_group is used for application termination.
-           Do thread termination if we have more then one thread.  */
-
-        if (block_signals()) {
-            return -TARGET_ERESTARTSYS;
-        }
-
-        cpu_list_lock();
-
-        if (CPU_NEXT(first_cpu)) {
-            TaskState *ts;
-
-            /* Remove the CPU from the list.  */
-            QTAILQ_REMOVE(&cpus, cpu, node);
-
-            cpu_list_unlock();
-
-            ts = cpu->opaque;
-            if (ts->child_tidptr) {
-                put_user_u32(0, ts->child_tidptr);
-                sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
-                          NULL, NULL, 0);
-            }
-            thread_cpu = NULL;
-            object_unref(OBJECT(cpu));
-            g_free(ts);
-            rcu_unregister_thread();
-            pthread_exit(NULL);
-        }
-
-        cpu_list_unlock();
-#ifdef TARGET_GPROF
-        _mcleanup();
-#endif
-        gdb_exit(cpu_env, arg1);
-        _exit(arg1);
-        return 0; /* avoid warning */
-    case TARGET_NR_read:
-        if (arg3 == 0) {
-            return 0;
-        } else {
-            if (is_hostfd(arg1)) {
-                return -TARGET_EBADF;
-            }
-            if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-                return -TARGET_EFAULT;
-            ret = get_errno(safe_read(arg1, p, arg3));
-            if (ret >= 0 &&
-                fd_trans_host_to_target_data(arg1)) {
-                ret = fd_trans_host_to_target_data(arg1)(p, ret);
-            }
-            unlock_user(p, arg2, ret);
-        }
-        return ret;
-    case TARGET_NR_write:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        }
-        if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
-            return -TARGET_EFAULT;
-        if (fd_trans_target_to_host_data(arg1)) {
-            void *copy = g_malloc(arg3);
-            memcpy(copy, p, arg3);
-            ret = fd_trans_target_to_host_data(arg1)(copy, arg3);
-            if (ret >= 0) {
-                ret = get_errno(safe_write(arg1, copy, ret));
-            }
-            g_free(copy);
-        } else {
-            ret = get_errno(safe_write(arg1, p, arg3));
-        }
-        unlock_user(p, arg2, 0);
-        return ret;
-
 #ifdef TARGET_NR_open
     case TARGET_NR_open:
         if (!(p = lock_user_string(arg1)))
@@ -8116,15 +8145,6 @@ IMPL(everything_else)
         fd_trans_unregister(ret);
         return ret;
 #endif
-    case TARGET_NR_close:
-        if (is_hostfd(arg1)) {
-            return -TARGET_EBADF;
-        }
-        fd_trans_unregister(arg1);
-        return get_errno(close(arg1));
-
-    case TARGET_NR_brk:
-        return do_brk(arg1);
 #ifdef TARGET_NR_fork
     case TARGET_NR_fork:
         return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
@@ -12894,7 +12914,11 @@ IMPL(everything_else)
 }
 
 static impl_fn * const syscall_table[] = {
-    impl_everything_else,
+    [TARGET_NR_brk] = impl_brk,
+    [TARGET_NR_close] = impl_close,
+    [TARGET_NR_exit] = impl_exit,
+    [TARGET_NR_read] = impl_read,
+    [TARGET_NR_write] = impl_write,
 };
 
 abi_long do_syscall(void *cpu_env, unsigned num, abi_long arg1,
-- 
2.17.0
