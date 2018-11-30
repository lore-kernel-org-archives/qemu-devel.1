Received: from eggs.gnu.org ([2001:4830:134:3::10]:45322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSlQr-0003kF-JE
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:14:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSlQq-0007Qt-3y
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:14:21 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSlQp-0007Pn-AZ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:14:20 -0500
Received: by mail-oi1-x243.google.com with SMTP id i6so5155921oia.6
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
	<20181120212553.8480-9-aaron@os.amperecomputing.com>
In-Reply-To: <20181120212553.8480-9-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 16:14:05 +0000
Message-ID: <CAFEAcA_kcjm2F_1h2hRC_wW4hdozCQDzY1RmRTGTkEH+De+-Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 08/13] target/arm: Add array for
 supported PMU events, generate PMCEID[01]_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

On Tue, 20 Nov 2018 at 21:26, Aaron Lindsay
<aaron@os.amperecomputing.com> wrote:
>
> This commit doesn't add any supported events, but provides the framework
> for adding them. We store the pm_event structs in a simple array, and
> provide the mapping from the event numbers to array indexes in the
> supported_event_map array. Because the value of PMCEID[01] depends upon
> which events are supported at runtime, generate it dynamically.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/cpu.c    | 19 +++++++++------
>  target/arm/cpu.h    | 10 ++++++++
>  target/arm/cpu64.c  |  4 ----
>  target/arm/helper.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index f7bad04f60..208a08e867 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1019,10 +1019,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>
>      if (!cpu->has_pmu) {
>          unset_feature(env, ARM_FEATURE_PMU);
> +    }
> +    if (arm_feature(env, ARM_FEATURE_PMU)) {
> +        cpu->pmceid0 = get_pmceid(&cpu->env, 0);
> +        cpu->pmceid1 = get_pmceid(&cpu->env, 1);
> +
> +        if (!kvm_enabled()) {
> +            arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
> +            arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
> +        }
> +    } else {
>          cpu->id_aa64dfr0 &= ~0xf00;
> -    } else if (!kvm_enabled()) {
> -        arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
> -        arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
> +        cpu->pmceid0 = 0;
> +        cpu->pmceid1 = 0;
>      }
>
>      if (!arm_feature(env, ARM_FEATURE_EL2)) {
> @@ -1665,8 +1674,6 @@ static void cortex_a7_initfn(Object *obj)
>      cpu->id_pfr0 = 0x00001131;
>      cpu->id_pfr1 = 0x00011011;
>      cpu->id_dfr0 = 0x02010555;
> -    cpu->pmceid0 = 0x00000000;
> -    cpu->pmceid1 = 0x00000000;
>      cpu->id_afr0 = 0x00000000;
>      cpu->id_mmfr0 = 0x10101105;
>      cpu->id_mmfr1 = 0x40000000;
> @@ -1712,8 +1719,6 @@ static void cortex_a15_initfn(Object *obj)
>      cpu->id_pfr0 = 0x00001131;
>      cpu->id_pfr1 = 0x00011011;
>      cpu->id_dfr0 = 0x02010555;
> -    cpu->pmceid0 = 0x0000000;
> -    cpu->pmceid1 = 0x00000000;
>      cpu->id_afr0 = 0x00000000;
>      cpu->id_mmfr0 = 0x10201105;
>      cpu->id_mmfr1 = 0x20000000;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 50de58e4a2..32c3397948 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -993,6 +993,16 @@ void pmu_op_finish(CPUARMState *env);
>  void pmu_pre_el_change(ARMCPU *cpu, void *ignored);
>  void pmu_post_el_change(ARMCPU *cpu, void *ignored);
>
> +/*
> + * get_pmceid
> + * @env: CPUARMState
> + *
> + * Return the PMCEID[01]_EL0 register values corresponding to the counters
> + * which are supported given the current configuration (`which` is 0 or 1 to
> + * indicate which PMCEID should be returned)
> + */

Nit: you should have a line here below the one for "@env"
for the "@which" parameter, and the reference to it in
the text should just be "@which", not "`which`" (or just
put that description in the line saying what @which is
rather than having it in a parenthetical).

> +uint64_t get_pmceid(CPUARMState *env, unsigned which);
> +
>  /* SCTLR bit meanings. Several bits have been reused in newer
>   * versions of the architecture; in that case we define constants
>   * for both old and new bit meanings. Code which tests against those
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 873f059bf2..a1aad772fa 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -138,8 +138,6 @@ static void aarch64_a57_initfn(Object *obj)
>      cpu->isar.id_isar6 = 0;
>      cpu->isar.id_aa64pfr0 = 0x00002222;
>      cpu->id_aa64dfr0 = 0x10305106;
> -    cpu->pmceid0 = 0x00000000;
> -    cpu->pmceid1 = 0x00000000;
>      cpu->isar.id_aa64isar0 = 0x00011120;
>      cpu->id_aa64mmfr0 = 0x00001124;
>      cpu->dbgdidr = 0x3516d000;
> @@ -246,8 +244,6 @@ static void aarch64_a72_initfn(Object *obj)
>      cpu->isar.id_isar5 = 0x00011121;
>      cpu->isar.id_aa64pfr0 = 0x00002222;
>      cpu->id_aa64dfr0 = 0x10305106;
> -    cpu->pmceid0 = 0x00000000;
> -    cpu->pmceid1 = 0x00000000;
>      cpu->isar.id_aa64isar0 = 0x00011120;
>      cpu->id_aa64mmfr0 = 0x00001124;
>      cpu->dbgdidr = 0x3516d000;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 75f054fe79..68e9743606 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1009,6 +1009,63 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
>    return (1 << 31) | ((1 << pmu_num_counters(env)) - 1);
>  }
>
> +typedef struct pm_event {
> +    uint16_t number; /* PMEVTYPER.evtCount is 16 bits wide */
> +    /* If the event is supported on this CPU (used to generate PMCEID[01]) */
> +    bool (*supported)(CPUARMState *);
> +    /*
> +     * Retrieve the current count of the underlying event. The programmed
> +     * counters hold a difference from the return value from this function
> +     */
> +    uint64_t (*get_count)(CPUARMState *);
> +} pm_event;
> +
> +static const pm_event pm_events[] = {
> +};
> +
> +/*
> + * Note: Before increasing MAX_EVENT_ID beyond 0x3f into the 0x40xx range of
> + * events (i.e. the statistical profiling extension), this implementation
> + * should first be updated to something sparse instead of the current
> + * supported_event_map[] array.
> + */
> +#define MAX_EVENT_ID 0x0
> +#define UNSUPPORTED_EVENT UINT16_MAX
> +static uint16_t supported_event_map[MAX_EVENT_ID + 1];
> +
> +/*
> + * Called upon initialization to build PMCEID0_EL0 or PMCEID1_EL0 (indicated by
> + * 'which'). We also use it to build a map of ARM event numbers to indices in
> + * our pm_events array.
> + *
> + * Note: Events in the 0x40XX range are not currently supported.
> + */
> +uint64_t get_pmceid(CPUARMState *env, unsigned which)
> +{
> +    uint64_t pmceid = 0;
> +    unsigned int i;
> +
> +    assert(which <= 1);
> +
> +    for (i = 0; i < ARRAY_SIZE(supported_event_map); i++) {
> +        supported_event_map[i] = UNSUPPORTED_EVENT;
> +    }
> +
> +    for (i = 0; i < ARRAY_SIZE(pm_events); i++) {
> +        const pm_event *cnt = &pm_events[i];
> +        assert(cnt->number <= MAX_EVENT_ID);
> +        /* We do not currently support events in the 0x40xx range */
> +        assert(cnt->number <= 0x3f);
> +
> +        if ((cnt->number & 0x20) == (which << 6) &&
> +                cnt->supported(env)) {
> +            pmceid |= (1 << (cnt->number & 0x1f));
> +            supported_event_map[cnt->number] = i;
> +        }
> +    }
> +    return pmceid;
> +}
> +

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
