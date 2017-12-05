Received: from eggs.gnu.org ([2001:4830:134:3::10]:57003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMKgS-0007QZ-G9
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 16:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMKgP-0003wQ-AB
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 16:23:20 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
	<1512153879-5291-5-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ac246e55-a12d-6d9d-959a-47aa0334c17f@amsat.org>
Date: Tue, 5 Dec 2017 18:23:13 -0300
MIME-Version: 1.0
In-Reply-To: <1512153879-5291-5-git-send-email-peter.maydell@linaro.org>
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Hi Peter,

On 12/01/2017 03:44 PM, Peter Maydell wrote:
> For M profile, we currently have an mmu index MNegPri for
> "requested execution priority negative". This fails to
> distinguish "requested execution priority negative, privileged"
> from "requested execution priority negative, usermode", but
> the two can return different results for MPU lookups. Fix this
> by splitting MNegPri into MNegPriPriv and MNegPriUser, and
> similarly for the Secure equivalent MSNegPri.
> 
> This takes us from 6 M profile MMU modes to 8, which means
> we need to bump NB_MMU_MODES; this is OK since the point
> where we are forced to reduce TLB sizes is 9 MMU modes.
> 
> (It would in theory be possible to stick with 6 MMU indexes:
> {mpu-disabled,user,privileged} x {secure,nonsecure} since
> in the MPU-disabled case the result of an MPU lookup is
> always the same for both user and privileged code. However
> we would then need to rework the TB flags handling to put
> user/priv into the TB flags separately from the mmuidx.
> Adding an extra couple of mmu indexes is simpler.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       | 49 ++++++++++++++++++++++++++++---------------------
>  target/arm/internals.h |  6 ++++--
>  target/arm/helper.c    | 14 ++++++++++----
>  target/arm/translate.c |  8 ++++++--
>  4 files changed, 48 insertions(+), 29 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 89d49cd..d228fe6 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -112,7 +112,7 @@ enum {
>  #define ARM_CPU_VIRQ 2
>  #define ARM_CPU_VFIQ 3
>  
> -#define NB_MMU_MODES 7
> +#define NB_MMU_MODES 8
>  /* ARM-specific extra insn start words:
>   * 1: Conditional execution bits
>   * 2: Partial exception syndrome for data aborts
> @@ -2226,13 +2226,13 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>   * They have the following different MMU indexes:
>   *  User
>   *  Privileged
> - *  Execution priority negative (this is like privileged, but the
> - *  MPU HFNMIENA bit means that it may have different access permission
> - *  check results to normal privileged code, so can't share a TLB).
> + *  User, execution priority negative (ie the MPU HFNMIENA bit may apply)
> + *  Privileged, execution priority negative (ditto)
>   * If the CPU supports the v8M Security Extension then there are also:
>   *  Secure User
>   *  Secure Privileged
> - *  Secure, execution priority negative
> + *  Secure User, execution priority negative
> + *  Secure Privileged, execution priority negative
>   *
>   * The ARMMMUIdx and the mmu index value used by the core QEMU TLB code
>   * are not quite the same -- different CPU types (most notably M profile
> @@ -2251,6 +2251,8 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>   * The constant names here are patterned after the general style of the names
>   * of the AT/ATS operations.
>   * The values used are carefully arranged to make mmu_idx => EL lookup easy.
> + * For M profile we arrange them to have a bit for priv, a bit for negpri
> + * and a bit for secure.
>   */
>  #define ARM_MMU_IDX_A 0x10 /* A profile */
>  #define ARM_MMU_IDX_NOTLB 0x20 /* does not have a TLB */
> @@ -2269,10 +2271,12 @@ typedef enum ARMMMUIdx {
>      ARMMMUIdx_S2NS = 6 | ARM_MMU_IDX_A,
>      ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
>      ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
> -    ARMMMUIdx_MNegPri = 2 | ARM_MMU_IDX_M,
> -    ARMMMUIdx_MSUser = 3 | ARM_MMU_IDX_M,
> -    ARMMMUIdx_MSPriv = 4 | ARM_MMU_IDX_M,
> -    ARMMMUIdx_MSNegPri = 5 | ARM_MMU_IDX_M,
> +    ARMMMUIdx_MUserNegPri = 2 | ARM_MMU_IDX_M,
> +    ARMMMUIdx_MPrivNegPri = 3 | ARM_MMU_IDX_M,
> +    ARMMMUIdx_MSUser = 4 | ARM_MMU_IDX_M,
> +    ARMMMUIdx_MSPriv = 5 | ARM_MMU_IDX_M,
> +    ARMMMUIdx_MSUserNegPri = 6 | ARM_MMU_IDX_M,
> +    ARMMMUIdx_MSPrivNegPri = 7 | ARM_MMU_IDX_M,
>      /* Indexes below here don't have TLBs and are used only for AT system
>       * instructions or for the first stage of an S12 page table walk.
>       */
> @@ -2293,10 +2297,12 @@ typedef enum ARMMMUIdxBit {
>      ARMMMUIdxBit_S2NS = 1 << 6,
>      ARMMMUIdxBit_MUser = 1 << 0,
>      ARMMMUIdxBit_MPriv = 1 << 1,
> -    ARMMMUIdxBit_MNegPri = 1 << 2,
> -    ARMMMUIdxBit_MSUser = 1 << 3,
> -    ARMMMUIdxBit_MSPriv = 1 << 4,
> -    ARMMMUIdxBit_MSNegPri = 1 << 5,
> +    ARMMMUIdxBit_MUserNegPri = 1 << 2,
> +    ARMMMUIdxBit_MPrivNegPri = 1 << 3,
> +    ARMMMUIdxBit_MSUser = 1 << 4,
> +    ARMMMUIdxBit_MSPriv = 1 << 5,
> +    ARMMMUIdxBit_MSUserNegPri = 1 << 6,
> +    ARMMMUIdxBit_MSPrivNegPri = 1 << 7,
>  } ARMMMUIdxBit;

(I think the ARMMMUIdxBit enum is misleading, since this is a mask)

The patch is correct, but I don't like having magic values.

Can you add these ARM_MMU_IDX_M_* defines/enums?

enum {
    ARM_MMU_IDX_M_EL        0x01, /* Exception Level */
    ARM_MMU_IDX_M_NEG       0x02,
    ARM_MMU_IDX_M_SEC       0x04, /* Secure */
    ARM_MMU_IDX_A           0x10, /* A profile */
    ARM_MMU_IDX_NOTLB       0x20, /* does not have a TLB */
    ARM_MMU_IDX_M           0x40, /* M profile */
};

>  
>  #define MMU_USER_IDX 0
> @@ -2322,8 +2328,7 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
>      case ARM_MMU_IDX_A:
>          return mmu_idx & 3;
>      case ARM_MMU_IDX_M:
> -        return (mmu_idx == ARMMMUIdx_MUser || mmu_idx == ARMMMUIdx_MSUser)
> -            ? 0 : 1;
> +        return mmu_idx & 1;

So here we can use:

           return mmu_idx & ARM_MMU_IDX_M_EL;

>      default:
>          g_assert_not_reached();
>      }
> @@ -2334,16 +2339,18 @@ static inline ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env,
>                                                       bool secstate)
>  {
>      int el = arm_current_el(env);
> -    ARMMMUIdx mmu_idx;
> +    ARMMMUIdx mmu_idx = ARM_MMU_IDX_M;
>  
> -    if (el == 0) {
> -        mmu_idx = secstate ? ARMMMUIdx_MSUser : ARMMMUIdx_MUser;
> -    } else {
> -        mmu_idx = secstate ? ARMMMUIdx_MSPriv : ARMMMUIdx_MPriv;
> +    if (el != 0) {
> +        mmu_idx |= 1;

           mmu_idx |= ARM_MMU_IDX_M_EL;

>      }
> 
>      if (armv7m_nvic_neg_prio_requested(env->nvic, secstate)) {
> -        mmu_idx = secstate ? ARMMMUIdx_MSNegPri : ARMMMUIdx_MNegPri;
> +        mmu_idx |= 2;

           mmu_idx |= ARM_MMU_IDX_M_NEG;

> +    }
> +
> +    if (secstate) {
> +        mmu_idx |= 4;

           mmu_idx |= ARM_MMU_IDX_M_SEC;

>      }
>  
>      return mmu_idx;
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index d9cc75e..aa9c91b 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -544,15 +544,17 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_S1NSE1:
>      case ARMMMUIdx_S1E2:
>      case ARMMMUIdx_S2NS:
> +    case ARMMMUIdx_MPrivNegPri:
> +    case ARMMMUIdx_MUserNegPri:
>      case ARMMMUIdx_MPriv:
> -    case ARMMMUIdx_MNegPri:
>      case ARMMMUIdx_MUser:
>          return false;
>      case ARMMMUIdx_S1E3:
>      case ARMMMUIdx_S1SE0:
>      case ARMMMUIdx_S1SE1:
> +    case ARMMMUIdx_MSPrivNegPri:
> +    case ARMMMUIdx_MSUserNegPri:
>      case ARMMMUIdx_MSPriv:
> -    case ARMMMUIdx_MSNegPri:
>      case ARMMMUIdx_MSUser:
>          return true;
>      default:
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c4c8d5a..14ab1f4 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7856,11 +7856,13 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_S1SE1:
>      case ARMMMUIdx_S1NSE0:
>      case ARMMMUIdx_S1NSE1:
> +    case ARMMMUIdx_MPrivNegPri:
> +    case ARMMMUIdx_MUserNegPri:
>      case ARMMMUIdx_MPriv:
> -    case ARMMMUIdx_MNegPri:
>      case ARMMMUIdx_MUser:
> +    case ARMMMUIdx_MSPrivNegPri:
> +    case ARMMMUIdx_MSUserNegPri:
>      case ARMMMUIdx_MSPriv:
> -    case ARMMMUIdx_MSNegPri:
>      case ARMMMUIdx_MSUser:
>          return 1;
>      default:
> @@ -7883,8 +7885,10 @@ static inline bool regime_translation_disabled(CPUARMState *env,
>                  (R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK)) {
>          case R_V7M_MPU_CTRL_ENABLE_MASK:
>              /* Enabled, but not for HardFault and NMI */
> -            return mmu_idx == ARMMMUIdx_MNegPri ||
> -                mmu_idx == ARMMMUIdx_MSNegPri;
> +            return mmu_idx == ARMMMUIdx_MUserNegPri ||
> +                mmu_idx == ARMMMUIdx_MPrivNegPri ||
> +                mmu_idx == ARMMMUIdx_MSUserNegPri ||
> +                mmu_idx == ARMMMUIdx_MSPrivNegPri;

And here we can simplify:

               return mmu_idx & ARM_MMU_IDX_M_NEG;

>          case R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK:
>              /* Enabled for all cases */
>              return false;
> @@ -8017,6 +8021,8 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_S1NSE0:
>      case ARMMMUIdx_MUser:
>      case ARMMMUIdx_MSUser:
> +    case ARMMMUIdx_MUserNegPri:
> +    case ARMMMUIdx_MSUserNegPri:
>          return true;
>      default:
>          return false;
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 4afb0c8..6df4d90 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -159,12 +159,16 @@ static inline int get_a32_user_mem_index(DisasContext *s)
>          return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0);
>      case ARMMMUIdx_MUser:
>      case ARMMMUIdx_MPriv:
> -    case ARMMMUIdx_MNegPri:
>          return arm_to_core_mmu_idx(ARMMMUIdx_MUser);
> +    case ARMMMUIdx_MUserNegPri:
> +    case ARMMMUIdx_MPrivNegPri:
> +        return arm_to_core_mmu_idx(ARMMMUIdx_MUserNegPri);
>      case ARMMMUIdx_MSUser:
>      case ARMMMUIdx_MSPriv:
> -    case ARMMMUIdx_MSNegPri:
>          return arm_to_core_mmu_idx(ARMMMUIdx_MSUser);
> +    case ARMMMUIdx_MSUserNegPri:
> +    case ARMMMUIdx_MSPrivNegPri:
> +        return arm_to_core_mmu_idx(ARMMMUIdx_MSUserNegPri);
>      case ARMMMUIdx_S2NS:
>      default:
>          g_assert_not_reached();
> 

Regards,

Phil.
