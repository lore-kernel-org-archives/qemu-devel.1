Received: from eggs.gnu.org ([2001:4830:134:3::10]:49511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRKMs-00014E-FQ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRKMp-0004O5-6Z
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:08:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRKMp-0004NA-0V
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:08:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so19778594wrb.2
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 09:08:13 -0800 (PST)
References: <20181126162942.21258-1-sameo@linux.intel.com>
	<20181126162942.21258-2-sameo@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1282f627-077e-975d-62ba-cf045fe86a20@redhat.com>
Date: Mon, 26 Nov 2018 18:07:38 +0100
MIME-Version: 1.0
In-Reply-To: <20181126162942.21258-2-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/8] hw: acpi: The RSDP build API can
 return void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 26/11/18 17:29, Samuel Ortiz wrote:
> For both x86 and ARM architectures, the internal RSDP build API can
> return void as the current return value is unused.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/virt-acpi-build.c | 4 +---
>  hw/i386/acpi-build.c     | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 5785fb697c..fcaa350892 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -367,7 +367,7 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>  }
>  
>  /* RSDP */
> -static GArray *
> +static void
>  build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
>  {
>      AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> @@ -392,8 +392,6 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
>      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
>          (char *)rsdp - rsdp_table->data, sizeof *rsdp,
>          (char *)&rsdp->checksum - rsdp_table->data);
> -
> -    return rsdp_table;
>  }
>  
>  static void
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 236a20eaa8..35f17d0d91 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2547,7 +2547,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
>                   "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
>  }
>  
> -static GArray *
> +static void
>  build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
>  {
>      AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> @@ -2569,8 +2569,6 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
>      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
>          (char *)rsdp - rsdp_table->data, sizeof *rsdp,
>          (char *)&rsdp->checksum - rsdp_table->data);
> -
> -    return rsdp_table;
>  }
>  
>  typedef
> 
