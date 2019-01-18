Received: from eggs.gnu.org ([209.51.188.92]:56244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkz-0005as-6y
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkx-0005BV-96
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:53 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkt-00056n-Dp
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:49 -0500
Received: by mail-pg1-x544.google.com with SMTP id z10so6647489pgp.7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:06 +1100
Message-Id: <20190118213122.22865-33-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 33/49] linux-user: Split out umount, umount2
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

Note that umount2 is unconditionally available.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  4 ++++
 linux-user/syscall.h          |  1 +
 linux-user/strace.c           | 30 ++++--------------------------
 linux-user/syscall-file.inc.c | 25 +++++++++++++++++++++++++
 linux-user/syscall.c          | 16 ----------------
 linux-user/strace.list        |  6 ------
 6 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 2b331c6a6d..0d8da0c6d6 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -155,6 +155,10 @@ SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #ifdef TARGET_NR_time
 SYSCALL_DEF(time, ARG_PTR);
 #endif
+#ifdef TARGET_NR_umount
+SYSCALL_DEF(umount, ARG_STR);
+#endif
+SYSCALL_DEF(umount2, ARG_STR, ARG_UMOUNTFLAG);
 #ifdef TARGET_NR_unlink
 SYSCALL_DEF(unlink, ARG_STR);
 #endif
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 35dd3e5fa3..3c936b648a 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -64,6 +64,7 @@ typedef enum {
     ARG_MODEFLAG,
     ARG_MOUNTFLAG,
     ARG_OPENFLAG,
+    ARG_UMOUNTFLAG,
     ARG_UNLINKATFLAG,
     ARG_LSEEKWHENCE,
 
diff --git a/linux-user/strace.c b/linux-user/strace.c
index eb02430eba..78781b8817 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -733,7 +733,7 @@ static struct flags const mount_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags umount2_flags[] = {
+static struct flags const umount2_flags[] = {
 #ifdef MNT_FORCE
     FLAG_GENERIC(MNT_FORCE),
 #endif
@@ -2003,31 +2003,6 @@ print_symlinkat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_umount
-static void
-print_umount(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_umount2
-static void
-print_umount2(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_flags(umount2_flags, arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_utime
 static void
 print_utime(const struct syscallname *name,
@@ -2293,6 +2268,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_OPENFLAG:
             len = add_open_flags(b, rest, arg);
             break;
+        case ARG_UMOUNTFLAG:
+            len = add_flags(b, rest, umount2_flags, arg, false);
+            break;
         case ARG_UNLINKATFLAG:
             len = add_flags(b, rest, unlinkat_flags, arg, true);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index d7eb72cc31..7ec1c26347 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -810,6 +810,31 @@ SYSCALL_IMPL(readlinkat)
 }
 #endif
 
+static abi_long do_umount2(abi_ulong target_path, int flags)
+{
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(umount2(p, flags));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_umount
+SYSCALL_IMPL(umount)
+{
+    return do_umount2(arg1, 0);
+}
+#endif
+
+SYSCALL_IMPL(umount2)
+{
+    return do_umount2(arg1, arg2);
+}
+
 static abi_long do_unlinkat(int dirfd, abi_ulong target_path, int flags)
 {
     char *p = lock_user_string(target_path);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 39e749a985..b35d84794f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5327,14 +5327,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_umount
-    case TARGET_NR_umount:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(umount(p));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
 #ifdef TARGET_NR_stime /* not on alpha */
     case TARGET_NR_stime:
         {
@@ -5555,14 +5547,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p, arg1, 0);
         }
         return ret;
-#ifdef TARGET_NR_umount2
-    case TARGET_NR_umount2:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(umount2(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
     case TARGET_NR_ioctl:
         return do_ioctl(arg1, arg2, arg3);
 #ifdef TARGET_NR_fcntl
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 5f07e0e23d..0f32c456cd 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1368,12 +1368,6 @@
 #ifdef TARGET_NR_umask
 { TARGET_NR_umask, "umask" , "%s(%#o)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_umount
-{ TARGET_NR_umount, "umount" , NULL, print_umount, NULL },
-#endif
-#ifdef TARGET_NR_umount2
-{ TARGET_NR_umount2, "umount2" , NULL, print_umount2, NULL },
-#endif
 #ifdef TARGET_NR_uname
 { TARGET_NR_uname, "uname" , "%s(%p)", NULL, NULL },
 #endif
-- 
2.17.2
