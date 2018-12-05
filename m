Received: from eggs.gnu.org ([2001:4830:134:3::10]:60519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUZAY-00024E-7k
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUZAX-0007hK-9Z
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:32:58 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Wed, 5 Dec 2018 15:32:47 +0000
Message-ID: <20181205153242.GE5549@quinoa.localdomain>
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
	<20181205134243.4791-9-aaron@os.amperecomputing.com>
In-Reply-To: <20181205134243.4791-9-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12FB09A4256A9741A986DDE93F67ED51@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 08/14] target/arm: Make PMCEID[01]_EL0
 64 bit registers, add PMCEID[23]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Dec 05 08:43, Aaron Lindsay wrote:
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> ---
>  target/arm/cpu.h    |  4 ++--
>  target/arm/helper.c | 18 ++++++++++++++++--
>  2 files changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 304e6e47b3..4216fe22db 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -837,8 +837,8 @@ struct ARMCPU {
>      uint32_t id_pfr0;
>      uint32_t id_pfr1;
>      uint32_t id_dfr0;
> -    uint32_t pmceid0;
> -    uint32_t pmceid1;
> +    uint64_t pmceid0;
> +    uint64_t pmceid1;
>      uint32_t id_afr0;
>      uint32_t id_mmfr0;
>      uint32_t id_mmfr1;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 71be6fb578..fb6939e99c 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5256,6 +5256,20 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>      } else {
>          define_arm_cp_regs(cpu, not_v7_cp_reginfo);
>      }
> +    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >=3D 4) {

After further discussion on my last version, this should be

if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >=3D 4 &&
	FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) !=3D 0xf) {

to guard against defining these registers for implementation-defined
PMUs.

> +        ARMCPRegInfo v81_pmu_regs[] =3D {
> +            { .name =3D "PMCEID2", .state =3D ARM_CP_STATE_AA32,
> +              .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 14, .opc2 =
=3D 4,
> +              .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D A=
RM_CP_CONST,
> +              .resetvalue =3D extract64(cpu->pmceid0, 32, 32) },
> +            { .name =3D "PMCEID3", .state =3D ARM_CP_STATE_AA32,
> +              .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 14, .opc2 =
=3D 5,
> +              .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D A=
RM_CP_CONST,
> +              .resetvalue =3D extract64(cpu->pmceid1, 32, 32) },
> +            REGINFO_SENTINEL
> +        };
> +        define_arm_cp_regs(cpu, v81_pmu_regs);
> +    }
>      if (arm_feature(env, ARM_FEATURE_V8)) {
>          /* AArch64 ID registers, which all have impdef reset values.
>           * Note that within the ID register ranges the unused slots
> @@ -5432,7 +5446,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              { .name =3D "PMCEID0", .state =3D ARM_CP_STATE_AA32,
>                .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 12, .opc2 =
=3D 6,
>                .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D A=
RM_CP_CONST,
> -              .resetvalue =3D cpu->pmceid0 },
> +              .resetvalue =3D extract64(cpu->pmceid0, 0, 32) },
>              { .name =3D "PMCEID0_EL0", .state =3D ARM_CP_STATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 12, .opc2 =
=3D 6,
>                .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D A=
RM_CP_CONST,
> @@ -5440,7 +5454,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              { .name =3D "PMCEID1", .state =3D ARM_CP_STATE_AA32,
>                .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 12, .opc2 =
=3D 7,
>                .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D A=
RM_CP_CONST,
> -              .resetvalue =3D cpu->pmceid1 },
> +              .resetvalue =3D extract64(cpu->pmceid1, 0, 32) },
>              { .name =3D "PMCEID1_EL0", .state =3D ARM_CP_STATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 12, .opc2 =
=3D 7,
>                .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D A=
RM_CP_CONST,
> --=20
> 2.19.1
>=20
