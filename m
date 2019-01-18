Received: from eggs.gnu.org ([209.51.188.92]:56328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbl6-0005g5-JH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbl4-0005Lo-DL
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:00 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbl3-0005Fk-2l
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:57 -0500
Received: by mail-pg1-x542.google.com with SMTP id z11so6661221pgu.0
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:10 +1100
Message-Id: <20190118213122.22865-37-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 37/49] linux-user: Split out access,
 faccessat
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

Note that faccessat is unconditionally available.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  4 ++++
 linux-user/syscall.h          |  1 +
 linux-user/strace.c           | 33 ++++-----------------------------
 linux-user/syscall-file.inc.c | 25 +++++++++++++++++++++++++
 linux-user/syscall.c          | 18 ------------------
 linux-user/strace.list        |  6 ------
 6 files changed, 34 insertions(+), 53 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 2767e335d8..39e3ae3c21 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -16,6 +16,9 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#ifdef TARGET_NR_access
+SYSCALL_DEF(access, ARG_STR, ARG_ACCESSFLAG);
+#endif
 #ifdef TARGET_NR_alarm
 SYSCALL_DEF(alarm, ARG_DEC);
 #endif
@@ -34,6 +37,7 @@ SYSCALL_DEF(creat, ARG_STR, ARG_MODEFLAG);
 SYSCALL_DEF(exit, ARG_DEC);
 SYSCALL_DEF(execve, ARG_STR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(execveat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
+SYSCALL_DEF(faccessat, ARG_ATDIRFD, ARG_STR, ARG_ACCESSFLAG);
 SYSCALL_DEF(fchmod, ARG_DEC, ARG_MODEFLAG);
 SYSCALL_DEF(fchmodat, ARG_ATDIRFD, ARG_STR, ARG_MODEFLAG);
 #ifdef TARGET_NR_futimesat
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 3c936b648a..84a52b2d9a 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -57,6 +57,7 @@ typedef enum {
 
     /* These print as sets of flags.  */
     ARG_ATDIRFD,
+    ARG_ACCESSFLAG,
     ARG_ATFLAG,
     ARG_CLONEFLAG,
     ARG_MMAPFLAG,
diff --git a/linux-user/strace.c b/linux-user/strace.c
index b54949df27..da2cc30f82 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -634,7 +634,7 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
     gemu_log("\n");
 }
 
-UNUSED static struct flags access_flags[] = {
+static struct flags const access_flags[] = {
     FLAG_GENERIC(F_OK),
     FLAG_GENERIC(R_OK),
     FLAG_GENERIC(W_OK),
@@ -1114,19 +1114,6 @@ print_accept(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_access
-static void
-print_access(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_flags(access_flags, arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_clock_adjtime
 static void
 print_clock_adjtime(const struct syscallname *name,
@@ -1153,21 +1140,6 @@ print_execv(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_faccessat
-static void
-print_faccessat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_flags(access_flags, arg2, 0);
-    print_flags(at_file_flags, arg3, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_fchownat
 static void
 print_fchownat(const struct syscallname *name,
@@ -2206,6 +2178,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_ATDIRFD:
             len = add_atdirfd(b, rest, arg);
             break;
+        case ARG_ACCESSFLAG:
+            len = add_flags(b, rest, access_flags, arg, false);
+            break;
         case ARG_ATFLAG:
             len = add_flags(b, rest, at_file_flags, arg, false);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 6a7ef80bfc..3111abd861 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -16,6 +16,26 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+static abi_long do_faccessat(int dirfd, abi_ulong target_path, int mode)
+{
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(faccessat(dirfd, p, mode, 0));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_access
+SYSCALL_IMPL(access)
+{
+    return do_faccessat(AT_FDCWD, arg1, arg2);
+}
+#endif
+
 SYSCALL_IMPL(chdir)
 {
     abi_ulong target_path = arg1;
@@ -74,6 +94,11 @@ SYSCALL_IMPL(creat)
 }
 #endif
 
+SYSCALL_IMPL(faccessat)
+{
+    return do_faccessat(arg1, arg2, arg3);
+}
+
 SYSCALL_IMPL(fchmod)
 {
     return get_errno(fchmod(arg1, arg2));
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ca462fde61..9074cf8b8d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5327,24 +5327,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
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
 #ifdef TARGET_NR_nice /* not on alpha */
     case TARGET_NR_nice:
         return get_errno(nice(arg1));
diff --git a/linux-user/strace.list b/linux-user/strace.list
index c0c1b896f7..fc0eb91e29 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -9,9 +9,6 @@
 #ifdef TARGET_NR_accept4
 { TARGET_NR_accept4, "accept4" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_access
-{ TARGET_NR_access, "access" , NULL, print_access, NULL },
-#endif
 #ifdef TARGET_NR_acct
 { TARGET_NR_acct, "acct" , NULL, NULL, NULL },
 #endif
@@ -142,9 +139,6 @@
 #ifdef TARGET_NR_exit_group
 { TARGET_NR_exit_group, "exit_group" , "%s(%d)\n", NULL, NULL },
 #endif
-#ifdef TARGET_NR_faccessat
-{ TARGET_NR_faccessat, "faccessat" , NULL, print_faccessat, NULL },
-#endif
 #ifdef TARGET_NR_fadvise64
 { TARGET_NR_fadvise64, "fadvise64" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
