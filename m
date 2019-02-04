Received: from eggs.gnu.org ([209.51.188.92]:35544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqesB-000118-CT
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqes9-0001jV-LL
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:05:19 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqes9-0001hR-9R
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:05:17 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so13022317ota.12
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20190128173940.25813-1-alex.bennee@linaro.org>
	<20190128173940.25813-3-alex.bennee@linaro.org>
In-Reply-To: <20190128173940.25813-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 14:05:03 +0000
Message-ID: <CAFEAcA9fD_bju_+QM3D+088rKJffQ66HBPYUB-cDknKmPikhaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/4] target/arm: expose CPUID registers
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 28 Jan 2019 at 17:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> A number of CPUID registers are exposed to userspace by modern Linux
> kernels thanks to the "ARM64 CPU Feature Registers" ABI. For QEMU's
> user-mode emulation we don't need to emulate the kernels trap but just
> return the value the trap would have done. For this we use the PL0U_R
> permission mask which allows this access in CONFIG_USER mode.
>
> Some registers only return a subset of their contents so we need
> specific CONFIG_USER_ONLY logic to do this.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v4
>   - tweak commit message
>   - use PL0U_R instead of PL1U_R to be less confusing
>   - more CONFIG_USER logic for special cases
>   - mask a bunch of bits for some registers
> ---
>  target/arm/helper.c | 51 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 15 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 42c1c0b144..68808e7293 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3543,7 +3543,7 @@ static uint64_t mpidr_read(CPUARMState *env, const =
ARMCPRegInfo *ri)
>  static const ARMCPRegInfo mpidr_cp_reginfo[] =3D {
>      { .name =3D "MPIDR", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .crn =3D 0, .crm =3D 0, .opc1 =3D 0, .opc2 =3D 5,
> -      .access =3D PL1_R, .readfn =3D mpidr_read, .type =3D ARM_CP_NO_RAW=
 },
> +      .access =3D PL0U_R, .readfn =3D mpidr_read, .type =3D ARM_CP_NO_RA=
W },
>      REGINFO_SENTINEL
>  };
>
> @@ -5488,6 +5488,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, cons=
t ARMCPRegInfo *ri)
>      return pfr1;
>  }
>
> +#ifndef CONFIG_USER_ONLY
>  static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *r=
i)
>  {
>      ARMCPU *cpu =3D arm_env_get_cpu(env);
> @@ -5498,6 +5499,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, =
const ARMCPRegInfo *ri)
>      }
>      return pfr0;
>  }
> +#endif
>
>  /* Shared logic between LORID and the rest of the LOR* registers.
>   * Secure state has already been delt with.
> @@ -5799,18 +5801,26 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
> +             * user-mode HWCAP_CPUID emulation the GIC bits are masked
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
> +              .access =3D PL0U_R, .type =3D ARM_CP_CONST,
> +              .resetvalue =3D cpu->isar.id_aa64pfr0 & 0x000f000f0ff0000U=
LL
> +#endif
> +            },
>              { .name =3D "ID_AA64PFR1_EL1", .state =3D ARM_CP_STATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 4, .opc2 =
=3D 1,
> -              .access =3D PL1_R, .type =3D ARM_CP_CONST,
> +              .access =3D PL0U_R, .type =3D ARM_CP_CONST,
>                .resetvalue =3D cpu->isar.id_aa64pfr1},
>              { .name =3D "ID_AA64PFR2_EL1_RESERVED", .state =3D ARM_CP_ST=
ATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 4, .opc2 =
=3D 2,
> @@ -5839,11 +5849,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .resetvalue =3D 0 },
>              { .name =3D "ID_AA64DFR0_EL1", .state =3D ARM_CP_STATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 5, .opc2 =
=3D 0,
> -              .access =3D PL1_R, .type =3D ARM_CP_CONST,
> +              .access =3D PL0U_R, .type =3D ARM_CP_CONST,
>                .resetvalue =3D cpu->id_aa64dfr0 },

This doesn't seem right -- I think ID_AA64DFR0_EL1 should be exposed
as zero, not whatever the underlying register value is.

More generally, this ifdeffing of "maybe mask the values" doesn't
seem very future-proof. If we add something to one of the cpu-id_*
values, that should be masked out to zero by default for linux-user,
not defaulting to passed through.

thanks
-- PMM
