Received: from eggs.gnu.org ([2001:4830:134:3::10]:57200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dgDZy-0002mI-MB
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dgDZv-000705-Gu
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:18:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dgDZv-0006zV-B2
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:18:31 -0400
Date: Fri, 11 Aug 2017 20:18:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170811201006-mutt-send-email-mst@kernel.org>
References: <20170811151138.29405-1-anthony.perard@citrix.com>
	<20170811151138.29405-2-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170811151138.29405-2-anthony.perard@citrix.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/2] hw/acpi: Call
 acpi_set_pci_info when no ACPI tables needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Bruce Rogers <brogers@suse.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Aug 11, 2017 at 04:11:37PM +0100, Anthony PERARD wrote:
> To do PCI passthrough with Xen, the property acpi-pcihp-bsel needs to be
> set, but this was done only when ACPI tables are built which is not
> needed for a Xen guest. The need for the property starts with commit
> "pc: pcihp: avoid adding ACPI_PCIHP_PROP_BSEL twice"
> (f0c9d64a68b776374ec4732424a3e27753ce37b6).
> 
> Set pci info before checking for the needs to build ACPI tables.
> 
> Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
> Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

I am worried that Xen will come to depend on specific
assignment of bsel which isn't guaranteed. Thoughts on
how to avoid that?



> 
> ---
> In this patch rather than always calling acpi_set_pci_info() when
> acpi_setup() is called, we could check first for acpi_enabled? (which is
> true for Xen.)

Yes, please change it like this. Also, please add
a comment explainging what it does.


Thanks!

> 
> This patch would be a canditade to backport to 2.9.
> 
> CC: Stefano Stabellini <sstabellini@kernel.org>
> CC: Bruce Rogers <brogers@suse.com>
> ---
>  hw/i386/acpi-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 98dd424678..e1b7797408 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2871,6 +2871,8 @@ void acpi_setup(void)
>      AcpiBuildState *build_state;
>      Object *vmgenid_dev;
>  
> +    acpi_set_pci_info();
> +
>      if (!pcms->fw_cfg) {
>          ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
>          return;
> @@ -2888,8 +2890,6 @@ void acpi_setup(void)
>  
>      build_state = g_malloc0(sizeof *build_state);
>  
> -    acpi_set_pci_info();
> -
>      acpi_build_tables_init(&tables);
>      acpi_build(&tables, MACHINE(pcms));
>  
> -- 
> Anthony PERARD
