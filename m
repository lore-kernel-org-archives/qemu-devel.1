Received: from eggs.gnu.org ([2001:4830:134:3::10]:48883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eddaF-00027k-Mb
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eddaB-00089t-HI
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:00:27 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:32806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eddaA-000897-Vj
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:00:23 -0500
Received: by mail-wm0-x241.google.com with SMTP id x4so17884754wmc.0
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 07:00:22 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-13-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-13-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 15:00:20 +0000
Message-ID: <87r2qij5vf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Define ZCR_EL[1-3].
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    |  5 ++++
>  target/arm/helper.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
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
> @@ -4266,6 +4266,82 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] =
=3D {
>      REGINFO_SENTINEL
>  };
>
> +/* Return the exception level to which SVE-disabled exceptions should
> + * be taken, or 0 if SVE is enabled.
> + */
> +static int sve_exception_el(CPUARMState *env)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    int highest_el =3D arm_highest_el(env);
> +    int current_el =3D arm_current_el(env);
> +    int i;
> +
> +    for (i =3D highest_el; i >=3D MAX(1, current_el); --i) {
> +        switch (i) {
> +        case 3:
> +            if ((env->cp15.cptr_el[3] & CPTR_EZ) =3D=3D 0) {
> +                return 3;
> +            }
> +            break;
> +        case 2:
> +            if (env->cp15.cptr_el[2] & CPTR_TZ) {
> +                return 2;
> +            }
> +            break;
> +        case 1:

Might be worth a comment /* ZEN bits */

> +            switch (extract32(env->cp15.cpacr_el1, 16, 2)) {
> +            case 1:
> +                return current_el =3D=3D 0 ? 1 : 0;
> +            case 3:
> +                return 0;
> +            default:
> +                return 1;

Am I missing something here?

"Traps SVE instructions and instructions that access SVE System registers a=
t EL0 and EL1 to EL1,
or to EL2 when SCR_EL3.NS and HCR_EL2.TGE are both 1. Defined values
are:"


> +            }
> +        }
> +    }
> +#endif
> +    return 0;
> +}
> +
> +static CPAccessResult zcr_access(CPUARMState *env, const ARMCPRegInfo *r=
i,
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
> +static const ARMCPRegInfo sve_cp_reginfo[] =3D {
> +    { .name =3D "ZCR_EL1", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 2, .opc1 =3D 0, .crn =3D 1, .crm =3D 2, .opc2 =3D 0,
> +      .access =3D PL1_RW, .accessfn =3D zcr_access, .type =3D ARM_CP_64B=
IT,
> +      .fieldoffset =3D offsetof(CPUARMState, vfp.zcr_el[1]),
> +      .writefn =3D zcr_write, .raw_writefn =3D raw_write, },
> +    { .name =3D "ZCR_EL2", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 2, .opc1 =3D 4, .crn =3D 1, .crm =3D 2, .opc2 =3D 0,
> +      .access =3D PL2_RW, .accessfn =3D zcr_access, .type =3D ARM_CP_64B=
IT,
> +      .fieldoffset =3D offsetof(CPUARMState, vfp.zcr_el[2]),
> +      .writefn =3D zcr_write, .raw_writefn =3D raw_write, },
> +    { .name =3D "ZCR_EL3", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 2, .opc1 =3D 6, .crn =3D 1, .crm =3D 2, .opc2 =3D 0,
> +      .access =3D PL1_RW, .accessfn =3D zcr_access, .type =3D ARM_CP_64B=
IT,
> +      .fieldoffset =3D offsetof(CPUARMState, vfp.zcr_el[3]),
> +      .writefn =3D zcr_write, .raw_writefn =3D raw_write, },
> +};
> +
>  void hw_watchpoint_update(ARMCPU *cpu, int n)
>  {
>      CPUARMState *env =3D &cpu->env;
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


--
Alex Benn=C3=A9e
