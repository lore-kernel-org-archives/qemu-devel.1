Received: from eggs.gnu.org ([2001:4830:134:3::10]:57629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gIVrZ-0004n4-RF
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shannon.zhaosl@gmail.com>) id 1gIVrP-0007Ys-JA
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:35:27 -0400
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181101102303.16439-6-sameo@linux.intel.com>
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Message-ID: <c88b4769-a517-36da-b181-e59a4380bcea@gmail.com>
Date: Fri, 2 Nov 2018 17:35:06 +0800
MIME-Version: 1.0
In-Reply-To: <20181101102303.16439-6-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 05/23] hw: arm: Switch to the AML build
 RSDP building routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>



On 2018/11/1 18:22, Samuel Ortiz wrote:
> We make the ARM virt ACPI code use the now shared build_rsdp() API from
> aml-build.c. By doing so we fix a bug where the ARM implementation was
> missing adding both the legacy and extended checksums, which was
> building an invalid RSDP table.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>   hw/arm/virt-acpi-build.c | 31 +------------------------------
>   1 file changed, 1 insertion(+), 30 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 0ed132b79b..0a6a88380a 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -35,6 +35,7 @@
>   #include "target/arm/cpu.h"
>   #include "hw/acpi/acpi-defs.h"
>   #include "hw/acpi/acpi.h"
> +#include "hw/acpi/aml-build.h"
>   #include "hw/nvram/fw_cfg.h"
>   #include "hw/acpi/bios-linker-loader.h"
>   #include "hw/loader.h"
> @@ -366,36 +367,6 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>       aml_append(scope, dev);
>   }
>   
> -/* RSDP */
> -static void
> -build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
Note: here we use xsdt table not rsdt for ARM. After your change which 
assigns xsdt table address to rsdt_physical_address, it doesn't work.

IIRC, we discussed this before that ARM virt uses xsdt while pc/q35 uses 
rsdt. So this patch is not necessary I think.

Thanks,
Shannon
> -{
> -    AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> -    unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
> -    unsigned xsdt_pa_offset =
> -        (char *)&rsdp->xsdt_physical_address - rsdp_table->data;
> -
> -    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
> -                             true /* fseg memory */);
> -
> -    memcpy(&rsdp->signature, "RSD PTR ", sizeof(rsdp->signature));
> -    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, sizeof(rsdp->oem_id));
> -    rsdp->length = cpu_to_le32(sizeof(*rsdp));
> -    rsdp->revision = 0x02;
> -
> -    /* Address to be filled by Guest linker */
> -    bios_linker_loader_add_pointer(linker,
> -        ACPI_BUILD_RSDP_FILE, xsdt_pa_offset, xsdt_pa_size,
> -        ACPI_BUILD_TABLE_FILE, xsdt_tbl_offset);
> -
> -    /* Checksum to be filled by Guest linker */
> -    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> -        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
> -        (char *)&rsdp->checksum - rsdp_table->data);
> -
> -    return rsdp_table;
> -}
> -
>   static void
>   build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   {
> 
