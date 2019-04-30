Received: from eggs.gnu.org ([209.51.188.92]:57084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLROj-0002f6-IK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLROi-0005Gz-If
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:58:09 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLROi-0005Et-C4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:58:08 -0400
Received: by mail-ot1-x343.google.com with SMTP id t20so11629075otl.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 04:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-6-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 12:57:56 +0100
Message-ID: <CAFEAcA-LJfcTp2BNtug3XM39jTUQSEu3wNrgYmJih6cvPubShg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/26] target/cris: Convert to
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

On Wed, 3 Apr 2019 at 04:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/cris/cpu.h       |  5 +--
>  target/cris/cpu.c       |  5 ++-
>  target/cris/helper.c    | 67 +++++++++++++++++++++++------------------
>  target/cris/op_helper.c | 28 -----------------
>  4 files changed, 42 insertions(+), 63 deletions(-)

> -int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
> -                              int mmu_idx)
> +bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr)
>  {
>      CRISCPU *cpu = CRIS_CPU(cs);
>
>      cs->exception_index = 0xaa;
>      cpu->env.pregs[PR_EDA] = address;
> -    cpu_dump_state(cs, stderr, fprintf, 0);
> -    return 1;
> +    cpu_loop_exit_restore(cs, retaddr);

You might mention in the commit message that we removed the
cpu_dump_state().

> +    env->pregs[PR_EDA] = address;
> +    cs->exception_index = EXCP_BUSFAULT;
> +    env->fault_vector = res.bf_vec;
> +    if (retaddr) {
> +        if (cpu_restore_state(cs, retaddr, true)) {
> +            /* Evaluate flags after retranslation. */
> +            helper_top_evaluate_flags(env);

Side note because the old code does the same thing, but it seems
weird that we have to manually recalculate the flags here -- I
would expect cpu_restore_state() to actually restore the state
(presumably by having restore_state_to_opc() do the fixing up
of the flags?).

> +        }
> +    }
> +    cpu_loop_exit(cs);
> +}

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
