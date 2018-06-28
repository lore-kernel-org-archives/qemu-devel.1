Received: from eggs.gnu.org ([2001:4830:134:3::10]:47983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYZiL-0005qy-Ro
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYZiK-0003lI-Lv
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:24:09 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYZiK-0003l1-Gh
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:24:08 -0400
Received: by mail-oi0-x242.google.com with SMTP id k81-v6so5739048oib.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:24:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529699547-17044-7-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-7-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 17:23:47 +0100
Message-ID: <CAFEAcA-0_PQdFXo_vY-cxkeC_HwxsKhCe7VNy7+4iCX-NqtOqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 06/13] target/arm: Implement PMOVSSET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

On 22 June 2018 at 21:32, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> Add an array for PMOVSSET so we only define it for v7ve+ platforms
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7d63bb2..5d83446 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1293,9 +1293,17 @@ static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                           uint64_t value)
>  {
> +    value &= pmu_counter_mask(env);
>      env->cp15.c9_pmovsr &= ~value;
>  }

This change doesn't look like it should be in this patch ?

>
> +static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                         uint64_t value)
> +{
> +    value &= pmu_counter_mask(env);
> +    env->cp15.c9_pmovsr |= value;
> +}
> +
>  static void pmxevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> @@ -1645,6 +1653,23 @@ static const ARMCPRegInfo v7mp_cp_reginfo[] = {
>      REGINFO_SENTINEL
>  };
>
> +static const ARMCPRegInfo pmovsset_cp_reginfo[] = {
> +    /* PMOVSSET is not implemented in v7 before v7ve */
> +    { .name = "PMOVSSET", .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 3,
> +      .access = PL0_RW, .accessfn = pmreg_access,
> +      .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
> +      .writefn = pmovsset_write,
> +      .raw_writefn = raw_write },

This should be marked ARM_CP_ALIAS, beacuse its underlying
state in c9_pmovsr is just an alias into PMOVSR, and that
register is handling reset and migration.

> +    { .name = "PMOVSSET_EL0", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 14, .opc2 = 3,
> +      .access = PL0_RW, .accessfn = pmreg_access,
> +      .type = ARM_CP_ALIAS,
> +      .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
> +      .writefn = pmovsset_write,
> +      .raw_writefn = raw_write },
> +    REGINFO_SENTINEL
> +};
> +
>  static void teecr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                          uint64_t value)
>  {
> @@ -4996,6 +5021,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          !arm_feature(env, ARM_FEATURE_PMSA)) {
>          define_arm_cp_regs(cpu, v7mp_cp_reginfo);
>      }
> +    if (arm_feature(env, ARM_FEATURE_V7VE)) {
> +        define_arm_cp_regs(cpu, pmovsset_cp_reginfo);
> +    }
>      if (arm_feature(env, ARM_FEATURE_V7)) {
>          /* v7 performance monitor control register: same implementor
>           * field as main ID register, and we implement only the cycle
> --

thanks
-- PMM
