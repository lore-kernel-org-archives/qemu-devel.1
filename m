Received: from eggs.gnu.org ([2001:4830:134:3::10]:47535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWlH1-0002ZP-NI
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWlH0-0005Ul-OT
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:52:43 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWlH0-0005Tq-Fw
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:52:42 -0500
Received: by mail-ot1-x344.google.com with SMTP id 40so14687322oth.4
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 08:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-18-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 16:52:30 +0000
Message-ID: <CAFEAcA_stGu-L5oH2gLbmsnS2QVPOxz4kg-ToJQfWSHmMf1unA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 17/26] target/arm: Reuse aa64_va_parameters
 for setting tbflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Fri, 7 Dec 2018 at 10:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The arm_regime_tbi{0,1} functions are replacable with the new function
> by giving the lowest and highest address.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    | 35 -----------------------------
>  target/arm/helper.c | 55 +++++++++------------------------------------
>  2 files changed, 10 insertions(+), 80 deletions(-)

> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 99ceed2cab..3ad5909b1e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8967,48 +8967,6 @@ static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
>      return mmu_idx;
>  }
>
> -/* Returns TBI0 value for current regime el */
> -uint32_t arm_regime_tbi0(CPUARMState *env, ARMMMUIdx mmu_idx)
> -{
> -    TCR *tcr;
> -    uint32_t el;
> -
> -    /* For EL0 and EL1, TBI is controlled by stage 1's TCR, so convert
> -     * a stage 1+2 mmu index into the appropriate stage 1 mmu index.
> -     */
> -    mmu_idx = stage_1_mmu_idx(mmu_idx);
> -
> -    tcr = regime_tcr(env, mmu_idx);
> -    el = regime_el(env, mmu_idx);
> -
> -    if (el > 1) {
> -        return extract64(tcr->raw_tcr, 20, 1);
> -    } else {
> -        return extract64(tcr->raw_tcr, 37, 1);
> -    }
> -}
> -
> -/* Returns TBI1 value for current regime el */
> -uint32_t arm_regime_tbi1(CPUARMState *env, ARMMMUIdx mmu_idx)
> -{
> -    TCR *tcr;
> -    uint32_t el;
> -
> -    /* For EL0 and EL1, TBI is controlled by stage 1's TCR, so convert
> -     * a stage 1+2 mmu index into the appropriate stage 1 mmu index.
> -     */
> -    mmu_idx = stage_1_mmu_idx(mmu_idx);
> -
> -    tcr = regime_tcr(env, mmu_idx);
> -    el = regime_el(env, mmu_idx);
> -
> -    if (el > 1) {
> -        return 0;
> -    } else {
> -        return extract64(tcr->raw_tcr, 38, 1);
> -    }
> -}
> -
>  /* Return the TTBR associated with this translation regime */
>  static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
>                                     int ttbrn)
> @@ -13041,9 +12999,16 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>
>          *pc = env->pc;
>          flags = ARM_TBFLAG_AARCH64_STATE_MASK;
> -        /* Get control bits for tagged addresses */
> -        flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
> -        flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
> +
> +#ifndef CONFIG_USER_ONLY
> +        /* Get control bits for tagged addresses.  Note that the
> +         * translator only uses this for instruction addresses.
> +         */
> +        flags |= (aa64_va_parameters(env, 0, mmu_idx, false).tbi
> +                  << ARM_TBFLAG_TBI0_SHIFT);
> +        flags |= (aa64_va_parameters(env, -1, mmu_idx, false).tbi
> +                  << ARM_TBFLAG_TBI1_SHIFT);
> +#endif

This has lost the bit of the old functions that converted
the stage 1+2 MMU index into a stage 1 MMU index. The call
to regime_el() in aa64_va_parameters() will assert if it is
passed ARMMMUIdx_S12NSE0 or ARMMMUIdx_S12NSE1. (In the code
paths in the get_phys_addr() functions, this is handled by
the top level get_phys_addr() code, so get_phys_addr_lpae()
never sees a stage 1+2 MMU index.)

thanks
-- PMM
