Received: from eggs.gnu.org ([2001:4830:134:3::10]:38333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gOlcr-0007Oo-Qx
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gOlcq-0001bR-Lb
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:38:13 -0500
Date: Mon, 19 Nov 2018 16:37:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181119163757.3c975f62@redhat.com>
In-Reply-To: <1542397323.18399.3.camel@intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-20-sameo@linux.intel.com>
	<20181116103909.64f35d5d@redhat.com>
	<1542397323.18399.3.camel@intel.com>
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
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "anthony.perard@citrix.com" <anthony.perard@citrix.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>, "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "rth@twiddle.net" <rth@twiddle.net>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

On Fri, 16 Nov 2018 19:42:08 +0000
"Boeuf, Sebastien" <sebastien.boeuf@intel.com> wrote:

> Hi Igor,
>=20
> On Fri, 2018-11-16 at 10:39 +0100, Igor Mammedov wrote:
> > On Mon,=C2=A0=C2=A05 Nov 2018 02:40:42 +0100
> > Samuel Ortiz <sameo@linux.intel.com> wrote:
> >  =20
> > >=20
> > > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > >=20
> > > Instead of using the machine type specific method find_i440fx() to
> > > retrieve the PCI bus, this commit aims to rely on the fact that the
> > > PCI bus is known by the structure AcpiPciHpState.
> > >=20
> > > When the structure is initialized through acpi_pcihp_init() call,
> > > it saves the PCI bus, which means there is no need to invoke a
> > > special function later on.
> > >=20
> > > Based on the fact that find_i440fx() was only used there, this
> > > patch also removes the function find_i440fx() itself from the
> > > entire codebase.
> > >=20
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > Signed-off-by: Jing Liu <jing2.liu@linux.intel.com> =20
> > Thanks for cleaning it up
> >=20
> > minor nit:
> > Taking in account that you're removing '/* TODO: Q35 support */'
> > comment along with find_i440fx(), it might be worth to mention
> > in this commit message. Something along lines that ACPI PCIHP
> > exist to support guests without SHPC support on PCI
> > based PC machine. Considering that Q35 provides native
> > PCI-E hotplug, there is no need to add ACPI hotplug there. =20
>=20
> Oh yes sure we can update the commit message :). But just wanted to
> mention that 'pc' machine type uses ACPI PCIHP and does support
> SHPC, so it's not mutually exclusive.
it supports both but is it relevant to this patch?

Point was that one shouldn't remove something silently without
any justification/explanation. So that readers that come later
wouldn't wonder about the reasons why the code was removed.
=20
> >=20
> > with commit message fixed
> >=20
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> >  =20
> > >=20
> > > ---
> > > =C2=A0include/hw/i386/pc.h=C2=A0=C2=A0|=C2=A0=C2=A01 -
> > > =C2=A0hw/acpi/pcihp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 10 +=
+++------
> > > =C2=A0hw/pci-host/piix.c=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A08 ------=
--
> > > =C2=A0stubs/pci-host-piix.c |=C2=A0=C2=A06 ------
> > > =C2=A0stubs/Makefile.objs=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A01 -
> > > =C2=A05 files changed, 4 insertions(+), 22 deletions(-)
> > > =C2=A0delete mode 100644 stubs/pci-host-piix.c
> > >=20
> > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > > index 44cb6bf3f3..8e5f1464eb 100644
> > > --- a/include/hw/i386/pc.h
> > > +++ b/include/hw/i386/pc.h
> > > @@ -255,7 +255,6 @@ PCIBus *i440fx_init(const char *host_type,
> > > const char *pci_type,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MemoryRegion *pci_=
memory,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MemoryRegion *ram_=
memory);
> > > =C2=A0
> > > -PCIBus *find_i440fx(void);
> > > =C2=A0/* piix4.c */
> > > =C2=A0extern PCIDevice *piix4_dev;
> > > =C2=A0int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
> > > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > > index 80d42e12ff..254b2e50ab 100644
> > > --- a/hw/acpi/pcihp.c
> > > +++ b/hw/acpi/pcihp.c
> > > @@ -93,10 +93,9 @@ static void *acpi_set_bsel(PCIBus *bus, void
> > > *opaque)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return bsel_alloc;
> > > =C2=A0}
> > > =C2=A0
> > > -static void acpi_set_pci_info(void)
> > > +static void acpi_set_pci_info(AcpiPciHpState *s)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0static bool bsel_is_set;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0PCIBus *bus;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned bsel_alloc =3D ACPI_PCIHP_BSEL=
_DEFAULT;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (bsel_is_set) {
> > > @@ -104,10 +103,9 @@ static void acpi_set_pci_info(void)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bsel_is_set =3D true;
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0bus =3D find_i440fx(); /* TODO: Q35 support =
*/
> > > -=C2=A0=C2=A0=C2=A0=C2=A0if (bus) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0if (s->root) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Scan all PCI=
 buses. Set property to enable acpi based
> > > hotplug. */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_for_each_bus_dep=
th_first(bus, acpi_set_bsel, NULL,
> > > &bsel_alloc);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_for_each_bus_dep=
th_first(s->root, acpi_set_bsel, NULL,
> > > &bsel_alloc);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0}
> > > =C2=A0
> > > @@ -213,7 +211,7 @@ static void acpi_pcihp_update(AcpiPciHpState
> > > *s)
> > > =C2=A0
> > > =C2=A0void acpi_pcihp_reset(AcpiPciHpState *s)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0acpi_set_pci_info();
> > > +=C2=A0=C2=A0=C2=A0=C2=A0acpi_set_pci_info(s);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_pcihp_update(s);
> > > =C2=A0}
> > > =C2=A0
> > > diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> > > index 47293a3915..658460264b 100644
> > > --- a/hw/pci-host/piix.c
> > > +++ b/hw/pci-host/piix.c
> > > @@ -445,14 +445,6 @@ PCIBus *i440fx_init(const char *host_type,
> > > const char *pci_type,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return b;
> > > =C2=A0}
> > > =C2=A0
> > > -PCIBus *find_i440fx(void)
> > > -{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0PCIHostState *s =3D OBJECT_CHECK(PCIHostStat=
e,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object=
_resolve_path("/machine/i
> > > 440fx", NULL),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TYPE_P=
CI_HOST_BRIDGE);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0return s ? s->bus : NULL;
> > > -}
> > > -
> > > =C2=A0/* PIIX3 PCI to ISA bridge */
> > > =C2=A0static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
> > > =C2=A0{
> > > diff --git a/stubs/pci-host-piix.c b/stubs/pci-host-piix.c
> > > deleted file mode 100644
> > > index 6ed81b1f21..0000000000
> > > --- a/stubs/pci-host-piix.c
> > > +++ /dev/null
> > > @@ -1,6 +0,0 @@
> > > -#include "qemu/osdep.h"
> > > -#include "hw/i386/pc.h"
> > > -PCIBus *find_i440fx(void)
> > > -{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > > -}
> > > diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> > > index 5dd0aeeec6..725f78bedc 100644
> > > --- a/stubs/Makefile.objs
> > > +++ b/stubs/Makefile.objs
> > > @@ -41,6 +41,5 @@ stub-obj-y +=3D pc_madt_cpu_entry.o
> > > =C2=A0stub-obj-y +=3D vmgenid.o
> > > =C2=A0stub-obj-y +=3D xen-common.o
> > > =C2=A0stub-obj-y +=3D xen-hvm.o
> > > -stub-obj-y +=3D pci-host-piix.o
> > > =C2=A0stub-obj-y +=3D ram-block.o
> > > =C2=A0stub-obj-y +=3D ramfb.o =20
>=20
> Thanks,
> Sebastien
