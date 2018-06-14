Received: from eggs.gnu.org ([2001:4830:134:3::10]:49277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fTST6-0004te-Vj
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fTST6-0001eB-1U
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:39:17 -0400
Date: Thu, 14 Jun 2018 15:39:04 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180614133904.bic4wwjeed4ybu2u@kamzik.brq.redhat.com>
References: <1528879723-24675-1-git-send-email-eric.auger@redhat.com>
	<1528879723-24675-5-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528879723-24675-5-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] hw/intc/arm_gicv3_kvm: Get prepared to
 handle multiple redist regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, christoffer.dall@arm.com, zhaoshenglong@huawei.com, lersek@redhat.com

On Wed, Jun 13, 2018 at 10:48:38AM +0200, Eric Auger wrote:
> Let's check if KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION is supported.
> If not, we check the number of redist region is equal to 1 and use the
> legacy KVM_VGIC_V3_ADDR_TYPE_REDIST attribute. Otherwise we use
> the new attribute and allow to register multiple regions to the
> KVM device.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> ---
> 
> v2 -> v3:
> - In kvm_arm_gicv3_realize rename val into add_ormask local variable and
>   add a comment
> - start the redist region registration  from s->nb_redist_regions - 1
>   downwards
> ---
>  hw/intc/arm_gicv3_kvm.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index ed7b719..52e6e70 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -753,6 +753,7 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>  {
>      GICv3State *s = KVM_ARM_GICV3(dev);
>      KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
> +    bool multiple_redist_region_allowed;
>      Error *local_err = NULL;
>      int i;
>  
> @@ -789,6 +790,18 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    multiple_redist_region_allowed =
> +        kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
> +                              KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION);
> +
> +    if (!multiple_redist_region_allowed && s->nb_redist_regions > 1) {
> +        error_setg(errp, "Multiple VGICv3 redistributor regions are not "
> +                   "supported by this host kernel");
> +        error_append_hint(errp, "A maximum of %d VCPUs can be used",
> +                          s->redist_region_count[0]);
> +        return;
> +    }
> +
>      kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
>                        0, &s->num_irq, true, &error_abort);
>  
> @@ -798,9 +811,23 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>  
>      kvm_arm_register_device(&s->iomem_dist, -1, KVM_DEV_ARM_VGIC_GRP_ADDR,
>                              KVM_VGIC_V3_ADDR_TYPE_DIST, s->dev_fd, 0);
> -    kvm_arm_register_device(&s->iomem_redist[0], -1,
> -                            KVM_DEV_ARM_VGIC_GRP_ADDR,
> -                            KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd, 0);
> +
> +    if (!multiple_redist_region_allowed) {
> +        kvm_arm_register_device(&s->iomem_redist[0], -1,
> +                                KVM_DEV_ARM_VGIC_GRP_ADDR,
> +                                KVM_VGIC_V3_ADDR_TYPE_REDIST, s->dev_fd, 0);
> +    } else {
> +        for (i = s->nb_redist_regions - 1; i >= 0; i--) {

So we register in reverse-index order? Looking at your update to Linux doc
Documentation/virtual/kvm/devices/arm-vgic-v3.txt, shouldn't they be
registered in index-order? The doc says "Redistributor regions must be
registered in the incremental index order, starting from index 0."

Thanks,
drew

> +            /* Address mask made of the rdist region index and count */
> +            uint64_t addr_ormask =
> +                        i | ((uint64_t)s->redist_region_count[i] << 52);
> +
> +            kvm_arm_register_device(&s->iomem_redist[i], -1,
> +                                    KVM_DEV_ARM_VGIC_GRP_ADDR,
> +                                    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION,
> +                                    s->dev_fd, addr_ormask);
> +        }
> +    }
>  
>      if (kvm_has_gsi_routing()) {
>          /* set up irq routing */
> -- 
> 2.5.5
> 
> 
