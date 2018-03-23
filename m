Received: from eggs.gnu.org ([2001:4830:134:3::10]:32851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezNWL-0005my-Hb
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezNWK-0002WI-Cn
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:18:17 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:39764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezNWK-0002Vk-7C
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:18:16 -0400
Received: by mail-ot0-x243.google.com with SMTP id h8-v6so13390451oti.6
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 07:18:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180322215833.7713-4-laurent@vivier.eu>
References: <20180322215833.7713-1-laurent@vivier.eu>
	<20180322215833.7713-4-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 14:17:55 +0000
Message-ID: <CAFEAcA8fTCNdZurrXY9vpNfJugqsfpGgTAhWKBEM34pMzW4+vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.13 3/5] linux-user: define
 TARGET_ARCH_HAS_SETUP_FRAME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 22 March 2018 at 21:58, Laurent Vivier <laurent@vivier.eu> wrote:
> instead of calling setup_frame() conditionnaly to a list of knowm targets,

"Instead". "conditionally". "known".

> define TARGET_ARCH_HAS_SETUP_FRAME if the target provides the function
> and call it only if the macro is defined

Trailing ".".

>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---

> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -886,18 +886,13 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
>          }
>  #endif
>          /* prepare the stack frame of the virtual CPU */
> -#if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64) \
> -        || defined(TARGET_OPENRISC) || defined(TARGET_TILEGX) \
> -        || defined(TARGET_PPC64) || defined(TARGET_HPPA) \
> -        || defined(TARGET_NIOS2) || defined(TARGET_X86_64) \
> -        || defined(TARGET_RISCV) || defined(TARGET_XTENSA)
> -        /* These targets do not have traditional signals.  */
> -        setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
> -#else
> +#if defined(TARGET_ARCH_HAS_SETUP_FRAME)
>          if (sa->sa_flags & TARGET_SA_SIGINFO)
>              setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
>          else
>              setup_frame(sig, sa, &target_old_set, cpu_env);
> +#else
> +        setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
>  #endif
>          if (sa->sa_flags & TARGET_SA_RESETHAND) {
>              sa->_sa_handler = TARGET_SIG_DFL;

You might like to add the {} to the if (sa->sa_flags...) while we're
here.

Either way,

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
