Received: from eggs.gnu.org ([2001:4830:134:3::10]:48465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMAnq-0001hr-40
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMAnl-0001G9-UH
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:54:50 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMAnl-0001FU-Lm
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:54:45 -0500
Received: by mail-wm1-x344.google.com with SMTP id r11-v6so8180544wmb.2
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 03:54:45 -0800 (PST)
References: <20181109134731.11605-1-peter.maydell@linaro.org>
	<20181109134731.11605-2-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181109134731.11605-2-peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 11:54:42 +0000
Message-ID: <87in12ecjh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-v3.1 1/3] Revert
 "target/arm: Implement HCR.VI and VF"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Adam Lackorzynski <adam.lackorzynski@kernkonzept.com>, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> This reverts commit 8a0fc3a29fc2315325400c738f807d0d4ae0ab7f.
>
> The implementation of HCR.VI and VF in that commit is not
> correct -- they do not track the overall "is there a pending
> VIRQ or VFIQ" status, but whether there is a pending interrupt
> due to "this mechanism", ie the hypervisor having set the VI/VF
> bits. The overall pending state for VIRQ and VFIQ is effectively
> the logical OR of the inbound lines from the GIC with the
> VI and VF bits. Commit 8a0fc3a29fc231 would result in pending
> VIRQ/VFIQ possibly being lost when the hypervisor wrote to HCR.
>
> As a preliminary to implementing the HCR.VI/VF feature properly,
> revert the broken one entirely.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 47 ++++-----------------------------------------
>  1 file changed, 4 insertions(+), 43 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 851ea9aa977..f3878f505b7 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3931,7 +3931,6 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[=
] =3D {
>  static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t=
 value)
>  {
>      ARMCPU *cpu =3D arm_env_get_cpu(env);
> -    CPUState *cs =3D ENV_GET_CPU(env);
>      uint64_t valid_mask =3D HCR_MASK;
>
>      if (arm_feature(env, ARM_FEATURE_EL3)) {
> @@ -3950,28 +3949,6 @@ static void hcr_write(CPUARMState *env, const ARMC=
PRegInfo *ri, uint64_t value)
>      /* Clear RES0 bits.  */
>      value &=3D valid_mask;
>
> -    /*
> -     * VI and VF are kept in cs->interrupt_request. Modifying that
> -     * requires that we have the iothread lock, which is done by
> -     * marking the reginfo structs as ARM_CP_IO.
> -     * Note that if a write to HCR pends a VIRQ or VFIQ it is never
> -     * possible for it to be taken immediately, because VIRQ and
> -     * VFIQ are masked unless running at EL0 or EL1, and HCR
> -     * can only be written at EL2.
> -     */
> -    g_assert(qemu_mutex_iothread_locked());
> -    if (value & HCR_VI) {
> -        cs->interrupt_request |=3D CPU_INTERRUPT_VIRQ;
> -    } else {
> -        cs->interrupt_request &=3D ~CPU_INTERRUPT_VIRQ;
> -    }
> -    if (value & HCR_VF) {
> -        cs->interrupt_request |=3D CPU_INTERRUPT_VFIQ;
> -    } else {
> -        cs->interrupt_request &=3D ~CPU_INTERRUPT_VFIQ;
> -    }
> -    value &=3D ~(HCR_VI | HCR_VF);
> -
>      /* These bits change the MMU setup:
>       * HCR_VM enables stage 2 translation
>       * HCR_PTW forbids certain page-table setups
> @@ -3999,32 +3976,16 @@ static void hcr_writelow(CPUARMState *env, const =
ARMCPRegInfo *ri,
>      hcr_write(env, NULL, value);
>  }
>
> -static uint64_t hcr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> -{
> -    /* The VI and VF bits live in cs->interrupt_request */
> -    uint64_t ret =3D env->cp15.hcr_el2 & ~(HCR_VI | HCR_VF);
> -    CPUState *cs =3D ENV_GET_CPU(env);
> -
> -    if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
> -        ret |=3D HCR_VI;
> -    }
> -    if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
> -        ret |=3D HCR_VF;
> -    }
> -    return ret;
> -}
> -
>  static const ARMCPRegInfo el2_cp_reginfo[] =3D {
>      { .name =3D "HCR_EL2", .state =3D ARM_CP_STATE_AA64,
> -      .type =3D ARM_CP_IO,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 0,
>        .access =3D PL2_RW, .fieldoffset =3D offsetof(CPUARMState, cp15.hc=
r_el2),
> -      .writefn =3D hcr_write, .readfn =3D hcr_read },
> +      .writefn =3D hcr_write },
>      { .name =3D "HCR", .state =3D ARM_CP_STATE_AA32,
> -      .type =3D ARM_CP_ALIAS | ARM_CP_IO,
> +      .type =3D ARM_CP_ALIAS,
>        .cp =3D 15, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 0,
>        .access =3D PL2_RW, .fieldoffset =3D offsetof(CPUARMState, cp15.hc=
r_el2),
> -      .writefn =3D hcr_writelow, .readfn =3D hcr_read },
> +      .writefn =3D hcr_writelow },
>      { .name =3D "ELR_EL2", .state =3D ARM_CP_STATE_AA64,
>        .type =3D ARM_CP_ALIAS,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 4, .crm =3D 0, .opc2 =3D 1,
> @@ -4261,7 +4222,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {
>
>  static const ARMCPRegInfo el2_v8_cp_reginfo[] =3D {
>      { .name =3D "HCR2", .state =3D ARM_CP_STATE_AA32,
> -      .type =3D ARM_CP_ALIAS | ARM_CP_IO,
> +      .type =3D ARM_CP_ALIAS,
>        .cp =3D 15, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 4,
>        .access =3D PL2_RW,
>        .fieldoffset =3D offsetofhigh32(CPUARMState, cp15.hcr_el2),


--
Alex Benn=C3=A9e
