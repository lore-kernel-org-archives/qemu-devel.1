Received: from eggs.gnu.org ([2001:4830:134:3::10]:33059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gEaRv-0000Ih-7U
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gEaRq-0002s5-C9
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:40:51 -0400
Date: Mon, 22 Oct 2018 14:40:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181022144026.3171d287@igors-macbook-pro.local>
In-Reply-To: <20181018143042.29588-13-eric.auger@redhat.com>
References: <20181018143042.29588-1-eric.auger@redhat.com>
	<20181018143042.29588-13-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 12/16] hw/arm/virt-acpi-build: Add PC-DIMM
 in SRAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, david@redhat.com, drjones@redhat.com, dgilbert@redhat.com, Suzuki.Poulose@arm.com

On Thu, 18 Oct 2018 16:30:38 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> Generate Memory Affinity Structures for PC-DIMM ranges.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v3 -> v4:
> - do not use vms->bootinfo.device_memory_start/device_memory_size anymore
> 
> v1 -> v2:
> - build_srat_hotpluggable_memory movedc to aml-build
> ---
>  hw/arm/virt-acpi-build.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 5785fb697c..8818bbf5ec 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -545,6 +545,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      int i, srat_start;
>      uint64_t mem_base;
>      MachineClass *mc = MACHINE_GET_CLASS(vms);
> +    MachineState *ms = MACHINE(vms);
>      const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(MACHINE(vms));
>  
>      srat_start = table_data->len;
> @@ -570,6 +571,9 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          }
>      }
>  
> +    build_srat_hotpluggable_memory(table_data, ms->device_memory->base,
> +                                   ms->device_memory->mr.size, 0);
on x86, we use the last node here to make windows happy. I'd use the same value here.

> +
>      build_header(linker, table_data, (void *)(table_data->data + srat_start),
>                   "SRAT", table_data->len - srat_start, 3, NULL, NULL);
>  }
