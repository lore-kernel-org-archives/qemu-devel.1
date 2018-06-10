Received: from eggs.gnu.org ([2001:4830:134:3::10]:40142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqd0-0001jj-My
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqcz-0003Ck-Fu
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:50 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqcz-0003CU-8M
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:49 -0400
Received: by mail-pf0-x242.google.com with SMTP id a63-v6so8498419pfl.1
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:02:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:42 -1000
Message-Id: <20180610030220.3777-11-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 010/108] linux-user: Split out brk, close,
 exit, read, write
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
 linux-user/syscall.c | 179 ++++++++++++++++++++++++-------------------
 1 file changed, 102 insertions(+), 77 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8678e749ee..6d2f9915ec 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7958,6 +7958,103 @@ static abi_long impl_##NAME(void *cpu_env, unsigned num, abi_long arg1,   \
                             abi_long arg5, abi_long arg6, abi_long arg7,  \
                             abi_long arg8)
 
+IMPL(brk)
+{
+    return do_brk(arg1);
+}
+
+IMPL(close)
+{
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
+    char *p;
+
+    if (arg3 == 0) {
+        return 0;
+    }
+    p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(safe_read(arg1, p, arg3));
+    if (ret >= 0 && fd_trans_host_to_target_data(arg1)) {
+        ret = fd_trans_host_to_target_data(arg1)(p, ret);
+    }
+    unlock_user(p, arg2, ret);
+    return ret;
+}
+
+IMPL(write)
+{
+    abi_long ret;
+    char *p;
+
+    p = lock_user(VERIFY_READ, arg2, arg3, 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    if (fd_trans_target_to_host_data(arg1)) {
+        void *copy = g_malloc(arg3);
+        memcpy(copy, p, arg3);
+        ret = fd_trans_target_to_host_data(arg1)(copy, arg3);
+        if (ret >= 0) {
+            ret = get_errno(safe_write(arg1, copy, ret));
+        }
+        g_free(copy);
+    } else {
+        ret = get_errno(safe_write(arg1, p, arg3));
+    }
+    unlock_user(p, arg2, ret);
+    return ret;
+}
+
 /* This is an internal helper for do_syscall so that it is easier
  * to have a single return point, so that actions, such as logging
  * of syscall results, can be performed.
@@ -7975,77 +8072,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
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
@@ -8077,12 +8103,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
         fd_trans_unregister(ret);
         return ret;
 #endif
-    case TARGET_NR_close:
-        fd_trans_unregister(arg1);
-        return get_errno(close(arg1));
-
-    case TARGET_NR_brk:
-        return do_brk(arg1);
 #ifdef TARGET_NR_fork
     case TARGET_NR_fork:
         return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
@@ -12445,6 +12465,11 @@ static impl_fn *syscall_table(unsigned num)
         /*
          * Other syscalls listed in collation order, with '_' ignored.
          */
+        SYSCALL(brk);
+        SYSCALL(close);
+        SYSCALL(exit);
+        SYSCALL(read);
+        SYSCALL(write);
     }
 
 #undef SYSCALL
-- 
2.17.1
