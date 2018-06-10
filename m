Received: from eggs.gnu.org ([2001:4830:134:3::10]:40863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqec-0003H5-Lc
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeb-0003nx-C8
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:30 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeb-0003nr-6F
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:29 -0400
Received: by mail-pg0-x242.google.com with SMTP id w12-v6so8139290pgc.6
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:28 -1000
Message-Id: <20180610030220.3777-57-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 056/108] linux-user: Split out clone,
 exit_group, fsync
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 70 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1c3a4590fb..41facf4b44 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7753,6 +7753,25 @@ IMPL(chroot)
     return ret;
 }
 
+IMPL(clone)
+{
+    /* Linux manages to have three different orderings for its
+     * arguments to clone(); the BACKWARDS and BACKWARDS2 defines
+     * match the kernel's CONFIG_CLONE_* settings.
+     * Microblaze is further special in that it uses a sixth
+     * implicit argument to clone for the TLS pointer.
+     */
+#if defined(TARGET_MICROBLAZE)
+    return get_errno(do_fork(cpu_env, arg1, arg2, arg4, arg6, arg5));
+#elif defined(TARGET_CLONE_BACKWARDS)
+    return get_errno(do_fork(cpu_env, arg1, arg2, arg3, arg4, arg5));
+#elif defined(TARGET_CLONE_BACKWARDS2)
+    return get_errno(do_fork(cpu_env, arg2, arg1, arg3, arg5, arg4));
+#else
+    return get_errno(do_fork(cpu_env, arg1, arg2, arg3, arg5, arg4));
+#endif
+}
+
 IMPL(close)
 {
     fd_trans_unregister(arg1);
@@ -7973,6 +7992,17 @@ IMPL(exit)
     g_assert_not_reached();
 }
 
+#ifdef __NR_exit_group
+IMPL(exit_group)
+{
+# ifdef TARGET_GPROF
+    _mcleanup();
+# endif
+    gdb_exit(cpu_env, arg1);
+    return get_errno(exit_group(arg1));
+}
+#endif
+
 IMPL(faccessat)
 {
     char *p = lock_user_string(arg2);
@@ -8056,6 +8086,11 @@ IMPL(fstatfs64)
 }
 #endif
 
+IMPL(fsync)
+{
+    return get_errno(fsync(arg1));
+}
+
 IMPL(ftruncate)
 {
     return get_errno(ftruncate(arg1, arg2));
@@ -10349,34 +10384,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_fsync:
-        return get_errno(fsync(arg1));
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
-#ifdef __NR_exit_group
-        /* new thread calls */
-    case TARGET_NR_exit_group:
-#ifdef TARGET_GPROF
-        _mcleanup();
-#endif
-        gdb_exit(cpu_env, arg1);
-        return get_errno(exit_group(arg1));
-#endif
     case TARGET_NR_setdomainname:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
@@ -12877,6 +12884,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(bind);
 #endif
         SYSCALL(brk);
+        SYSCALL(clone);
         SYSCALL(close);
         SYSCALL(chdir);
         SYSCALL(chroot);
@@ -12896,6 +12904,11 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(dup3);
         SYSCALL(execve);
         SYSCALL(exit);
+#ifdef __NR_exit_group
+        SYSCALL(exit_group);
+#else
+        SYSCALL_WITH(exit_group, enosys);
+#endif
         SYSCALL(faccessat);
         SYSCALL(fchmod);
         SYSCALL(fchmodat);
@@ -12910,6 +12923,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_fstatfs64
         SYSCALL(fstatfs64);
 #endif
+        SYSCALL(fsync);
         SYSCALL(ftruncate);
 #ifdef TARGET_NR_futimesat
         SYSCALL(futimesat);
-- 
2.17.1
