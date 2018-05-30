Received: from eggs.gnu.org ([2001:4830:134:3::10]:59830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNx1L-00068z-Qn
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNx1H-0001n3-SS
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:03:51 -0400
References: <1527663951-14552-1-git-send-email-zhaoshenglong@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e6827289-812c-eb87-ad52-43094917bb7f@redhat.com>
Date: Wed, 30 May 2018 11:03:31 +0200
MIME-Version: 1.0
In-Reply-To: <1527663951-14552-1-git-send-email-zhaoshenglong@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] ARM: ACPI: Fix use-after-free due to
 memory realloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, f4bug@amsat.org, shannon.zhaosl@gmail.com

Hi Shannon,

On 05/30/2018 09:05 AM, Shannon Zhao wrote:
> acpi_data_push uses g_array_set_size to resize the memory size. If there
> is no enough contiguous memory, the address will be changed. So previous
> pointer could not be used any more. It must update the pointer and use
> the new one.
> 
> Also, previous codes wrongly use le32 conversion of iort->node_offset
> for subsequent computations that will result incorrect value if host is
> not litlle endian. So use the non-converted one instead.
> 
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
> V3: Fix typo and add some words in commit message to explain another bug
> ---
>  hw/arm/virt-acpi-build.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 92ceee9..74f5744 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -400,7 +400,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      AcpiIortItsGroup *its;
>      AcpiIortTable *iort;
>      AcpiIortSmmu3 *smmu;
> -    size_t node_size, iort_length, smmu_offset = 0;
> +    size_t node_size, iort_node_offset, iort_length, smmu_offset = 0;
>      AcpiIortRC *rc;
>  
>      iort = acpi_data_push(table_data, sizeof(*iort));
> @@ -413,7 +413,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>      iort_length = sizeof(*iort);
>      iort->node_count = cpu_to_le32(nb_nodes);
> -    iort->node_offset = cpu_to_le32(sizeof(*iort));
> +    /*
> +     * Use a copy in case table_data->data moves during acpi_data_push
> +     * operations.
> +     */
> +    iort_node_offset = sizeof(*iort);
> +    iort->node_offset = cpu_to_le32(iort_node_offset);
>  
>      /* ITS group node */
>      node_size =  sizeof(*its) + sizeof(uint32_t);
> @@ -429,7 +434,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          int irq =  vms->irqmap[VIRT_SMMU];
>  
>          /* SMMUv3 node */
> -        smmu_offset = iort->node_offset + node_size;
> +        smmu_offset = iort_node_offset + node_size;
>          node_size = sizeof(*smmu) + sizeof(*idmap);
>          iort_length += node_size;
>          smmu = acpi_data_push(table_data, node_size);
> @@ -450,7 +455,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          idmap->id_count = cpu_to_le32(0xFFFF);
>          idmap->output_base = 0;
>          /* output IORT node is the ITS group node (the first node) */
> -        idmap->output_reference = cpu_to_le32(iort->node_offset);
> +        idmap->output_reference = cpu_to_le32(iort_node_offset);
>      }
>  
>      /* Root Complex Node */
> @@ -479,9 +484,14 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          idmap->output_reference = cpu_to_le32(smmu_offset);
>      } else {
>          /* output IORT node is the ITS group node (the first node) */
> -        idmap->output_reference = cpu_to_le32(iort->node_offset);
> +        idmap->output_reference = cpu_to_le32(iort_node_offset);
>      }
>  
> +    /*
> +     * Update the pointer address in case table_data->data moves during above
> +     * acpi_data_push operations.
> +     */
> +    iort = (AcpiIortTable *)(table_data->data + iort_start);
>      iort->length = cpu_to_le32(iort_length);
>  
>      build_header(linker, table_data, (void *)(table_data->data + iort_start),
> 
