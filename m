Received: from eggs.gnu.org ([2001:4830:134:3::10]:59317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXl-0005Ba-0s
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXj-0007YX-H3
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:17 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSXXj-0007Xz-97
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:15 -0400
Received: by mail-pf0-x243.google.com with SMTP id y5-v6so10239266pfn.4
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:52:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Jun 2018 14:51:36 -1000
Message-Id: <20180612005145.3375-11-richard.henderson@linaro.org>
In-Reply-To: <20180612005145.3375-1-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 10/19] linux-user: Propagate goto
 unimplemented to default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org

There is no point in listing a syscall if you want the same effect as
not listing it.  In one less trivial case, the goto was demonstrably
not reachable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 144 +------------------------------------------
 1 file changed, 1 insertion(+), 143 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 06205d3d65..5a17803732 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8297,14 +8297,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(chmod(p, arg2));
         unlock_user(p, arg1, 0);
         return ret;
-#endif
-#ifdef TARGET_NR_break
-    case TARGET_NR_break:
-        goto unimplemented;
-#endif
-#ifdef TARGET_NR_oldstat
-    case TARGET_NR_oldstat:
-        goto unimplemented;
 #endif
     case TARGET_NR_lseek:
         return get_errno(lseek(arg1, arg2, arg3));
@@ -8390,16 +8382,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return get_errno(stime(&host_time));
         }
 #endif
-    case TARGET_NR_ptrace:
-        goto unimplemented;
 #ifdef TARGET_NR_alarm /* not on alpha */
     case TARGET_NR_alarm:
         return alarm(arg1);
 #endif
-#ifdef TARGET_NR_oldfstat
-    case TARGET_NR_oldfstat:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR_pause /* not on alpha */
     case TARGET_NR_pause:
         if (!block_signals()) {
@@ -8470,14 +8456,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
-#ifdef TARGET_NR_stty
-    case TARGET_NR_stty:
-        goto unimplemented;
-#endif
-#ifdef TARGET_NR_gtty
-    case TARGET_NR_gtty:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR_access
     case TARGET_NR_access:
         if (!(p = lock_user_string(arg1))) {
@@ -8499,10 +8477,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_nice /* not on alpha */
     case TARGET_NR_nice:
         return get_errno(nice(arg1));
-#endif
-#ifdef TARGET_NR_ftime
-    case TARGET_NR_ftime:
-        goto unimplemented;
 #endif
     case TARGET_NR_sync:
         sync();
@@ -8616,14 +8590,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = host_to_target_clock_t(ret);
         }
         return ret;
-#ifdef TARGET_NR_prof
-    case TARGET_NR_prof:
-        goto unimplemented;
-#endif
-#ifdef TARGET_NR_signal
-    case TARGET_NR_signal:
-        goto unimplemented;
-#endif
     case TARGET_NR_acct:
         if (arg1 == 0) {
             ret = get_errno(acct(NULL));
@@ -8642,31 +8608,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(umount2(p, arg2));
         unlock_user(p, arg1, 0);
         return ret;
-#endif
-#ifdef TARGET_NR_lock
-    case TARGET_NR_lock:
-        goto unimplemented;
 #endif
     case TARGET_NR_ioctl:
         return do_ioctl(arg1, arg2, arg3);
 #ifdef TARGET_NR_fcntl
     case TARGET_NR_fcntl:
         return do_fcntl(arg1, arg2, arg3);
-#endif
-#ifdef TARGET_NR_mpx
-    case TARGET_NR_mpx:
-        goto unimplemented;
 #endif
     case TARGET_NR_setpgid:
         return get_errno(setpgid(arg1, arg2));
-#ifdef TARGET_NR_ulimit
-    case TARGET_NR_ulimit:
-        goto unimplemented;
-#endif
-#ifdef TARGET_NR_oldolduname
-    case TARGET_NR_oldolduname:
-        goto unimplemented;
-#endif
     case TARGET_NR_umask:
         return get_errno(umask(arg1));
     case TARGET_NR_chroot:
@@ -8675,10 +8625,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(chroot(p));
         unlock_user(p, arg1, 0);
         return ret;
-#ifdef TARGET_NR_ustat
-    case TARGET_NR_ustat:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR_dup2
     case TARGET_NR_dup2:
         ret = get_errno(dup2(arg1, arg2));
@@ -9386,10 +9332,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
-#ifdef TARGET_NR_oldlstat
-    case TARGET_NR_oldlstat:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR_readlink
     case TARGET_NR_readlink:
         {
@@ -9443,10 +9385,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
-#ifdef TARGET_NR_uselib
-    case TARGET_NR_uselib:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR_swapon
     case TARGET_NR_swapon:
         if (!(p = lock_user_string(arg1)))
@@ -9468,10 +9406,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
            ret = get_errno(reboot(arg1, arg2, arg3, NULL));
         }
         return ret;
-#ifdef TARGET_NR_readdir
-    case TARGET_NR_readdir:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR_mmap
     case TARGET_NR_mmap:
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
@@ -9588,10 +9522,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_setpriority:
         return get_errno(setpriority(arg1, arg2, arg3));
-#ifdef TARGET_NR_profil
-    case TARGET_NR_profil:
-        goto unimplemented;
-#endif
     case TARGET_NR_statfs:
         if (!(p = lock_user_string(arg1))) {
             return -TARGET_EFAULT;
@@ -9659,10 +9589,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(fstatfs(arg1, &stfs));
         goto convert_statfs64;
 #endif
-#ifdef TARGET_NR_ioperm
-    case TARGET_NR_ioperm:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR_socketcall
     case TARGET_NR_socketcall:
         return do_socketcall(arg1, arg2);
@@ -9880,20 +9806,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
-#ifdef TARGET_NR_olduname
-    case TARGET_NR_olduname:
-        goto unimplemented;
-#endif
-#ifdef TARGET_NR_iopl
-    case TARGET_NR_iopl:
-        goto unimplemented;
-#endif
     case TARGET_NR_vhangup:
         return get_errno(vhangup());
-#ifdef TARGET_NR_idle
-    case TARGET_NR_idle:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR_syscall
     case TARGET_NR_syscall:
         return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
@@ -10069,8 +9983,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_modify_ldt:
         return do_modify_ldt(cpu_env, arg1, arg2, arg3);
 #if !defined(TARGET_X86_64)
-    case TARGET_NR_vm86old:
-        goto unimplemented;
     case TARGET_NR_vm86:
         return do_vm86(cpu_env, arg1, arg2);
 #endif
@@ -10107,35 +10019,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
-#ifdef TARGET_NR_create_module
-    case TARGET_NR_create_module:
-#endif
-    case TARGET_NR_init_module:
-    case TARGET_NR_delete_module:
-#ifdef TARGET_NR_get_kernel_syms
-    case TARGET_NR_get_kernel_syms:
-#endif
-        goto unimplemented;
-    case TARGET_NR_quotactl:
-        goto unimplemented;
     case TARGET_NR_getpgid:
         return get_errno(getpgid(arg1));
     case TARGET_NR_fchdir:
         return get_errno(fchdir(arg1));
-#ifdef TARGET_NR_bdflush /* not on x86_64 */
-    case TARGET_NR_bdflush:
-        goto unimplemented;
-#endif
-#ifdef TARGET_NR_sysfs
-    case TARGET_NR_sysfs:
-        goto unimplemented;
-#endif
     case TARGET_NR_personality:
         return get_errno(personality(arg1));
-#ifdef TARGET_NR_afs_syscall
-    case TARGET_NR_afs_syscall:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR__llseek /* Not on alpha */
     case TARGET_NR__llseek:
         {
@@ -10648,14 +10537,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
-#ifdef TARGET_NR_query_module
-    case TARGET_NR_query_module:
-        goto unimplemented;
-#endif
-#ifdef TARGET_NR_nfsservctl
-    case TARGET_NR_nfsservctl:
-        goto unimplemented;
-#endif
     case TARGET_NR_prctl:
         switch (arg1) {
         case PR_GET_PDEATHSIG:
@@ -10734,7 +10615,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_I386) && !defined(TARGET_ABI32)
         return do_arch_prctl(cpu_env, arg1, arg2);
 #else
-        goto unimplemented;
+#error unreachable
 #endif
 #endif
 #ifdef TARGET_NR_pread64
@@ -10882,21 +10763,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
-#else
-    case TARGET_NR_sendfile:
-#ifdef TARGET_NR_sendfile64
-    case TARGET_NR_sendfile64:
-#endif
-        goto unimplemented;
-#endif
-
-#ifdef TARGET_NR_getpmsg
-    case TARGET_NR_getpmsg:
-        goto unimplemented;
-#endif
-#ifdef TARGET_NR_putpmsg
-    case TARGET_NR_putpmsg:
-        goto unimplemented;
 #endif
 #ifdef TARGET_NR_vfork
     case TARGET_NR_vfork:
@@ -11439,9 +11305,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_setfsgid32:
         return get_errno(setfsgid(arg1));
 #endif
-
-    case TARGET_NR_pivot_root:
-        goto unimplemented;
 #ifdef TARGET_NR_mincore
     case TARGET_NR_mincore:
         {
@@ -11599,10 +11462,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         /* self-modifying code is handled automatically, so nothing needed */
         return 0;
 #endif
-#ifdef TARGET_NR_security
-    case TARGET_NR_security:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR_getpagesize
     case TARGET_NR_getpagesize:
         return TARGET_PAGE_SIZE;
@@ -12562,7 +12421,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 
     default:
-    unimplemented:
         gemu_log("qemu: Unsupported syscall: %d\n", num);
         return -TARGET_ENOSYS;
     }
-- 
2.17.1
