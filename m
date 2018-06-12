Received: from eggs.gnu.org ([2001:4830:134:3::10]:55387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSm9L-0001Jp-1f
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSm9F-0003el-W9
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:28:03 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSm9F-0003eH-Mf
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:27:57 -0400
Received: by mail-qt0-x244.google.com with SMTP id l10-v6so19061084qtj.0
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 09:27:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c0591ba3-f32a-0846-2a7b-fdff32e1d043@amsat.org>
Date: Tue, 12 Jun 2018 13:27:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180612005145.3375-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 08/19] linux-user: Propagate goto efault
 to return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu

On 06/11/2018 09:51 PM, Richard Henderson wrote:
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 341 ++++++++++++++++++++++---------------------
>  1 file changed, 175 insertions(+), 166 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index efe882612b..a6b8268332 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8009,7 +8009,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              return 0;
>          } else {
>              if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              ret = get_errno(safe_read(arg1, p, arg3));
>              if (ret >= 0 &&
>                  fd_trans_host_to_target_data(arg1)) {
> @@ -8020,7 +8020,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return ret;
>      case TARGET_NR_write:
>          if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          if (fd_trans_target_to_host_data(arg1)) {
>              void *copy = g_malloc(arg3);
>              memcpy(copy, p, arg3);
> @@ -8038,7 +8038,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_open
>      case TARGET_NR_open:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(do_openat(cpu_env, AT_FDCWD, p,
>                                    target_to_host_bitmask(arg2, fcntl_flags_tbl),
>                                    arg3));
> @@ -8048,7 +8048,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #endif
>      case TARGET_NR_openat:
>          if (!(p = lock_user_string(arg2)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(do_openat(cpu_env, arg1, p,
>                                    target_to_host_bitmask(arg3, fcntl_flags_tbl),
>                                    arg4));
> @@ -8083,7 +8083,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(safe_wait4(arg1, &status, arg3, 0));
>              if (!is_error(ret) && arg2 && ret
>                  && put_user_s32(host_to_target_waitstatus(status), arg2))
> -                goto efault;
> +                return -TARGET_EFAULT;
>          }
>          return ret;
>  #endif
> @@ -8095,7 +8095,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(safe_waitid(arg1, arg2, &info, arg4, NULL));
>              if (!is_error(ret) && arg3 && info.si_pid != 0) {
>                  if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_siginfo_t), 0)))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  host_to_target_siginfo(p, &info);
>                  unlock_user(p, arg3, sizeof(target_siginfo_t));
>              }
> @@ -8105,7 +8105,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_creat /* not on alpha */
>      case TARGET_NR_creat:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(creat(p, arg2));
>          fd_trans_unregister(ret);
>          unlock_user(p, arg1, 0);
> @@ -8131,7 +8131,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          {
>              void * p2 = NULL;
>              if (!arg2 || !arg4)
> -                goto efault;
> +                return -TARGET_EFAULT;
>              p  = lock_user_string(arg2);
>              p2 = lock_user_string(arg4);
>              if (!p || !p2)
> @@ -8146,7 +8146,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_unlink
>      case TARGET_NR_unlink:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(unlink(p));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -8154,7 +8154,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #if defined(TARGET_NR_unlinkat)
>      case TARGET_NR_unlinkat:
>          if (!(p = lock_user_string(arg2)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(unlinkat(arg1, p, arg3));
>          unlock_user(p, arg2, 0);
>          return ret;
> @@ -8174,7 +8174,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              guest_argp = arg2;
>              for (gp = guest_argp; gp; gp += sizeof(abi_ulong)) {
>                  if (get_user_ual(addr, gp))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  if (!addr)
>                      break;
>                  argc++;
> @@ -8183,7 +8183,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              guest_envp = arg3;
>              for (gp = guest_envp; gp; gp += sizeof(abi_ulong)) {
>                  if (get_user_ual(addr, gp))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  if (!addr)
>                      break;
>                  envc++;
> @@ -8258,7 +8258,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return ret;
>      case TARGET_NR_chdir:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(chdir(p));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -8270,14 +8270,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              if (!is_error(ret)
>                  && arg1
>                  && put_user_sal(host_time, arg1))
> -                goto efault;
> +                return -TARGET_EFAULT;
>          }
>          return ret;
>  #endif
>  #ifdef TARGET_NR_mknod
>      case TARGET_NR_mknod:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(mknod(p, arg2, arg3));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -8285,7 +8285,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #if defined(TARGET_NR_mknodat)
>      case TARGET_NR_mknodat:
>          if (!(p = lock_user_string(arg2)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(mknodat(arg1, p, arg3, arg4));
>          unlock_user(p, arg2, 0);
>          return ret;
> @@ -8293,7 +8293,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_chmod
>      case TARGET_NR_chmod:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(chmod(p, arg2));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -8326,7 +8326,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              if (arg1) {
>                  p = lock_user_string(arg1);
>                  if (!p) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>              } else {
>                  p = NULL;
> @@ -8337,7 +8337,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  if (arg1) {
>                      unlock_user(p, arg1, 0);
>                  }
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>  
>              if (arg3) {
> @@ -8347,7 +8347,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                          unlock_user(p, arg1, 0);
>                      }
>                      unlock_user(p2, arg2, 0);
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>              } else {
>                  p3 = NULL;
> @@ -8376,7 +8376,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_umount
>      case TARGET_NR_umount:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(umount(p));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -8386,7 +8386,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          {
>              time_t host_time;
>              if (get_user_sal(host_time, arg1))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              return get_errno(stime(&host_time));
>          }
>  #endif
> @@ -8414,7 +8414,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              struct target_utimbuf *target_tbuf;
>              if (arg2) {
>                  if (!lock_user_struct(VERIFY_READ, target_tbuf, arg2, 1))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  tbuf.actime = tswapal(target_tbuf->actime);
>                  tbuf.modtime = tswapal(target_tbuf->modtime);
>                  unlock_user_struct(target_tbuf, arg2, 0);
> @@ -8423,7 +8423,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  host_tbuf = NULL;
>              }
>              if (!(p = lock_user_string(arg1)))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              ret = get_errno(utime(p, host_tbuf));
>              unlock_user(p, arg1, 0);
>          }
> @@ -8437,13 +8437,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  if (copy_from_user_timeval(&tv[0], arg2)
>                      || copy_from_user_timeval(&tv[1],
>                                                arg2 + sizeof(struct target_timeval)))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  tvp = tv;
>              } else {
>                  tvp = NULL;
>              }
>              if (!(p = lock_user_string(arg1)))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              ret = get_errno(utimes(p, tvp));
>              unlock_user(p, arg1, 0);
>          }
> @@ -8457,13 +8457,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  if (copy_from_user_timeval(&tv[0], arg3)
>                      || copy_from_user_timeval(&tv[1],
>                                                arg3 + sizeof(struct target_timeval)))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  tvp = tv;
>              } else {
>                  tvp = NULL;
>              }
> -            if (!(p = lock_user_string(arg2)))
> -                goto efault;
> +            if (!(p = lock_user_string(arg2))) {
> +                return -TARGET_EFAULT;
> +            }
>              ret = get_errno(futimesat(arg1, path(p), tvp));
>              unlock_user(p, arg2, 0);
>          }
> @@ -8479,16 +8480,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #endif
>  #ifdef TARGET_NR_access
>      case TARGET_NR_access:
> -        if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +        if (!(p = lock_user_string(arg1))) {
> +            return -TARGET_EFAULT;
> +        }
>          ret = get_errno(access(path(p), arg2));
>          unlock_user(p, arg1, 0);
>          return ret;
>  #endif
>  #if defined(TARGET_NR_faccessat) && defined(__NR_faccessat)
>      case TARGET_NR_faccessat:
> -        if (!(p = lock_user_string(arg2)))
> -            goto efault;
> +        if (!(p = lock_user_string(arg2))) {
> +            return -TARGET_EFAULT;
> +        }
>          ret = get_errno(faccessat(arg1, p, arg3, 0));
>          unlock_user(p, arg2, 0);
>          return ret;
> @@ -8559,7 +8562,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_mkdir
>      case TARGET_NR_mkdir:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(mkdir(p, arg2));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -8567,7 +8570,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #if defined(TARGET_NR_mkdirat)
>      case TARGET_NR_mkdirat:
>          if (!(p = lock_user_string(arg2)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(mkdirat(arg1, p, arg3));
>          unlock_user(p, arg2, 0);
>          return ret;
> @@ -8575,7 +8578,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_rmdir
>      case TARGET_NR_rmdir:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(rmdir(p));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -8603,7 +8606,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              if (arg1) {
>                  tmsp = lock_user(VERIFY_WRITE, arg1, sizeof(struct target_tms), 0);
>                  if (!tmsp)
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  tmsp->tms_utime = tswapal(host_to_target_clock_t(tms.tms_utime));
>                  tmsp->tms_stime = tswapal(host_to_target_clock_t(tms.tms_stime));
>                  tmsp->tms_cutime = tswapal(host_to_target_clock_t(tms.tms_cutime));
> @@ -8625,8 +8628,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          if (arg1 == 0) {
>              ret = get_errno(acct(NULL));
>          } else {
> -            if (!(p = lock_user_string(arg1)))
> -                goto efault;
> +            if (!(p = lock_user_string(arg1))) {
> +                return -TARGET_EFAULT;
> +            }
>              ret = get_errno(acct(path(p)));
>              unlock_user(p, arg1, 0);
>          }
> @@ -8634,7 +8638,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_umount2
>      case TARGET_NR_umount2:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(umount2(p, arg2));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -8667,7 +8671,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return get_errno(umask(arg1));
>      case TARGET_NR_chroot:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(chroot(p));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -8717,7 +8721,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              struct target_old_sigaction *old_act;
>              if (arg2) {
>                  if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  act._sa_handler = old_act->_sa_handler;
>                  target_siginitset(&act.sa_mask, old_act->sa_mask);
>                  act.sa_flags = old_act->sa_flags;
> @@ -8728,7 +8732,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(do_sigaction(arg1, pact, &oact));
>              if (!is_error(ret) && arg3) {
>                  if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  old_act->_sa_handler = oact._sa_handler;
>                  old_act->sa_mask = oact.sa_mask.sig[0];
>                  old_act->sa_flags = oact.sa_flags;
> @@ -8739,7 +8743,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>  	    if (arg2) {
>                  if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>  		act._sa_handler = old_act->_sa_handler;
>  		target_siginitset(&act.sa_mask, old_act->sa_mask.sig[0]);
>  		act.sa_flags = old_act->sa_flags;
> @@ -8753,7 +8757,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>  	    if (!is_error(ret) && arg3) {
>                  if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>  		old_act->_sa_handler = oact._sa_handler;
>  		old_act->sa_flags = oact.sa_flags;
>  		old_act->sa_mask.sig[0] = oact.sa_mask.sig[0];
> @@ -8767,7 +8771,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              struct target_sigaction act, oact, *pact;
>              if (arg2) {
>                  if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  act._sa_handler = old_act->_sa_handler;
>                  target_siginitset(&act.sa_mask, old_act->sa_mask);
>                  act.sa_flags = old_act->sa_flags;
> @@ -8783,7 +8787,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(do_sigaction(arg1, pact, &oact));
>              if (!is_error(ret) && arg3) {
>                  if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  old_act->_sa_handler = oact._sa_handler;
>                  old_act->sa_mask = oact.sa_mask.sig[0];
>                  old_act->sa_flags = oact.sa_flags;
> @@ -8813,7 +8817,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>              if (arg2) {
>                  if (!lock_user_struct(VERIFY_READ, rt_act, arg2, 1))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  act._sa_handler = rt_act->_sa_handler;
>                  act.sa_mask = rt_act->sa_mask;
>                  act.sa_flags = rt_act->sa_flags;
> @@ -8824,7 +8828,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(do_sigaction(arg1, pact, &oact));
>              if (!is_error(ret) && arg3) {
>                  if (!lock_user_struct(VERIFY_WRITE, rt_act, arg3, 0))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  rt_act->_sa_handler = oact._sa_handler;
>                  rt_act->sa_mask = oact.sa_mask;
>                  rt_act->sa_flags = oact.sa_flags;
> @@ -8845,7 +8849,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>              if (arg2) {
>                  if (!lock_user_struct(VERIFY_READ, act, arg2, 1)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>  #ifdef TARGET_ARCH_HAS_KA_RESTORER
>                  act->ka_restorer = restorer;
> @@ -8947,7 +8951,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                      goto fail;
>                  }
>                  if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  target_to_host_old_sigset(&set, p);
>                  unlock_user(p, arg2, 0);
>                  set_ptr = &set;
> @@ -8958,7 +8962,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = do_sigprocmask(how, set_ptr, &oldset);
>              if (!is_error(ret) && arg3) {
>                  if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0)))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  host_to_target_old_sigset(p, &oldset);
>                  unlock_user(p, arg3, sizeof(target_sigset_t));
>              }
> @@ -8991,7 +8995,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                      goto fail;
>                  }
>                  if (!(p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1)))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  target_to_host_sigset(&set, p);
>                  unlock_user(p, arg2, 0);
>                  set_ptr = &set;
> @@ -9002,7 +9006,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = do_sigprocmask(how, set_ptr, &oldset);
>              if (!is_error(ret) && arg3) {
>                  if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0)))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  host_to_target_sigset(p, &oldset);
>                  unlock_user(p, arg3, sizeof(target_sigset_t));
>              }
> @@ -9015,7 +9019,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(sigpending(&set));
>              if (!is_error(ret)) {
>                  if (!(p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0)))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  host_to_target_old_sigset(p, &set);
>                  unlock_user(p, arg1, sizeof(target_sigset_t));
>              }
> @@ -9038,7 +9042,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(sigpending(&set));
>              if (!is_error(ret)) {
>                  if (!(p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0)))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  host_to_target_sigset(p, &set);
>                  unlock_user(p, arg1, sizeof(target_sigset_t));
>              }
> @@ -9053,7 +9057,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              target_to_host_old_sigset(&ts->sigsuspend_mask, &mask);
>  #else
>              if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              target_to_host_old_sigset(&ts->sigsuspend_mask, p);
>              unlock_user(p, arg1, 0);
>  #endif
> @@ -9073,7 +9077,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  return -TARGET_EINVAL;
>              }
>              if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              target_to_host_sigset(&ts->sigsuspend_mask, p);
>              unlock_user(p, arg1, 0);
>              ret = get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask,
> @@ -9094,7 +9098,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>  
>              if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              target_to_host_sigset(&set, p);
>              unlock_user(p, arg1, 0);
>              if (arg3) {
> @@ -9110,7 +9114,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                      p = lock_user(VERIFY_WRITE, arg2, sizeof(target_siginfo_t),
>                                    0);
>                      if (!p) {
> -                        goto efault;
> +                        return -TARGET_EFAULT;
>                      }
>                      host_to_target_siginfo(p, &uinfo);
>                      unlock_user(p, arg2, sizeof(target_siginfo_t));
> @@ -9125,7 +9129,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>              p = lock_user(VERIFY_READ, arg3, sizeof(target_siginfo_t), 1);
>              if (!p) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              target_to_host_siginfo(&uinfo, p);
>              unlock_user(p, arg3, 0);
> @@ -9138,7 +9142,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>              p = lock_user(VERIFY_READ, arg4, sizeof(target_siginfo_t), 1);
>              if (!p) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              target_to_host_siginfo(&uinfo, p);
>              unlock_user(p, arg4, 0);
> @@ -9162,7 +9166,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          }
>      case TARGET_NR_sethostname:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(sethostname(p, arg2));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -9172,7 +9176,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              struct target_rlimit *target_rlim;
>              struct rlimit rlim;
>              if (!lock_user_struct(VERIFY_READ, target_rlim, arg2, 1))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              rlim.rlim_cur = target_to_host_rlim(target_rlim->rlim_cur);
>              rlim.rlim_max = target_to_host_rlim(target_rlim->rlim_max);
>              unlock_user_struct(target_rlim, arg2, 0);
> @@ -9187,7 +9191,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(getrlimit(resource, &rlim));
>              if (!is_error(ret)) {
>                  if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
>                  target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
>                  unlock_user_struct(target_rlim, arg2, 1);
> @@ -9209,7 +9213,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(gettimeofday(&tv, NULL));
>              if (!is_error(ret)) {
>                  if (copy_to_user_timeval(arg1, &tv))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> @@ -9220,14 +9224,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>              if (arg1) {
>                  if (copy_from_user_timeval(&tv, arg1)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>                  ptv = &tv;
>              }
>  
>              if (arg2) {
>                  if (copy_from_user_timezone(&tz, arg2)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>                  ptz = &tz;
>              }
> @@ -9294,7 +9298,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>               */
>              if (ts_addr) {
>                  if (target_to_host_timespec(&ts, ts_addr)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>                  ts_ptr = &ts;
>              } else {
> @@ -9308,7 +9312,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>                  arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
>                  if (!arg7) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>                  arg_sigset = tswapal(arg7[0]);
>                  arg_sigsize = tswapal(arg7[1]);
> @@ -9324,7 +9328,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                      target_sigset = lock_user(VERIFY_READ, arg_sigset,
>                                                sizeof(*target_sigset), 1);
>                      if (!target_sigset) {
> -                        goto efault;
> +                        return -TARGET_EFAULT;
>                      }
>                      target_to_host_sigset(&set, target_sigset);
>                      unlock_user(target_sigset, arg_sigset, 0);
> @@ -9340,14 +9344,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>              if (!is_error(ret)) {
>                  if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>  
>                  if (ts_addr && host_to_target_timespec(ts_addr, &ts))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> @@ -9446,7 +9450,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_swapon
>      case TARGET_NR_swapon:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(swapon(p, arg2));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -9456,7 +9460,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>             /* arg4 must be ignored in all other cases */
>             p = lock_user_string(arg4);
>             if (!p) {
> -              goto efault;
> +               return -TARGET_EFAULT;
>             }
>             ret = get_errno(reboot(arg1, arg2, arg3, p));
>             unlock_user(p, arg4, 0);
> @@ -9478,7 +9482,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              abi_ulong *v;
>              abi_ulong v1, v2, v3, v4, v5, v6;
>              if (!(v = lock_user(VERIFY_READ, arg1, 6 * sizeof(abi_ulong), 1)))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              v1 = tswapal(v[0]);
>              v2 = tswapal(v[1]);
>              v3 = tswapal(v[2]);
> @@ -9550,7 +9554,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #endif
>      case TARGET_NR_truncate:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(truncate(p, arg2));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -9561,7 +9565,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #if defined(TARGET_NR_fchmodat)
>      case TARGET_NR_fchmodat:
>          if (!(p = lock_user_string(arg2)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(fchmodat(arg1, p, arg3, 0));
>          unlock_user(p, arg2, 0);
>          return ret;
> @@ -9589,8 +9593,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          goto unimplemented;
>  #endif
>      case TARGET_NR_statfs:
> -        if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +        if (!(p = lock_user_string(arg1))) {
> +            return -TARGET_EFAULT;
> +        }
>          ret = get_errno(statfs(path(p), &stfs));
>          unlock_user(p, arg1, 0);
>      convert_statfs:
> @@ -9598,7 +9603,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              struct target_statfs *target_stfs;
>  
>              if (!lock_user_struct(VERIFY_WRITE, target_stfs, arg2, 0))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              __put_user(stfs.f_type, &target_stfs->f_type);
>              __put_user(stfs.f_bsize, &target_stfs->f_bsize);
>              __put_user(stfs.f_blocks, &target_stfs->f_blocks);
> @@ -9624,8 +9629,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          goto convert_statfs;
>  #ifdef TARGET_NR_statfs64
>      case TARGET_NR_statfs64:
> -        if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +        if (!(p = lock_user_string(arg1))) {
> +            return -TARGET_EFAULT;
> +        }
>          ret = get_errno(statfs(path(p), &stfs));
>          unlock_user(p, arg1, 0);
>      convert_statfs64:
> @@ -9633,7 +9639,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              struct target_statfs64 *target_stfs;
>  
>              if (!lock_user_struct(VERIFY_WRITE, target_stfs, arg3, 0))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              __put_user(stfs.f_type, &target_stfs->f_type);
>              __put_user(stfs.f_bsize, &target_stfs->f_bsize);
>              __put_user(stfs.f_blocks, &target_stfs->f_blocks);
> @@ -9731,7 +9737,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_getrandom:
>          p = lock_user(VERIFY_WRITE, arg1, arg2, 0);
>          if (!p) {
> -            goto efault;
> +            return -TARGET_EFAULT;
>          }
>          ret = get_errno(getrandom(p, arg2, arg3));
>          unlock_user(p, arg1, ret);
> @@ -9799,7 +9805,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  if (copy_from_user_timeval(&pvalue->it_interval, arg2)
>                      || copy_from_user_timeval(&pvalue->it_value,
>                                                arg2 + sizeof(struct target_timeval)))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>              } else {
>                  pvalue = NULL;
>              }
> @@ -9809,7 +9815,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                                           &ovalue.it_interval)
>                      || copy_to_user_timeval(arg3 + sizeof(struct target_timeval),
>                                              &ovalue.it_value))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> @@ -9823,22 +9829,24 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                                           &value.it_interval)
>                      || copy_to_user_timeval(arg2 + sizeof(struct target_timeval),
>                                              &value.it_value))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>              }
>          }
>          return ret;
>  #ifdef TARGET_NR_stat
>      case TARGET_NR_stat:
> -        if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +        if (!(p = lock_user_string(arg1))) {
> +            return -TARGET_EFAULT;
> +        }
>          ret = get_errno(stat(path(p), &st));
>          unlock_user(p, arg1, 0);
>          goto do_stat;
>  #endif
>  #ifdef TARGET_NR_lstat
>      case TARGET_NR_lstat:
> -        if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +        if (!(p = lock_user_string(arg1))) {
> +            return -TARGET_EFAULT;
> +        }
>          ret = get_errno(lstat(path(p), &st));
>          unlock_user(p, arg1, 0);
>          goto do_stat;
> @@ -9853,7 +9861,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  struct target_stat *target_st;
>  
>                  if (!lock_user_struct(VERIFY_WRITE, target_st, arg2, 0))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  memset(target_st, 0, sizeof(*target_st));
>                  __put_user(st.st_dev, &target_st->st_dev);
>                  __put_user(st.st_ino, &target_st->st_ino);
> @@ -9907,7 +9915,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  if (status_ptr && ret) {
>                      status = host_to_target_waitstatus(status);
>                      if (put_user_s32(status, status_ptr))
> -                        goto efault;
> +                        return -TARGET_EFAULT;
>                  }
>                  if (target_rusage) {
>                      rusage_err = host_to_target_rusage(target_rusage, &rusage);
> @@ -9921,7 +9929,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_swapoff
>      case TARGET_NR_swapoff:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(swapoff(p));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -9934,7 +9942,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              if (!is_error(ret) && arg1)
>              {
>                  if (!lock_user_struct(VERIFY_WRITE, target_value, arg1, 0))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  __put_user(value.uptime, &target_value->uptime);
>                  __put_user(value.loads[0], &target_value->loads[0]);
>                  __put_user(value.loads[1], &target_value->loads[1]);
> @@ -10031,7 +10039,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #endif
>      case TARGET_NR_setdomainname:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(setdomainname(p, arg2));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -10041,7 +10049,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              struct new_utsname * buf;
>  
>              if (!lock_user_struct(VERIFY_WRITE, buf, arg1, 0))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              ret = get_errno(sys_uname(buf));
>              if (!is_error(ret)) {
>                  /* Overwrite the native machine name with whatever is being
> @@ -10072,12 +10080,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              struct timex host_buf;
>  
>              if (target_to_host_timex(&host_buf, arg1) != 0) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              ret = get_errno(adjtimex(&host_buf));
>              if (!is_error(ret)) {
>                  if (host_to_target_timex(arg1, &host_buf) != 0) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>              }
>          }
> @@ -10088,12 +10096,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              struct timex htx, *phtx = &htx;
>  
>              if (target_to_host_timex(phtx, arg2) != 0) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              ret = get_errno(clock_adjtime(arg1, phtx));
>              if (!is_error(ret) && phtx) {
>                  if (host_to_target_timex(arg2, phtx) != 0) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>              }
>          }
> @@ -10143,7 +10151,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(_llseek(arg1, arg2, arg3, &res, arg5));
>  #endif
>              if ((ret == 0) && put_user_s64(res, arg4)) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> @@ -10174,7 +10182,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  		count1 = 0;
>                  de = dirp;
>                  if (!(target_dirp = lock_user(VERIFY_WRITE, arg2, count, 0)))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>  		tde = target_dirp;
>                  while (len > 0) {
>                      reclen = de->d_reclen;
> @@ -10202,7 +10210,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              abi_long count = arg3;
>  
>              if (!(dirp = lock_user(VERIFY_WRITE, arg2, count, 0)))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              ret = get_errno(sys_getdents(arg1, dirp, count));
>              if (!is_error(ret)) {
>                  struct linux_dirent *de;
> @@ -10231,7 +10239,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>              dirp = lock_user(VERIFY_WRITE, arg2, count, 0);
>              if (!dirp) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              ret = get_errno(sys_getdents64(arg1, dirp, count));
>              if (!is_error(ret)) {
> @@ -10286,7 +10294,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              struct linux_dirent64 *dirp;
>              abi_long count = arg3;
>              if (!(dirp = lock_user(VERIFY_WRITE, arg2, count, 0)))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              ret = get_errno(sys_getdents64(arg1, dirp, count));
>              if (!is_error(ret)) {
>                  struct linux_dirent64 *de;
> @@ -10335,7 +10343,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  target_pfd = lock_user(VERIFY_WRITE, arg1,
>                                         sizeof(struct target_pollfd) * nfds, 1);
>                  if (!target_pfd) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>  
>                  pfd = alloca(sizeof(struct pollfd) * nfds);
> @@ -10356,7 +10364,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  if (arg3) {
>                      if (target_to_host_timespec(timeout_ts, arg3)) {
>                          unlock_user(target_pfd, arg1, 0);
> -                        goto efault;
> +                        return -TARGET_EFAULT;
>                      }
>                  } else {
>                      timeout_ts = NULL;
> @@ -10371,7 +10379,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                      target_set = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
>                      if (!target_set) {
>                          unlock_user(target_pfd, arg1, 0);
> -                        goto efault;
> +                        return -TARGET_EFAULT;
>                      }
>                      target_to_host_sigset(set, target_set);
>                  } else {
> @@ -10525,7 +10533,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  }
>  
>                  if (host_to_target_cpu_mask(mask, mask_size, arg3, ret)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>              }
>          }
> @@ -10562,10 +10570,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  goto fail;
>              }
>              if (arg1 && put_user_u32(cpu, arg1)) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              if (arg2 && put_user_u32(node, arg2)) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> @@ -10578,7 +10586,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  return -TARGET_EINVAL;
>              }
>              if (!lock_user_struct(VERIFY_READ, target_schp, arg2, 1))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              schp.sched_priority = tswap32(target_schp->sched_priority);
>              unlock_user_struct(target_schp, arg2, 0);
>              return get_errno(sched_setparam(arg1, &schp));
> @@ -10594,7 +10602,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(sched_getparam(arg1, &schp));
>              if (!is_error(ret)) {
>                  if (!lock_user_struct(VERIFY_WRITE, target_schp, arg2, 0))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  target_schp->sched_priority = tswap32(schp.sched_priority);
>                  unlock_user_struct(target_schp, arg2, 1);
>              }
> @@ -10608,7 +10616,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  return -TARGET_EINVAL;
>              }
>              if (!lock_user_struct(VERIFY_READ, target_schp, arg3, 1))
> -                goto efault;
> +                return -TARGET_EFAULT;
>              schp.sched_priority = tswap32(target_schp->sched_priority);
>              unlock_user_struct(target_schp, arg3, 0);
>              return get_errno(sched_setscheduler(arg1, arg2, &schp));
> @@ -10656,7 +10664,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(prctl(arg1, &deathsig, arg3, arg4, arg5));
>              if (!is_error(ret) && arg2
>                  && put_user_ual(deathsig, arg2)) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              return ret;
>          }
> @@ -10665,7 +10673,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          {
>              void *name = lock_user(VERIFY_WRITE, arg2, 16, 1);
>              if (!name) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              ret = get_errno(prctl(arg1, (unsigned long)name,
>                                    arg3, arg4, arg5));
> @@ -10676,7 +10684,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          {
>              void *name = lock_user(VERIFY_READ, arg2, 16, 1);
>              if (!name) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              ret = get_errno(prctl(arg1, (unsigned long)name,
>                                    arg3, arg4, arg5));
> @@ -10736,7 +10744,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              arg5 = arg6;
>          }
>          if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
>          unlock_user(p, arg2, ret);
>          return ret;
> @@ -10746,14 +10754,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              arg5 = arg6;
>          }
>          if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
>          unlock_user(p, arg2, 0);
>          return ret;
>  #endif
>      case TARGET_NR_getcwd:
>          if (!(p = lock_user(VERIFY_WRITE, arg1, arg2, 0)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(sys_getcwd1(p, arg2));
>          unlock_user(p, arg1, ret);
>          return ret;
> @@ -10769,7 +10777,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          int data_items = 1;
>  
>          if (!lock_user_struct(VERIFY_WRITE, target_header, arg1, 1)) {
> -            goto efault;
> +            return -TARGET_EFAULT;
>          }
>          header.version = tswap32(target_header->version);
>          header.pid = tswap32(target_header->pid);
> @@ -10789,7 +10797,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>              if (!target_data) {
>                  unlock_user_struct(target_header, arg1, 0);
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>  
>              if (num == TARGET_NR_capset) {
> @@ -10905,7 +10913,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  	if (!is_error(ret)) {
>  	    struct target_rlimit *target_rlim;
>              if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0))
> -                goto efault;
> +                return -TARGET_EFAULT;
>  	    target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
>  	    target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
>              unlock_user_struct(target_rlim, arg2, 1);
> @@ -10916,7 +10924,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_truncate64
>      case TARGET_NR_truncate64:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>  	ret = target_truncate64(cpu_env, p, arg2, arg3, arg4);
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -10927,8 +10935,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #endif
>  #ifdef TARGET_NR_stat64
>      case TARGET_NR_stat64:
> -        if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +        if (!(p = lock_user_string(arg1))) {
> +            return -TARGET_EFAULT;
> +        }
>          ret = get_errno(stat(path(p), &st));
>          unlock_user(p, arg1, 0);
>          if (!is_error(ret))
> @@ -10937,8 +10946,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #endif
>  #ifdef TARGET_NR_lstat64
>      case TARGET_NR_lstat64:
> -        if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +        if (!(p = lock_user_string(arg1))) {
> +            return -TARGET_EFAULT;
> +        }
>          ret = get_errno(lstat(path(p), &st));
>          unlock_user(p, arg1, 0);
>          if (!is_error(ret))
> @@ -10959,9 +10969,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_newfstatat
>      case TARGET_NR_newfstatat:
>  #endif
> -        if (!(p = lock_user_string(arg2)))
> -            goto efault;
> +        if (!(p = lock_user_string(arg2))) {
> +            return -TARGET_EFAULT;
> +        }
>          ret = get_errno(fstatat(arg1, path(p), &st, arg4));
> +        unlock_user(p, arg2, 0);

Oh, another bug fixed? Is it worth a separate patch?

>          if (!is_error(ret))
>              ret = host_to_target_stat64(cpu_env, arg3, &st);
>          return ret;
> @@ -10969,7 +10981,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_lchown
>      case TARGET_NR_lchown:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(lchown(p, low2highuid(arg2), low2highgid(arg3)));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -11008,7 +11020,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              if (!is_error(ret)) {
>                  target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * sizeof(target_id), 0);
>                  if (!target_grouplist)
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  for(i = 0;i < ret; i++)
>                      target_grouplist[i] = tswapid(high2lowgid(grouplist[i]));
>                  unlock_user(target_grouplist, arg2, gidsetsize * sizeof(target_id));
> @@ -11040,7 +11052,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #if defined(TARGET_NR_fchownat)
>      case TARGET_NR_fchownat:
>          if (!(p = lock_user_string(arg2))) 
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(fchownat(arg1, p, low2highuid(arg3),
>                                   low2highgid(arg4), arg5));
>          unlock_user(p, arg2, 0);
> @@ -11061,7 +11073,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  if (put_user_id(high2lowuid(ruid), arg1)
>                      || put_user_id(high2lowuid(euid), arg2)
>                      || put_user_id(high2lowuid(suid), arg3))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> @@ -11081,7 +11093,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  if (put_user_id(high2lowgid(rgid), arg1)
>                      || put_user_id(high2lowgid(egid), arg2)
>                      || put_user_id(high2lowgid(sgid), arg3))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> @@ -11089,7 +11101,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_chown
>      case TARGET_NR_chown:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(chown(p, low2highuid(arg2), low2highgid(arg3)));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -11106,7 +11118,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_lchown32
>      case TARGET_NR_lchown32:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(lchown(p, arg2, arg3));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -11157,7 +11169,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  swcr |= (~fpcr >> 41) & SWCR_TRAP_ENABLE_DNO;
>  
>                  if (put_user_u64 (swcr, arg2))
> -                        goto efault;
> +                        return -TARGET_EFAULT;
>                  ret = 0;
>              }
>              break;
> @@ -11184,7 +11196,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  uint64_t swcr, fpcr, orig_fpcr;
>  
>                  if (get_user_u64 (swcr, arg2)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>                  orig_fpcr = cpu_alpha_load_fpcr(cpu_env);
>                  fpcr = orig_fpcr & FPCR_DYN_MASK;
> @@ -11211,7 +11223,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  int si_code;
>  
>                  if (get_user_u64(exc, arg2)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>  
>                  orig_fpcr = cpu_alpha_load_fpcr(cpu_env);
> @@ -11380,7 +11392,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  if (put_user_u32(ruid, arg1)
>                      || put_user_u32(euid, arg2)
>                      || put_user_u32(suid, arg3))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> @@ -11398,7 +11410,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  if (put_user_u32(rgid, arg1)
>                      || put_user_u32(egid, arg2)
>                      || put_user_u32(sgid, arg3))
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> @@ -11406,7 +11418,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_chown32
>      case TARGET_NR_chown32:
>          if (!(p = lock_user_string(arg1)))
> -            goto efault;
> +            return -TARGET_EFAULT;
>          ret = get_errno(chown(p, arg2, arg3));
>          unlock_user(p, arg1, 0);
>          return ret;
> @@ -11969,13 +11981,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              pposix_mq_attr = NULL;
>              if (arg4) {
>                  if (copy_from_user_mq_attr(&posix_mq_attr, arg4) != 0) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>                  pposix_mq_attr = &posix_mq_attr;
>              }
>              p = lock_user_string(arg1 - 1);
>              if (!p) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              ret = get_errno(mq_open(p, host_flags, arg3, pposix_mq_attr));
>              unlock_user (p, arg1, 0);
> @@ -12065,25 +12077,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              loff_t *ploff_in = NULL, *ploff_out = NULL;
>              if (arg2) {
>                  if (get_user_u64(loff_in, arg2)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>                  ploff_in = &loff_in;
>              }
>              if (arg4) {
>                  if (get_user_u64(loff_out, arg4)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>                  ploff_out = &loff_out;
>              }
>              ret = get_errno(splice(arg1, ploff_in, arg3, ploff_out, arg5, arg6));
>              if (arg2) {
>                  if (put_user_u64(loff_in, arg2)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>              }
>              if (arg4) {
>                  if (put_user_u64(loff_out, arg4)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>              }
>          }
> @@ -12193,7 +12205,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          if (arg4) {
>              struct target_epoll_event *target_ep;
>              if (!lock_user_struct(VERIFY_READ, target_ep, arg4, 1)) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              ep.events = tswap32(target_ep->events);
>              /* The epoll_data_t union is just opaque data to the kernel,
> @@ -12229,7 +12241,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          target_ep = lock_user(VERIFY_WRITE, arg2,
>                                maxevents * sizeof(struct target_epoll_event), 1);
>          if (!target_ep) {
> -            goto efault;
> +            return -TARGET_EFAULT;
>          }
>  
>          ep = g_try_new(struct epoll_event, maxevents);
> @@ -12301,7 +12313,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          int resource = target_to_host_resource(arg2);
>          if (arg3) {
>              if (!lock_user_struct(VERIFY_READ, target_rnew, arg3, 1)) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              rnew.rlim_cur = tswap64(target_rnew->rlim_cur);
>              rnew.rlim_max = tswap64(target_rnew->rlim_max);
> @@ -12312,7 +12324,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          ret = get_errno(sys_prlimit64(arg1, resource, rnewp, arg4 ? &rold : 0));
>          if (!is_error(ret) && arg4) {
>              if (!lock_user_struct(VERIFY_WRITE, target_rold, arg4, 1)) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              target_rold->rlim_cur = tswap64(rold.rlim_cur);
>              target_rold->rlim_max = tswap64(rold.rlim_max);
> @@ -12390,7 +12402,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  phtimer = NULL;
>              } else {
>                  if (put_user(TIMER_MAGIC | timer_index, arg3, target_timer_t)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>              }
>          }
> @@ -12414,12 +12426,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              struct itimerspec hspec_new = {{0},}, hspec_old = {{0},};
>  
>              if (target_to_host_itimerspec(&hspec_new, arg3)) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>              ret = get_errno(
>                            timer_settime(htimer, arg2, &hspec_new, &hspec_old));
>              if (arg4 && host_to_target_itimerspec(arg4, &hspec_old)) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> @@ -12497,7 +12509,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(timerfd_gettime(arg1, &its_curr));
>  
>              if (arg2 && host_to_target_itimerspec(arg2, &its_curr)) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> @@ -12510,7 +12522,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>              if (arg3) {
>                  if (target_to_host_itimerspec(&its_new, arg3)) {
> -                    goto efault;
> +                    return -TARGET_EFAULT;
>                  }
>                  p_new = &its_new;
>              } else {
> @@ -12520,7 +12532,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(timerfd_settime(arg1, arg2, p_new, &its_old));
>  
>              if (arg4 && host_to_target_itimerspec(arg4, &its_old)) {
> -                goto efault;
> +                return -TARGET_EFAULT;
>              }
>          }
>          return ret;
> @@ -12559,9 +12571,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      }
>  fail:
>      return ret;
> -efault:
> -    ret = -TARGET_EFAULT;
> -    goto fail;
>  }
>  
>  abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
