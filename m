Received: from eggs.gnu.org ([2001:4830:134:3::10]:42968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cdall@linaro.org>) id 1dYW4N-0000Ck-0U
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cdall@linaro.org>) id 1dYW4I-0003ic-2K
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:26:07 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:34767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cdall@linaro.org>) id 1dYW4H-0003gu-O5
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:26:01 -0400
Received: by mail-wm0-x231.google.com with SMTP id l81so2971616wmg.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 04:26:01 -0700 (PDT)
Date: Fri, 21 Jul 2017 13:25:59 +0200
From: Christoffer Dall <cdall@linaro.org>
Message-ID: <20170721112559.GB16350@cbox>
References: <1500471597-2517-1-git-send-email-drjones@redhat.com>
	<1500471597-2517-3-git-send-email-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500471597-2517-3-git-send-email-drjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] target/arm/kvm: pmu: split init and
 set-irq stages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, agraf@suse.de

On Wed, Jul 19, 2017 at 09:39:55AM -0400, Andrew Jones wrote:
> When adding a PMU with a userspace irqchip we skip the set-irq
> stage of device creation. Split the 'create' function into two
> functions 'init' and 'set-irq' so they may be called separately.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>

Reviewed-by: Christoffer Dall <cdall@linaro.org>

> ---
>  hw/arm/virt.c        | 11 +++++++++--
>  target/arm/kvm32.c   |  8 +++++++-
>  target/arm/kvm64.c   | 52 +++++++++++++++++++++++++---------------------------
>  target/arm/kvm_arm.h | 10 ++++++++--
>  4 files changed, 49 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ea26f0c473c2..7157a028adce 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -492,10 +492,17 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
>  
>      CPU_FOREACH(cpu) {
>          armcpu = ARM_CPU(cpu);
> -        if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU) ||
> -            (kvm_enabled() && !kvm_arm_pmu_create(cpu, PPI(VIRTUAL_PMU_IRQ)))) {
> +        if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
>              return;
>          }
> +        if (kvm_enabled()) {
> +            if (!kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ))) {
> +                return;
> +            }
> +            if (!kvm_arm_pmu_init(cpu)) {
> +                return;
> +            }
> +        }
>      }
>  
>      if (vms->gic_version == 2) {
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index 069da0c5fd10..e3aab89a1a94 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -522,7 +522,13 @@ bool kvm_arm_hw_debug_active(CPUState *cs)
>      return false;
>  }
>  
> -int kvm_arm_pmu_create(CPUState *cs, int irq)
> +int kvm_arm_pmu_set_irq(CPUState *cs, int irq)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
> +    return 0;
> +}
> +
> +int kvm_arm_pmu_init(CPUState *cs)
>  {
>      qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
>      return 0;
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index a16abc8d129e..e26638a6fac1 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -381,46 +381,44 @@ static CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
>      return NULL;
>  }
>  
> -static bool kvm_arm_pmu_support_ctrl(CPUState *cs, struct kvm_device_attr *attr)
> -{
> -    return kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr) == 0;
> -}
> -
> -int kvm_arm_pmu_create(CPUState *cs, int irq)
> +static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
>  {
>      int err;
>  
> -    struct kvm_device_attr attr = {
> -        .group = KVM_ARM_VCPU_PMU_V3_CTRL,
> -        .addr = (intptr_t)&irq,
> -        .attr = KVM_ARM_VCPU_PMU_V3_IRQ,
> -        .flags = 0,
> -    };
> -
> -    if (!kvm_arm_pmu_support_ctrl(cs, &attr)) {
> -        return 0;
> +    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
> +    if (err != 0) {
> +        return false;
>      }
>  
> -    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, &attr);
> +    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
>      if (err < 0) {
>          fprintf(stderr, "KVM_SET_DEVICE_ATTR failed: %s\n",
>                  strerror(-err));
>          abort();
>      }
>  
> -    attr.group = KVM_ARM_VCPU_PMU_V3_CTRL;
> -    attr.attr = KVM_ARM_VCPU_PMU_V3_INIT;
> -    attr.addr = 0;
> -    attr.flags = 0;
> +    return true;
> +}
>  
> -    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, &attr);
> -    if (err < 0) {
> -        fprintf(stderr, "KVM_SET_DEVICE_ATTR failed: %s\n",
> -                strerror(-err));
> -        abort();
> -    }
> +int kvm_arm_pmu_init(CPUState *cs)
> +{
> +    struct kvm_device_attr attr = {
> +        .group = KVM_ARM_VCPU_PMU_V3_CTRL,
> +        .attr = KVM_ARM_VCPU_PMU_V3_INIT,
> +    };
> +
> +    return kvm_arm_pmu_set_attr(cs, &attr);
> +}
> +
> +int kvm_arm_pmu_set_irq(CPUState *cs, int irq)
> +{
> +    struct kvm_device_attr attr = {
> +        .group = KVM_ARM_VCPU_PMU_V3_CTRL,
> +        .addr = (intptr_t)&irq,
> +        .attr = KVM_ARM_VCPU_PMU_V3_IRQ,
> +    };
>  
> -    return 1;
> +    return kvm_arm_pmu_set_attr(cs, &attr);
>  }
>  
>  static inline void set_feature(uint64_t *features, int feature)
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 633d08828a5d..cab5ea9be55c 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -195,7 +195,8 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu);
>  
>  int kvm_arm_vgic_probe(void);
>  
> -int kvm_arm_pmu_create(CPUState *cs, int irq);
> +int kvm_arm_pmu_set_irq(CPUState *cs, int irq);
> +int kvm_arm_pmu_init(CPUState *cs);
>  
>  #else
>  
> @@ -204,7 +205,12 @@ static inline int kvm_arm_vgic_probe(void)
>      return 0;
>  }
>  
> -static inline int kvm_arm_pmu_create(CPUState *cs, int irq)
> +static inline int kvm_arm_pmu_set_irq(CPUState *cs, int irq)
> +{
> +    return 0;
> +}
> +
> +static inline int kvm_arm_pmu_init(CPUState *cs)
>  {
>      return 0;
>  }
> -- 
> 1.8.3.1
> 
