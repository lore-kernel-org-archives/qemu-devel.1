Received: from eggs.gnu.org ([2001:4830:134:3::10]:36534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHk8-00076x-U7
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHjv-0001vX-Gt
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:15:26 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:54155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsHju-0001sF-Iz
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:15:15 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 22 Aug 2018 03:14:13 +0200
Message-Id: <20180822011417.11608-4-laurent@vivier.eu>
In-Reply-To: <20180822011417.11608-1-laurent@vivier.eu>
References: <20180822011417.11608-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/7] linux-user: Relax single exit from "break"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Transform outermost "break" to "return ret".  If the immediately
preceeding statement was an assignment to ret, return the value
directly.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180818190118.12911-4-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 972 +++++++++++++++++--------------------------
 1 file changed, 390 insertions(+), 582 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f651024357..54721684e7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8123,8 +8123,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
            Do thread termination if we have more then one thread.  */
 
         if (block_signals()) {
-            ret = -TARGET_ERESTARTSYS;
-            break;
+            return -TARGET_ERESTARTSYS;
         }
 
         cpu_list_lock();
@@ -8153,12 +8152,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8168,7 +8166,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
             unlock_user(p, arg2, ret);
         }
-        break;
+        return ret;
     case TARGET_NR_write:
         if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
             goto efault;
@@ -8184,7 +8182,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(safe_write(arg1, p, arg3));
         }
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
+
 #ifdef TARGET_NR_open
     case TARGET_NR_open:
         if (!(p = lock_user_string(arg1)))
@@ -8194,7 +8193,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                   arg3));
         fd_trans_unregister(ret);
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
     case TARGET_NR_openat:
         if (!(p = lock_user_string(arg2)))
@@ -8204,29 +8203,27 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8237,7 +8234,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 && put_user_s32(host_to_target_waitstatus(status), arg2))
                 goto efault;
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_waitid
     case TARGET_NR_waitid:
@@ -8252,7 +8249,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(p, arg3, sizeof(target_siginfo_t));
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_creat /* not on alpha */
     case TARGET_NR_creat:
@@ -8261,7 +8258,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(creat(p, arg2));
         fd_trans_unregister(ret);
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_link
     case TARGET_NR_link:
@@ -8276,7 +8273,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg2, 0);
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_linkat)
     case TARGET_NR_linkat:
@@ -8293,7 +8290,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p, arg2, 0);
             unlock_user(p2, arg4, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_unlink
     case TARGET_NR_unlink:
@@ -8301,7 +8298,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(unlink(p));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_unlinkat)
     case TARGET_NR_unlinkat:
@@ -8309,7 +8306,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(unlinkat(arg1, p, arg3));
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
 #endif
     case TARGET_NR_execve:
         {
@@ -8407,13 +8404,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8424,7 +8421,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 && put_user_sal(host_time, arg1))
                 goto efault;
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_mknod
     case TARGET_NR_mknod:
@@ -8432,7 +8429,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(mknod(p, arg2, arg3));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_mknodat)
     case TARGET_NR_mknodat:
@@ -8440,7 +8437,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(mknodat(arg1, p, arg3, arg4));
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_chmod
     case TARGET_NR_chmod:
@@ -8448,7 +8445,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(chmod(p, arg2));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_break
     case TARGET_NR_break:
@@ -8460,20 +8457,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8529,14 +8523,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8544,16 +8538,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8564,8 +8556,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (!block_signals()) {
             sigsuspend(&((TaskState *)cpu->opaque)->signal_mask);
         }
-        ret = -TARGET_EINTR;
-        break;
+        return -TARGET_EINTR;
 #endif
 #ifdef TARGET_NR_utime
     case TARGET_NR_utime:
@@ -8587,7 +8578,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(utime(p, host_tbuf));
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_utimes
     case TARGET_NR_utimes:
@@ -8607,7 +8598,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(utimes(p, tvp));
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_futimesat)
     case TARGET_NR_futimesat:
@@ -8627,7 +8618,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(futimesat(arg1, path(p), tvp));
             unlock_user(p, arg2, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_stty
     case TARGET_NR_stty:
@@ -8643,7 +8634,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(access(path(p), arg2));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_faccessat) && defined(__NR_faccessat)
     case TARGET_NR_faccessat:
@@ -8651,12 +8642,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8664,16 +8654,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8687,7 +8674,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg2, 0);
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_renameat)
     case TARGET_NR_renameat:
@@ -8702,7 +8689,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg4, 0);
             unlock_user(p, arg2, 0);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_renameat2)
     case TARGET_NR_renameat2:
@@ -8718,7 +8705,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg4, 0);
             unlock_user(p, arg2, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_mkdir
     case TARGET_NR_mkdir:
@@ -8726,7 +8713,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(mkdir(p, arg2));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_mkdirat)
     case TARGET_NR_mkdirat:
@@ -8734,7 +8721,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(mkdirat(arg1, p, arg3));
         unlock_user(p, arg2, 0);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_rmdir
     case TARGET_NR_rmdir:
@@ -8742,24 +8729,22 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8778,7 +8763,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (!is_error(ret))
                 ret = host_to_target_clock_t(ret);
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_prof
     case TARGET_NR_prof:
         goto unimplemented;
@@ -8796,34 +8781,31 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8833,14 +8815,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8851,7 +8832,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (ret >= 0) {
             fd_trans_dup(arg1, arg2);
         }
-        break;
+        return ret;
 #endif
 #if defined(CONFIG_DUP3) && defined(TARGET_NR_dup3)
     case TARGET_NR_dup3:
@@ -8866,22 +8847,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8965,7 +8943,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
 #endif
         }
-        break;
+        return ret;
 #endif
     case TARGET_NR_rt_sigaction:
         {
@@ -8982,8 +8960,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct target_sigaction act, oact, *pact = 0;
 
             if (arg4 != sizeof(target_sigset_t)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
             if (arg2) {
                 if (!lock_user_struct(VERIFY_READ, rt_act, arg2, 1))
@@ -9015,8 +8992,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct target_sigaction *oact;
 
             if (sigsetsize != sizeof(target_sigset_t)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
             if (arg2) {
                 if (!lock_user_struct(VERIFY_READ, act, arg2, 1)) {
@@ -9043,7 +9019,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user_struct(oact, arg3, 1);
 #endif
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_sgetmask /* not on alpha */
     case TARGET_NR_sgetmask:
         {
@@ -9055,7 +9031,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = target_set;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_ssetmask /* not on alpha */
     case TARGET_NR_ssetmask:
@@ -9069,7 +9045,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = target_set;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_sigprocmask
     case TARGET_NR_sigprocmask:
@@ -9139,7 +9115,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
 #endif
         }
-        break;
+        return ret;
 #endif
     case TARGET_NR_rt_sigprocmask:
         {
@@ -9147,8 +9123,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             sigset_t set, oldset, *set_ptr;
 
             if (arg4 != sizeof(target_sigset_t)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
 
             if (arg2) {
@@ -9183,7 +9158,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(p, arg3, sizeof(target_sigset_t));
             }
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_sigpending
     case TARGET_NR_sigpending:
         {
@@ -9196,7 +9171,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(p, arg1, sizeof(target_sigset_t));
             }
         }
-        break;
+        return ret;
 #endif
     case TARGET_NR_rt_sigpending:
         {
@@ -9208,8 +9183,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              * the old_sigset_t is smaller in size.
              */
             if (arg2 > sizeof(target_sigset_t)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
 
             ret = get_errno(sigpending(&set));
@@ -9220,7 +9194,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(p, arg1, sizeof(target_sigset_t));
             }
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_sigsuspend
     case TARGET_NR_sigsuspend:
         {
@@ -9240,15 +9214,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9260,7 +9233,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ts->in_sigsuspend = 1;
             }
         }
-        break;
+        return ret;
     case TARGET_NR_rt_sigtimedwait:
         {
             sigset_t set;
@@ -9268,8 +9241,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             siginfo_t uinfo;
 
             if (arg4 != sizeof(target_sigset_t)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
 
             if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
@@ -9297,7 +9269,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = host_to_target_signal(ret);
             }
         }
-        break;
+        return ret;
     case TARGET_NR_rt_sigqueueinfo:
         {
             siginfo_t uinfo;
@@ -9310,7 +9282,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p, arg3, 0);
             ret = get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
         }
-        break;
+        return ret;
     case TARGET_NR_rt_tgsigqueueinfo:
         {
             siginfo_t uinfo;
@@ -9323,29 +9295,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9357,9 +9325,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9377,7 +9344,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user_struct(target_rlim, arg2, 1);
             }
         }
-        break;
+        return ret;
 #endif
     case TARGET_NR_getrusage:
         {
@@ -9387,7 +9354,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = host_to_target_rusage(arg2, &rusage);
             }
         }
-        break;
+        return ret;
     case TARGET_NR_gettimeofday:
         {
             struct timeval tv;
@@ -9397,7 +9364,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
     case TARGET_NR_settimeofday:
         {
             struct timeval tv, *ptv = NULL;
@@ -9417,9 +9384,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ptz = &tz;
             }
 
-            ret = get_errno(settimeofday(ptv, ptz));
+            return get_errno(settimeofday(ptv, ptz));
         }
-        break;
 #if defined(TARGET_NR_select)
     case TARGET_NR_select:
 #if defined(TARGET_WANT_NI_OLD_SELECT)
@@ -9432,7 +9398,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
         ret = do_select(arg1, arg2, arg3, arg4, arg5);
 #endif
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_pselect6
     case TARGET_NR_pselect6:
@@ -9536,7 +9502,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_symlink
     case TARGET_NR_symlink:
@@ -9551,7 +9517,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg2, 0);
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_symlinkat)
     case TARGET_NR_symlinkat:
@@ -9566,7 +9532,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg3, 0);
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_oldlstat
     case TARGET_NR_oldlstat:
@@ -9602,7 +9568,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg2, ret);
             unlock_user(p, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_readlinkat)
     case TARGET_NR_readlinkat:
@@ -9623,7 +9589,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p2, arg3, ret);
             unlock_user(p, arg2, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_uselib
     case TARGET_NR_uselib:
@@ -9635,7 +9601,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(swapon(p, arg2));
         unlock_user(p, arg1, 0);
-        break;
+        return ret;
 #endif
     case TARGET_NR_reboot:
         if (arg3 == LINUX_REBOOT_CMD_RESTART2) {
@@ -9649,7 +9615,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         } else {
            ret = get_errno(reboot(arg1, arg2, arg3, NULL));
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_readdir
     case TARGET_NR_readdir:
         goto unimplemented;
@@ -9682,22 +9648,20 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9710,38 +9674,31 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9749,23 +9706,21 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9773,8 +9728,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         errno = 0;
         ret = getpriority(arg1, arg2);
         if (ret == -1 && errno != 0) {
-            ret = -host_to_target_errno(errno);
-            break;
+            return -host_to_target_errno(errno);
         }
 #ifdef TARGET_ALPHA
         /* Return value is the unbiased priority.  Signal no error.  */
@@ -9783,10 +9737,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9822,7 +9775,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
             unlock_user_struct(target_stfs, arg2, 1);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_fstatfs
     case TARGET_NR_fstatfs:
@@ -9855,7 +9808,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
             unlock_user_struct(target_stfs, arg3, 1);
         }
-        break;
+        return ret;
     case TARGET_NR_fstatfs64:
         ret = get_errno(fstatfs(arg1, &stfs));
         goto convert_statfs64;
@@ -9866,91 +9819,73 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9960,22 +9895,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9991,10 +9923,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10003,9 +9932,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10015,10 +9943,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10045,7 +9972,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
     case TARGET_NR_getitimer:
         {
             struct itimerval value;
@@ -10059,7 +9986,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_stat
     case TARGET_NR_stat:
         if (!(p = lock_user_string(arg1)))
@@ -10105,7 +10032,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user_struct(target_st, arg2, 1);
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_olduname
     case TARGET_NR_olduname:
@@ -10116,17 +10043,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10154,14 +10079,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10189,70 +10114,57 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10269,20 +10181,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10304,17 +10215,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10331,7 +10240,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
         }
-        break;
+        return ret;
 #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
     case TARGET_NR_clock_adjtime:
         {
@@ -10347,7 +10256,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_create_module
     case TARGET_NR_create_module:
@@ -10361,11 +10270,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10375,8 +10282,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         goto unimplemented;
 #endif
     case TARGET_NR_personality:
-        ret = get_errno(personality(arg1));
-        break;
+        return get_errno(personality(arg1));
 #ifdef TARGET_NR_afs_syscall
     case TARGET_NR_afs_syscall:
         goto unimplemented;
@@ -10399,7 +10305,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_getdents
     case TARGET_NR_getdents:
@@ -10531,7 +10437,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(dirp, arg2, ret);
         }
 #endif
-        break;
+        return ret;
 #endif /* TARGET_NR_getdents */
 #if defined(TARGET_NR_getdents64) && defined(__NR_getdents64)
     case TARGET_NR_getdents64:
@@ -10559,12 +10465,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10583,8 +10488,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             target_pfd = NULL;
             if (nfds) {
                 if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
-                    ret = -TARGET_EINVAL;
-                    break;
+                    return -TARGET_EINVAL;
                 }
 
                 target_pfd = lock_user(VERIFY_WRITE, arg1,
@@ -10620,8 +10524,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (arg4) {
                     if (arg5 != sizeof(target_sigset_t)) {
                         unlock_user(target_pfd, arg1, 0);
-                        ret = -TARGET_EINVAL;
-                        break;
+                        return -TARGET_EINVAL;
                     }
 
                     target_set = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
@@ -10675,13 +10578,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10692,7 +10594,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = -host_to_target_errno(errno);
             }
         }
-        break;
+        return ret;
     case TARGET_NR_writev:
         {
             struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
@@ -10703,7 +10605,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = -host_to_target_errno(errno);
             }
         }
-        break;
+        return ret;
 #if defined(TARGET_NR_preadv)
     case TARGET_NR_preadv:
         {
@@ -10718,7 +10620,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = -host_to_target_errno(errno);
            }
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_pwritev)
     case TARGET_NR_pwritev:
@@ -10734,22 +10636,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10761,8 +10660,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              * care of mismatches between target ulong and host ulong sizes.
              */
             if (arg2 & (sizeof(abi_ulong) - 1)) {
-                ret = -TARGET_EINVAL;
-                break;
+                return -TARGET_EINVAL;
             }
             mask_size = (arg2 + (sizeof(*mask) - 1)) & ~(sizeof(*mask) - 1);
 
@@ -10781,8 +10679,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                      */
                     int numcpus = sysconf(_SC_NPROCESSORS_CONF);
                     if (numcpus > arg2 * 8) {
-                        ret = -TARGET_EINVAL;
-                        break;
+                        return -TARGET_EINVAL;
                     }
                     ret = arg2;
                 }
@@ -10792,7 +10689,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
         }
-        break;
+        return ret;
     case TARGET_NR_sched_setaffinity:
         {
             unsigned int mask_size;
@@ -10803,20 +10700,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10833,7 +10728,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 goto efault;
             }
         }
-        break;
+        return ret;
     case TARGET_NR_sched_setparam:
         {
             struct sched_param *target_schp;
@@ -10846,9 +10741,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10865,7 +10759,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user_struct(target_schp, arg2, 1);
             }
         }
-        break;
+        return ret;
     case TARGET_NR_sched_setscheduler:
         {
             struct sched_param *target_schp;
@@ -10877,21 +10771,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -10900,7 +10789,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = host_to_target_timespec(arg2, &ts);
             }
         }
-        break;
+        return ret;
     case TARGET_NR_nanosleep:
         {
             struct timespec req, rem;
@@ -10910,7 +10799,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 host_to_target_timespec(arg2, &rem);
             }
         }
-        break;
+        return ret;
 #ifdef TARGET_NR_query_module
     case TARGET_NR_query_module:
         goto unimplemented;
@@ -10929,7 +10818,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 && put_user_ual(deathsig, arg2)) {
                 goto efault;
             }
-            break;
+            return ret;
         }
 #ifdef PR_GET_NAME
         case PR_GET_NAME:
@@ -10941,7 +10830,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(prctl(arg1, (unsigned long)name,
                                   arg3, arg4, arg5));
             unlock_user(name, arg2, 16);
-            break;
+            return ret;
         }
         case PR_SET_NAME:
         {
@@ -10952,7 +10841,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(prctl(arg1, (unsigned long)name,
                                   arg3, arg4, arg5));
             unlock_user(name, arg2, 0);
-            break;
+            return ret;
         }
 #endif
 #ifdef TARGET_AARCH64
@@ -10980,32 +10869,29 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11020,7 +10906,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             goto efault;
         ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
         unlock_user(p, arg2, ret);
-        break;
+        return ret;
     case TARGET_NR_pwrite64:
         if (regpairs_aligned(cpu_env, num)) {
             arg4 = arg5;
@@ -11030,14 +10916,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11106,11 +10992,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11121,7 +11007,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (arg3) {
             ret = get_user_sal(off, arg3);
             if (is_error(ret)) {
-                break;
+                return ret;
             }
             offp = &off;
         }
@@ -11132,7 +11018,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = ret2;
             }
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_sendfile64
@@ -11143,7 +11029,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (arg3) {
             ret = get_user_s64(off, arg3);
             if (is_error(ret)) {
-                break;
+                return ret;
             }
             offp = &off;
         }
@@ -11154,7 +11040,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = ret2;
             }
         }
-        break;
+        return ret;
     }
 #endif
 #else
@@ -11175,10 +11061,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11194,7 +11079,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 	    target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
             unlock_user_struct(target_rlim, arg2, 1);
 	}
-	break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_truncate64
@@ -11203,12 +11088,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11218,7 +11102,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg1, 0);
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg2, &st);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_lstat64
     case TARGET_NR_lstat64:
@@ -11228,14 +11112,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11249,7 +11133,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(fstatat(arg1, path(p), &st, arg4));
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg3, &st);
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_lchown
     case TARGET_NR_lchown:
@@ -11257,34 +11141,28 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11295,7 +11173,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             grouplist = alloca(gidsetsize * sizeof(gid_t));
             ret = get_errno(getgroups(gidsetsize, grouplist));
             if (gidsetsize == 0)
-                break;
+                return ret;
             if (!is_error(ret)) {
                 target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * sizeof(target_id), 0);
                 if (!target_grouplist)
@@ -11305,7 +11183,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(target_grouplist, arg2, gidsetsize * sizeof(target_id));
             }
         }
-        break;
+        return ret;
     case TARGET_NR_setgroups:
         {
             int gidsetsize = arg1;
@@ -11324,12 +11202,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11337,14 +11213,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11358,14 +11233,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11379,7 +11253,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_chown
     case TARGET_NR_chown:
@@ -11387,20 +11261,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11408,12 +11278,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11424,8 +11293,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             euid=geteuid();
             ((CPUAlphaState *)cpu_env)->ir[IR_A4]=euid;
          }
-        ret = get_errno(getuid());
-        break;
+        return get_errno(getuid());
 #endif
 #if defined(TARGET_NR_getxgid) && defined(TARGET_ALPHA)
    /* Alpha specific */
@@ -11435,8 +11303,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             egid=getegid();
             ((CPUAlphaState *)cpu_env)->ir[IR_A4]=egid;
          }
-        ret = get_errno(getgid());
-        break;
+        return get_errno(getgid());
 #endif
 #if defined(TARGET_NR_osf_getsysinfo) && defined(TARGET_ALPHA)
     /* Alpha specific */
@@ -11474,7 +11341,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              -- Grabs a copy of the HWRPB; surely not used.
           */
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_osf_setsysinfo) && defined(TARGET_ALPHA)
     /* Alpha specific */
@@ -11565,7 +11432,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              -- Not implemented in linux kernel
           */
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_osf_sigprocmask
     /* Alpha specific.  */
@@ -11597,33 +11464,28 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11636,7 +11498,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             grouplist = alloca(gidsetsize * sizeof(gid_t));
             ret = get_errno(getgroups(gidsetsize, grouplist));
             if (gidsetsize == 0)
-                break;
+                return ret;
             if (!is_error(ret)) {
                 target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * 4, 0);
                 if (!target_grouplist) {
@@ -11648,7 +11510,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 unlock_user(target_grouplist, arg2, gidsetsize * 4);
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_setgroups32
     case TARGET_NR_setgroups32:
@@ -11667,19 +11529,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11693,12 +11552,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11712,7 +11570,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_chown32
     case TARGET_NR_chown32:
@@ -11720,27 +11578,23 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11764,7 +11618,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             mincore_fail:
             unlock_user(a, arg1, 0);
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_arm_fadvise64_64
     case TARGET_NR_arm_fadvise64_64:
@@ -11776,8 +11630,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
          */
         ret = posix_fadvise(arg1, target_offset64(arg3, arg4),
                             target_offset64(arg5, arg6), arg2);
-        ret = -host_to_target_errno(ret);
-        break;
+        return -host_to_target_errno(ret);
 #endif
 
 #if TARGET_ABI_BITS == 32
@@ -11803,11 +11656,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11820,10 +11671,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11843,8 +11692,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         default: break;
         }
 #endif
-        ret = -host_to_target_errno(posix_fadvise(arg1, arg2, arg3, arg4));
-        break;
+        return -host_to_target_errno(posix_fadvise(arg1, arg2, arg3, arg4));
 #endif
 #endif /* end of 64-bit ABI fadvise handling */
 
@@ -11854,8 +11702,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
            turns private file-backed mappings into anonymous mappings.
            This will break MADV_DONTNEED.
            This is a hint, so ignoring and returning success is ok.  */
-        ret = get_errno(0);
-        break;
+        return 0;
 #endif
 #if TARGET_ABI_BITS == 32
     case TARGET_NR_fcntl64:
@@ -11874,8 +11721,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
 	cmd = target_to_host_fcntl_cmd(arg2);
         if (cmd == -TARGET_EINVAL) {
-            ret = cmd;
-            break;
+            return cmd;
         }
 
         switch(arg2) {
@@ -11902,14 +11748,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11917,12 +11762,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11935,7 +11778,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
         ret = get_errno(readahead(arg1, arg2, arg3));
 #endif
-        break;
+        return ret;
 #endif
 #ifdef CONFIG_ATTR
 #ifdef TARGET_NR_setxattr
@@ -11946,8 +11789,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (arg2) {
             b = lock_user(VERIFY_WRITE, arg2, arg3, 0);
             if (!b) {
-                ret = -TARGET_EFAULT;
-                break;
+                return -TARGET_EFAULT;
             }
         }
         p = lock_user_string(arg1);
@@ -11962,7 +11804,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         unlock_user(p, arg1, 0);
         unlock_user(b, arg2, arg3);
-        break;
+        return ret;
     }
     case TARGET_NR_flistxattr:
     {
@@ -11970,13 +11812,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11985,8 +11826,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (arg3) {
                 v = lock_user(VERIFY_READ, arg3, arg4, 1);
                 if (!v) {
-                    ret = -TARGET_EFAULT;
-                    break;
+                    return -TARGET_EFAULT;
                 }
             }
             p = lock_user_string(arg1);
@@ -12004,15 +11844,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12024,7 +11863,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(n, arg2, 0);
             unlock_user(v, arg3, 0);
         }
-        break;
+        return ret;
     case TARGET_NR_getxattr:
     case TARGET_NR_lgetxattr:
         {
@@ -12032,8 +11871,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (arg3) {
                 v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
                 if (!v) {
-                    ret = -TARGET_EFAULT;
-                    break;
+                    return -TARGET_EFAULT;
                 }
             }
             p = lock_user_string(arg1);
@@ -12051,15 +11889,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12071,7 +11908,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(n, arg2, 0);
             unlock_user(v, arg3, arg4);
         }
-        break;
+        return ret;
     case TARGET_NR_removexattr:
     case TARGET_NR_lremovexattr:
         {
@@ -12090,7 +11927,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p, arg1, 0);
             unlock_user(n, arg2, 0);
         }
-        break;
+        return ret;
     case TARGET_NR_fremovexattr:
         {
             void *n;
@@ -12102,15 +11939,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12118,16 +11954,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12136,13 +11970,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12162,7 +11994,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (!is_error(ret)) {
             ret = get_errno(clock_settime(arg1, &ts));
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_clock_gettime
@@ -12173,7 +12005,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (!is_error(ret)) {
             ret = host_to_target_timespec(arg2, &ts);
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_clock_getres
@@ -12184,7 +12016,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (!is_error(ret)) {
             host_to_target_timespec(arg2, &ts);
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_clock_nanosleep
@@ -12204,24 +12036,21 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12263,18 +12092,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12284,7 +12112,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (ret >= 0) {
             fd_trans_register(ret, &target_inotify_trans);
         }
-        break;
+        return ret;
 #endif
 #endif
 #if defined(TARGET_NR_inotify_add_watch) && defined(__NR_inotify_add_watch)
@@ -12292,12 +12120,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12322,17 +12149,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12348,7 +12174,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
             unlock_user (p, arg2, arg3);
         }
-        break;
+        return ret;
 
     case TARGET_NR_mq_timedreceive:
         {
@@ -12369,7 +12195,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (arg4 != 0)
                 put_user_u32(prio, arg4);
         }
-        break;
+        return ret;
 
     /* Not implemented for now... */
 /*     case TARGET_NR_mq_notify: */
@@ -12390,7 +12216,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 copy_to_user_mq_attr(arg3, &posix_mq_attr_out);
             }
         }
-        break;
+        return ret;
 #endif
 
 #ifdef CONFIG_SPLICE
@@ -12399,7 +12225,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         {
             ret = get_errno(tee(arg1,arg2,arg3,arg4));
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_splice
     case TARGET_NR_splice:
@@ -12430,7 +12256,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
         }
-        break;
+        return ret;
 #endif
 #ifdef TARGET_NR_vmsplice
 	case TARGET_NR_vmsplice:
@@ -12443,7 +12269,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = -host_to_target_errno(errno);
             }
         }
-        break;
+        return ret;
 #endif
 #endif /* CONFIG_SPLICE */
 #ifdef CONFIG_EVENTFD
@@ -12453,7 +12279,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (ret >= 0) {
             fd_trans_register(ret, &target_eventfd_trans);
         }
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_eventfd2)
     case TARGET_NR_eventfd2:
@@ -12469,7 +12295,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (ret >= 0) {
             fd_trans_register(ret, &target_eventfd_trans);
         }
-        break;
+        return ret;
     }
 #endif
 #endif /* CONFIG_EVENTFD  */
@@ -12481,7 +12307,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
         ret = get_errno(fallocate(arg1, arg2, arg3, arg4));
 #endif
-        break;
+        return ret;
 #endif
 #if defined(CONFIG_SYNC_FILE_RANGE)
 #if defined(TARGET_NR_sync_file_range)
@@ -12497,7 +12323,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
         ret = get_errno(sync_file_range(arg1, arg2, arg3, arg4));
 #endif
-        break;
+        return ret;
 #endif
 #if defined(TARGET_NR_sync_file_range2)
     case TARGET_NR_sync_file_range2:
@@ -12508,29 +12334,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12551,8 +12373,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user_struct(target_ep, arg4, 0);
             epp = &ep;
         }
-        ret = get_errno(epoll_ctl(arg1, arg2, arg3, epp));
-        break;
+        return get_errno(epoll_ctl(arg1, arg2, arg3, epp));
     }
 #endif
 
@@ -12571,8 +12392,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         int timeout = arg4;
 
         if (maxevents <= 0 || maxevents > TARGET_EP_MAX_EVENTS) {
-            ret = -TARGET_EINVAL;
-            break;
+            return -TARGET_EINVAL;
         }
 
         target_ep = lock_user(VERIFY_WRITE, arg2,
@@ -12584,8 +12404,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ep = g_try_new(struct epoll_event, maxevents);
         if (!ep) {
             unlock_user(target_ep, arg2, 0);
-            ret = -TARGET_ENOMEM;
-            break;
+            return -TARGET_ENOMEM;
         }
 
         switch (num) {
@@ -12639,7 +12458,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(target_ep, arg2, 0);
         }
         g_free(ep);
-        break;
+        return ret;
     }
 #endif
 #endif
@@ -12669,7 +12488,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             target_rold->rlim_max = tswap64(rold.rlim_max);
             unlock_user_struct(target_rold, arg4, 1);
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_gethostname
@@ -12682,7 +12501,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         } else {
             ret = -TARGET_EFAULT;
         }
-        break;
+        return ret;
     }
 #endif
 #ifdef TARGET_NR_atomic_cmpxchg_32
@@ -12703,17 +12522,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12735,7 +12551,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 phost_sevp = &host_sevp;
                 ret = target_to_host_sigevent(phost_sevp, arg2);
                 if (ret != 0) {
-                    break;
+                    return ret;
                 }
             }
 
@@ -12748,7 +12564,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
         }
-        break;
+        return ret;
     }
 #endif
 
@@ -12776,7 +12592,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 goto efault;
             }
         }
-        break;
+        return ret;
     }
 #endif
 
@@ -12799,7 +12615,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = -TARGET_EFAULT;
             }
         }
-        break;
+        return ret;
     }
 #endif
 
@@ -12816,7 +12632,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(timer_getoverrun(htimer));
         }
         fd_trans_unregister(ret);
-        break;
+        return ret;
     }
 #endif
 
@@ -12833,15 +12649,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12855,7 +12670,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 goto efault;
             }
         }
-        break;
+        return ret;
 #endif
 
 #if defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD)
@@ -12878,41 +12693,35 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12921,8 +12730,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
