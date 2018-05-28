Received: from eggs.gnu.org ([2001:4830:134:3::10]:48665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNKzy-0006UK-55
	for qemu-devel@nongnu.org; Mon, 28 May 2018 12:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNKzu-0000xf-Uv
	for qemu-devel@nongnu.org; Mon, 28 May 2018 12:27:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527496946-12036-1-git-send-email-zhaoshenglong@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8b06a7d9-49d4-9d22-d357-5448fbaf7a56@amsat.org>
Date: Mon, 28 May 2018 13:27:44 -0300
MIME-Version: 1.0
In-Reply-To: <1527496946-12036-1-git-send-email-zhaoshenglong@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] ARM: ACPI: Fix use-after-free
 due to memory realloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org, eric.auger@redhat.com

On 05/28/2018 05:42 AM, Shannon Zhao wrote:
> acpi_data_push uses g_array_set_size to resize the memory size. If there
> is no enough contiguous memory, the address will be changed. So previous
> pointer could not be used any more. It must update the pointer and use
> the new one.
> 
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 92ceee9..30584ee 100644
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
> @@ -414,6 +414,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      iort_length = sizeof(*iort);
>      iort->node_count = cpu_to_le32(nb_nodes);
>      iort->node_offset = cpu_to_le32(sizeof(*iort));

Eventually similar comment to explain why you also use another var:

       /*
        * Use a copy in case table_data->data moves during
        * acpi_data_push operations.
        */
> +    iort_node_offset = iort->node_offset;

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>      /* ITS group node */
>      node_size =  sizeof(*its) + sizeof(uint32_t);
> @@ -429,7 +430,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          int irq =  vms->irqmap[VIRT_SMMU];
>  
>          /* SMMUv3 node */
> -        smmu_offset = iort->node_offset + node_size;
> +        smmu_offset = iort_node_offset + node_size;
>          node_size = sizeof(*smmu) + sizeof(*idmap);
>          iort_length += node_size;
>          smmu = acpi_data_push(table_data, node_size);
> @@ -450,7 +451,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          idmap->id_count = cpu_to_le32(0xFFFF);
>          idmap->output_base = 0;
>          /* output IORT node is the ITS group node (the first node) */
> -        idmap->output_reference = cpu_to_le32(iort->node_offset);
> +        idmap->output_reference = cpu_to_le32(iort_node_offset);
>      }
>  
>      /* Root Complex Node */
> @@ -479,9 +480,14 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          idmap->output_reference = cpu_to_le32(smmu_offset);
>      } else {
>          /* output IORT node is the ITS group node (the first node) */
> -        idmap->output_reference = cpu_to_le32(iort->node_offset);
> +        idmap->output_reference = cpu_to_le32(iort_node_offset);
>      }
>  
> +    /*
> +     * Update the pointer address in case table_data->data moved during above
> +     * acpi_data_push operations.
> +     */
> +    iort = (AcpiIortTable *)(table_data->data + iort_start);
>      iort->length = cpu_to_le32(iort_length);
>  
>      build_header(linker, table_data, (void *)(table_data->data + iort_start),
> 
