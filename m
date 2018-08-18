Received: from eggs.gnu.org ([2001:4830:134:3::10]:55210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Tc-0005Gh-9x
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Ta-0007AG-UI
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:32 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6Ta-00079b-LY
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:30 -0400
Received: by mail-pf1-x443.google.com with SMTP id y10-v6so4879838pfn.8
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:08 -0700
Message-Id: <20180818190118.12911-7-richard.henderson@linaro.org>
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
References: <20180818190118.12911-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 06/16] linux-user: Propagate goto
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
Cc: laurent@vivier.eu

There is no point in listing a syscall if you want the same effect as
not listing it.  In one less trivial case, the goto was demonstrably
not reachable.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 144 +------------------------------------------
 1 file changed, 1 insertion(+), 143 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 812fb27fa1..ef3b9b623c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8341,14 +8341,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg1, 0);
         return ret;
 #endif
-#ifdef TARGET_NR_break
-    case TARGET_NR_break:
-        goto unimplemented;
-#endif
-#ifdef TARGET_NR_oldstat
-    case TARGET_NR_oldstat:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR_lseek
     case TARGET_NR_lseek:
         return get_errno(lseek(arg1, arg2, arg3));
@@ -8435,16 +8427,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8515,14 +8501,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8544,10 +8522,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8661,14 +8635,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8687,31 +8653,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8720,10 +8670,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9432,10 +9378,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9489,10 +9431,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9514,10 +9452,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9638,10 +9572,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_setpriority:
         return get_errno(setpriority(arg1, arg2, arg3));
-#ifdef TARGET_NR_profil
-    case TARGET_NR_profil:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR_statfs
     case TARGET_NR_statfs:
         if (!(p = lock_user_string(arg1))) {
@@ -9713,10 +9643,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9935,21 +9861,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
-#endif
-#ifdef TARGET_NR_olduname
-    case TARGET_NR_olduname:
-        goto unimplemented;
-#endif
-#ifdef TARGET_NR_iopl
-    case TARGET_NR_iopl:
-        goto unimplemented;
 #endif
     case TARGET_NR_vhangup:
         return get_errno(vhangup());
-#ifdef TARGET_NR_idle
-    case TARGET_NR_idle:
-        goto unimplemented;
-#endif
 #ifdef TARGET_NR_syscall
     case TARGET_NR_syscall:
         return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
@@ -10122,8 +10036,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_modify_ldt:
         return do_modify_ldt(cpu_env, arg1, arg2, arg3);
 #if !defined(TARGET_X86_64)
-    case TARGET_NR_vm86old:
-        goto unimplemented;
     case TARGET_NR_vm86:
         return do_vm86(cpu_env, arg1, arg2);
 #endif
@@ -10160,35 +10072,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10702,14 +10591,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10795,7 +10676,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_I386) && !defined(TARGET_ABI32)
         return do_arch_prctl(cpu_env, arg1, arg2);
 #else
-        goto unimplemented;
+#error unreachable
 #endif
 #endif
 #ifdef TARGET_NR_pread64
@@ -10945,21 +10826,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11502,9 +11368,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_setfsgid32:
         return get_errno(setfsgid(arg1));
 #endif
-
-    case TARGET_NR_pivot_root:
-        goto unimplemented;
 #ifdef TARGET_NR_mincore
     case TARGET_NR_mincore:
         {
@@ -11662,10 +11525,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12631,7 +12490,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 
     default:
-    unimplemented:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         return -TARGET_ENOSYS;
     }
-- 
2.17.1
