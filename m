Received: from eggs.gnu.org ([209.51.188.92]:53928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gxBA0-0006EG-Ts
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gxAvB-0003Hm-8Z
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:31:22 -0500
Date: Fri, 22 Feb 2019 14:30:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190222143002.23705904@redhat.com>
In-Reply-To: <20190220224003.4420-12-eric.auger@redhat.com>
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190220224003.4420-12-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 11/17] hw/arm/boot: Expose the PC-DIMM
 nodes in the DT
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

On Wed, 20 Feb 2019 23:39:57 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> This patch adds memory nodes corresponding to PC-DIMM regions.
> 
> NV_DIMM and ACPI_NVDIMM configs are not yet set for ARM so we
  ^^^
git grep says it doesn't exists

> don't need to care about NV-DIMM at this stage.
we use NVDIMM term everywhere in QEMU so fix it up just for consistency

> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
with all comments addressed

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v6 -> v7:
> - rework the error messages, use a switch/case
> v3 -> v4:
> - git rid of @base and @len in fdt_add_hotpluggable_memory_nodes
> 
> v1 -> v2:
> - added qapi_free_MemoryDeviceInfoList and simplify the loop
> ---
>  hw/arm/boot.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index a830655e1a..255aaca0cf 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -19,6 +19,7 @@
>  #include "sysemu/numa.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> +#include "hw/mem/memory-device.h"
>  #include "elf.h"
>  #include "sysemu/device_tree.h"
>  #include "qemu/config-file.h"
> @@ -522,6 +523,41 @@ static void fdt_add_psci_node(void *fdt)
>      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
>  }
>  
> +static int fdt_add_hotpluggable_memory_nodes(void *fdt,
> +                                             uint32_t acells, uint32_t scells) {
> +    MemoryDeviceInfoList *info, *info_list = qmp_memory_device_list();
> +    MemoryDeviceInfo *mi;
> +    int ret = 0;
> +
> +    for (info = info_list; info != NULL; info = info->next) {
> +        mi = info->value;
> +        switch (mi->type) {
> +        case MEMORY_DEVICE_INFO_KIND_DIMM:
> +        {
> +            PCDIMMDeviceInfo *di = mi->u.dimm.data;
> +
> +            ret = fdt_add_memory_node(fdt, acells, di->addr,
> +                                      scells, di->size, di->node);
> +            if (ret) {
> +                fprintf(stderr,
> +                        "couldn't add PCDIMM /memory@%"PRIx64" node\n",
> +                        di->addr);
> +                goto out;
> +            }
> +            break;
> +        }
> +        default:
> +            fprintf(stderr, "%s memory nodes are not yet supported\n",
> +                    MemoryDeviceInfoKind_str(mi->type));
> +            ret = -ENOENT;
> +            goto out;
> +        }
> +    }
> +out:
> +    qapi_free_MemoryDeviceInfoList(info_list);
> +    return ret;
> +}
> +
>  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>                   hwaddr addr_limit, AddressSpace *as)
>  {
> @@ -621,6 +657,12 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>          }
>      }
>  
> +    rc = fdt_add_hotpluggable_memory_nodes(fdt, acells, scells);
> +    if (rc < 0) {
> +            fprintf(stderr, "couldn't add hotpluggable memory nodes\n");
> +            goto fail;
wrong indent

> +    }
> +
>      rc = fdt_path_offset(fdt, "/chosen");
>      if (rc < 0) {
>          qemu_fdt_add_subnode(fdt, "/chosen");
