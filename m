Received: from eggs.gnu.org ([208.118.235.92]:59685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eobHI-0005It-HT
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eobFe-0007j1-Ck
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:46:12 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eobFd-0007gn-Mn
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:44:30 -0500
Received: by mail-wr0-x22e.google.com with SMTP id m5so8200575wrg.1
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 12:44:29 -0800 (PST)
References: <CAFEAcA_Tp9cH5CBi4C6CRHpZ4ozygGSFYhdLaURBQOVZ9zVxvA@mail.gmail.com>
	<20180220210137.18018-1-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180220210137.18018-1-alex.bennee@linaro.org>
Date: Wed, 21 Feb 2018 20:44:26 +0000
Message-ID: <87k1v69iol.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: use hardware sqrt if we can
 (EXPERIMENT!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, "open list:ARM" <qemu-arm@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This is an attempt to save some of the cost of sqrt by using the
> inbuilt support of the host hardware. The idea is assuming we start
> with a valid input we can use the hardware. If any tininess issues
> occur this will trip and FPU exception where:
>
>   - we turn off cpu->use_host_fpu
>   - mask the FPU exceptions
>   - return to what we were doing
>
> Once we return we should pick up the fact that there was something
> weird about the operation and fall-back to the pure software
> implementation.
>
> You could imagine this being extended for code generation but instead
> of returning to the code we could exit and re-generate the TB but this
> time with pure software helpers rather than any support from the
> hardware.
>
> This is a sort of fix-it-up after the fact approach because reading
> the FP state is an expensive operation for everything so let's only
> worry about exceptions when they trip...
>
<snip>
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -20,6 +20,7 @@
>  #include "qemu/bitops.h"
>  #include <sys/ucontext.h>
>  #include <sys/resource.h>
> +#include <fenv.h>
>
>  #include "qemu.h"
>  #include "qemu-common.h"
> @@ -639,6 +640,21 @@ static void host_signal_handler(int host_signum, sig=
info_t *info,
>      ucontext_t *uc =3D puc;
>      struct emulated_sigtable *k;
>
> +    /* Catch any FPU exceptions we might get from having tried to use
> +     * the host FPU to speed up some calculations
> +     */
> +    if (host_signum =3D=3D SIGFPE && cpu->use_host_fpu) {
> +        cpu->use_host_fpu =3D false;
> +        /* sadly this gets lost on the context switch when we return */
> +        fedisableexcept(FE_INVALID   |
> +                        FE_OVERFLOW  |
> +                        FE_UNDERFLOW |
> +                        FE_INEXACT);
> +        /* sigaddset(&uc->uc_sigmask, SIGFPE); */
> +        uc->__fpregs_mem.mxcsr |=3D 0x1f80;

This is a bug, the correct place to reset mxcsr for the return is:

        (uc->uc_mcontext.fpregs)->mxcsr |=3D 0x1f80;

--
Alex Benn=C3=A9e
