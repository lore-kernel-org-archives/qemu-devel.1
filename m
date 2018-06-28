Received: from eggs.gnu.org ([2001:4830:134:3::10]:42673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYXpe-0003xx-Ub
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYXpd-0002qe-F2
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:23:34 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYXpd-0002qL-6i
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:23:33 -0400
Received: by mail-oi0-x241.google.com with SMTP id c2-v6so5361314oic.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:23:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625160009.17437-4-alex.bennee@linaro.org>
References: <20180625160009.17437-1-alex.bennee@linaro.org>
	<20180625160009.17437-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 15:23:11 +0100
Message-ID: <CAFEAcA_DT1a0J8UH0iOAmNQpvkrgMy-cJo-zPdXKrhisSjJxDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/5] target/arm: expose CPUID registers
 to userspace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 25 June 2018 at 17:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> A number of CPUID registers are exposed to userspace by modern Linux
> kernels thanks to the "ARM64 CPU Feature Registers" ABI. For
> CONFIG_USER_ONLY we don't emulate the kernels trap and emulate but
> instead just lower the read permission to PL0_R (hidden behind the
> PL1U_R macro).
>
> The ID_AA64PFR0_EL1 is a little special as the GIC version is hidden
> from userspace so we can define a ARM_CP_CONST version of the register
> for usermode.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> squash! target/arm: expose CPUID registers to userspace
> ---
>  target/arm/cpu.h    |  7 +++++++
>  target/arm/helper.c | 39 +++++++++++++++++++++++++--------------
>  2 files changed, 32 insertions(+), 14 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a4507a2d6f..156c811654 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1924,6 +1924,13 @@ static inline bool cptype_valid(int cptype)
>  #define PL0_R (0x02 | PL1_R)
>  #define PL0_W (0x01 | PL1_W)
>
> +/* for AArch64 HWCAP_CPUID to userspace */

The comment here should define what the semantics of this new #define are.

> +#ifdef CONFIG_USER_ONLY
> +#define PL1U_R PL0_R
> +#else
> +#define PL1U_R PL1_R
> +#endif
> +
>  #define PL3_RW (PL3_R | PL3_W)
>  #define PL2_RW (PL2_R | PL2_W)
>  #define PL1_RW (PL1_R | PL1_W)

>  void register_cp_regs_for_features(ARMCPU *cpu)
>  {
> @@ -4934,18 +4936,26 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>           * define new registers here.
>           */
>          ARMCPRegInfo v8_idregs[] =3D {
> -            /* ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST because we do=
n't
> -             * know the right value for the GIC field until after we
> -             * define these regs.
> +            /* ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST for system
> +             * emulation because we don't know the right value for the
> +             * GIC field until after we define these regs. For
> +             * user-mode HWCAP_CPUID emulation the gic bits are masked
> +             * anyway.
>               */
>              { .name =3D "ID_AA64PFR0_EL1", .state =3D ARM_CP_STATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 4, .opc2 =
=3D 0,
> +#ifndef CONFIG_USER_ONLY
>                .access =3D PL1_R, .type =3D ARM_CP_NO_RAW,
>                .readfn =3D id_aa64pfr0_read,
> -              .writefn =3D arm_cp_write_ignore },
> +              .writefn =3D arm_cp_write_ignore
> +#else
> +              .access =3D PL0_R, .type =3D ARM_CP_CONST,
> +              .resetvalue =3D cpu->id_aa64pfr0
> +#endif
> +            },
>              { .name =3D "ID_AA64PFR1_EL1", .state =3D ARM_CP_STATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 4, .opc2 =
=3D 1,
> -              .access =3D PL1_R, .type =3D ARM_CP_CONST,
> +              .access =3D PL1U_R, .type =3D ARM_CP_CONST,
>                .resetvalue =3D cpu->id_aa64pfr1},
>              { .name =3D "ID_AA64PFR2_EL1_RESERVED", .state =3D ARM_CP_ST=
ATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 4, .opc2 =
=3D 2,


The spec says that the values revealed to userspace are masked,
so only certain fields are shown to userspace and others (reserved,
impdef, invisible fields) are masked out and replaced with fixed
values. I don't see where in this patchset we're doing that.

Also, in order to correctly reveal the ID regs to linux-user code,
we need to set them correctly for what we're emulating, which at
the moment we do not if the cpu is 'max' or 'any'. (See the comment
in arm_max_initfn().)

> @@ -4973,11 +4983,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .resetvalue =3D 0 },
>              { .name =3D "ID_AA64DFR0_EL1", .state =3D ARM_CP_STATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 5, .opc2 =
=3D 0,
> -              .access =3D PL1_R, .type =3D ARM_CP_CONST,
> +              .access =3D PL1U_R, .type =3D ARM_CP_CONST,
>                .resetvalue =3D cpu->id_aa64dfr0 },
>              { .name =3D "ID_AA64DFR1_EL1", .state =3D ARM_CP_STATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 5, .opc2 =
=3D 1,
> -              .access =3D PL1_R, .type =3D ARM_CP_CONST,
> +              .access =3D PL1U_R, .type =3D ARM_CP_CONST,
>                .resetvalue =3D cpu->id_aa64dfr1 },
>              { .name =3D "ID_AA64DFR2_EL1_RESERVED", .state =3D ARM_CP_ST=
ATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 5, .opc2 =
=3D 2,
> @@ -5005,11 +5015,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .resetvalue =3D 0 },
>              { .name =3D "ID_AA64ISAR0_EL1", .state =3D ARM_CP_STATE_AA64=
,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 6, .opc2 =
=3D 0,
> -              .access =3D PL1_R, .type =3D ARM_CP_CONST,
> +              .access =3D PL1U_R, .type =3D ARM_CP_CONST,
>                .resetvalue =3D cpu->id_aa64isar0 },
>              { .name =3D "ID_AA64ISAR1_EL1", .state =3D ARM_CP_STATE_AA64=
,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 6, .opc2 =
=3D 1,
> -              .access =3D PL1_R, .type =3D ARM_CP_CONST,
> +              .access =3D PL1U_R, .type =3D ARM_CP_CONST,
>                .resetvalue =3D cpu->id_aa64isar1 },
>              { .name =3D "ID_AA64ISAR2_EL1_RESERVED", .state =3D ARM_CP_S=
TATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 6, .opc2 =
=3D 2,
> @@ -5037,11 +5047,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .resetvalue =3D 0 },
>              { .name =3D "ID_AA64MMFR0_EL1", .state =3D ARM_CP_STATE_AA64=
,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 7, .opc2 =
=3D 0,
> -              .access =3D PL1_R, .type =3D ARM_CP_CONST,
> +              .access =3D PL1U_R, .type =3D ARM_CP_CONST,
>                .resetvalue =3D cpu->id_aa64mmfr0 },
>              { .name =3D "ID_AA64MMFR1_EL1", .state =3D ARM_CP_STATE_AA64=
,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 7, .opc2 =
=3D 1,
> -              .access =3D PL1_R, .type =3D ARM_CP_CONST,
> +              .access =3D PL1U_R, .type =3D ARM_CP_CONST,
>                .resetvalue =3D cpu->id_aa64mmfr1 },
>              { .name =3D "ID_AA64MMFR2_EL1_RESERVED", .state =3D ARM_CP_S=
TATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 7, .opc2 =
=3D 2,
> @@ -5335,7 +5345,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          ARMCPRegInfo id_v8_midr_cp_reginfo[] =3D {
>              { .name =3D "MIDR_EL1", .state =3D ARM_CP_STATE_BOTH,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 0, .opc2 =
=3D 0,
> -              .access =3D PL1_R, .type =3D ARM_CP_NO_RAW, .resetvalue =
=3D cpu->midr,
> +              .access =3D PL1U_R, .type =3D ARM_CP_NO_RAW, .resetvalue =
=3D cpu->midr,
>                .fieldoffset =3D offsetof(CPUARMState, cp15.c0_cpuid),
>                .readfn =3D midr_read },
>              /* crn =3D 0 op1 =3D 0 crm =3D 0 op2 =3D 4,7 : AArch32 alias=
es of MIDR */
> @@ -5347,7 +5357,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .access =3D PL1_R, .resetvalue =3D cpu->midr },
>              { .name =3D "REVIDR_EL1", .state =3D ARM_CP_STATE_BOTH,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 0, .opc2 =
=3D 6,
> -              .access =3D PL1_R, .type =3D ARM_CP_CONST, .resetvalue =3D=
 cpu->revidr },
> +              .access =3D PL1U_R, .type =3D ARM_CP_CONST,
> +              .resetvalue =3D cpu->revidr },

This is a STATE_BOTH register, so just changing the .access value
will reveal the aarch32 cpreg to userspace, which is wrong.

>              REGINFO_SENTINEL
>          };
>          ARMCPRegInfo id_cp_reginfo[] =3D {
> --
> 2.17.1

thanks
-- PMM
