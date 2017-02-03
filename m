Received: from eggs.gnu.org ([2001:4830:134:3::10]:37576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cZlr4-0003Vl-Gw
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cZlr1-000566-4b
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:57:18 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cZlr0-00055I-Q9
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:57:15 -0500
References: <20170125001041.14029-1-bobby.prani@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <24151c6e-2c30-ae82-9b91-aa1c6cad6e81@vivier.eu>
Date: Fri, 3 Feb 2017 22:56:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170125001041.14029-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] linux-user: Add signal handling for
 x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Allan Wirth <awirth@akamai.com>

Le 25/01/2017 à 01:10, Pranith Kumar a écrit :
> Adopted from a previous patch posting:
> https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg02079.html
> 
> CC: Allan Wirth <awirth@akamai.com>
> CC: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  linux-user/signal.c      | 264 ++++++++++++++++++++++++++++++++++++++++-------
>  target/i386/cpu.h        |   2 +
>  target/i386/fpu_helper.c |  12 +++
>  3 files changed, 242 insertions(+), 36 deletions(-)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 0a5bb4e26b..0248621d66 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -253,8 +253,7 @@ int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
>      return 0;
>  }
>  
> -#if !defined(TARGET_OPENRISC) && !defined(TARGET_UNICORE32) && \
> -    !defined(TARGET_X86_64)
> +#if !defined(TARGET_OPENRISC) && !defined(TARGET_UNICORE32)
>  /* Just set the guest's signal mask to the specified value; the
>   * caller is assumed to have called block_signals() already.
>   */
> @@ -512,7 +511,7 @@ void signal_init(void)
>      }
>  }
>  
> -#if !(defined(TARGET_X86_64) || defined(TARGET_UNICORE32))
> +#ifndef TARGET_UNICORE32
>  /* Force a synchronously taken signal. The kernel force_sig() function
>   * also forces the signal to "not blocked, not ignored", but for QEMU
>   * that work is done in process_pending_signals().
> @@ -819,9 +818,8 @@ int do_sigaction(int sig, const struct target_sigaction *act,
>      return ret;
>  }
>  
> -#if defined(TARGET_I386) && TARGET_ABI_BITS == 32
> -
> -/* from the Linux kernel */
> +#if defined(TARGET_I386)
> +/* from the Linux kernel - /arch/x86/include/uapi/asm/sigcontext.h */
>  
>  struct target_fpreg {
>      uint16_t significand[4];
> @@ -835,7 +833,7 @@ struct target_fpxreg {
>  };
>  
>  struct target_xmmreg {
> -    abi_ulong element[4];
> +    uint32_t element[4];
>  };
>  
>  struct target_fpstate {
> @@ -860,33 +858,117 @@ struct target_fpstate {
>      abi_ulong padding[56];
>  };

I think you should remove the definition of the target_fpstate structure
as you overwrite it with #define below:
...
> +
> +#ifndef TARGET_X86_64
> +# define target_fpstate target_fpstate_32
> +#else
> +# define target_fpstate target_fpstate_64
> +#endif
> +
...
> @@ -959,12 +1052,49 @@ static void setup_sigcontext(struct target_sigcontext *sc,
>      /* non-iBCS2 extensions.. */
>      __put_user(mask, &sc->oldmask);
>      __put_user(env->cr[2], &sc->cr2);
> +#else
> +    __put_user(env->regs[8], &sc->r8);
> +    __put_user(env->regs[9], &sc->r9);
> +    __put_user(env->regs[10], &sc->r10);
> +    __put_user(env->regs[11], &sc->r11);
> +    __put_user(env->regs[12], &sc->r12);
> +    __put_user(env->regs[13], &sc->r13);
> +    __put_user(env->regs[14], &sc->r14);
> +    __put_user(env->regs[15], &sc->r15);
> +
> +    __put_user(env->regs[R_EDI], &sc->rdi);
> +    __put_user(env->regs[R_ESI], &sc->rsi);
> +    __put_user(env->regs[R_EBP], &sc->rbp);
> +    __put_user(env->regs[R_EBX], &sc->rbx);
> +    __put_user(env->regs[R_EDX], &sc->rdx);
> +    __put_user(env->regs[R_EAX], &sc->rax);
> +    __put_user(env->regs[R_ECX], &sc->rcx);
> +    __put_user(env->regs[R_ESP], &sc->rsp);
> +    __put_user(env->eip, &sc->rip);
> +
> +    __put_user(env->eflags, &sc->eflags);
> +
> +    __put_user(env->segs[R_CS].selector, &sc->cs);
> +    __put_user((uint16_t)0, &sc->gs);
> +    __put_user((uint16_t)0, &sc->fs);
> +    __put_user(env->segs[R_SS].selector, &sc->ss);
> +
> +    __put_user(env->error_code, &sc->err);
> +    __put_user(cs->exception_index, &sc->trapno);
> +    __put_user(mask, &sc->oldmask);
> +    __put_user(env->cr[2], &sc->cr2);
> +
> +    /* fpstate_addr must be 16 byte aligned for fxsave */
> +    assert(!(fpstate_addr & 0xf));
> +
> +    cpu_x86_fxsave(env, fpstate_addr);
> +    __put_user(fpstate_addr, &sc->fpstate);
> +#endif

This part would be more readable if the registers were in the same order
as  in the kernel function setup_sigcontext().
...
> +    if (info) {
> +        tswap_siginfo(&frame->info, info);
> +    }

kernel checks "ksig->ka.sa.sa_flags & SA_SIGINFO" to know if there is
siginfo structure.

...
>      /* Set up registers for signal handler */
>      env->regs[R_ESP] = frame_addr;
> +    env->regs[R_EAX] = 0;
> +    env->regs[R_EDI] = sig;
> +    env->regs[R_ESI] = (unsigned long)&frame->info;
> +    env->regs[R_EDX] = (unsigned long)&frame->uc;
>      env->eip = ka->_sa_handler;

In kernel, 32bit handler seems to not use the same registers as 64bit
handler, for instance ax is sig, info is dx and uc is cx.

...
> @@ -6181,11 +6371,13 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
>          || defined(TARGET_PPC64) || defined(TARGET_HPPA)
>          /* These targets do not have traditional signals.  */
>          setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
> -#else
> +#elif !defined(TARGET_X86_64)
>          if (sa->sa_flags & TARGET_SA_SIGINFO)
>              setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
>          else
>              setup_frame(sig, sa, &target_old_set, cpu_env);
> +#else
> +        setup_rt_frame(sig, sa, 0, &target_old_set, cpu_env);

Why do we use "0" instead of "&k->info"?

Laurent
