Received: from eggs.gnu.org ([2001:4830:134:3::10]:38738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cHSit-0006JP-MG
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cHSis-0000vP-NJ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:53:11 -0500
Date: Thu, 15 Dec 2016 10:53:00 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161215105300.08136939@nial.brq.redhat.com>
In-Reply-To: <20161213214522.25548-2-drjones@redhat.com>
References: <20161213214522.25548-1-drjones@redhat.com>
	<20161213214522.25548-2-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/11] hw/arm/virt: parameter passing
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, zhaoshenglong@huawei.com, mst@redhat.com, ehabkost@redhat.com

On Tue, 13 Dec 2016 22:45:12 +0100
Andrew Jones <drjones@redhat.com> wrote:

> Some simple cleanups made possible by "hw/arm/virt: Merge
> VirtBoardInfo and VirtMachineState"
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/virt.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7eec50a82494..d451bc4f6b9b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -570,10 +570,10 @@ static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
>      fdt_add_v2m_gic_node(vms);
>  }
>  
> -static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type,
> -                       bool secure, bool no_its)
> +static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type)
>  {
>      /* We create a standalone GIC */
> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>      DeviceState *gicdev;
>      SysBusDevice *gicbusdev;
>      const char *gictype;
> @@ -589,7 +589,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type,
>       */
>      qdev_prop_set_uint32(gicdev, "num-irq", NUM_IRQS + 32);
>      if (!kvm_irqchip_in_kernel()) {
> -        qdev_prop_set_bit(gicdev, "has-security-extensions", secure);
> +        qdev_prop_set_bit(gicdev, "has-security-extensions", vms->secure);
>      }
>      qdev_init_nofail(gicdev);
>      gicbusdev = SYS_BUS_DEVICE(gicdev);
> @@ -643,7 +643,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type,
>  
>      fdt_add_gic_node(vms, type);
>  
> -    if (type == 3 && !no_its) {
> +    if (type == 3 && !vmc->no_its) {
>          create_its(vms, gicdev);
>      } else if (type == 2) {
>          create_v2m(vms, pic);
> @@ -1005,8 +1005,7 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
>                             0x7           /* PCI irq */);
>  }
>  
> -static void create_pcie(const VirtMachineState *vms, qemu_irq *pic,
> -                        bool use_highmem)
> +static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
>  {
>      hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
>      hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
> @@ -1049,7 +1048,7 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic,
>                               mmio_reg, base_mmio, size_mmio);
>      memory_region_add_subregion(get_system_memory(), base_mmio, mmio_alias);
>  
> -    if (use_highmem) {
> +    if (vms->highmem) {
>          /* Map high MMIO space */
>          MemoryRegion *high_mmio_alias = g_new0(MemoryRegion, 1);
>  
> @@ -1098,7 +1097,7 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic,
>      qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
>                                   2, base_ecam, 2, size_ecam);
>  
> -    if (use_highmem) {
> +    if (vms->highmem) {
>          qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "ranges",
>                                       1, FDT_PCI_RANGE_IOPORT, 2, 0,
>                                       2, base_pio, 2, size_pio,
> @@ -1428,7 +1427,7 @@ static void machvirt_init(MachineState *machine)
>  
>      create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
>  
> -    create_gic(vms, pic, gic_version, vms->secure, vmc->no_its);
> +    create_gic(vms, pic, gic_version);
>  
>      fdt_add_pmu_nodes(vms, gic_version);
>  
> @@ -1441,7 +1440,7 @@ static void machvirt_init(MachineState *machine)
>  
>      create_rtc(vms, pic);
>  
> -    create_pcie(vms, pic, vms->highmem);
> +    create_pcie(vms, pic);
>  
>      create_gpio(vms, pic);
>  
