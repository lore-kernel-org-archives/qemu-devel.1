Received: from eggs.gnu.org ([2001:4830:134:3::10]:40937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqel-0003Q2-DF
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqei-0003rE-7C
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:39 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:46988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeh-0003r9-Vy
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:36 -0400
Received: by mail-pf0-x244.google.com with SMTP id q1-v6so8483019pff.13
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:31 -1000
Message-Id: <20180610030220.3777-60-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 059/108] linux-user: Split out fchdir,
 getpgid, llseek, personality
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

Given that we use _LARGEFILE_SOURCE and _FILEOFFSET_BITS == 64, there
is no need to special-case llseek on the host side; always use lseek.
Define _llseek in terms of llseek, rather than the other way around.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 81 +++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7ff05dd33c..f5f21658a8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -240,15 +240,6 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define __NR_sys_inotify_add_watch __NR_inotify_add_watch
 #define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
 
-#if defined(__alpha__) || defined(__x86_64__) || defined(__s390x__)
-#define __NR__llseek __NR_lseek
-#endif
-
-/* Newer kernel ports have llseek() instead of _llseek() */
-#if defined(TARGET_NR_llseek) && !defined(TARGET_NR__llseek)
-#define TARGET_NR__llseek TARGET_NR_llseek
-#endif
-
 /* These definitions produce an ENOSYS from the host kernel.
  * Performing a bogus syscall is lazier than boilerplating
  * the replacement functions here in C.
@@ -280,10 +271,6 @@ _syscall3(int, sys_getdents, uint, fd, struct linux_dirent *, dirp, uint, count)
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
@@ -8026,6 +8013,11 @@ IMPL(faccessat)
     return ret;
 }
 
+IMPL(fchdir)
+{
+    return get_errno(fchdir(arg1));
+}
+
 IMPL(fchmod)
 {
     return get_errno(fchmod(arg1, arg2));
@@ -8150,6 +8142,11 @@ IMPL(getpeername)
 }
 #endif
 
+IMPL(getpgid)
+{
+    return get_errno(getpgid(arg1));
+}
+
 #ifdef TARGET_NR_getpgrp
 IMPL(getpgrp)
 {
@@ -8484,6 +8481,27 @@ IMPL(listen)
 }
 #endif
 
+/* Older kernel ports have _llseek() instead of llseek() */
+#if defined(TARGET_NR__llseek) && !defined(TARGET_NR_llseek)
+#define TARGET_NR_llseek TARGET_NR__llseek
+#endif
+
+#ifdef TARGET_NR_llseek
+IMPL(llseek)
+{
+    off_t res;
+
+    res = lseek(arg1, ((uint64_t)arg2 << 32) | (abi_ulong)arg3, arg5);
+    if (res == -1) {
+        return -host_to_target_errno(errno);
+    }
+    if (put_user_s64(res, arg4)) {
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
+#endif
+
 IMPL(lseek)
 {
     return get_errno(lseek(arg1, arg2, arg3));
@@ -8901,6 +8919,11 @@ IMPL(pause)
 }
 #endif
 
+IMPL(personality)
+{
+    return get_errno(personality(arg1));
+}
+
 #ifdef TARGET_NR_pipe
 IMPL(pipe)
 {
@@ -10462,32 +10485,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_getpgid:
-        return get_errno(getpgid(arg1));
-    case TARGET_NR_fchdir:
-        return get_errno(fchdir(arg1));
-    case TARGET_NR_personality:
-        return get_errno(personality(arg1));
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
@@ -12924,6 +12921,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL_WITH(exit_group, enosys);
 #endif
         SYSCALL(faccessat);
+        SYSCALL(fchdir);
         SYSCALL(fchmod);
         SYSCALL(fchmodat);
 #ifdef TARGET_NR_fcntl
@@ -12946,6 +12944,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_getpeername
         SYSCALL(getpeername);
 #endif
+        SYSCALL(getpgid);
 #ifdef TARGET_NR_getpgrp
         SYSCALL(getpgrp);
 #endif
@@ -12980,6 +12979,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(linkat);
 #ifdef TARGET_NR_listen
         SYSCALL(listen);
+#endif
+#ifdef TARGET_NR_llseek
+        SYSCALL(llseek);
 #endif
         SYSCALL(lseek);
 #ifdef TARGET_NR_lstat
@@ -13042,6 +13044,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_pause
         SYSCALL(pause);
 #endif
+        SYSCALL(personality);
 #ifdef TARGET_NR_pipe
         SYSCALL(pipe);
 #endif
-- 
2.17.1
