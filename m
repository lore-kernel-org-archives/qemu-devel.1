Received: from eggs.gnu.org ([2001:4830:134:3::10]:40326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdR-00027h-66
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdO-0003M5-2i
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:17 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdN-0003Lk-QL
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:13 -0400
Received: by mail-pl0-x241.google.com with SMTP id z9-v6so10386379plk.11
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:00:54 -1000
Message-Id: <20180610030220.3777-23-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 022/108] linux-user: Split out access,
 faccessat, futimesat, kill, nice, sync, syncfs
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

All targets define faccessat and syncfs; remove the ifdefs.
Fix the missing flags parameter to faccessat.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 143 +++++++++++++++++++++++++++----------------
 1 file changed, 91 insertions(+), 52 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d5f7519e62..6729a960ea 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7871,6 +7871,21 @@ static abi_long impl_##NAME(void *cpu_env, unsigned num, abi_long arg1,   \
                             abi_long arg5, abi_long arg6, abi_long arg7,  \
                             abi_long arg8)
 
+#ifdef TARGET_NR_access
+IMPL(access)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(access(path(p), arg2));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_alarm
 IMPL(alarm)
 {
@@ -8080,6 +8095,19 @@ IMPL(exit)
     g_assert_not_reached();
 }
 
+IMPL(faccessat)
+{
+    char *p = lock_user_string(arg2);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(faccessat(arg1, p, arg3, arg4));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+
 #ifdef TARGET_NR_fork
 IMPL(fork)
 {
@@ -8087,6 +8115,29 @@ IMPL(fork)
 }
 #endif
 
+#ifdef TARGET_NR_futimesat
+IMPL(futimesat)
+{
+    struct timeval tv[2];
+    char *p;
+    abi_long ret;
+
+    if (arg3 &&
+        (copy_from_user_timeval(&tv[0], arg3) ||
+         copy_from_user_timeval(&tv[1],
+                                arg3 + sizeof(struct target_timeval)))) {
+        return -TARGET_EFAULT;
+    }
+    p = lock_user_string(arg2);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(futimesat(arg1, path(p), arg3 ? tv : NULL));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_getpid
 IMPL(getpid)
 {
@@ -8102,6 +8153,11 @@ IMPL(getxpid)
 }
 #endif
 
+IMPL(kill)
+{
+    return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
+}
+
 #ifdef TARGET_NR_link
 IMPL(link)
 {
@@ -8256,6 +8312,13 @@ IMPL(name_to_handle_at)
 }
 #endif
 
+#ifdef TARGET_NR_nice
+IMPL(nice)
+{
+    return get_errno(nice(arg1));
+}
+#endif
+
 #ifdef TARGET_NR_open
 IMPL(open)
 {
@@ -8368,6 +8431,19 @@ IMPL(stime)
 }
 #endif
 
+IMPL(sync)
+{
+    sync();
+    return 0;
+}
+
+#ifdef CONFIG_SYNCFS
+IMPL(syncfs)
+{
+    return get_errno(syncfs(arg1));
+}
+#endif
+
 #ifdef TARGET_NR_time
 IMPL(time)
 {
@@ -8545,58 +8621,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_futimesat)
-    case TARGET_NR_futimesat:
-        {
-            struct timeval *tvp, tv[2];
-            if (arg3) {
-                if (copy_from_user_timeval(&tv[0], arg3)
-                    || copy_from_user_timeval(&tv[1],
-                                              arg3 + sizeof(struct target_timeval)))
-                    return -TARGET_EFAULT;
-                tvp = tv;
-            } else {
-                tvp = NULL;
-            }
-            if (!(p = lock_user_string(arg2))) {
-                return -TARGET_EFAULT;
-            }
-            ret = get_errno(futimesat(arg1, path(p), tvp));
-            unlock_user(p, arg2, 0);
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_access
-    case TARGET_NR_access:
-        if (!(p = lock_user_string(arg1))) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(access(path(p), arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_faccessat) && defined(__NR_faccessat)
-    case TARGET_NR_faccessat:
-        if (!(p = lock_user_string(arg2))) {
-            return -TARGET_EFAULT;
-        }
-        ret = get_errno(faccessat(arg1, p, arg3, 0));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
-#ifdef TARGET_NR_nice /* not on alpha */
-    case TARGET_NR_nice:
-        return get_errno(nice(arg1));
-#endif
-    case TARGET_NR_sync:
-        sync();
-        return 0;
-#if defined(TARGET_NR_syncfs) && defined(CONFIG_SYNCFS)
-    case TARGET_NR_syncfs:
-        return get_errno(syncfs(arg1));
-#endif
-    case TARGET_NR_kill:
-        return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
 #ifdef TARGET_NR_rename
     case TARGET_NR_rename:
         {
@@ -12544,6 +12568,9 @@ static impl_fn *syscall_table(unsigned num)
         /*
          * Other syscalls listed in collation order, with '_' ignored.
          */
+#ifdef TARGET_NR_access
+        SYSCALL(access);
+#endif
 #ifdef TARGET_NR_alarm
         SYSCALL(alarm);
 #endif
@@ -12558,15 +12585,20 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(execve);
         SYSCALL(exit);
+        SYSCALL(faccessat);
 #ifdef TARGET_NR_fork
         SYSCALL(fork);
 #endif
+#ifdef TARGET_NR_futimesat
+        SYSCALL(futimesat);
+#endif
 #ifdef TARGET_NR_getpid
         SYSCALL(getpid);
 #endif
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
         SYSCALL(getxpid);
 #endif
+        SYSCALL(kill);
 #ifdef TARGET_NR_link
         SYSCALL(link);
 #endif
@@ -12580,6 +12612,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef CONFIG_OPEN_BY_HANDLE
         SYSCALL(name_to_handle_at);
 #endif
+#ifdef TARGET_NR_nice
+        SYSCALL(nice);
+#endif
 #ifdef TARGET_NR_open
         SYSCALL(open);
 #endif
@@ -12593,6 +12628,10 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(read);
 #ifdef TARGET_NR_stime
         SYSCALL(stime);
+#endif
+        SYSCALL(sync);
+#ifdef CONFIG_SYNCFS
+        SYSCALL(syncfs);
 #endif
 #ifdef TARGET_NR_time
         SYSCALL(time);
-- 
2.17.1
