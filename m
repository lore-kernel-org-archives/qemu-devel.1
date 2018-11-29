Received: from eggs.gnu.org ([2001:4830:134:3::10]:42261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSMua-0004W5-ML
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSMuW-0005Iq-Bv
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:03:23 -0500
Date: Thu, 29 Nov 2018 15:02:46 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181129135301.l5dyvmjtpsrfjhdw@kamzik.brq.redhat.com>
References: <20181129132428.333-1-sameo@linux.intel.com>
	<20181129132428.333-3-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129132428.333-3-sameo@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] hw: arm: acpi: Fix incorrect
 checksums in RSDP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Nov 29, 2018 at 02:24:22PM +0100, Samuel Ortiz wrote:
> From: Igor Mammedov <imammedo@redhat.com>
> 
> When RSDP table was introduced (d4bec5d87), we calculated only legacy
> checksum, and that was incorrect as it
>  - specified rev=2 and forgot about extended checksum.
>  - legacy checksum calculated on full table instead of the 1st 20 bytes
> 
> Fix it by adding extended checksum calculation and using correct
> size for legacy checksum.
> 
> While at it use explicit constants to specify sub/full tables
> sizes instead of relying on AcpiRsdpDescriptor size and fields offsets.
> The follow up commits will convert this table to build_append_int_noprefix() API,
> will use constants anyway and remove unused AcpiRsdpDescriptor structure.
> 
> Based on "[PATCH v5 05/24] hw: acpi: Implement XSDT support for  RSDP"
> by Samuel Ortiz, who did it right in his impl.
> 
> Fixes: d4bec5d87 (hw/arm/virt-acpi-build: Generate RSDP table)
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> CC: Shannon Zhao <shannon.zhaosl@gmail.com>
> Reviewed-by: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>

I don't see my R-b here, but this patch doesn't appear to have changed
since I reviewed it. Here it is again

Reviewed-by: Andrew Jones <drjones@redhat.com>

> ---
>  hw/arm/virt-acpi-build.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index fcaa350892..0835900052 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -390,8 +390,13 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
>  
>      /* Checksum to be filled by Guest linker */
>      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> -        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
> +        (char *)rsdp - rsdp_table->data, 20 /* ACPI rev 1.0 RSDP size */,
>          (char *)&rsdp->checksum - rsdp_table->data);
> +
> +    /* Extended checksum to be filled by Guest linker */
> +    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> +        (char *)rsdp - rsdp_table->data, 36 /* ACPI rev 2.0 RSDP size */,
> +        (char *)&rsdp->extended_checksum - rsdp_table->data);
>  }
>  
>  static void
> -- 
> 2.19.2
> 
>
