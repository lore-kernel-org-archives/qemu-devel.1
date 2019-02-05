Received: from eggs.gnu.org ([209.51.188.92]:60934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr6OA-0002uO-5I
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr6O8-0007NX-SS
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:28:10 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr6O8-0007Mt-C7
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:28:08 -0500
Received: by mail-ot1-x344.google.com with SMTP id 32so7683157ota.12
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 11:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-4-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 19:27:54 +0000
Message-ID: <CAFEAcA-BEfqu=BU-2y+8dUBdXsyC4n2zhZm5nZ1MofUj3cE2Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/17] target/arm: Add MTE system registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 14 Jan 2019 at 01:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is TFSRE0_EL1, TFSR_EL1, TFSR_EL2, TFSR_EL3,
> RGSR_EL1, GCR_EL1, and PSTATE.TCO.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           |  5 +++++
>  target/arm/translate.h     | 11 ++++++++++
>  target/arm/helper.c        | 45 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c | 11 ++++++++++
>  4 files changed, 72 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 22163c9c3f..c8b447e30a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -482,6 +482,11 @@ typedef struct CPUARMState {
>          uint64_t pmccfiltr_el0; /* Performance Monitor Filter Register */
>          uint64_t vpidr_el2; /* Virtualization Processor ID Register */
>          uint64_t vmpidr_el2; /* Virtualization Multiprocessor ID Register */
> +#ifdef TARGET_AARCH64
> +        uint64_t tfsr_el[4]; /* tfsrel0_el1 is index 0.  */
> +        uint64_t gcr_el1;
> +        uint64_t rgsr_el1;
> +#endif

Are we going to add more fields inside this #ifdef or is it only
saving 12 words?

>      } cp15;
>
>      struct {
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index 5a101e1c6d..a24757d3d7 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -204,6 +204,17 @@ static inline TCGv_i32 get_ahp_flag(void)
>      return ret;
>  }
>
> +/* Set bits within PSTATE.  */
> +static inline void set_pstate_bits(uint32_t bits)
> +{
> +    TCGv_i32 p = tcg_temp_new_i32();
> +
> +    tcg_gen_ld_i32(p, cpu_env, offsetof(CPUARMState, pstate));
> +    tcg_gen_ori_i32(p, p, bits);
> +    tcg_gen_st_i32(p, cpu_env, offsetof(CPUARMState, pstate));
> +    tcg_temp_free_i32(p);

Maybe assert() that all the bits in the input are in the
set that we actually store in env->pstate, to catch attempts
to set NZCV, nRW, etc this way ?

> +}
> +
>  /* Clear bits within PSTATE.  */
>  static inline void clear_pstate_bits(uint32_t bits)
>  {
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5a59fc4315..df43deb0f8 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5132,6 +5132,48 @@ static const ARMCPRegInfo pauth_reginfo[] = {
>        .fieldoffset = offsetof(CPUARMState, apib_key.hi) },
>      REGINFO_SENTINEL
>  };
> +
> +static uint64_t tco_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    return env->pstate & PSTATE_TCO;
> +}
> +
> +static void tco_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t val)
> +{
> +    env->pstate = (env->pstate & ~PSTATE_TCO) | (val & PSTATE_TCO);
> +}
> +
> +static const ARMCPRegInfo mte_reginfo[] = {
> +    { .name = "TFSRE0_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 6, .crm = 6, .opc2 = 1,
> +      .access = PL1_RW,
> +      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[0]) },
> +    { .name = "TFSR_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 6, .crm = 5, .opc2 = 0,
> +      .access = PL1_RW,
> +      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[1]) },
> +    { .name = "TFSR_EL2", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 4, .crn = 6, .crm = 5, .opc2 = 0,
> +      .access = PL2_RW,
> +      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[2]) },
> +    { .name = "TFSR_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 6, .crm = 6, .opc2 = 0,
> +      .access = PL3_RW,
> +      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[3]) },
> +    { .name = "RGSR_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 5,
> +      .access = PL1_RW,
> +      .fieldoffset = offsetof(CPUARMState, cp15.rgsr_el1) },
> +    { .name = "GCR_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 6,
> +      .access = PL1_RW,
> +      .fieldoffset = offsetof(CPUARMState, cp15.gcr_el1) },
> +    { .name = "TCO", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 0, .opc1 = 3, .crn = 4, .crm = 2, .opc2 = 7,

Shouldn't this have opc0 = 3 ?

> +      .type = ARM_CP_NO_RAW,
> +      .access = PL0_RW, .readfn = tco_read, .writefn = tco_write },
> +    REGINFO_SENTINEL

Missing GMID_EL1 ?

> +};
>  #endif
>
>  void register_cp_regs_for_features(ARMCPU *cpu)
> @@ -5923,6 +5965,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>      if (cpu_isar_feature(aa64_pauth, cpu)) {
>          define_arm_cp_regs(cpu, pauth_reginfo);
>      }
> +    if (cpu_isar_feature(aa64_mte_insn_reg, cpu)) {
> +        define_arm_cp_regs(cpu, mte_reginfo);
> +    }
>  #endif
>  }
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 0286507bae..5c2577a9ac 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1668,6 +1668,17 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
>          s->base.is_jmp = DISAS_UPDATE;
>          break;
>
> +    case 0x1c: /* TCO */
> +        if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
> +            goto do_unallocated;
> +        }
> +        if (crm & 1) {
> +            set_pstate_bits(PSTATE_TCO);
> +        } else {
> +            clear_pstate_bits(PSTATE_TCO);
> +        }
> +        break;

Don't we need to break the TB here or something to pick up
the new value of TCO when we generate code for a following
load or store ? (TCO is self-synchronizing so there is no
requirement for an ISB before it takes effect.)

thanks
-- PMM
