Received: from eggs.gnu.org ([2001:4830:134:3::10]:39178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1chK2z-00069J-1q
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1chK2x-00079Q-U3
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:52:49 -0500
References: <1487850673-26455-1-git-send-email-vijay.kilari@gmail.com>
	<1487850673-26455-6-git-send-email-vijay.kilari@gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0b7e4ab6-c487-d4d2-3336-89ef253dc445@redhat.com>
Date: Fri, 24 Feb 2017 18:52:38 +0100
MIME-Version: 1.0
In-Reply-To: <1487850673-26455-6-git-send-email-vijay.kilari@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 5/5] hw/intc/arm_gicv3_kvm: Reset GICv3
 cpu interface registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vijay.kilari@gmail.com, qemu-arm@nongnu.org, peter.maydell@linaro.org, christoffer.dall@linaro.org
Cc: p.fedin@samsung.com, marc.zyngier@arm.com, qemu-devel@nongnu.org, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Hi

On 23/02/2017 12:51, vijay.kilari@gmail.com wrote:
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/intc/arm_gicv3_kvm.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index cda1af4..81f0403 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -604,6 +604,32 @@ static void kvm_arm_gicv3_get(GICv3State *s)
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
> @@ -621,6 +647,34 @@ static void kvm_arm_gicv3_reset(DeviceState *dev)
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
> +      /*
> +       * If ARM_CP_NOP is used, resetfn is not called,
> +       * So ARM_CP_NO_RAW is appropriate type.
> +       */
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
> +};
> +
>  static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>  {
>      GICv3State *s = KVM_ARM_GICV3(dev);
> @@ -644,6 +698,12 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>  
>      gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
>  
> +    for (i = 0; i < s->num_cpu; i++) {
> +        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
> +
> +        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
> +    }
> +
>      /* Try to create the device via the device control API */
>      s->dev_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_ARM_VGIC_V3, false);
>      if (s->dev_fd < 0) {
> 
