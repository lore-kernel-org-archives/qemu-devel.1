Received: from eggs.gnu.org ([2001:4830:134:3::10]:41493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfv-0004ZS-27
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqft-0004js-Kd
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:51 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:46990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqft-0004jh-E8
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:49 -0400
Received: by mail-pf0-x244.google.com with SMTP id q1-v6so8483697pff.13
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:11 -1000
Message-Id: <20180610030220.3777-100-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 099/108] linux-user: Split out signalfd,
 signalfd4
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

All targets define signalfd4; remove the ifdefs.
In do_signalfd4, unlock the target sigmask earlier and use is_error.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5edcb39b73..e630a43f97 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6975,8 +6975,6 @@ static abi_long host_to_target_statfs64(abi_ulong target_addr,
 }
 #endif
 
-#if defined(TARGET_NR_signalfd) || defined(TARGET_NR_signalfd4)
-
 /* signalfd siginfo conversion */
 
 static void
@@ -7045,21 +7043,17 @@ static abi_long do_signalfd4(int fd, abi_long mask, int flags)
     if (!lock_user_struct(VERIFY_READ, target_mask, mask, 1)) {
         return -TARGET_EFAULT;
     }
-
     target_to_host_sigset(&host_mask, target_mask);
+    unlock_user_struct(target_mask, mask, 0);
 
     host_flags = target_to_host_bitmask(flags, fcntl_flags_tbl);
 
     ret = get_errno(signalfd(fd, &host_mask, host_flags));
-    if (ret >= 0) {
+    if (!is_error(ret)) {
         fd_trans_register(ret, &target_signalfd_trans);
     }
-
-    unlock_user_struct(target_mask, mask, 0);
-
     return ret;
 }
-#endif
 
 /* Map host to target signal numbers for the wait family of syscalls.
    Assume all other status bits are the same.  */
@@ -11884,6 +11878,18 @@ IMPL(sigaltstack)
     return do_sigaltstack(arg1, arg2, get_sp_from_cpustate(cpu_env));
 }
 
+#ifdef TARGET_NR_signalfd
+IMPL(signalfd)
+{
+    return do_signalfd4(arg1, arg2, 0);
+}
+#endif
+
+IMPL(signalfd4)
+{
+    return do_signalfd4(arg1, arg2, arg4);
+}
+
 #ifdef TARGET_NR_sigpending
 IMPL(sigpending)
 {
@@ -12850,14 +12856,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     abi_long ret;
 
     switch(num) {
-#if defined(TARGET_NR_signalfd4)
-    case TARGET_NR_signalfd4:
-        return do_signalfd4(arg1, arg2, arg4);
-#endif
-#if defined(TARGET_NR_signalfd)
-    case TARGET_NR_signalfd:
-        return do_signalfd4(arg1, arg2, 0);
-#endif
 #if defined(CONFIG_EPOLL)
 #if defined(TARGET_NR_epoll_create)
     case TARGET_NR_epoll_create:
@@ -13808,6 +13806,10 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(sigaction);
 #endif
         SYSCALL(sigaltstack);
+#ifdef TARGET_NR_signalfd
+        SYSCALL(signalfd);
+#endif
+        SYSCALL(signalfd4);
 #ifdef TARGET_NR_sigpending
         SYSCALL(sigpending);
 #endif
-- 
2.17.1
