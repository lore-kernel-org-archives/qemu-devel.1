Received: from eggs.gnu.org ([209.51.188.92]:53827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gvenc-0002cj-Rn
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gvelP-0004wY-Jd
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 03:59:00 -0500
Date: Mon, 18 Feb 2019 09:58:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190218095838.048819c5@Igors-MacBook-Pro.local>
In-Reply-To: <20190205173306.20483-13-eric.auger@redhat.com>
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-13-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 12/18] hw/arm/boot: Expose the PC-DIMM
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
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, drjones@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au

On Tue,  5 Feb 2019 18:33:00 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> This patch add memory nodes corresponding to PC-DIMM regions.
s/add/adds/ or s/This patch add/Add/

> 
> NV_DIMM and ACPI_NVDIMM configs are not yet set for ARM so we
> don't need to care about NV-DIMM at this stage.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v3 -> v4:
> - git rid of @base and @len in fdt_add_hotpluggable_memory_nodes
> 
> v1 -> v2:
> - added qapi_free_MemoryDeviceInfoList and simplify the loop
> ---
>  hw/arm/boot.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 2ef367e15b..2a70e8aa82 100644
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
> @@ -526,6 +527,34 @@ static void fdt_add_psci_node(void *fdt)
>      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
>  }
>  
> +static int fdt_add_hotpluggable_memory_nodes(void *fdt,
> +                                             uint32_t acells, uint32_t scells) {
> +    MemoryDeviceInfoList *info, *info_list = qmp_memory_device_list();
> +    MemoryDeviceInfo *mi;
> +    PCDIMMDeviceInfo *di;
> +    bool is_nvdimm;
> +    int ret = 0;
> +
> +    for (info = info_list; info != NULL; info = info->next) {
> +        mi = info->value;
> +        is_nvdimm = (mi->type == MEMORY_DEVICE_INFO_KIND_NVDIMM);
> +        di = !is_nvdimm ? mi->u.dimm.data : mi->u.nvdimm.data;
> +
> +        if (is_nvdimm) {
> +            ret = -ENOENT; /* NV-DIMM not yet supported */
> +        } else {
> +            ret = fdt_add_memory_node(fdt, acells, di->addr,
> +                                      scells, di->size, di->node);
> +        }
> +        if (ret < 0) {
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
> @@ -621,6 +650,12 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>          }
>      }
>  
> +    rc = fdt_add_hotpluggable_memory_nodes(fdt, acells, scells);
> +    if (rc < 0) {
> +            fprintf(stderr, "couldn't add hotpluggable memory nodes\n");
error message is rather vague, user using nvdimms + pc-dimms on CLI won't have
a clue that the former is not supported.
Suggest pass in error_fatal as argument and report more specific error from
fdt_add_hotpluggable_memory_nodes()

does this run on reboot?

> +            goto fail;
> +    }
> +
>      rc = fdt_path_offset(fdt, "/chosen");
>      if (rc < 0) {
>          qemu_fdt_add_subnode(fdt, "/chosen");
