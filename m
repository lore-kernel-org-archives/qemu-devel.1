Received: from eggs.gnu.org ([209.51.188.92]:43795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQZJ-0003q8-G6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQZH-0000B9-J6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:05:00 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLQZH-00009h-13
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:04:59 -0400
Received: by mail-oi1-x244.google.com with SMTP id t81so10850720oig.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 04:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-11-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 12:04:46 +0100
Message-ID: <CAFEAcA8RQt83x008=+6J2ijUomL=7Ou3qF-=2sWmp9-K57sS-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/26] target/microblaze: Convert to
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

On Wed, 3 Apr 2019 at 04:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>



> -#if defined(CONFIG_USER_ONLY)
> +bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                     MMUAccessType access_type, int mmu_idx,
> +                     bool probe, uintptr_t retaddr)
> +{
> +    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
> +    CPUMBState *env = &cpu->env;
> +
> +#ifndef CONFIG_USER_ONLY
> +    uint32_t vaddr, paddr;
> +    struct microblaze_mmu_lookup lu;
> +    unsigned int hit;
> +    int prot;
> +
> +    if (mmu_idx == MMU_NOMMU_IDX) {
> +        /* MMU disabled or not available.  */
> +        address &= TARGET_PAGE_MASK;
> +        prot = PAGE_BITS;
> +        tlb_set_page(cs, address, address, prot, mmu_idx, TARGET_PAGE_SIZE);
> +        return true;
> +    }
> +
> +    hit = mmu_translate(&env->mmu, &lu, address, access_type, mmu_idx);
> +    if (likely(hit)) {
> +        vaddr = address & TARGET_PAGE_MASK;
> +        paddr = lu.paddr + vaddr - lu.vaddr;
> +
> +        qemu_log_mask(CPU_LOG_MMU, "MMU map mmu=%d v=%x p=%x prot=%x\n",
> +                      mmu_idx, vaddr, paddr, lu.prot);
> +        tlb_set_page(cs, vaddr, paddr, lu.prot, mmu_idx, TARGET_PAGE_SIZE);
> +        return true;
> +    }
> +
> +    /* TLB miss.  */
> +    if (probe) {
> +        return false;
> +    }
> +
> +    qemu_log_mask(CPU_LOG_MMU, "mmu=%d miss v=%" VADDR_PRIx "\n",
> +                  mmu_idx, address);
> +
> +    switch (lu.err) {
> +    case ERR_PROT:
> +        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ? 17 : 16;
> +        env->sregs[SR_ESR] |= (access_type == MMU_DATA_STORE) << 10;
> +        break;
> +    case ERR_MISS:
> +        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ? 19 : 18;
> +        env->sregs[SR_ESR] |= (access_type == MMU_DATA_STORE) << 10;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (cs->exception_index == EXCP_MMU) {
> +        cpu_abort(cs, "recursive faults\n");
> +    }
> +#endif
> +
> +    env->sregs[SR_EAR] = address;
> +    cs->exception_index = EXCP_MMU;
> +    cpu_loop_exit_restore(cs, retaddr);
> +}


> -int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
> -                            int mmu_idx)
> -{
> -    cs->exception_index = 0xaa;
> -    cpu_dump_state(cs, stderr, fprintf, 0);
> -    return 1;
> -}
> -
> -#else /* !CONFIG_USER_ONLY */

For the user-mode case we used to set cs->exception_state to 0xaa,
but now we set it to EXCP_MMU. We also set SR_EAR which we didn't
previously.

Otherwise the refactoring looks ok.

thanks
-- PMM
