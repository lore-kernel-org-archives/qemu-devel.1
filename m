Received: from eggs.gnu.org ([2001:4830:134:3::10]:52150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gPo4U-00032I-6r
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gPo4Q-0003Qq-K8
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:27:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1gPo4Q-0003Nx-7V
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:26:58 -0500
Date: Thu, 22 Nov 2018 13:26:49 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181122122649.okwoa2qvpqao53mb@kamzik.brq.redhat.com>
References: <1542882574-109418-1-git-send-email-imammedo@redhat.com>
	<1542882574-109418-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542882574-109418-3-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] arm/virt: acpi: fix incorrect
 checksums in RSDP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, sameo@linux.intel.com, mst@redhat.com, peter.maydell@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>

On Thu, Nov 22, 2018 at 11:29:34AM +0100, Igor Mammedov wrote:
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
> CC: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  hw/arm/virt-acpi-build.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 5785fb6..daa093b 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -390,9 +390,14 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
>  
>      /* Checksum to be filled by Guest linker */
>      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> -        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
> +        (char *)rsdp - rsdp_table->data, 20 /* ACPI rev 1.0 RSDP size */,
>          (char *)&rsdp->checksum - rsdp_table->data);
>  
> +    /* Extended checksum to be filled by Guest linker */
> +    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> +        (char *)rsdp - rsdp_table->data, 36 /* ACPI rev 2.0 RSDP size */,
> +        (char *)&rsdp->extended_checksum - rsdp_table->data);
> +
>      return rsdp_table;
>  }
>  
> -- 
> 2.7.4
> 

Indeed this slipped by because Linux doesn't seem to care. Linux doesn't
even check the checksums by default. It can be forced to check them by
adding the acpi_force_table_verification kernel command line parameter,
but even then it didn't care that we got it wrong for this table, at it
apparently doesn't bother checking it the RSDP, but rather just the XSDT
it points to. In any case, a guest that was depending on that broken
behavior is broken, so we can fix this without concern for compatibility,
and with this change we now match the spec.

Reviewed-by: Andrew Jones <drjones@redhat.com>
