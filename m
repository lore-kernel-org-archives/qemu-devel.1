Received: from eggs.gnu.org ([209.51.188.92]:40320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6z1-0004yU-Ac
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6yw-0006id-JS
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:10:15 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6yw-0006hR-Cy
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:10:10 -0400
Received: by mail-oi1-x244.google.com with SMTP id k9so5349983oig.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-11-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:09:58 +0100
Message-ID: <CAFEAcA8y47RpfpuwqagRDMTJpZLyVkhNV_NF0y6_qVhopoeAGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 10/36] target/cris: Use env_cpu,
 env_archcpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Mar 2019 at 23:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/cris/cpu.h          |  5 -----
>  linux-user/cris/cpu_loop.c |  2 +-
>  target/cris/mmu.c          |  3 +--
>  target/cris/op_helper.c    | 10 +++-------
>  target/cris/translate.c    |  2 +-
>  5 files changed, 6 insertions(+), 16 deletions(-)

> --- a/target/cris/mmu.c
> +++ b/target/cris/mmu.c
> @@ -290,7 +290,6 @@ static int cris_mmu_translate_page(struct cris_mmu_result *res,
>
>  void cris_mmu_flush_pid(CPUCRISState *env, uint32_t pid)
>  {
> -    CRISCPU *cpu = cris_env_get_cpu(env);
>         target_ulong vaddr;
>         unsigned int idx;
>         uint32_t lo, hi;
> @@ -316,7 +315,7 @@ void cris_mmu_flush_pid(CPUCRISState *env, uint32_t pid)
>                                         vaddr = tlb_vpn << TARGET_PAGE_BITS;
>                                         D_LOG("flush pid=%x vaddr=%x\n",
>                                                   pid, vaddr);
> -                    tlb_flush_page(CPU(cpu), vaddr);
> +                    tlb_flush_page(env_cpu(env), vaddr);
>                                 }
>                         }
>                 }

> @@ -143,7 +139,7 @@ void helper_movl_sreg_reg(CPUCRISState *env, uint32_t sreg, uint32_t reg)
>                         D_LOG("tlb flush vaddr=%x v=%d pc=%x\n",
>                                   vaddr, tlb_v, env->pc);
>                         if (tlb_v) {
> -                tlb_flush_page(CPU(cpu), vaddr);
> +                tlb_flush_page(env_cpu(env), vaddr);
>                         }
>                 }
>         }

This file is a mess because it's old-school hard-tabs, but maybe
fix the indent on these lines while you're changing them?

Either way
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
