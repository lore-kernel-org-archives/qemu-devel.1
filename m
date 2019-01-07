Received: from eggs.gnu.org ([209.51.188.92]:56433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggVip-0005LU-8q
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggVij-00079e-7S
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:17:43 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggVii-00076G-Vf
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:17:37 -0500
Received: by mail-ot1-x342.google.com with SMTP id v23so402649otk.9
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 06:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-25-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 14:17:24 +0000
Message-ID: <CAFEAcA-2qftWAs8f0pdTOdvGyNSyYnJVGAsUEke6P3ZFEAyhdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 24/27] target/arm: Add PAuth system
 registers
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

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b9ffc07fbc..f1e9254c9a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5061,6 +5061,70 @@ static CPAccessResult access_lor_other(CPUARMState *env,
>      return access_lor_ns(env);
>  }
>
> +#ifdef TARGET_AARCH64
> +static CPAccessResult access_pauth(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                   bool isread)
> +{
> +    int el = arm_current_el(env);
> +
> +    if (el < 2 &&
> +        arm_feature(env, ARM_FEATURE_EL2) &&
> +        !(arm_hcr_el2_eff(env) & HCR_APK)) {
> +        return CP_ACCESS_TRAP_EL2;
> +    }
> +    if (el < 3 &&
> +        arm_feature(env, ARM_FEATURE_EL3) &&
> +        !(env->cp15.scr_el3 & SCR_APK)) {
> +        return CP_ACCESS_TRAP_EL3;
> +    }
> +    return CP_ACCESS_OK;
> +}
> +
> +static const ARMCPRegInfo pauth_reginfo[] = {
> +    { .name = "APDAKEYLOW_EL1", .state = ARM_CP_STATE_AA64,

The Arm ARM uses "LO" in these register names, not "LOW".

> +      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 0,
> +      .access = PL1_RW, .accessfn = access_pauth,
> +      .fieldoffset = offsetof(CPUARMState, apda_key.lo) },
> +    { .name = "APDAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 1,
> +      .access = PL1_RW, .accessfn = access_pauth,
> +      .fieldoffset = offsetof(CPUARMState, apda_key.hi) },
> +    { .name = "APDBKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 2,
> +      .access = PL1_RW, .accessfn = access_pauth,
> +      .fieldoffset = offsetof(CPUARMState, apdb_key.lo) },
> +    { .name = "APDBKEYHI_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 3,
> +      .access = PL1_RW, .accessfn = access_pauth,
> +      .fieldoffset = offsetof(CPUARMState, apdb_key.hi) },
> +    { .name = "APGAKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 3, .opc2 = 0,
> +      .access = PL1_RW, .accessfn = access_pauth,
> +      .fieldoffset = offsetof(CPUARMState, apia_key.lo) },

Isn't this referring to the wrong field? Same with the HI version.

> +    { .name = "APGAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 3, .opc2 = 1,
> +      .access = PL1_RW, .accessfn = access_pauth,
> +      .fieldoffset = offsetof(CPUARMState, apia_key.hi) },
> +    { .name = "APIAKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 0,
> +      .access = PL1_RW, .accessfn = access_pauth,
> +      .fieldoffset = offsetof(CPUARMState, apia_key.lo) },
> +    { .name = "APIAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 1,
> +      .access = PL1_RW, .accessfn = access_pauth,
> +      .fieldoffset = offsetof(CPUARMState, apia_key.hi) },
> +    { .name = "APIBKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 2,
> +      .access = PL1_RW, .accessfn = access_pauth,
> +      .fieldoffset = offsetof(CPUARMState, apib_key.lo) },
> +    { .name = "APIBKEYHI_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 3,
> +      .access = PL1_RW, .accessfn = access_pauth,
> +      .fieldoffset = offsetof(CPUARMState, apib_key.hi) },
> +    REGINFO_SENTINEL
> +};
> +#endif

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
