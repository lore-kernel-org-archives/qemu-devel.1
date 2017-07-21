Received: from eggs.gnu.org ([2001:4830:134:3::10]:43190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cdall@linaro.org>) id 1dYW6T-0000og-H4
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cdall@linaro.org>) id 1dYW6O-0005Dl-GC
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:28:17 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cdall@linaro.org>) id 1dYW6O-0005Cy-8u
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:28:12 -0400
Received: by mail-wm0-x22b.google.com with SMTP id w191so11415903wmw.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 04:28:12 -0700 (PDT)
Date: Fri, 21 Jul 2017 13:28:10 +0200
From: Christoffer Dall <cdall@linaro.org>
Message-ID: <20170721112810.GC16350@cbox>
References: <1500471597-2517-1-git-send-email-drjones@redhat.com>
	<1500471597-2517-4-git-send-email-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500471597-2517-4-git-send-email-drjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] hw/arm/virt: allow pmu
 instantiation with userspace irqchip
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

On Wed, Jul 19, 2017 at 09:39:56AM -0400, Andrew Jones wrote:
> Move the in-kernel-irqchip test to only guard the set-irq
> stage, not the init stage of the PMU.  Also add the PMU to
> the KVM device irq line synchronization to enable its use.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>

Reviewed-by: Christoffer Dall <cdall@linaro.org>

> ---
>  hw/arm/virt.c      | 3 ++-
>  target/arm/kvm.c   | 6 +++++-
>  target/arm/kvm64.c | 3 +--
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7157a028adce..a215330444da 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -496,7 +496,8 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
>              return;
>          }
>          if (kvm_enabled()) {
> -            if (!kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ))) {
> +            if (kvm_irqchip_in_kernel() &&
> +                !kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ))) {
>                  return;
>              }
>              if (!kvm_arm_pmu_init(cpu)) {
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 7c17f0d629d7..211a7bf7befd 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -567,7 +567,11 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
>              switched_level &= ~KVM_ARM_DEV_EL1_PTIMER;
>          }
>  
> -        /* XXX PMU IRQ is missing */
> +        if (switched_level & KVM_ARM_DEV_PMU) {
> +            qemu_set_irq(cpu->pmu_interrupt,
> +                         !!(run->s.regs.device_irq_level & KVM_ARM_DEV_PMU));
> +            switched_level &= ~KVM_ARM_DEV_PMU;
> +        }
>  
>          if (switched_level) {
>              qemu_log_mask(LOG_UNIMP, "%s: unhandled in-kernel device IRQ %x\n",
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index e26638a6fac1..ec7d85314acc 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -506,8 +506,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
>      }
> -    if (!kvm_irqchip_in_kernel() ||
> -        !kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
> +    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
>              cpu->has_pmu = false;
>      }
>      if (cpu->has_pmu) {
> -- 
> 1.8.3.1
> 
