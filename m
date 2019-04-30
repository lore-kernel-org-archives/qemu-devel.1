Received: from eggs.gnu.org ([209.51.188.92]:58419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRSp-0006G1-AB
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRSn-0007x7-AX
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:02:23 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRSn-0007vy-6I
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:02:21 -0400
Received: by mail-ot1-x341.google.com with SMTP id r20so10492692otg.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-5-richard.henderson@linaro.org>
	<CAFEAcA_c+RSOmxHcoNueRtAoQAZZCfeSt-4F2GFe=BhSg_1jXg@mail.gmail.com>
In-Reply-To: <CAFEAcA_c+RSOmxHcoNueRtAoQAZZCfeSt-4F2GFe=BhSg_1jXg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 13:02:07 +0100
Message-ID: <CAFEAcA_hGbmmekSutR5t=DV2zTHnWWeSJ1+viaKipR9OVmW+HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 04/26] target/arm: Convert to
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Wed, 3 Apr 2019 at 06:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 3 Apr 2019 at 10:44, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>
> > +bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> > +                      MMUAccessType access_type, int mmu_idx,
> > +                      bool probe, uintptr_t retaddr)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(cs);
> > +
> > +#ifdef CONFIG_USER_ONLY
> > +    cpu->env.exception.vaddress = address;
> > +    if (access_type == MMU_INST_FETCH) {
> > +        cs->exception_index = EXCP_PREFETCH_ABORT;
> > +    } else {
> > +        cs->exception_index = EXCP_DATA_ABORT;
> > +    }
> > +    cpu_loop_exit_restore(cs, retaddr);
> > +#else
> > +    hwaddr phys_addr;
> > +    target_ulong page_size;
> > +    int prot, ret;
> > +    MemTxAttrs attrs = {};
> > +    ARMMMUFaultInfo fi = {};
> > +
> > +    /*
> > +     * Walk the page table and (if the mapping exists) add the page
> > +     * to the TLB. Return false on success, or true on failure. Populate
> > +     * fsr with ARM DFSR/IFSR fault register format value on failure.
> > +     */
>
> This comment about what we return doesn't seem to match what
> the code is doing.

Other than fixing up the comment,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
