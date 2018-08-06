Received: from eggs.gnu.org ([2001:4830:134:3::10]:54034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmixb-0005x4-Jg
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmixY-00071I-Sh
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:06:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43856 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fmixY-000710-Fl
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:06:20 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  6 Aug 2018 18:59:40 +0200
Message-Id: <1533574847-19294-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 13/80] linux-user: Add preprocessor
 availability control to some syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Add ability to target platforms to individually include user-mode
support for system calls from "stat" group of system calls.

This change is related to new nanoMIPS platform in the sense that
it supports a different set of "stat" system calls than any other
target. nanoMIPS does not support structures stat and stat64 at
all. Also, support for certain number of other system calls is
dropped in nanoMIPS (those are most of the time obsoleted system
calls).

Without this patch, build for nanoMIPS would fail.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/strace.c  | 14 +++++++++++++-
 linux-user/syscall.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index bd897a3..33f4a50 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -2304,7 +2304,19 @@ print_statfs(const struct syscallname *name,
     print_pointer(arg1, 1);
     print_syscall_epilogue(name);
 }
-#define print_statfs64  print_statfs
+#endif
+
+#ifdef TARGET_NR_statfs64
+static void
+print_statfs64(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_pointer(arg1, 1);
+    print_syscall_epilogue(name);
+}
 #endif
 
 #ifdef TARGET_NR_symlink
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dfc851c..3d57966 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7286,6 +7286,9 @@ static inline int target_to_host_mlockall_arg(int arg)
 }
 #endif
 
+#if (defined(TARGET_NR_stat64) || defined(TARGET_NR_lstat64) ||     \
+     defined(TARGET_NR_fstat64) || defined(TARGET_NR_fstatat64) ||  \
+     defined(TARGET_NR_newfstatat))
 static inline abi_long host_to_target_stat64(void *cpu_env,
                                              abi_ulong target_addr,
                                              struct stat *host_st)
@@ -7348,6 +7351,7 @@ static inline abi_long host_to_target_stat64(void *cpu_env,
 
     return 0;
 }
+#endif
 
 /* ??? Using host futex calls even when target atomic operations
    are not really atomic probably breaks things.  However implementing
@@ -7996,8 +8000,15 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
     abi_long ret;
+#if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) \
+    || defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64) \
+    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64)
     struct stat st;
+#endif
+#if defined(TARGET_NR_statfs) || defined(TARGET_NR_statfs64) \
+    || defined(TARGET_NR_fstatfs)
     struct statfs stfs;
+#endif
     void *p;
 
 #if defined(DEBUG_ERESTARTSYS)
@@ -8365,9 +8376,11 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_oldstat:
         goto unimplemented;
 #endif
+#ifdef TARGET_NR_lseek
     case TARGET_NR_lseek:
         ret = get_errno(lseek(arg1, arg2, arg3));
         break;
+#endif
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
     /* Alpha specific */
     case TARGET_NR_getxpid:
@@ -9251,6 +9264,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(sethostname(p, arg2));
         unlock_user(p, arg1, 0);
         break;
+#ifdef TARGET_NR_setrlimit
     case TARGET_NR_setrlimit:
         {
             int resource = target_to_host_resource(arg1);
@@ -9264,6 +9278,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(setrlimit(resource, &rlim));
         }
         break;
+#endif
+#ifdef TARGET_NR_getrlimit
     case TARGET_NR_getrlimit:
         {
             int resource = target_to_host_resource(arg1);
@@ -9280,6 +9296,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             }
         }
         break;
+#endif
     case TARGET_NR_getrusage:
         {
             struct rusage rusage;
@@ -9644,15 +9661,19 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(munlockall());
         break;
 #endif
+#ifdef TARGET_NR_truncate
     case TARGET_NR_truncate:
         if (!(p = lock_user_string(arg1)))
             goto efault;
         ret = get_errno(truncate(p, arg2));
         unlock_user(p, arg1, 0);
         break;
+#endif
+#ifdef TARGET_NR_ftruncate
     case TARGET_NR_ftruncate:
         ret = get_errno(ftruncate(arg1, arg2));
         break;
+#endif
     case TARGET_NR_fchmod:
         ret = get_errno(fchmod(arg1, arg2));
         break;
@@ -9688,6 +9709,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_profil:
         goto unimplemented;
 #endif
+#ifdef TARGET_NR_statfs
     case TARGET_NR_statfs:
         if (!(p = lock_user_string(arg1)))
             goto efault;
@@ -9719,9 +9741,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             unlock_user_struct(target_stfs, arg2, 1);
         }
         break;
+#endif
+#ifdef TARGET_NR_fstatfs
     case TARGET_NR_fstatfs:
         ret = get_errno(fstatfs(arg1, &stfs));
         goto convert_statfs;
+#endif
 #ifdef TARGET_NR_statfs64
     case TARGET_NR_statfs64:
         if (!(p = lock_user_string(arg1)))
@@ -9969,6 +9994,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg1, 0);
         goto do_stat;
 #endif
+#ifdef TARGET_NR_fstat
     case TARGET_NR_fstat:
         {
             ret = get_errno(fstat(arg1, &st));
@@ -9998,6 +10024,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             }
         }
         break;
+#endif
 #ifdef TARGET_NR_olduname
     case TARGET_NR_olduname:
         goto unimplemented;
@@ -10997,6 +11024,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
 #ifdef CONFIG_SENDFILE
+#ifdef TARGET_NR_sendfile
     case TARGET_NR_sendfile:
     {
         off_t *offp = NULL;
@@ -11017,6 +11045,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
     }
+#endif
 #ifdef TARGET_NR_sendfile64
     case TARGET_NR_sendfile64:
     {
-- 
2.7.4
