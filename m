Received: from eggs.gnu.org ([2001:4830:134:3::10]:47308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea4OP-0000q2-G4
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea4ON-0003iD-W5
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:49:29 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:32878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea4ON-0003hY-Qx
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:49:27 -0500
Received: by mail-ot0-x244.google.com with SMTP id x15so5861238ote.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:49:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218173022.18418-9-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 18:49:06 +0000
Message-ID: <CAFEAcA8QfZBfujPdZ+n89x6rF0m7ohz+KsVX527d4xMnOu-5XA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 8/9] target/arm: Add ZCR.LEN to tb->flags
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

On 18 December 2017 at 17:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This has a stub(-ish) implementation of ZCR, in that it does not
> implement _EL[123], or wire up the system register properly.
> However, it is enough for CONFIG_USER_ONLY.
>
> We will need VQ in tb->flags in order to pass the true vector
> size to the generic vector expanders.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           | 48 ++++++++++++++++++++++++++++++----------------
>  target/arm/translate.h     |  1 +
>  target/arm/cpu.c           |  2 ++
>  target/arm/translate-a64.c |  5 ++---
>  4 files changed, 37 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 150b0d9d84..37b8cef2e2 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -553,6 +553,12 @@ typedef struct CPUARMState {
>          float_status fp_status;
>          float_status fp_status_f16;
>          float_status standard_fp_status;
> +
> +        /* TODO: For system mode, represent all of zcr_el{1,2,3}.
> +         * In the meantime, the composite value exposed to el0.
> +         * Only the low 4 bits are defined, and set via syscall.
> +         */
> +        uint32_t zcr_el;

For purposes of not having to mess with migration state too frequently,
I think this patch should define zcr_el[4] (and add that to the
migration subsection for 'has SVE'). We don't need to actually
implement the behaviour of the upper ELs yet.

>      } vfp;
>      uint64_t exclusive_addr;
>      uint64_t exclusive_val;
> @@ -2649,6 +2655,8 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
>  #define ARM_TBFLAG_TBI0_MASK (0x1ull << ARM_TBFLAG_TBI0_SHIFT)
>  #define ARM_TBFLAG_TBI1_SHIFT 1        /* TBI1 for EL0/1  */
>  #define ARM_TBFLAG_TBI1_MASK (0x1ull << ARM_TBFLAG_TBI1_SHIFT)
> +#define ARM_TBFLAG_ZCR_LEN_SHIFT 2     /* Composite ZCR_EL1/2/3.LEN */
> +#define ARM_TBFLAG_ZCR_LEN_MASK  (0xfull << ARM_TBFLAG_ZCR_LEN_SHIFT)
>
>  /* some convenience accessor macros */
>  #define ARM_TBFLAG_AARCH64_STATE(F) \
> @@ -2685,6 +2693,8 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
>      (((F) & ARM_TBFLAG_TBI0_MASK) >> ARM_TBFLAG_TBI0_SHIFT)
>  #define ARM_TBFLAG_TBI1(F) \
>      (((F) & ARM_TBFLAG_TBI1_MASK) >> ARM_TBFLAG_TBI1_SHIFT)
> +#define ARM_TBFLAG_ZCR_LEN(F) \
> +    (((F) & ARM_TBFLAG_ZCR_LEN_MASK) >> ARM_TBFLAG_ZCR_LEN_SHIFT)
>
>  static inline bool bswap_code(bool sctlr_b)
>  {
> @@ -2818,34 +2828,39 @@ static inline uint32_t arm_regime_tbi1(CPUARMState *env, ARMMMUIdx mmu_idx)
>  #endif
>
>  static inline void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
> -                                        target_ulong *cs_base, uint32_t *flags)
> +                                        target_ulong *cs_base, uint32_t *pflags)
>  {
>      ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
> +    uint32_t flags;
> +
>      if (is_a64(env)) {
>          *pc = env->pc;
> -        *flags = ARM_TBFLAG_AARCH64_STATE_MASK;
> +        flags = ARM_TBFLAG_AARCH64_STATE_MASK;

Can you put this kind of refactoring in its own patch, please?

>          /* Get control bits for tagged addresses */
> -        *flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
> -        *flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
> +        flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
> +        flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
> +        /* Get SVE vector length */
> +        flags |= ((env->vfp.zcr_el << ARM_TBFLAG_ZCR_LEN_SHIFT)
> +                  & ARM_TBFLAG_ZCR_LEN_MASK);

Otherwise looks OK.

thanks
-- PMM
