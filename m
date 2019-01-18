Received: from eggs.gnu.org ([209.51.188.92]:56177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkr-0005Wq-Cn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkn-00053Z-Iq
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:43 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkl-000513-QQ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:40 -0500
Received: by mail-pg1-x542.google.com with SMTP id j10so6663302pga.1
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:03 +1100
Message-Id: <20190118213122.22865-30-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 30/49] linux-user: Split out lseek, llseek
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

Canonicalise the target syscall name on llseek (new kernels)
instead of _llseek (old kernels).  Always use host lseek(3)
rather than attempting to use the host llseek(2).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  6 ++++++
 linux-user/syscall.h          |  1 +
 linux-user/strace.c           | 39 +++++++++++++++--------------------
 linux-user/syscall-file.inc.c | 36 ++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 32 ++--------------------------
 linux-user/strace.list        |  6 ------
 6 files changed, 62 insertions(+), 58 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 3ddf8aa0e3..3453e7afdf 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -43,6 +43,12 @@ SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 SYSCALL_DEF(link, ARG_STR, ARG_STR);
 #endif
 SYSCALL_DEF(linkat, ARG_ATDIRFD, ARG_STR, ARG_ATDIRFD, ARG_STR, ARG_ATFLAG);
+#ifdef TARGET_NR_lseek
+SYSCALL_DEF(lseek, ARG_DEC, ARG_DEC, ARG_LSEEKWHENCE);
+#endif
+#ifdef TARGET_NR_llseek
+SYSCALL_DEF_ARGS(llseek, ARG_DEC, ARG_DEC, ARG_PTR, ARG_LSEEKWHENCE);
+#endif
 #ifdef TARGET_NR_mknod
 SYSCALL_DEF(mknod, ARG_STR, ARG_MODEFLAG, ARG_HEX);
 #endif
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index bdc4d653c4..c16c0a3f1e 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -64,6 +64,7 @@ typedef enum {
     ARG_MODEFLAG,
     ARG_OPENFLAG,
     ARG_UNLINKATFLAG,
+    ARG_LSEEKWHENCE,
 
     /* These are interpreted as pointers.  */
     ARG_PTR,
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 66d981b9e6..c08dbdff0c 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -934,6 +934,20 @@ print_open_flags(abi_long flags, int last)
     gemu_log("%s%s", buf, get_comma(last));
 }
 
+static int add_lseek_whence(char *buf, int size, int whence)
+{
+    switch (whence) {
+    case SEEK_SET:
+        return snprintf(buf, size, "SEEK_SET");
+    case SEEK_CUR:
+        return snprintf(buf, size, "SEEK_CUR");
+    case SEEK_END:
+        return snprintf(buf, size, "SEEK_END");
+    default:
+        return snprintf(buf, size, "%#x", whence);
+    }
+}
+
 static void
 print_syscall_prologue(const struct syscallname *sc)
 {
@@ -1285,28 +1299,6 @@ print_futimesat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR__llseek
-static void
-print__llseek(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    const char *whence = "UNKNOWN";
-    print_syscall_prologue(name);
-    print_raw_param("%d", arg0, 0);
-    print_raw_param("%ld", arg1, 0);
-    print_raw_param("%ld", arg2, 0);
-    print_pointer(arg3, 0);
-    switch(arg4) {
-    case SEEK_SET: whence = "SEEK_SET"; break;
-    case SEEK_CUR: whence = "SEEK_CUR"; break;
-    case SEEK_END: whence = "SEEK_END"; break;
-    }
-    gemu_log("%s",whence);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #if defined(TARGET_NR_socket)
 static void
 print_socket(const struct syscallname *name,
@@ -2317,6 +2309,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_UNLINKATFLAG:
             len = add_flags(b, rest, unlinkat_flags, arg, true);
             break;
+        case ARG_LSEEKWHENCE:
+            len = add_lseek_whence(b, rest, arg);
+            break;
         case ARG_PTR:
             len = add_pointer(b, rest, arg);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 9844382166..e23d21bdfc 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -112,6 +112,42 @@ SYSCALL_IMPL(linkat)
     return do_linkat(arg1, arg2, arg3, arg4, arg5);
 }
 
+#ifdef TARGET_NR_lseek
+SYSCALL_IMPL(lseek)
+{
+    return get_errno(lseek(arg1, arg2, arg3));
+}
+#endif
+
+#ifdef TARGET_NR_llseek
+SYSCALL_ARGS(llseek)
+{
+    /* The parts for offset are *always* in big-endian order.  */
+    abi_ulong lo = in[2], hi = in[1];
+    out[1] = (((uint64_t)hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
+    out[2] = in[3];
+    out[3] = in[4];
+    return def;
+}
+
+SYSCALL_IMPL(llseek)
+{
+    int fd = arg1;
+    int64_t offset = arg2;
+    abi_ulong target_res = arg3;
+    int whence = arg4;
+
+    off_t res = lseek(fd, offset, whence);
+
+    if (res == -1) {
+        return get_errno(-1);
+    } else if (put_user_s64(res, target_res)) {
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
+#endif
+
 static abi_long do_mknodat(int dirfd, abi_ulong target_path,
                            mode_t mode, dev_t dev)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f9101d0b08..09fcec7812 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -195,8 +195,8 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #endif
 
 /* Newer kernel ports have llseek() instead of _llseek() */
-#if defined(TARGET_NR_llseek) && !defined(TARGET_NR__llseek)
-#define TARGET_NR__llseek TARGET_NR_llseek
+#if !defined(TARGET_NR_llseek) && defined(TARGET_NR__llseek)
+#define TARGET_NR_llseek TARGET_NR__llseek
 #endif
 
 #ifdef __NR_gettid
@@ -227,10 +227,6 @@ _syscall3(int, sys_getdents, uint, fd, struct linux_dirent *, dirp, uint, count)
     (defined(TARGET_NR_getdents64) && defined(__NR_getdents64))
 _syscall3(int, sys_getdents64, uint, fd, struct linux_dirent64 *, dirp, uint, count);
 #endif
-#if defined(TARGET_NR__llseek) && defined(__NR_llseek)
-_syscall5(int, _llseek,  uint,  fd, ulong, hi, ulong, lo,
-          loff_t *, res, uint, wh);
-#endif
 _syscall3(int, sys_rt_sigqueueinfo, pid_t, pid, int, sig, siginfo_t *, uinfo)
 _syscall4(int, sys_rt_tgsigqueueinfo, pid_t, pid, pid_t, tid, int, sig,
           siginfo_t *, uinfo)
@@ -5331,10 +5327,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_lseek
-    case TARGET_NR_lseek:
-        return get_errno(lseek(arg1, arg2, arg3));
-#endif
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
     /* Alpha specific */
     case TARGET_NR_getxpid:
@@ -6833,26 +6825,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return get_errno(fchdir(arg1));
     case TARGET_NR_personality:
         return get_errno(personality(arg1));
-#ifdef TARGET_NR__llseek /* Not on alpha */
-    case TARGET_NR__llseek:
-        {
-            int64_t res;
-#if !defined(__NR_llseek)
-            res = lseek(arg1, ((uint64_t)arg2 << 32) | (abi_ulong)arg3, arg5);
-            if (res == -1) {
-                ret = get_errno(res);
-            } else {
-                ret = 0;
-            }
-#else
-            ret = get_errno(_llseek(arg1, arg2, arg3, &res, arg5));
-#endif
-            if ((ret == 0) && put_user_s64(res, arg4)) {
-                return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_getdents
     case TARGET_NR_getdents:
 #ifdef EMULATE_GETDENTS_WITH_GETDENTS
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 92a86c682c..18c93ccc2d 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -455,9 +455,6 @@
 #ifdef TARGET_NR_llistxattr
 { TARGET_NR_llistxattr, "llistxattr" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR__llseek
-{ TARGET_NR__llseek, "_llseek" , NULL, print__llseek, NULL },
-#endif
 #ifdef TARGET_NR_lock
 { TARGET_NR_lock, "lock" , NULL, NULL, NULL },
 #endif
@@ -467,9 +464,6 @@
 #ifdef TARGET_NR_lremovexattr
 { TARGET_NR_lremovexattr, "lremovexattr" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_lseek
-{ TARGET_NR_lseek, "lseek" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_lsetxattr
 { TARGET_NR_lsetxattr, "lsetxattr" , NULL, NULL, NULL },
 #endif
-- 
2.17.2
