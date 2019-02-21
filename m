Received: from eggs.gnu.org ([209.51.188.92]:54223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gwpoy-0005Us-Gv
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gwpom-0001IP-HP
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:59:27 -0500
Date: Thu, 21 Feb 2019 15:58:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190221155849.7a79d979@redhat.com>
In-Reply-To: <20190220224003.4420-2-eric.auger@redhat.com>
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190220224003.4420-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 01/17] hw/arm/boot: introduce
 fdt_add_memory_node helper
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

On Wed, 20 Feb 2019 23:39:47 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> We introduce an helper to create a memory node.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> 
> v6 -> v7:
> - msg error in the caller
> - add comment about NUMA ID
> ---
>  hw/arm/boot.c | 54 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 34 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index d90af2f17d..a830655e1a 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -423,6 +423,32 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
>      }
>  }
>  
> +static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
> +                               uint32_t scells, hwaddr mem_len,
> +                               int numa_node_id)
> +{
> +    char *nodename;
> +    int ret;
> +
> +    nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> +    ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells, mem_base,
> +                                       scells, mem_len);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    /* only set the NUMA ID if it is specified */
> +    if (numa_node_id >= 0) {
> +        ret = qemu_fdt_setprop_cell(fdt, nodename,
> +                                    "numa-node-id", numa_node_id);
> +    }
> +out:
> +    g_free(nodename);
> +    return ret;
> +}
> +
>  static void fdt_add_psci_node(void *fdt)
>  {
>      uint32_t cpu_suspend_fn;
> @@ -502,7 +528,6 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>      void *fdt = NULL;
>      int size, rc, n = 0;
>      uint32_t acells, scells;
> -    char *nodename;
>      unsigned int i;
>      hwaddr mem_base, mem_len;
>      char **node_path;
> @@ -576,35 +601,24 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>          mem_base = binfo->loader_start;
>          for (i = 0; i < nb_numa_nodes; i++) {
>              mem_len = numa_info[i].node_mem;
> -            nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
> -            qemu_fdt_add_subnode(fdt, nodename);
> -            qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> -            rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
> -                                              acells, mem_base,
> -                                              scells, mem_len);
> +            rc = fdt_add_memory_node(fdt, acells, mem_base,
> +                                     scells, mem_len, i);
>              if (rc < 0) {
> -                fprintf(stderr, "couldn't set %s/reg for node %d\n", nodename,
> -                        i);
> +                fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
> +                        mem_base);
>                  goto fail;
>              }
>  
> -            qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", i);
>              mem_base += mem_len;
> -            g_free(nodename);
>          }
>      } else {
> -        nodename = g_strdup_printf("/memory@%" PRIx64, binfo->loader_start);
> -        qemu_fdt_add_subnode(fdt, nodename);
> -        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> -
> -        rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
> -                                          acells, binfo->loader_start,
> -                                          scells, binfo->ram_size);
> +        rc = fdt_add_memory_node(fdt, acells, binfo->loader_start,
> +                                 scells, binfo->ram_size, -1);
>          if (rc < 0) {
> -            fprintf(stderr, "couldn't set %s reg\n", nodename);
> +            fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
> +                    binfo->loader_start);
>              goto fail;
>          }
> -        g_free(nodename);
>      }
>  
>      rc = fdt_path_offset(fdt, "/chosen");
