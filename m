Received: from eggs.gnu.org ([209.51.188.92]:49458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLWcH-0000sC-Cp
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLWcG-0006iz-Ao
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:32:29 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:37759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hLWcG-0006gy-6Z
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:32:28 -0400
Received: by mail-yw1-xc43.google.com with SMTP id a62so6512077ywa.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-24-richard.henderson@linaro.org>
	<CAFEAcA_FZHKXJHg4819JOZkwwhE44Vx874GKrnxRrOau1HhzRw@mail.gmail.com>
In-Reply-To: <CAFEAcA_FZHKXJHg4819JOZkwwhE44Vx874GKrnxRrOau1HhzRw@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 30 Apr 2019 10:32:14 -0700
Message-ID: <CAMo8BfJVdDvYWEdN_08ed5OKBGXc+U8kSbmWaSWY9WCuvDj2pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 23/26] target/xtensa: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Apr 30, 2019 at 3:11 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 3 Apr 2019 at 05:00, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/xtensa/cpu.h    |  5 +--
> >  target/xtensa/cpu.c    |  5 ++-
> >  target/xtensa/helper.c | 74 +++++++++++++++++++++---------------------
> >  3 files changed, 42 insertions(+), 42 deletions(-)
>
> > -#ifdef CONFIG_USER_ONLY
> > -
> > -int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
> > -                                int mmu_idx)
> > +bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> > +                         MMUAccessType access_type, int mmu_idx,
> > +                         bool probe, uintptr_t retaddr)
> >  {
> >      XtensaCPU *cpu = XTENSA_CPU(cs);
> >      CPUXtensaState *env = &cpu->env;
> > +    target_ulong vaddr = address;
> > +    int ret;
> >
> > -    qemu_log_mask(CPU_LOG_INT,
> > -                  "%s: rw = %d, address = 0x%08" VADDR_PRIx ", size = %d\n",
> > -                  __func__, rw, address, size);
> > -    env->sregs[EXCVADDR] = address;
> > -    env->sregs[EXCCAUSE] = rw ? STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE;
> > -    cs->exception_index = EXC_USER;
> > -    return 1;
>
> Previously we set exception_index to EXC_USER...
>
> > +#ifdef CONFIG_USER_ONLY
> > +    ret = (access_type == MMU_DATA_STORE ?
> > +           STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE);
> > +#else
> > +    uint32_t paddr;
> > +    uint32_t page_size;
> > +    unsigned access;
> > +
> > +    ret = xtensa_get_physical_addr(env, true, vaddr, access_type, mmu_idx,
> > +                                   &paddr, &page_size, &access);
> > +
> > +    qemu_log_mask(CPU_LOG_MMU, "%s(%08x, %d, %d) -> %08x, ret = %d\n",
> > +                  __func__, vaddr, access_type, mmu_idx, paddr, ret);
> > +
> > +    if (ret == 0) {
> > +        tlb_set_page(cs, vaddr & TARGET_PAGE_MASK, paddr & TARGET_PAGE_MASK,
> > +                     access, mmu_idx, page_size);
> > +        return true;
> > +    }
> > +    if (probe) {
> > +        return false;
> > +    }
> > +#endif
> > +
> > +    cpu_restore_state(cs, retaddr, true);
> > +    HELPER(exception_cause_vaddr)(env, env->pc, ret, vaddr);
>
> ...but now we'll set it to whatever exception_cause_vaddr does,
> which is something more complicated based on the state of
> env->sregs[PS].
>
> We'll also end up setting env->sregs[PS] bits and env->pc, which
> the old code did not. (In particular since we set the PS_EXCM bit,
> the second time we take an exception won't we then end up
> setting exception_index to EXC_DOUBLE, not EXC_USER ?)

I guess it doesn't matter, because linux-user userspace never handles
exceptions. PS, PC and similar must be fixed up by the linux-user
exception handler. But I haven't tested it.
Richard, is there a branch with this series available somewhere?

-- 
Thanks.
-- Max
