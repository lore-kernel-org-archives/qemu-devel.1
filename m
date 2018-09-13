Received: from eggs.gnu.org ([2001:4830:134:3::10]:41403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1g0LIl-00012p-90
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1g0LIk-00051v-Gg
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:40:31 -0400
Date: Thu, 13 Sep 2018 08:40:20 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180913064020.xcxjof5466emyplp@kamzik.brq.redhat.com>
References: <20180911112643.19296-1-shenglong.zsl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911112643.19296-1-shenglong.zsl@alibaba-inc.com>
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt-acpi-build: Add a check for
 memory-less NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <shannon.zhaosl@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Tue, Sep 11, 2018 at 07:26:43PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhaosl@gmail.com>
> 
> Like commit 16b4226(hw/acpi-build: Add a check for memory-less NUMA node
> ), it also needs to check memory length for NUMA nodes on ARM.
> 
> Signed-off-by: Shannon Zhao <shannon.zhaosl@gmail.com>
> ---
>  hw/arm/virt-acpi-build.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index ce31abd..5785fb6 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -562,10 +562,12 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>      mem_base = vms->memmap[VIRT_MEM].base;
>      for (i = 0; i < nb_numa_nodes; ++i) {
> -        numamem = acpi_data_push(table_data, sizeof(*numamem));
> -        build_srat_memory(numamem, mem_base, numa_info[i].node_mem, i,
> -                          MEM_AFFINITY_ENABLED);
> -        mem_base += numa_info[i].node_mem;
> +        if (numa_info[i].node_mem > 0) {
> +            numamem = acpi_data_push(table_data, sizeof(*numamem));
> +            build_srat_memory(numamem, mem_base, numa_info[i].node_mem, i,
> +                              MEM_AFFINITY_ENABLED);
> +            mem_base += numa_info[i].node_mem;
> +        }
>      }
>  
>      build_header(linker, table_data, (void *)(table_data->data + srat_start),
> -- 
> 2.9.3.windows.1
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
