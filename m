Received: from eggs.gnu.org ([2001:4830:134:3::10]:53908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvun-0001ok-2l
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvuj-0003Qo-To
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:17:17 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPvuj-0003Qa-HG
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:17:13 -0400
References: <20180601073050.8054-1-richard.henderson@linaro.org>
	<20180601073050.8054-11-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1da933da-35f1-5370-10a1-26f7f16bae42@vivier.eu>
Date: Mon, 4 Jun 2018 22:17:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180601073050.8054-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/33] linux-user: Split out brk, close,
 exit, read, write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 01/06/2018 à 09:30, Richard Henderson a écrit :
> These are relatively simple unconditionally defined syscalls.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 198 ++++++++++++++++++++++++-------------------
>  1 file changed, 111 insertions(+), 87 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index fc3dc3f40d..b0d268dab7 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7984,6 +7984,112 @@ IMPL(enosys)
>      return do_unimplemented(num);
>  }
>  
> +IMPL(brk)
> +{
> +    return do_brk(arg1);
> +}
> +
> +IMPL(close)
> +{
> +    if (is_hostfd(arg1)) {
> +        return -TARGET_EBADF;
> +    }
> +    fd_trans_unregister(arg1);
> +    return get_errno(close(arg1));
> +}
> +
> +IMPL(exit)
> +{
> +    CPUState *cpu = ENV_GET_CPU(cpu_env);
> +
> +    /* In old applications this may be used to implement _exit(2).
> +       However in threaded applictions it is used for thread termination,
> +       and _exit_group is used for application termination.
> +       Do thread termination if we have more then one thread.  */
> +    if (block_signals()) {
> +        return -TARGET_ERESTARTSYS;
> +    }
> +
> +    cpu_list_lock();
> +
> +    if (CPU_NEXT(first_cpu)) {
> +        /* Remove the CPU from the list.  */
> +        QTAILQ_REMOVE(&cpus, cpu, node);
> +        cpu_list_unlock();
> +
> +        TaskState *ts = cpu->opaque;
> +        if (ts->child_tidptr) {
> +            put_user_u32(0, ts->child_tidptr);
> +            sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
> +                      NULL, NULL, 0);
> +        }
> +        thread_cpu = NULL;
> +        object_unref(OBJECT(cpu));
> +        g_free(ts);
> +        rcu_unregister_thread();
> +        pthread_exit(NULL);
> +    } else {
> +        cpu_list_unlock();
> +
> +#ifdef TARGET_GPROF
> +        _mcleanup();
> +#endif
> +        gdb_exit(cpu_env, arg1);
> +        _exit(arg1);
> +    }
> +    g_assert_not_reached();
> +}
> +
> +IMPL(read)
> +{
> +    abi_long ret;
> +    char *fn;
> +
> +    if (arg3 == 0) {
> +        return 0;
> +    }
> +    if (is_hostfd(arg1)) {
> +        return -TARGET_EBADF;
> +    }
> +    fn = lock_user(VERIFY_WRITE, arg2, arg3, 0);
> +    if (!fn) {
> +        return -TARGET_EFAULT;
> +    }
> +    ret = get_errno(safe_read(arg1, fn, arg3));
> +    if (ret >= 0 && fd_trans_host_to_target_data(arg1)) {
> +        ret = fd_trans_host_to_target_data(arg1)(fn, ret);
> +    }
> +    unlock_user(fn, arg2, ret);
> +    return ret;
> +}
> +
> +IMPL(write)
> +{
> +    abi_long ret;
> +    char *fn;
> +
> +    if (is_hostfd(arg1)) {
> +        return -TARGET_EBADF;
> +    }
> +    fn = lock_user(VERIFY_READ, arg2, arg3, 1);
> +    if (!fn) {
> +        return -TARGET_EFAULT;
> +    }
> +    if (fd_trans_target_to_host_data(arg1)) {
> +        void *copy = g_malloc(arg3);
> +        memcpy(copy, fn, arg3);
> +        ret = fd_trans_target_to_host_data(arg1)(copy, arg3);
> +        if (ret >= 0) {
> +            ret = get_errno(safe_write(arg1, copy, ret));
> +        }
> +        g_free(copy);
> +    } else {
> +        ret = get_errno(safe_write(arg1, fn, arg3));
> +    }
> +    unlock_user(fn, arg2, ret);
> +    return ret;
> +}
> +
>  /* This is an internal helper for do_syscall so that it is easier
>   * to have a single return point, so that actions, such as logging
>   * of syscall results, can be performed.
> @@ -7999,83 +8105,6 @@ IMPL(everything_else)
>      char *fn;
>  
>      switch(num) {
> -    case TARGET_NR_exit:
> -        /* In old applications this may be used to implement _exit(2).
> -           However in threaded applictions it is used for thread termination,
> -           and _exit_group is used for application termination.
> -           Do thread termination if we have more then one thread.  */
> -
> -        if (block_signals()) {
> -            return -TARGET_ERESTARTSYS;
> -        }
> -
> -        cpu_list_lock();
> -
> -        if (CPU_NEXT(first_cpu)) {
> -            TaskState *ts;
> -
> -            /* Remove the CPU from the list.  */
> -            QTAILQ_REMOVE(&cpus, cpu, node);
> -
> -            cpu_list_unlock();
> -
> -            ts = cpu->opaque;
> -            if (ts->child_tidptr) {
> -                put_user_u32(0, ts->child_tidptr);
> -                sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
> -                          NULL, NULL, 0);
> -            }
> -            thread_cpu = NULL;
> -            object_unref(OBJECT(cpu));
> -            g_free(ts);
> -            rcu_unregister_thread();
> -            pthread_exit(NULL);
> -        }
> -
> -        cpu_list_unlock();
> -#ifdef TARGET_GPROF
> -        _mcleanup();
> -#endif
> -        gdb_exit(cpu_env, arg1);
> -        _exit(arg1);
> -        return 0; /* avoid warning */
> -    case TARGET_NR_read:
> -        if (arg3 == 0) {
> -            return 0;
> -        } else {
> -            if (is_hostfd(arg1)) {
> -                return -TARGET_EBADF;
> -            }
> -            if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
> -                return -TARGET_EFAULT;
> -            ret = get_errno(safe_read(arg1, p, arg3));
> -            if (ret >= 0 &&
> -                fd_trans_host_to_target_data(arg1)) {
> -                ret = fd_trans_host_to_target_data(arg1)(p, ret);
> -            }
> -            unlock_user(p, arg2, ret);
> -        }
> -        return ret;
> -    case TARGET_NR_write:
> -        if (is_hostfd(arg1)) {
> -            return -TARGET_EBADF;
> -        }
> -        if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
> -            return -TARGET_EFAULT;
> -        if (fd_trans_target_to_host_data(arg1)) {
> -            void *copy = g_malloc(arg3);
> -            memcpy(copy, p, arg3);
> -            ret = fd_trans_target_to_host_data(arg1)(copy, arg3);
> -            if (ret >= 0) {
> -                ret = get_errno(safe_write(arg1, copy, ret));
> -            }
> -            g_free(copy);
> -        } else {
> -            ret = get_errno(safe_write(arg1, p, arg3));
> -        }
> -        unlock_user(p, arg2, 0);
> -        return ret;
> -
>  #ifdef TARGET_NR_open
>      case TARGET_NR_open:
>          if (!(p = lock_user_string(arg1)))
> @@ -8116,15 +8145,6 @@ IMPL(everything_else)
>          fd_trans_unregister(ret);
>          return ret;
>  #endif
> -    case TARGET_NR_close:
> -        if (is_hostfd(arg1)) {
> -            return -TARGET_EBADF;
> -        }
> -        fd_trans_unregister(arg1);
> -        return get_errno(close(arg1));
> -
> -    case TARGET_NR_brk:
> -        return do_brk(arg1);
>  #ifdef TARGET_NR_fork
>      case TARGET_NR_fork:
>          return get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
> @@ -12894,7 +12914,11 @@ IMPL(everything_else)
>  }
>  
>  static impl_fn * const syscall_table[] = {
> -    impl_everything_else,
> +    [TARGET_NR_brk] = impl_brk,
> +    [TARGET_NR_close] = impl_close,
> +    [TARGET_NR_exit] = impl_exit,
> +    [TARGET_NR_read] = impl_read,
> +    [TARGET_NR_write] = impl_write,
>  };
>  
>  abi_long do_syscall(void *cpu_env, unsigned num, abi_long arg1,
> 

Starting with this patch, this is broken...

For instance with ppc64le target:

qemu: Unsupported syscall: 33
qemu: Unsupported syscall: 33
qemu: Unsupported syscall: 5
qemu: Unsupported syscall: 5
qemu: Unsupported syscall: 5
qemu: Unsupported syscall: 5
qemu: Unsupported syscall: 5
qemu: Unsupported syscall: 5
qemu: Unsupported syscall: 5
qemu: Unsupported syscall: 5
qemu: Unsupported syscall: 5
/bin/uname: error while loading shared libraries: libc.so.6: cannot open
shared object file: Error 38

for instance, for num = TARGET_NR_OPEN:

+    impl_fn *fn = impl_everything_else;

-> fn = impl_everything_else

+    if (num < ARRAY_SIZE(syscall_table)) {
+        fn = syscall_table[num];

-> fn = NULL

+    }
+    if (fn == NULL) {
+        fn = impl_enosys;

-> fn = impl_enosys;

+    }

So all undefined syscall numbers < max(defined syscall numbers) will
call impl_enosys.

You should do

    fn = NULL;
    if (num < ARRAY_SIZE(syscall_table)) {
        fn = syscall_table[num];
    }
    if (fn == NULL) {
        fn = impl_eveything_else;
    }

and the impl_enosys is managed by impl_eveything_else.

You can come back to your initial code when all syscalls are split out
(when you remove the enosys case from everything_else)... otherwise we
will not be able to bisect this part in the future.

Thanks,
Laurent
