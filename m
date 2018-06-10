Received: from eggs.gnu.org ([2001:4830:134:3::10]:41092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqf3-0003he-Ey
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqf1-00049Y-V7
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:57 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqf1-00049C-NH
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:55 -0400
Received: by mail-pg0-x244.google.com with SMTP id w12-v6so8139553pgc.6
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:42 -1000
Message-Id: <20180610030220.3777-71-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 070/108] linux-user: Split out ftruncate64,
 truncate64, ugetrlimit, vfork
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
 linux-user/syscall.c | 133 +++++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 63 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 39e416db0b..c2dc7131bb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6718,34 +6718,6 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 }
 #endif /* TARGET_ABI_BITS != 32 */
 
-#ifdef TARGET_NR_truncate64
-static inline abi_long target_truncate64(void *cpu_env, const char *arg1,
-                                         abi_long arg2,
-                                         abi_long arg3,
-                                         abi_long arg4)
-{
-    if (regpairs_aligned(cpu_env, TARGET_NR_truncate64)) {
-        arg2 = arg3;
-        arg3 = arg4;
-    }
-    return get_errno(truncate64(arg1, target_offset64(arg2, arg3)));
-}
-#endif
-
-#ifdef TARGET_NR_ftruncate64
-static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
-                                          abi_long arg2,
-                                          abi_long arg3,
-                                          abi_long arg4)
-{
-    if (regpairs_aligned(cpu_env, TARGET_NR_ftruncate64)) {
-        arg2 = arg3;
-        arg3 = arg4;
-    }
-    return get_errno(ftruncate64(arg1, target_offset64(arg2, arg3)));
-}
-#endif
-
 static inline abi_long target_to_host_timespec(struct timespec *host_ts,
                                                abi_ulong target_addr)
 {
@@ -8204,6 +8176,17 @@ IMPL(ftruncate)
     return get_errno(ftruncate(arg1, arg2));
 }
 
+#ifdef TARGET_NR_ftruncate64
+IMPL(ftruncate64)
+{
+    if (regpairs_aligned(cpu_env, TARGET_NR_ftruncate64)) {
+        arg2 = arg3;
+        arg3 = arg4;
+    }
+    return get_errno(ftruncate64(arg1, target_offset64(arg2, arg3)));
+}
+#endif
+
 #ifdef TARGET_NR_futimesat
 IMPL(futimesat)
 {
@@ -11048,6 +11031,45 @@ IMPL(truncate)
     return ret;
 }
 
+#ifdef TARGET_NR_truncate64
+IMPL(truncate64)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    if (regpairs_aligned(cpu_env, TARGET_NR_truncate64)) {
+        arg2 = arg3;
+        arg3 = arg4;
+    }
+    ret = get_errno(truncate64(p, target_offset64(arg2, arg3)));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
+#ifdef TARGET_NR_ugetrlimit
+IMPL(ugetrlimit)
+{
+    struct rlimit rlim;
+    int resource = target_to_host_resource(arg1);
+    abi_long ret = get_errno(getrlimit(resource, &rlim));
+
+    if (!is_error(ret)) {
+        struct target_rlimit *target_rlim;
+        if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0)) {
+            return -TARGET_EFAULT;
+        }
+        target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
+        target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
+        unlock_user_struct(target_rlim, arg2, 1);
+    }
+    return ret;
+}
+#endif
+
 IMPL(umask)
 {
     return get_errno(umask(arg1));
@@ -11183,6 +11205,14 @@ IMPL(utimes)
 }
 #endif
 
+#ifdef TARGET_NR_vfork
+IMPL(vfork)
+{
+    return get_errno(do_fork(cpu_env, CLONE_VFORK | CLONE_VM | TARGET_SIGCHLD,
+                             0, 0, 0, 0));
+}
+#endif
+
 IMPL(vhangup)
 {
     return get_errno(vhangup());
@@ -11307,41 +11337,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_vfork
-    case TARGET_NR_vfork:
-        return get_errno(do_fork(cpu_env,
-                         CLONE_VFORK | CLONE_VM | TARGET_SIGCHLD,
-                         0, 0, 0, 0));
-#endif
-#ifdef TARGET_NR_ugetrlimit
-    case TARGET_NR_ugetrlimit:
-    {
-	struct rlimit rlim;
-	int resource = target_to_host_resource(arg1);
-	ret = get_errno(getrlimit(resource, &rlim));
-	if (!is_error(ret)) {
-	    struct target_rlimit *target_rlim;
-            if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0))
-                return -TARGET_EFAULT;
-	    target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
-	    target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
-            unlock_user_struct(target_rlim, arg2, 1);
-	}
-        return ret;
-    }
-#endif
-#ifdef TARGET_NR_truncate64
-    case TARGET_NR_truncate64:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-	ret = target_truncate64(cpu_env, p, arg2, arg3, arg4);
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#ifdef TARGET_NR_ftruncate64
-    case TARGET_NR_ftruncate64:
-        return target_ftruncate64(cpu_env, arg1, arg2, arg3, arg4);
-#endif
 #ifdef TARGET_NR_stat64
     case TARGET_NR_stat64:
         if (!(p = lock_user_string(arg1))) {
@@ -13052,6 +13047,9 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(fsync);
         SYSCALL(ftruncate);
+#ifdef TARGET_NR_ftruncate64
+        SYSCALL(ftruncate64);
+#endif
 #ifdef TARGET_NR_futimesat
         SYSCALL(futimesat);
 #endif
@@ -13352,6 +13350,12 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(times);
         SYSCALL(truncate);
+#ifdef TARGET_NR_truncate64
+        SYSCALL(truncate64);
+#endif
+#ifdef TARGET_NR_ugetrlimit
+        SYSCALL(ugetrlimit);
+#endif
         SYSCALL(umask);
 #ifdef TARGET_NR_umount
         SYSCALL(umount);
@@ -13367,6 +13371,9 @@ static impl_fn *syscall_table(unsigned num)
 #endif
 #ifdef TARGET_NR_utimes
         SYSCALL(utimes);
+#endif
+#ifdef TARGET_NR_vfork
+        SYSCALL(vfork);
 #endif
         SYSCALL(vhangup);
 #if defined(TARGET_I386) && !defined(TARGET_X86_64)
-- 
2.17.1
