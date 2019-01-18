Received: from eggs.gnu.org ([209.51.188.92]:56386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblD-0005l4-6v
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblA-0005Ub-Vj
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:06 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkblA-0005TQ-Ns
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:04 -0500
Received: by mail-pl1-x641.google.com with SMTP id g9so6895802plo.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:33:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:14 +1100
Message-Id: <20190118213122.22865-41-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 41/49] linux-user: Split out rename, renameat,
 renameat2
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

Note that renameat2 is universally available for guests.
Merge sys_renameat2 into the new do_renameat2 helper.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  8 +++++
 linux-user/syscall.h          |  1 +
 linux-user/strace.c           | 39 ++++++---------------
 linux-user/syscall-file.inc.c | 45 ++++++++++++++++++++++++
 linux-user/syscall.c          | 64 -----------------------------------
 linux-user/strace.list        |  9 -----
 6 files changed, 65 insertions(+), 101 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index c672b5ad99..0ed01aa100 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -142,6 +142,14 @@ SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlinkat
 SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
 #endif
+#ifdef TARGET_NR_rename
+SYSCALL_DEF(rename, ARG_STR, ARG_STR);
+#endif
+#ifdef TARGET_NR_renameat
+SYSCALL_DEF(renameat, ARG_ATDIRFD, ARG_STR, ARG_ATDIRFD, ARG_STR);
+#endif
+SYSCALL_DEF(renameat2, ARG_ATDIRFD, ARG_STR,
+            ARG_ATDIRFD, ARG_STR, ARG_RENAMEFLAG);
 SYSCALL_DEF(readv, ARG_DEC, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_rmdir
 SYSCALL_DEF(rmdir, ARG_STR);
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 642fb6dccb..7b197840f5 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -69,6 +69,7 @@ typedef enum {
     ARG_MODEFLAG,
     ARG_MOUNTFLAG,
     ARG_OPENFLAG,
+    ARG_RENAMEFLAG,
     ARG_UMOUNTFLAG,
     ARG_UNLINKATFLAG,
 
diff --git a/linux-user/strace.c b/linux-user/strace.c
index ec36fcf2c2..6dce7e52c0 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4,6 +4,7 @@
 #include <arpa/inet.h>
 #include <netinet/tcp.h>
 #include <linux/if_packet.h>
+#include <linux/fs.h>
 #include <sched.h>
 #include "qemu.h"
 #include "syscall.h"
@@ -741,6 +742,13 @@ static struct flags const mount_flags[] = {
     FLAG_END,
 };
 
+static struct flags const renameat2_flags[] = {
+    FLAG_GENERIC(RENAME_EXCHANGE),
+    FLAG_GENERIC(RENAME_NOREPLACE),
+    FLAG_GENERIC(RENAME_WHITEOUT),
+    FLAG_END,
+};
+
 static struct flags const umount2_flags[] = {
 #ifdef MNT_FORCE
     FLAG_GENERIC(MNT_FORCE),
@@ -1887,34 +1895,6 @@ print_fstatat64(const struct syscallname *name,
 #define print_newfstatat    print_fstatat64
 #endif
 
-#ifdef TARGET_NR_rename
-static void
-print_rename(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_string(arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_renameat
-static void
-print_renameat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_at_dirfd(arg2, 0);
-    print_string(arg3, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_statfs
 static void
 print_statfs(const struct syscallname *name,
@@ -2200,6 +2180,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_OPENFLAG:
             len = add_open_flags(b, rest, arg);
             break;
+        case ARG_RENAMEFLAG:
+            len = add_flags(b, rest, renameat2_flags, arg, false);
+            break;
         case ARG_UMOUNTFLAG:
             len = add_flags(b, rest, umount2_flags, arg, false);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 80dec33971..9099107631 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -867,6 +867,51 @@ SYSCALL_IMPL(readlinkat)
 }
 #endif
 
+static abi_long do_renameat2(int oldfd, abi_ulong target_oldpath,
+                             int newfd, abi_ulong target_newpath,
+                             unsigned int flags)
+{
+    char *p_old = lock_user_string(target_oldpath);
+    char *p_new = lock_user_string(target_newpath);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (p_old && p_new) {
+        if (flags == 0) {
+            ret = renameat(oldfd, p_old, newfd, p_new);
+        } else {
+#ifdef __NR_renameat2
+            ret = syscall(__NR_renameat2, oldfd, p_old, newfd, p_new, flags);
+#else
+            errno = ENOSYS;
+            ret = -1;
+#endif
+        }
+        ret = get_errno(ret);
+    }
+    unlock_user(p_old, target_oldpath, 0);
+    unlock_user(p_new, target_newpath, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_rename
+SYSCALL_IMPL(rename)
+{
+    return do_renameat2(AT_FDCWD, arg1, AT_FDCWD, arg2, 0);
+}
+#endif
+
+#ifdef TARGET_NR_renameat
+SYSCALL_IMPL(renameat)
+{
+    return do_renameat2(arg1, arg2, arg3, arg4, 0);
+}
+#endif
+
+SYSCALL_IMPL(renameat2)
+{
+    return do_renameat2(arg1, arg2, arg3, arg4, arg5);
+}
+
 SYSCALL_IMPL(sync)
 {
     sync();
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fef955ce66..fe38ec59d4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -341,24 +341,6 @@ static int sys_utimensat(int dirfd, const char *pathname,
 #endif
 #endif /* TARGET_NR_utimensat */
 
-#ifdef TARGET_NR_renameat2
-#if defined(__NR_renameat2)
-#define __NR_sys_renameat2 __NR_renameat2
-_syscall5(int, sys_renameat2, int, oldfd, const char *, old, int, newfd,
-          const char *, new, unsigned int, flags)
-#else
-static int sys_renameat2(int oldfd, const char *old,
-                         int newfd, const char *new, int flags)
-{
-    if (flags == 0) {
-        return renameat(oldfd, old, newfd, new);
-    }
-    errno = ENOSYS;
-    return -1;
-}
-#endif
-#endif /* TARGET_NR_renameat2 */
-
 #ifdef CONFIG_INOTIFY
 #include <sys/inotify.h>
 
@@ -5338,52 +5320,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_rename
-    case TARGET_NR_rename:
-        {
-            void *p2;
-            p = lock_user_string(arg1);
-            p2 = lock_user_string(arg2);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(rename(p, p2));
-            unlock_user(p2, arg2, 0);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_renameat)
-    case TARGET_NR_renameat:
-        {
-            void *p2;
-            p  = lock_user_string(arg2);
-            p2 = lock_user_string(arg4);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(renameat(arg1, p, arg3, p2));
-            unlock_user(p2, arg4, 0);
-            unlock_user(p, arg2, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_renameat2)
-    case TARGET_NR_renameat2:
-        {
-            void *p2;
-            p  = lock_user_string(arg2);
-            p2 = lock_user_string(arg4);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else {
-                ret = get_errno(sys_renameat2(arg1, p, arg3, p2, arg5));
-            }
-            unlock_user(p2, arg4, 0);
-            unlock_user(p, arg2, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_mkdir
     case TARGET_NR_mkdir:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index b120f11dc2..56aab25d9f 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -944,15 +944,6 @@
 #ifdef TARGET_NR_removexattr
 { TARGET_NR_removexattr, "removexattr" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_rename
-{ TARGET_NR_rename, "rename" , NULL, print_rename, NULL },
-#endif
-#ifdef TARGET_NR_renameat
-{ TARGET_NR_renameat, "renameat" , NULL, print_renameat, NULL },
-#endif
-#ifdef TARGET_NR_renameat2
-{ TARGET_NR_renameat2, "renameat2" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_request_key
 { TARGET_NR_request_key, "request_key" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
