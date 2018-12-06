Received: from eggs.gnu.org ([2001:4830:134:3::10]:51308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUuE5-0000R6-8P
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUu2N-0006X1-BB
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:50:01 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUu2L-0006W6-Ug
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:49:54 -0500
Received: by mail-ot1-x343.google.com with SMTP id s5so430605oth.7
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 05:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20181203203839.757-1-richard.henderson@linaro.org>
	<20181203203839.757-9-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 13:49:41 +0000
Message-ID: <CAFEAcA__1C-GkRk65E+JL9Ovte7GhZhGKmP3Zcv_w=wZSqV7=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 08/10] target/arm: Implement the
 ARMv8.1-LOR extension
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

On Mon, 3 Dec 2018 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Provide a trivial implementation with zero limited ordering regions,
> which causes the LDLAR and STLLR instructions to devolve into the
> LDAR and STLR instructions from the base ARMv8.0 instruction set.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v2: Mark LORID_EL1 read-only.
>     Add TLOR access checks.
>     Conditionally unmask TLOR in hcr/scr_write.
> ---
>  target/arm/cpu.h           |  5 +++
>  target/arm/cpu64.c         |  4 ++
>  target/arm/helper.c        | 91 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c | 12 +++++
>  4 files changed, 112 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a84101efa9..ba0c368292 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3285,6 +3285,11 @@ static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
>      return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, ATOMIC) != 0;
>  }
>
> +static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR1, LO) != 0;

You're testing the wrong ID register here...

> +}
> +

> +static CPAccessResult access_lor_other(CPUARMState *env,
> +                                       const ARMCPRegInfo *ri, bool isread)
> +{
> +    int el = arm_current_el(env);
> +
> +    if (arm_is_secure_below_el3(env)) {
> +        /* Access denied in secure mode.  */
> +        return CP_ACCESS_TRAP;
> +    }
> +    if (el < 2 && arm_el_is_aa64(env, 2)) {

You don't need to explicitly check if EL2 is AArch64 --
these registers are AArch64 only so if we accessed them
from a lower EL then that EL is AArch64 and so all the
ELs above it must be too.

> +        uint64_t hcr = arm_hcr_el2_eff(env);
> +        if (hcr & HCR_E2H) {
> +            hcr &= HCR_TLOR;
> +        } else {
> +            hcr &= HCR_TGE | HCR_TLOR;

This doesn't make sense to me: I think TGE can't be 1 here.
We know (.access flag) that we're not in EL0. We know from
the el < 2 that we're in EL1, and we've already ruled out
Secure EL1. So this is NS EL1. If E2H == 0 then TGE can't
be set, because E2H,TGE={0,1} means the CPU can never be
in NS EL1.

(these remarks apply also to the access_lorid function)

> +        }
> +        if (hcr == HCR_TLOR) {
> +            return CP_ACCESS_TRAP_EL2;
> +        }
> +    }
> +    if (el < 3 && (env->cp15.scr_el3 & SCR_TLOR)) {
> +        return CP_ACCESS_TRAP_EL3;
> +    }
> +    return CP_ACCESS_OK;
> +}
> +
>  void register_cp_regs_for_features(ARMCPU *cpu)
>  {
>      /* Register all the coprocessor registers based on feature bits */
> @@ -5741,6 +5800,38 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          define_one_arm_cp_reg(cpu, &sctlr);
>      }
>
> +    if (cpu_isar_feature(aa64_lor, cpu)) {
> +        /*
> +         * A trivial implementation of ARMv8.1-LOR leaves all of these
> +         * registers fixed at 0, which indicates that there are zero
> +         * supported Limited Ordering regions.
> +         */
> +        static const ARMCPRegInfo lor_reginfo[] = {
> +            { .name = "LORSA_EL1", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 0,
> +              .access = PL1_RW, .accessfn = access_lor_other,
> +              .type = ARM_CP_CONST, .resetvalue = 0 },
> +            { .name = "LOREA_EL1", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 1,
> +              .access = PL1_RW, .accessfn = access_lor_other,
> +              .type = ARM_CP_CONST, .resetvalue = 0 },
> +            { .name = "LORN_EL1", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 2,
> +              .access = PL1_RW, .accessfn = access_lor_other,
> +              .type = ARM_CP_CONST, .resetvalue = 0 },
> +            { .name = "LORC_EL1", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 3,
> +              .access = PL1_RW, .accessfn = access_lor_other,
> +              .type = ARM_CP_CONST, .resetvalue = 0 },
> +            { .name = "LORID_EL1", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 7,
> +              .access = PL1_R, .accessfn = access_lorid,
> +              .type = ARM_CP_CONST, .resetvalue = 0 },
> +            REGINFO_SENTINEL
> +        };
> +        define_arm_cp_regs(cpu, lor_reginfo);
> +    }
> +
>      if (cpu_isar_feature(aa64_sve, cpu)) {
>          define_one_arm_cp_reg(cpu, &zcr_el1_reginfo);
>          if (arm_feature(env, ARM_FEATURE_EL2)) {
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index fd36425f1a..5952a9d1cc 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -2290,6 +2290,12 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
>          }
>          return;
>
> +    case 0x8: /* STLLR */
> +        if (!dc_isar_feature(aa64_lor, s)) {
> +            break;
> +        }
> +        /* StoreLORelease is the same as Store-Release for QEMU.  */
> +        /* fallthru */

We are as usual a bit inconsistent, but we seem to use the
spelling "fall through" for this linter-hint more often than
any of the other variations.

>      case 0x9: /* STLR */
>          /* Generate ISS for non-exclusive accesses including LASR.  */
>          if (rn == 31) {
> @@ -2301,6 +2307,12 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
>                    disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
>          return;
>
> +    case 0xc: /* LDLAR */
> +        if (!dc_isar_feature(aa64_lor, s)) {
> +            break;
> +        }
> +        /* LoadLOAcquire is the same as Load-Acquire for QEMU.  */
> +        /* fallthru */
>      case 0xd: /* LDAR */
>          /* Generate ISS for non-exclusive accesses including LASR.  */
>          if (rn == 31) {

thanks
-- PMM
