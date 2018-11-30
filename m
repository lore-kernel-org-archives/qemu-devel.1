Received: from eggs.gnu.org ([2001:4830:134:3::10]:41744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSlJt-0000rY-8r
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSlJs-0002HA-GZ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:07:09 -0500
Date: Fri, 30 Nov 2018 17:06:53 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181130160653.adccrrdtgr5vtey6@kamzik.brq.redhat.com>
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
	<1543407172-16175-6-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543407172-16175-6-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V10 5/9] hw/arm/virt: add pvpanic device in
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

On Wed, Nov 28, 2018 at 08:12:48PM +0800, Peng Hao wrote:
> Add pvpanic device in virt acpi table, so when kenrel command line
> uses acpi=force, kernel can get info from acpi table.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  hw/arm/virt-acpi-build.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 5785fb6..2adba60 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -84,6 +84,20 @@ static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>      aml_append(scope, dev);
>  }
>  
> +static void acpi_dsdt_add_pvpanic(Aml *scope, const MemMapEntry *pvpanic_memmap)
> +{
> +    Aml *dev = aml_device("PEVT");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0001")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    Aml *crs = aml_resource_template();
> +    aml_append(crs, aml_memory32_fixed(pvpanic_memmap->base,
> +                                       pvpanic_memmap->size, AML_READ_WRITE));
> +
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +
>  static void acpi_dsdt_add_fw_cfg(Aml *scope, const MemMapEntry *fw_cfg_memmap)
>  {
>      Aml *dev = aml_device("FWCF");
> @@ -771,6 +785,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
>                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
>      acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> +    acpi_dsdt_add_pvpanic(scope, &memmap[VIRT_PVPANIC]);
>      acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
>      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
>                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
> -- 
> 1.8.3.1
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
