Received: from eggs.gnu.org ([209.51.188.92]:46711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gve5m-0004X3-Qe
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 03:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gve5l-0005BD-Te
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 03:15:58 -0500
Date: Mon, 18 Feb 2019 09:14:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190218091439.198d3aad@Igors-MacBook-Pro.local>
In-Reply-To: <20190205173306.20483-14-eric.auger@redhat.com>
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-14-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 13/18] hw/arm/virt-acpi-build: Add
 PC-DIMM in SRAT
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

On Tue,  5 Feb 2019 18:33:01 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> Generate Memory Affinity Structures for PC-DIMM ranges.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v5 -> v6:
> - fix mingw compil issue
> 
> v4 -> v5:
> - Align to x86 code and especially
>   "pc: acpi: revert back to 1 SRAT entry for hotpluggable area"
> 
> v3 -> v4:
> - do not use vms->bootinfo.device_memory_start/device_memory_size anymore
> 
> v1 -> v2:
> - build_srat_hotpluggable_memory movedc to aml-build
> ---
>  hw/arm/virt-acpi-build.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 829d2f0035..781eafaf5e 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -516,6 +516,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      int i, srat_start;
>      uint64_t mem_base;
>      MachineClass *mc = MACHINE_GET_CLASS(vms);
> +    MachineState *ms = MACHINE(vms);
>      const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(MACHINE(vms));
>  
>      srat_start = table_data->len;
> @@ -541,6 +542,14 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          }
>      }
>  
> +    if (ms->device_memory) {
> +        numamem = acpi_data_push(table_data, sizeof *numamem);
> +        build_srat_memory(numamem, ms->device_memory->base,
> +                          memory_region_size(&ms->device_memory->mr),
> +                          nb_numa_nodes - 1,
> +                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> +    }
> +
>      build_header(linker, table_data, (void *)(table_data->data + srat_start),
>                   "SRAT", table_data->len - srat_start, 3, NULL, NULL);
>  }
