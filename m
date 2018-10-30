Received: from eggs.gnu.org ([2001:4830:134:3::10]:50374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHVT4-00053R-O8
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHVT0-0006cO-FF
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:58:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:62770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gHVT0-0006aL-4v
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:58:02 -0400
Date: Tue, 30 Oct 2018 15:57:15 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181030145715.GC5291@caravaggio.home>
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-10-sameo@linux.intel.com>
	<ec47ae4b-5dce-9b21-0126-04f302b701eb@redhat.com>
	<6df32467-fe8f-8821-aa20-cf8e1a7dab29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6df32467-fe8f-8821-aa20-cf8e1a7dab29@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/19] hw: acpi: Export and generalize
 the PCI host AML API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Rob Bradford <robert.bradford@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Philippe,

On Mon, Oct 29, 2018 at 08:29:38PM +0100, Philippe Mathieu-Daudé wrote:
> On 29/10/18 20:23, Philippe Mathieu-Daudé wrote:
> > On 29/10/18 18:01, Samuel Ortiz wrote:
> > > From: Yang Zhong <yang.zhong@intel.com>
> > > 
> > > The AML build routines for the PCI host bridge and the corresponding
> > > DSDT addition are neither x86 nor PC machine type specific.
> > > We can move them to the architecture agnostic hw/acpi folder, and by
> > > carrying all the needed information through a new AcpiPciBus structure,
> > > we can make them PC machine type independent.
> > > 
> > > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > > Signed-off-by: Rob Bradford <robert.bradford@intel.com>
> > > ---
> > >   hw/acpi/aml-build.c         | 208 ++++++++++++++++++++++++++++++++++++
> > >   hw/i386/acpi-build.c        | 167 ++---------------------------
> > >   include/hw/acpi/aml-build.h |  10 ++
> > >   3 files changed, 226 insertions(+), 159 deletions(-)
> > > 
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > index 52ac39acdb..aa72b5459c 100644
> > > --- a/hw/acpi/aml-build.c
> > > +++ b/hw/acpi/aml-build.c
> > > @@ -29,6 +29,25 @@
> > >   #include "hw/pci/pci_bus.h"
> > >   #include "qemu/range.h"
> > >   #include "hw/pci/pci_bridge.h"
> > > +#include "hw/i386/pc.h"
> 
> Err I just missed that, this include doesn't belong here, ...
> 
> > > +#include "sysemu/tpm.h"
> > > +#include "hw/acpi/tpm.h"
> > > +
> > > +#define PCI_HOST_BRIDGE_CONFIG_ADDR        0xcf8
> > > +#define PCI_HOST_BRIDGE_IO_0_MIN_ADDR      0x0000
> > > +#define PCI_HOST_BRIDGE_IO_0_MAX_ADDR      0x0cf7
> > > +#define PCI_HOST_BRIDGE_IO_1_MIN_ADDR      0x0d00
> > > +#define PCI_HOST_BRIDGE_IO_1_MAX_ADDR      0xffff
> > > +#define PCI_VGA_MEM_BASE_ADDR              0x000a0000
> > > +#define PCI_VGA_MEM_MAX_ADDR               0x000bffff
> > > +#define IO_0_LEN                           0xcf8
> > > +#define VGA_MEM_LEN                        0x20000
> > > +
> > > +static const char *pci_hosts[] = {
> > 
> > This array should stay in hw/i386/acpi-build.c.
> > 
> > > +   "/machine/i440fx",
> > > +   "/machine/q35",
> > > +   NULL,
> > > +};
> > >   static GArray *build_alloc_array(void)
> > >   {
> > > @@ -1601,6 +1620,51 @@ void
> > > acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
> > >       g_array_free(tables->vmgenid, mfre);
> > >   }
> > > +/*
> > > + * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
> > > + */
> > > +Object *acpi_get_pci_host(void)
> > 
> > This function should take the machine_paths as argument.
> > 
> > > +{
> > > +    PCIHostState *host;
> > > +    int i = 0;
> > > +
> > > +    while (pci_hosts[i]) {
> > > +        host = OBJECT_CHECK(PCIHostState,
> > > +                            object_resolve_path(pci_hosts[i], NULL),
> > > +                            TYPE_PCI_HOST_BRIDGE);
> > > +        if (host) {
> > > +            return OBJECT(host);
> > > +        }
> > > +
> > > +        i++;
> > > +    }
> > > +
> > > +    return NULL;
> > > +}
> > > +
> > > +void acpi_get_pci_holes(Range *hole, Range *hole64)
> 
> ... and this function neither, it should stay in hw/i386/acpi-build.c, thus
> you don't need to modify the prototype and can call
> acpi_get_pci_host(x86_machine_paths) directly.
>
So the idea for those routines is that they're not x86 specific. As a
matter of fact, they will eventually get called from architecture
agnostic code like e.g. hw/acpi/reduced.c. So I don't think they should
live under hw/i386/

Moreover adding an argument to acpi_get_pci_host() means the caller should
know which potential machines it needs to go through. And once both
arm/virt and i386/virt calls into hw/acpi/reduced.c, we need to somehow
pass a relevant set of machines paths to this API.
So I think a more robust way to do so would be for each machine instance to
be able to set its own PCI host pointer instead of having to maintain
a per architecture set of potential PCI machine paths. I'm thinking
about adding that to the AcpiConfiguration structure and let each
machine fills it if/when it builds its PCI host.

Cheers,
Samuel.
