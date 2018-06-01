Received: from eggs.gnu.org ([2001:4830:134:3::10]:57350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWg-0005Qo-1A
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWb-0000Gi-Cl
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:06 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWa-0000Fg-UL
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:01 -0400
Received: by mail-pl0-x243.google.com with SMTP id c41-v6so14803208plj.10
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:21 -0700
Message-Id: <20180601073050.8054-5-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/33] linux-user: Propagate goto efault to
 return
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
 linux-user/syscall.c | 311 +++++++++++++++++++++----------------------
 1 file changed, 154 insertions(+), 157 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d0bf650c62..8ea2099001 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8028,7 +8028,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 return -TARGET_EBADF;
             }
             if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-                goto efault;
+                return -TARGET_EFAULT;
             ret = get_errno(safe_read(arg1, p, arg3));
             if (ret >= 0 &&
                 fd_trans_host_to_target_data(arg1)) {
@@ -8042,7 +8042,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return -TARGET_EBADF;
         }
         if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
-            goto efault;
+            return -TARGET_EFAULT;
         if (fd_trans_target_to_host_data(arg1)) {
             void *copy = g_malloc(arg3);
             memcpy(copy, p, arg3);
@@ -8060,7 +8060,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_open
     case TARGET_NR_open:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(do_openat(cpu_env, AT_FDCWD, p,
                                   target_to_host_bitmask(arg2, fcntl_flags_tbl),
                                   arg3));
@@ -8073,7 +8073,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return -TARGET_EBADF;
         }
         if (!(p = lock_user_string(arg2)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(do_openat(cpu_env, arg1, p,
                                   target_to_host_bitmask(arg3, fcntl_flags_tbl),
                                   arg4));
@@ -8117,7 +8117,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(safe_wait4(arg1, &status, arg3, 0));
             if (!is_error(ret) && arg2 && ret
                 && put_user_s32(host_to_target_waitstatus(status), arg2))
-                goto efault;
+                return -TARGET_EFAULT;
         }
         return ret;
 #endif
@@ -8129,7 +8129,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(safe_waitid(arg1, arg2, &info, arg4, NULL));
             if (!is_error(ret) && arg3 && info.si_pid != 0) {
                 if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_siginfo_t), 0)))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 host_to_target_siginfo(p, &info);
                 unlock_user(p, arg3, sizeof(target_siginfo_t));
             }
@@ -8139,7 +8139,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_creat /* not on alpha */
     case TARGET_NR_creat:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(creat(p, arg2));
         fd_trans_unregister(ret);
         unlock_user(p, arg1, 0);
@@ -8167,7 +8167,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         } else {
             void * p2 = NULL;
             if (!arg2 || !arg4)
-                goto efault;
+                return -TARGET_EFAULT;
             p  = lock_user_string(arg2);
             p2 = lock_user_string(arg4);
             if (!p || !p2)
@@ -8182,7 +8182,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_unlink
     case TARGET_NR_unlink:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(unlink(p));
         unlock_user(p, arg1, 0);
         return ret;
@@ -8193,7 +8193,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return -TARGET_EBADF;
         }
         if (!(p = lock_user_string(arg2)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(unlinkat(arg1, p, arg3));
         unlock_user(p, arg2, 0);
         return ret;
@@ -8213,7 +8213,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             guest_argp = arg2;
             for (gp = guest_argp; gp; gp += sizeof(abi_ulong)) {
                 if (get_user_ual(addr, gp))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 if (!addr)
                     break;
                 argc++;
@@ -8222,7 +8222,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             guest_envp = arg3;
             for (gp = guest_envp; gp; gp += sizeof(abi_ulong)) {
                 if (get_user_ual(addr, gp))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 if (!addr)
                     break;
                 envc++;
@@ -8297,7 +8297,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     case TARGET_NR_chdir:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(chdir(p));
         unlock_user(p, arg1, 0);
         return ret;
@@ -8309,14 +8309,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (!is_error(ret)
                 && arg1
                 && put_user_sal(host_time, arg1))
-                goto efault;
+                return -TARGET_EFAULT;
         }
         return ret;
 #endif
 #ifdef TARGET_NR_mknod
     case TARGET_NR_mknod:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(mknod(p, arg2, arg3));
         unlock_user(p, arg1, 0);
         return ret;
@@ -8327,7 +8327,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return -TARGET_EBADF;
         }
         if (!(p = lock_user_string(arg2)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(mknodat(arg1, p, arg3, arg4));
         unlock_user(p, arg2, 0);
         return ret;
@@ -8335,7 +8335,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_chmod
     case TARGET_NR_chmod:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(chmod(p, arg2));
         unlock_user(p, arg1, 0);
         return ret;
@@ -8371,7 +8371,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (arg1) {
                 p = lock_user_string(arg1);
                 if (!p) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
             } else {
                 p = NULL;
@@ -8382,7 +8382,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (arg1) {
                     unlock_user(p, arg1, 0);
                 }
-                goto efault;
+                return -TARGET_EFAULT;
             }
 
             if (arg3) {
@@ -8392,7 +8392,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                         unlock_user(p, arg1, 0);
                     }
                     unlock_user(p2, arg2, 0);
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
             } else {
                 p3 = NULL;
@@ -8421,7 +8421,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_umount
     case TARGET_NR_umount:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(umount(p));
         unlock_user(p, arg1, 0);
         return ret;
@@ -8431,7 +8431,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         {
             time_t host_time;
             if (get_user_sal(host_time, arg1))
-                goto efault;
+                return -TARGET_EFAULT;
             return get_errno(stime(&host_time));
         }
 #endif
@@ -8459,7 +8459,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct target_utimbuf *target_tbuf;
             if (arg2) {
                 if (!lock_user_struct(VERIFY_READ, target_tbuf, arg2, 1))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 tbuf.actime = tswapal(target_tbuf->actime);
                 tbuf.modtime = tswapal(target_tbuf->modtime);
                 unlock_user_struct(target_tbuf, arg2, 0);
@@ -8468,7 +8468,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 host_tbuf = NULL;
             }
             if (!(p = lock_user_string(arg1)))
-                goto efault;
+                return -TARGET_EFAULT;
             ret = get_errno(utime(p, host_tbuf));
             unlock_user(p, arg1, 0);
         }
@@ -8482,13 +8482,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (copy_from_user_timeval(&tv[0], arg2)
                     || copy_from_user_timeval(&tv[1],
                                               arg2 + sizeof(struct target_timeval)))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 tvp = tv;
             } else {
                 tvp = NULL;
             }
             if (!(p = lock_user_string(arg1)))
-                goto efault;
+                return -TARGET_EFAULT;
             ret = get_errno(utimes(p, tvp));
             unlock_user(p, arg1, 0);
         }
@@ -8504,13 +8504,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (copy_from_user_timeval(&tv[0], arg3)
                     || copy_from_user_timeval(&tv[1],
                                               arg3 + sizeof(struct target_timeval)))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 tvp = tv;
             } else {
                 tvp = NULL;
             }
             if (!(fn = lock_user_string(arg2))) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             TRY_INTERP_FD(ret, fn,
                           futimesat(interp_dirfd, fn + 1, tvp),
@@ -8531,7 +8531,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_access
     case TARGET_NR_access:
         if (!(fn = lock_user_string(arg1))) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
         TRY_INTERP_FD(ret, fn,
                       faccessat(interp_dirfd, fn + 1, arg2, 0),
@@ -8546,7 +8546,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return -TARGET_EBADF;
         }
         if (!(fn = lock_user_string(arg2))) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
         TRY_INTERP_FD(ret, fn,
                       faccessat(interp_dirfd, fn + 1, arg3, 0),
@@ -8625,7 +8625,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_mkdir
     case TARGET_NR_mkdir:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(mkdir(p, arg2));
         unlock_user(p, arg1, 0);
         return ret;
@@ -8636,7 +8636,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return -TARGET_EBADF;
         }
         if (!(p = lock_user_string(arg2)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(mkdirat(arg1, p, arg3));
         unlock_user(p, arg2, 0);
         return ret;
@@ -8644,7 +8644,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_rmdir
     case TARGET_NR_rmdir:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(rmdir(p));
         unlock_user(p, arg1, 0);
         return ret;
@@ -8675,7 +8675,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (arg1) {
                 tmsp = lock_user(VERIFY_WRITE, arg1, sizeof(struct target_tms), 0);
                 if (!tmsp)
-                    goto efault;
+                    return -TARGET_EFAULT;
                 tmsp->tms_utime = tswapal(host_to_target_clock_t(tms.tms_utime));
                 tmsp->tms_stime = tswapal(host_to_target_clock_t(tms.tms_stime));
                 tmsp->tms_cutime = tswapal(host_to_target_clock_t(tms.tms_cutime));
@@ -8698,7 +8698,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(acct(NULL));
         } else {
             if (!(fn = lock_user_string(arg1))) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             TRY_INTERP_PATH(ret, fn, acct(fn));
             ret = get_errno(ret);
@@ -8708,7 +8708,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_umount2
     case TARGET_NR_umount2:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(umount2(p, arg2));
         unlock_user(p, arg1, 0);
         return ret;
@@ -8741,7 +8741,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return get_errno(umask(arg1));
     case TARGET_NR_chroot:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(chroot(p));
         unlock_user(p, arg1, 0);
         return ret;
@@ -8797,7 +8797,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct target_old_sigaction *old_act;
             if (arg2) {
                 if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 act._sa_handler = old_act->_sa_handler;
                 target_siginitset(&act.sa_mask, old_act->sa_mask);
                 act.sa_flags = old_act->sa_flags;
@@ -8808,7 +8808,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(do_sigaction(arg1, pact, &oact));
             if (!is_error(ret) && arg3) {
                 if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 old_act->_sa_handler = oact._sa_handler;
                 old_act->sa_mask = oact.sa_mask.sig[0];
                 old_act->sa_flags = oact.sa_flags;
@@ -8819,7 +8819,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
 	    if (arg2) {
                 if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1))
-                    goto efault;
+                    return -TARGET_EFAULT;
 		act._sa_handler = old_act->_sa_handler;
 		target_siginitset(&act.sa_mask, old_act->sa_mask.sig[0]);
 		act.sa_flags = old_act->sa_flags;
@@ -8833,7 +8833,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
 	    if (!is_error(ret) && arg3) {
                 if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0))
-                    goto efault;
+                    return -TARGET_EFAULT;
 		old_act->_sa_handler = oact._sa_handler;
 		old_act->sa_flags = oact.sa_flags;
 		old_act->sa_mask.sig[0] = oact.sa_mask.sig[0];
@@ -8847,7 +8847,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct target_sigaction act, oact, *pact;
             if (arg2) {
                 if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 act._sa_handler = old_act->_sa_handler;
                 target_siginitset(&act.sa_mask, old_act->sa_mask);
                 act.sa_flags = old_act->sa_flags;
@@ -8863,7 +8863,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(do_sigaction(arg1, pact, &oact));
             if (!is_error(ret) && arg3) {
                 if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 old_act->_sa_handler = oact._sa_handler;
                 old_act->sa_mask = oact.sa_mask.sig[0];
                 old_act->sa_flags = oact.sa_flags;
@@ -8893,7 +8893,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
             if (arg2) {
                 if (!lock_user_struct(VERIFY_READ, rt_act, arg2, 1))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 act._sa_handler = rt_act->_sa_handler;
                 act.sa_mask = rt_act->sa_mask;
                 act.sa_flags = rt_act->sa_flags;
@@ -8904,7 +8904,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(do_sigaction(arg1, pact, &oact));
             if (!is_error(ret) && arg3) {
                 if (!lock_user_struct(VERIFY_WRITE, rt_act, arg3, 0))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 rt_act->_sa_handler = oact._sa_handler;
                 rt_act->sa_mask = oact.sa_mask;
                 rt_act->sa_flags = oact.sa_flags;
@@ -8925,7 +8925,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
             if (arg2) {
                 if (!lock_user_struct(VERIFY_READ, act, arg2, 1)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
 #ifdef TARGET_ARCH_HAS_KA_RESTORER
                 act->ka_restorer = restorer;
@@ -9027,7 +9027,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto fail;
                 }
                 if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 target_to_host_old_sigset(&set, p);
                 unlock_user(p, arg2, 0);
                 set_ptr = &set;
@@ -9038,7 +9038,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = do_sigprocmask(how, set_ptr, &oldset);
             if (!is_error(ret) && arg3) {
                 if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0)))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 host_to_target_old_sigset(p, &oldset);
                 unlock_user(p, arg3, sizeof(target_sigset_t));
             }
@@ -9071,7 +9071,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     goto fail;
                 }
                 if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 target_to_host_sigset(&set, p);
                 unlock_user(p, arg2, 0);
                 set_ptr = &set;
@@ -9082,7 +9082,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = do_sigprocmask(how, set_ptr, &oldset);
             if (!is_error(ret) && arg3) {
                 if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0)))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 host_to_target_sigset(p, &oldset);
                 unlock_user(p, arg3, sizeof(target_sigset_t));
             }
@@ -9095,7 +9095,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(sigpending(&set));
             if (!is_error(ret)) {
                 if (!(p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0)))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 host_to_target_old_sigset(p, &set);
                 unlock_user(p, arg1, sizeof(target_sigset_t));
             }
@@ -9118,7 +9118,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(sigpending(&set));
             if (!is_error(ret)) {
                 if (!(p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0)))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 host_to_target_sigset(p, &set);
                 unlock_user(p, arg1, sizeof(target_sigset_t));
             }
@@ -9133,7 +9133,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             target_to_host_old_sigset(&ts->sigsuspend_mask, &mask);
 #else
             if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
-                goto efault;
+                return -TARGET_EFAULT;
             target_to_host_old_sigset(&ts->sigsuspend_mask, p);
             unlock_user(p, arg1, 0);
 #endif
@@ -9153,7 +9153,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 return -TARGET_EINVAL;
             }
             if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
-                goto efault;
+                return -TARGET_EFAULT;
             target_to_host_sigset(&ts->sigsuspend_mask, p);
             unlock_user(p, arg1, 0);
             ret = get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask,
@@ -9174,7 +9174,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
 
             if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
-                goto efault;
+                return -TARGET_EFAULT;
             target_to_host_sigset(&set, p);
             unlock_user(p, arg1, 0);
             if (arg3) {
@@ -9190,7 +9190,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     p = lock_user(VERIFY_WRITE, arg2, sizeof(target_siginfo_t),
                                   0);
                     if (!p) {
-                        goto efault;
+                        return -TARGET_EFAULT;
                     }
                     host_to_target_siginfo(p, &uinfo);
                     unlock_user(p, arg2, sizeof(target_siginfo_t));
@@ -9205,7 +9205,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             p = lock_user(VERIFY_READ, arg3, sizeof(target_siginfo_t), 1);
             if (!p) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             target_to_host_siginfo(&uinfo, p);
             unlock_user(p, arg3, 0);
@@ -9218,7 +9218,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             p = lock_user(VERIFY_READ, arg4, sizeof(target_siginfo_t), 1);
             if (!p) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             target_to_host_siginfo(&uinfo, p);
             unlock_user(p, arg4, 0);
@@ -9242,7 +9242,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
     case TARGET_NR_sethostname:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(sethostname(p, arg2));
         unlock_user(p, arg1, 0);
         return ret;
@@ -9252,7 +9252,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct target_rlimit *target_rlim;
             struct rlimit rlim;
             if (!lock_user_struct(VERIFY_READ, target_rlim, arg2, 1))
-                goto efault;
+                return -TARGET_EFAULT;
             rlim.rlim_cur = target_to_host_rlim(target_rlim->rlim_cur);
             rlim.rlim_max = target_to_host_rlim(target_rlim->rlim_max);
             unlock_user_struct(target_rlim, arg2, 0);
@@ -9267,7 +9267,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(getrlimit(resource, &rlim));
             if (!is_error(ret)) {
                 if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
                 target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
                 unlock_user_struct(target_rlim, arg2, 1);
@@ -9289,7 +9289,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(gettimeofday(&tv, NULL));
             if (!is_error(ret)) {
                 if (copy_to_user_timeval(arg1, &tv))
-                    goto efault;
+                    return -TARGET_EFAULT;
             }
         }
         return ret;
@@ -9300,14 +9300,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             if (arg1) {
                 if (copy_from_user_timeval(&tv, arg1)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
                 ptv = &tv;
             }
 
             if (arg2) {
                 if (copy_from_user_timezone(&tz, arg2)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
                 ptz = &tz;
             }
@@ -9379,7 +9379,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              */
             if (ts_addr) {
                 if (target_to_host_timespec(&ts, ts_addr)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
                 ts_ptr = &ts;
             } else {
@@ -9393,7 +9393,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
                 arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
                 if (!arg7) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
                 arg_sigset = tswapal(arg7[0]);
                 arg_sigsize = tswapal(arg7[1]);
@@ -9409,7 +9409,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     target_sigset = lock_user(VERIFY_READ, arg_sigset,
                                               sizeof(*target_sigset), 1);
                     if (!target_sigset) {
-                        goto efault;
+                        return -TARGET_EFAULT;
                     }
                     target_to_host_sigset(&set, target_sigset);
                     unlock_user(target_sigset, arg_sigset, 0);
@@ -9425,14 +9425,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             if (!is_error(ret)) {
                 if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
-                    goto efault;
+                    return -TARGET_EFAULT;
 
                 if (ts_addr && host_to_target_timespec(ts_addr, &ts))
-                    goto efault;
+                    return -TARGET_EFAULT;
             }
         }
         return ret;
@@ -9541,7 +9541,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_swapon
     case TARGET_NR_swapon:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(swapon(p, arg2));
         unlock_user(p, arg1, 0);
         return ret;
@@ -9551,7 +9551,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
            /* arg4 must be ignored in all other cases */
            p = lock_user_string(arg4);
            if (!p) {
-              goto efault;
+              return -TARGET_EFAULT;
            }
            ret = get_errno(reboot(arg1, arg2, arg3, p));
            unlock_user(p, arg4, 0);
@@ -9573,7 +9573,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             abi_ulong *v;
             abi_ulong v1, v2, v3, v4, v5, v6;
             if (!(v = lock_user(VERIFY_READ, arg1, 6 * sizeof(abi_ulong), 1)))
-                goto efault;
+                return -TARGET_EFAULT;
             v1 = tswapal(v[0]);
             v2 = tswapal(v[1]);
             v3 = tswapal(v[2]);
@@ -9654,7 +9654,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
     case TARGET_NR_truncate:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(truncate(p, arg2));
         unlock_user(p, arg1, 0);
         return ret;
@@ -9674,7 +9674,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return -TARGET_EBADF;
         }
         if (!(p = lock_user_string(arg2)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(fchmodat(arg1, p, arg3, 0));
         unlock_user(p, arg2, 0);
         return ret;
@@ -9703,7 +9703,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
     case TARGET_NR_statfs:
         if (!(fn = lock_user_string(arg1))) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
         TRY_INTERP_PATH(ret, fn, statfs(fn, &stfs));
         ret = get_errno(ret);
@@ -9713,7 +9713,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct target_statfs *target_stfs;
 
             if (!lock_user_struct(VERIFY_WRITE, target_stfs, arg2, 0))
-                goto efault;
+                return -TARGET_EFAULT;
             __put_user(stfs.f_type, &target_stfs->f_type);
             __put_user(stfs.f_bsize, &target_stfs->f_bsize);
             __put_user(stfs.f_blocks, &target_stfs->f_blocks);
@@ -9743,7 +9743,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_statfs64
     case TARGET_NR_statfs64:
         if (!(fn = lock_user_string(arg1))) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
         TRY_INTERP_PATH(ret, fn, statfs(fn, &stfs));
         ret = get_errno(ret);
@@ -9753,7 +9753,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct target_statfs64 *target_stfs;
 
             if (!lock_user_struct(VERIFY_WRITE, target_stfs, arg3, 0))
-                goto efault;
+                return -TARGET_EFAULT;
             __put_user(stfs.f_type, &target_stfs->f_type);
             __put_user(stfs.f_bsize, &target_stfs->f_bsize);
             __put_user(stfs.f_blocks, &target_stfs->f_blocks);
@@ -9905,7 +9905,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_getrandom:
         p = lock_user(VERIFY_WRITE, arg1, arg2, 0);
         if (!p) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
         ret = get_errno(getrandom(p, arg2, arg3));
         unlock_user(p, arg1, ret);
@@ -9977,7 +9977,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (copy_from_user_timeval(&pvalue->it_interval, arg2)
                     || copy_from_user_timeval(&pvalue->it_value,
                                               arg2 + sizeof(struct target_timeval)))
-                    goto efault;
+                    return -TARGET_EFAULT;
             } else {
                 pvalue = NULL;
             }
@@ -9987,7 +9987,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                          &ovalue.it_interval)
                     || copy_to_user_timeval(arg3 + sizeof(struct target_timeval),
                                             &ovalue.it_value))
-                    goto efault;
+                    return -TARGET_EFAULT;
             }
         }
         return ret;
@@ -10001,14 +10001,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                          &value.it_interval)
                     || copy_to_user_timeval(arg2 + sizeof(struct target_timeval),
                                             &value.it_value))
-                    goto efault;
+                    return -TARGET_EFAULT;
             }
         }
         return ret;
 #ifdef TARGET_NR_stat
     case TARGET_NR_stat:
         if (!(fn = lock_user_string(arg1))) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
         TRY_INTERP_FD(ret, fn,
                       fstatat(interp_dirfd, fn + 1, &st, 0),
@@ -10020,7 +10020,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_lstat
     case TARGET_NR_lstat:
         if (!(fn = lock_user_string(arg1))) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
         TRY_INTERP_FD(ret, fn,
                       fstatat(interp_dirfd, fn + 1, &st, AT_SYMLINK_NOFOLLOW),
@@ -10041,7 +10041,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 struct target_stat *target_st;
 
                 if (!lock_user_struct(VERIFY_WRITE, target_st, arg2, 0))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 memset(target_st, 0, sizeof(*target_st));
                 __put_user(st.st_dev, &target_st->st_dev);
                 __put_user(st.st_ino, &target_st->st_ino);
@@ -10095,7 +10095,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (status_ptr && ret) {
                     status = host_to_target_waitstatus(status);
                     if (put_user_s32(status, status_ptr))
-                        goto efault;
+                        return -TARGET_EFAULT;
                 }
                 if (target_rusage) {
                     rusage_err = host_to_target_rusage(target_rusage, &rusage);
@@ -10109,7 +10109,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_swapoff
     case TARGET_NR_swapoff:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(swapoff(p));
         unlock_user(p, arg1, 0);
         return ret;
@@ -10122,7 +10122,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (!is_error(ret) && arg1)
             {
                 if (!lock_user_struct(VERIFY_WRITE, target_value, arg1, 0))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 __put_user(value.uptime, &target_value->uptime);
                 __put_user(value.loads[0], &target_value->loads[0]);
                 __put_user(value.loads[1], &target_value->loads[1]);
@@ -10222,7 +10222,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
     case TARGET_NR_setdomainname:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(setdomainname(p, arg2));
         unlock_user(p, arg1, 0);
         return ret;
@@ -10232,7 +10232,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct new_utsname * buf;
 
             if (!lock_user_struct(VERIFY_WRITE, buf, arg1, 0))
-                goto efault;
+                return -TARGET_EFAULT;
             ret = get_errno(sys_uname(buf));
             if (!is_error(ret)) {
                 /* Overwrite the native machine name with whatever is being
@@ -10262,12 +10262,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct timex host_buf;
 
             if (target_to_host_timex(&host_buf, arg1) != 0) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             ret = get_errno(adjtimex(&host_buf));
             if (!is_error(ret)) {
                 if (host_to_target_timex(arg1, &host_buf) != 0) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
             }
         }
@@ -10278,12 +10278,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct timex htx, *phtx = &htx;
 
             if (target_to_host_timex(phtx, arg2) != 0) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             ret = get_errno(clock_adjtime(arg1, phtx));
             if (!is_error(ret) && phtx) {
                 if (host_to_target_timex(arg2, phtx) != 0) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
             }
         }
@@ -10338,7 +10338,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(_llseek(arg1, arg2, arg3, &res, arg5));
 #endif
             if ((ret == 0) && put_user_s64(res, arg4)) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
         }
         return ret;
@@ -10372,7 +10372,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 		count1 = 0;
                 de = dirp;
                 if (!(target_dirp = lock_user(VERIFY_WRITE, arg2, count, 0)))
-                    goto efault;
+                    return -TARGET_EFAULT;
 		tde = target_dirp;
                 while (len > 0) {
                     reclen = de->d_reclen;
@@ -10400,7 +10400,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             abi_long count = arg3;
 
             if (!(dirp = lock_user(VERIFY_WRITE, arg2, count, 0)))
-                goto efault;
+                return -TARGET_EFAULT;
             ret = get_errno(sys_getdents(arg1, dirp, count));
             if (!is_error(ret)) {
                 struct linux_dirent *de;
@@ -10429,7 +10429,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             dirp = lock_user(VERIFY_WRITE, arg2, count, 0);
             if (!dirp) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             ret = get_errno(sys_getdents64(arg1, dirp, count));
             if (!is_error(ret)) {
@@ -10486,7 +10486,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct linux_dirent64 *dirp;
             abi_long count = arg3;
             if (!(dirp = lock_user(VERIFY_WRITE, arg2, count, 0)))
-                goto efault;
+                return -TARGET_EFAULT;
             ret = get_errno(sys_getdents64(arg1, dirp, count));
             if (!is_error(ret)) {
                 struct linux_dirent64 *de;
@@ -10535,7 +10535,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 target_pfd = lock_user(VERIFY_WRITE, arg1,
                                        sizeof(struct target_pollfd) * nfds, 1);
                 if (!target_pfd) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
 
                 ret = 0;
@@ -10565,7 +10565,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (arg3) {
                     if (target_to_host_timespec(timeout_ts, arg3)) {
                         unlock_user(target_pfd, arg1, 0);
-                        goto efault;
+                        return -TARGET_EFAULT;
                     }
                 } else {
                     timeout_ts = NULL;
@@ -10580,7 +10580,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     target_set = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
                     if (!target_set) {
                         unlock_user(target_pfd, arg1, 0);
-                        goto efault;
+                        return -TARGET_EFAULT;
                     }
                     target_to_host_sigset(set, target_set);
                 } else {
@@ -10748,7 +10748,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
 
                 if (host_to_target_cpu_mask(mask, mask_size, arg3, ret)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
             }
         }
@@ -10785,10 +10785,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 goto fail;
             }
             if (arg1 && put_user_u32(cpu, arg1)) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             if (arg2 && put_user_u32(node, arg2)) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
         }
         return ret;
@@ -10801,7 +10801,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 return -TARGET_EINVAL;
             }
             if (!lock_user_struct(VERIFY_READ, target_schp, arg2, 1))
-                goto efault;
+                return -TARGET_EFAULT;
             schp.sched_priority = tswap32(target_schp->sched_priority);
             unlock_user_struct(target_schp, arg2, 0);
             return get_errno(sched_setparam(arg1, &schp));
@@ -10817,7 +10817,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(sched_getparam(arg1, &schp));
             if (!is_error(ret)) {
                 if (!lock_user_struct(VERIFY_WRITE, target_schp, arg2, 0))
-                    goto efault;
+                    return -TARGET_EFAULT;
                 target_schp->sched_priority = tswap32(schp.sched_priority);
                 unlock_user_struct(target_schp, arg2, 1);
             }
@@ -10831,7 +10831,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 return -TARGET_EINVAL;
             }
             if (!lock_user_struct(VERIFY_READ, target_schp, arg3, 1))
-                goto efault;
+                return -TARGET_EFAULT;
             schp.sched_priority = tswap32(target_schp->sched_priority);
             unlock_user_struct(target_schp, arg3, 0);
             return get_errno(sched_setscheduler(arg1, arg2, &schp));
@@ -10879,7 +10879,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(prctl(arg1, &deathsig, arg3, arg4, arg5));
             if (!is_error(ret) && arg2
                 && put_user_ual(deathsig, arg2)) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             return ret;
         }
@@ -10888,7 +10888,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         {
             void *name = lock_user(VERIFY_WRITE, arg2, 16, 1);
             if (!name) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             ret = get_errno(prctl(arg1, (unsigned long)name,
                                   arg3, arg4, arg5));
@@ -10899,7 +10899,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         {
             void *name = lock_user(VERIFY_READ, arg2, 16, 1);
             if (!name) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             ret = get_errno(prctl(arg1, (unsigned long)name,
                                   arg3, arg4, arg5));
@@ -10962,7 +10962,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             arg5 = arg6;
         }
         if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
         unlock_user(p, arg2, ret);
         return ret;
@@ -10975,14 +10975,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             arg5 = arg6;
         }
         if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
         unlock_user(p, arg2, 0);
         return ret;
 #endif
     case TARGET_NR_getcwd:
         if (!(p = lock_user(VERIFY_WRITE, arg1, arg2, 0)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(sys_getcwd1(p, arg2));
         unlock_user(p, arg1, ret);
         return ret;
@@ -10998,7 +10998,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         int data_items = 1;
 
         if (!lock_user_struct(VERIFY_WRITE, target_header, arg1, 1)) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
         header.version = tswap32(target_header->version);
         header.pid = tswap32(target_header->pid);
@@ -11018,7 +11018,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
             if (!target_data) {
                 unlock_user_struct(target_header, arg1, 0);
-                goto efault;
+                return -TARGET_EFAULT;
             }
 
             if (num == TARGET_NR_capset) {
@@ -11142,7 +11142,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 	if (!is_error(ret)) {
 	    struct target_rlimit *target_rlim;
             if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0))
-                goto efault;
+                return -TARGET_EFAULT;
 	    target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
 	    target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
             unlock_user_struct(target_rlim, arg2, 1);
@@ -11153,7 +11153,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_truncate64
     case TARGET_NR_truncate64:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
 	ret = target_truncate64(cpu_env, p, arg2, arg3, arg4);
         unlock_user(p, arg1, 0);
 	return ret;
@@ -11168,7 +11168,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_stat64
     case TARGET_NR_stat64:
         if (!(fn = lock_user_string(arg1))) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
         TRY_INTERP_FD(ret, fn,
                       fstatat(interp_dirfd, fn + 1, &st, 0),
@@ -11182,7 +11182,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_lstat64
     case TARGET_NR_lstat64:
         if (!(fn = lock_user_string(arg1))) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
         TRY_INTERP_FD(ret, fn,
                       fstatat(interp_dirfd, fn + 1, &st, AT_SYMLINK_NOFOLLOW),
@@ -11214,7 +11214,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return -TARGET_EBADF;
         }
         if (!(fn = lock_user_string(arg2))) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
         TRY_INTERP_FD(ret, fn,
                       fstatat(interp_dirfd, fn + 1, &st, arg4),
@@ -11228,7 +11228,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_lchown
     case TARGET_NR_lchown:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(lchown(p, low2highuid(arg2), low2highgid(arg3)));
         unlock_user(p, arg1, 0);
         return ret;
@@ -11267,7 +11267,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (!is_error(ret)) {
                 target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * sizeof(target_id), 0);
                 if (!target_grouplist)
-                    goto efault;
+                    return -TARGET_EFAULT;
                 for(i = 0;i < ret; i++)
                     target_grouplist[i] = tswapid(high2lowgid(grouplist[i]));
                 unlock_user(target_grouplist, arg2, gidsetsize * sizeof(target_id));
@@ -11302,7 +11302,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return -TARGET_EBADF;
         }
         if (!(p = lock_user_string(arg2))) 
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(fchownat(arg1, p, low2highuid(arg3),
                                  low2highgid(arg4), arg5));
         unlock_user(p, arg2, 0);
@@ -11323,7 +11323,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (put_user_id(high2lowuid(ruid), arg1)
                     || put_user_id(high2lowuid(euid), arg2)
                     || put_user_id(high2lowuid(suid), arg3))
-                    goto efault;
+                    return -TARGET_EFAULT;
             }
         }
         return ret;
@@ -11343,7 +11343,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (put_user_id(high2lowgid(rgid), arg1)
                     || put_user_id(high2lowgid(egid), arg2)
                     || put_user_id(high2lowgid(sgid), arg3))
-                    goto efault;
+                    return -TARGET_EFAULT;
             }
         }
         return ret;
@@ -11351,7 +11351,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_chown
     case TARGET_NR_chown:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(chown(p, low2highuid(arg2), low2highgid(arg3)));
         unlock_user(p, arg1, 0);
         return ret;
@@ -11368,7 +11368,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_lchown32
     case TARGET_NR_lchown32:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(lchown(p, arg2, arg3));
         unlock_user(p, arg1, 0);
         return ret;
@@ -11419,7 +11419,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 swcr |= (~fpcr >> 41) & SWCR_TRAP_ENABLE_DNO;
 
                 if (put_user_u64 (swcr, arg2))
-                        goto efault;
+                        return -TARGET_EFAULT;
                 ret = 0;
             }
             break;
@@ -11446,7 +11446,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 uint64_t swcr, fpcr, orig_fpcr;
 
                 if (get_user_u64 (swcr, arg2)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
                 orig_fpcr = cpu_alpha_load_fpcr(cpu_env);
                 fpcr = orig_fpcr & FPCR_DYN_MASK;
@@ -11473,7 +11473,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 int si_code;
 
                 if (get_user_u64(exc, arg2)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
 
                 orig_fpcr = cpu_alpha_load_fpcr(cpu_env);
@@ -11645,7 +11645,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (put_user_u32(ruid, arg1)
                     || put_user_u32(euid, arg2)
                     || put_user_u32(suid, arg3))
-                    goto efault;
+                    return -TARGET_EFAULT;
             }
         }
         return ret;
@@ -11663,7 +11663,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (put_user_u32(rgid, arg1)
                     || put_user_u32(egid, arg2)
                     || put_user_u32(sgid, arg3))
-                    goto efault;
+                    return -TARGET_EFAULT;
             }
         }
         return ret;
@@ -11671,7 +11671,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_chown32
     case TARGET_NR_chown32:
         if (!(p = lock_user_string(arg1)))
-            goto efault;
+            return -TARGET_EFAULT;
         ret = get_errno(chown(p, arg2, arg3));
         unlock_user(p, arg1, 0);
         return ret;
@@ -12204,7 +12204,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 ret = get_errno(sys_utimensat(arg1, NULL, tsp, arg4));
             else {
                 if (!(fn = lock_user_string(arg2))) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
                 TRY_INTERP_FD(ret, fn,
                               sys_utimensat(interp_dirfd, fn + 1, tsp, arg4),
@@ -12242,7 +12242,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return -TARGET_EBADF;
         }
         if (!(fn = lock_user_string(arg2))) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
         TRY_INTERP_PATH(ret, fn, sys_inotify_add_watch(arg1, fn, arg3));
         ret = get_errno(ret);
@@ -12268,13 +12268,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             pposix_mq_attr = NULL;
             if (arg4) {
                 if (copy_from_user_mq_attr(&posix_mq_attr, arg4) != 0) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
                 pposix_mq_attr = &posix_mq_attr;
             }
             p = lock_user_string(arg1 - 1);
             if (!p) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             ret = get_errno(mq_open(p, host_flags, arg3, pposix_mq_attr));
             unlock_user (p, arg1, 0);
@@ -12368,25 +12368,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             loff_t *ploff_in = NULL, *ploff_out = NULL;
             if (arg2) {
                 if (get_user_u64(loff_in, arg2)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
                 ploff_in = &loff_in;
             }
             if (arg4) {
                 if (get_user_u64(loff_out, arg4)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
                 ploff_out = &loff_out;
             }
             ret = get_errno(splice(arg1, ploff_in, arg3, ploff_out, arg5, arg6));
             if (arg2) {
                 if (put_user_u64(loff_in, arg2)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
             }
             if (arg4) {
                 if (put_user_u64(loff_out, arg4)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
             }
         }
@@ -12517,7 +12517,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (arg4) {
             struct target_epoll_event *target_ep;
             if (!lock_user_struct(VERIFY_READ, target_ep, arg4, 1)) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             ep.events = tswap32(target_ep->events);
             /* The epoll_data_t union is just opaque data to the kernel,
@@ -12556,7 +12556,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         target_ep = lock_user(VERIFY_WRITE, arg2,
                               maxevents * sizeof(struct target_epoll_event), 1);
         if (!target_ep) {
-            goto efault;
+            return -TARGET_EFAULT;
         }
 
         ep = g_try_new(struct epoll_event, maxevents);
@@ -12628,7 +12628,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         int resource = target_to_host_resource(arg2);
         if (arg3) {
             if (!lock_user_struct(VERIFY_READ, target_rnew, arg3, 1)) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             rnew.rlim_cur = tswap64(target_rnew->rlim_cur);
             rnew.rlim_max = tswap64(target_rnew->rlim_max);
@@ -12639,7 +12639,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(sys_prlimit64(arg1, resource, rnewp, arg4 ? &rold : 0));
         if (!is_error(ret) && arg4) {
             if (!lock_user_struct(VERIFY_WRITE, target_rold, arg4, 1)) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             target_rold->rlim_cur = tswap64(rold.rlim_cur);
             target_rold->rlim_max = tswap64(rold.rlim_max);
@@ -12717,7 +12717,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 phtimer = NULL;
             } else {
                 if (put_user(TIMER_MAGIC | timer_index, arg3, target_timer_t)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
             }
         }
@@ -12741,12 +12741,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             struct itimerspec hspec_new = {{0},}, hspec_old = {{0},};
 
             if (target_to_host_itimerspec(&hspec_new, arg3)) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
             ret = get_errno(
                           timer_settime(htimer, arg2, &hspec_new, &hspec_old));
             if (arg4 && host_to_target_itimerspec(arg4, &hspec_old)) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
         }
         return ret;
@@ -12826,7 +12826,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(timerfd_gettime(arg1, &its_curr));
 
             if (arg2 && host_to_target_itimerspec(arg2, &its_curr)) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
         }
         return ret;
@@ -12841,7 +12841,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             if (arg3) {
                 if (target_to_host_itimerspec(&its_new, arg3)) {
-                    goto efault;
+                    return -TARGET_EFAULT;
                 }
                 p_new = &its_new;
             } else {
@@ -12851,7 +12851,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(timerfd_settime(arg1, arg2, p_new, &its_old));
 
             if (arg4 && host_to_target_itimerspec(arg4, &its_old)) {
-                goto efault;
+                return -TARGET_EFAULT;
             }
         }
         return ret;
@@ -12893,9 +12893,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     }
 fail:
     return ret;
-efault:
-    ret = -TARGET_EFAULT;
-    goto fail;
 }
 
 abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
-- 
2.17.0
