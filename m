Received: from eggs.gnu.org ([209.51.188.92]:56791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDsNK-0000JN-9W
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDsNJ-0004Pf-5t
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:09:26 -0400
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-9-shameerali.kolothum.thodi@huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4f3df83f-8d45-09d0-ec9e-0ddf843fd3a4@redhat.com>
Date: Tue, 9 Apr 2019 17:08:57 +0200
MIME-Version: 1.0
In-Reply-To: <20190409102935.28292-9-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 8/8] hw/arm/boot: Expose the PC-DIMM
 nodes in the DT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com, imammedo@redhat.com
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com, xuwei5@hisilicon.com, ard.biesheuvel@linaro.org, linuxarm@huawei.com

On 04/09/19 12:29, Shameer Kolothum wrote:
> This patch adds memory nodes corresponding to PC-DIMM regions.
> This will enable support for cold plugged device memory for Guests
> with DT boot.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/boot.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 8c840ba..150e1ed 100644
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
> @@ -538,6 +539,41 @@ static void fdt_add_psci_node(void *fdt)
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
> +            ret = fdt_add_memory_node(fdt, acells, di->addr, scells,
> +                                      di->size, di->node, true);
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
> @@ -637,6 +673,12 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>          }
>      }
>  
> +    rc = fdt_add_hotpluggable_memory_nodes(fdt, acells, scells);
> +    if (rc < 0) {
> +        fprintf(stderr, "couldn't add hotpluggable memory nodes\n");
> +        goto fail;
> +    }
> +
>      rc = fdt_path_offset(fdt, "/chosen");
>      if (rc < 0) {
>          qemu_fdt_add_subnode(fdt, "/chosen");
> 


Given patches #7 and #8, as I understand them, the firmware cannot distinguish hotpluggable & present, from hotpluggable & absent. The firmware can only skip both hotpluggable cases. That's fine in that the firmware will hog neither type -- but is that OK for the OS as well, for both ACPI boot and DT boot?

Consider in particular the "hotpluggable & present, ACPI boot" case. Assuming we modify the firmware to skip "hotpluggable" altogether, the UEFI memmap will not include the range despite it being present at boot. Presumably, ACPI will refer to the range somehow, however. Will that not confuse the OS?

When Igor raised this earlier, I suggested that hotpluggable-and-present should be added by the firmware, but also allocated immediately, as EfiBootServicesData type memory. This will prevent other drivers in the firmware from allocating AcpiNVS or Reserved chunks from the same memory range, the UEFI memmap will contain the range as EfiBootServicesData, and then the OS can release that allocation in one go early during boot.

But this really has to be clarified from the Linux kernel's expectations. Please formalize all of the following cases:

OS boot (DT/ACPI)  hotpluggable & ...  GetMemoryMap() should report as  DT/ACPI should report as
-----------------  ------------------  -------------------------------  ------------------------
DT                 present             ?                                ?
DT                 absent              ?                                ?
ACPI               present             ?                                ?
ACPI               absent              ?                                ?

Again, this table is dictated by Linux.

Thanks
Laszlo
