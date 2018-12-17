Received: from eggs.gnu.org ([2001:4830:134:3::10]:52907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gYvjm-0005BH-L9
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gYvjk-0004cn-ET
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:27:22 -0500
Date: Mon, 17 Dec 2018 17:27:01 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181217162701.nzdqhccpnhypj2z7@kamzik.brq.redhat.com>
References: <20181206170733.7469-1-eric.auger@redhat.com>
	<20181206170733.7469-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206170733.7469-3-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH-for-4.0 v2 2/2] hw/arm/virt-acpi-build:
 IORT Update for revision D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, shameerali.kolothum.thodi@huawei.com

On Thu, Dec 06, 2018 at 06:07:33PM +0100, Eric Auger wrote:
> Let's update the structs according to revision D of the IORT
> specification and set the IORT node revision fields.
> 
> In IORT smmuv3 node: the new proximity field is not used as
> the proximity domain valid flag is not set. The new DeviceId
> mapping index is not used either as all the SMMU control
> interrupts are GSIV based.
> 
> In IORT RC node: the new memory address size limit field is
> set to 64 bits.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - separate patches for SMMUv3 DMA coherency issue and struct
>   update to revision D.
> - revision fields set
> ---
>  hw/arm/virt-acpi-build.c    |  4 ++++
>  include/hw/acpi/acpi-defs.h | 10 +++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index aa177ba64d..a34a0958a5 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -423,6 +423,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       */
>      iort_node_offset = sizeof(*iort);
>      iort->node_offset = cpu_to_le32(iort_node_offset);
> +    iort->revision = 0;
>  
>      /* ITS group node */
>      node_size =  sizeof(*its) + sizeof(uint32_t);
> @@ -445,6 +446,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>          smmu->type = ACPI_IORT_NODE_SMMU_V3;
>          smmu->length = cpu_to_le16(node_size);
> +        smmu->revision = cpu_to_le32(2);
>          smmu->mapping_count = cpu_to_le32(1);
>          smmu->mapping_offset = cpu_to_le32(sizeof(*smmu));
>          smmu->base_address = cpu_to_le64(vms->memmap[VIRT_SMMU].base);
> @@ -470,6 +472,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>      rc->type = ACPI_IORT_NODE_PCI_ROOT_COMPLEX;
>      rc->length = cpu_to_le16(node_size);
> +    rc->revision = cpu_to_le32(1);
>      rc->mapping_count = cpu_to_le32(1);
>      rc->mapping_offset = cpu_to_le32(sizeof(*rc));
>  
> @@ -477,6 +480,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      rc->memory_properties.cache_coherency = cpu_to_le32(1);
>      rc->memory_properties.memory_flags = 0x3; /* CCA = CPM = DCAS = 1 */
>      rc->pci_segment_number = 0; /* MCFG pci_segment */
> +    rc->memory_address_limit = 64;

Hmmm... IIUC this provides the size of the IOVA space. When it's 64 the
size of the space is U64_MAX, which gets added to the DMA base (also 64
bits) when calculating things like the last PFN. It seems strange to use
a value that will surely overflow those calculations. Is it common to
put 64 here? Can you elaborate on this?

>  
>      /* Identity RID mapping covering the whole input RID range */
>      idmap = &rc->id_mapping_array[0];
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 532eaf79bd..b4a5104367 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -628,7 +628,11 @@ struct AcpiIortItsGroup {
>  } QEMU_PACKED;
>  typedef struct AcpiIortItsGroup AcpiIortItsGroup;
>  
> -#define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE 1
> +enum {
> +    ACPI_IORT_SMMU_V3_COHACC_OVERRIDE = 1 << 0,
> +    ACPI_IORT_SMMU_V3_HTTU_OVERRIDE   = 3 << 1,
> +    ACPI_IORT_SMMU_V3_PXM_VALID       = 1 << 3
> +};

We don't usually add flag definitions until we need them. Indeed it'll
just be more code to delete when switching to the aml_append* API.

>  
>  struct AcpiIortSmmu3 {
>      ACPI_IORT_NODE_HEADER_DEF
> @@ -641,6 +645,8 @@ struct AcpiIortSmmu3 {
>      uint32_t pri_gsiv;
>      uint32_t gerr_gsiv;
>      uint32_t sync_gsiv;
> +    uint32_t pxm;
> +    uint32_t id_mapping_index;
>      AcpiIortIdMapping id_mapping_array[0];
>  } QEMU_PACKED;
>  typedef struct AcpiIortSmmu3 AcpiIortSmmu3;
> @@ -650,6 +656,8 @@ struct AcpiIortRC {
>      AcpiIortMemoryAccess memory_properties;
>      uint32_t ats_attribute;
>      uint32_t pci_segment_number;
> +    uint8_t memory_address_limit;
> +    uint8_t reserved2[3];
>      AcpiIortIdMapping id_mapping_array[0];
>  } QEMU_PACKED;
>  typedef struct AcpiIortRC AcpiIortRC;
> -- 
> 2.17.2
> 
>

Thanks,
drew
