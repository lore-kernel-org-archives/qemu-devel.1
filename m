Received: from eggs.gnu.org ([2001:4830:134:3::10]:46816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gQE1y-0002Cs-GB
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gQE1s-0005YY-OM
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:10:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gQE1r-0005Vz-VN
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:10:04 -0500
Date: Fri, 23 Nov 2018 11:10:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181123110106-mutt-send-email-mst@kernel.org>
References: <1542882574-109418-1-git-send-email-imammedo@redhat.com>
	<1542882574-109418-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542882574-109418-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] pc: acpi: use correct RSDT length for
 checksum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, sameo@linux.intel.com, drjones@redhat.com, peter.maydell@linaro.org

On Thu, Nov 22, 2018 at 11:29:33AM +0100, Igor Mammedov wrote:
> AcpiRsdpDescriptor describes revision 2 RSDP table so using sizeof(*rsdp)
> for checksum calculation isn't correct since we are adding extra 16 bytes.
> But acpi_data_push() zeroes out table, so just by luck we are summing up
> exta zeros which still yelds correct checksum.
> 
> Fix it up by explicitly stating table size instead of using
> pointer arithmetics on stucture.
> 
> PS:
> Extra 16 bytes are still wasted, but droping them will break migration
> for machines older than 2.3 due to size mismatch, for 2.3 and older it's
> not an issue since they are using resizable memory regions (a1666142d)
> for ACPI blobs. So keep wasting memory to avoid breaking old machines.

I'd like this explanation in code comments please.

> Fixes: 72c194f7e (i386: ACPI table generation code from seabios)
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> there is no changes to the current RSDP content caused by this patch
> ---
>  hw/i386/acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 236a20e..131c565 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2567,7 +2567,7 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
>  
>      /* Checksum to be filled by Guest linker */
>      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> -        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
> +        (char *)rsdp - rsdp_table->data, 20 /* ACPI rev 1.0 RSDP size */,
>          (char *)&rsdp->checksum - rsdp_table->data);
>  
>      return rsdp_table;

I dislike hard-coded size math like this.
How about a sub-structure for RSDPv1?


> -- 
> 2.7.4
