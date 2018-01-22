Received: from eggs.gnu.org ([2001:4830:134:3::10]:45088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eddGr-00035T-TZ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:40:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eddGr-0004cu-2n
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:40:25 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:46195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eddGq-0004cZ-OW
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:40:24 -0500
Received: by mail-oi0-x231.google.com with SMTP id d124so6044420oib.13
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 06:40:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180119045438.28582-17-richard.henderson@linaro.org>
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 14:40:03 +0000
Message-ID: <CAFEAcA-5=sVBxvWTZRA7GFM7GV4PQ3Zvgh=2zdOBbNSXGd3+bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 16/16] target/arm: Add SVE state to
 TB->FLAGS
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

On 19 January 2018 at 04:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Add both SVE exception state and vector length.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -11772,14 +11772,35 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                            target_ulong *cs_base, uint32_t *pflags)
>  {
>      ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
> +    int fp_el = fp_exception_el(env);
>      uint32_t flags;
>
>      if (is_a64(env)) {
> +        int sve_el = sve_exception_el(env);
> +        uint32_t zcr_len;
> +
>          *pc = env->pc;
>          flags = ARM_TBFLAG_AARCH64_STATE_MASK;
>          /* Get control bits for tagged addresses */
>          flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
>          flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
> +        flags |= sve_el << ARM_TBFLAG_SVEEXC_EL_SHIFT;
> +
> +        /* If SVE is disabled, but FP is enabled,
> +           then the effective len is 0.  */
> +        if (sve_el != 0 && fp_el == 0) {
> +            zcr_len = 0;
> +        } else {
> +            int highest_el = arm_highest_el(env);
> +            int current_el = arm_current_el(env);
> +            int i;
> +
> +            zcr_len = 0xf & (uint32_t)env->vfp.zcr_el[highest_el];
> +            for (i = highest_el - 1; i >= MAX(1, current_el); --i) {
> +                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[i]);
> +            }

This loop also doesn't consider the case of EL3 implemented but
EL2 not, I think.

thanks
-- PMM
