Received: from eggs.gnu.org ([2001:4830:134:3::10]:37900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gSfFt-0005iw-DU
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gSfFr-0001yf-QF
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:38:37 -0500
Date: Fri, 30 Nov 2018 10:38:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181130103822.6b9a6919@redhat.com>
In-Reply-To: <20181129132428.333-7-sameo@linux.intel.com>
References: <20181129132428.333-1-sameo@linux.intel.com>
	<20181129132428.333-7-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/8] hw: arm: Support both legacy and
 current RSDP build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>

On Thu, 29 Nov 2018 14:24:26 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> We add the ability to build legacy or current RSDP tables, based on the
> AcpiRsdpData revision field passed to build_rsdp().
> Although arm/virt only uses RSDP v2, adding that capability to
> build_rsdp will allow us to share the RSDP build code between ARM and x86.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/virt-acpi-build.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 4782aea4fe..e1338b6f5a 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -378,23 +378,38 @@ build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
>      g_array_append_vals(tbl, rsdp_data->oem_id, 6); /* OEMID */
>      build_append_int_noprefix(tbl, rsdp_data->revision, 1); /* Revision */
>      build_append_int_noprefix(tbl, 0, 4); /* RsdtAddress */
> -    build_append_int_noprefix(tbl, 36, 4); /* Length */
> -
> -    /* XSDT address to be filled by guest linker */
> -    build_append_int_noprefix(tbl, 0, 8); /* XsdtAddress */
> -    bios_linker_loader_add_pointer(linker, ACPI_BUILD_RSDP_FILE,
> -                                   24, 8,
> -                                   ACPI_BUILD_TABLE_FILE,
> -                                   *rsdp_data->xsdt_tbl_offset);
> -
> -    build_append_int_noprefix(tbl, 0, 1); /* Extended Checksum */
> -    build_append_int_noprefix(tbl, 0, 3); /* Reserved */
> +    if (rsdp_data->rsdt_tbl_offset) {
> +        /* RSDT address to be filled by guest linker */
> +        bios_linker_loader_add_pointer(linker,
> +                                       ACPI_BUILD_RSDP_FILE, 16, 4,
> +                                       ACPI_BUILD_TABLE_FILE,
> +                                       *rsdp_data->rsdt_tbl_offset);
> +    }
>  
>      /* Checksum to be filled by guest linker */
>      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
>                                      0, 20, /* ACPI rev 1.0 RSDP size */
>                                      8);
>  
> +    if (rsdp_data->revision == 0) {
> +        /* ACPI 1.0 RSDP, we're done */
> +        return;
> +    }
> +
> +    /* The RSDP revision is 2 and later, we must have an XSDT pointer */
> +    g_assert(rsdp_data->xsdt_tbl_offset != NULL);
> +
> +    build_append_int_noprefix(tbl, 36, 4); /* Length */
> +
> +    /* XSDT address to be filled by guest linker */
> +    build_append_int_noprefix(tbl, 0, 8); /* XsdtAddress */
> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_RSDP_FILE, 24, 8,
> +                                   ACPI_BUILD_TABLE_FILE,
> +                                   *rsdp_data->xsdt_tbl_offset);
> +
> +    build_append_int_noprefix(tbl, 0, 1); /* Extended Checksum */
> +    build_append_int_noprefix(tbl, 0, 3); /* Reserved */
> +
>      /* Extended checksum to be filled by Guest linker */
>      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
>                                      0, 36, /* ACPI rev 2.0 RSDP size */
