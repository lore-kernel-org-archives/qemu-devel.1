Received: from eggs.gnu.org ([2001:4830:134:3::10]:38796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHBjI-0004pr-Kf
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHBjF-0006QV-Fe
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:44:28 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHBjF-0006On-1r
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:44:25 -0500
Received: by mail-vk0-f54.google.com with SMTP id 137so33567321vkl.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 07:44:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480434248-27138-2-git-send-email-clg@kaod.org>
References: <1480434248-27138-1-git-send-email-clg@kaod.org>
	<1480434248-27138-2-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Dec 2016 15:43:03 +0000
Message-ID: <CAFEAcA-B3iMZ7rX3XEJvMJ-HdL3t9yAfLNR8P02NYybzUt_DEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 01/30] target-arm: Add VBAR support
 to ARM1176 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Marcin Krzeminski <marcin.krzeminski@nokia.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 29 November 2016 at 15:43, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> ARM1176 CPUs support the Vector Base Address Register but currently,
> qemu only supports VBAR on ARMv7 CPUs. Fix this by adding a new
> feature ARM_FEATURE_VBAR which can used for ARMv7 and ARM1176 CPUs.
>
> The VBAR feature is always set for ARMv7 because some legacy boards
> require it even if this is not architecturally correct. However, to
> support arm1176 CPUs without TrustZone, which doesn't exist in real
> hardware but which is used in old qemu boards, we need to disable the
> feature when 'has_el3' is not set.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  target-arm/cpu.c    |  6 ++++++
>  target-arm/cpu.h    |  1 +
>  target-arm/helper.c | 24 ++++++++++++++++++------
>  3 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/target-arm/cpu.c b/target-arm/cpu.c
> index 99f0dbebb9f6..1007e504248a 100644
> --- a/target-arm/cpu.c
> +++ b/target-arm/cpu.c
> @@ -685,6 +685,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
>           */
>          cpu->id_pfr1 &=3D ~0xf0;
>          cpu->id_aa64pfr0 &=3D ~0xf000;
> +
> +        /* Also disable VBAR support for boards using a arm1176 CPU
> +         * without EL3.
> +         */
> +        unset_feature(env, ARM_FEATURE_VBAR);
>      }
>
>      if (!cpu->has_pmu || !kvm_enabled()) {
> @@ -911,6 +916,7 @@ static void arm1176_initfn(Object *obj)
>
>      cpu->dtb_compatible =3D "arm,arm1176";
>      set_feature(&cpu->env, ARM_FEATURE_V6K);
> +    set_feature(&cpu->env, ARM_FEATURE_VBAR);
>      set_feature(&cpu->env, ARM_FEATURE_VFP);
>      set_feature(&cpu->env, ARM_FEATURE_VAPA);
>      set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
> diff --git a/target-arm/cpu.h b/target-arm/cpu.h
> index ca5c849ed65e..ab119e62ab0f 100644
> --- a/target-arm/cpu.h
> +++ b/target-arm/cpu.h
> @@ -1125,6 +1125,7 @@ enum arm_features {
>      ARM_FEATURE_V8_PMULL, /* implements PMULL part of v8 Crypto Extensio=
ns */
>      ARM_FEATURE_THUMB_DSP, /* DSP insns supported in the Thumb encodings=
 */
>      ARM_FEATURE_PMU, /* has PMU support */
> +    ARM_FEATURE_VBAR, /* has cp15 VBAR */
>  };
>
>  static inline int arm_feature(CPUARMState *env, int feature)
> diff --git a/target-arm/helper.c b/target-arm/helper.c
> index b5b65caadf8a..d417c8ba802f 100644
> --- a/target-arm/helper.c
> +++ b/target-arm/helper.c
> @@ -1252,12 +1252,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] =3D {
>        .access =3D PL1_RW, .accessfn =3D access_tpm, .type =3D ARM_CP_ALI=
AS,
>        .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pminten),
>        .writefn =3D pmintenclr_write },
> -    { .name =3D "VBAR", .state =3D ARM_CP_STATE_BOTH,
> -      .opc0 =3D 3, .crn =3D 12, .crm =3D 0, .opc1 =3D 0, .opc2 =3D 0,
> -      .access =3D PL1_RW, .writefn =3D vbar_write,
> -      .bank_fieldoffsets =3D { offsetof(CPUARMState, cp15.vbar_s),
> -                             offsetof(CPUARMState, cp15.vbar_ns) },
> -      .resetvalue =3D 0 },
>      { .name =3D "CCSIDR", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .crn =3D 0, .crm =3D 0, .opc1 =3D 1, .opc2 =3D 0,
>        .access =3D PL1_R, .readfn =3D ccsidr_read, .type =3D ARM_CP_NO_RA=
W },
> @@ -1412,6 +1406,16 @@ static const ARMCPRegInfo v6k_cp_reginfo[] =3D {
>      REGINFO_SENTINEL
>  };
>
> +static const ARMCPRegInfo vbar_cp_reginfo[] =3D {
> +    { .name =3D "VBAR", .state =3D ARM_CP_STATE_BOTH,
> +      .opc0 =3D 3, .crn =3D 12, .crm =3D 0, .opc1 =3D 0, .opc2 =3D 0,
> +      .access =3D PL1_RW, .writefn =3D vbar_write,
> +      .bank_fieldoffsets =3D { offsetof(CPUARMState, cp15.vbar_s),
> +                             offsetof(CPUARMState, cp15.vbar_ns) },
> +      .resetvalue =3D 0 },
> +    REGINFO_SENTINEL
> +};
> +
>  #ifndef CONFIG_USER_ONLY
>
>  static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegI=
nfo *ri,
> @@ -4506,6 +4510,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>      if (arm_feature(env, ARM_FEATURE_V6K)) {
>          define_arm_cp_regs(cpu, v6k_cp_reginfo);
>      }
> +    if (arm_feature(env, ARM_FEATURE_VBAR)) {
> +        define_arm_cp_regs(cpu, vbar_cp_reginfo);
> +    }
>      if (arm_feature(env, ARM_FEATURE_V7MP) &&
>          !arm_feature(env, ARM_FEATURE_MPU)) {
>          define_arm_cp_regs(cpu, v7mp_cp_reginfo);
> @@ -4543,6 +4550,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          };
>          define_one_arm_cp_reg(cpu, &clidr);
>          define_arm_cp_regs(cpu, v7_cp_reginfo);
> +
> +        /* Always define VBAR even if it doesn't exist in non-EL3
> +         * configs. This is needed by some legacy boards.
> +         */
> +        define_arm_cp_regs(cpu, vbar_cp_reginfo);
>          define_debug_regs(cpu);
>      } else {
>          define_arm_cp_regs(cpu, not_v7_cp_reginfo);
> --
> 2.7.4

This all seems overcomplicated to me. The aim is to define VBAR for:
 * CPUs with TrustZone/EL3
 * ARMv7 CPUs (even if no EL3, for legacy reasons)
right?

We do that by changing arm_cpu_realizefn():
 * add set_feature(arm, ARM_FEATURE_VBAR) to the things we enable
   when the ARM_FEATURE_V7 bit is set (with a comment about why)
 * add
    if (arm_feature(env, ARM_FEATURE_EL3)) {
       set_feature(env, ARM_FEATURE_VBAR));
    }
   in the appropriate place
and then register_cp_regs_for_features() just does
   if (arm_feature(env, ARM_FEATURE_VBAR)) {
       define_arm_cp_regs(cpu, vbar_cp_reginfo);
   }

You don't need to explicitly set the VBAR feature in the 1176
initfn, or unset set feature bits, or register vbar_cp_reginfo
in two separate places.

thanks
-- PMM
