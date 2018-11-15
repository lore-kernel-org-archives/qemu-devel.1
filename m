Received: from eggs.gnu.org ([2001:4830:134:3::10]:54778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gNIMJ-0001p1-1g
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gNIMI-0007ZL-9w
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:11:03 -0500
Date: Thu, 15 Nov 2018 15:10:03 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181115141003.r6imovu25ymatm4w@kamzik.brq.redhat.com>
References: <1542022940-46849-1-git-send-email-peng.hao2@zte.com.cn>
	<1542022940-46849-6-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542022940-46849-6-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V6 5/6] hw/arm/virt: add pvpanic device in
 virt acpi table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: peter.maydell@linaro.org, philmd@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Mon, Nov 12, 2018 at 07:42:19PM +0800, Peng Hao wrote:
> add pvpanic device in virt acpi table, so when kenrel command line uses
> acpi=force, kernel can get info from acpi table in aarch64.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  hw/arm/virt-acpi-build.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 5785fb6..d126cee 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -61,6 +61,21 @@ static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
>      }
>  }
>  
> +static void acpi_dsdt_add_pvpanic(Aml *scope, const MemMapEntry *pvpanic_memmap)
> +{
> +    Aml *dev = aml_device("PANC");

Shouldn't this be "PEVT" ("panic event"), like it is for x86?

> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0001")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));

Why add _UID? Also, I see x86 had some issues with not having _STA and
then having a _STA without the UI flag. It now has _STA=0xf
(PRESENT|ENABLED|UI|FUNCTIONING). I'm not saying we need to do that to,
but I'd like to know if it was considered and decided we don't need to.

> +
> +    Aml *crs = aml_resource_template();
> +    aml_append(crs, aml_memory32_fixed(pvpanic_memmap->base,
> +                                       pvpanic_memmap->size, AML_READ_WRITE));
> +
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    aml_append(scope, dev);
> +}
> +
>  static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>                                             uint32_t uart_irq)
>  {
> @@ -770,6 +785,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_dsdt_add_cpus(scope, vms->smp_cpus);
>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
>                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
> +    acpi_dsdt_add_pvpanic(scope, &memmap[VIRT_PVPANIC]);
>      acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
>      acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
>      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
> -- 
> 1.8.3.1
> 
> 

Thanks,
drew
