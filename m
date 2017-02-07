Received: from eggs.gnu.org ([2001:4830:134:3::10]:51418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb75o-000574-CN
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb75n-0002WQ-BE
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:50:04 -0500
Received: from mail-wj0-x232.google.com ([2a00:1450:400c:c01::232]:34829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb75n-0002Vr-3H
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:50:03 -0500
Received: by mail-wj0-x232.google.com with SMTP id b20so4673227wjs.2
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 06:50:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485879782-6075-6-git-send-email-vijay.kilari@gmail.com>
References: <1485879782-6075-1-git-send-email-vijay.kilari@gmail.com>
	<1485879782-6075-6-git-send-email-vijay.kilari@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 14:49:41 +0000
Message-ID: <CAFEAcA-7PE_T7BsV=vSCEkQDeekB9KnX33Ou5NiUec4XeUu+zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v7 RESEND 5/5] hw/intc/arm_gicv3_kvm: Reset
 GICv3 cpu interface registers
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

On 31 January 2017 at 16:23,  <vijay.kilari@gmail.com> wrote:
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
>  hw/intc/arm_gicv3_kvm.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index f91e0ac..c3f38aa 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -604,6 +604,39 @@ static void kvm_arm_gicv3_get(GICv3State *s)
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
> +    if (!c || !c->cpu || !c->gic) {

We should assert this kind of thing, not just silently do nothing.
Or just assume it's true, because if it's not then we'll segfault
immediately below which is just as clear an indication of where
the bug is as asserting.

> +        return;
> +    }
> +
> +    s = c->gic;
> +    if (!s) {

You've already checked this once.

> +        return;
> +    }
> +
> +    cpu = ARM_CPU(c->cpu);
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
> @@ -621,6 +654,41 @@ static void kvm_arm_gicv3_reset(DeviceState *dev)
>      kvm_arm_gicv3_put(s);
>  }
>
> +static uint64_t icc_cp_reg_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    return 0;
> +}
> +
> +static void icc_cp_reg_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                          uint64_t value)
> +{
> +    return;
> +}

If you want to do nothing in a read/write function there are
already arm_cp_read_zero and arm_cp_write_ignore functions for
this. But using the ARM_CP_NOP flag is better still.

> +
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
> +      .readfn = icc_cp_reg_read,
> +      .writefn = icc_cp_reg_write,
> +      /*
> +       * We hang the whole cpu interface reset routine off here
> +       * rather than parcelling it out into one little function
> +       * per register
> +       */
> +      .resetfn = arm_gicv3_icc_reset,
> +    },
> +    REGINFO_SENTINEL
> +};
> +
>  static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>  {
>      GICv3State *s = KVM_ARM_GICV3(dev);
> @@ -650,6 +718,7 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>
>          /* Store GICv3CPUState in CPUARMState gicv3state pointer */
>          env->gicv3state = (void *)&s->cpu[i];
> +        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
>      }
>
>      /* Try to create the device via the device control API */
> --
> 1.9.1
>

thanks
-- PMM
