Received: from eggs.gnu.org ([2001:4830:134:3::10]:51978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eddik-0007h7-PU
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eddih-0006WZ-Jq
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:09:14 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eddih-0006W2-AI
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:09:11 -0500
Received: by mail-wr0-x242.google.com with SMTP id x1so9018520wrb.5
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 07:09:11 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-15-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-15-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 15:09:08 +0000
Message-ID: <87o9lmj5gr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/16] target/arm: Hoist store to flags
 output in cpu_get_tb_cpu_state
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

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

But it would be nice to resurrect Paolo's tb state caching series as
this is an expensive function to re-compute everytime.

> ---
>  target/arm/helper.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 9e673bb672..c0e5f321c5 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11768,34 +11768,36 @@ static inline int fp_exception_el(CPUARMState *=
env)
>  }
>
>  void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
> -                          target_ulong *cs_base, uint32_t *flags)
> +                          target_ulong *cs_base, uint32_t *pflags)
>  {
>      ARMMMUIdx mmu_idx =3D core_to_arm_mmu_idx(env, cpu_mmu_index(env, fa=
lse));
> +    uint32_t flags;
> +
>      if (is_a64(env)) {
>          *pc =3D env->pc;
> -        *flags =3D ARM_TBFLAG_AARCH64_STATE_MASK;
> +        flags =3D ARM_TBFLAG_AARCH64_STATE_MASK;
>          /* Get control bits for tagged addresses */
> -        *flags |=3D (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SH=
IFT);
> -        *flags |=3D (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SH=
IFT);
> +        flags |=3D (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHI=
FT);
> +        flags |=3D (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHI=
FT);
>      } else {
>          *pc =3D env->regs[15];
> -        *flags =3D (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
> +        flags =3D (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
>              | (env->vfp.vec_len << ARM_TBFLAG_VECLEN_SHIFT)
>              | (env->vfp.vec_stride << ARM_TBFLAG_VECSTRIDE_SHIFT)
>              | (env->condexec_bits << ARM_TBFLAG_CONDEXEC_SHIFT)
>              | (arm_sctlr_b(env) << ARM_TBFLAG_SCTLR_B_SHIFT);
>          if (!(access_secure_reg(env))) {
> -            *flags |=3D ARM_TBFLAG_NS_MASK;
> +            flags |=3D ARM_TBFLAG_NS_MASK;
>          }
>          if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
>              || arm_el_is_aa64(env, 1)) {
> -            *flags |=3D ARM_TBFLAG_VFPEN_MASK;
> +            flags |=3D ARM_TBFLAG_VFPEN_MASK;
>          }
> -        *flags |=3D (extract32(env->cp15.c15_cpar, 0, 2)
> -                   << ARM_TBFLAG_XSCALE_CPAR_SHIFT);
> +        flags |=3D (extract32(env->cp15.c15_cpar, 0, 2)
> +                  << ARM_TBFLAG_XSCALE_CPAR_SHIFT);
>      }
>
> -    *flags |=3D (arm_to_core_mmu_idx(mmu_idx) << ARM_TBFLAG_MMUIDX_SHIFT=
);
> +    flags |=3D (arm_to_core_mmu_idx(mmu_idx) << ARM_TBFLAG_MMUIDX_SHIFT);
>
>      /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
>       * states defined in the ARM ARM for software singlestep:
> @@ -11805,25 +11807,26 @@ void cpu_get_tb_cpu_state(CPUARMState *env, tar=
get_ulong *pc,
>       *     1            1       Active-not-pending
>       */
>      if (arm_singlestep_active(env)) {
> -        *flags |=3D ARM_TBFLAG_SS_ACTIVE_MASK;
> +        flags |=3D ARM_TBFLAG_SS_ACTIVE_MASK;
>          if (is_a64(env)) {
>              if (env->pstate & PSTATE_SS) {
> -                *flags |=3D ARM_TBFLAG_PSTATE_SS_MASK;
> +                flags |=3D ARM_TBFLAG_PSTATE_SS_MASK;
>              }
>          } else {
>              if (env->uncached_cpsr & PSTATE_SS) {
> -                *flags |=3D ARM_TBFLAG_PSTATE_SS_MASK;
> +                flags |=3D ARM_TBFLAG_PSTATE_SS_MASK;
>              }
>          }
>      }
>      if (arm_cpu_data_is_big_endian(env)) {
> -        *flags |=3D ARM_TBFLAG_BE_DATA_MASK;
> +        flags |=3D ARM_TBFLAG_BE_DATA_MASK;
>      }
> -    *flags |=3D fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
> +    flags |=3D fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
>
>      if (arm_v7m_is_handler_mode(env)) {
> -        *flags |=3D ARM_TBFLAG_HANDLER_MASK;
> +        flags |=3D ARM_TBFLAG_HANDLER_MASK;
>      }
>
> +    *pflags =3D flags;
>      *cs_base =3D 0;
>  }


--
Alex Benn=C3=A9e
