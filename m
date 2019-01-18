Received: from eggs.gnu.org ([209.51.188.92]:56075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkf-0005Mf-3s
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkd-0004tV-SZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:33 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkd-0004l3-Lg
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:31 -0500
Received: by mail-pg1-x541.google.com with SMTP id y4so6629776pgc.12
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:56 +1100
Message-Id: <20190118213122.22865-23-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 23/49] linux-user: Split out unlink, unlinkat,
 rmdir
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

Note that unlinkat is universally provided.
Implement rmdir in terms of unlinkat.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  7 ++++++
 linux-user/syscall.h          |  1 +
 linux-user/strace.c           | 43 ++++-------------------------------
 linux-user/syscall-file.inc.c | 32 ++++++++++++++++++++++++++
 linux-user/syscall.c          | 24 -------------------
 linux-user/strace.list        |  9 --------
 6 files changed, 44 insertions(+), 72 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 41dd887dbc..78d3f600eb 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -98,6 +98,9 @@ SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
 #endif
 SYSCALL_DEF(readv, ARG_DEC, ARG_PTR, ARG_DEC);
+#ifdef TARGET_NR_rmdir
+SYSCALL_DEF(rmdir, ARG_STR);
+#endif
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semctl)
 SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
@@ -121,6 +124,10 @@ SYSCALL_DEF(shmdt, ARG_PTR);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_shmget)
 SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
+#ifdef TARGET_NR_unlink
+SYSCALL_DEF(unlink, ARG_STR);
+#endif
+SYSCALL_DEF(unlinkat, ARG_ATDIRFD, ARG_STR, ARG_UNLINKATFLAG);
 #ifdef TARGET_NR_vfork
 /* Emulate vfork() with fork().  */
 SYSCALL_DEF_FULL(vfork, .impl = impl_fork);
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index f75cd3ddd0..bdc4d653c4 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -63,6 +63,7 @@ typedef enum {
     ARG_MMAPPROT,
     ARG_MODEFLAG,
     ARG_OPENFLAG,
+    ARG_UNLINKATFLAG,
 
     /* These are interpreted as pointers.  */
     ARG_PTR,
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5b78eb137b..a41b6dcfe7 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -684,7 +684,7 @@ static struct flags const at_file_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags unlinkat_flags[] = {
+static struct flags const unlinkat_flags[] = {
 #ifdef AT_REMOVEDIR
     FLAG_GENERIC(AT_REMOVEDIR),
 #endif
@@ -1798,18 +1798,6 @@ print_mkdirat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_rmdir
-static void
-print_rmdir(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_rt_sigaction
 static void
 print_rt_sigaction(const struct syscallname *name,
@@ -2175,32 +2163,6 @@ print_umount2(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_unlink
-static void
-print_unlink(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_unlinkat
-static void
-print_unlinkat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_flags(unlinkat_flags, arg2, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_utime
 static void
 print_utime(const struct syscallname *name,
@@ -2463,6 +2425,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_OPENFLAG:
             len = add_open_flags(b, rest, arg);
             break;
+        case ARG_UNLINKATFLAG:
+            len = add_flags(b, rest, unlinkat_flags, arg, true);
+            break;
         case ARG_PTR:
             len = add_pointer(b, rest, arg);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index c6ca80955b..2dd57176b3 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -656,6 +656,38 @@ SYSCALL_IMPL(readlinkat)
 }
 #endif
 
+static abi_long do_unlinkat(int dirfd, abi_ulong target_path, int flags)
+{
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(unlinkat(dirfd, p, flags));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_unlink
+SYSCALL_IMPL(unlink)
+{
+    return do_unlinkat(AT_FDCWD, arg1, 0);
+}
+#endif
+
+#ifdef TARGET_NR_rmdir
+SYSCALL_IMPL(rmdir)
+{
+    return do_unlinkat(AT_FDCWD, arg1, AT_REMOVEDIR);
+}
+#endif
+
+SYSCALL_IMPL(unlinkat)
+{
+    return do_unlinkat(arg1, arg2, arg3);
+}
+
 SYSCALL_IMPL(write)
 {
     int fd = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f1e8d06996..eda199d46f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5330,22 +5330,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_unlink
-    case TARGET_NR_unlink:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(unlink(p));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_unlinkat)
-    case TARGET_NR_unlinkat:
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(unlinkat(arg1, p, arg3));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
     case TARGET_NR_execve:
         {
             char **argp, **envp;
@@ -5737,14 +5721,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(mkdirat(arg1, p, arg3));
         unlock_user(p, arg2, 0);
         return ret;
-#endif
-#ifdef TARGET_NR_rmdir
-    case TARGET_NR_rmdir:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(rmdir(p));
-        unlock_user(p, arg1, 0);
-        return ret;
 #endif
     case TARGET_NR_dup:
         ret = get_errno(dup(arg1));
diff --git a/linux-user/strace.list b/linux-user/strace.list
index c369915759..faa0a9012d 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -527,9 +527,6 @@
 #ifdef TARGET_NR_mkdirat
 { TARGET_NR_mkdirat, "mkdirat" , NULL, print_mkdirat, NULL },
 #endif
-#ifdef TARGET_NR_rmdir
-{ TARGET_NR_rmdir, "rmdir" , NULL, print_rmdir, NULL },
-#endif
 #ifdef TARGET_NR_mknod
 { TARGET_NR_mknod, "mknod" , NULL, print_mknod, NULL },
 #endif
@@ -1425,12 +1422,6 @@
 #ifdef TARGET_NR_uname
 { TARGET_NR_uname, "uname" , "%s(%p)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_unlink
-{ TARGET_NR_unlink, "unlink" , NULL, print_unlink, NULL },
-#endif
-#ifdef TARGET_NR_unlinkat
-{ TARGET_NR_unlinkat, "unlinkat" , NULL, print_unlinkat, NULL },
-#endif
 #ifdef TARGET_NR_unshare
 { TARGET_NR_unshare, "unshare" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
