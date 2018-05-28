Received: from eggs.gnu.org ([2001:4830:134:3::10]:45253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNJ20-0007yk-Nh
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNJ1z-0006Q1-SG
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:21:52 -0400
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
	<20180516152026.2920-6-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <12945c4d-97f6-df0c-1046-b5d981624c18@redhat.com>
Date: Mon, 28 May 2018 16:21:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180516152026.2920-6-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 5/6] hw/arm: ACPI SRAT changes to
 accommodate non-contiguous mem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: drjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, zhaoshenglong@huawei.com, jonathan.cameron@huawei.com, linuxarm@huawei.com

Hi Shameer,

On 05/16/2018 05:20 PM, Shameer Kolothum wrote:
> This is in preparation for the next patch where initial ram is split
> into a non-pluggable chunk and a pc-dimm modeled mem if  the vaild
valid
> iova regions are non-contiguous.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index c7c6a57..8d17b40 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -488,7 +488,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      AcpiSratProcessorGiccAffinity *core;
>      AcpiSratMemoryAffinity *numamem;
>      int i, srat_start;
> -    uint64_t mem_base;
> +    uint64_t mem_base, mem_sz, mem_len;
>      MachineClass *mc = MACHINE_GET_CLASS(vms);
>      const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(MACHINE(vms));
>  
> @@ -505,12 +505,28 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          core->flags = cpu_to_le32(1);
>      }
>  
> -    mem_base = vms->memmap[VIRT_MEM].base;
> +    mem_base = vms->bootinfo.loader_start;
> +    mem_sz = vms->bootinfo.loader_start;
>      for (i = 0; i < nb_numa_nodes; ++i) {
>          numamem = acpi_data_push(table_data, sizeof(*numamem));
> -        build_srat_memory(numamem, mem_base, numa_info[i].node_mem, i,
> +        mem_len = MIN(numa_info[i].node_mem, mem_sz);
same question as in previous patch

Thanks

Eric
> +        build_srat_memory(numamem, mem_base, mem_len, i,
>                            MEM_AFFINITY_ENABLED);
> -        mem_base += numa_info[i].node_mem;
> +        mem_base += mem_len;
> +        mem_sz -= mem_len;
> +        if (!mem_sz) {
> +            break;
> +        }
> +    }
> +
> +    /* Create table for initial pc-dimm ram, if any */
> +    if (vms->bootinfo.dimm_mem) {
> +        numamem = acpi_data_push(table_data, sizeof(*numamem));
> +        build_srat_memory(numamem, vms->bootinfo.dimm_mem->base,
> +                          vms->bootinfo.dimm_mem->size,
> +                          vms->bootinfo.dimm_mem->node,
> +                          MEM_AFFINITY_ENABLED);
> +
>      }
>  
>      build_header(linker, table_data, (void *)(table_data->data + srat_start),
> 
