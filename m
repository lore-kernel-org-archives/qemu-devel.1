Received: from eggs.gnu.org ([2001:4830:134:3::10]:41527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfy-0004cn-4i
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfx-0004l1-3I
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:54 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:35912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfw-0004kj-Sl
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:53 -0400
Received: by mail-pl0-x243.google.com with SMTP id a7-v6so7900703plp.3
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:13 -1000
Message-Id: <20180610030220.3777-102-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 101/108] linux-user: Split out prlimit64
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

All targets define prlimit64; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 65 ++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9ce37c1119..91d90c7417 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -627,7 +627,6 @@ static int sys_renameat2(int oldfd, const char *old,
 }
 #endif
 
-#if defined(TARGET_NR_prlimit64)
 #ifndef __NR_prlimit64
 # define __NR_prlimit64 -1
 #endif
@@ -640,8 +639,6 @@ struct host_rlimit64 {
 _syscall4(int, sys_prlimit64, pid_t, pid, int, resource,
           const struct host_rlimit64 *, new_limit,
           struct host_rlimit64 *, old_limit)
-#endif
-
 
 #if defined(TARGET_NR_timer_create)
 /* Maxiumum of 32 active POSIX timers allowed at any one time. */
@@ -10713,6 +10710,38 @@ IMPL(preadv)
     return ret;
 }
 
+IMPL(prlimit64)
+{
+    /* args: pid, resource number, ptr to new rlimit, ptr to old rlimit */
+    struct host_rlimit64 rnew, rold;
+    int resource = target_to_host_resource(arg2);
+    abi_long ret;
+
+    if (arg3) {
+        struct target_rlimit64 *target_rnew;
+        if (!lock_user_struct(VERIFY_READ, target_rnew, arg3, 1)) {
+            return -TARGET_EFAULT;
+        }
+        rnew.rlim_cur = tswap64(target_rnew->rlim_cur);
+        rnew.rlim_max = tswap64(target_rnew->rlim_max);
+        unlock_user_struct(target_rnew, arg3, 0);
+    }
+
+    ret = get_errno(sys_prlimit64(arg1, resource, arg3 ? &rnew : NULL,
+                                  arg4 ? &rold : NULL));
+
+    if (!is_error(ret) && arg4) {
+        struct target_rlimit64 *target_rold;
+        if (!lock_user_struct(VERIFY_WRITE, target_rold, arg4, 1)) {
+            return -TARGET_EFAULT;
+        }
+        target_rold->rlim_cur = tswap64(rold.rlim_cur);
+        target_rold->rlim_max = tswap64(rold.rlim_max);
+        unlock_user_struct(target_rold, arg4, 1);
+    }
+    return ret;
+}
+
 IMPL(pselect6)
 {
     abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
@@ -12973,35 +13002,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     abi_long ret;
 
     switch(num) {
-#ifdef TARGET_NR_prlimit64
-    case TARGET_NR_prlimit64:
-    {
-        /* args: pid, resource number, ptr to new rlimit, ptr to old rlimit */
-        struct target_rlimit64 *target_rnew, *target_rold;
-        struct host_rlimit64 rnew, rold, *rnewp = 0;
-        int resource = target_to_host_resource(arg2);
-        if (arg3) {
-            if (!lock_user_struct(VERIFY_READ, target_rnew, arg3, 1)) {
-                return -TARGET_EFAULT;
-            }
-            rnew.rlim_cur = tswap64(target_rnew->rlim_cur);
-            rnew.rlim_max = tswap64(target_rnew->rlim_max);
-            unlock_user_struct(target_rnew, arg3, 0);
-            rnewp = &rnew;
-        }
-
-        ret = get_errno(sys_prlimit64(arg1, resource, rnewp, arg4 ? &rold : 0));
-        if (!is_error(ret) && arg4) {
-            if (!lock_user_struct(VERIFY_WRITE, target_rold, arg4, 1)) {
-                return -TARGET_EFAULT;
-            }
-            target_rold->rlim_cur = tswap64(rold.rlim_cur);
-            target_rold->rlim_max = tswap64(rold.rlim_max);
-            unlock_user_struct(target_rold, arg4, 1);
-        }
-        return ret;
-    }
-#endif
 #ifdef TARGET_NR_gethostname
     case TARGET_NR_gethostname:
     {
@@ -13650,6 +13650,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(prctl);
         SYSCALL(pread64);
         SYSCALL(preadv);
+        SYSCALL(prlimit64);
         SYSCALL(pselect6);
         SYSCALL(pwrite64);
         SYSCALL(pwritev);
-- 
2.17.1
