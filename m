Received: from eggs.gnu.org ([2001:4830:134:3::10]:54963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6yrC-0007FQ-KT
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6yrB-0008Tn-CL
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:35:14 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:45148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6yrA-0008TL-Su
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:35:13 -0400
Received: by mail-ot0-x241.google.com with SMTP id m3-v6so754138ote.12
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 06:35:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522160122-10744-5-git-send-email-eric.auger@redhat.com>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
	<1522160122-10744-5-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 14:34:51 +0100
Message-ID: <CAFEAcA8sQSuVcYPyE58tjapxxe6FNdD5qcyftYrZeWQ0fbev8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 4/8] hw/intc/arm_gicv3: Implement
 register_redist_region API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <cdall@kernel.org>, Shannon Zhao <zhaoshenglong@huawei.com>

On 27 March 2018 at 15:15, Eric Auger <eric.auger@redhat.com> wrote:
> This patch defines and implements the register_redist_region() API
> for both arm_gicv3 and arm_gicv3_kvm. Virt machine now directly calls
> the function to set the single redistributor region. The associated
> memory region init is removed from gicv3_init_irqs_and_mmio.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/virt.c                      |  6 +++++-
>  hw/intc/arm_gicv3.c                | 21 +++++++++++++++++++++
>  hw/intc/arm_gicv3_common.c         | 10 ++++++----
>  hw/intc/arm_gicv3_kvm.c            | 38 +++++++++++++++++++++++++++++++++++---
>  include/hw/intc/arm_gicv3_common.h |  5 +++--
>  5 files changed, 70 insertions(+), 10 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 94dcb12..0eef6aa 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -526,7 +526,11 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>      gicbusdev = SYS_BUS_DEVICE(gicdev);
>      sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
>      if (type == 3) {
> -        sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
> +        ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_GET_CLASS(gicdev);
> +
> +        agcc->register_redist_region((GICv3State *)gicdev,
> +                                 vms->memmap[VIRT_GIC_REDIST].base,
> +                                 vms->memmap[VIRT_GIC_REDIST].size >> 17);

What is this magic number 17 ?

>      } else {
>          sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
>      }
> diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
> index 479c667..37f7564 100644
> --- a/hw/intc/arm_gicv3.c
> +++ b/hw/intc/arm_gicv3.c
> @@ -378,6 +378,26 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
>      gicv3_init_cpuif(s);
>  }
>
> +static int arm_gicv3_register_redist_region(GICv3State *s, hwaddr base,
> +                                            uint32_t count)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(s);
> +
> +    if (s->nb_redist_regions > 0) {
> +        return -EINVAL;
> +    }
> +
> +    s->redist_region[s->nb_redist_regions].base = base;
> +    s->redist_region[s->nb_redist_regions].count = count;
> +    memory_region_init_io(&s->redist_region[s->nb_redist_regions].mr, OBJECT(s),
> +                          gic_ops, s, "gicv3_redist", 0x20000 * count);
> +    sysbus_init_mmio(sbd, &s->redist_region[s->nb_redist_regions].mr);
> +    sysbus_mmio_map(sbd, 1, base);

Devices should never call sysbus_mmio_map() -- they should
just provide sysbus MMIO regions, and let the board code map
them in the right places. More generally the device code
shouldn't be told where in the memory map it is. kvm_arm_register_device()
goes to some lengths to maintain this abstraction (by setting
up a notifier to tell the kernel where things are only once
everything has been created and mapped).

Similar remarks apply to other changes in this patch (and
I suspect will need some restructuring to address).

> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index 3cf132f..549ccc3 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -220,6 +220,7 @@ struct GICv3State {
>      MemoryRegion iomem_dist; /* Distributor */
>      GICv3RDISTRegion redist_region[GICV3_MAX_RDIST_REGIONS];
>      uint32_t nb_redist_regions;
> +    bool support_multiple_redist_regions;
>
>      uint32_t num_cpu;
>      uint32_t num_irq;
> @@ -297,8 +298,8 @@ typedef struct ARMGICv3CommonClass {
>
>      void (*pre_save)(GICv3State *s);
>      void (*post_load)(GICv3State *s);
> -    /* register an RDIST region at @base, containing @pfns 64kB pages */
> -    int (*register_redist_region)(GICv3State *s, hwaddr base, uint32_t pfns);
> +    /* register an RDIST region at @base, containing @count redistributors */
> +    int (*register_redist_region)(GICv3State *s, hwaddr base, uint32_t count);

This looks like a change that should have been folded into a
previous patch.

>  } ARMGICv3CommonClass;
>
>  void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
> --
> 2.5.5

thanks
-- PMM
