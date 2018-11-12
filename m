Received: from eggs.gnu.org ([2001:4830:134:3::10]:36723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzsv-0001V5-Qy
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 19:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzsr-0001rN-3e
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 19:15:21 -0500
MIME-Version: 1.0
References: <20181109134731.11605-1-peter.maydell@linaro.org>
	<20181109134731.11605-4-peter.maydell@linaro.org>
In-Reply-To: <20181109134731.11605-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 01:14:57 +0100
Message-ID: <CAAdtpL4JRDUQafj2fGapgJsG+vAaexu7ACP6cjUiCDh33gdA4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-v3.1 3/3] target/arm:
 Correctly implement handling of HCR_EL2.{VI, VF}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, adam.lackorzynski@kernkonzept.com, Patch Tracking <patches@linaro.org>

On Fri, Nov 9, 2018 at 2:48 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> In commit 8a0fc3a29fc2315325400 we tried to implement HCR_EL2.{VI,VF},
> but we got it wrong and had to revert it.
>
> In that commit we implemented them as simply tracking whether there
> is a pending virtual IRQ or virtual FIQ. This is not correct -- these
> bits cause a software-generated VIRQ/VFIQ, which is distinct from
> whether there is a hardware-generated VIRQ/VFIQ caused by the
> external interrupt controller. So we need to track separately
> the HCR_EL2 bit state and the external virq/vfiq line state, and
> OR the two together to get the actual pending VIRQ/VFIQ state.
>
> Fixes: 8a0fc3a29fc2315325400c738f807d0d4ae0ab7f
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

On Fri, Nov 9, 2018 at 2:49 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> Currently we track the state of the four irq lines from the GIC
> only via the cs->interrupt_request or KVM irq state. That means
> that we assume that an interrupt is asserted if and only if the
> external line is set. This assumption is incorrect for VIRQ
> and VFIQ, because the HCR_EL2.{VI,VF} bits allow assertion
> of VIRQ and VFIQ separately from the state of the external line.
>
> To handle this, start tracking the state of the external lines
> explicitly in a CPU state struct field, as is common practice
> for devices.
>
> The complicated part of this is dealing with inbound migration
> from an older QEMU which didn't have this state. We assume in
> that case that the older QEMU did not implement the HCR_EL2.{VI,VF}
> bits as generating interrupts, and so the line state matches
> the current state in cs->interrupt_request. (This is not quite
> true between commit 8a0fc3a29fc2315325400c7 and its revert, but
> that commit is broken and never made it into any released QEMU
> version.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  target/arm/internals.h | 18 ++++++++++++++++
>  target/arm/cpu.c       | 48 +++++++++++++++++++++++++++++++++++++++++-
>  target/arm/helper.c    | 20 ++++++++++++++++--
>  3 files changed, 83 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 6c2bb2deebd..a32d359dd03 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -871,4 +871,22 @@ static inline const char *aarch32_mode_name(uint32_t=
 psr)
>      return cpu_mode_names[psr & 0xf];
>  }
>
> +/**
> + * arm_cpu_update_virq: Update CPU_INTERRUPT_VIRQ bit in cs->interrupt_r=
equest
> + *
> + * Update the CPU_INTERRUPT_VIRQ bit in cs->interrupt_request, following
> + * a change to either the input VIRQ line from the GIC or the HCR_EL2.VI=
 bit.
> + * Must be called with the iothread lock held.
> + */
> +void arm_cpu_update_virq(ARMCPU *cpu);
> +
> +/**
> + * arm_cpu_update_vfiq: Update CPU_INTERRUPT_VFIQ bit in cs->interrupt_r=
equest
> + *
> + * Update the CPU_INTERRUPT_VFIQ bit in cs->interrupt_request, following
> + * a change to either the input VFIQ line from the GIC or the HCR_EL2.VF=
 bit.
> + * Must be called with the iothread lock held.
> + */
> +void arm_cpu_update_vfiq(ARMCPU *cpu);
> +
>  #endif
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 45c16ae90ba..6fbea4dc88c 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -436,6 +436,48 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs,=
 int interrupt_request)
>  }
>  #endif
>
> +void arm_cpu_update_virq(ARMCPU *cpu)
> +{
> +    /*
> +     * Update the interrupt level for VIRQ, which is the logical OR of
> +     * the HCR_EL2.VI bit and the input line level from the GIC.
> +     */
> +    CPUARMState *env =3D &cpu->env;
> +    CPUState *cs =3D CPU(cpu);
> +
> +    bool new_state =3D (env->cp15.hcr_el2 & HCR_VI) ||
> +        (env->irq_line_state & CPU_INTERRUPT_VIRQ);
> +
> +    if (new_state !=3D ((cs->interrupt_request & CPU_INTERRUPT_VIRQ) !=
=3D 0)) {
> +        if (new_state) {
> +            cpu_interrupt(cs, CPU_INTERRUPT_VIRQ);
> +        } else {
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_VIRQ);
> +        }
> +    }
> +}
> +
> +void arm_cpu_update_vfiq(ARMCPU *cpu)
> +{
> +    /*
> +     * Update the interrupt level for VFIQ, which is the logical OR of
> +     * the HCR_EL2.VF bit and the input line level from the GIC.
> +     */
> +    CPUARMState *env =3D &cpu->env;
> +    CPUState *cs =3D CPU(cpu);
> +
> +    bool new_state =3D (env->cp15.hcr_el2 & HCR_VF) ||
> +        (env->irq_line_state & CPU_INTERRUPT_VFIQ);
> +
> +    if (new_state !=3D ((cs->interrupt_request & CPU_INTERRUPT_VFIQ) !=
=3D 0)) {
> +        if (new_state) {
> +            cpu_interrupt(cs, CPU_INTERRUPT_VFIQ);
> +        } else {
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_VFIQ);
> +        }
> +    }
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  static void arm_cpu_set_irq(void *opaque, int irq, int level)
>  {
> @@ -457,9 +499,13 @@ static void arm_cpu_set_irq(void *opaque, int irq, i=
nt level)
>
>      switch (irq) {
>      case ARM_CPU_VIRQ:
> +        assert(arm_feature(env, ARM_FEATURE_EL2));
> +        arm_cpu_update_virq(cpu);
> +        break;
>      case ARM_CPU_VFIQ:
>          assert(arm_feature(env, ARM_FEATURE_EL2));
> -        /* fall through */
> +        arm_cpu_update_vfiq(cpu);
> +        break;
>      case ARM_CPU_IRQ:
>      case ARM_CPU_FIQ:
>          if (level) {
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f3878f505b7..771e4c3d0fb 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3958,6 +3958,21 @@ static void hcr_write(CPUARMState *env, const ARMC=
PRegInfo *ri, uint64_t value)
>          tlb_flush(CPU(cpu));
>      }
>      env->cp15.hcr_el2 =3D value;
> +
> +    /*
> +     * Updates to VI and VF require us to update the status of
> +     * virtual interrupts, which are the logical OR of these bits
> +     * and the state of the input lines from the GIC. (This requires
> +     * that we have the iothread lock, which is done by marking the
> +     * reginfo structs as ARM_CP_IO.)
> +     * Note that if a write to HCR pends a VIRQ or VFIQ it is never
> +     * possible for it to be taken immediately, because VIRQ and
> +     * VFIQ are masked unless running at EL0 or EL1, and HCR
> +     * can only be written at EL2.
> +     */
> +    g_assert(qemu_mutex_iothread_locked());
> +    arm_cpu_update_virq(cpu);
> +    arm_cpu_update_vfiq(cpu);
>  }
>
>  static void hcr_writehigh(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3978,11 +3993,12 @@ static void hcr_writelow(CPUARMState *env, const =
ARMCPRegInfo *ri,
>
>  static const ARMCPRegInfo el2_cp_reginfo[] =3D {
>      { .name =3D "HCR_EL2", .state =3D ARM_CP_STATE_AA64,
> +      .type =3D ARM_CP_IO,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 0,
>        .access =3D PL2_RW, .fieldoffset =3D offsetof(CPUARMState, cp15.hc=
r_el2),
>        .writefn =3D hcr_write },
>      { .name =3D "HCR", .state =3D ARM_CP_STATE_AA32,
> -      .type =3D ARM_CP_ALIAS,
> +      .type =3D ARM_CP_ALIAS | ARM_CP_IO,
>        .cp =3D 15, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 0,
>        .access =3D PL2_RW, .fieldoffset =3D offsetof(CPUARMState, cp15.hc=
r_el2),
>        .writefn =3D hcr_writelow },
> @@ -4222,7 +4238,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {
>
>  static const ARMCPRegInfo el2_v8_cp_reginfo[] =3D {
>      { .name =3D "HCR2", .state =3D ARM_CP_STATE_AA32,
> -      .type =3D ARM_CP_ALIAS,
> +      .type =3D ARM_CP_ALIAS | ARM_CP_IO,
>        .cp =3D 15, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 4,
>        .access =3D PL2_RW,
>        .fieldoffset =3D offsetofhigh32(CPUARMState, cp15.hcr_el2),
> --
> 2.19.1
>
>
