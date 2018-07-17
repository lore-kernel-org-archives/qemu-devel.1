Received: from eggs.gnu.org ([2001:4830:134:3::10]:43019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffSfp-0003EP-UJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffSfo-0006GR-Di
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:18:01 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffSfn-0006G4-VW
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:18:00 -0400
Received: by mail-oi0-x244.google.com with SMTP id n84-v6so3094200oib.9
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 09:17:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529699547-17044-9-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-9-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 17:17:38 +0100
Message-ID: <CAFEAcA_O5f7Ao4cfCD8XMD5y0bb4g8P4mMz-k573FoXJwZz0qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 08/13] target/arm: Finish implementation
 of PM[X]EVCNTR and PM[X]EVTYPER
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
> Add arrays to hold the registers, the definitions themselves, access
> functions, and logic to reset counters when PMCR.P is set. Update
> filtering code to support counters other than PMCCNTR.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/cpu.h    |   3 +
>  target/arm/helper.c | 224 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 209 insertions(+), 18 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 430b8d5..c240b38 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -481,6 +481,9 @@ typedef struct CPUARMState {
>           * pmccntr_op_finish.
>           */
>          uint64_t c15_ccnt_delta;
> +        uint64_t c14_pmevcntr[31];
> +        uint64_t c14_pmevcntr_delta[31];
> +        uint64_t c14_pmevtyper[31];
>          uint64_t pmccfiltr_el0; /* Performance Monitor Filter Register */
>          uint64_t vpidr_el2; /* Virtualization Processor ID Register */
>          uint64_t vmpidr_el2; /* Virtualization Multiprocessor ID Register */
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 9f81747..f1fd21c 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -938,6 +938,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
>  #define PMCRDP  0x10
>  #define PMCRD   0x8
>  #define PMCRC   0x4
> +#define PMCRP   0x2
>  #define PMCRE   0x1
>
>  #define PMXEVTYPER_P          0x80000000
> @@ -1120,9 +1121,11 @@ static inline bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
>          prohibited = env->cp15.c9_pmcr & PMCRDP;
>      }
>
> -    /* TODO Remove assert, set filter to correct PMEVTYPER */
> -    assert(counter == 31);
> -    filter = env->cp15.pmccfiltr_el0;
> +    if (counter == 31) {
> +        filter = env->cp15.pmccfiltr_el0;
> +    } else {
> +        filter = env->cp15.c14_pmevtyper[counter];
> +    }
>
>      p   = filter & PMXEVTYPER_P;
>      u   = filter & PMXEVTYPER_U;
> @@ -1142,6 +1145,21 @@ static inline bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
>          filtered = m != p;
>      }
>
> +    if (counter != 31) {
> +        /* If not checking PMCCNTR, ensure the counter is setup to an event we
> +         * support */

Please use the right format for multiline comments (here and below).

>  static void pmuserenr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                              uint64_t value)
>  {
> @@ -1552,16 +1698,23 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .fieldoffset = offsetof(CPUARMState, cp15.pmccfiltr_el0),
>        .resetvalue = 0, },
>      { .name = "PMXEVTYPER", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 1,
> -      .access = PL0_RW, .type = ARM_CP_NO_RAW, .accessfn = pmreg_access,
> +      .access = PL0_RW, .type = ARM_CP_NO_RAW | ARM_CP_IO,
> +      .accessfn = pmreg_access,
>        .writefn = pmxevtyper_write, .readfn = pmxevtyper_read },
>      { .name = "PMXEVTYPER_EL0", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 1,
> -      .access = PL0_RW, .type = ARM_CP_NO_RAW, .accessfn = pmreg_access,
> +      .access = PL0_RW, .type = ARM_CP_NO_RAW | ARM_CP_IO,
> +      .accessfn = pmreg_access,
>        .writefn = pmxevtyper_write, .readfn = pmxevtyper_read },
> -    /* Unimplemented, RAZ/WI. */
>      { .name = "PMXEVCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 2,
> -      .access = PL0_RW, .type = ARM_CP_CONST, .resetvalue = 0,
> -      .accessfn = pmreg_access_xevcntr },
> +      .access = PL0_RW, .type = ARM_CP_NO_RAW | ARM_CP_IO,
> +      .accessfn = pmreg_access_xevcntr,
> +      .writefn = pmxevcntr_write, .readfn = pmxevcntr_read },
> +    { .name = "PMXEVCNTR_EL0", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 2,
> +      .access = PL0_RW, .type = ARM_CP_NO_RAW | ARM_CP_IO,
> +      .accessfn = pmreg_access_xevcntr,
> +      .writefn = pmxevcntr_write, .readfn = pmxevcntr_read },
>      { .name = "PMUSERENR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 0,
>        .access = PL0_R | PL1_RW, .accessfn = access_tpm,
>        .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmuserenr),
> @@ -4250,7 +4403,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>  #endif
>      /* The only field of MDCR_EL2 that has a defined architectural reset value
>       * is MDCR_EL2.HPMN which should reset to the value of PMCR_EL0.N; but we
> -     * don't impelment any PMU event counters, so using zero as a reset
> +     * don't implement any PMU event counters, so using zero as a reset
>       * value for MDCR_EL2 is okay
>       */
>      { .name = "MDCR_EL2", .state = ARM_CP_STATE_BOTH,
> @@ -5062,6 +5215,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          define_arm_cp_regs(cpu, pmovsset_cp_reginfo);
>      }
>      if (arm_feature(env, ARM_FEATURE_V7)) {
> +        unsigned int i;
>          /* v7 performance monitor control register: same implementor
>           * field as main ID register, and we implement only the cycle
>           * count register.
> @@ -5086,6 +5240,40 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          };
>          define_one_arm_cp_reg(cpu, &pmcr);
>          define_one_arm_cp_reg(cpu, &pmcr64);
> +        for (i = 0; i < 31; i++) {
> +            char *pmevcntr_name = g_strdup_printf("PMEVCNTR%d", i);
> +            char *pmevcntr_el0_name = g_strdup_printf("PMEVCNTR%d_EL0", i);
> +            char *pmevtyper_name = g_strdup_printf("PMEVTYPER%d", i);
> +            char *pmevtyper_el0_name = g_strdup_printf("PMEVTYPER%d_EL0", i);
> +            ARMCPRegInfo pmev_regs[] = {
> +                { .name = pmevcntr_name, .cp = 15, .crn = 15,
> +                  .crm = 8 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
> +                  .access = PL0_RW, .type = ARM_CP_NO_RAW | ARM_CP_IO,
> +                  .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
> +                  .accessfn = pmreg_access },
> +                { .name = pmevcntr_el0_name, .state = ARM_CP_STATE_AA64,
> +                  .opc0 = 3, .opc1 = 3, .crn = 15, .crm = 8 | (3 & (i >> 3)),
> +                  .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
> +                  .type = ARM_CP_NO_RAW | ARM_CP_IO,
> +                  .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn },
> +                { .name = pmevtyper_name, .cp = 15, .crn = 15,
> +                  .crm = 12 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
> +                  .access = PL0_RW, .type = ARM_CP_NO_RAW | ARM_CP_IO,
> +                  .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
> +                  .accessfn = pmreg_access },
> +                { .name = pmevtyper_el0_name, .state = ARM_CP_STATE_AA64,
> +                  .opc0 = 3, .opc1 = 3, .crn = 15, .crm = 12 | (3 & (i >> 3)),
> +                  .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
> +                  .type = ARM_CP_NO_RAW | ARM_CP_IO,
> +                  .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn },
> +                REGINFO_SENTINEL
> +            };
> +            define_arm_cp_regs(cpu, pmev_regs);
> +            g_free(pmevcntr_name);
> +            g_free(pmevcntr_el0_name);
> +            g_free(pmevtyper_name);
> +            g_free(pmevtyper_el0_name);
> +        }
>  #endif

Because all these registers are marked as NO_RAW we're going to fail
to migrate their state, I think.

This patchset in general needs to address how the extra CPU state
involved with the PMU is going to be migrated.

thanks
-- PMM
