Received: from eggs.gnu.org ([2001:4830:134:3::10]:50671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sebastien.boeuf@intel.com>) id 1gHH4W-0008TT-Q0
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sebastien.boeuf@intel.com>) id 1gHH4S-00080O-5m
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:35:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:46842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sebastien.boeuf@intel.com>)
	id 1gHH4Q-0007wN-4E
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:35:44 -0400
From: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
Date: Mon, 29 Oct 2018 23:35:26 +0000
Message-ID: <1E91073893EF8F498411079ED374F91245EE1730@ORSMSX115.amr.corp.intel.com>
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-17-sameo@linux.intel.com>,
	<5d77ee72-8073-d5c3-6859-842846442cce@redhat.com>
In-Reply-To: <5d77ee72-8073-d5c3-6859-842846442cce@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 16/19] hw: acpi: Retrieve the PCI bus
 from AcpiPciHpState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Samuel
	Ortiz <sameo@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jing Liu <jing2.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor
	Mammedov <imammedo@redhat.com>

Glad you think it's worth it.=0A=
=0A=
Thanks,=0A=
Sebastien=0A=
________________________________________=0A=
From: Philippe Mathieu-Daud=E9 [philmd@redhat.com]=0A=
Sent: Monday, October 29, 2018 2:02 PM=0A=
To: Samuel Ortiz; qemu-devel@nongnu.org=0A=
Cc: Michael S. Tsirkin; Jing Liu; Boeuf, Sebastien; Paolo Bonzini; Igor Mam=
medov=0A=
Subject: Re: [Qemu-devel] [PATCH v3 16/19] hw: acpi: Retrieve the PCI bus f=
rom AcpiPciHpState=0A=
=0A=
On 29/10/18 18:01, Samuel Ortiz wrote:=0A=
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>=0A=
>=0A=
> Instead of using the machine type specific method find_i440fx() to=0A=
> retrieve the PCI bus, this commit aims to rely on the fact that the=0A=
> PCI bus is known by the structure AcpiPciHpState.=0A=
>=0A=
> When the structure is initialized through acpi_pcihp_init() call,=0A=
> it saves the PCI bus, which means there is no need to invoke a=0A=
> special function later on.=0A=
>=0A=
> Based on the fact that find_i440fx() was only used there, this=0A=
> patch also removes the function find_i440fx() itself from the=0A=
> entire codebase.=0A=
=0A=
Nice :)=0A=
=0A=
>=0A=
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>=0A=
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>=0A=
=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>=0A=
=0A=
> ---=0A=
>   hw/acpi/pcihp.c       | 10 ++++------=0A=
>   hw/pci-host/piix.c    |  8 --------=0A=
>   include/hw/i386/pc.h  |  1 -=0A=
>   stubs/Makefile.objs   |  1 -=0A=
>   stubs/pci-host-piix.c |  6 ------=0A=
>   5 files changed, 4 insertions(+), 22 deletions(-)=0A=
>   delete mode 100644 stubs/pci-host-piix.c=0A=
>=0A=
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c=0A=
> index 80d42e12ff..254b2e50ab 100644=0A=
> --- a/hw/acpi/pcihp.c=0A=
> +++ b/hw/acpi/pcihp.c=0A=
> @@ -93,10 +93,9 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)=
=0A=
>       return bsel_alloc;=0A=
>   }=0A=
>=0A=
> -static void acpi_set_pci_info(void)=0A=
> +static void acpi_set_pci_info(AcpiPciHpState *s)=0A=
>   {=0A=
>       static bool bsel_is_set;=0A=
> -    PCIBus *bus;=0A=
>       unsigned bsel_alloc =3D ACPI_PCIHP_BSEL_DEFAULT;=0A=
>=0A=
>       if (bsel_is_set) {=0A=
> @@ -104,10 +103,9 @@ static void acpi_set_pci_info(void)=0A=
>       }=0A=
>       bsel_is_set =3D true;=0A=
>=0A=
> -    bus =3D find_i440fx(); /* TODO: Q35 support */=0A=
> -    if (bus) {=0A=
> +    if (s->root) {=0A=
>           /* Scan all PCI buses. Set property to enable acpi based hotplu=
g. */=0A=
> -        pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_all=
oc);=0A=
> +        pci_for_each_bus_depth_first(s->root, acpi_set_bsel, NULL, &bsel=
_alloc);=0A=
>       }=0A=
>   }=0A=
>=0A=
> @@ -213,7 +211,7 @@ static void acpi_pcihp_update(AcpiPciHpState *s)=0A=
>=0A=
>   void acpi_pcihp_reset(AcpiPciHpState *s)=0A=
>   {=0A=
> -    acpi_set_pci_info();=0A=
> +    acpi_set_pci_info(s);=0A=
>       acpi_pcihp_update(s);=0A=
>   }=0A=
>=0A=
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c=0A=
> index da73743fa2..4940f59c9b 100644=0A=
> --- a/hw/pci-host/piix.c=0A=
> +++ b/hw/pci-host/piix.c=0A=
> @@ -445,14 +445,6 @@ PCIBus *i440fx_init(const char *host_type, const cha=
r *pci_type,=0A=
>       return b;=0A=
>   }=0A=
>=0A=
> -PCIBus *find_i440fx(void)=0A=
> -{=0A=
> -    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,=0A=
> -                                   object_resolve_path("/machine/i440fx"=
, NULL),=0A=
> -                                   TYPE_PCI_HOST_BRIDGE);=0A=
> -    return s ? s->bus : NULL;=0A=
> -}=0A=
> -=0A=
>   /* PIIX3 PCI to ISA bridge */=0A=
>   static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)=0A=
>   {=0A=
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h=0A=
> index 7d177cd207..f6b2649cf8 100644=0A=
> --- a/include/hw/i386/pc.h=0A=
> +++ b/include/hw/i386/pc.h=0A=
> @@ -260,7 +260,6 @@ PCIBus *i440fx_init(const char *host_type, const char=
 *pci_type,=0A=
>                       MemoryRegion *pci_memory,=0A=
>                       MemoryRegion *ram_memory);=0A=
>=0A=
> -PCIBus *find_i440fx(void);=0A=
>   /* piix4.c */=0A=
>   extern PCIDevice *piix4_dev;=0A=
>   int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);=0A=
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs=0A=
> index 5dd0aeeec6..725f78bedc 100644=0A=
> --- a/stubs/Makefile.objs=0A=
> +++ b/stubs/Makefile.objs=0A=
> @@ -41,6 +41,5 @@ stub-obj-y +=3D pc_madt_cpu_entry.o=0A=
>   stub-obj-y +=3D vmgenid.o=0A=
>   stub-obj-y +=3D xen-common.o=0A=
>   stub-obj-y +=3D xen-hvm.o=0A=
> -stub-obj-y +=3D pci-host-piix.o=0A=
>   stub-obj-y +=3D ram-block.o=0A=
>   stub-obj-y +=3D ramfb.o=0A=
> diff --git a/stubs/pci-host-piix.c b/stubs/pci-host-piix.c=0A=
> deleted file mode 100644=0A=
> index 6ed81b1f21..0000000000=0A=
> --- a/stubs/pci-host-piix.c=0A=
> +++ /dev/null=0A=
> @@ -1,6 +0,0 @@=0A=
> -#include "qemu/osdep.h"=0A=
> -#include "hw/i386/pc.h"=0A=
> -PCIBus *find_i440fx(void)=0A=
> -{=0A=
> -    return NULL;=0A=
> -}=0A=
>=0A=
