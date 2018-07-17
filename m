Received: from eggs.gnu.org ([2001:4830:134:3::10]:39886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffSUh-0007Ah-2y
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffSUf-0008KI-JH
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:06:31 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffSUf-0008K2-Ca
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:06:29 -0400
Received: by mail-oi0-x243.google.com with SMTP id d189-v6so3023866oib.6
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 09:06:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529699547-17044-8-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-8-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 17:06:08 +0100
Message-ID: <CAFEAcA-ZVvytysV4M4oM-czE5zhxu-VJsd_mfgkp47QAVEtYXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 07/13] target/arm: Add array for
 supported PMU events, generate PMCEID[01]
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
>  target/arm/cpu64.c  |  2 --
>  target/arm/helper.c | 37 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 98790b1..2f5b16a 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -927,9 +927,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>      if (!cpu->has_pmu) {
>          unset_feature(env, ARM_FEATURE_PMU);
>          cpu->id_aa64dfr0 &= ~0xf00;
> -    } else if (!kvm_enabled()) {
> -        arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
> -        arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
> +    }
> +    if (arm_feature(env, ARM_FEATURE_PMU)) {
> +        uint64_t pmceid = get_pmceid(&cpu->env);
> +        cpu->pmceid0 = pmceid & 0xffffffff;
> +        cpu->pmceid1 = (pmceid >> 32) & 0xffffffff;
> +
> +        if (!kvm_enabled()) {
> +            arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
> +            arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
> +        }
> +    } else {
> +        cpu->pmceid0 = 0x00000000;
> +        cpu->pmceid1 = 0x00000000;

This is ok for now, but we really need to sort out what we're
doing for the interplay between feature bits and ID register
values more generally (notably for '-cpu max'), so depending on
when we do that work this might end up needing to change a bit
to fit in.

>      }
>
>      if (!arm_feature(env, ARM_FEATURE_EL2)) {
> @@ -1538,8 +1548,6 @@ static void cortex_a7_initfn(Object *obj)
>      cpu->id_pfr0 = 0x00001131;
>      cpu->id_pfr1 = 0x00011011;
>      cpu->id_dfr0 = 0x02010555;
> -    cpu->pmceid0 = 0x00000000;
> -    cpu->pmceid1 = 0x00000000;
>      cpu->id_afr0 = 0x00000000;
>      cpu->id_mmfr0 = 0x10101105;
>      cpu->id_mmfr1 = 0x40000000;
> @@ -1581,8 +1589,6 @@ static void cortex_a15_initfn(Object *obj)
>      cpu->id_pfr0 = 0x00001131;
>      cpu->id_pfr1 = 0x00011011;
>      cpu->id_dfr0 = 0x02010555;
> -    cpu->pmceid0 = 0x0000000;
> -    cpu->pmceid1 = 0x00000000;
>      cpu->id_afr0 = 0x00000000;
>      cpu->id_mmfr0 = 0x10201105;
>      cpu->id_mmfr1 = 0x20000000;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 852743b..430b8d5 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -964,6 +964,16 @@ void pmu_op_finish(CPUARMState *env);
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
> +
>  /* SCTLR bit meanings. Several bits have been reused in newer
>   * versions of the architecture; in that case we define constants
>   * for both old and new bit meanings. Code which tests against those
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index c50dcd4..28482a0 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -141,8 +141,6 @@ static void aarch64_a57_initfn(Object *obj)
>      cpu->id_isar5 = 0x00011121;
>      cpu->id_aa64pfr0 = 0x00002222;
>      cpu->id_aa64dfr0 = 0x10305106;
> -    cpu->pmceid0 = 0x00000000;
> -    cpu->pmceid1 = 0x00000000;
>      cpu->id_aa64isar0 = 0x00011120;
>      cpu->id_aa64mmfr0 = 0x00001124;
>      cpu->dbgdidr = 0x3516d000;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5d83446..9f81747 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -964,6 +964,43 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
>    return (1 << 31) | ((1 << pmu_num_counters(env)) - 1);
>  }
>
> +typedef struct pm_event {
> +    uint16_t number; /* PMEVTYPER.evtCount is 10 bits wide */
> +    /* If the event is supported on this CPU (used to generate PMCEID[01]) */
> +    bool (*supported)(CPUARMState *);
> +    /* Retrieve the current count of the underlying event. The programmed
> +     * counters hold a difference from the return value from this function */

Don't leave the */ dangling on the RHS of a multiline comment.
(CODING_STYLE now recommends Linux-kernel style.)

> +    uint64_t (*get_count)(CPUARMState *);
> +} pm_event;
> +
> +#define SUPPORTED_EVENT_SENTINEL UINT16_MAX
> +static const pm_event pm_events[] = {
> +    { .number = SUPPORTED_EVENT_SENTINEL }
> +};
> +static uint16_t supported_event_map[0x3f];

What is this hardcoded 0x3f ?

> +
> +/*
> + * Called upon initialization to build PMCEID0 (low 32 bits) and PMCEID1 (high
> + * 32). We also use it to build a map of ARM event numbers to indices in
> + * our pm_events array.
> + */
> +uint64_t get_pmceid(CPUARMState *env)
> +{
> +    uint64_t pmceid = 0;
> +    unsigned int i = 0;
> +    while (pm_events[i].number != SUPPORTED_EVENT_SENTINEL) {

Are we ever going to run through some other array than the
constant pm_events[] ? We could just use ARRAY_SIZE rather
than requiring a sentinel member.

> +        const pm_event *cnt = &pm_events[i];
> +        if (cnt->number < 0x3f && cnt->supported(env)) {

...another 0x3f. Are we ever really going to see an
out-of-range .number field, or should we just assert()
that it's in range ?

> +            pmceid |= (1 << cnt->number);
> +            supported_event_map[cnt->number] = i;
> +        } else {
> +            supported_event_map[cnt->number] = SUPPORTED_EVENT_SENTINEL;

This will leave us with supported_event_map[] entries in
one of three states:
 * SUPPORTED_EVENT_SENTINEL if they have a specific pm_events[]
   entry marked as not supported
 * an index if they are supported
 * zero if there is no pm_events[] entry

Don't the ones in the last category get confused with the
real index 0?

Maybe this should initialize the whole array first to the
sentinel value and then just fill in the supported ones with
their index values?

> +        }
> +        i++;
> +    }
> +    return pmceid;
> +}
> +

thanks
-- PMM
