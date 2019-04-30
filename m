Received: from eggs.gnu.org ([209.51.188.92]:55341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLP6u-0003SP-IP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLP6t-0006SG-Lp
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:31:36 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLP6t-0006Rb-Bf
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:31:35 -0400
Received: by mail-oi1-x241.google.com with SMTP id v23so10528177oif.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-15-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 10:31:23 +0100
Message-ID: <CAFEAcA8PzZV0yDY6gONx+wwN8j52yPi6bEAM5C0NwVCkxd_Hxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 14/26] target/openrisc: Convert to
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

On Wed, 3 Apr 2019 at 04:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> --- a/target/openrisc/mmu.c
> +++ b/target/openrisc/mmu.c
> @@ -107,16 +107,42 @@ static void raise_mmu_exception(OpenRISCCPU *cpu, target_ulong address,
>      cpu->env.lock_addr = -1;
>  }
>
> -int openrisc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
> -                                  int rw, int mmu_idx)
> +bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> +                           MMUAccessType access_type, int mmu_idx,
> +                           bool probe, uintptr_t retaddr)
>  {
> -#ifdef CONFIG_USER_ONLY
>      OpenRISCCPU *cpu = OPENRISC_CPU(cs);
> -    raise_mmu_exception(cpu, address, EXCP_DPF);
> -    return 1;
> -#else
> -    g_assert_not_reached();
> +    int excp = EXCP_DPF;

Let's hope no compilers complain that this assignment is
never used in the softmmu configuration (where the following
code always sets it to something else)...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
