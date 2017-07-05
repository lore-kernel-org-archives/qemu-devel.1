Received: from eggs.gnu.org ([2001:4830:134:3::10]:52142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dSu6Y-0006sg-3i
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 19:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dSu6Q-0008Sq-S3
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 19:53:10 -0400
MIME-Version: 1.0
In-Reply-To: <1498830302-19274-2-git-send-email-edgar.iglesias@gmail.com>
References: <1498830302-19274-1-git-send-email-edgar.iglesias@gmail.com>
	<1498830302-19274-2-git-send-email-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jul 2017 16:52:30 -0700
Message-ID: <CAKmqyKNwa9UNxMJ0yQjiUa374bD6MY3hO63gSCk7cP_21RFGmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/2] target-arm: Move the regime_xxx
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Fri, Jun 30, 2017 at 6:45 AM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Move the regime_xxx helpers in preparation for future code
> that will reuse them.
>
> No functional change.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  target/arm/helper.c | 404 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 202 insertions(+), 202 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2594faa..fd1027e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -35,6 +35,208 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>  #define PMCRD   0x8
>  #define PMCRC   0x4
>  #define PMCRE   0x1
> +
> +/* Return the exception level which controls this address translation regime */
> +static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
> +{
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_S2NS:
> +    case ARMMMUIdx_S1E2:
> +        return 2;
> +    case ARMMMUIdx_S1E3:
> +        return 3;
> +    case ARMMMUIdx_S1SE0:
> +        return arm_el_is_aa64(env, 3) ? 1 : 3;
> +    case ARMMMUIdx_S1SE1:
> +    case ARMMMUIdx_S1NSE0:
> +    case ARMMMUIdx_S1NSE1:
> +    case ARMMMUIdx_MPriv:
> +    case ARMMMUIdx_MNegPri:
> +    case ARMMMUIdx_MUser:
> +        return 1;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +/* Return true if this address translation regime is secure */
> +static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
> +{
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_S12NSE0:
> +    case ARMMMUIdx_S12NSE1:
> +    case ARMMMUIdx_S1NSE0:
> +    case ARMMMUIdx_S1NSE1:
> +    case ARMMMUIdx_S1E2:
> +    case ARMMMUIdx_S2NS:
> +    case ARMMMUIdx_MPriv:
> +    case ARMMMUIdx_MNegPri:
> +    case ARMMMUIdx_MUser:
> +        return false;
> +    case ARMMMUIdx_S1E3:
> +    case ARMMMUIdx_S1SE0:
> +    case ARMMMUIdx_S1SE1:
> +        return true;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +/* Return the SCTLR value which controls this address translation regime */
> +static inline uint32_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
> +{
> +    return env->cp15.sctlr_el[regime_el(env, mmu_idx)];
> +}
> +
> +/* Return true if the specified stage of address translation is disabled */
> +static inline bool regime_translation_disabled(CPUARMState *env,
> +                                               ARMMMUIdx mmu_idx)
> +{
> +    if (arm_feature(env, ARM_FEATURE_M)) {
> +        switch (env->v7m.mpu_ctrl &
> +                (R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK)) {
> +        case R_V7M_MPU_CTRL_ENABLE_MASK:
> +            /* Enabled, but not for HardFault and NMI */
> +            return mmu_idx == ARMMMUIdx_MNegPri;
> +        case R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK:
> +            /* Enabled for all cases */
> +            return false;
> +        case 0:
> +        default:
> +            /* HFNMIENA set and ENABLE clear is UNPREDICTABLE, but
> +             * we warned about that in armv7m_nvic.c when the guest set it.
> +             */
> +            return true;
> +        }
> +    }
> +
> +    if (mmu_idx == ARMMMUIdx_S2NS) {
> +        return (env->cp15.hcr_el2 & HCR_VM) == 0;
> +    }
> +    return (regime_sctlr(env, mmu_idx) & SCTLR_M) == 0;
> +}
> +
> +static inline bool regime_translation_big_endian(CPUARMState *env,
> +                                                 ARMMMUIdx mmu_idx)
> +{
> +    return (regime_sctlr(env, mmu_idx) & SCTLR_EE) != 0;
> +}
> +
> +/* Return the TCR controlling this translation regime */
> +static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
> +{
> +    if (mmu_idx == ARMMMUIdx_S2NS) {
> +        return &env->cp15.vtcr_el2;
> +    }
> +    return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
> +}
> +
> +/* Convert a possible stage1+2 MMU index into the appropriate
> + * stage 1 MMU index
> + */
> +static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
> +{
> +    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
> +        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_S12NSE0);
> +    }
> +    return mmu_idx;
> +}
> +
> +/* Returns TBI0 value for current regime el */
> +uint32_t arm_regime_tbi0(CPUARMState *env, ARMMMUIdx mmu_idx)
> +{
> +    TCR *tcr;
> +    uint32_t el;
> +
> +    /* For EL0 and EL1, TBI is controlled by stage 1's TCR, so convert
> +     * a stage 1+2 mmu index into the appropriate stage 1 mmu index.
> +     */
> +    mmu_idx = stage_1_mmu_idx(mmu_idx);
> +
> +    tcr = regime_tcr(env, mmu_idx);
> +    el = regime_el(env, mmu_idx);
> +
> +    if (el > 1) {
> +        return extract64(tcr->raw_tcr, 20, 1);
> +    } else {
> +        return extract64(tcr->raw_tcr, 37, 1);
> +    }
> +}
> +
> +/* Returns TBI1 value for current regime el */
> +uint32_t arm_regime_tbi1(CPUARMState *env, ARMMMUIdx mmu_idx)
> +{
> +    TCR *tcr;
> +    uint32_t el;
> +
> +    /* For EL0 and EL1, TBI is controlled by stage 1's TCR, so convert
> +     * a stage 1+2 mmu index into the appropriate stage 1 mmu index.
> +     */
> +    mmu_idx = stage_1_mmu_idx(mmu_idx);
> +
> +    tcr = regime_tcr(env, mmu_idx);
> +    el = regime_el(env, mmu_idx);
> +
> +    if (el > 1) {
> +        return 0;
> +    } else {
> +        return extract64(tcr->raw_tcr, 38, 1);
> +    }
> +}
> +
> +/* Return the TTBR associated with this translation regime */
> +static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
> +                                   int ttbrn)
> +{
> +    if (mmu_idx == ARMMMUIdx_S2NS) {
> +        return env->cp15.vttbr_el2;
> +    }
> +    if (ttbrn == 0) {
> +        return env->cp15.ttbr0_el[regime_el(env, mmu_idx)];
> +    } else {
> +        return env->cp15.ttbr1_el[regime_el(env, mmu_idx)];
> +    }
> +}
> +
> +/* Return true if the translation regime is using LPAE format page tables */
> +static bool regime_using_lpae_format(CPUARMState *env,
> +                                     ARMMMUIdx mmu_idx)
> +{
> +    int el = regime_el(env, mmu_idx);
> +    if (el == 2 || arm_el_is_aa64(env, el)) {
> +        return true;
> +    }
> +    if (arm_feature(env, ARM_FEATURE_LPAE)
> +        && (regime_tcr(env, mmu_idx)->raw_tcr & TTBCR_EAE)) {
> +        return true;
> +    }
> +    return false;
> +}
> +
> +/* Returns true if the stage 1 translation regime is using LPAE format page
> + * tables. Used when raising alignment exceptions, whose FSR changes depending
> + * on whether the long or short descriptor format is in use. */
> +bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
> +{
> +    mmu_idx = stage_1_mmu_idx(mmu_idx);
> +
> +    return regime_using_lpae_format(env, mmu_idx);
> +}
> +
> +static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
> +{
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_S1SE0:
> +    case ARMMMUIdx_S1NSE0:
> +    case ARMMMUIdx_MUser:
> +        return true;
> +    default:
> +        return false;
> +    case ARMMMUIdx_S12NSE0:
> +    case ARMMMUIdx_S12NSE1:
> +        g_assert_not_reached();
> +    }
> +}
>  #endif
>
>  static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
> @@ -7022,208 +7224,6 @@ void arm_cpu_do_interrupt(CPUState *cs)
>      }
>  }
>
> -/* Return the exception level which controls this address translation regime */
> -static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
> -{
> -    switch (mmu_idx) {
> -    case ARMMMUIdx_S2NS:
> -    case ARMMMUIdx_S1E2:
> -        return 2;
> -    case ARMMMUIdx_S1E3:
> -        return 3;
> -    case ARMMMUIdx_S1SE0:
> -        return arm_el_is_aa64(env, 3) ? 1 : 3;
> -    case ARMMMUIdx_S1SE1:
> -    case ARMMMUIdx_S1NSE0:
> -    case ARMMMUIdx_S1NSE1:
> -    case ARMMMUIdx_MPriv:
> -    case ARMMMUIdx_MNegPri:
> -    case ARMMMUIdx_MUser:
> -        return 1;
> -    default:
> -        g_assert_not_reached();
> -    }
> -}
> -
> -/* Return true if this address translation regime is secure */
> -static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
> -{
> -    switch (mmu_idx) {
> -    case ARMMMUIdx_S12NSE0:
> -    case ARMMMUIdx_S12NSE1:
> -    case ARMMMUIdx_S1NSE0:
> -    case ARMMMUIdx_S1NSE1:
> -    case ARMMMUIdx_S1E2:
> -    case ARMMMUIdx_S2NS:
> -    case ARMMMUIdx_MPriv:
> -    case ARMMMUIdx_MNegPri:
> -    case ARMMMUIdx_MUser:
> -        return false;
> -    case ARMMMUIdx_S1E3:
> -    case ARMMMUIdx_S1SE0:
> -    case ARMMMUIdx_S1SE1:
> -        return true;
> -    default:
> -        g_assert_not_reached();
> -    }
> -}
> -
> -/* Return the SCTLR value which controls this address translation regime */
> -static inline uint32_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
> -{
> -    return env->cp15.sctlr_el[regime_el(env, mmu_idx)];
> -}
> -
> -/* Return true if the specified stage of address translation is disabled */
> -static inline bool regime_translation_disabled(CPUARMState *env,
> -                                               ARMMMUIdx mmu_idx)
> -{
> -    if (arm_feature(env, ARM_FEATURE_M)) {
> -        switch (env->v7m.mpu_ctrl &
> -                (R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK)) {
> -        case R_V7M_MPU_CTRL_ENABLE_MASK:
> -            /* Enabled, but not for HardFault and NMI */
> -            return mmu_idx == ARMMMUIdx_MNegPri;
> -        case R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK:
> -            /* Enabled for all cases */
> -            return false;
> -        case 0:
> -        default:
> -            /* HFNMIENA set and ENABLE clear is UNPREDICTABLE, but
> -             * we warned about that in armv7m_nvic.c when the guest set it.
> -             */
> -            return true;
> -        }
> -    }
> -
> -    if (mmu_idx == ARMMMUIdx_S2NS) {
> -        return (env->cp15.hcr_el2 & HCR_VM) == 0;
> -    }
> -    return (regime_sctlr(env, mmu_idx) & SCTLR_M) == 0;
> -}
> -
> -static inline bool regime_translation_big_endian(CPUARMState *env,
> -                                                 ARMMMUIdx mmu_idx)
> -{
> -    return (regime_sctlr(env, mmu_idx) & SCTLR_EE) != 0;
> -}
> -
> -/* Return the TCR controlling this translation regime */
> -static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
> -{
> -    if (mmu_idx == ARMMMUIdx_S2NS) {
> -        return &env->cp15.vtcr_el2;
> -    }
> -    return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
> -}
> -
> -/* Convert a possible stage1+2 MMU index into the appropriate
> - * stage 1 MMU index
> - */
> -static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
> -{
> -    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
> -        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_S12NSE0);
> -    }
> -    return mmu_idx;
> -}
> -
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
> -/* Return the TTBR associated with this translation regime */
> -static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
> -                                   int ttbrn)
> -{
> -    if (mmu_idx == ARMMMUIdx_S2NS) {
> -        return env->cp15.vttbr_el2;
> -    }
> -    if (ttbrn == 0) {
> -        return env->cp15.ttbr0_el[regime_el(env, mmu_idx)];
> -    } else {
> -        return env->cp15.ttbr1_el[regime_el(env, mmu_idx)];
> -    }
> -}
> -
> -/* Return true if the translation regime is using LPAE format page tables */
> -static inline bool regime_using_lpae_format(CPUARMState *env,
> -                                            ARMMMUIdx mmu_idx)
> -{
> -    int el = regime_el(env, mmu_idx);
> -    if (el == 2 || arm_el_is_aa64(env, el)) {
> -        return true;
> -    }
> -    if (arm_feature(env, ARM_FEATURE_LPAE)
> -        && (regime_tcr(env, mmu_idx)->raw_tcr & TTBCR_EAE)) {
> -        return true;
> -    }
> -    return false;
> -}
> -
> -/* Returns true if the stage 1 translation regime is using LPAE format page
> - * tables. Used when raising alignment exceptions, whose FSR changes depending
> - * on whether the long or short descriptor format is in use. */
> -bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
> -{
> -    mmu_idx = stage_1_mmu_idx(mmu_idx);
> -
> -    return regime_using_lpae_format(env, mmu_idx);
> -}
> -
> -static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
> -{
> -    switch (mmu_idx) {
> -    case ARMMMUIdx_S1SE0:
> -    case ARMMMUIdx_S1NSE0:
> -    case ARMMMUIdx_MUser:
> -        return true;
> -    default:
> -        return false;
> -    case ARMMMUIdx_S12NSE0:
> -    case ARMMMUIdx_S12NSE1:
> -        g_assert_not_reached();
> -    }
> -}
> -
>  /* Translate section/page access permissions to page
>   * R/W protection flags
>   *
> --
> 2.7.4
>
>
