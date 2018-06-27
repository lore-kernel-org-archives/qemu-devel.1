Received: from eggs.gnu.org ([2001:4830:134:3::10]:39208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYGLN-0002Dx-Pk
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYGLK-0007ma-M0
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:43:09 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fYGLK-0007kj-Bo
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:43:06 -0400
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-22-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <53040926-8347-30f7-98a5-689441575c76@vivier.eu>
Date: Wed, 27 Jun 2018 21:43:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180618184046.6270-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 21/22] linux-user: Implement signals for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: shorne@gmail.com

Le 18/06/2018 à 20:40, Richard Henderson a écrit :
> All of the existing code was boilerplate from elsewhere,
> and would crash the guest upon the first signal.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> v2:
>   Add a comment to the new definition of target_pt_regs.
>   Install the signal mask into the ucontext.
> ---
>  linux-user/openrisc/target_syscall.h |  28 +---
>  linux-user/openrisc/signal.c         | 212 +++++++++++----------------
>  linux-user/signal.c                  |   2 +-
>  target/openrisc/cpu.c                |   1 +
>  4 files changed, 95 insertions(+), 148 deletions(-)
> 
...
> diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
> index 8be0b74001..ea083ef15e 100644
> --- a/linux-user/openrisc/signal.c
> +++ b/linux-user/openrisc/signal.c
...
>  static inline abi_ulong get_sigframe(struct target_sigaction *ka,
> -                                     CPUOpenRISCState *regs,
> +                                     CPUOpenRISCState *env,
>                                       size_t frame_size)
>  {
> -    unsigned long sp = get_sp_from_cpustate(regs);
> +    target_ulong sp = get_sp_from_cpustate(env);
>      int onsigstack = on_sig_stack(sp);
>  
> -    /* redzone */
> -    sp = target_sigsp(sp, ka);
> -
> +    /* Honor redzone now.  If we swap to signal stack, no need to waste
> +     * the 128 bytes by subtracting afterward.
> +     */
> +    sp = target_sigsp(sp - 128, ka);
>      sp = align_sigframe(sp - frame_size);
>  
> -    /*
> -     * If we are on the alternate signal stack and would overflow it, don't.
> +    /* If we are on the alternate signal stack and would overflow it, don't.
>       * Return an always-bogus address instead so we will die with SIGSEGV.
>       */
> -
> -    if (onsigstack && !likely(on_sig_stack(sp))) {
> +    if (onsigstack && !on_sig_stack(sp)) {
>          return -1L;
>      }

This part has been removed from the kernel since:

    8e2beafa2f7f openrisc: Use sigsp()

and we use target_sigsp().

> -
>      return sp;
>  }
>  
> @@ -147,11 +101,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>                      target_siginfo_t *info,
>                      target_sigset_t *set, CPUOpenRISCState *env)
>  {
> -    int err = 0;
>      abi_ulong frame_addr;
> -    unsigned long return_ip;
> -    struct target_rt_sigframe *frame;
> -    abi_ulong info_addr, uc_addr;
> +    target_rt_sigframe *frame;
> +    int i;
>  
>      frame_addr = get_sigframe(ka, env, sizeof(*frame));
>      trace_user_setup_rt_frame(env, frame_addr);
> @@ -159,47 +111,35 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>          goto give_sigsegv;
>      }
>  
> -    info_addr = frame_addr + offsetof(struct target_rt_sigframe, info);
> -    __put_user(info_addr, &frame->pinfo);
> -    uc_addr = frame_addr + offsetof(struct target_rt_sigframe, uc);
> -    __put_user(uc_addr, &frame->puc);
> +    tswap_siginfo(&frame->info, info);
>  
> -    if (ka->sa_flags & SA_SIGINFO) {
> -        tswap_siginfo(&frame->info, info);
> -    }

According to your answer to my comment of the v1, you should keep this.
Did you change your mind?

...
>  long do_rt_sigreturn(CPUOpenRISCState *env)
>  {
> +    abi_ulong frame_addr = cpu_get_gpr(env, 1);

You should use get_sp_from_cpustate(env)

Thanks,
Laurent
