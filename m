Received: from eggs.gnu.org ([2001:4830:134:3::10]:35174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOqvn-0001UW-CH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOqvj-0003Bl-B2
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:45:51 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43443)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fOqvj-00035A-1H
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:45:47 -0400
References: <20180531041822.5761-1-richard.henderson@linaro.org>
	<20180531041822.5761-2-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <dbd7a0dd-a6db-e9ca-d9fd-7ae5e75efdb4@vivier.eu>
Date: Fri, 1 Jun 2018 22:45:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180531041822.5761-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: Implement signals for
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

Le 31/05/2018 à 06:18, Richard Henderson a écrit :
> All of the existing code was boilerplate from elsewhere,
> and would crash the guest upon the first signal.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/openrisc/target_syscall.h |  23 +--
>  linux-user/openrisc/signal.c         | 210 +++++++++++----------------
>  linux-user/signal.c                  |   2 +-
>  target/openrisc/cpu.c                |   1 +
>  4 files changed, 87 insertions(+), 149 deletions(-)
> 
...
> @@ -148,11 +102,8 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>                      target_siginfo_t *info,
>                      target_sigset_t *set, CPUOpenRISCState *env)
>  {
...
> @@ -160,47 +111,32 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
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

Why do you remove the "ka->sa_flags & SA_SIGINFO"?

> -    /*err |= __clear_user(&frame->uc, offsetof(ucontext_t, uc_mcontext));*/
>      __put_user(0, &frame->uc.tuc_flags);
>      __put_user(0, &frame->uc.tuc_link);
> +
>      target_save_altstack(&frame->uc.tuc_stack, env);
> -    setup_sigcontext(&frame->sc, env, set->sig[0]);
> +    setup_sigcontext(&frame->uc.tuc_mcontext, env);
>  
> -    /*err |= copy_to_user(frame->uc.tuc_sigmask, set, sizeof(*set));*/

other targets have something like:

    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
        __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
    }

to match kernel

        err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));

Do we need it?

Thanks,
Laurent
