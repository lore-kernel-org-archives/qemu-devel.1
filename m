Received: from eggs.gnu.org ([2001:4830:134:3::10]:40963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evMqp-0003Jw-0C
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evMqn-0002OP-Jx
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:46:51 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evMqn-0002N9-DQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:46:49 -0400
Received: by mail-ot0-x241.google.com with SMTP id y11so15116335otg.0
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 05:46:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1518893216-9983-13-git-send-email-eric.auger@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-13-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 12:46:28 +0000
Message-ID: <CAFEAcA-BZ=wcpEKVQnX0dBh7tZVPNfHRm1E39DYEMZ=UStEamA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 12/14] hw/arm/virt: Add SMMUv3 to the
 virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
> From: Prem Mallappa <prem.mallappa@broadcom.com>
>
> Add code to instantiate an smmuv3 in virt machine. A new iommu
> integer member is introduced in VirtMachineState to store the type
> of the iommu in use.
>
> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
> v7 -> v8:
> - integer iommu member
> - add primary-bus property
>
> v4 -> v5:
> - add dma-coherent property
>
> v2 -> v3:
> - vbi was removed. Use vms instead
> - migrate to new smmu binding format (iommu-map)
> - don't use appendprop anymore
> - add vms->smmu and guard instantiation with this latter
> - interrupts type changed to edge
>
> Conflicts:
>         hw/arm/smmuv3.c
> ---
>  hw/arm/virt.c         | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/hw/arm/virt.h | 10 ++++++++
>  2 files changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index dbb3c80..e9dca0d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -58,6 +58,7 @@
>  #include "hw/smbios/smbios.h"
>  #include "qapi/visitor.h"
>  #include "standard-headers/linux/input.h"
> +#include "hw/arm/smmuv3.h"
>
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -141,6 +142,7 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
>      [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>      [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
> +    [VIRT_SMMU] =               { 0x09050000, 0x00020000 }, /* 128K, needed */

What does the "needed" comment mean here?

>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -161,6 +163,7 @@ static const int a15irqmap[] = {
>      [VIRT_SECURE_UART] = 8,
>      [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
>      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
> +    [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
>      [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
>  };
>
> @@ -941,7 +944,57 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
>                             0x7           /* PCI irq */);
>  }
>
> -static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
> +static void create_smmu(const VirtMachineState *vms, qemu_irq *pic,
> +                        PCIBus *bus)

Side suggestion: if you add "algorithm = histogram" to the [diff] section
of your .gitconfig, you will probably find that it doesn't generate patches
with this sort of silly patch hunk any more. I only discovered this
config setting recently but I think it's better than the default.

> +{
> +    char *node;
> +    const char compat[] = "arm,smmu-v3";
> +    int irq =  vms->irqmap[VIRT_SMMU];
> +    int i;
> +    hwaddr base = vms->memmap[VIRT_SMMU].base;
> +    hwaddr size = vms->memmap[VIRT_SMMU].size;
> +    const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
> +    DeviceState *dev;
> +
> +    if (vms->iommu != VIRT_IOMMU_SMMUV3 || !vms->iommu_phandle) {
> +        return;
> +    }
> +
> +    dev = qdev_create(NULL, "arm-smmuv3");
> +
> +    object_property_set_link(OBJECT(dev), OBJECT(bus), "primary-bus",
> +                             &error_abort);
> +    qdev_init_nofail(dev);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +    for (i = 0; i < NUM_SMMU_IRQS; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
> +    }
> +
> +    node = g_strdup_printf("/smmuv3@%" PRIx64, base);
> +    qemu_fdt_add_subnode(vms->fdt, node);
> +    qemu_fdt_setprop(vms->fdt, node, "compatible", compat, sizeof(compat));
> +    qemu_fdt_setprop_sized_cells(vms->fdt, node, "reg", 2, base, 2, size);
> +
> +    qemu_fdt_setprop_cells(vms->fdt, node, "interrupts",
> +            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
> +            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
> +            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
> +            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
> +
> +    qemu_fdt_setprop(vms->fdt, node, "interrupt-names", irq_names,
> +                     sizeof(irq_names));
> +
> +    qemu_fdt_setprop_cell(vms->fdt, node, "clocks", vms->clock_phandle);
> +    qemu_fdt_setprop_string(vms->fdt, node, "clock-names", "apb_pclk");
> +    qemu_fdt_setprop(vms->fdt, node, "dma-coherent", NULL, 0);

Is this definitely the right setting for dma-coherent? My (possibly
naive) thought is that for an emulated SMMU our page-table walks are
going to be coherent with the CPU's view.

> +
> +    qemu_fdt_setprop_cell(vms->fdt, node, "#iommu-cells", 1);
> +
> +    qemu_fdt_setprop_cell(vms->fdt, node, "phandle", vms->iommu_phandle);
> +    g_free(node);
> +}

> +enum {
> +    VIRT_IOMMU_NONE,
> +    VIRT_IOMMU_SMMUV3,
> +    VIRT_IOMMU_VIRTIO,
> +};
> +
>  typedef struct MemMapEntry {
>      hwaddr base;
>      hwaddr size;
> @@ -96,6 +104,7 @@ typedef struct {
>      bool its;
>      bool virt;
>      int32_t gic_version;
> +    int32_t iommu;

This is always one of the VIRT_IOMMU_* values, right?
I think we should give that enum a typedef name and then
use the type here.

>      struct arm_boot_info bootinfo;
>      const MemMapEntry *memmap;
>      const int *irqmap;
> @@ -105,6 +114,7 @@ typedef struct {
>      uint32_t clock_phandle;
>      uint32_t gic_phandle;
>      uint32_t msi_phandle;
> +    uint32_t iommu_phandle;
>      int psci_conduit;
>  } VirtMachineState;
>

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
