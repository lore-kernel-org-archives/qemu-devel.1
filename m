Received: from eggs.gnu.org ([2001:4830:134:3::10]:52535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSltE-0001N1-Uo
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSltA-0003mW-Il
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:11:24 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:45570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSltA-0003mN-Cj
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:11:20 -0400
Received: by mail-vk0-x244.google.com with SMTP id l64-v6so7145144vkl.12
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 09:11:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <90465ae9-6dbc-78b0-7bbf-af933ece3514@amsat.org>
Date: Tue, 12 Jun 2018 13:11:14 -0300
MIME-Version: 1.0
In-Reply-To: <20180612005145.3375-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 06/19] linux-user: Split out do_syscall1
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
> There was supposed to be a single point of return for do_syscall
> so that tracing works properly.  However, there are a few bugs
> in that area.  It is significantly simpler to simply split out
> an inner function to enforce this.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/syscall.c | 77 +++++++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 29 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index c212149245..ec3bc1cbe5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7947,13 +7947,15 @@ static int host_to_target_cpu_mask(const unsigned long *host_mask,
>      return 0;
>  }
>  
> -/* do_syscall() should always have a single exit point at the end so
> -   that actions, such as logging of syscall results, can be performed.
> -   All errnos that do_syscall() returns must be -TARGET_<errcode>. */
> -abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
> -                    abi_long arg2, abi_long arg3, abi_long arg4,
> -                    abi_long arg5, abi_long arg6, abi_long arg7,
> -                    abi_long arg8)
> +/* This is an internal helper for do_syscall so that it is easier
> + * to have a single return point, so that actions, such as logging
> + * of syscall results, can be performed.
> + * All errnos that do_syscall() returns must be -TARGET_<errcode>.
> + */
> +static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
> +                            abi_long arg2, abi_long arg3, abi_long arg4,
> +                            abi_long arg5, abi_long arg6, abi_long arg7,
> +                            abi_long arg8)
>  {
>      CPUState *cpu = ENV_GET_CPU(cpu_env);
>      abi_long ret;
> @@ -7961,25 +7963,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>      struct statfs stfs;
>      void *p;
>  
> -#if defined(DEBUG_ERESTARTSYS)
> -    /* Debug-only code for exercising the syscall-restart code paths
> -     * in the per-architecture cpu main loops: restart every syscall
> -     * the guest makes once before letting it through.
> -     */
> -    {
> -        static int flag;
> -
> -        flag = !flag;
> -        if (flag) {
> -            return -TARGET_ERESTARTSYS;
> -        }
> -    }
> -#endif
> -
> -    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
> -    if(do_strace)
> -        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> -
>      switch(num) {
>      case TARGET_NR_exit:
>          /* In old applications this may be used to implement _exit(2).
> @@ -12765,11 +12748,47 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>          break;
>      }
>  fail:
> -    if(do_strace)
> -        print_syscall_ret(num, ret);
> -    trace_guest_user_syscall_ret(cpu, num, ret);
>      return ret;
>  efault:
>      ret = -TARGET_EFAULT;
>      goto fail;
>  }
> +
> +abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
> +                    abi_long arg2, abi_long arg3, abi_long arg4,
> +                    abi_long arg5, abi_long arg6, abi_long arg7,
> +                    abi_long arg8)
> +{
> +    CPUState *cpu = ENV_GET_CPU(cpu_env);
> +    abi_long ret;
> +
> +#ifdef DEBUG_ERESTARTSYS
> +    /* Debug-only code for exercising the syscall-restart code paths
> +     * in the per-architecture cpu main loops: restart every syscall
> +     * the guest makes once before letting it through.
> +     */
> +    {
> +        static bool flag;
> +        flag = !flag;
> +        if (flag) {
> +            return -TARGET_ERESTARTSYS;
> +        }
> +    }
> +#endif
> +
> +    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
> +                             arg5, arg6, arg7, arg8);
> +
> +    if (unlikely(do_strace)) {
> +        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> +        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> +                          arg5, arg6, arg7, arg8);
> +        print_syscall_ret(num, ret);
> +    } else {
> +        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> +                          arg5, arg6, arg7, arg8);
> +    }
> +
> +    trace_guest_user_syscall_ret(cpu, num, ret);
> +    return ret;
> +}
> 
