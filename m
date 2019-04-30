Received: from eggs.gnu.org ([209.51.188.92]:57499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPJA-0007m4-AR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPJ9-0005qe-4R
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:16 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLPJ8-0005q8-VO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:15 -0400
Received: by mail-ot1-x343.google.com with SMTP id f23so11290374otl.9
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-14-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 10:44:02 +0100
Message-ID: <CAFEAcA_PFGUWdhGuPzjuzW7kdu849iRTGLRNMewT-7RnTAuA+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 13/26] target/nios2: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>

On Wed, 3 Apr 2019 at 04:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/nios2/cpu.h    |   5 +-
>  target/nios2/cpu.c    |   5 +-
>  target/nios2/helper.c | 181 ++++++++++++++++++++----------------------
>  target/nios2/mmu.c    |  12 ---
>  4 files changed, 92 insertions(+), 111 deletions(-)
> --- a/target/nios2/helper.c
> +++ b/target/nios2/helper.c
> @@ -36,17 +36,6 @@ void nios2_cpu_do_interrupt(CPUState *cs)
>      env->regs[R_EA] = env->regs[R_PC] + 4;
>  }
>
> -int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
> -                               int rw, int mmu_idx)
> -{
> -    cs->exception_index = 0xaa;
> -    /* Page 0x1000 is kuser helper */
> -    if (address < 0x1000 || address >= 0x2000) {
> -        cpu_dump_state(cs, stderr, fprintf, 0);
> -    }
> -    return 1;
> -}

For user mode we used to set cs->exception_index to 0xaa...

> +bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                        MMUAccessType access_type, int mmu_idx,
> +                        bool probe, uintptr_t retaddr)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    CPUNios2State *env = &cpu->env;
> +    unsigned int excp = EXCP_TLBD;

...but in the new code we end up setting it to
EXCP_TLBD, which is 12.

> +
> +#ifndef CONFIG_USER_ONLY

[...]

>  #endif /* !CONFIG_USER_ONLY */
> +
> +    cs->exception_index = excp;
> +    env->regs[CR_BADADDR] = address;
> +    cpu_loop_exit_restore(cs, retaddr);
> +}

We also set env->regs[CR_BADADDR], which we weren't
doing before.

We've lost the cpu_dump_state() as well (though I'm not
sure why that was there -- maybe stray debug printing?)

Otherwise the changes look OK (ie no-behaviour-change).

thanks
-- PMM
