Received: from eggs.gnu.org ([2001:4830:134:3::10]:55235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Td-0005Gk-LJ
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6TX-00077S-Oj
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:33 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6TX-00076y-A5
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:27 -0400
Received: by mail-pf1-x442.google.com with SMTP id e13-v6so4885016pff.7
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:05 -0700
Message-Id: <20180818190118.12911-4-richard.henderson@linaro.org>
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
References: <20180818190118.12911-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 03/16] linux-user: Relax single exit from
 "break"
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

Transform outermost "break" to "return ret".  If the immediately
preceeding statement was an assignment to ret, return the value
directly.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 972 +++++++++++++++++--------------------------
 1 file changed, 390 insertions(+), 582 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dddd386ec4..f92a24f32a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8017,8 +8017,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
            Do thread termination if we have more then one thread.  */
 
         if (block_signals()) {
-            ret = -TARGET_ERESTARTSYS;
-            break;
+            return -TARGET_ERESTARTSYS;
         }
 
         cpu_list_lock();
@@ -8047,12 +8046,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         cpu_list_unlock();
         preexit_cleanup(cpu_env, arg1);
         _exit(arg1);
-        ret = 0; /* avoid warning */
-        break;
+        return 0; /* avoid warning */
     case TARGET_NR_read:
-        if (arg3 == 0)
-            ret = 0;
-        else {
+        if (arg3 == 0) {
+            return 0;
+        } else {
             if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
                 goto efault;
             ret = get_errno(safe_read(arg1, p, arg3));
@@ -8062,7 +8060,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
             unlock_user(p, arg2, ret);
         }
-        break;
+        return ret;
     case TARGET_NR_write:
         if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
             goto efault;
@@ -8078,7 +8076,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(safe_write(arg1, p, arg3));
         }
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
+
 #ifdef TARGET_NR_open
     case TARGET_NR_open:
         if (!(p = lock_user_string(arg1)))
@@ -8088,7 +8087,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                   arg3));
         fd_trans_unregister(ret);
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
     case TARGET_NR_openat:
         if (!(p = lock_user_string(arg2)))
@@ -8098,29 +8097,27 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                   arg4));
         fd_trans_unregister(ret);
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_open_by_handle_at:
         ret = do_open_by_handle_at(arg1, arg2, arg3);
         fd_trans_unregister(ret);
-        break;
+        return ret;
 #endif
     case TARGET_NR_close:
         fd_trans_unregister(arg1);
-        ret = get_errno(close(arg1));
-        break;
+        return get_errno(close(arg1));
+
     case TARGET_NR_brk:
-        ret = do_brk(arg1);
-        break;
+        return do_brk(arg1);
 #ifdef TARGET_NR_fork
     case TARGET_NR_fork:
-        ret = get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
-        break;
+        return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
 #endif
 #ifdef TARGET_NR_waitpid
     case TARGET_NR_waitpid:
@@ -8131,7 +8128,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 && put_user_s32(host_to_target_waitstatus(status), arg2))
                 goto efault;
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_waitid
     case TARGET_NR_waitid:
@@ -8146,7 +8143,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(p, arg3, sizeof(target_siginfo_t));
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_creat /* not on alpha */
     case TARGET_NR_creat:
@@ -8155,7 +8152,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(creat(p, arg2));
         fd_trans_unregister(ret);
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_link
     case TARGET_NR_link:
@@ -8170,7 +8167,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg2, 0);
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_linkat)
     case TARGET_NR_linkat:
@@ -8187,7 +8184,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p, arg2, 0);
             unlock_user(p2, arg4, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_unlink
     case TARGET_NR_unlink:
@@ -8195,7 +8192,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(unlink(p));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_unlinkat)
     case TARGET_NR_unlinkat:
@@ -8203,7 +8200,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(unlinkat(arg1, p, arg3));
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
 #endif
     case TARGET_NR_execve:
         {
@@ -8301,13 +8298,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             g_free(argp);
             g_free(envp);
         }
-        break;
+        return ret;
     case TARGET_NR_chdir:
         if (!(p = lock_user_string(arg1)))
             goto efault;
         ret = get_errno(chdir(p));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #ifdef TARGET_NR_time
     case TARGET_NR_time:
         {
@@ -8318,7 +8315,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 && put_user_sal(host_time, arg1))
                 goto efault;
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_mknod
     case TARGET_NR_mknod:
@@ -8326,7 +8323,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(mknod(p, arg2, arg3));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_mknodat)
     case TARGET_NR_mknodat:
@@ -8334,7 +8331,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(mknodat(arg1, p, arg3, arg4));
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_chmod
     case TARGET_NR_chmod:
@@ -8342,7 +8339,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(chmod(p, arg2));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_break
     case TARGET_NR_break:
@@ -8354,20 +8351,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_lseek
     case TARGET_NR_lseek:
-        ret = get_errno(lseek(arg1, arg2, arg3));
-        break;
+        return get_errno(lseek(arg1, arg2, arg3));
 #endif
 #if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
     /* Alpha specific */
     case TARGET_NR_getxpid:
         ((CPUAlphaState *)cpu_env)->ir[IR_A4] = getppid();
-        ret = get_errno(getpid());
-        break;
+        return get_errno(getpid());
 #endif
 #ifdef TARGET_NR_getpid
     case TARGET_NR_getpid:
-        ret = get_errno(getpid());
-        break;
+        return get_errno(getpid());
 #endif
     case TARGET_NR_mount:
         {
@@ -8423,14 +8417,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(p3, arg3, 0);
             }
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_umount
     case TARGET_NR_umount:
         if (!(p = lock_user_string(arg1)))
             goto efault;
         ret = get_errno(umount(p));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_stime /* not on alpha */
     case TARGET_NR_stime:
@@ -8438,16 +8432,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             time_t host_time;
             if (get_user_sal(host_time, arg1))
                 goto efault;
-            ret = get_errno(stime(&host_time));
+            return get_errno(stime(&host_time));
         }
-        break;
 #endif
     case TARGET_NR_ptrace:
         goto unimplemented;
 #ifdef TARGET_NR_alarm /* not on alpha */
     case TARGET_NR_alarm:
-        ret = alarm(arg1);
-        break;
+        return alarm(arg1);
 #endif
 #ifdef TARGET_NR_oldfstat
     case TARGET_NR_oldfstat:
@@ -8458,8 +8450,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (!block_signals()) {
             sigsuspend(&((TaskState *)cpu->opaque)->signal_mask);
         }
-        ret = -TARGET_EINTR;
-        break;
+        return -TARGET_EINTR;
 #endif
 #ifdef TARGET_NR_utime
     case TARGET_NR_utime:
@@ -8481,7 +8472,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(utime(p, host_tbuf));
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_utimes
     case TARGET_NR_utimes:
@@ -8501,7 +8492,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(utimes(p, tvp));
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_futimesat)
     case TARGET_NR_futimesat:
@@ -8521,7 +8512,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(futimesat(arg1, path(p), tvp));
             unlock_user(p, arg2, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_stty
     case TARGET_NR_stty:
@@ -8537,7 +8528,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(access(path(p), arg2));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_faccessat) && defined(__NR_faccessat)
     case TARGET_NR_faccessat:
@@ -8545,12 +8536,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(faccessat(arg1, p, arg3, 0));
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_nice /* not on alpha */
     case TARGET_NR_nice:
-        ret = get_errno(nice(arg1));
-        break;
+        return get_errno(nice(arg1));
 #endif
 #ifdef TARGET_NR_ftime
     case TARGET_NR_ftime:
@@ -8558,16 +8548,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
     case TARGET_NR_sync:
         sync();
-        ret = 0;
-        break;
+        return 0;
 #if defined(TARGET_NR_syncfs) && defined(CONFIG_SYNCFS)
     case TARGET_NR_syncfs:
-        ret = get_errno(syncfs(arg1));
-        break;
+        return get_errno(syncfs(arg1));
 #endif
     case TARGET_NR_kill:
-        ret = get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
-        break;
+        return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
 #ifdef TARGET_NR_rename
     case TARGET_NR_rename:
         {
@@ -8581,7 +8568,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg2, 0);
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_renameat)
     case TARGET_NR_renameat:
@@ -8596,7 +8583,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg4, 0);
             unlock_user(p, arg2, 0);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_renameat2)
     case TARGET_NR_renameat2:
@@ -8612,7 +8599,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg4, 0);
             unlock_user(p, arg2, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_mkdir
     case TARGET_NR_mkdir:
@@ -8620,7 +8607,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(mkdir(p, arg2));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_mkdirat)
     case TARGET_NR_mkdirat:
@@ -8628,7 +8615,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(mkdirat(arg1, p, arg3));
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_rmdir
     case TARGET_NR_rmdir:
@@ -8636,24 +8623,22 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(rmdir(p));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
     case TARGET_NR_dup:
         ret = get_errno(dup(arg1));
         if (ret >= 0) {
             fd_trans_dup(arg1, ret);
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_pipe
     case TARGET_NR_pipe:
-        ret = do_pipe(cpu_env, arg1, 0, 0);
-        break;
+        return do_pipe(cpu_env, arg1, 0, 0);
 #endif
 #ifdef TARGET_NR_pipe2
     case TARGET_NR_pipe2:
-        ret = do_pipe(cpu_env, arg1,
-                      target_to_host_bitmask(arg2, fcntl_flags_tbl), 1);
-        break;
+        return do_pipe(cpu_env, arg1,
+                       target_to_host_bitmask(arg2, fcntl_flags_tbl), 1);
 #endif
     case TARGET_NR_times:
         {
@@ -8672,7 +8657,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (!is_error(ret))
                 ret = host_to_target_clock_t(ret);
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_prof
     case TARGET_NR_prof:
         goto unimplemented;
@@ -8690,34 +8675,31 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(acct(path(p)));
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_umount2
     case TARGET_NR_umount2:
         if (!(p = lock_user_string(arg1)))
             goto efault;
         ret = get_errno(umount2(p, arg2));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_lock
     case TARGET_NR_lock:
         goto unimplemented;
 #endif
     case TARGET_NR_ioctl:
-        ret = do_ioctl(arg1, arg2, arg3);
-        break;
+        return do_ioctl(arg1, arg2, arg3);
 #ifdef TARGET_NR_fcntl
     case TARGET_NR_fcntl:
-        ret = do_fcntl(arg1, arg2, arg3);
-        break;
+        return do_fcntl(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_mpx
     case TARGET_NR_mpx:
         goto unimplemented;
 #endif
     case TARGET_NR_setpgid:
-        ret = get_errno(setpgid(arg1, arg2));
-        break;
+        return get_errno(setpgid(arg1, arg2));
 #ifdef TARGET_NR_ulimit
     case TARGET_NR_ulimit:
         goto unimplemented;
@@ -8727,14 +8709,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         goto unimplemented;
 #endif
     case TARGET_NR_umask:
-        ret = get_errno(umask(arg1));
-        break;
+        return get_errno(umask(arg1));
     case TARGET_NR_chroot:
         if (!(p = lock_user_string(arg1)))
             goto efault;
         ret = get_errno(chroot(p));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #ifdef TARGET_NR_ustat
     case TARGET_NR_ustat:
         goto unimplemented;
@@ -8745,7 +8726,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (ret >= 0) {
             fd_trans_dup(arg1, arg2);
         }
-        break;
+        return ret;
 #endif
 #if defined(CONFIG_DUP3) && defined(TARGET_NR_dup3)
     case TARGET_NR_dup3:
@@ -8760,22 +8741,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (ret >= 0) {
             fd_trans_dup(arg1, arg2);
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_getppid /* not on alpha */
     case TARGET_NR_getppid:
-        ret = get_errno(getppid());
-        break;
+        return get_errno(getppid());
 #endif
 #ifdef TARGET_NR_getpgrp
     case TARGET_NR_getpgrp:
-        ret = get_errno(getpgrp());
-        break;
+        return get_errno(getpgrp());
 #endif
     case TARGET_NR_setsid:
-        ret = get_errno(setsid());
-        break;
+        return get_errno(setsid());
 #ifdef TARGET_NR_sigaction
     case TARGET_NR_sigaction:
         {
@@ -8859,7 +8837,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
 #endif
         }
-        break;
+        return ret;
 #endif
     case TARGET_NR_rt_sigaction:
         {
@@ -8876,8 +8854,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct target_sigaction act, oact, *pact = 0;
 
             if (arg4 != sizeof(target_sigset_t)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
             if (arg2) {
                 if (!lock_user_struct(VERIFY_READ, rt_act, arg2, 1))
@@ -8909,8 +8886,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct target_sigaction *oact;
 
             if (sigsetsize != sizeof(target_sigset_t)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
             if (arg2) {
                 if (!lock_user_struct(VERIFY_READ, act, arg2, 1)) {
@@ -8937,7 +8913,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user_struct(oact, arg3, 1);
 #endif
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_sgetmask /* not on alpha */
     case TARGET_NR_sgetmask:
         {
@@ -8949,7 +8925,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = target_set;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_ssetmask /* not on alpha */
     case TARGET_NR_ssetmask:
@@ -8963,7 +8939,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = target_set;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_sigprocmask
     case TARGET_NR_sigprocmask:
@@ -9033,7 +9009,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
 #endif
         }
-        break;
+        return ret;
 #endif
     case TARGET_NR_rt_sigprocmask:
         {
@@ -9041,8 +9017,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             sigset_t set, oldset, *set_ptr;
 
             if (arg4 != sizeof(target_sigset_t)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
 
             if (arg2) {
@@ -9077,7 +9052,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(p, arg3, sizeof(target_sigset_t));
             }
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_sigpending
     case TARGET_NR_sigpending:
         {
@@ -9090,7 +9065,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(p, arg1, sizeof(target_sigset_t));
             }
         }
-        break;
+        return ret;
 #endif
     case TARGET_NR_rt_sigpending:
         {
@@ -9102,8 +9077,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              * the old_sigset_t is smaller in size.
              */
             if (arg2 > sizeof(target_sigset_t)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
 
             ret = get_errno(sigpending(&set));
@@ -9114,7 +9088,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(p, arg1, sizeof(target_sigset_t));
             }
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_sigsuspend
     case TARGET_NR_sigsuspend:
         {
@@ -9134,15 +9108,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ts->in_sigsuspend = 1;
             }
         }
-        break;
+        return ret;
 #endif
     case TARGET_NR_rt_sigsuspend:
         {
             TaskState *ts = cpu->opaque;
 
             if (arg2 != sizeof(target_sigset_t)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
             if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
                 goto efault;
@@ -9154,7 +9127,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ts->in_sigsuspend = 1;
             }
         }
-        break;
+        return ret;
     case TARGET_NR_rt_sigtimedwait:
         {
             sigset_t set;
@@ -9162,8 +9135,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             siginfo_t uinfo;
 
             if (arg4 != sizeof(target_sigset_t)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
 
             if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
@@ -9191,7 +9163,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = host_to_target_signal(ret);
             }
         }
-        break;
+        return ret;
     case TARGET_NR_rt_sigqueueinfo:
         {
             siginfo_t uinfo;
@@ -9204,7 +9176,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p, arg3, 0);
             ret = get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
         }
-        break;
+        return ret;
     case TARGET_NR_rt_tgsigqueueinfo:
         {
             siginfo_t uinfo;
@@ -9217,29 +9189,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p, arg4, 0);
             ret = get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, arg3, &uinfo));
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_sigreturn
     case TARGET_NR_sigreturn:
         if (block_signals()) {
-            ret = -TARGET_ERESTARTSYS;
-        } else {
-            ret = do_sigreturn(cpu_env);
+            return -TARGET_ERESTARTSYS;
         }
-        break;
+        return do_sigreturn(cpu_env);
 #endif
     case TARGET_NR_rt_sigreturn:
         if (block_signals()) {
-            ret = -TARGET_ERESTARTSYS;
-        } else {
-            ret = do_rt_sigreturn(cpu_env);
+            return -TARGET_ERESTARTSYS;
         }
-        break;
+        return do_rt_sigreturn(cpu_env);
     case TARGET_NR_sethostname:
         if (!(p = lock_user_string(arg1)))
             goto efault;
         ret = get_errno(sethostname(p, arg2));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #ifdef TARGET_NR_setrlimit
     case TARGET_NR_setrlimit:
         {
@@ -9251,9 +9219,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             rlim.rlim_cur = target_to_host_rlim(target_rlim->rlim_cur);
             rlim.rlim_max = target_to_host_rlim(target_rlim->rlim_max);
             unlock_user_struct(target_rlim, arg2, 0);
-            ret = get_errno(setrlimit(resource, &rlim));
+            return get_errno(setrlimit(resource, &rlim));
         }
-        break;
 #endif
 #ifdef TARGET_NR_getrlimit
     case TARGET_NR_getrlimit:
@@ -9271,7 +9238,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user_struct(target_rlim, arg2, 1);
             }
         }
-        break;
+        return ret;
 #endif
     case TARGET_NR_getrusage:
         {
@@ -9281,7 +9248,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = host_to_target_rusage(arg2, &rusage);
             }
         }
-        break;
+        return ret;
     case TARGET_NR_gettimeofday:
         {
             struct timeval tv;
@@ -9291,7 +9258,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
     case TARGET_NR_settimeofday:
         {
             struct timeval tv, *ptv = NULL;
@@ -9311,9 +9278,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ptz = &tz;
             }
 
-            ret = get_errno(settimeofday(ptv, ptz));
+            return get_errno(settimeofday(ptv, ptz));
         }
-        break;
 #if defined(TARGET_NR_select)
     case TARGET_NR_select:
 #if defined(TARGET_WANT_NI_OLD_SELECT)
@@ -9326,7 +9292,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
         ret = do_select(arg1, arg2, arg3, arg4, arg5);
 #endif
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_pselect6
     case TARGET_NR_pselect6:
@@ -9430,7 +9396,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_symlink
     case TARGET_NR_symlink:
@@ -9445,7 +9411,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg2, 0);
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_symlinkat)
     case TARGET_NR_symlinkat:
@@ -9460,7 +9426,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg3, 0);
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_oldlstat
     case TARGET_NR_oldlstat:
@@ -9496,7 +9462,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg2, ret);
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_readlinkat)
     case TARGET_NR_readlinkat:
@@ -9517,7 +9483,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg3, ret);
             unlock_user(p, arg2, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_uselib
     case TARGET_NR_uselib:
@@ -9529,7 +9495,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(swapon(p, arg2));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
     case TARGET_NR_reboot:
         if (arg3 == LINUX_REBOOT_CMD_RESTART2) {
@@ -9543,7 +9509,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         } else {
            ret = get_errno(reboot(arg1, arg2, arg3, NULL));
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_readdir
     case TARGET_NR_readdir:
         goto unimplemented;
@@ -9576,22 +9542,20 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                     arg5,
                                     arg6));
 #endif
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_mmap2
     case TARGET_NR_mmap2:
 #ifndef MMAP_SHIFT
 #define MMAP_SHIFT 12
 #endif
-        ret = get_errno(target_mmap(arg1, arg2, arg3,
-                                    target_to_host_bitmask(arg4, mmap_flags_tbl),
-                                    arg5,
-                                    arg6 << MMAP_SHIFT));
-        break;
+        ret = target_mmap(arg1, arg2, arg3,
+                          target_to_host_bitmask(arg4, mmap_flags_tbl),
+                          arg5, arg6 << MMAP_SHIFT);
+        return get_errno(ret);
 #endif
     case TARGET_NR_munmap:
-        ret = get_errno(target_munmap(arg1, arg2));
-        break;
+        return get_errno(target_munmap(arg1, arg2));
     case TARGET_NR_mprotect:
         {
             TaskState *ts = cpu->opaque;
@@ -9604,38 +9568,31 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 arg1 = ts->info->stack_limit;
             }
         }
-        ret = get_errno(target_mprotect(arg1, arg2, arg3));
-        break;
+        return get_errno(target_mprotect(arg1, arg2, arg3));
 #ifdef TARGET_NR_mremap
     case TARGET_NR_mremap:
-        ret = get_errno(target_mremap(arg1, arg2, arg3, arg4, arg5));
-        break;
+        return get_errno(target_mremap(arg1, arg2, arg3, arg4, arg5));
 #endif
         /* ??? msync/mlock/munlock are broken for softmmu.  */
 #ifdef TARGET_NR_msync
     case TARGET_NR_msync:
-        ret = get_errno(msync(g2h(arg1), arg2, arg3));
-        break;
+        return get_errno(msync(g2h(arg1), arg2, arg3));
 #endif
 #ifdef TARGET_NR_mlock
     case TARGET_NR_mlock:
-        ret = get_errno(mlock(g2h(arg1), arg2));
-        break;
+        return get_errno(mlock(g2h(arg1), arg2));
 #endif
 #ifdef TARGET_NR_munlock
     case TARGET_NR_munlock:
-        ret = get_errno(munlock(g2h(arg1), arg2));
-        break;
+        return get_errno(munlock(g2h(arg1), arg2));
 #endif
 #ifdef TARGET_NR_mlockall
     case TARGET_NR_mlockall:
-        ret = get_errno(mlockall(target_to_host_mlockall_arg(arg1)));
-        break;
+        return get_errno(mlockall(target_to_host_mlockall_arg(arg1)));
 #endif
 #ifdef TARGET_NR_munlockall
     case TARGET_NR_munlockall:
-        ret = get_errno(munlockall());
-        break;
+        return get_errno(munlockall());
 #endif
 #ifdef TARGET_NR_truncate
     case TARGET_NR_truncate:
@@ -9643,23 +9600,21 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(truncate(p, arg2));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_ftruncate
     case TARGET_NR_ftruncate:
-        ret = get_errno(ftruncate(arg1, arg2));
-        break;
+        return get_errno(ftruncate(arg1, arg2));
 #endif
     case TARGET_NR_fchmod:
-        ret = get_errno(fchmod(arg1, arg2));
-        break;
+        return get_errno(fchmod(arg1, arg2));
 #if defined(TARGET_NR_fchmodat)
     case TARGET_NR_fchmodat:
         if (!(p = lock_user_string(arg2)))
             goto efault;
         ret = get_errno(fchmodat(arg1, p, arg3, 0));
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
 #endif
     case TARGET_NR_getpriority:
         /* Note that negative values are valid for getpriority, so we must
@@ -9667,8 +9622,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         errno = 0;
         ret = getpriority(arg1, arg2);
         if (ret == -1 && errno != 0) {
-            ret = -host_to_target_errno(errno);
-            break;
+            return -host_to_target_errno(errno);
         }
 #ifdef TARGET_ALPHA
         /* Return value is the unbiased priority.  Signal no error.  */
@@ -9677,10 +9631,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         /* Return value is a biased priority to avoid negative numbers.  */
         ret = 20 - ret;
 #endif
-        break;
+        return ret;
     case TARGET_NR_setpriority:
-        ret = get_errno(setpriority(arg1, arg2, arg3));
-        break;
+        return get_errno(setpriority(arg1, arg2, arg3));
 #ifdef TARGET_NR_profil
     case TARGET_NR_profil:
         goto unimplemented;
@@ -9716,7 +9669,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
             unlock_user_struct(target_stfs, arg2, 1);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_fstatfs
     case TARGET_NR_fstatfs:
@@ -9749,7 +9702,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
             unlock_user_struct(target_stfs, arg3, 1);
         }
-        break;
+        return ret;
     case TARGET_NR_fstatfs64:
         ret = get_errno(fstatfs(arg1, &stfs));
         goto convert_statfs64;
@@ -9760,91 +9713,73 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_socketcall
     case TARGET_NR_socketcall:
-        ret = do_socketcall(arg1, arg2);
-        break;
+        return do_socketcall(arg1, arg2);
 #endif
 #ifdef TARGET_NR_accept
     case TARGET_NR_accept:
-        ret = do_accept4(arg1, arg2, arg3, 0);
-        break;
+        return do_accept4(arg1, arg2, arg3, 0);
 #endif
 #ifdef TARGET_NR_accept4
     case TARGET_NR_accept4:
-        ret = do_accept4(arg1, arg2, arg3, arg4);
-        break;
+        return do_accept4(arg1, arg2, arg3, arg4);
 #endif
 #ifdef TARGET_NR_bind
     case TARGET_NR_bind:
-        ret = do_bind(arg1, arg2, arg3);
-        break;
+        return do_bind(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_connect
     case TARGET_NR_connect:
-        ret = do_connect(arg1, arg2, arg3);
-        break;
+        return do_connect(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_getpeername
     case TARGET_NR_getpeername:
-        ret = do_getpeername(arg1, arg2, arg3);
-        break;
+        return do_getpeername(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_getsockname
     case TARGET_NR_getsockname:
-        ret = do_getsockname(arg1, arg2, arg3);
-        break;
+        return do_getsockname(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_getsockopt
     case TARGET_NR_getsockopt:
-        ret = do_getsockopt(arg1, arg2, arg3, arg4, arg5);
-        break;
+        return do_getsockopt(arg1, arg2, arg3, arg4, arg5);
 #endif
 #ifdef TARGET_NR_listen
     case TARGET_NR_listen:
-        ret = get_errno(listen(arg1, arg2));
-        break;
+        return get_errno(listen(arg1, arg2));
 #endif
 #ifdef TARGET_NR_recv
     case TARGET_NR_recv:
-        ret = do_recvfrom(arg1, arg2, arg3, arg4, 0, 0);
-        break;
+        return do_recvfrom(arg1, arg2, arg3, arg4, 0, 0);
 #endif
 #ifdef TARGET_NR_recvfrom
     case TARGET_NR_recvfrom:
-        ret = do_recvfrom(arg1, arg2, arg3, arg4, arg5, arg6);
-        break;
+        return do_recvfrom(arg1, arg2, arg3, arg4, arg5, arg6);
 #endif
 #ifdef TARGET_NR_recvmsg
     case TARGET_NR_recvmsg:
-        ret = do_sendrecvmsg(arg1, arg2, arg3, 0);
-        break;
+        return do_sendrecvmsg(arg1, arg2, arg3, 0);
 #endif
 #ifdef TARGET_NR_send
     case TARGET_NR_send:
-        ret = do_sendto(arg1, arg2, arg3, arg4, 0, 0);
-        break;
+        return do_sendto(arg1, arg2, arg3, arg4, 0, 0);
 #endif
 #ifdef TARGET_NR_sendmsg
     case TARGET_NR_sendmsg:
-        ret = do_sendrecvmsg(arg1, arg2, arg3, 1);
-        break;
+        return do_sendrecvmsg(arg1, arg2, arg3, 1);
 #endif
 #ifdef TARGET_NR_sendmmsg
     case TARGET_NR_sendmmsg:
-        ret = do_sendrecvmmsg(arg1, arg2, arg3, arg4, 1);
-        break;
+        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 1);
     case TARGET_NR_recvmmsg:
-        ret = do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0);
-        break;
+        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0);
 #endif
 #ifdef TARGET_NR_sendto
     case TARGET_NR_sendto:
-        ret = do_sendto(arg1, arg2, arg3, arg4, arg5, arg6);
-        break;
+        return do_sendto(arg1, arg2, arg3, arg4, arg5, arg6);
 #endif
 #ifdef TARGET_NR_shutdown
     case TARGET_NR_shutdown:
-        ret = get_errno(shutdown(arg1, arg2));
-        break;
+        return get_errno(shutdown(arg1, arg2));
 #endif
 #if defined(TARGET_NR_getrandom) && defined(__NR_getrandom)
     case TARGET_NR_getrandom:
@@ -9854,22 +9789,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         ret = get_errno(getrandom(p, arg2, arg3));
         unlock_user(p, arg1, ret);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_socket
     case TARGET_NR_socket:
-        ret = do_socket(arg1, arg2, arg3);
-        break;
+        return do_socket(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_socketpair
     case TARGET_NR_socketpair:
-        ret = do_socketpair(arg1, arg2, arg3, arg4);
-        break;
+        return do_socketpair(arg1, arg2, arg3, arg4);
 #endif
 #ifdef TARGET_NR_setsockopt
     case TARGET_NR_setsockopt:
-        ret = do_setsockopt(arg1, arg2, arg3, arg4, (socklen_t) arg5);
-        break;
+        return do_setsockopt(arg1, arg2, arg3, arg4, (socklen_t) arg5);
 #endif
 #if defined(TARGET_NR_syslog)
     case TARGET_NR_syslog:
@@ -9885,10 +9817,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             case TARGET_SYSLOG_ACTION_CONSOLE_LEVEL: /* Set messages level */
             case TARGET_SYSLOG_ACTION_SIZE_UNREAD:   /* Number of chars */
             case TARGET_SYSLOG_ACTION_SIZE_BUFFER:   /* Size of the buffer */
-                {
-                    ret = get_errno(sys_syslog((int)arg1, NULL, (int)arg3));
-                }
-                break;
+                return get_errno(sys_syslog((int)arg1, NULL, (int)arg3));
             case TARGET_SYSLOG_ACTION_READ:          /* Read from log */
             case TARGET_SYSLOG_ACTION_READ_CLEAR:    /* Read/clear msgs */
             case TARGET_SYSLOG_ACTION_READ_ALL:      /* Read last messages */
@@ -9897,9 +9826,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     if (len < 0) {
                         goto fail;
                     }
-                    ret = 0;
                     if (len == 0) {
-                        break;
+                        return 0;
                     }
                     p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
                     if (!p) {
@@ -9909,10 +9837,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     ret = get_errno(sys_syslog((int)arg1, p, (int)arg3));
                     unlock_user(p, arg2, arg3);
                 }
-                break;
+                return ret;
             default:
-                ret = -EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
         }
         break;
@@ -9939,7 +9866,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
     case TARGET_NR_getitimer:
         {
             struct itimerval value;
@@ -9953,7 +9880,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_stat
     case TARGET_NR_stat:
         if (!(p = lock_user_string(arg1)))
@@ -9999,7 +9926,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user_struct(target_st, arg2, 1);
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_olduname
     case TARGET_NR_olduname:
@@ -10010,17 +9937,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         goto unimplemented;
 #endif
     case TARGET_NR_vhangup:
-        ret = get_errno(vhangup());
-        break;
+        return get_errno(vhangup());
 #ifdef TARGET_NR_idle
     case TARGET_NR_idle:
         goto unimplemented;
 #endif
 #ifdef TARGET_NR_syscall
     case TARGET_NR_syscall:
-        ret = do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
-                         arg6, arg7, arg8, 0);
-        break;
+        return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
+                          arg6, arg7, arg8, 0);
 #endif
     case TARGET_NR_wait4:
         {
@@ -10048,14 +9973,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_swapoff
     case TARGET_NR_swapoff:
         if (!(p = lock_user_string(arg1)))
             goto efault;
         ret = get_errno(swapoff(p));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
     case TARGET_NR_sysinfo:
         {
@@ -10083,70 +10008,57 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user_struct(target_value, arg1, 1);
             }
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_ipc
     case TARGET_NR_ipc:
-        ret = do_ipc(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
-        break;
+        return do_ipc(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
 #endif
 #ifdef TARGET_NR_semget
     case TARGET_NR_semget:
-        ret = get_errno(semget(arg1, arg2, arg3));
-        break;
+        return get_errno(semget(arg1, arg2, arg3));
 #endif
 #ifdef TARGET_NR_semop
     case TARGET_NR_semop:
-        ret = do_semop(arg1, arg2, arg3);
-        break;
+        return do_semop(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_semctl
     case TARGET_NR_semctl:
-        ret = do_semctl(arg1, arg2, arg3, arg4);
-        break;
+        return do_semctl(arg1, arg2, arg3, arg4);
 #endif
 #ifdef TARGET_NR_msgctl
     case TARGET_NR_msgctl:
-        ret = do_msgctl(arg1, arg2, arg3);
-        break;
+        return do_msgctl(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_msgget
     case TARGET_NR_msgget:
-        ret = get_errno(msgget(arg1, arg2));
-        break;
+        return get_errno(msgget(arg1, arg2));
 #endif
 #ifdef TARGET_NR_msgrcv
     case TARGET_NR_msgrcv:
-        ret = do_msgrcv(arg1, arg2, arg3, arg4, arg5);
-        break;
+        return do_msgrcv(arg1, arg2, arg3, arg4, arg5);
 #endif
 #ifdef TARGET_NR_msgsnd
     case TARGET_NR_msgsnd:
-        ret = do_msgsnd(arg1, arg2, arg3, arg4);
-        break;
+        return do_msgsnd(arg1, arg2, arg3, arg4);
 #endif
 #ifdef TARGET_NR_shmget
     case TARGET_NR_shmget:
-        ret = get_errno(shmget(arg1, arg2, arg3));
-        break;
+        return get_errno(shmget(arg1, arg2, arg3));
 #endif
 #ifdef TARGET_NR_shmctl
     case TARGET_NR_shmctl:
-        ret = do_shmctl(arg1, arg2, arg3);
-        break;
+        return do_shmctl(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_shmat
     case TARGET_NR_shmat:
-        ret = do_shmat(cpu_env, arg1, arg2, arg3);
-        break;
+        return do_shmat(cpu_env, arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_shmdt
     case TARGET_NR_shmdt:
-        ret = do_shmdt(arg1);
-        break;
+        return do_shmdt(arg1);
 #endif
     case TARGET_NR_fsync:
-        ret = get_errno(fsync(arg1));
-        break;
+        return get_errno(fsync(arg1));
     case TARGET_NR_clone:
         /* Linux manages to have three different orderings for its
          * arguments to clone(); the BACKWARDS and BACKWARDS2 defines
@@ -10163,20 +10075,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
         ret = get_errno(do_fork(cpu_env, arg1, arg2, arg3, arg5, arg4));
 #endif
-        break;
+        return ret;
 #ifdef __NR_exit_group
         /* new thread calls */
     case TARGET_NR_exit_group:
         preexit_cleanup(cpu_env, arg1);
-        ret = get_errno(exit_group(arg1));
-        break;
+        return get_errno(exit_group(arg1));
 #endif
     case TARGET_NR_setdomainname:
         if (!(p = lock_user_string(arg1)))
             goto efault;
         ret = get_errno(setdomainname(p, arg2));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
     case TARGET_NR_uname:
         /* no need to transcode because we use the linux syscall */
         {
@@ -10198,17 +10109,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
             unlock_user_struct(buf, arg1, 1);
         }
-        break;
+        return ret;
 #ifdef TARGET_I386
     case TARGET_NR_modify_ldt:
-        ret = do_modify_ldt(cpu_env, arg1, arg2, arg3);
-        break;
+        return do_modify_ldt(cpu_env, arg1, arg2, arg3);
 #if !defined(TARGET_X86_64)
     case TARGET_NR_vm86old:
         goto unimplemented;
     case TARGET_NR_vm86:
-        ret = do_vm86(cpu_env, arg1, arg2);
-        break;
+        return do_vm86(cpu_env, arg1, arg2);
 #endif
 #endif
     case TARGET_NR_adjtimex:
@@ -10225,7 +10134,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
         }
-        break;
+        return ret;
 #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
     case TARGET_NR_clock_adjtime:
         {
@@ -10241,7 +10150,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_create_module
     case TARGET_NR_create_module:
@@ -10255,11 +10164,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_quotactl:
         goto unimplemented;
     case TARGET_NR_getpgid:
-        ret = get_errno(getpgid(arg1));
-        break;
+        return get_errno(getpgid(arg1));
     case TARGET_NR_fchdir:
-        ret = get_errno(fchdir(arg1));
-        break;
+        return get_errno(fchdir(arg1));
 #ifdef TARGET_NR_bdflush /* not on x86_64 */
     case TARGET_NR_bdflush:
         goto unimplemented;
@@ -10269,8 +10176,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         goto unimplemented;
 #endif
     case TARGET_NR_personality:
-        ret = get_errno(personality(arg1));
-        break;
+        return get_errno(personality(arg1));
 #ifdef TARGET_NR_afs_syscall
     case TARGET_NR_afs_syscall:
         goto unimplemented;
@@ -10293,7 +10199,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_getdents
     case TARGET_NR_getdents:
@@ -10425,7 +10331,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(dirp, arg2, ret);
         }
 #endif
-        break;
+        return ret;
 #endif /* TARGET_NR_getdents */
 #if defined(TARGET_NR_getdents64) && defined(__NR_getdents64)
     case TARGET_NR_getdents64:
@@ -10453,12 +10359,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
             unlock_user(dirp, arg2, ret);
         }
-        break;
+        return ret;
 #endif /* TARGET_NR_getdents64 */
 #if defined(TARGET_NR__newselect)
     case TARGET_NR__newselect:
-        ret = do_select(arg1, arg2, arg3, arg4, arg5);
-        break;
+        return do_select(arg1, arg2, arg3, arg4, arg5);
 #endif
 #if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll)
 # ifdef TARGET_NR_poll
@@ -10477,8 +10382,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             target_pfd = NULL;
             if (nfds) {
                 if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
-                    ret = -TARGET_EINVAL;
-                    break;
+                    return -TARGET_EINVAL;
                 }
 
                 target_pfd = lock_user(VERIFY_WRITE, arg1,
@@ -10514,8 +10418,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (arg4) {
                     if (arg5 != sizeof(target_sigset_t)) {
                         unlock_user(target_pfd, arg1, 0);
-                        ret = -TARGET_EINVAL;
-                        break;
+                        return -TARGET_EINVAL;
                     }
 
                     target_set = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
@@ -10569,13 +10472,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
             unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
         }
-        break;
+        return ret;
 #endif
     case TARGET_NR_flock:
         /* NOTE: the flock constant seems to be the same for every
            Linux platform */
-        ret = get_errno(safe_flock(arg1, arg2));
-        break;
+        return get_errno(safe_flock(arg1, arg2));
     case TARGET_NR_readv:
         {
             struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
@@ -10586,7 +10488,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = -host_to_target_errno(errno);
             }
         }
-        break;
+        return ret;
     case TARGET_NR_writev:
         {
             struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
@@ -10597,7 +10499,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = -host_to_target_errno(errno);
             }
         }
-        break;
+        return ret;
 #if defined(TARGET_NR_preadv)
     case TARGET_NR_preadv:
         {
@@ -10612,7 +10514,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = -host_to_target_errno(errno);
            }
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_pwritev)
     case TARGET_NR_pwritev:
@@ -10628,22 +10530,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = -host_to_target_errno(errno);
            }
         }
-        break;
+        return ret;
 #endif
     case TARGET_NR_getsid:
-        ret = get_errno(getsid(arg1));
-        break;
+        return get_errno(getsid(arg1));
 #if defined(TARGET_NR_fdatasync) /* Not on alpha (osf_datasync ?) */
     case TARGET_NR_fdatasync:
-        ret = get_errno(fdatasync(arg1));
-        break;
+        return get_errno(fdatasync(arg1));
 #endif
 #ifdef TARGET_NR__sysctl
     case TARGET_NR__sysctl:
         /* We don't implement this, but ENOTDIR is always a safe
            return value. */
-        ret = -TARGET_ENOTDIR;
-        break;
+        return -TARGET_ENOTDIR;
 #endif
     case TARGET_NR_sched_getaffinity:
         {
@@ -10655,8 +10554,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              * care of mismatches between target ulong and host ulong sizes.
              */
             if (arg2 & (sizeof(abi_ulong) - 1)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
             mask_size = (arg2 + (sizeof(*mask) - 1)) & ~(sizeof(*mask) - 1);
 
@@ -10675,8 +10573,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                      */
                     int numcpus = sysconf(_SC_NPROCESSORS_CONF);
                     if (numcpus > arg2 * 8) {
-                        ret = -TARGET_EINVAL;
-                        break;
+                        return -TARGET_EINVAL;
                     }
                     ret = arg2;
                 }
@@ -10686,7 +10583,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
         }
-        break;
+        return ret;
     case TARGET_NR_sched_setaffinity:
         {
             unsigned int mask_size;
@@ -10697,20 +10594,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              * care of mismatches between target ulong and host ulong sizes.
              */
             if (arg2 & (sizeof(abi_ulong) - 1)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
             mask_size = (arg2 + (sizeof(*mask) - 1)) & ~(sizeof(*mask) - 1);
             mask = alloca(mask_size);
 
             ret = target_to_host_cpu_mask(mask, mask_size, arg3, arg2);
             if (ret) {
-                break;
+                return ret;
             }
 
-            ret = get_errno(sys_sched_setaffinity(arg1, mask_size, mask));
+            return get_errno(sys_sched_setaffinity(arg1, mask_size, mask));
         }
-        break;
     case TARGET_NR_getcpu:
         {
             unsigned cpu, node;
@@ -10727,7 +10622,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 goto efault;
             }
         }
-        break;
+        return ret;
     case TARGET_NR_sched_setparam:
         {
             struct sched_param *target_schp;
@@ -10740,9 +10635,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 goto efault;
             schp.sched_priority = tswap32(target_schp->sched_priority);
             unlock_user_struct(target_schp, arg2, 0);
-            ret = get_errno(sched_setparam(arg1, &schp));
+            return get_errno(sched_setparam(arg1, &schp));
         }
-        break;
     case TARGET_NR_sched_getparam:
         {
             struct sched_param *target_schp;
@@ -10759,7 +10653,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user_struct(target_schp, arg2, 1);
             }
         }
-        break;
+        return ret;
     case TARGET_NR_sched_setscheduler:
         {
             struct sched_param *target_schp;
@@ -10771,21 +10665,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 goto efault;
             schp.sched_priority = tswap32(target_schp->sched_priority);
             unlock_user_struct(target_schp, arg3, 0);
-            ret = get_errno(sched_setscheduler(arg1, arg2, &schp));
+            return get_errno(sched_setscheduler(arg1, arg2, &schp));
         }
-        break;
     case TARGET_NR_sched_getscheduler:
-        ret = get_errno(sched_getscheduler(arg1));
-        break;
+        return get_errno(sched_getscheduler(arg1));
     case TARGET_NR_sched_yield:
-        ret = get_errno(sched_yield());
-        break;
+        return get_errno(sched_yield());
     case TARGET_NR_sched_get_priority_max:
-        ret = get_errno(sched_get_priority_max(arg1));
-        break;
+        return get_errno(sched_get_priority_max(arg1));
     case TARGET_NR_sched_get_priority_min:
-        ret = get_errno(sched_get_priority_min(arg1));
-        break;
+        return get_errno(sched_get_priority_min(arg1));
     case TARGET_NR_sched_rr_get_interval:
         {
             struct timespec ts;
@@ -10794,7 +10683,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = host_to_target_timespec(arg2, &ts);
             }
         }
-        break;
+        return ret;
     case TARGET_NR_nanosleep:
         {
             struct timespec req, rem;
@@ -10804,7 +10693,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 host_to_target_timespec(arg2, &rem);
             }
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_query_module
     case TARGET_NR_query_module:
         goto unimplemented;
@@ -10823,7 +10712,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 && put_user_ual(deathsig, arg2)) {
                 goto efault;
             }
-            break;
+            return ret;
         }
 #ifdef PR_GET_NAME
         case PR_GET_NAME:
@@ -10835,7 +10724,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(prctl(arg1, (unsigned long)name,
                                   arg3, arg4, arg5));
             unlock_user(name, arg2, 16);
-            break;
+            return ret;
         }
         case PR_SET_NAME:
         {
@@ -10846,7 +10735,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(prctl(arg1, (unsigned long)name,
                                   arg3, arg4, arg5));
             unlock_user(name, arg2, 0);
-            break;
+            return ret;
         }
 #endif
 #ifdef TARGET_AARCH64
@@ -10874,32 +10763,29 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 env->vfp.zcr_el[1] = vq - 1;
                 ret = vq * 16;
             }
-            break;
+            return ret;
         case TARGET_PR_SVE_GET_VL:
             ret = -TARGET_EINVAL;
             if (arm_feature(cpu_env, ARM_FEATURE_SVE)) {
                 CPUARMState *env = cpu_env;
                 ret = ((env->vfp.zcr_el[1] & 0xf) + 1) * 16;
             }
-            break;
+            return ret;
 #endif /* AARCH64 */
         case PR_GET_SECCOMP:
         case PR_SET_SECCOMP:
             /* Disable seccomp to prevent the target disabling syscalls we
              * need. */
-            ret = -TARGET_EINVAL;
-            break;
+            return -TARGET_EINVAL;
         default:
             /* Most prctl options have no pointer arguments */
-            ret = get_errno(prctl(arg1, arg2, arg3, arg4, arg5));
-            break;
+            return get_errno(prctl(arg1, arg2, arg3, arg4, arg5));
         }
         break;
 #ifdef TARGET_NR_arch_prctl
     case TARGET_NR_arch_prctl:
 #if defined(TARGET_I386) && !defined(TARGET_ABI32)
-        ret = do_arch_prctl(cpu_env, arg1, arg2);
-        break;
+        return do_arch_prctl(cpu_env, arg1, arg2);
 #else
         goto unimplemented;
 #endif
@@ -10914,7 +10800,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
         unlock_user(p, arg2, ret);
-        break;
+        return ret;
     case TARGET_NR_pwrite64:
         if (regpairs_aligned(cpu_env, num)) {
             arg4 = arg5;
@@ -10924,14 +10810,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
 #endif
     case TARGET_NR_getcwd:
         if (!(p = lock_user(VERIFY_WRITE, arg1, arg2, 0)))
             goto efault;
         ret = get_errno(sys_getcwd1(p, arg2));
         unlock_user(p, arg1, ret);
-        break;
+        return ret;
     case TARGET_NR_capget:
     case TARGET_NR_capset:
     {
@@ -11000,11 +10886,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(target_data, arg2, 0);
             }
         }
-        break;
+        return ret;
     }
     case TARGET_NR_sigaltstack:
-        ret = do_sigaltstack(arg1, arg2, get_sp_from_cpustate((CPUArchState *)cpu_env));
-        break;
+        return do_sigaltstack(arg1, arg2,
+                              get_sp_from_cpustate((CPUArchState *)cpu_env));
 
 #ifdef CONFIG_SENDFILE
 #ifdef TARGET_NR_sendfile
@@ -11015,7 +10901,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (arg3) {
             ret = get_user_sal(off, arg3);
             if (is_error(ret)) {
-                break;
+                return ret;
             }
             offp = &off;
         }
@@ -11026,7 +10912,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = ret2;
             }
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_sendfile64
@@ -11037,7 +10923,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (arg3) {
             ret = get_user_s64(off, arg3);
             if (is_error(ret)) {
-                break;
+                return ret;
             }
             offp = &off;
         }
@@ -11048,7 +10934,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = ret2;
             }
         }
-        break;
+        return ret;
     }
 #endif
 #else
@@ -11069,10 +10955,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_vfork
     case TARGET_NR_vfork:
-        ret = get_errno(do_fork(cpu_env,
-                        CLONE_VFORK | CLONE_VM | TARGET_SIGCHLD,
-                        0, 0, 0, 0));
-        break;
+        return get_errno(do_fork(cpu_env,
+                         CLONE_VFORK | CLONE_VM | TARGET_SIGCHLD,
+                         0, 0, 0, 0));
 #endif
 #ifdef TARGET_NR_ugetrlimit
     case TARGET_NR_ugetrlimit:
@@ -11088,7 +10973,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 	    target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
             unlock_user_struct(target_rlim, arg2, 1);
 	}
-	break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_truncate64
@@ -11097,12 +10982,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
 	ret = target_truncate64(cpu_env, p, arg2, arg3, arg4);
         unlock_user(p, arg1, 0);
-	break;
+        return ret;
 #endif
 #ifdef TARGET_NR_ftruncate64
     case TARGET_NR_ftruncate64:
-	ret = target_ftruncate64(cpu_env, arg1, arg2, arg3, arg4);
-	break;
+        return target_ftruncate64(cpu_env, arg1, arg2, arg3, arg4);
 #endif
 #ifdef TARGET_NR_stat64
     case TARGET_NR_stat64:
@@ -11112,7 +10996,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg1, 0);
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg2, &st);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_lstat64
     case TARGET_NR_lstat64:
@@ -11122,14 +11006,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg1, 0);
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg2, &st);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_fstat64
     case TARGET_NR_fstat64:
         ret = get_errno(fstat(arg1, &st));
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg2, &st);
-        break;
+        return ret;
 #endif
 #if (defined(TARGET_NR_fstatat64) || defined(TARGET_NR_newfstatat))
 #ifdef TARGET_NR_fstatat64
@@ -11143,7 +11027,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(fstatat(arg1, path(p), &st, arg4));
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg3, &st);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_lchown
     case TARGET_NR_lchown:
@@ -11151,34 +11035,28 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(lchown(p, low2highuid(arg2), low2highgid(arg3)));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_getuid
     case TARGET_NR_getuid:
-        ret = get_errno(high2lowuid(getuid()));
-        break;
+        return get_errno(high2lowuid(getuid()));
 #endif
 #ifdef TARGET_NR_getgid
     case TARGET_NR_getgid:
-        ret = get_errno(high2lowgid(getgid()));
-        break;
+        return get_errno(high2lowgid(getgid()));
 #endif
 #ifdef TARGET_NR_geteuid
     case TARGET_NR_geteuid:
-        ret = get_errno(high2lowuid(geteuid()));
-        break;
+        return get_errno(high2lowuid(geteuid()));
 #endif
 #ifdef TARGET_NR_getegid
     case TARGET_NR_getegid:
-        ret = get_errno(high2lowgid(getegid()));
-        break;
+        return get_errno(high2lowgid(getegid()));
 #endif
     case TARGET_NR_setreuid:
-        ret = get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
-        break;
+        return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
     case TARGET_NR_setregid:
-        ret = get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
-        break;
+        return get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
     case TARGET_NR_getgroups:
         {
             int gidsetsize = arg1;
@@ -11189,7 +11067,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             grouplist = alloca(gidsetsize * sizeof(gid_t));
             ret = get_errno(getgroups(gidsetsize, grouplist));
             if (gidsetsize == 0)
-                break;
+                return ret;
             if (!is_error(ret)) {
                 target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * sizeof(target_id), 0);
                 if (!target_grouplist)
@@ -11199,7 +11077,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(target_grouplist, arg2, gidsetsize * sizeof(target_id));
             }
         }
-        break;
+        return ret;
     case TARGET_NR_setgroups:
         {
             int gidsetsize = arg1;
@@ -11218,12 +11096,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
                 unlock_user(target_grouplist, arg2, 0);
             }
-            ret = get_errno(setgroups(gidsetsize, grouplist));
+            return get_errno(setgroups(gidsetsize, grouplist));
         }
-        break;
     case TARGET_NR_fchown:
-        ret = get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
-        break;
+        return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
 #if defined(TARGET_NR_fchownat)
     case TARGET_NR_fchownat:
         if (!(p = lock_user_string(arg2))) 
@@ -11231,14 +11107,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(fchownat(arg1, p, low2highuid(arg3),
                                  low2highgid(arg4), arg5));
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_setresuid
     case TARGET_NR_setresuid:
-        ret = get_errno(sys_setresuid(low2highuid(arg1),
-                                      low2highuid(arg2),
-                                      low2highuid(arg3)));
-        break;
+        return get_errno(sys_setresuid(low2highuid(arg1),
+                                       low2highuid(arg2),
+                                       low2highuid(arg3)));
 #endif
 #ifdef TARGET_NR_getresuid
     case TARGET_NR_getresuid:
@@ -11252,14 +11127,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_getresgid
     case TARGET_NR_setresgid:
-        ret = get_errno(sys_setresgid(low2highgid(arg1),
-                                      low2highgid(arg2),
-                                      low2highgid(arg3)));
-        break;
+        return get_errno(sys_setresgid(low2highgid(arg1),
+                                       low2highgid(arg2),
+                                       low2highgid(arg3)));
 #endif
 #ifdef TARGET_NR_getresgid
     case TARGET_NR_getresgid:
@@ -11273,7 +11147,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_chown
     case TARGET_NR_chown:
@@ -11281,20 +11155,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(chown(p, low2highuid(arg2), low2highgid(arg3)));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
     case TARGET_NR_setuid:
-        ret = get_errno(sys_setuid(low2highuid(arg1)));
-        break;
+        return get_errno(sys_setuid(low2highuid(arg1)));
     case TARGET_NR_setgid:
-        ret = get_errno(sys_setgid(low2highgid(arg1)));
-        break;
+        return get_errno(sys_setgid(low2highgid(arg1)));
     case TARGET_NR_setfsuid:
-        ret = get_errno(setfsuid(arg1));
-        break;
+        return get_errno(setfsuid(arg1));
     case TARGET_NR_setfsgid:
-        ret = get_errno(setfsgid(arg1));
-        break;
+        return get_errno(setfsgid(arg1));
 
 #ifdef TARGET_NR_lchown32
     case TARGET_NR_lchown32:
@@ -11302,12 +11172,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(lchown(p, arg2, arg3));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_getuid32
     case TARGET_NR_getuid32:
-        ret = get_errno(getuid());
-        break;
+        return get_errno(getuid());
 #endif
 
 #if defined(TARGET_NR_getxuid) && defined(TARGET_ALPHA)
@@ -11318,8 +11187,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             euid=geteuid();
             ((CPUAlphaState *)cpu_env)->ir[IR_A4]=euid;
          }
-        ret = get_errno(getuid());
-        break;
+        return get_errno(getuid());
 #endif
 #if defined(TARGET_NR_getxgid) && defined(TARGET_ALPHA)
    /* Alpha specific */
@@ -11329,8 +11197,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             egid=getegid();
             ((CPUAlphaState *)cpu_env)->ir[IR_A4]=egid;
          }
-        ret = get_errno(getgid());
-        break;
+        return get_errno(getgid());
 #endif
 #if defined(TARGET_NR_osf_getsysinfo) && defined(TARGET_ALPHA)
     /* Alpha specific */
@@ -11368,7 +11235,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              -- Grabs a copy of the HWRPB; surely not used.
           */
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_osf_setsysinfo) && defined(TARGET_ALPHA)
     /* Alpha specific */
@@ -11459,7 +11326,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              -- Not implemented in linux kernel
           */
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_osf_sigprocmask
     /* Alpha specific.  */
@@ -11491,33 +11358,28 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = mask;
             }
         }
-        break;
+        return ret;
 #endif
 
 #ifdef TARGET_NR_getgid32
     case TARGET_NR_getgid32:
-        ret = get_errno(getgid());
-        break;
+        return get_errno(getgid());
 #endif
 #ifdef TARGET_NR_geteuid32
     case TARGET_NR_geteuid32:
-        ret = get_errno(geteuid());
-        break;
+        return get_errno(geteuid());
 #endif
 #ifdef TARGET_NR_getegid32
     case TARGET_NR_getegid32:
-        ret = get_errno(getegid());
-        break;
+        return get_errno(getegid());
 #endif
 #ifdef TARGET_NR_setreuid32
     case TARGET_NR_setreuid32:
-        ret = get_errno(setreuid(arg1, arg2));
-        break;
+        return get_errno(setreuid(arg1, arg2));
 #endif
 #ifdef TARGET_NR_setregid32
     case TARGET_NR_setregid32:
-        ret = get_errno(setregid(arg1, arg2));
-        break;
+        return get_errno(setregid(arg1, arg2));
 #endif
 #ifdef TARGET_NR_getgroups32
     case TARGET_NR_getgroups32:
@@ -11530,7 +11392,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             grouplist = alloca(gidsetsize * sizeof(gid_t));
             ret = get_errno(getgroups(gidsetsize, grouplist));
             if (gidsetsize == 0)
-                break;
+                return ret;
             if (!is_error(ret)) {
                 target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * 4, 0);
                 if (!target_grouplist) {
@@ -11542,7 +11404,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(target_grouplist, arg2, gidsetsize * 4);
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_setgroups32
     case TARGET_NR_setgroups32:
@@ -11561,19 +11423,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             for(i = 0;i < gidsetsize; i++)
                 grouplist[i] = tswap32(target_grouplist[i]);
             unlock_user(target_grouplist, arg2, 0);
-            ret = get_errno(setgroups(gidsetsize, grouplist));
+            return get_errno(setgroups(gidsetsize, grouplist));
         }
-        break;
 #endif
 #ifdef TARGET_NR_fchown32
     case TARGET_NR_fchown32:
-        ret = get_errno(fchown(arg1, arg2, arg3));
-        break;
+        return get_errno(fchown(arg1, arg2, arg3));
 #endif
 #ifdef TARGET_NR_setresuid32
     case TARGET_NR_setresuid32:
-        ret = get_errno(sys_setresuid(arg1, arg2, arg3));
-        break;
+        return get_errno(sys_setresuid(arg1, arg2, arg3));
 #endif
 #ifdef TARGET_NR_getresuid32
     case TARGET_NR_getresuid32:
@@ -11587,12 +11446,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_setresgid32
     case TARGET_NR_setresgid32:
-        ret = get_errno(sys_setresgid(arg1, arg2, arg3));
-        break;
+        return get_errno(sys_setresgid(arg1, arg2, arg3));
 #endif
 #ifdef TARGET_NR_getresgid32
     case TARGET_NR_getresgid32:
@@ -11606,7 +11464,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_chown32
     case TARGET_NR_chown32:
@@ -11614,27 +11472,23 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(chown(p, arg2, arg3));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_setuid32
     case TARGET_NR_setuid32:
-        ret = get_errno(sys_setuid(arg1));
-        break;
+        return get_errno(sys_setuid(arg1));
 #endif
 #ifdef TARGET_NR_setgid32
     case TARGET_NR_setgid32:
-        ret = get_errno(sys_setgid(arg1));
-        break;
+        return get_errno(sys_setgid(arg1));
 #endif
 #ifdef TARGET_NR_setfsuid32
     case TARGET_NR_setfsuid32:
-        ret = get_errno(setfsuid(arg1));
-        break;
+        return get_errno(setfsuid(arg1));
 #endif
 #ifdef TARGET_NR_setfsgid32
     case TARGET_NR_setfsgid32:
-        ret = get_errno(setfsgid(arg1));
-        break;
+        return get_errno(setfsgid(arg1));
 #endif
 
     case TARGET_NR_pivot_root:
@@ -11658,7 +11512,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             mincore_fail:
             unlock_user(a, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_arm_fadvise64_64
     case TARGET_NR_arm_fadvise64_64:
@@ -11670,8 +11524,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
          */
         ret = posix_fadvise(arg1, target_offset64(arg3, arg4),
                             target_offset64(arg5, arg6), arg2);
-        ret = -host_to_target_errno(ret);
-        break;
+        return -host_to_target_errno(ret);
 #endif
 
 #if TARGET_ABI_BITS == 32
@@ -11697,11 +11550,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             arg6 = arg7;
         }
 #endif
-        ret = -host_to_target_errno(posix_fadvise(arg1,
-                                                  target_offset64(arg2, arg3),
-                                                  target_offset64(arg4, arg5),
-                                                  arg6));
-        break;
+        ret = posix_fadvise(arg1, target_offset64(arg2, arg3),
+                            target_offset64(arg4, arg5), arg6);
+        return -host_to_target_errno(ret);
 #endif
 
 #ifdef TARGET_NR_fadvise64
@@ -11714,10 +11565,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             arg4 = arg5;
             arg5 = arg6;
         }
-        ret = -host_to_target_errno(posix_fadvise(arg1,
-                                                  target_offset64(arg2, arg3),
-                                                  arg4, arg5));
-        break;
+        ret = posix_fadvise(arg1, target_offset64(arg2, arg3), arg4, arg5);
+        return -host_to_target_errno(ret);
 #endif
 
 #else /* not a 32-bit ABI */
@@ -11737,8 +11586,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         default: break;
         }
 #endif
-        ret = -host_to_target_errno(posix_fadvise(arg1, arg2, arg3, arg4));
-        break;
+        return -host_to_target_errno(posix_fadvise(arg1, arg2, arg3, arg4));
 #endif
 #endif /* end of 64-bit ABI fadvise handling */
 
@@ -11748,8 +11596,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
            turns private file-backed mappings into anonymous mappings.
            This will break MADV_DONTNEED.
            This is a hint, so ignoring and returning success is ok.  */
-        ret = get_errno(0);
-        break;
+        return 0;
 #endif
 #if TARGET_ABI_BITS == 32
     case TARGET_NR_fcntl64:
@@ -11768,8 +11615,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
 	cmd = target_to_host_fcntl_cmd(arg2);
         if (cmd == -TARGET_EINVAL) {
-            ret = cmd;
-            break;
+            return cmd;
         }
 
         switch(arg2) {
@@ -11796,14 +11642,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = do_fcntl(arg1, arg2, arg3);
             break;
         }
-	break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_cacheflush
     case TARGET_NR_cacheflush:
         /* self-modifying code is handled automatically, so nothing needed */
-        ret = 0;
-        break;
+        return 0;
 #endif
 #ifdef TARGET_NR_security
     case TARGET_NR_security:
@@ -11811,12 +11656,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_getpagesize
     case TARGET_NR_getpagesize:
-        ret = TARGET_PAGE_SIZE;
-        break;
+        return TARGET_PAGE_SIZE;
 #endif
     case TARGET_NR_gettid:
-        ret = get_errno(gettid());
-        break;
+        return get_errno(gettid());
 #ifdef TARGET_NR_readahead
     case TARGET_NR_readahead:
 #if TARGET_ABI_BITS == 32
@@ -11829,7 +11672,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
         ret = get_errno(readahead(arg1, arg2, arg3));
 #endif
-        break;
+        return ret;
 #endif
 #ifdef CONFIG_ATTR
 #ifdef TARGET_NR_setxattr
@@ -11840,8 +11683,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (arg2) {
             b = lock_user(VERIFY_WRITE, arg2, arg3, 0);
             if (!b) {
-                ret = -TARGET_EFAULT;
-                break;
+                return -TARGET_EFAULT;
             }
         }
         p = lock_user_string(arg1);
@@ -11856,7 +11698,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         unlock_user(p, arg1, 0);
         unlock_user(b, arg2, arg3);
-        break;
+        return ret;
     }
     case TARGET_NR_flistxattr:
     {
@@ -11864,13 +11706,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (arg2) {
             b = lock_user(VERIFY_WRITE, arg2, arg3, 0);
             if (!b) {
-                ret = -TARGET_EFAULT;
-                break;
+                return -TARGET_EFAULT;
             }
         }
         ret = get_errno(flistxattr(arg1, b, arg3));
         unlock_user(b, arg2, arg3);
-        break;
+        return ret;
     }
     case TARGET_NR_setxattr:
     case TARGET_NR_lsetxattr:
@@ -11879,8 +11720,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (arg3) {
                 v = lock_user(VERIFY_READ, arg3, arg4, 1);
                 if (!v) {
-                    ret = -TARGET_EFAULT;
-                    break;
+                    return -TARGET_EFAULT;
                 }
             }
             p = lock_user_string(arg1);
@@ -11898,15 +11738,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(n, arg2, 0);
             unlock_user(v, arg3, 0);
         }
-        break;
+        return ret;
     case TARGET_NR_fsetxattr:
         {
             void *n, *v = 0;
             if (arg3) {
                 v = lock_user(VERIFY_READ, arg3, arg4, 1);
                 if (!v) {
-                    ret = -TARGET_EFAULT;
-                    break;
+                    return -TARGET_EFAULT;
                 }
             }
             n = lock_user_string(arg2);
@@ -11918,7 +11757,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(n, arg2, 0);
             unlock_user(v, arg3, 0);
         }
-        break;
+        return ret;
     case TARGET_NR_getxattr:
     case TARGET_NR_lgetxattr:
         {
@@ -11926,8 +11765,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (arg3) {
                 v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
                 if (!v) {
-                    ret = -TARGET_EFAULT;
-                    break;
+                    return -TARGET_EFAULT;
                 }
             }
             p = lock_user_string(arg1);
@@ -11945,15 +11783,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(n, arg2, 0);
             unlock_user(v, arg3, arg4);
         }
-        break;
+        return ret;
     case TARGET_NR_fgetxattr:
         {
             void *n, *v = 0;
             if (arg3) {
                 v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
                 if (!v) {
-                    ret = -TARGET_EFAULT;
-                    break;
+                    return -TARGET_EFAULT;
                 }
             }
             n = lock_user_string(arg2);
@@ -11965,7 +11802,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(n, arg2, 0);
             unlock_user(v, arg3, arg4);
         }
-        break;
+        return ret;
     case TARGET_NR_removexattr:
     case TARGET_NR_lremovexattr:
         {
@@ -11984,7 +11821,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p, arg1, 0);
             unlock_user(n, arg2, 0);
         }
-        break;
+        return ret;
     case TARGET_NR_fremovexattr:
         {
             void *n;
@@ -11996,15 +11833,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
             unlock_user(n, arg2, 0);
         }
-        break;
+        return ret;
 #endif
 #endif /* CONFIG_ATTR */
 #ifdef TARGET_NR_set_thread_area
     case TARGET_NR_set_thread_area:
 #if defined(TARGET_MIPS)
       ((CPUMIPSState *) cpu_env)->active_tc.CP0_UserLocal = arg1;
-      ret = 0;
-      break;
+      return 0;
 #elif defined(TARGET_CRIS)
       if (arg1 & 0xff)
           ret = -TARGET_EINVAL;
@@ -12012,16 +11848,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
           ((CPUCRISState *) cpu_env)->pregs[PR_PID] = arg1;
           ret = 0;
       }
-      break;
+      return ret;
 #elif defined(TARGET_I386) && defined(TARGET_ABI32)
-      ret = do_set_thread_area(cpu_env, arg1);
-      break;
+      return do_set_thread_area(cpu_env, arg1);
 #elif defined(TARGET_M68K)
       {
           TaskState *ts = cpu->opaque;
           ts->tp_value = arg1;
-          ret = 0;
-          break;
+          return 0;
       }
 #else
       goto unimplemented_nowarn;
@@ -12030,13 +11864,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_get_thread_area
     case TARGET_NR_get_thread_area:
 #if defined(TARGET_I386) && defined(TARGET_ABI32)
-        ret = do_get_thread_area(cpu_env, arg1);
-        break;
+        return do_get_thread_area(cpu_env, arg1);
 #elif defined(TARGET_M68K)
         {
             TaskState *ts = cpu->opaque;
-            ret = ts->tp_value;
-            break;
+            return ts->tp_value;
         }
 #else
         goto unimplemented_nowarn;
@@ -12056,7 +11888,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (!is_error(ret)) {
             ret = get_errno(clock_settime(arg1, &ts));
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_clock_gettime
@@ -12067,7 +11899,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (!is_error(ret)) {
             ret = host_to_target_timespec(arg2, &ts);
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_clock_getres
@@ -12078,7 +11910,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (!is_error(ret)) {
             host_to_target_timespec(arg2, &ts);
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_clock_nanosleep
@@ -12098,24 +11930,21 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ((CPUPPCState *)cpu_env)->crf[0] |= 1;
         }
 #endif
-        break;
+        return ret;
     }
 #endif
 
 #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
     case TARGET_NR_set_tid_address:
-        ret = get_errno(set_tid_address((int *)g2h(arg1)));
-        break;
+        return get_errno(set_tid_address((int *)g2h(arg1)));
 #endif
 
     case TARGET_NR_tkill:
-        ret = get_errno(safe_tkill((int)arg1, target_to_host_signal(arg2)));
-        break;
+        return get_errno(safe_tkill((int)arg1, target_to_host_signal(arg2)));
 
     case TARGET_NR_tgkill:
-        ret = get_errno(safe_tgkill((int)arg1, (int)arg2,
-                        target_to_host_signal(arg3)));
-        break;
+        return get_errno(safe_tgkill((int)arg1, (int)arg2,
+                         target_to_host_signal(arg3)));
 
 #ifdef TARGET_NR_set_robust_list
     case TARGET_NR_set_robust_list:
@@ -12157,18 +11986,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(p, arg2, 0);
             }
         }
-	break;
+        return ret;
 #endif
     case TARGET_NR_futex:
-        ret = do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
-        break;
+        return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
 #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
     case TARGET_NR_inotify_init:
         ret = get_errno(sys_inotify_init());
         if (ret >= 0) {
             fd_trans_register(ret, &target_inotify_trans);
         }
-        break;
+        return ret;
 #endif
 #ifdef CONFIG_INOTIFY1
 #if defined(TARGET_NR_inotify_init1) && defined(__NR_inotify_init1)
@@ -12178,7 +12006,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (ret >= 0) {
             fd_trans_register(ret, &target_inotify_trans);
         }
-        break;
+        return ret;
 #endif
 #endif
 #if defined(TARGET_NR_inotify_add_watch) && defined(__NR_inotify_add_watch)
@@ -12186,12 +12014,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         p = lock_user_string(arg2);
         ret = get_errno(sys_inotify_add_watch(arg1, path(p), arg3));
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_inotify_rm_watch) && defined(__NR_inotify_rm_watch)
     case TARGET_NR_inotify_rm_watch:
-        ret = get_errno(sys_inotify_rm_watch(arg1, arg2));
-        break;
+        return get_errno(sys_inotify_rm_watch(arg1, arg2));
 #endif
 
 #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
@@ -12216,17 +12043,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(mq_open(p, host_flags, arg3, pposix_mq_attr));
             unlock_user (p, arg1, 0);
         }
-        break;
+        return ret;
 
     case TARGET_NR_mq_unlink:
         p = lock_user_string(arg1 - 1);
         if (!p) {
-            ret = -TARGET_EFAULT;
-            break;
+            return -TARGET_EFAULT;
         }
         ret = get_errno(mq_unlink(p));
         unlock_user (p, arg1, 0);
-        break;
+        return ret;
 
     case TARGET_NR_mq_timedsend:
         {
@@ -12242,7 +12068,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
             unlock_user (p, arg2, arg3);
         }
-        break;
+        return ret;
 
     case TARGET_NR_mq_timedreceive:
         {
@@ -12263,7 +12089,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (arg4 != 0)
                 put_user_u32(prio, arg4);
         }
-        break;
+        return ret;
 
     /* Not implemented for now... */
 /*     case TARGET_NR_mq_notify: */
@@ -12284,7 +12110,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 copy_to_user_mq_attr(arg3, &posix_mq_attr_out);
             }
         }
-        break;
+        return ret;
 #endif
 
 #ifdef CONFIG_SPLICE
@@ -12293,7 +12119,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         {
             ret = get_errno(tee(arg1,arg2,arg3,arg4));
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_splice
     case TARGET_NR_splice:
@@ -12324,7 +12150,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_vmsplice
 	case TARGET_NR_vmsplice:
@@ -12337,7 +12163,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = -host_to_target_errno(errno);
             }
         }
-        break;
+        return ret;
 #endif
 #endif /* CONFIG_SPLICE */
 #ifdef CONFIG_EVENTFD
@@ -12347,7 +12173,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (ret >= 0) {
             fd_trans_register(ret, &target_eventfd_trans);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_eventfd2)
     case TARGET_NR_eventfd2:
@@ -12363,7 +12189,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (ret >= 0) {
             fd_trans_register(ret, &target_eventfd_trans);
         }
-        break;
+        return ret;
     }
 #endif
 #endif /* CONFIG_EVENTFD  */
@@ -12375,7 +12201,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
         ret = get_errno(fallocate(arg1, arg2, arg3, arg4));
 #endif
-        break;
+        return ret;
 #endif
 #if defined(CONFIG_SYNC_FILE_RANGE)
 #if defined(TARGET_NR_sync_file_range)
@@ -12391,7 +12217,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
         ret = get_errno(sync_file_range(arg1, arg2, arg3, arg4));
 #endif
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_sync_file_range2)
     case TARGET_NR_sync_file_range2:
@@ -12402,29 +12228,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
         ret = get_errno(sync_file_range(arg1, arg3, arg4, arg2));
 #endif
-        break;
+        return ret;
 #endif
 #endif
 #if defined(TARGET_NR_signalfd4)
     case TARGET_NR_signalfd4:
-        ret = do_signalfd4(arg1, arg2, arg4);
-        break;
+        return do_signalfd4(arg1, arg2, arg4);
 #endif
 #if defined(TARGET_NR_signalfd)
     case TARGET_NR_signalfd:
-        ret = do_signalfd4(arg1, arg2, 0);
-        break;
+        return do_signalfd4(arg1, arg2, 0);
 #endif
 #if defined(CONFIG_EPOLL)
 #if defined(TARGET_NR_epoll_create)
     case TARGET_NR_epoll_create:
-        ret = get_errno(epoll_create(arg1));
-        break;
+        return get_errno(epoll_create(arg1));
 #endif
 #if defined(TARGET_NR_epoll_create1) && defined(CONFIG_EPOLL_CREATE1)
     case TARGET_NR_epoll_create1:
-        ret = get_errno(epoll_create1(arg1));
-        break;
+        return get_errno(epoll_create1(arg1));
 #endif
 #if defined(TARGET_NR_epoll_ctl)
     case TARGET_NR_epoll_ctl:
@@ -12445,8 +12267,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user_struct(target_ep, arg4, 0);
             epp = &ep;
         }
-        ret = get_errno(epoll_ctl(arg1, arg2, arg3, epp));
-        break;
+        return get_errno(epoll_ctl(arg1, arg2, arg3, epp));
     }
 #endif
 
@@ -12465,8 +12286,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         int timeout = arg4;
 
         if (maxevents <= 0 || maxevents > TARGET_EP_MAX_EVENTS) {
-            ret = -TARGET_EINVAL;
-            break;
+            return -TARGET_EINVAL;
         }
 
         target_ep = lock_user(VERIFY_WRITE, arg2,
@@ -12478,8 +12298,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ep = g_try_new(struct epoll_event, maxevents);
         if (!ep) {
             unlock_user(target_ep, arg2, 0);
-            ret = -TARGET_ENOMEM;
-            break;
+            return -TARGET_ENOMEM;
         }
 
         switch (num) {
@@ -12533,7 +12352,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(target_ep, arg2, 0);
         }
         g_free(ep);
-        break;
+        return ret;
     }
 #endif
 #endif
@@ -12563,7 +12382,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             target_rold->rlim_max = tswap64(rold.rlim_max);
             unlock_user_struct(target_rold, arg4, 1);
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_gethostname
@@ -12576,7 +12395,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         } else {
             ret = -TARGET_EFAULT;
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_atomic_cmpxchg_32
@@ -12597,17 +12416,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         if (mem_value == arg2)
             put_user_u32(arg1, arg6);
-        ret = mem_value;
-        break;
+        return mem_value;
     }
 #endif
 #ifdef TARGET_NR_atomic_barrier
     case TARGET_NR_atomic_barrier:
-    {
-        /* Like the kernel implementation and the qemu arm barrier, no-op this? */
-        ret = 0;
-        break;
-    }
+        /* Like the kernel implementation and the
+           qemu arm barrier, no-op this? */
+        return 0;
 #endif
 
 #ifdef TARGET_NR_timer_create
@@ -12629,7 +12445,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 phost_sevp = &host_sevp;
                 ret = target_to_host_sigevent(phost_sevp, arg2);
                 if (ret != 0) {
-                    break;
+                    return ret;
                 }
             }
 
@@ -12642,7 +12458,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
         }
-        break;
+        return ret;
     }
 #endif
 
@@ -12670,7 +12486,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 goto efault;
             }
         }
-        break;
+        return ret;
     }
 #endif
 
@@ -12693,7 +12509,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = -TARGET_EFAULT;
             }
         }
-        break;
+        return ret;
     }
 #endif
 
@@ -12710,7 +12526,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(timer_getoverrun(htimer));
         }
         fd_trans_unregister(ret);
-        break;
+        return ret;
     }
 #endif
 
@@ -12727,15 +12543,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(timer_delete(htimer));
             g_posix_timers[timerid] = 0;
         }
-        break;
+        return ret;
     }
 #endif
 
 #if defined(TARGET_NR_timerfd_create) && defined(CONFIG_TIMERFD)
     case TARGET_NR_timerfd_create:
-        ret = get_errno(timerfd_create(arg1,
-                target_to_host_bitmask(arg2, fcntl_flags_tbl)));
-        break;
+        return get_errno(timerfd_create(arg1,
+                          target_to_host_bitmask(arg2, fcntl_flags_tbl)));
 #endif
 
 #if defined(TARGET_NR_timerfd_gettime) && defined(CONFIG_TIMERFD)
@@ -12749,7 +12564,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 
 #if defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD)
@@ -12772,41 +12587,35 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 
 #if defined(TARGET_NR_ioprio_get) && defined(__NR_ioprio_get)
     case TARGET_NR_ioprio_get:
-        ret = get_errno(ioprio_get(arg1, arg2));
-        break;
+        return get_errno(ioprio_get(arg1, arg2));
 #endif
 
 #if defined(TARGET_NR_ioprio_set) && defined(__NR_ioprio_set)
     case TARGET_NR_ioprio_set:
-        ret = get_errno(ioprio_set(arg1, arg2, arg3));
-        break;
+        return get_errno(ioprio_set(arg1, arg2, arg3));
 #endif
 
 #if defined(TARGET_NR_setns) && defined(CONFIG_SETNS)
     case TARGET_NR_setns:
-        ret = get_errno(setns(arg1, arg2));
-        break;
+        return get_errno(setns(arg1, arg2));
 #endif
 #if defined(TARGET_NR_unshare) && defined(CONFIG_SETNS)
     case TARGET_NR_unshare:
-        ret = get_errno(unshare(arg1));
-        break;
+        return get_errno(unshare(arg1));
 #endif
 #if defined(TARGET_NR_kcmp) && defined(__NR_kcmp)
     case TARGET_NR_kcmp:
-        ret = get_errno(kcmp(arg1, arg2, arg3, arg4, arg5));
-        break;
+        return get_errno(kcmp(arg1, arg2, arg3, arg4, arg5));
 #endif
 #ifdef TARGET_NR_swapcontext
     case TARGET_NR_swapcontext:
         /* PowerPC specific.  */
-        ret = do_swapcontext(cpu_env, arg1, arg2, arg3);
-        break;
+        return do_swapcontext(cpu_env, arg1, arg2, arg3);
 #endif
 
     default:
@@ -12815,8 +12624,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_setxattr) || defined(TARGET_NR_get_thread_area) || defined(TARGET_NR_getdomainname) || defined(TARGET_NR_set_robust_list)
     unimplemented_nowarn:
 #endif
-        ret = -TARGET_ENOSYS;
-        break;
+        return -TARGET_ENOSYS;
     }
 fail:
     return ret;
-- 
2.17.1
