Received: from eggs.gnu.org ([2001:4830:134:3::10]:36146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL6Vb-00027q-Vn
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL6VX-0001e9-VJ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:35:20 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL6VX-0001dW-Qd
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:35:15 -0400
Received: by mail-oi0-x242.google.com with SMTP id w123-v6so16006227oia.4
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 05:35:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526222114-5324-5-git-send-email-eric.auger@redhat.com>
References: <1526222114-5324-1-git-send-email-eric.auger@redhat.com>
	<1526222114-5324-5-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 13:34:54 +0100
Message-ID: <CAFEAcA-foFnb7zcO_apsOk15ELpYcWqhAo1pyonm6h_1Wrkd8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 4/7] hw/intc/arm_gicv3_kvm: Get prepared
 to handle multiple redist regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

On 13 May 2018 at 15:35, Eric Auger <eric.auger@redhat.com> wrote:
> Let's check if KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION is supported.
> If not, we check the number of redist region is equal to 1 and use the
> legacy KVM_VGIC_V3_ADDR_TYPE_REDIST attribute. Otherwise we use
> the new attribute and allow to register multiple regions to the
> KVM device.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/intc/arm_gicv3_kvm.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 7e76b87..1b32804 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -714,6 +714,7 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>  {
>      GICv3State *s = KVM_ARM_GICV3(dev);
>      KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
> +    bool multiple_redist_region_allowed;
>      Error *local_err = NULL;
>      int i;
>
> @@ -750,6 +751,18 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
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
> @@ -759,9 +772,21 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
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
> +        for (i = s->nb_redist_regions; i >= 0; i--) {
> +            uint64_t val = i | ((uint64_t)s->redist_region_count[i] << 52);

A comment here about what this value is would be useful.

> +
> +            kvm_arm_register_device(&s->iomem_redist[i], -1,
> +                                    KVM_DEV_ARM_VGIC_GRP_ADDR,
> +                                    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION,
> +                                    s->dev_fd, val);
> +        }
> +    }
>
>      if (kvm_has_gsi_routing()) {
>          /* set up irq routing */

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
