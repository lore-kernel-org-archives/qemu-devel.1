Received: from eggs.gnu.org ([2001:4830:134:3::10]:45743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRgO3-0003U1-7k
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRgO2-0005uZ-C4
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:38:59 -0500
Date: Tue, 27 Nov 2018 17:38:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181127173848.0ea2b18a@redhat.com>
In-Reply-To: <20181126162942.21258-7-sameo@linux.intel.com>
References: <20181126162942.21258-1-sameo@linux.intel.com>
	<20181126162942.21258-7-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/8] hw: arm: Support both legacy and
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, 26 Nov 2018 17:29:39 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> We add the ability to build legacy or current RSDP tables, based on the
> AcpiRsdpData revision field passed to build_rsdp().
> Although arm/virt only uses RSDP v2, adding that capability to
> build_rsdp will allow us to share the RSDP build code between ARM and x86.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  hw/arm/virt-acpi-build.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index d47978a55e..10f8388b63 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -389,6 +389,27 @@ build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
>      /* Space for the RSDT address (32 bit) */
>      build_append_int_noprefix(tbl, 0, 4);
>  
> +    if (rsdp_data->rsdt_tbl_offset) {
> +        /* RSDT address to be filled by guest linker */
> +        bios_linker_loader_add_pointer(linker,
> +                                       ACPI_BUILD_RSDP_FILE, 16, 4,
> +                                       ACPI_BUILD_TABLE_FILE,
> +                                       *rsdp_data->rsdt_tbl_offset);
> +    }
> +
> +    /* Checksum to be filled by guest linker */
> +    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE, 0,
> +                                    ACPI_RSDP_REV_1_LEN,
> +                                    ACPI_RSDP_CHECKSUM_OFFSET);
> +
> +    if (rsdp_data->revision == ACPI_RSDP_REV_1) {
> +        /* Legacy RSDP, we're done */
> +        return;
> +    }
> +
> +    /* The RSDP revision is 2 and later, we must have an XSDT pointer */
> +    g_assert(rsdp_data->xsdt_tbl_offset != NULL);
> +
>      /* Length */
>      build_append_int_noprefix(tbl, ACPI_RSDP_REV_2_LEN, ACPI_RSDP_LEN_LEN);
>  
> @@ -406,11 +427,6 @@ build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
>      /* Space for the reserved bytes */
>      build_append_int_noprefix(tbl, 0, ACPI_RSDP_RESERVED_LEN);
>  
> -    /* Checksum to be filled by guest linker */
> -    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE, 0,
> -                                    ACPI_RSDP_REV_1_LEN,
> -                                    ACPI_RSDP_CHECKSUM_OFFSET);
> -
maybe put this hunk in 5/8 at the place where are you moving it here, so you don't have to touch it twice
(I'll leave it up to you)
otherwise looks good 


>      /* Extended checksum to be filled by Guest linker */
>      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE, 0,
>                                      ACPI_RSDP_REV_2_LEN,
