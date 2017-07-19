Received: from eggs.gnu.org ([2001:4830:134:3::10]:37883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXglC-0008HS-V7
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXgl9-0002oX-OJ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:38:54 -0400
Date: Wed, 19 Jul 2017 14:34:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170719043442.GX3140@umbus.fritz.box>
References: <149910050540.26371.12575732020425703531.stgit@bahia.lan>
	<20170704072901.GA2180@umbus.fritz.box>
	<20170704104722.499d4e86@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4PR/+zdSfVlxyWed"
Content-Disposition: inline
In-Reply-To: <20170704104722.499d4e86@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: make default PHB optionnal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Andrea Bolognani <abologna@redhat.com>


--4PR/+zdSfVlxyWed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 10:47:22AM +0200, Greg Kurz wrote:
> On Tue, 4 Jul 2017 17:29:01 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, Jul 03, 2017 at 06:48:25PM +0200, Greg Kurz wrote:
> > > The sPAPR machine always create a default PHB during initialization, =
even
> > > if -nodefaults was passed on the command line. This forces the user to
> > > rely on -global if she wants to set properties of the default PHB, su=
ch
> > > as numa_node.
> > >=20
> > > This patch introduces a new machine create-default-phb property to co=
ntrol
> > > whether the default PHB must be created or not. It defaults to on in =
order
> > > to preserve old setups (which is also the motivation to not alter the
> > > current behavior of -nodefaults).
> > >=20
> > > If create-default-phb is set to off, the default PHB isn't created, n=
or
> > > any other device usually created with it. It is mandatory to provide
> > > a PHB on the command line to be able to use PCI devices (otherwise QE=
MU
> > > won't start). For example, the following creates a PHB with the same
> > > mappings as the default PHB and also sets the NUMA affinity:
> > >=20
> > >     -machine type=3Dpseries,create-default-phb=3Doff \
> > >     -numa node,nodeid=3D0 -device spapr-pci-host-bridge,index=3D0,num=
a_node=3D0
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > So, I agree that the distinction between default devices that are
> > disabled with -nodefaults and default devices that aren't is a big
> > mess in qemu configuration.  But on the other hand this only addresses
> > one tiny aspect of that, and in the meantime means we will silently
> > ignore some other configuration options in some conditions.
> >=20
> > So, what's the immediate benefit / use case for this?
> >=20
>=20
> With the current code base, the only way to set properties of the default
> PHB, is to pass -global spapr-pci-host-bridge.prop=3Dvalue for each prope=
rty.
> The immediate benefit of this patch is to unify the way libvirt passes
> PHB description to the command line:

I thought you could use -set to set things more explicitly.  But I'll
admit, I can never remember how the syntax of that works.
>=20
> ie, do:
>=20
>     -machine type=3Dpseries,create-default-phb=3Doff \
>     -device spapr-pci-host-bridge,prop1=3Da,prop2=3Db,prop3=3Dc \
>     -device spapr-pci-host-bridge,prop1=3Dd,prop2=3De,prop3=3Df
>=20
> instead of:
>=20
>     -machine type=3Dpseries \
>     -global spapr-pci-host-bridge.prop1=3Da \
>     -global spapr-pci-host-bridge.prop2=3Db \
>     -global spapr-pci-host-bridge.prop3=3Dc \
>     -device spapr-pci-host-bridge,prop1=3Dd,prop2=3De,prop3=3Df
>=20
> > > ---
> > >  hw/ppc/spapr.c         |   63 ++++++++++++++++++++++++++++++++++----=
----------
> > >  include/hw/ppc/spapr.h |    2 ++
> > >  2 files changed, 47 insertions(+), 18 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index ba8f57a5a054..3395bb3774b9 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2103,7 +2103,7 @@ static void ppc_spapr_init(MachineState *machin=
e)
> > >      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> > >      const char *kernel_filename =3D machine->kernel_filename;
> > >      const char *initrd_filename =3D machine->initrd_filename;
> > > -    PCIHostState *phb;
> > > +    PCIHostState *phb =3D NULL;
> > >      int i;
> > >      MemoryRegion *sysmem =3D get_system_memory();
> > >      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> > > @@ -2294,7 +2294,9 @@ static void ppc_spapr_init(MachineState *machin=
e)
> > >      /* Set up PCI */
> > >      spapr_pci_rtas_init();
> > > =20
> > > -    phb =3D spapr_create_phb(spapr, 0);
> > > +    if (spapr->create_default_phb) {
> > > +        phb =3D spapr_create_phb(spapr, 0);
> > > +    }
> > > =20
> > >      for (i =3D 0; i < nb_nics; i++) {
> > >          NICInfo *nd =3D &nd_table[i];
> > > @@ -2305,7 +2307,7 @@ static void ppc_spapr_init(MachineState *machin=
e)
> > > =20
> > >          if (strcmp(nd->model, "ibmveth") =3D=3D 0) {
> > >              spapr_vlan_create(spapr->vio_bus, nd);
> > > -        } else {
> > > +        } else if (phb) {
> > >              pci_nic_init_nofail(&nd_table[i], phb->bus, nd->model, N=
ULL);
> > >          }
> > >      }
> > > @@ -2314,24 +2316,26 @@ static void ppc_spapr_init(MachineState *mach=
ine)
> > >          spapr_vscsi_create(spapr->vio_bus);
> > >      }
> > > =20
> > > -    /* Graphics */
> > > -    if (spapr_vga_init(phb->bus, &error_fatal)) {
> > > -        spapr->has_graphics =3D true;
> > > -        machine->usb |=3D defaults_enabled() && !machine->usb_disabl=
ed;
> > > -    }
> > > -
> > > -    if (machine->usb) {
> > > -        if (smc->use_ohci_by_default) {
> > > -            pci_create_simple(phb->bus, -1, "pci-ohci");
> > > -        } else {
> > > -            pci_create_simple(phb->bus, -1, "nec-usb-xhci");
> > > +    if (phb) {
> > > +        /* Graphics */
> > > +        if (spapr_vga_init(phb->bus, &error_fatal)) {
> > > +            spapr->has_graphics =3D true;
> > > +            machine->usb |=3D defaults_enabled() && !machine->usb_di=
sabled;
> > >          }
> > > =20
> > > -        if (spapr->has_graphics) {
> > > -            USBBus *usb_bus =3D usb_bus_find(-1);
> > > +        if (machine->usb) {
> > > +            if (smc->use_ohci_by_default) {
> > > +                pci_create_simple(phb->bus, -1, "pci-ohci");
> > > +            } else {
> > > +                pci_create_simple(phb->bus, -1, "nec-usb-xhci");
> > > +            }
> > > +
> > > +            if (spapr->has_graphics) {
> > > +                USBBus *usb_bus =3D usb_bus_find(-1);
> > > =20
> > > -            usb_create_simple(usb_bus, "usb-kbd");
> > > -            usb_create_simple(usb_bus, "usb-mouse");
> > > +                usb_create_simple(usb_bus, "usb-kbd");
> > > +                usb_create_simple(usb_bus, "usb-mouse");
> > > +            }
> > >          }
> > >      }
> > > =20
> > > @@ -2544,12 +2548,27 @@ static void spapr_set_modern_hotplug_events(O=
bject *obj, bool value,
> > >      spapr->use_hotplug_event_source =3D value;
> > >  }
> > > =20
> > > +static bool spapr_get_create_default_phb(Object *obj, Error **errp)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > +
> > > +    return spapr->create_default_phb;
> > > +}
> > > +
> > > +static void spapr_set_create_default_phb(Object *obj, bool value, Er=
ror **errp)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > +
> > > +    spapr->create_default_phb =3D value;
> > > +}
> > > +
> > >  static void spapr_machine_initfn(Object *obj)
> > >  {
> > >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > =20
> > >      spapr->htab_fd =3D -1;
> > >      spapr->use_hotplug_event_source =3D true;
> > > +    spapr->create_default_phb =3D true;
> > >      object_property_add_str(obj, "kvm-type",
> > >                              spapr_get_kvm_type, spapr_set_kvm_type, =
NULL);
> > >      object_property_set_description(obj, "kvm-type",
> > > @@ -2568,6 +2587,14 @@ static void spapr_machine_initfn(Object *obj)
> > >      ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compa=
t_pvr,
> > >                              "Maximum permitted CPU compatibility mod=
e",
> > >                              &error_fatal);
> > > +
> > > +    object_property_add_bool(obj, "create-default-phb",
> > > +                            spapr_get_create_default_phb,
> > > +                            spapr_set_create_default_phb,
> > > +                            NULL);
> > > +    object_property_set_description(obj, "create-default-phb",
> > > +                                    "Create a default PCI Host Bridg=
e",
> > > +                                    NULL);
> > >  }
> > > =20
> > >  static void spapr_machine_finalizefn(Object *obj)
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index a184ffab0ebc..6ee914764807 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -93,6 +93,8 @@ struct sPAPRMachineState {
> > >      bool use_hotplug_event_source;
> > >      sPAPREventSource *event_sources;
> > > =20
> > > +    bool create_default_phb;
> > > +
> > >      /* ibm,client-architecture-support option negotiation */
> > >      bool cas_reboot;
> > >      bool cas_legacy_guest_workaround;
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4PR/+zdSfVlxyWed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllu4WIACgkQbDjKyiDZ
s5IZtQ/9H/v4RmYsUMp31aaiKUKI4X8JwygRGz5liOhgIWxczdMBSyXwm8gpbphn
FRtob3qqTbNoxhu1dlpxH2G056/YB78EL3RD7PWDQgj/FONOE3hYUgbp/2kXgj4f
456dAbpQGxadjRvbQjzKUhtiXaT2NASDkCeQVWO5Qq2INBJSngaeuYBg+PTtETVI
9sP0jBKD0LtsNDieE5urNQQ0aV0s0eVPtXq5OOhuTdK8COD5q9W8Q+0Qh/fk0Jj1
sFwdZu39TNSlVXbgyCzXuwA9PcvZ4mS4Uv4WRnmujXzZPE0r9IudZE2HCn3A1cuG
XldSH9FwEkIaGpkXSSRYh6ataFLqe3oAglsX8jdnHbA3Qq9CoPzFC6Akf+vFF5TG
w8mjB7HRo8aqh4T5c+W/mYOwEIx3V6FsVDTVwi4azshnwFmB+9wH/qTJDyvrsvBV
7t0Qi6y07Nq4WRaMXGjjwo9YAqxaKygmJpNxyA34WTHpgtmIIbhC/WMRPYHCWbpU
VFipsZNjez9TMftdSB63JOM4lGgy+nzX8tGN55JjwDZl9yNZ13+ageYZq3J7wVf3
xzxWCmjnAjn8OkZNj91zVcgLpG3fdkq8ZbErc8N0SUufzm21rIpFjmQi+qrlnzkw
H5IMmuPju3Mi8vlfFr3GEuToUf7AfgY9PChH7KAXrJT2LURtu6M=
=ivd0
-----END PGP SIGNATURE-----

--4PR/+zdSfVlxyWed--
