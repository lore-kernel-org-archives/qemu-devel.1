Received: from eggs.gnu.org ([2001:4830:134:3::10]:37966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gNabE-00089J-Vz
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gNab9-0003r7-R7
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:39:40 -0500
Date: Fri, 16 Nov 2018 10:39:09 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181116103909.64f35d5d@redhat.com>
In-Reply-To: <20181105014047.26447-20-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-20-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 19/24] hw: acpi: Retrieve the PCI bus
 from AcpiPciHpState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Jing Liu <jing2.liu@linux.intel.com>

On Mon,  5 Nov 2018 02:40:42 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>=20
> Instead of using the machine type specific method find_i440fx() to
> retrieve the PCI bus, this commit aims to rely on the fact that the
> PCI bus is known by the structure AcpiPciHpState.
>=20
> When the structure is initialized through acpi_pcihp_init() call,
> it saves the PCI bus, which means there is no need to invoke a
> special function later on.
>=20
> Based on the fact that find_i440fx() was only used there, this
> patch also removes the function find_i440fx() itself from the
> entire codebase.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Thanks for cleaning it up

minor nit:
Taking in account that you're removing '/* TODO: Q35 support */'
comment along with find_i440fx(), it might be worth to mention
in this commit message. Something along lines that ACPI PCIHP
exist to support guests without SHPC support on PCI
based PC machine. Considering that Q35 provides native
PCI-E hotplug, there is no need to add ACPI hotplug there.


with commit message fixed

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/pc.h  |  1 -
>  hw/acpi/pcihp.c       | 10 ++++------
>  hw/pci-host/piix.c    |  8 --------
>  stubs/pci-host-piix.c |  6 ------
>  stubs/Makefile.objs   |  1 -
>  5 files changed, 4 insertions(+), 22 deletions(-)
>  delete mode 100644 stubs/pci-host-piix.c
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 44cb6bf3f3..8e5f1464eb 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -255,7 +255,6 @@ PCIBus *i440fx_init(const char *host_type, const char=
 *pci_type,
>                      MemoryRegion *pci_memory,
>                      MemoryRegion *ram_memory);
> =20
> -PCIBus *find_i440fx(void);
>  /* piix4.c */
>  extern PCIDevice *piix4_dev;
>  int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 80d42e12ff..254b2e50ab 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -93,10 +93,9 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
>      return bsel_alloc;
>  }
> =20
> -static void acpi_set_pci_info(void)
> +static void acpi_set_pci_info(AcpiPciHpState *s)
>  {
>      static bool bsel_is_set;
> -    PCIBus *bus;
>      unsigned bsel_alloc =3D ACPI_PCIHP_BSEL_DEFAULT;
> =20
>      if (bsel_is_set) {
> @@ -104,10 +103,9 @@ static void acpi_set_pci_info(void)
>      }
>      bsel_is_set =3D true;
> =20
> -    bus =3D find_i440fx(); /* TODO: Q35 support */
> -    if (bus) {
> +    if (s->root) {
>          /* Scan all PCI buses. Set property to enable acpi based hotplug=
. */
> -        pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_all=
oc);
> +        pci_for_each_bus_depth_first(s->root, acpi_set_bsel, NULL, &bsel=
_alloc);
>      }
>  }
> =20
> @@ -213,7 +211,7 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
> =20
>  void acpi_pcihp_reset(AcpiPciHpState *s)
>  {
> -    acpi_set_pci_info();
> +    acpi_set_pci_info(s);
>      acpi_pcihp_update(s);
>  }
> =20
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 47293a3915..658460264b 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -445,14 +445,6 @@ PCIBus *i440fx_init(const char *host_type, const cha=
r *pci_type,
>      return b;
>  }
> =20
> -PCIBus *find_i440fx(void)
> -{
> -    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> -                                   object_resolve_path("/machine/i440fx"=
, NULL),
> -                                   TYPE_PCI_HOST_BRIDGE);
> -    return s ? s->bus : NULL;
> -}
> -
>  /* PIIX3 PCI to ISA bridge */
>  static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
>  {
> diff --git a/stubs/pci-host-piix.c b/stubs/pci-host-piix.c
> deleted file mode 100644
> index 6ed81b1f21..0000000000
> --- a/stubs/pci-host-piix.c
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#include "qemu/osdep.h"
> -#include "hw/i386/pc.h"
> -PCIBus *find_i440fx(void)
> -{
> -    return NULL;
> -}
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 5dd0aeeec6..725f78bedc 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -41,6 +41,5 @@ stub-obj-y +=3D pc_madt_cpu_entry.o
>  stub-obj-y +=3D vmgenid.o
>  stub-obj-y +=3D xen-common.o
>  stub-obj-y +=3D xen-hvm.o
> -stub-obj-y +=3D pci-host-piix.o
>  stub-obj-y +=3D ram-block.o
>  stub-obj-y +=3D ramfb.o
