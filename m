Received: from eggs.gnu.org ([2001:4830:134:3::10]:35923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUtMF-0008Kv-Us
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUtMA-0001Nr-VK
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:06:23 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUtM9-0001MW-1t
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:06:17 -0500
Received: by mail-ot1-x344.google.com with SMTP id f18so292530otl.11
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 05:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20181203203839.757-1-richard.henderson@linaro.org>
	<20181203203839.757-7-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 13:06:04 +0000
Message-ID: <CAFEAcA9-jB-RhEPb4CnnrCZ9y+SWu_1Ec6GYw7dyQyrVi3fd7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 06/10] target/arm: Use arm_hcr_el2_eff
 more places
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

On Mon, 3 Dec 2018 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Since arm_hcr_el2_eff includes a check against
> arm_is_secure_below_el3, we can often remove a
> nearby check against secure state.
>
> In some cases, sort the call to arm_hcr_el2_eff
> to the end of a short-circuit logical sequence.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


> @@ -8797,6 +8795,8 @@ static inline uint32_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
>  static inline bool regime_translation_disabled(CPUARMState *env,
>                                                 ARMMMUIdx mmu_idx)
>  {
> +    uint64_t hcr_el2;
> +
>      if (arm_feature(env, ARM_FEATURE_M)) {
>          switch (env->v7m.mpu_ctrl[regime_is_secure(env, mmu_idx)] &
>                  (R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK)) {
> @@ -8815,19 +8815,21 @@ static inline bool regime_translation_disabled(CPUARMState *env,
>          }
>      }
>
> +    hcr_el2 = arm_hcr_el2_eff(env);

Changing this in this function makes me nervous, because
arm_hcr_el2_eff() looks at the current CPU state via
arm_is_secure_below_el3() rather than at the security state
of the translation regime we're asking about. I think
it probably doesn't change behaviour, but I'm finding
it hard to reason about...

> +
>      if (mmu_idx == ARMMMUIdx_S2NS) {
>          /* HCR.DC means HCR.VM behaves as 1 */
> -        return (env->cp15.hcr_el2 & (HCR_DC | HCR_VM)) == 0;
> +        return (hcr_el2 & (HCR_DC | HCR_VM)) == 0;
>      }
>
> -    if (env->cp15.hcr_el2 & HCR_TGE) {
> +    if (hcr_el2 & HCR_TGE) {
>          /* TGE means that NS EL0/1 act as if SCTLR_EL1.M is zero */
>          if (!regime_is_secure(env, mmu_idx) && regime_el(env, mmu_idx) == 1) {
>              return true;
>          }
>      }
>
> -    if ((env->cp15.hcr_el2 & HCR_DC) &&
> +    if ((hcr_el2 & HCR_DC) &&
>          (mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1)) {
>          /* HCR.DC means SCTLR_EL1.M behaves as 0 */
>          return true;


> @@ -995,7 +994,7 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
>                          exception_target_el(env));
>      }
>
> -    if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
> +    if (!secure && cur_el == 1 && (arm_hcr_el2_eff(env) & HCR_TSC)) {

Why can't we drop the !secure check here?

>          /* In NS EL1, HCR controlled routing to EL2 has priority over SMD.
>           * We also want an EL2 guest to be able to forbid its EL1 from
>           * making PSCI calls into QEMU's "firmware" via HCR.TSC.
> @@ -1098,8 +1097,7 @@ void HELPER(exception_return)(CPUARMState *env)
>          goto illegal_return;
>      }
>
> -    if (new_el == 1 && (env->cp15.hcr_el2 & HCR_TGE)
> -        && !arm_is_secure_below_el3(env)) {
> +    if (new_el == 1 && (arm_hcr_el2_eff(env) & HCR_TGE)) {
>          goto illegal_return;
>      }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
