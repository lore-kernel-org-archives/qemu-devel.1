Received: from eggs.gnu.org ([2001:4830:134:3::10]:39741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exh1r-0006Dg-MF
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 18:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exh1o-0007Zy-In
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 18:43:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-21-git-send-email-alindsay@codeaurora.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7959abaf-d22f-b14f-832d-b87f062852ad@amsat.org>
Date: Sun, 18 Mar 2018 23:43:45 +0100
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-21-git-send-email-alindsay@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 20/22] target/arm: PMU: Add
 instruction and cycle events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On 03/16/2018 09:31 PM, Aaron Lindsay wrote:
> The instruction event is only enabled when icount is used, cycles are
> always supported. Always defining get_cycle_count (but altering its
> behavior depending on CONFIG_USER_ONLY) allows us to remove some
> CONFIG_USER_ONLY #defines throughout the rest of the code.
> 
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/helper.c | 99 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 52 insertions(+), 47 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2fa8308..679897a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -15,6 +15,7 @@
>  #include "arm_ldst.h"
>  #include <zlib.h> /* For crc32 */
>  #include "exec/semihost.h"
> +#include "sysemu/cpus.h"
>  #include "sysemu/kvm.h"
>  #include "fpu/softfloat.h"
>  
> @@ -935,8 +936,54 @@ typedef struct pm_event {
>      uint64_t (*get_count)(CPUARMState *, uint64_t cycles);
>  } pm_event;
>  
> +/*
> + * Return the underlying cycle count for the PMU cycle counters. If we're in
> + * usermode, simply return 0.
> + */
> +static uint64_t get_cycle_count(CPUARMState *env)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                   ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> +#else
> +    return 0;
> +#endif
> +}
> +
> +static bool event_always_supported(CPUARMState *env)
> +{
> +    return true;
> +}
> +
> +#ifndef CONFIG_USER_ONLY
> +static uint64_t cycles_get_count(CPUARMState *env, uint64_t cycles)
> +{
> +    return cycles;
> +}
> +
> +static bool instructions_supported(CPUARMState *env)
> +{
> +    return use_icount == 1 /* Precise instruction counting */;
> +}
> +
> +static uint64_t instructions_get_count(CPUARMState *env, uint64_t cycles)
> +{
> +    return (uint64_t)cpu_get_icount_raw();
> +}
> +#endif
> +
>  #define SUPPORTED_EVENT_SENTINEL UINT16_MAX
>  static const pm_event pm_events[] = {
> +#ifndef CONFIG_USER_ONLY
> +    { .number = 0x008, /* INST_RETIRED */
> +      .supported = instructions_supported,
> +      .get_count = instructions_get_count
> +    },
> +    { .number = 0x011, /* CPU_CYCLES */
> +      .supported = event_always_supported,
> +      .get_count = cycles_get_count
> +    },
> +#endif
>      { .number = SUPPORTED_EVENT_SENTINEL }
>  };
>  static uint16_t supported_event_map[0x3f];
> @@ -1016,8 +1063,6 @@ static CPAccessResult pmreg_access_swinc(CPUARMState *env,
>      return pmreg_access(env, ri, isread);
>  }
>  
> -#ifndef CONFIG_USER_ONLY
> -
>  static CPAccessResult pmreg_access_selr(CPUARMState *env,
>                                          const ARMCPRegInfo *ri,
>                                          bool isread)
> @@ -1126,11 +1171,7 @@ static inline bool pmu_counter_filtered(CPUARMState *env, uint64_t pmxevtyper)
>   */
>  uint64_t pmccntr_op_start(CPUARMState *env)
>  {
> -    uint64_t cycles = 0;
> -#ifndef CONFIG_USER_ONLY
> -    cycles = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                          ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> -#endif
> +    uint64_t cycles = get_cycle_count(env);
>  
>      if (arm_ccnt_enabled(env) &&
>            !pmu_counter_filtered(env, env->cp15.pmccfiltr_el0)) {
> @@ -1268,26 +1309,6 @@ static void pmccntr_write32(CPUARMState *env, const ARMCPRegInfo *ri,
>      pmccntr_write(env, ri, deposit64(cur_val, 0, 32, value));
>  }
>  
> -#else /* CONFIG_USER_ONLY */
> -
> -uint64_t pmccntr_op_start(CPUARMState *env)
> -{
> -}
> -
> -void pmccntr_op_finish(CPUARMState *env, uint64_t prev_cycles)
> -{
> -}
> -
> -uint64_t pmu_op_start(CPUARMState *env)
> -{
> -}
> -
> -void pmu_op_finish(CPUARMState *env, uint64_t prev_cycles)
> -{
> -}
> -
> -#endif
> -
>  static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                              uint64_t value)
>  {
> @@ -1346,11 +1367,7 @@ static void pmevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      if (counter == 0x1f) {
>          pmccfiltr_write(env, ri, value);
>      } else if (counter < PMU_NUM_COUNTERS(env)) {
> -        uint64_t cycles = 0;
> -#ifndef CONFIG_USER_ONLY
> -        cycles = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                          ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> -#endif
> +        uint64_t cycles = get_cycle_count(env);
>          pmu_sync_counter(env, counter, cycles);
>          env->cp15.c14_pmevtyper[counter] = value & 0xfe0003ff;
>          pmu_sync_counter(env, counter, cycles);
> @@ -1404,11 +1421,7 @@ static void pmevcntr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value, uint8_t counter)
>  {
>      if (counter < PMU_NUM_COUNTERS(env)) {
> -        uint64_t cycles = 0;
> -#ifndef CONFIG_USER_ONLY
> -        cycles = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                          ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> -#endif
> +        uint64_t cycles = get_cycle_count(env);
>          env->cp15.c14_pmevcntr[counter] = value;
>          pmu_sync_counter(env, counter, cycles);
>      }
> @@ -1420,12 +1433,8 @@ static uint64_t pmevcntr_read(CPUARMState *env, const ARMCPRegInfo *ri,
>                                uint8_t counter)
>  {
>      if (counter < PMU_NUM_COUNTERS(env)) {
> -        uint64_t ret;
> -        uint64_t cycles = 0;
> -#ifndef CONFIG_USER_ONLY
> -        cycles = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -                          ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> -#endif
> +        uint64_t ret, cycles;
> +        cycles = get_cycle_count(env);
>          pmu_sync_counter(env, counter, cycles);
>          ret = env->cp15.c14_pmevcntr[counter];
>          pmu_sync_counter(env, counter, cycles);
> @@ -1613,7 +1622,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>      /* Unimplemented so WI. */
>      { .name = "PMSWINC", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 4,
>        .access = PL0_W, .accessfn = pmreg_access_swinc, .type = ARM_CP_NOP },
> -#ifndef CONFIG_USER_ONLY
>      { .name = "PMSELR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 5,
>        .access = PL0_RW, .type = ARM_CP_ALIAS,
>        .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmselr),
> @@ -1633,7 +1641,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .access = PL0_RW, .accessfn = pmreg_access_ccntr,
>        .type = ARM_CP_IO,
>        .readfn = pmccntr_read, .writefn = pmccntr_write, },
> -#endif
>      { .name = "PMCCFILTR", .cp = 15, .opc1 = 0, .crn = 14, .crm = 15, .opc2 = 7,
>        .writefn = pmccfiltr_write_a32, .readfn = pmccfiltr_read_a32,
>        .access = PL0_RW, .accessfn = pmreg_access,
> @@ -5171,7 +5178,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>           * field as main ID register, and we implement only the cycle
>           * count register.
>           */
> -#ifndef CONFIG_USER_ONLY
>          ARMCPRegInfo pmcr = {
>              .name = "PMCR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 0,
>              .access = PL0_RW,
> @@ -5225,7 +5231,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              g_free(pmevtyper_name);
>              g_free(pmevtyper_el0_name);
>          }
> -#endif
>          ARMCPRegInfo clidr = {
>              .name = "CLIDR", .state = ARM_CP_STATE_BOTH,
>              .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 1,
> 
