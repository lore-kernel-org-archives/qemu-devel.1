Received: from eggs.gnu.org ([2001:4830:134:3::10]:40421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQJqF-00083B-MX
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQJqC-0004ZV-KW
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:45:39 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:64722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dQJqC-0004Yr-9E
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:45:36 -0400
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-7-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e94af6f2-8869-b9e7-b2b8-b3f16713b345@vivier.eu>
Date: Wed, 28 Jun 2017 22:44:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170620205121.26515-7-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 6/6] target-m68k,
 linux-user: manage FP registers in ucontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>

Riku,

could you ACK this patch, so I will add it in my next pull request for m68k?

Thanks,
Laurent

Le 20/06/2017 à 22:51, Laurent Vivier a écrit :
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/signal.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 3d18d1b..d3753e4 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -5673,6 +5673,24 @@ give_sigsegv:
>      force_sigsegv(sig);
>  }
>  
> +static inline void target_rt_save_fpu_state(struct target_ucontext *uc,
> +                                           CPUM68KState *env)
> +{
> +    int i;
> +    target_fpregset_t *fpregs = &uc->tuc_mcontext.fpregs;
> +
> +    __put_user(env->fpcr, &fpregs->f_fpcntl[0]);
> +    __put_user(env->fpsr, &fpregs->f_fpcntl[1]);
> +    /* fpiar is not emulated */
> +
> +    for (i = 0; i < 8; i++) {
> +        uint32_t high = env->fregs[i].d.high << 16;
> +        __put_user(high, &fpregs->f_fpregs[i * 3]);
> +        __put_user(env->fregs[i].d.low,
> +                   (uint64_t *)&fpregs->f_fpregs[i * 3 + 1]);
> +    }
> +}
> +
>  static inline int target_rt_setup_ucontext(struct target_ucontext *uc,
>                                             CPUM68KState *env)
>  {
> @@ -5699,9 +5717,30 @@ static inline int target_rt_setup_ucontext(struct target_ucontext *uc,
>      __put_user(env->pc, &gregs[16]);
>      __put_user(sr, &gregs[17]);
>  
> +    target_rt_save_fpu_state(uc, env);
> +
>      return 0;
>  }
>  
> +static inline void target_rt_restore_fpu_state(CPUM68KState *env,
> +                                               struct target_ucontext *uc)
> +{
> +    int i;
> +    target_fpregset_t *fpregs = &uc->tuc_mcontext.fpregs;
> +
> +    __get_user(env->fpcr, &fpregs->f_fpcntl[0]);
> +    __get_user(env->fpsr, &fpregs->f_fpcntl[1]);
> +    /* fpiar is not emulated */
> +
> +    for (i = 0; i < 8; i++) {
> +        uint32_t high;
> +        __get_user(high, &fpregs->f_fpregs[i * 3]);
> +        env->fregs[i].d.high = high >> 16;
> +        __get_user(env->fregs[i].d.low,
> +                   (uint64_t *)&fpregs->f_fpregs[i * 3 + 1]);
> +    }
> +}
> +
>  static inline int target_rt_restore_ucontext(CPUM68KState *env,
>                                               struct target_ucontext *uc)
>  {
> @@ -5733,6 +5772,8 @@ static inline int target_rt_restore_ucontext(CPUM68KState *env,
>      __get_user(temp, &gregs[17]);
>      cpu_m68k_set_ccr(env, temp);
>  
> +    target_rt_restore_fpu_state(env, uc);
> +
>      return 0;
>  
>  badframe:
> 
