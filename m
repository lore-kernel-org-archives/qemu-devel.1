Received: from eggs.gnu.org ([209.51.188.92]:35472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h3MOT-0006QC-PT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h3MOS-0003X2-SG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:59:09 -0400
Date: Mon, 11 Mar 2019 15:58:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190311155857.78c6703d@redhat.com>
In-Reply-To: <20190308114218.26692-9-shameerali.kolothum.thodi@huawei.com>
References: <20190308114218.26692-1-shameerali.kolothum.thodi@huawei.com>
	<20190308114218.26692-9-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/11] hw/arm/boot: Expose the PC-DIMM
 nodes in the DT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com, linuxarm@huawei.com, xuwei5@hisilicon.com

On Fri, 8 Mar 2019 11:42:15 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> This patch adds memory nodes corresponding to PC-DIMM regions.
> 
> NVDIMM and ACPI_NVDIMM configs are not yet set for ARM so we
> don't need to care about NVDIMM at this stage.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/boot.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index a830655..4caaf91 100644
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
According to Eric's test, guest kernel picks this up. So it probably
should be an opt-in feature to avoid conflict with ACPI definition in DSDT.

> +    if (rc < 0) {
> +        fprintf(stderr, "couldn't add hotpluggable memory nodes\n");
> +        goto fail;
> +    }
> +
>      rc = fdt_path_offset(fdt, "/chosen");
>      if (rc < 0) {
>          qemu_fdt_add_subnode(fdt, "/chosen");
