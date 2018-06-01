Received: from eggs.gnu.org ([2001:4830:134:3::10]:57387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWi-0005Sf-Ek
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWe-0000JR-G8
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:08 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:42873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWe-0000Iw-8S
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:04 -0400
Received: by mail-pg0-x241.google.com with SMTP id p9-v6so10862763pgc.9
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:23 -0700
Message-Id: <20180601073050.8054-7-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/33] linux-user: Split out goto unimplemented
 to do_unimplemented
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 82 +++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f7b7051c1c..4269ec2c23 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7962,6 +7962,12 @@ static int host_to_target_cpu_mask(const unsigned long *host_mask,
     return 0;
 }
 
+static abi_long do_unimplemented(int num)
+{
+    gemu_log("qemu: Unsupported syscall: %d\n", num);
+    return -TARGET_ENOSYS;
+}
+
 /* This is an internal helper for do_syscall so that it is easier
  * to have a single return point, so that actions, such as logging
  * of syscall results, can be performed.
@@ -8342,11 +8348,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_break
     case TARGET_NR_break:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_oldstat
     case TARGET_NR_oldstat:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
     case TARGET_NR_lseek:
         if (is_hostfd(arg1)) {
@@ -8436,14 +8442,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
 #endif
     case TARGET_NR_ptrace:
-        goto unimplemented;
+        return do_unimplemented(num);
 #ifdef TARGET_NR_alarm /* not on alpha */
     case TARGET_NR_alarm:
         return alarm(arg1);
 #endif
 #ifdef TARGET_NR_oldfstat
     case TARGET_NR_oldfstat:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_pause /* not on alpha */
     case TARGET_NR_pause:
@@ -8522,11 +8528,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_stty
     case TARGET_NR_stty:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_gtty
     case TARGET_NR_gtty:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_access
     case TARGET_NR_access:
@@ -8561,7 +8567,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_ftime
     case TARGET_NR_ftime:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
     case TARGET_NR_sync:
         sync();
@@ -8687,11 +8693,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
 #ifdef TARGET_NR_prof
     case TARGET_NR_prof:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_signal
     case TARGET_NR_signal:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
     case TARGET_NR_acct:
         if (arg1 == 0) {
@@ -8715,7 +8721,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_lock
     case TARGET_NR_lock:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
     case TARGET_NR_ioctl:
         return do_ioctl(arg1, arg2, arg3);
@@ -8725,17 +8731,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_mpx
     case TARGET_NR_mpx:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
     case TARGET_NR_setpgid:
         return get_errno(setpgid(arg1, arg2));
 #ifdef TARGET_NR_ulimit
     case TARGET_NR_ulimit:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_oldolduname
     case TARGET_NR_oldolduname:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
     case TARGET_NR_umask:
         return get_errno(umask(arg1));
@@ -8747,7 +8753,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
 #ifdef TARGET_NR_ustat
     case TARGET_NR_ustat:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_dup2
     case TARGET_NR_dup2:
@@ -9471,7 +9477,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_oldlstat
     case TARGET_NR_oldlstat:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_readlink
     case TARGET_NR_readlink:
@@ -9536,7 +9542,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_uselib
     case TARGET_NR_uselib:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_swapon
     case TARGET_NR_swapon:
@@ -9561,7 +9567,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
 #ifdef TARGET_NR_readdir
     case TARGET_NR_readdir:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_mmap
     case TARGET_NR_mmap:
@@ -9699,7 +9705,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return get_errno(setpriority(arg1, arg2, arg3));
 #ifdef TARGET_NR_profil
     case TARGET_NR_profil:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
     case TARGET_NR_statfs:
         if (!(fn = lock_user_string(arg1))) {
@@ -9778,7 +9784,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_ioperm
     case TARGET_NR_ioperm:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_socketcall
     case TARGET_NR_socketcall:
@@ -10062,17 +10068,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
 #ifdef TARGET_NR_olduname
     case TARGET_NR_olduname:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_iopl
     case TARGET_NR_iopl:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
     case TARGET_NR_vhangup:
         return get_errno(vhangup());
 #ifdef TARGET_NR_idle
     case TARGET_NR_idle:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_syscall
     case TARGET_NR_syscall:
@@ -10252,7 +10258,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return do_modify_ldt(cpu_env, arg1, arg2, arg3);
 #if !defined(TARGET_X86_64)
     case TARGET_NR_vm86old:
-        goto unimplemented;
+        return do_unimplemented(num);
     case TARGET_NR_vm86:
         return do_vm86(cpu_env, arg1, arg2);
 #endif
@@ -10297,9 +10303,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_get_kernel_syms
     case TARGET_NR_get_kernel_syms:
 #endif
-        goto unimplemented;
+        return do_unimplemented(num);
     case TARGET_NR_quotactl:
-        goto unimplemented;
+        return do_unimplemented(num);
     case TARGET_NR_getpgid:
         return get_errno(getpgid(arg1));
     case TARGET_NR_fchdir:
@@ -10309,17 +10315,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return get_errno(fchdir(arg1));
 #ifdef TARGET_NR_bdflush /* not on x86_64 */
     case TARGET_NR_bdflush:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_sysfs
     case TARGET_NR_sysfs:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
     case TARGET_NR_personality:
         return get_errno(personality(arg1));
 #ifdef TARGET_NR_afs_syscall
     case TARGET_NR_afs_syscall:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR__llseek /* Not on alpha */
     case TARGET_NR__llseek:
@@ -10865,11 +10871,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
 #ifdef TARGET_NR_query_module
     case TARGET_NR_query_module:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_nfsservctl
     case TARGET_NR_nfsservctl:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
     case TARGET_NR_prctl:
         switch (arg1) {
@@ -10949,7 +10955,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_I386) && !defined(TARGET_ABI32)
         return do_arch_prctl(cpu_env, arg1, arg2);
 #else
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #endif
 #ifdef TARGET_NR_pread64
@@ -11116,16 +11122,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_sendfile64
     case TARGET_NR_sendfile64:
 #endif
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 
 #ifdef TARGET_NR_getpmsg
     case TARGET_NR_getpmsg:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_putpmsg
     case TARGET_NR_putpmsg:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_vfork
     case TARGET_NR_vfork:
@@ -11694,7 +11700,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 
     case TARGET_NR_pivot_root:
-        goto unimplemented;
+        return do_unimplemented(num);
 #ifdef TARGET_NR_mincore
     case TARGET_NR_mincore:
         {
@@ -11869,7 +11875,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_security
     case TARGET_NR_security:
-        goto unimplemented;
+        return do_unimplemented(num);
 #endif
 #ifdef TARGET_NR_getpagesize
     case TARGET_NR_getpagesize:
@@ -12884,9 +12890,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 
     default:
-    unimplemented:
-        gemu_log("qemu: Unsupported syscall: %d\n", num);
-        return -TARGET_ENOSYS;
+        return do_unimplemented(num);
     }
 fail:
     return ret;
-- 
2.17.0
