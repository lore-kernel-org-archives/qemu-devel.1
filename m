Received: from eggs.gnu.org ([2001:4830:134:3::10]:58595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1chxxW-0002yP-Nw
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 07:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1chxxT-0005f1-Kh
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 07:29:50 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:62115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1chxxT-0005ew-9P
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 07:29:47 -0500
References: <20170225230416.9775-1-bobby.prani@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <50cd1e34-deda-dc9b-2ce9-5c0cf09223cc@vivier.eu>
Date: Sun, 26 Feb 2017 13:29:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170225230416.9775-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Add signal handling support
 for x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: awirth@akamai.com

Le 26/02/2017 à 00:04, Pranith Kumar a écrit :
> Note that x86_64 has only _rt signal handlers. This implementation
> attempts to share code with the x86_32 implementation.
> 
> CC: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Allan Wirth <awirth@akamai.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
> v2: Update with review comments from Laurent Vivier
> ---
>  linux-user/signal.c      | 280 ++++++++++++++++++++++++++++++++++++++---------
>  target/i386/cpu.h        |   2 +
>  target/i386/fpu_helper.c |  12 ++
>  3 files changed, 243 insertions(+), 51 deletions(-)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 8209539555..c8eb854b29 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -254,7 +254,7 @@ int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
>  }
>  
>  #if !defined(TARGET_OPENRISC) && !defined(TARGET_UNICORE32) && \
> -    !defined(TARGET_X86_64) && !defined(TARGET_NIOS2)
> +    !defined(TARGET_NIOS2)
>  /* Just set the guest's signal mask to the specified value; the
>   * caller is assumed to have called block_signals() already.
>   */
> @@ -512,7 +512,7 @@ void signal_init(void)
>      }
>  }
>  
> -#if !(defined(TARGET_X86_64) || defined(TARGET_UNICORE32))
> +#ifndef TARGET_UNICORE32
>  /* Force a synchronously taken signal. The kernel force_sig() function
>   * also forces the signal to "not blocked, not ignored", but for QEMU
>   * that work is done in process_pending_signals().
> @@ -819,9 +819,8 @@ int do_sigaction(int sig, const struct target_sigaction *act,
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
> @@ -835,58 +834,120 @@ struct target_fpxreg {
>  };
>  
>  struct target_xmmreg {
> -    abi_ulong element[4];
> +    uint32_t element[4];
>  };
>  
> -struct target_fpstate {
> +struct target_fpstate_32 {
>      /* Regular FPU environment */
> -    abi_ulong cw;
> -    abi_ulong sw;
> -    abi_ulong tag;
> -    abi_ulong ipoff;
> -    abi_ulong cssel;
> -    abi_ulong dataoff;
> -    abi_ulong datasel;
> -    struct target_fpreg _st[8];
> +    uint32_t cw;
> +    uint32_t sw;
> +    uint32_t tag;
> +    uint32_t ipoff;
> +    uint32_t cssel;
> +    uint32_t dataoff;
> +    uint32_t datasel;
> +    struct target_fpreg st[8];

Why don't you keep the original name "_st"?

>      uint16_t  status;
>      uint16_t  magic;          /* 0xffff = regular FPU data only */
>  
>      /* FXSR FPU environment */
> -    abi_ulong _fxsr_env[6];   /* FXSR FPU env is ignored */
> -    abi_ulong mxcsr;
> -    abi_ulong reserved;
> -    struct target_fpxreg _fxsr_st[8]; /* FXSR FPU reg data is ignored */
> -    struct target_xmmreg _xmm[8];
> -    abi_ulong padding[56];
> +    uint32_t _fxsr_env[6];   /* FXSR FPU env is ignored */
> +    uint32_t mxcsr;
> +    uint32_t reserved;
> +    struct target_fpxreg fxsr_st[8]; /* FXSR FPU reg data is ignored */

"_fxsr_st"?

> @@ -1198,7 +1374,7 @@ long do_rt_sigreturn(CPUX86State *env)
>      struct rt_sigframe *frame;
>      sigset_t set;
>  
> -    frame_addr = env->regs[R_ESP] - 4;
> +    frame_addr = env->regs[R_ESP] - sizeof(abi_ulong);
>      trace_user_do_rt_sigreturn(env, frame_addr);
>      if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1))
>          goto badframe;
> @@ -6421,11 +6597,13 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
>          || defined(TARGET_NIOS2)
>          /* These targets do not have traditional signals.  */
>          setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
> -#else
> +#elif !defined(TARGET_X86_64)
>          if (sa->sa_flags & TARGET_SA_SIGINFO)
>              setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
>          else
>              setup_frame(sig, sa, &target_old_set, cpu_env);
> +#else
> +        setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
>  #endif

You should just add the "defined(TARGET_X86_64)" on the "#if".

Thanks,
Laurent
