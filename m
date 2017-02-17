Received: from eggs.gnu.org ([2001:4830:134:3::10]:38784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceimX-0003pf-R0
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceimW-0006GK-P4
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:41:05 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:34227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceimW-0006Fi-Il
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:41:04 -0500
Received: by mail-wm0-x229.google.com with SMTP id 196so9694872wmm.1
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 05:41:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487313115-9510-6-git-send-email-vijay.kilari@gmail.com>
References: <1487313115-9510-1-git-send-email-vijay.kilari@gmail.com>
	<1487313115-9510-6-git-send-email-vijay.kilari@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 13:40:42 +0000
Message-ID: <CAFEAcA8Fn0DUOx-htiJPQsRUhc+QG0oZ0vYpBees=OaKbu7s0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v8 5/5] hw/intc/arm_gicv3_kvm: Reset GICv3
 cpu interface registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vijay Kilari <vijay.kilari@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Eric Auger <eric.auger@redhat.com>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

On 17 February 2017 at 06:31,  <vijay.kilari@gmail.com> wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>
> Reset CPU interface registers of GICv3 when CPU is reset.
> For this, ARMCPRegInfo struct is registered with one ICC
> register whose resetfn is called when cpu is reset.
>
> All the ICC registers are reset under one single register
> reset function instead of calling resetfn for each ICC
> register.
>
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> ---
>  hw/intc/arm_gicv3_kvm.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index cda1af4..6377dc3 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -604,6 +604,34 @@ static void kvm_arm_gicv3_get(GICv3State *s)
>      }
>  }
>
> +static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    ARMCPU *cpu;
> +    GICv3State *s;
> +    GICv3CPUState *c;
> +
> +    c = (GICv3CPUState *)env->gicv3state;
> +    assert(!(!c || !c->cpu || !c->gic));

I thought I'd made a comment about these asserts on a previous
version of this code... they're pretty unnecessary since if
any of them are untrue we'll just segfault in this function.

The aim of an assert is to turn a hard-to-debug failure that
only becomes visible late into an easy-to-debug failure that
happens earlier. Assertions which don't move the failure
significantly forward in time or turn an obscure problem into a
clear one aren't really worth having.

> +    s = c->gic;
> +    cpu = ARM_CPU(c->cpu);
> +
> +    /* Initialize to actual HW supported configuration */
> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
> +                      KVM_VGIC_ATTR(ICC_CTLR_EL1, cpu->mp_affinity),
> +                      &c->icc_ctlr_el1[GICV3_NS], false);
> +
> +    c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
> +    c->icc_pmr_el1 = 0;
> +    c->icc_bpr[GICV3_G0] = GIC_MIN_BPR;
> +    c->icc_bpr[GICV3_G1] = GIC_MIN_BPR;
> +    c->icc_bpr[GICV3_G1NS] = GIC_MIN_BPR;
> +
> +    c->icc_sre_el1 = 0x7;
> +    memset(c->icc_apr, 0, sizeof(c->icc_apr));
> +    memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
> +}
> +
>  static void kvm_arm_gicv3_reset(DeviceState *dev)
>  {
>      GICv3State *s = ARM_GICV3_COMMON(dev);
> @@ -621,6 +649,30 @@ static void kvm_arm_gicv3_reset(DeviceState *dev)
>      kvm_arm_gicv3_put(s);
>  }
>
> +/*
> + * CPU interface registers of GIC needs to be reset on CPU reset.
> + * For the calling arm_gicv3_icc_reset() on CPU reset, we register
> + * below ARMCPRegInfo. As we reset the whole cpu interface under single
> + * register reset, we define only one register of CPU interface instead
> + * of defining all the registers.
> + */
> +static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
> +    { .name = "ICC_CTLR_EL1", .state = ARM_CP_STATE_BOTH,
> +      .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 12, .opc2 = 4,
> +      .type = ARM_CP_NO_RAW,
> +      .access = PL1_RW,
> +      .readfn = arm_cp_read_zero,
> +      .writefn = arm_cp_write_ignore,
> +      /*
> +       * We hang the whole cpu interface reset routine off here
> +       * rather than parcelling it out into one little function
> +       * per register
> +       */
> +      .resetfn = arm_gicv3_icc_reset,
> +    },
> +    REGINFO_SENTINEL

I asked for a comment saying why we can't use ARM_CP_NOP...

thanks
-- PMM
