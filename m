Received: from eggs.gnu.org ([2001:4830:134:3::10]:41277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfi2-0005da-EN
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfi1-00021y-Ep
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:07:02 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNfi0-00020Y-W4
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:07:01 -0500
Received: by mail-ot1-x344.google.com with SMTP id t5so21630245otk.1
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 07:07:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181105185046.2802-8-aaron@os.amperecomputing.com>
References: <20181105185046.2802-1-aaron@os.amperecomputing.com>
	<20181105185046.2802-8-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 15:06:39 +0000
Message-ID: <CAFEAcA8F5ZhPHU2ZC53xeXOEuR2NqzwHqjG9858VELjorwYj5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 07/12] target/arm: Add array for
 supported PMU events, generate PMCEID[01]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

On 5 November 2018 at 18:51, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
> This commit doesn't add any supported events, but provides the framework
> for adding them. We store the pm_event structs in a simple array, and
> provide the mapping from the event numbers to array indexes in the
> supported_event_map array. Because the value of PMCEID[01] depends upon
> which events are supported at runtime, generate it dynamically.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/cpu.c    | 20 +++++++++++++-------
>  target/arm/cpu.h    | 10 ++++++++++
>  target/arm/cpu64.c  |  4 ----
>  target/arm/helper.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 65 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 9e54c56379..d1c766d180 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -957,9 +957,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>      if (!cpu->has_pmu) {
>          unset_feature(env, ARM_FEATURE_PMU);
>          cpu->id_aa64dfr0 &= ~0xf00;
> -    } else if (!kvm_enabled()) {
> -        arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
> -        arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
> +    }
> +    if (arm_feature(env, ARM_FEATURE_PMU)) {
> +        uint64_t pmceid = get_pmceid(&cpu->env);
> +        cpu->pmceid0 = extract64(pmceid, 0, 32);
> +        cpu->pmceid1 = extract64(pmceid, 32, 32);
> +
> +        if (!kvm_enabled()) {
> +            arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
> +            arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
> +        }
> +    } else {
> +        cpu->pmceid0 = 0x00000000;
> +        cpu->pmceid1 = 0x00000000;
>      }

This now sets one of the ID registers for "we have no
PMU" in the first "if (!cpu->has_pmu)" statement (id_aa64dfr0),
and some of them (pmceid0, pcmeid1) in this else clause at the
end. We should put them all in the same place.

>
>      if (!arm_feature(env, ARM_FEATURE_EL2)) {
> @@ -1601,8 +1611,6 @@ static void cortex_a7_initfn(Object *obj)
>      cpu->id_pfr0 = 0x00001131;
>      cpu->id_pfr1 = 0x00011011;
>      cpu->id_dfr0 = 0x02010555;
> -    cpu->pmceid0 = 0x00000000;
> -    cpu->pmceid1 = 0x00000000;
>      cpu->id_afr0 = 0x00000000;
>      cpu->id_mmfr0 = 0x10101105;
>      cpu->id_mmfr1 = 0x40000000;
> @@ -1647,8 +1655,6 @@ static void cortex_a15_initfn(Object *obj)
>      cpu->id_pfr0 = 0x00001131;
>      cpu->id_pfr1 = 0x00011011;
>      cpu->id_dfr0 = 0x02010555;
> -    cpu->pmceid0 = 0x0000000;
> -    cpu->pmceid1 = 0x00000000;
>      cpu->id_afr0 = 0x00000000;
>      cpu->id_mmfr0 = 0x10201105;
>      cpu->id_mmfr1 = 0x20000000;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 92282cd976..f991ff370e 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -991,6 +991,16 @@ void pmu_op_finish(CPUARMState *env);
>  void pmu_pre_el_change(ARMCPU *cpu, void *ignored);
>  void pmu_post_el_change(ARMCPU *cpu, void *ignored);
>
> +/*
> + * get_pmceid
> + * @env: CPUARMState
> + *
> + * Return the PMCEID[01] register values corresponding to the counters which
> + * are supported given the current configuration (0 is low 32, 1 is high 32
> + * bits)
> + */
> +uint64_t get_pmceid(CPUARMState *env);

This doesn't look like the right API, because in AArch64
PMCEID0_EL0 and PMCEID1_EL0 are both 64-bit registers,
so you can't fit them both into a single uint64_t.

thanks
-- PMM
