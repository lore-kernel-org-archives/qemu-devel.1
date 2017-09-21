Received: from eggs.gnu.org ([2001:4830:134:3::10]:52728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dv46A-0007xt-RZ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dv466-0005us-Hr
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:13:10 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:44182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dv466-0005uJ-6I
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:13:06 -0400
Received: by mail-wr0-x22d.google.com with SMTP id v109so4990773wrc.1
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 09:13:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1d61ec4d-da94-e96a-e1f6-509a4e80daec@siemens.com>
References: <1d61ec4d-da94-e96a-e1f6-509a4e80daec@siemens.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:12:44 +0100
Message-ID: <CAFEAcA8H=wz2y+GEXUbxLpGRc8PoLKDUZf+emF=NeAs-zAPj1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] arm: Fix SMC reporting to EL2 when QEMU
 provides PSCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 18 September 2017 at 08:51, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This properly forwards SMC events to EL2 when PSCI is provided by QEMU
> itself and, thus, ARM_FEATURE_EL3 is off.
>
> Found and tested with the Jailhouse hypervisor.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  target/arm/helper.c    | 2 +-
>  target/arm/op_helper.c | 8 ++++----
>  target/arm/psci.c      | 6 ++++++
>  3 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 4f41841ef6..8c3929762c 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3717,7 +3717,7 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>
>      if (arm_feature(env, ARM_FEATURE_EL3)) {
>          valid_mask &= ~HCR_HCD;
> -    } else {
> +    } else if (cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
>          valid_mask &= ~HCR_TSC;

This looks odd, so it needs a comment I think.
  /* Architecturally HCR.TSC is RES0 if EL3 is not implemented.
   * However, if we're using the SMC PSCI conduit then QEMU is
   * effectively acting like EL3 firmware and so the guest at
   * EL2 should retain the ability to prevent EL1 from being
   * able to make SMC calls into the ersatz firmware, so in
   * that case HCR.TSC should be read/write.
   */

>      }
>
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 6a60464ab9..4b0ef6a234 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -960,12 +960,12 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
>          return;
>      }
>
> -    if (!arm_feature(env, ARM_FEATURE_EL3)) {
> -        /* If we have no EL3 then SMC always UNDEFs */
> -        undef = true;
> -    } else if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
> +    if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
>          /* In NS EL1, HCR controlled routing to EL2 has priority over SMD. */
>          raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
> +    } else if (!arm_feature(env, ARM_FEATURE_EL3)) {
> +        /* If we have no EL3 then SMC always UNDEFs */
> +        undef = true;
>      }
>
>      if (undef) {

I think the logic in this function should be something like:

    if (!arm_feature(env, ARM_FEATURE_EL3) &&
        cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC)) {
        /* If we have no EL3 then SMC always UNDEFs and can't be
         * trapped to EL2. PSCI-via-SMC is a sort of ersatz EL3
         * firmware within QEMU, and we want an EL2 guest to be able
         * to forbid its EL1 from making PSCI calls into QEMU's
         * "firmware" via HCR.TSC, so for these purposes treat
         *  PSCI-via-SMC as implying an EL3.
         */
        undef = true;
    else if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
        /* In NS EL1, HCR controlled routing to EL2 has priority over SMD.
         * We also want an EL2 guest to be able to forbid its EL1 from
         * making PSCI calls into QEMU's "firmware" via HCR.TSC.
         */
        raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
    }

    if (undef && !arm_is_psci_call(cpu, EXCP_SMC)) {
        /* If PSCI is enabled and this looks like a valid PSCI call then
         * suppress the UNDEF -- we'll catch the SMC exception and
         * implement the PSCI call behaviour there.
         */
        raise_exception(env, EXCP_UDEF, syn_uncategorized(),
                        exception_target_el(env));
    }

(Totally untested!)

> diff --git a/target/arm/psci.c b/target/arm/psci.c
> index fc34b263d3..637987ff46 100644
> --- a/target/arm/psci.c
> +++ b/target/arm/psci.c
> @@ -35,6 +35,8 @@ bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
>       */
>      CPUARMState *env = &cpu->env;
>      uint64_t param = is_a64(env) ? env->xregs[0] : env->regs[0];
> +    int cur_el = arm_current_el(env);
> +    bool secure = arm_is_secure(env);
>
>      switch (excp_type) {
>      case EXCP_HVC:
> @@ -46,6 +48,10 @@ bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
>          if (cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
>              return false;
>          }
> +        if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
> +            /* The EL2 will handle this. */
> +            return false;
> +        }

I don't think we should need to change this function -- its
purpose is "does this look like a PSCI call", and if it's
an SMC exception with the right magic parameters, then it
does look like a PSCI call. Instead we should make the
pre_smc helper choose "raise a hyp trap" if that's the right
thing to be doing (see comment above for what I think is the
right logic there).

thanks
-- PMM
