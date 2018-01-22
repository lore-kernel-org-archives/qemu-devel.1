Received: from eggs.gnu.org ([2001:4830:134:3::10]:44742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eddF2-0001rk-Gx
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eddF1-0003Sx-5l
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:38:32 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:47042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eddF0-0003SX-Ts
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:38:31 -0500
Received: by mail-oi0-x242.google.com with SMTP id d124so6039869oib.13
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 06:38:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180119045438.28582-13-richard.henderson@linaro.org>
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 14:38:09 +0000
Message-ID: <CAFEAcA9iqVP5FTwy=dbPrtUTWNaH0t16TvbyYAzZXj_cnGpkYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 12/16] target/arm: Add ZCR_ELx
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

On 19 January 2018 at 04:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Define ZCR_EL[1-3].
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    |  5 ++++
>  target/arm/helper.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 0a923e42d8..c8e8155b6e 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -547,6 +547,9 @@ typedef struct CPUARMState {
>           */
>          float_status fp_status;
>          float_status standard_fp_status;
> +
> +        /* ZCR_EL[1-3] */
> +        uint64_t zcr_el[4];
>      } vfp;
>      uint64_t exclusive_addr;
>      uint64_t exclusive_val;
> @@ -921,6 +924,8 @@ void pmccntr_sync(CPUARMState *env);
>  #define CPTR_TCPAC    (1U << 31)
>  #define CPTR_TTA      (1U << 20)
>  #define CPTR_TFP      (1U << 10)
> +#define CPTR_TZ       (1U << 8)   /* CPTR_EL2 */
> +#define CPTR_EZ       (1U << 8)   /* CPTR_EL3 */
>
>  #define MDCR_EPMAD    (1U << 21)
>  #define MDCR_EDAD     (1U << 20)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6705903301..984a4b1306 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4266,6 +4266,82 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
>      REGINFO_SENTINEL
>  };
>
> +/* Return the exception level to which SVE-disabled exceptions should
> + * be taken, or 0 if SVE is enabled.
> + */
> +static int sve_exception_el(CPUARMState *env)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    int highest_el = arm_highest_el(env);
> +    int current_el = arm_current_el(env);
> +    int i;
> +
> +    for (i = highest_el; i >= MAX(1, current_el); --i) {

This structure is a bit odd, because it doesn't account for the
possibility that EL3 could be implemented but EL2 not. Usually
these access checks are written as a series of if()s (see eg
access_tda(), access_tpm()). Where the register bit defaults to
the right thing for an unimplemented EL we can get away without
the arm_feature(env, ARM_FEATURE_ELx) test.

It also doesn't get the prioritization right if more than one
trap bit is set. This is defined by "Synchronous exception
prioritization for exceptions taken to AArch64" in the v8A Arm ARM,
which says that exceptions taken to EL2 because of CPTR_EL2
bits take precedence over taking an exception to EL3 because
of CPTR_EL3 bits (items 10 and 15 in the list), and taking
the exception to EL1 because of CPACR_EL1 takes precedence
over both (item 8).

> +        switch (i) {
> +        case 3:
> +            if ((env->cp15.cptr_el[3] & CPTR_EZ) == 0) {
> +                return 3;
> +            }
> +            break;
> +        case 2:
> +            if (env->cp15.cptr_el[2] & CPTR_TZ) {
> +                return 2;
> +            }

You need to check that we're in NonSecure before honouring
this trap bit, otherwise Secure EL1/EL0 would trap to EL2.

> +            break;
> +        case 1:
> +            switch (extract32(env->cp15.cpacr_el1, 16, 2)) {
> +            case 1:
> +                return current_el == 0 ? 1 : 0;
> +            case 3:
> +                return 0;
> +            default:
> +                return 1;
> +            }
> +        }
> +    }
> +#endif
> +    return 0;
> +}
> +
> +static CPAccessResult zcr_access(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                 bool isread)
> +{
> +    switch (sve_exception_el(env)) {
> +    case 3:
> +        return CP_ACCESS_TRAP_EL3;
> +    case 2:
> +        return CP_ACCESS_TRAP_EL2;
> +    case 1:
> +        return CP_ACCESS_TRAP;
> +    }
> +    return CP_ACCESS_OK;
> +}
> +
> +static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                      uint64_t value)
> +{
> +    /* Bits other than [3:0] are RAZ/WI.  */
> +    raw_write(env, ri, value & 0xf);
> +}
> +
> +static const ARMCPRegInfo sve_cp_reginfo[] = {
> +    { .name = "ZCR_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 2, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 0,

Are you sure the encodings are right here? My docs say opc0 == 3
for all of these.

> +      .access = PL1_RW, .accessfn = zcr_access, .type = ARM_CP_64BIT,
> +      .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[1]),
> +      .writefn = zcr_write, .raw_writefn = raw_write, },
> +    { .name = "ZCR_EL2", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 2, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 0,
> +      .access = PL2_RW, .accessfn = zcr_access, .type = ARM_CP_64BIT,
> +      .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[2]),
> +      .writefn = zcr_write, .raw_writefn = raw_write, },
> +    { .name = "ZCR_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 2, .opc1 = 6, .crn = 1, .crm = 2, .opc2 = 0,
> +      .access = PL1_RW, .accessfn = zcr_access, .type = ARM_CP_64BIT,

Shouldn't this be PL3_RW ? At any rate you need something to
stop NS EL1 and EL2 from being able to access it.

> +      .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[3]),
> +      .writefn = zcr_write, .raw_writefn = raw_write, },
> +};
> +
>  void hw_watchpoint_update(ARMCPU *cpu, int n)
>  {
>      CPUARMState *env = &cpu->env;
> @@ -5332,6 +5408,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          }
>          define_one_arm_cp_reg(cpu, &sctlr);
>      }
> +
> +    if (arm_feature(env, ARM_FEATURE_SVE)) {
> +        define_arm_cp_regs(cpu, sve_cp_reginfo);
> +    }
>  }
>
>  void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
> --
> 2.14.3

thanks
-- PMM
