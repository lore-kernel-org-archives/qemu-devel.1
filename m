Received: from eggs.gnu.org ([2001:4830:134:3::10]:40143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqd0-0001jk-Mv
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqcx-0003C9-Jh
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:50 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:44838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqcx-0003Bm-Bp
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:02:47 -0400
Received: by mail-pg0-x242.google.com with SMTP id p21-v6so8127188pgd.11
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:02:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:41 -1000
Message-Id: <20180610030220.3777-10-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 009/108] linux-user: Set up infrastructure
 for table-izing syscalls
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

At the same time, split out set_robust_list and get_robust_list.
Put them together, along with their block comment, at the top
of syscall_table.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 87 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 21 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 46f123ee13..8678e749ee 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7947,6 +7947,17 @@ static int host_to_target_cpu_mask(const unsigned long *host_mask,
     return 0;
 }
 
+typedef abi_long impl_fn(void *cpu_env, unsigned num, abi_long arg1,
+                         abi_long arg2, abi_long arg3, abi_long arg4,
+                         abi_long arg5, abi_long arg6, abi_long arg7,
+                         abi_long arg8);
+
+#define IMPL(NAME) \
+static abi_long impl_##NAME(void *cpu_env, unsigned num, abi_long arg1,   \
+                            abi_long arg2, abi_long arg3, abi_long arg4,  \
+                            abi_long arg5, abi_long arg6, abi_long arg7,  \
+                            abi_long arg8)
+
 /* This is an internal helper for do_syscall so that it is easier
  * to have a single return point, so that actions, such as logging
  * of syscall results, can be performed.
@@ -11740,23 +11751,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
         return get_errno(safe_tgkill((int)arg1, (int)arg2,
                          target_to_host_signal(arg3)));
 
-#ifdef TARGET_NR_set_robust_list
-    case TARGET_NR_set_robust_list:
-    case TARGET_NR_get_robust_list:
-        /* The ABI for supporting robust futexes has userspace pass
-         * the kernel a pointer to a linked list which is updated by
-         * userspace after the syscall; the list is walked by the kernel
-         * when the thread exits. Since the linked list in QEMU guest
-         * memory isn't a valid linked list for the host and we have
-         * no way to reliably intercept the thread-death event, we can't
-         * support these. Silently return ENOSYS so that guest userspace
-         * falls back to a non-robust futex implementation (which should
-         * be OK except in the corner case of the guest crashing while
-         * holding a mutex that is shared with another process via
-         * shared memory).
-         */
-        return -TARGET_ENOSYS;
-#endif
 
 #if defined(TARGET_NR_utimensat)
     case TARGET_NR_utimensat:
@@ -12412,6 +12406,54 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     return ret;
 }
 
+/* The default action for a syscall not listed in syscall_table is to
+ * log the missing syscall.  If a syscall is intentionally emulated as
+ * not present, then list it with impl_enosys as the implementation,
+ * which will avoid the logging.
+ */
+IMPL(enosys)
+{
+    return -TARGET_ENOSYS;
+}
+
+/* For a given syscall number, return a function implementing it.
+ * Do this via switch statement instead of table because some targets
+ * do not begin at 0 and others have a large split in the middle of
+ * the numbers.  The compiler should be able to produce a dense table.
+ */
+static impl_fn *syscall_table(unsigned num)
+{
+#define SYSCALL_WITH(X, Y)    case TARGET_NR_##X: return impl_##Y
+#define SYSCALL(X)            SYSCALL_WITH(X, X)
+
+    switch (num) {
+        /* The ABI for supporting robust futexes has userspace pass
+         * the kernel a pointer to a linked list which is updated by
+         * userspace after the syscall; the list is walked by the kernel
+         * when the thread exits. Since the linked list in QEMU guest
+         * memory isn't a valid linked list for the host and we have
+         * no way to reliably intercept the thread-death event, we can't
+         * support these. Silently return ENOSYS so that guest userspace
+         * falls back to a non-robust futex implementation (which should
+         * be OK except in the corner case of the guest crashing while
+         * holding a mutex that is shared with another process via
+         * shared memory).
+         */
+        SYSCALL_WITH(get_robust_list, enosys);
+        SYSCALL_WITH(set_robust_list, enosys);
+
+        /*
+         * Other syscalls listed in collation order, with '_' ignored.
+         */
+    }
+
+#undef SYSCALL
+#undef SYSCALL_WITH
+
+    /* After do_syscall1 is fully split, this will be impl_enosys.  */
+    return do_syscall1;
+}
+
 abi_long do_syscall(void *cpu_env, unsigned num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
@@ -12419,6 +12461,7 @@ abi_long do_syscall(void *cpu_env, unsigned num, abi_long arg1,
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
     abi_long ret;
+    impl_fn *fn;
 
 #ifdef DEBUG_ERESTARTSYS
     /* Debug-only code for exercising the syscall-restart code paths
@@ -12437,14 +12480,16 @@ abi_long do_syscall(void *cpu_env, unsigned num, abi_long arg1,
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
                              arg5, arg6, arg7, arg8);
 
+    fn = syscall_table(num);
+
     if (unlikely(do_strace)) {
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
-        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
-                          arg5, arg6, arg7, arg8);
+        ret = fn(cpu_env, num, arg1, arg2, arg3, arg4,
+                 arg5, arg6, arg7, arg8);
         print_syscall_ret(num, ret);
     } else {
-        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
-                          arg5, arg6, arg7, arg8);
+        ret = fn(cpu_env, num, arg1, arg2, arg3, arg4,
+                 arg5, arg6, arg7, arg8);
     }
 
     trace_guest_user_syscall_ret(cpu, num, ret);
-- 
2.17.1
