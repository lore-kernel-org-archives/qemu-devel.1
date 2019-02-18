Received: from eggs.gnu.org ([209.51.188.92]:43966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gvgCI-0001oF-7N
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gvgC8-0007bm-OB
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:30:44 -0500
Date: Mon, 18 Feb 2019 11:30:08 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190218113008.18ead6cb@Igors-MacBook-Pro.local>
In-Reply-To: <20190205173306.20483-17-eric.auger@redhat.com>
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-17-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 16/18] hw/arm/virt: Add nvdimm hot-plug
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

On Tue,  5 Feb 2019 18:33:04 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> From: Kwangwoo Lee <kwangwoo.lee@sk.com>
> 
> Pre-plug and plug handlers are prepared for NVDIMM support.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> ---
>  default-configs/arm-softmmu.mak |  2 ++
>  hw/arm/virt-acpi-build.c        |  6 ++++++
>  hw/arm/virt.c                   | 22 ++++++++++++++++++++++
>  include/hw/arm/virt.h           |  3 +++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index dc4624794f..ddbe87ed15 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -162,3 +162,5 @@ CONFIG_HIGHBANK=y
>  CONFIG_MUSICPAL=y
>  CONFIG_MEM_DEVICE=y
>  CONFIG_DIMM=y
> +CONFIG_NVDIMM=y
> +CONFIG_ACPI_NVDIMM=y
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 781eafaf5e..f086adfa82 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -784,6 +784,7 @@ static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> +    MachineState *ms = MACHINE(vms);
>      GArray *table_offsets;
>      unsigned dsdt, xsdt;
>      GArray *tables_blob = tables->table_data;
> @@ -824,6 +825,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>          }
>      }
>  
> +    if (vms->acpi_nvdimm_state.is_enabled) {
> +        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
> +                          &vms->acpi_nvdimm_state, ms->ram_slots);
> +    }
> +
>      if (its_class_name() && !vmc->no_its) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_iort(tables_blob, tables->linker, vms);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b683902991..0c8c2cc191 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -132,6 +132,7 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>      [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
>      [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
> +    [VIRT_ACPI_IO] =            { 0x09070000, 0x00010000 },
where does this range come from and is its size sufficient?

>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -1637,6 +1638,18 @@ static void machvirt_init(MachineState *machine)
>  
>      create_platform_bus(vms, pic);
>  
> +    if (vms->acpi_nvdimm_state.is_enabled) {
> +        AcpiNVDIMMState *acpi_nvdimm_state = &vms->acpi_nvdimm_state;
> +
> +        acpi_nvdimm_state->dsm_io.type = NVDIMM_ACPI_IO_MEMORY;
> +        acpi_nvdimm_state->dsm_io.base =
> +                vms->memmap[VIRT_ACPI_IO].base + NVDIMM_ACPI_IO_BASE;
> +        acpi_nvdimm_state->dsm_io.len = NVDIMM_ACPI_IO_LEN;
> +
> +        nvdimm_init_acpi_state(acpi_nvdimm_state, sysmem,
> +                               vms->fw_cfg, OBJECT(vms));
> +    }
> +
>      vms->bootinfo.ram_size = machine->ram_size;
>      vms->bootinfo.kernel_filename = machine->kernel_filename;
>      vms->bootinfo.kernel_cmdline = machine->kernel_cmdline;
> @@ -1822,10 +1835,19 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                               DeviceState *dev, Error **errp)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>      Error *local_err = NULL;
>  
>      pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
>  
> +    if (is_nvdimm) {
> +        nvdimm_plug(&vms->acpi_nvdimm_state);
> +    }
> +
> +out:
>      error_propagate(errp, local_err);
>  }
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index c88f67a492..56d73b0e86 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -37,6 +37,7 @@
>  #include "hw/arm/arm.h"
>  #include "sysemu/kvm.h"
>  #include "hw/intc/arm_gicv3_common.h"
> +#include "hw/mem/nvdimm.h"
>  
>  #define NUM_GICV2M_SPIS       64
>  #define NUM_VIRTIO_TRANSPORTS 32
> @@ -77,6 +78,7 @@ enum {
>      VIRT_GPIO,
>      VIRT_SECURE_UART,
>      VIRT_SECURE_MEM,
> +    VIRT_ACPI_IO,
>      VIRT_LOWMEMMAP_LAST,
>  };
>  
> @@ -134,6 +136,7 @@ typedef struct {
>      hwaddr high_io_base;
>      hwaddr highest_gpa;
>      bool extended_memmap;
> +    AcpiNVDIMMState acpi_nvdimm_state;
>  } VirtMachineState;
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
