Received: from eggs.gnu.org ([2001:4830:134:3::10]:50315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cP9Fs-0005rh-Uk
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cP9Fr-0004XW-Ua
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:43:01 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:36105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cP9Fr-0004XO-Q3
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:42:59 -0500
Received: by mail-ua0-x22b.google.com with SMTP id 88so374389492uaq.3
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 06:42:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170102124424.1031-1-kirkseraph@gmail.com>
References: <20170102124424.1031-1-kirkseraph@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 14:42:38 +0000
Message-ID: <CAFEAcA-9aYRHcn1dAD0xuR9H8sJ__HOK9ayWmsK7H-Cr2rj4SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RESEND PATCH] target-arm/abi32: check for
 segfault in do_kernel_trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seraphime Kirkovski <kirkseraph@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>

On 2 January 2017 at 12:44, Seraphime Kirkovski <kirkseraph@gmail.com> wrote:
> Currently, the cmpxchg implementation tests whether the destination address
> is readable:
>   - if it is, we read the value and continue with the comparison
>   - if isn't, i.e. access to addr would segfault, we assume that src != dest
>     rather than queuing a SIGSEGV.
>
> The same problem exists in the case where src == dest: the code doesn't
> check whether put_user_u32 succeeds.
>
> This fixes both problems by sending a SIGSEGV when the destination address
> is inaccessible.
>
> Signed-off-by: Seraphime Kirkovski <kirkseraph@gmail.com>
> ---
>  linux-user/main.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 75b199f..376b0c3 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -503,6 +503,7 @@ do_kernel_trap(CPUARMState *env)
>      uint32_t addr;
>      uint32_t cpsr;
>      uint32_t val;
> +    target_siginfo_t info;
>
>      switch (env->regs[15]) {
>      case 0xffff0fa0: /* __kernel_memory_barrier */
> @@ -516,13 +517,16 @@ do_kernel_trap(CPUARMState *env)
>          start_exclusive();
>          cpsr = cpsr_read(env);
>          addr = env->regs[2];
> -        /* FIXME: This should SEGV if the access fails.  */
> -        if (get_user_u32(val, addr))
> -            val = ~env->regs[0];
> +        if (get_user_u32(val, addr)) {
> +            env->exception.vaddress = addr;
> +            goto segv;
> +        }
>          if (val == env->regs[0]) {
>              val = env->regs[1];
> -            /* FIXME: Check for segfaults.  */
> -            put_user_u32(val, addr);
> +            if (put_user_u32(val, addr)) {
> +                env->exception.vaddress = addr;
> +                goto segv;
> +            }
>              env->regs[0] = 0;
>              cpsr |= CPSR_C;
>          } else {
> @@ -551,6 +555,16 @@ do_kernel_trap(CPUARMState *env)
>      env->regs[15] = addr;
>
>      return 0;
> +
> +segv:
> +    end_exclusive();
> +    info.si_signo = TARGET_SIGSEGV;
> +    info.si_errno = 0;
> +    /* XXX: check env->error_code */
> +    info.si_code = TARGET_SEGV_MAPERR;
> +    info._sifields._sigfault._addr = env->exception.vaddress;
> +    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +    return 0;

If you compare what happens with this segv code with
what happens for the segvs detected inside
arm_kernel_cmpxchg64_helper(), there's a difference.
With this code we will queue the signal and then return,
skipping the code which updates env->regs[15] and env->thumb.
The existing codepath for cmpxchg64 doesn't skip that code.
The effect is that for cmpxchg64 the SEGV signal handler
will see a PC pointing at the call into the kernel commpage,
whereas for this code it will see the PC actually in the
kernel commpage.

I'm not sure which of these options is the best choice,
but I do think we should be consistent.

>  }
>
>  void cpu_loop(CPUARMState *env)
> --
> 2.10.2

thanks
-- PMM
