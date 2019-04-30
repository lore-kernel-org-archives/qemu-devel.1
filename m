Received: from eggs.gnu.org ([209.51.188.92]:41192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQIx-0000SX-5Y
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQIw-0004wE-7I
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:48:07 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLQIw-0004vo-1H
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:48:06 -0400
Received: by mail-ot1-x344.google.com with SMTP id n15so5393254ota.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-13-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 11:47:54 +0100
Message-ID: <CAFEAcA9VotyrbWMSjfg-M565sE-HTiyJ_ZhfcvKku0u0fDa9Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 12/26] target/moxie: Convert to
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anthony Green <green@moxielogic.com>

On Wed, 3 Apr 2019 at 04:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Anthony Green <green@moxielogic.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

>
> -#if defined(CONFIG_USER_ONLY)
> -
> -void moxie_cpu_do_interrupt(CPUState *cs)
> -{
> -    CPUState *cs = CPU(moxie_env_get_cpu(env));
> -
> -    cs->exception_index = -1;
> -}
> -
> -int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
> -                               int rw, int mmu_idx)
> -{
> -    MoxieCPU *cpu = MOXIE_CPU(cs);
> -
> -    cs->exception_index = 0xaa;
> -    cpu->env.debug1 = address;
> -    cpu_dump_state(cs, stderr, fprintf, 0);
> -    return 1;
> -}

The commit message should say that we can just delete the old
user-only code because we don't have a moxie-linux-user config.

> -
> -#else /* !CONFIG_USER_ONLY */
> -
> -int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
> -                               int rw, int mmu_idx)
> +bool moxie_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                        MMUAccessType access_type, int mmu_idx,
> +                        bool probe, uintptr_t retaddr)
>  {
>      MoxieCPU *cpu = MOXIE_CPU(cs);
>      CPUMoxieState *env = &cpu->env;
>      MoxieMMUResult res;
>      int prot, miss;
> -    target_ulong phy;
> -    int r = 1;
>
>      address &= TARGET_PAGE_MASK;
>      prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> -    miss = moxie_mmu_translate(&res, env, address, rw, mmu_idx);
> -    if (miss) {
> -        /* handle the miss.  */
> -        phy = 0;
> -        cs->exception_index = MOXIE_EX_MMU_MISS;
> -    } else {
> -        phy = res.phy;
> -        r = 0;
> +    miss = moxie_mmu_translate(&res, env, address, access_type, mmu_idx);
> +    if (likely(!miss)) {
> +        tlb_set_page(cs, address, res.phy, prot, mmu_idx, TARGET_PAGE_SIZE);
> +        return true;
> +    }
> +    if (probe) {
> +        return false;
>      }
> -    tlb_set_page(cs, address, phy, prot, mmu_idx, TARGET_PAGE_SIZE);
> -    return r;
> -}
>
> +    cs->exception_index = MOXIE_EX_MMU_MISS;
> +    cpu_loop_exit_restore(cs, retaddr);
> +}

The old code was calling tlb_set_page() even on an MMU miss,
and the new could doesn't do that. This looks like it was
a bug to me, but if we're fixing bugs we should mention them
in the commit message, at least.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
