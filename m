Received: from eggs.gnu.org ([2001:4830:134:3::10]:47971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1elZdC-0005m5-Rk
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1elZdA-0004ds-Cl
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:24:18 -0500
Date: Tue, 13 Feb 2018 13:24:06 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180213122406.mhjdi2eolngxxvcl@kamzik.brq.redhat.com>
References: <1518461904-5305-1-git-send-email-eric.auger@redhat.com>
	<1518461904-5305-19-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518461904-5305-19-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 18/22] hw/arm/virt-acpi-build: Add
 virtio-iommu node in IORT table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com, wei@redhat.com, kevin.tian@intel.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, peterx@redhat.com, linuc.decode@gmail.com, bharat.bhushan@nxp.com, christoffer.dall@linaro.org

On Mon, Feb 12, 2018 at 06:58:20PM +0000, Eric Auger wrote:
> This patch builds the virtio-iommu node in the ACPI IORT table.
> The dt node creation function fills the information used by
> the IORT table generation function (base address, base irq,
> type of the smmu).
> 
> The RID space of the root complex, which spans 0x0-0x10000
> maps to streamid space 0x0-0x10000 in smmuv3, which in turn
> maps to deviceid space 0x0-0x10000 in the ITS group.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v5 -> v6:
> - use type=128
> - new gsiv and reserved2 fields
> ---
>  hw/arm/virt-acpi-build.c    | 54 +++++++++++++++++++++++++++++++++++++++------
>  hw/arm/virt.c               |  5 +++++
>  include/hw/acpi/acpi-defs.h | 21 +++++++++++++++++-
>  include/hw/arm/virt.h       | 13 +++++++++++
>  4 files changed, 85 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f7fa795..24efb69 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -42,6 +42,7 @@
>  #include "hw/acpi/aml-build.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
> +#include "hw/virtio/virtio-iommu.h"
>  #include "hw/arm/virt.h"
>  #include "sysemu/numa.h"
>  #include "kvm_arm.h"
> @@ -393,18 +394,26 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
>  }
>  
>  static void
> -build_iort(GArray *table_data, BIOSLinker *linker)
> +build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
> -    int iort_start = table_data->len;
> +    int nb_nodes, iort_start = table_data->len;
>      AcpiIortIdMapping *idmap;
>      AcpiIortItsGroup *its;
>      AcpiIortTable *iort;
> -    size_t node_size, iort_length;
> +    AcpiIortPVIommu *iommu;
> +    size_t node_size, iort_length, iommu_offset = 0;
>      AcpiIortRC *rc;
>  
>      iort = acpi_data_push(table_data, sizeof(*iort));
>  
> +    if (vms->iommu_info.type) {
> +        nb_nodes = 3; /* RC, ITS, IOMMU */
> +    } else {
> +        nb_nodes = 2; /* RC, ITS */
> +    }
> +
>      iort_length = sizeof(*iort);
> +    iort->node_count = cpu_to_le32(nb_nodes);
>      iort->node_count = cpu_to_le32(2); /* RC and ITS nodes */

The above line should be removed, as you're replacing it with the previous
one. I wonder how the guest was able to parse this table without seeing
the appropriate node count?

>      iort->node_offset = cpu_to_le32(sizeof(*iort));
>  
> @@ -418,6 +427,31 @@ build_iort(GArray *table_data, BIOSLinker *linker)
>      its->its_count = cpu_to_le32(1);
>      its->identifiers[0] = 0; /* MADT translation_id */
>  
> +    if (vms->iommu_info.type == VIRT_IOMMU_VIRTIO) {
> +

extra blank line

> +        /* Para-virtualized IOMMU node */
> +        iommu_offset = cpu_to_le32(iort->node_offset + node_size);
> +        node_size = sizeof(*iommu) + sizeof(*idmap);
> +        iort_length += node_size;
> +        iommu = acpi_data_push(table_data, node_size);
> +
> +        iommu->type = ACPI_IORT_NODE_PARAVIRT;
> +        iommu->length = cpu_to_le16(node_size);
> +        iommu->base_address = cpu_to_le64(vms->iommu_info.reg.base);
> +        iommu->span = cpu_to_le64(vms->iommu_info.reg.size);
> +        iommu->model = ACPI_IORT_NODE_PV_VIRTIO_IOMMU;
> +        iommu->flags = ACPI_IORT_NODE_PV_CACHE_COHERENT;

model and flags are both larger than a byte, so they need cpu_to_le*'s

> +        iommu->gsiv = cpu_to_le64(vms->iommu_info.irq_base);
> +
> +        /* Identity RID mapping covering the whole input RID range */
> +        idmap = &iommu->id_mapping_array[0];
> +        idmap->input_base = 0;
> +        idmap->id_count = cpu_to_le32(0xFFFF);
> +        idmap->output_base = 0;
> +        /* output IORT node is the ITS group node (the first node) */
> +        idmap->output_reference = cpu_to_le32(iort->node_offset);
> +    }
> +
>      /* Root Complex Node */
>      node_size = sizeof(*rc) + sizeof(*idmap);
>      iort_length += node_size;
> @@ -438,10 +472,16 @@ build_iort(GArray *table_data, BIOSLinker *linker)
>      idmap->input_base = 0;
>      idmap->id_count = cpu_to_le32(0xFFFF);
>      idmap->output_base = 0;
> -    /* output IORT node is the ITS group node (the first node) */
> -    idmap->output_reference = cpu_to_le32(iort->node_offset);
>  
> -    iort->length = cpu_to_le32(iort_length);
> +    if (vms->iommu_info.type) {
> +        /* output IORT node is the smmuv3 node */
> +        idmap->output_reference = cpu_to_le32(iommu_offset);
> +    } else {
> +        /* output IORT node is the ITS group node (the first node) */
> +        idmap->output_reference = cpu_to_le32(iort->node_offset);
> +    }
> +
> +   iort->length = cpu_to_le32(iort_length);

This line appears to have moved down for no reason, but what happened
was the indentation of it got messed up (missing a space)

>  
>      build_header(linker, table_data, (void *)(table_data->data + iort_start),
>                   "IORT", table_data->len - iort_start, 0, NULL, NULL);
> @@ -786,7 +826,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  
>      if (its_class_name() && !vmc->no_its) {
>          acpi_add_table(table_offsets, tables_blob);
> -        build_iort(tables_blob, tables->linker);
> +        build_iort(tables_blob, tables->linker, vms);
>      }
>  
>      /* XSDT is pointed to by RSDP */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index cf81716..80740ac 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -969,6 +969,11 @@ static void virtio_iommu_notifier(Notifier *notifier, void *data)
>  
>      object_property_set_bool(obj, false, "msi_bypass", &error_fatal);
>  
> +    vms->iommu_info.type = VIRT_IOMMU_VIRTIO;
> +    vms->iommu_info.reg.base = vms->memmap[VIRT_IOMMU].base;
> +    vms->iommu_info.reg.size = vms->memmap[VIRT_IOMMU].size;
> +    vms->iommu_info.irq_base = vms->irqmap[VIRT_IOMMU];
> +
>      qemu_fdt_setprop_cells(fdt, vms->pcie_host_nodename, "iommu-map",
>                             0x0, vms->iommu_phandle, 0x0, 0x10000);
>  }
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 80c8099..57b9cf9 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -673,7 +673,8 @@ enum {
>          ACPI_IORT_NODE_NAMED_COMPONENT = 0x01,
>          ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
>          ACPI_IORT_NODE_SMMU = 0x03,
> -        ACPI_IORT_NODE_SMMU_V3 = 0x04
> +        ACPI_IORT_NODE_SMMU_V3 = 0x04,
> +        ACPI_IORT_NODE_PARAVIRT = 0x80

I recommend putting a comma on the last line too, to avoid having to touch
the line in the future if new enums are added later (as must be done in
this patch). It's nicer for git-blame

>  };
>  
>  struct AcpiIortIdMapping {
> @@ -700,6 +701,24 @@ struct AcpiIortItsGroup {
>  } QEMU_PACKED;
>  typedef struct AcpiIortItsGroup AcpiIortItsGroup;
>  
> +struct AcpiIortPVIommu {
> +    ACPI_IORT_NODE_HEADER_DEF
> +    uint64_t base_address;
> +    uint64_t span;
> +    uint32_t model;
> +    uint32_t flags;
> +    uint64_t gsiv;
> +    uint64_t reserved2;
> +    AcpiIortIdMapping id_mapping_array[0];
> +} QEMU_PACKED;
> +typedef struct AcpiIortPVIommu AcpiIortPVIommu;
> +
> +enum {
> +    ACPI_IORT_NODE_PV_VIRTIO_IOMMU = 0x00,
> +};
> +
> +#define ACPI_IORT_NODE_PV_CACHE_COHERENT    (1 << 0)
> +
>  struct AcpiIortRC {
>      ACPI_IORT_NODE_HEADER_DEF
>      AcpiIortMemoryAccess memory_properties;
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index a13b895..2e1e907 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -89,6 +89,18 @@ typedef struct {
>      bool claim_edge_triggered_timers;
>  } VirtMachineClass;
>  
> +typedef enum VirtIOMMUType {
> +    VIRT_IOMMU_NONE,
> +    VIRT_IOMMU_SMMUV3,
> +    VIRT_IOMMU_VIRTIO,
> +} VirtIOMMUType;
> +
> +typedef struct VirtIOMMUInfo {
> +    VirtIOMMUType type;
> +    MemMapEntry reg;
> +    int irq_base;
> +} VirtIOMMUInfo;
> +
>  typedef struct {
>      MachineState parent;
>      Notifier machine_done;
> @@ -98,6 +110,7 @@ typedef struct {
>      bool highmem;
>      bool its;
>      bool virt;
> +    VirtIOMMUInfo iommu_info;
>      int32_t gic_version;
>      struct arm_boot_info bootinfo;
>      const MemMapEntry *memmap;
> -- 
> 1.9.1
> 
>

I just caught the above comments while skimming. I'm afraid I didn't have
time to review this to the spec yet.

Thanks,
drew
