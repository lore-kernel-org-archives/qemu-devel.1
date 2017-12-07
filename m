Received: from eggs.gnu.org ([2001:4830:134:3::10]:50954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMwxd-0002KJ-Ln
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMwxY-0002jr-Nj
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:15:37 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
	<1512153879-5291-5-git-send-email-peter.maydell@linaro.org>
	<ac246e55-a12d-6d9d-959a-47aa0334c17f@amsat.org>
	<CAFEAcA8zN1nd1pWE9SZGzE1AipO-Ss7Xz8kSXMEvFhX_C5LckA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <37c60c49-ad3a-559a-c6d7-9687ae868f55@amsat.org>
Date: Thu, 7 Dec 2017 11:15:25 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8zN1nd1pWE9SZGzE1AipO-Ss7Xz8kSXMEvFhX_C5LckA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/7] target/arm: Split M profile
 MNegPri mmu index into user and priv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 12/07/2017 08:07 AM, Peter Maydell wrote:
> On 5 December 2017 at 21:23, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> The patch is correct, but I don't like having magic values.
> 
> Yeah, you're right this would be better. I've already put this
> patch into target-arm.next, so I'll just squash in this change:

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2258,6 +2258,11 @@ static inline bool arm_excp_unmasked(CPUState
> *cs, unsigned int excp_idx,
>  #define ARM_MMU_IDX_NOTLB 0x20 /* does not have a TLB */
>  #define ARM_MMU_IDX_M 0x40 /* M profile */
> 
> +/* meanings of the bits for M profile mmu idx values */
> +#define ARM_MMU_IDX_M_PRIV 0x1
> +#define ARM_MMU_IDX_M_NEGPRI 0x2
> +#define ARM_MMU_IDX_M_S 0x4
> +
>  #define ARM_MMU_IDX_TYPE_MASK (~0x7)
>  #define ARM_MMU_IDX_COREIDX_MASK 0x7
> 
> @@ -2328,7 +2333,7 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
>      case ARM_MMU_IDX_A:
>          return mmu_idx & 3;
>      case ARM_MMU_IDX_M:
> -        return mmu_idx & 1;
> +        return mmu_idx & ARM_MMU_IDX_M_PRIV;
>      default:
>          g_assert_not_reached();
>      }
> @@ -2342,15 +2347,15 @@ static inline ARMMMUIdx
> arm_v7m_mmu_idx_for_secstate(CPUARMState *env,
>      ARMMMUIdx mmu_idx = ARM_MMU_IDX_M;
> 
>      if (el != 0) {
> -        mmu_idx |= 1;
> +        mmu_idx |= ARM_MMU_IDX_M_PRIV;
>      }
> 
>      if (armv7m_nvic_neg_prio_requested(env->nvic, secstate)) {
> -        mmu_idx |= 2;
> +        mmu_idx |= ARM_MMU_IDX_M_NEGPRI;
>      }
> 
>      if (secstate) {
> -        mmu_idx |= 4;
> +        mmu_idx |= ARM_MMU_IDX_M_S;
>      }
> 
>      return mmu_idx;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 14ab1f4..70cf313 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7885,10 +7885,7 @@ static inline bool
> regime_translation_disabled(CPUARMState *env,
>                  (R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK)) {
>          case R_V7M_MPU_CTRL_ENABLE_MASK:
>              /* Enabled, but not for HardFault and NMI */
> -            return mmu_idx == ARMMMUIdx_MUserNegPri ||
> -                mmu_idx == ARMMMUIdx_MPrivNegPri ||
> -                mmu_idx == ARMMMUIdx_MSUserNegPri ||
> -                mmu_idx == ARMMMUIdx_MSPrivNegPri;
> +            return mmu_idx & ARM_MMU_IDX_M_NEGPRI;
>          case R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK:
>              /* Enabled for all cases */
>              return false;
> 
> 
> thanks
> -- PMM
> 
