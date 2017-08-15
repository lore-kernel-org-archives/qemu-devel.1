Received: from eggs.gnu.org ([2001:4830:134:3::10]:36390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhadh-00057r-Ti
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 08:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhadb-0003Ot-T2
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 08:08:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dhadb-0003OU-JO
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 08:07:59 -0400
Date: Tue, 15 Aug 2017 14:07:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170815140751.2d432a46@nial.brq.redhat.com>
In-Reply-To: <20170815111549.6232-2-anthony.perard@citrix.com>
References: <20170815111549.6232-1-anthony.perard@citrix.com>
	<20170815111549.6232-2-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 1/2] hw/acpi: Call
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
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Bruce Rogers <brogers@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, 15 Aug 2017 12:15:48 +0100
Anthony PERARD <anthony.perard@citrix.com> wrote:

> To do PCI passthrough with Xen, the property acpi-pcihp-bsel needs to be
> set, but this was done only when ACPI tables are built which is not
> needed for a Xen guest. The need for the property starts with commit
> "pc: pcihp: avoid adding ACPI_PCIHP_PROP_BSEL twice"
> (f0c9d64a68b776374ec4732424a3e27753ce37b6).
> 
> Set pci info before checking for the needs to build ACPI tables.
> 
> Assign bsel=0 property only to the root bus on Xen as there is no
> support in the Xen ACPI tables for a different value.

looking at hw/acpi/pcihp.c and bsel usage there it looks like
bsel property is owned by it and not by ACPI tables, so instead of
shuffling it in acpi_setup(), how about moving bsel initialization
to hw/acpi/pcihp.c and initialize it there unconditionally?

It could be as simple as moving acpi_set_pci_info()/acpi_set_bsel()
there and calling it from acpi_pcihp_reset().

Then there won't be need for Xen specific branches, as root bus
will have bsel set automatically which is sufficient for Xen and
the rest of bsel-s (bridges) will be just unused by Xen,
which could later extend its ACPI table implementation to utilize them. 


> Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> 
> ---
> Changes in V2:
>   - check for acpi_enabled before calling acpi_set_pci_info.
>   - set the property on the root bus only.
> 
> This patch would be a canditade to backport to 2.9.
> 
> CC: Stefano Stabellini <sstabellini@kernel.org>
> CC: Bruce Rogers <brogers@suse.com>
> ---
>  hw/i386/acpi-build.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 98dd424678..c0483b96cf 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -46,6 +46,7 @@
>  #include "sysemu/tpm_backend.h"
>  #include "hw/timer/mc146818rtc_regs.h"
>  #include "sysemu/numa.h"
> +#include "hw/xen/xen.h"
>  
>  /* Supported chipsets: */
>  #include "hw/acpi/piix4.h"
> @@ -518,8 +519,13 @@ static void acpi_set_pci_info(void)
>      unsigned bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT;
>  
>      if (bus) {
> -        /* Scan all PCI buses. Set property to enable acpi based hotplug. */
> -        pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
> +        if (xen_enabled()) {
> +            /* Assign BSEL property to root bus only. */
> +            acpi_set_bsel(bus, &bsel_alloc);
> +        } else {
> +            /* Scan all PCI buses. Set property to enable acpi based hotplug. */
> +            pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
> +        }
>      }
>  }
>  
> @@ -2871,6 +2877,14 @@ void acpi_setup(void)
>      AcpiBuildState *build_state;
>      Object *vmgenid_dev;
>  
> +    if (!acpi_enabled) {
> +        ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
> +        return;
> +    }
> +
> +    /* Assign BSEL property on hotpluggable PCI buses. */
> +    acpi_set_pci_info();
> +
>      if (!pcms->fw_cfg) {
>          ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
>          return;
> @@ -2881,15 +2895,8 @@ void acpi_setup(void)
>          return;
>      }
>  
> -    if (!acpi_enabled) {
> -        ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
> -        return;
> -    }
> -
>      build_state = g_malloc0(sizeof *build_state);
>  
> -    acpi_set_pci_info();
> -
>      acpi_build_tables_init(&tables);
>      acpi_build(&tables, MACHINE(pcms));
>  
