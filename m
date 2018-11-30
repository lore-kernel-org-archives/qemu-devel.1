Received: from eggs.gnu.org ([2001:4830:134:3::10]:36270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSl4r-0005bg-Bw
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSl4q-0005YL-J5
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:51:37 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSl4q-0005Y8-Ce
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:51:36 -0500
Received: by mail-ot1-x342.google.com with SMTP id u16so5487070otk.8
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 07:51:36 -0800 (PST)
MIME-Version: 1.0
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
	<1543407172-16175-6-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543407172-16175-6-git-send-email-peng.hao2@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:51:24 +0000
Message-ID: <CAFEAcA_+JB43Q=O2jVZ6Rr1brawaH1QcmFWWQ2UXevdqr173fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Wed, 28 Nov 2018 at 03:50, Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Add pvpanic device in virt acpi table, so when kenrel command line

typo: "kernel". I'll leave it to the ACPI experts to review the
meat of this patch.

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

thanks
-- PMM
