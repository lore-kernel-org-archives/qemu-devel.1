Received: from eggs.gnu.org ([2001:4830:134:3::10]:41559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1dFsMQ-0000No-O9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1dFsMP-0000la-Sz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:23:42 -0400
Message-ID: <592E1971.8000008@huawei.com>
Date: Wed, 31 May 2017 09:16:33 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <20170529173751.3443-1-drjones@redhat.com>
	<20170529173751.3443-3-drjones@redhat.com>
In-Reply-To: <20170529173751.3443-3-drjones@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/virt: fdt: generate
 distance-map when needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org



On 2017/5/30 1:37, Andrew Jones wrote:
> This is based on patch Shannon Zhao originally posted.
> 
> Cc: Shannon Zhao <zhaoshenglong@huawei.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Shannon Zhao <shannon.zhao@linaro.org>

> ---
>  hw/arm/virt.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index c7c8159dfd59..4db2d4207cf2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -219,6 +219,27 @@ static void create_fdt(VirtMachineState *vms)
>                                  "clk24mhz");
>      qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", vms->clock_phandle);
>  
> +    if (have_numa_distance) {
> +        int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
> +        uint32_t *matrix = g_malloc0(size);
> +        int idx, i, j;
> +
> +        for (i = 0; i < nb_numa_nodes; i++) {
> +            for (j = 0; j < nb_numa_nodes; j++) {
> +                idx = (i * nb_numa_nodes + j) * 3;
> +                matrix[idx + 0] = cpu_to_be32(i);
> +                matrix[idx + 1] = cpu_to_be32(j);
> +                matrix[idx + 2] = cpu_to_be32(numa_info[i].distance[j]);
> +            }
> +        }
> +
> +        qemu_fdt_add_subnode(fdt, "/distance-map");
> +        qemu_fdt_setprop_string(fdt, "/distance-map", "compatible",
> +                                "numa-distance-map-v1");
> +        qemu_fdt_setprop(fdt, "/distance-map", "distance-matrix",
> +                         matrix, size);
> +        g_free(matrix);
> +    }
>  }
>  
>  static void fdt_add_psci_node(const VirtMachineState *vms)
> 

-- 
Shannon
