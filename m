Received: from eggs.gnu.org ([2001:4830:134:3::10]:50518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fTSZ1-0000mF-Uf
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fTSZ0-0003I6-Ox
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:45:23 -0400
Date: Thu, 14 Jun 2018 15:45:14 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180614134514.fxae6m2ucsfpczpl@kamzik.brq.redhat.com>
References: <1528879723-24675-1-git-send-email-eric.auger@redhat.com>
	<1528879723-24675-8-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528879723-24675-8-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/9] hw/arm/virt: Register two
 redistributor regions when necessary
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

On Wed, Jun 13, 2018 at 10:48:41AM +0200, Eric Auger wrote:
> With a VGICv3 KVM device, if the number of vcpus exceeds the
> capacity of the legacy redistributor region (123 redistributors),
> we now attempt to register a second redistributor region. Up to
> 512 redistributors can fit in this latter on top of the 123 allowed
> by the legacy redistributor region.
> 
> Registering this second redistributor region is possible if the
> host kernel supports the following VGICv3 KVM device group/attribute:
> KVM_DEV_ARM_VGIC_GRP_ADDR/KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION.
> 
> In case the host kernel does not support the registration of several
> redistributor regions and the requested number of vcpus exceeds the
> capacity of the legacy redistributor region, the GICv3 device
> initialization fails with a proper error message and qemu exits.
> 
> At the moment the max number of vcpus still is capped by the
> virt machine class max_cpus.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - remove spare space
> ---
>  hw/arm/virt.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 5c02cc5..2a1c0fb 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -528,6 +528,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>      SysBusDevice *gicbusdev;
>      const char *gictype;
>      int type = vms->gic_version, i;
> +    uint32_t nb_redist_regions = 0;
>  
>      gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
>  
> @@ -547,14 +548,28 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>                      vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
>          uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
>  
> -        qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
> +        nb_redist_regions = virt_gicv3_redist_region_count(vms);
> +
> +        qdev_prop_set_uint32(gicdev, "len-redist-region-count",
> +                             nb_redist_regions);
>          qdev_prop_set_uint32(gicdev, "redist-region-count[0]", redist0_count);
> +
> +        if (nb_redist_regions == 2) {
> +            uint32_t redist1_capacity =
> +                        vms->memmap[VIRT_GIC_REDIST2].size / GICV3_REDIST_SIZE;
> +
> +            qdev_prop_set_uint32(gicdev, "redist-region-count[1]",
> +                MIN(smp_cpus - redist0_count, redist1_capacity));
> +        }
>      }
>      qdev_init_nofail(gicdev);
>      gicbusdev = SYS_BUS_DEVICE(gicdev);
>      sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
>      if (type == 3) {
>          sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
> +        if (nb_redist_regions == 2) {
> +            sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_GIC_REDIST2].base);
> +        }
>      } else {
>          sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
>      }
> @@ -1350,6 +1365,7 @@ static void machvirt_init(MachineState *machine)
>       */
>      if (vms->gic_version == 3) {
>          virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
> +        virt_max_cpus += vms->memmap[VIRT_GIC_REDIST2].size / GICV3_REDIST_SIZE;
>      } else {
>          virt_max_cpus = GIC_NCPU;
>      }
> -- 
> 2.5.5
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
