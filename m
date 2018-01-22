Received: from eggs.gnu.org ([2001:4830:134:3::10]:51580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eddhO-0006jm-S4
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:07:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eddhK-0005TZ-9r
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:07:50 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eddhK-0005Sw-09
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:07:46 -0500
Received: by mail-wr0-x244.google.com with SMTP id g21so9009242wrb.13
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 07:07:45 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-14-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-14-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 15:07:43 +0000
Message-ID: <87po62j5j4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/16] target/arm: Move
 cpu_get_tb_cpu_state out of line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    | 127 +---------------------------------------------=
------
>  target/arm/helper.c | 126
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 128 insertions(+), 125 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index c8e8155b6e..2de1afb53a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2703,71 +2703,6 @@ static inline bool bswap_code(bool sctlr_b)
>  #endif
>  }
>
> -/* Return the exception level to which FP-disabled exceptions should
> - * be taken, or 0 if FP is enabled.
> - */
> -static inline int fp_exception_el(CPUARMState *env)
> -{
> -    int fpen;
> -    int cur_el =3D arm_current_el(env);
> -
> -    /* CPACR and the CPTR registers don't exist before v6, so FP is
> -     * always accessible
> -     */
> -    if (!arm_feature(env, ARM_FEATURE_V6)) {
> -        return 0;
> -    }
> -
> -    /* The CPACR controls traps to EL1, or PL1 if we're 32 bit:
> -     * 0, 2 : trap EL0 and EL1/PL1 accesses
> -     * 1    : trap only EL0 accesses
> -     * 3    : trap no accesses
> -     */
> -    fpen =3D extract32(env->cp15.cpacr_el1, 20, 2);
> -    switch (fpen) {
> -    case 0:
> -    case 2:
> -        if (cur_el =3D=3D 0 || cur_el =3D=3D 1) {
> -            /* Trap to PL1, which might be EL1 or EL3 */
> -            if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
> -                return 3;
> -            }
> -            return 1;
> -        }
> -        if (cur_el =3D=3D 3 && !is_a64(env)) {
> -            /* Secure PL1 running at EL3 */
> -            return 3;
> -        }
> -        break;
> -    case 1:
> -        if (cur_el =3D=3D 0) {
> -            return 1;
> -        }
> -        break;
> -    case 3:
> -        break;
> -    }
> -
> -    /* For the CPTR registers we don't need to guard with an ARM_FEATURE
> -     * check because zero bits in the registers mean "don't trap".
> -     */
> -
> -    /* CPTR_EL2 : present in v7VE or v8 */
> -    if (cur_el <=3D 2 && extract32(env->cp15.cptr_el[2], 10, 1)
> -        && !arm_is_secure_below_el3(env)) {
> -        /* Trap FP ops at EL2, NS-EL1 or NS-EL0 to EL2 */
> -        return 2;
> -    }
> -
> -    /* CPTR_EL3 : present in v8 */
> -    if (extract32(env->cp15.cptr_el[3], 10, 1)) {
> -        /* Trap all FP ops to EL3 */
> -        return 3;
> -    }
> -
> -    return 0;
> -}
> -
>  #ifdef CONFIG_USER_ONLY
>  static inline bool arm_cpu_bswap_data(CPUARMState *env)
>  {
> @@ -2814,66 +2749,8 @@ static inline uint32_t arm_regime_tbi1(CPUARMState=
 *env, ARMMMUIdx mmu_idx)
>  }
>  #endif
>
> -static inline void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *=
pc,
> -                                        target_ulong *cs_base, uint32_t =
*flags)
> -{
> -    ARMMMUIdx mmu_idx =3D core_to_arm_mmu_idx(env, cpu_mmu_index(env, fa=
lse));
> -    if (is_a64(env)) {
> -        *pc =3D env->pc;
> -        *flags =3D ARM_TBFLAG_AARCH64_STATE_MASK;
> -        /* Get control bits for tagged addresses */
> -        *flags |=3D (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SH=
IFT);
> -        *flags |=3D (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SH=
IFT);
> -    } else {
> -        *pc =3D env->regs[15];
> -        *flags =3D (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
> -            | (env->vfp.vec_len << ARM_TBFLAG_VECLEN_SHIFT)
> -            | (env->vfp.vec_stride << ARM_TBFLAG_VECSTRIDE_SHIFT)
> -            | (env->condexec_bits << ARM_TBFLAG_CONDEXEC_SHIFT)
> -            | (arm_sctlr_b(env) << ARM_TBFLAG_SCTLR_B_SHIFT);
> -        if (!(access_secure_reg(env))) {
> -            *flags |=3D ARM_TBFLAG_NS_MASK;
> -        }
> -        if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
> -            || arm_el_is_aa64(env, 1)) {
> -            *flags |=3D ARM_TBFLAG_VFPEN_MASK;
> -        }
> -        *flags |=3D (extract32(env->cp15.c15_cpar, 0, 2)
> -                   << ARM_TBFLAG_XSCALE_CPAR_SHIFT);
> -    }
> -
> -    *flags |=3D (arm_to_core_mmu_idx(mmu_idx) << ARM_TBFLAG_MMUIDX_SHIFT=
);
> -
> -    /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
> -     * states defined in the ARM ARM for software singlestep:
> -     *  SS_ACTIVE   PSTATE.SS   State
> -     *     0            x       Inactive (the TB flag for SS is always 0)
> -     *     1            0       Active-pending
> -     *     1            1       Active-not-pending
> -     */
> -    if (arm_singlestep_active(env)) {
> -        *flags |=3D ARM_TBFLAG_SS_ACTIVE_MASK;
> -        if (is_a64(env)) {
> -            if (env->pstate & PSTATE_SS) {
> -                *flags |=3D ARM_TBFLAG_PSTATE_SS_MASK;
> -            }
> -        } else {
> -            if (env->uncached_cpsr & PSTATE_SS) {
> -                *flags |=3D ARM_TBFLAG_PSTATE_SS_MASK;
> -            }
> -        }
> -    }
> -    if (arm_cpu_data_is_big_endian(env)) {
> -        *flags |=3D ARM_TBFLAG_BE_DATA_MASK;
> -    }
> -    *flags |=3D fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
> -
> -    if (arm_v7m_is_handler_mode(env)) {
> -        *flags |=3D ARM_TBFLAG_HANDLER_MASK;
> -    }
> -
> -    *cs_base =3D 0;
> -}
> +void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
> +                          target_ulong *cs_base, uint32_t *flags);
>
>  enum {
>      QEMU_PSCI_CONDUIT_DISABLED =3D 0,
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 984a4b1306..9e673bb672 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11701,3 +11701,129 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t =
val, uint32_t bytes)
>      /* Linux crc32c converts the output to one's complement.  */
>      return crc32c(acc, buf, bytes) ^ 0xffffffff;
>  }
> +
> +/* Return the exception level to which FP-disabled exceptions should
> + * be taken, or 0 if FP is enabled.
> + */
> +static inline int fp_exception_el(CPUARMState *env)

You can drop the inline here. The compiler knows what to do and we are
no longer in a header.

> +{
> +    int fpen;
> +    int cur_el =3D arm_current_el(env);
> +
> +    /* CPACR and the CPTR registers don't exist before v6, so FP is
> +     * always accessible
> +     */
> +    if (!arm_feature(env, ARM_FEATURE_V6)) {
> +        return 0;
> +    }
> +
> +    /* The CPACR controls traps to EL1, or PL1 if we're 32 bit:
> +     * 0, 2 : trap EL0 and EL1/PL1 accesses
> +     * 1    : trap only EL0 accesses
> +     * 3    : trap no accesses
> +     */
> +    fpen =3D extract32(env->cp15.cpacr_el1, 20, 2);
> +    switch (fpen) {
> +    case 0:
> +    case 2:
> +        if (cur_el =3D=3D 0 || cur_el =3D=3D 1) {
> +            /* Trap to PL1, which might be EL1 or EL3 */
> +            if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
> +                return 3;
> +            }
> +            return 1;
> +        }
> +        if (cur_el =3D=3D 3 && !is_a64(env)) {
> +            /* Secure PL1 running at EL3 */
> +            return 3;
> +        }
> +        break;
> +    case 1:
> +        if (cur_el =3D=3D 0) {
> +            return 1;
> +        }
> +        break;
> +    case 3:
> +        break;
> +    }
> +
> +    /* For the CPTR registers we don't need to guard with an ARM_FEATURE
> +     * check because zero bits in the registers mean "don't trap".
> +     */
> +
> +    /* CPTR_EL2 : present in v7VE or v8 */
> +    if (cur_el <=3D 2 && extract32(env->cp15.cptr_el[2], 10, 1)
> +        && !arm_is_secure_below_el3(env)) {
> +        /* Trap FP ops at EL2, NS-EL1 or NS-EL0 to EL2 */
> +        return 2;
> +    }
> +
> +    /* CPTR_EL3 : present in v8 */
> +    if (extract32(env->cp15.cptr_el[3], 10, 1)) {
> +        /* Trap all FP ops to EL3 */
> +        return 3;
> +    }
> +
> +    return 0;
> +}

I'm not sure helper.c is the best place for this. Maybe cpu.c?

> +
> +void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
> +                          target_ulong *cs_base, uint32_t *flags)
> +{
> +    ARMMMUIdx mmu_idx =3D core_to_arm_mmu_idx(env, cpu_mmu_index(env, fa=
lse));
> +    if (is_a64(env)) {
> +        *pc =3D env->pc;
> +        *flags =3D ARM_TBFLAG_AARCH64_STATE_MASK;
> +        /* Get control bits for tagged addresses */
> +        *flags |=3D (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SH=
IFT);
> +        *flags |=3D (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SH=
IFT);
> +    } else {
> +        *pc =3D env->regs[15];
> +        *flags =3D (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
> +            | (env->vfp.vec_len << ARM_TBFLAG_VECLEN_SHIFT)
> +            | (env->vfp.vec_stride << ARM_TBFLAG_VECSTRIDE_SHIFT)
> +            | (env->condexec_bits << ARM_TBFLAG_CONDEXEC_SHIFT)
> +            | (arm_sctlr_b(env) << ARM_TBFLAG_SCTLR_B_SHIFT);
> +        if (!(access_secure_reg(env))) {
> +            *flags |=3D ARM_TBFLAG_NS_MASK;
> +        }
> +        if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
> +            || arm_el_is_aa64(env, 1)) {
> +            *flags |=3D ARM_TBFLAG_VFPEN_MASK;
> +        }
> +        *flags |=3D (extract32(env->cp15.c15_cpar, 0, 2)
> +                   << ARM_TBFLAG_XSCALE_CPAR_SHIFT);
> +    }
> +
> +    *flags |=3D (arm_to_core_mmu_idx(mmu_idx) << ARM_TBFLAG_MMUIDX_SHIFT=
);
> +
> +    /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
> +     * states defined in the ARM ARM for software singlestep:
> +     *  SS_ACTIVE   PSTATE.SS   State
> +     *     0            x       Inactive (the TB flag for SS is always 0)
> +     *     1            0       Active-pending
> +     *     1            1       Active-not-pending
> +     */
> +    if (arm_singlestep_active(env)) {
> +        *flags |=3D ARM_TBFLAG_SS_ACTIVE_MASK;
> +        if (is_a64(env)) {
> +            if (env->pstate & PSTATE_SS) {
> +                *flags |=3D ARM_TBFLAG_PSTATE_SS_MASK;
> +            }
> +        } else {
> +            if (env->uncached_cpsr & PSTATE_SS) {
> +                *flags |=3D ARM_TBFLAG_PSTATE_SS_MASK;
> +            }
> +        }
> +    }
> +    if (arm_cpu_data_is_big_endian(env)) {
> +        *flags |=3D ARM_TBFLAG_BE_DATA_MASK;
> +    }
> +    *flags |=3D fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
> +
> +    if (arm_v7m_is_handler_mode(env)) {
> +        *flags |=3D ARM_TBFLAG_HANDLER_MASK;
> +    }
> +
> +    *cs_base =3D 0;
> +}


--
Alex Benn=C3=A9e
