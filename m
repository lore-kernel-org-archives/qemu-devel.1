Received: from eggs.gnu.org ([2001:4830:134:3::10]:41595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqg8-0004oq-1L
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqg7-0004sk-3X
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:04 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:32941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqg6-0004s2-T2
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:03 -0400
Received: by mail-pf0-x244.google.com with SMTP id b17-v6so8496140pfi.0
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:06:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:18 -1000
Message-Id: <20180610030220.3777-107-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 106/108] linux-user: Split out ioprio_get,
 ioprio_set, kcmp
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

All targets define all of these; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 49 ++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c0752ad6e0..d15f994039 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -250,6 +250,15 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #ifndef __NR_gettid
 #define __NR_gettid  -1
 #endif
+#ifndef __NR_ioprio_get
+#define __NR_ioprio_get  -1
+#endif
+#ifndef __NR_ioprio_set
+#define __NR_ioprio_set  -1
+#endif
+#ifndef __NR_kcmp
+#define __NR_kcmp  -1
+#endif
 #ifndef __NR_set_tid_address
 #define __NR_set_tid_address  -1
 #endif
@@ -296,18 +305,11 @@ _syscall2(int, capget, struct __user_cap_header_struct *, header,
           struct __user_cap_data_struct *, data);
 _syscall2(int, capset, struct __user_cap_header_struct *, header,
           struct __user_cap_data_struct *, data);
-#if defined(TARGET_NR_ioprio_get) && defined(__NR_ioprio_get)
 _syscall2(int, ioprio_get, int, which, int, who)
-#endif
-#if defined(TARGET_NR_ioprio_set) && defined(__NR_ioprio_set)
 _syscall3(int, ioprio_set, int, which, int, who, int, ioprio)
-#endif
 _syscall3(int, getrandom, void *, buf, size_t, buflen, unsigned int, flags)
-
-#if defined(TARGET_NR_kcmp) && defined(__NR_kcmp)
 _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, type,
           unsigned long, idx1, unsigned long, idx2)
-#endif
 
 static bitmask_transtbl fcntl_flags_tbl[] = {
   { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
@@ -9474,6 +9476,16 @@ IMPL(ioctl)
     return ret;
 }
 
+IMPL(ioprio_get)
+{
+    return get_errno(ioprio_get(arg1, arg2));
+}
+
+IMPL(ioprio_set)
+{
+    return get_errno(ioprio_set(arg1, arg2, arg3));
+}
+
 #ifdef TARGET_NR_ipc
 IMPL(ipc)
 {
@@ -9553,6 +9565,11 @@ IMPL(ipc)
 }
 #endif
 
+IMPL(kcmp)
+{
+    return get_errno(kcmp(arg1, arg2, arg3, arg4, arg5));
+}
+
 IMPL(kill)
 {
     return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
@@ -13187,16 +13204,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     abi_long ret;
 
     switch(num) {
-#if defined(TARGET_NR_ioprio_get) && defined(__NR_ioprio_get)
-    case TARGET_NR_ioprio_get:
-        return get_errno(ioprio_get(arg1, arg2));
-#endif
-
-#if defined(TARGET_NR_ioprio_set) && defined(__NR_ioprio_set)
-    case TARGET_NR_ioprio_set:
-        return get_errno(ioprio_set(arg1, arg2, arg3));
-#endif
-
 #if defined(TARGET_NR_setns) && defined(CONFIG_SETNS)
     case TARGET_NR_setns:
         return get_errno(setns(arg1, arg2));
@@ -13205,11 +13212,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     case TARGET_NR_unshare:
         return get_errno(unshare(arg1));
 #endif
-#if defined(TARGET_NR_kcmp) && defined(__NR_kcmp)
-    case TARGET_NR_kcmp:
-        return get_errno(kcmp(arg1, arg2, arg3, arg4, arg5));
-#endif
-
     default:
         gemu_log("qemu: Unsupported syscall: %d\n", num);
         return -TARGET_ENOSYS;
@@ -13510,9 +13512,12 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(inotify_rm_watch);
 #endif
         SYSCALL(ioctl);
+        SYSCALL(ioprio_get);
+        SYSCALL(ioprio_set);
 #ifdef TARGET_NR_ipc
         SYSCALL(ipc);
 #endif
+        SYSCALL(kcmp);
         SYSCALL(kill);
 #ifdef TARGET_NR_lchown
         SYSCALL(lchown);
-- 
2.17.1
