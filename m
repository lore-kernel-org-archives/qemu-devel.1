Received: from eggs.gnu.org ([209.51.188.92]:56027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPAY-0004bY-J4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPAX-0000UV-BH
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:35:22 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLPAX-0000Tv-5P
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:35:21 -0400
Received: by mail-oi1-x244.google.com with SMTP id d62so4826935oib.13
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-16-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 10:35:09 +0100
Message-ID: <CAFEAcA_tgrZBuwcTZLKro-C4tS+vy5a0Bm7ZvZjr+yL_UnNb_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 15/26] target/ppc: Convert to
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 3 Apr 2019 at 04:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: qemu-ppc@nongnu.org
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/cpu.h                |  7 +++----
>  target/ppc/mmu_helper.c         | 19 +++++++++++++------
>  target/ppc/translate_init.inc.c |  5 ++---
>  target/ppc/user_only_helper.c   | 14 ++++++++------
>  4 files changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 0707177584..da73d3ee5b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1297,10 +1297,9 @@ void ppc_translate_init(void);
>     is returned if the signal was handled by the virtual CPU.  */
>  int cpu_ppc_signal_handler (int host_signum, void *pinfo,
>                              void *puc);
> -#if defined(CONFIG_USER_ONLY)
> -int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
> -                             int mmu_idx);
> -#endif
> +bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                      MMUAccessType access_type, int mmu_idx,
> +                      bool probe, uintptr_t retaddr);
>
>  #if !defined(CONFIG_USER_ONLY)
>  void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 4a6be4d63b..6865c0ca37 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -3026,12 +3026,9 @@ void helper_check_tlb_flush_global(CPUPPCState *env)
>
>  /*****************************************************************************/
>
> -/* try to fill the TLB and return an exception if error. If retaddr is
> -   NULL, it means that the function was called in C code (i.e. not
> -   from generated code or from helper.c) */
> -/* XXX: fix it to restore all registers */

Is this XXX comment definitely no longer relevant ?

> -void tlb_fill(CPUState *cs, target_ulong addr, int size,
> -              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> +bool ppc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> +                      MMUAccessType access_type, int mmu_idx,
> +                      bool probe, uintptr_t retaddr)
>  {
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
