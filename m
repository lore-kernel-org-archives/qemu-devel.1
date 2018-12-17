Received: from eggs.gnu.org ([2001:4830:134:3::10]:43740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gYvLu-0006li-6i
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gYvLo-0002OA-EW
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:02:42 -0500
Date: Mon, 17 Dec 2018 17:02:08 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181217160208.uhz5pjr2yxxosljw@kamzik.brq.redhat.com>
References: <20181206170733.7469-1-eric.auger@redhat.com>
	<20181206170733.7469-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206170733.7469-2-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH-for-4.0 v2 1/2] hw/arm/virt-acpi-build: Set
 COHACC override flag in IORT SMMUv3 node
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

On Thu, Dec 06, 2018 at 06:07:32PM +0100, Eric Auger wrote:
> Let's report IO-coherent access is supported for translation
> table walks, descriptor fetches and queues by setting the COHACC
> override flag. Without that, we observe wrong command opcodes.
> The DT description also advertises the dma coherency.
> 
> Fixes a703b4f6c1ee ("hw/arm/virt-acpi-build: Add smmuv3 node in IORT table")
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> ---
> 
> - change the commit title
> - addition of new fields (pxm and id_mapping_index) done in a
>   separate patch
> ---
>  hw/arm/virt-acpi-build.c    | 1 +
>  include/hw/acpi/acpi-defs.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 5785fb697c..aa177ba64d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -448,6 +448,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          smmu->mapping_count = cpu_to_le32(1);
>          smmu->mapping_offset = cpu_to_le32(sizeof(*smmu));
>          smmu->base_address = cpu_to_le64(vms->memmap[VIRT_SMMU].base);
> +        smmu->flags = ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;

Flags are 4 bytes in length, so you need cpu_to_le32()

>          smmu->event_gsiv = cpu_to_le32(irq);
>          smmu->pri_gsiv = cpu_to_le32(irq + 1);
>          smmu->gerr_gsiv = cpu_to_le32(irq + 2);
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index af8e023968..532eaf79bd 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -628,6 +628,8 @@ struct AcpiIortItsGroup {
>  } QEMU_PACKED;
>  typedef struct AcpiIortItsGroup AcpiIortItsGroup;
>  
> +#define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE 1
> +
>  struct AcpiIortSmmu3 {
>      ACPI_IORT_NODE_HEADER_DEF
>      uint64_t base_address;
> -- 
> 2.17.2
> 
> 

Probably not necessary for this series, but we should really switch all
table generators to the aml_append* API.

Besides the missing cpu_to_le32(),

Reviewed-by: Andrew Jones <drjones@redhat.com>
