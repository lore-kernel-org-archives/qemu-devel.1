Received: from eggs.gnu.org ([2001:4830:134:3::10]:42972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSJUd-00072P-BU
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSJUa-00007J-6l
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:47:35 -0400
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:52695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dSJUZ-00005i-Tb
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:47:32 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 6E0A681BD6
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 10:47:30 +0200 (CEST)
Date: Tue, 4 Jul 2017 10:47:22 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170704104722.499d4e86@bahia.lan>
In-Reply-To: <20170704072901.GA2180@umbus.fritz.box>
References: <149910050540.26371.12575732020425703531.stgit@bahia.lan>
	<20170704072901.GA2180@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/g8qx0M7/OKZO2oZNR_nBd2f";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr: make default PHB optionnal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Andrea Bolognani <abologna@redhat.com>

--Sig_/g8qx0M7/OKZO2oZNR_nBd2f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Jul 2017 17:29:01 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Jul 03, 2017 at 06:48:25PM +0200, Greg Kurz wrote:
> > The sPAPR machine always create a default PHB during initialization, ev=
en
> > if -nodefaults was passed on the command line. This forces the user to
> > rely on -global if she wants to set properties of the default PHB, such
> > as numa_node.
> >=20
> > This patch introduces a new machine create-default-phb property to cont=
rol
> > whether the default PHB must be created or not. It defaults to on in or=
der
> > to preserve old setups (which is also the motivation to not alter the
> > current behavior of -nodefaults).
> >=20
> > If create-default-phb is set to off, the default PHB isn't created, nor
> > any other device usually created with it. It is mandatory to provide
> > a PHB on the command line to be able to use PCI devices (otherwise QEMU
> > won't start). For example, the following creates a PHB with the same
> > mappings as the default PHB and also sets the NUMA affinity:
> >=20
> >     -machine type=3Dpseries,create-default-phb=3Doff \
> >     -numa node,nodeid=3D0 -device spapr-pci-host-bridge,index=3D0,numa_=
node=3D0
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> So, I agree that the distinction between default devices that are
> disabled with -nodefaults and default devices that aren't is a big
> mess in qemu configuration.  But on the other hand this only addresses
> one tiny aspect of that, and in the meantime means we will silently
> ignore some other configuration options in some conditions.
>=20
> So, what's the immediate benefit / use case for this?
>=20

With the current code base, the only way to set properties of the default
PHB, is to pass -global spapr-pci-host-bridge.prop=3Dvalue for each propert=
y.
The immediate benefit of this patch is to unify the way libvirt passes
PHB description to the command line:

ie, do:

    -machine type=3Dpseries,create-default-phb=3Doff \
    -device spapr-pci-host-bridge,prop1=3Da,prop2=3Db,prop3=3Dc \
    -device spapr-pci-host-bridge,prop1=3Dd,prop2=3De,prop3=3Df

instead of:

    -machine type=3Dpseries \
    -global spapr-pci-host-bridge.prop1=3Da \
    -global spapr-pci-host-bridge.prop2=3Db \
    -global spapr-pci-host-bridge.prop3=3Dc \
    -device spapr-pci-host-bridge,prop1=3Dd,prop2=3De,prop3=3Df

> > ---
> >  hw/ppc/spapr.c         |   63 ++++++++++++++++++++++++++++++++++------=
--------
> >  include/hw/ppc/spapr.h |    2 ++
> >  2 files changed, 47 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index ba8f57a5a054..3395bb3774b9 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2103,7 +2103,7 @@ static void ppc_spapr_init(MachineState *machine)
> >      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> >      const char *kernel_filename =3D machine->kernel_filename;
> >      const char *initrd_filename =3D machine->initrd_filename;
> > -    PCIHostState *phb;
> > +    PCIHostState *phb =3D NULL;
> >      int i;
> >      MemoryRegion *sysmem =3D get_system_memory();
> >      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> > @@ -2294,7 +2294,9 @@ static void ppc_spapr_init(MachineState *machine)
> >      /* Set up PCI */
> >      spapr_pci_rtas_init();
> > =20
> > -    phb =3D spapr_create_phb(spapr, 0);
> > +    if (spapr->create_default_phb) {
> > +        phb =3D spapr_create_phb(spapr, 0);
> > +    }
> > =20
> >      for (i =3D 0; i < nb_nics; i++) {
> >          NICInfo *nd =3D &nd_table[i];
> > @@ -2305,7 +2307,7 @@ static void ppc_spapr_init(MachineState *machine)
> > =20
> >          if (strcmp(nd->model, "ibmveth") =3D=3D 0) {
> >              spapr_vlan_create(spapr->vio_bus, nd);
> > -        } else {
> > +        } else if (phb) {
> >              pci_nic_init_nofail(&nd_table[i], phb->bus, nd->model, NUL=
L);
> >          }
> >      }
> > @@ -2314,24 +2316,26 @@ static void ppc_spapr_init(MachineState *machin=
e)
> >          spapr_vscsi_create(spapr->vio_bus);
> >      }
> > =20
> > -    /* Graphics */
> > -    if (spapr_vga_init(phb->bus, &error_fatal)) {
> > -        spapr->has_graphics =3D true;
> > -        machine->usb |=3D defaults_enabled() && !machine->usb_disabled;
> > -    }
> > -
> > -    if (machine->usb) {
> > -        if (smc->use_ohci_by_default) {
> > -            pci_create_simple(phb->bus, -1, "pci-ohci");
> > -        } else {
> > -            pci_create_simple(phb->bus, -1, "nec-usb-xhci");
> > +    if (phb) {
> > +        /* Graphics */
> > +        if (spapr_vga_init(phb->bus, &error_fatal)) {
> > +            spapr->has_graphics =3D true;
> > +            machine->usb |=3D defaults_enabled() && !machine->usb_disa=
bled;
> >          }
> > =20
> > -        if (spapr->has_graphics) {
> > -            USBBus *usb_bus =3D usb_bus_find(-1);
> > +        if (machine->usb) {
> > +            if (smc->use_ohci_by_default) {
> > +                pci_create_simple(phb->bus, -1, "pci-ohci");
> > +            } else {
> > +                pci_create_simple(phb->bus, -1, "nec-usb-xhci");
> > +            }
> > +
> > +            if (spapr->has_graphics) {
> > +                USBBus *usb_bus =3D usb_bus_find(-1);
> > =20
> > -            usb_create_simple(usb_bus, "usb-kbd");
> > -            usb_create_simple(usb_bus, "usb-mouse");
> > +                usb_create_simple(usb_bus, "usb-kbd");
> > +                usb_create_simple(usb_bus, "usb-mouse");
> > +            }
> >          }
> >      }
> > =20
> > @@ -2544,12 +2548,27 @@ static void spapr_set_modern_hotplug_events(Obj=
ect *obj, bool value,
> >      spapr->use_hotplug_event_source =3D value;
> >  }
> > =20
> > +static bool spapr_get_create_default_phb(Object *obj, Error **errp)
> > +{
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +
> > +    return spapr->create_default_phb;
> > +}
> > +
> > +static void spapr_set_create_default_phb(Object *obj, bool value, Erro=
r **errp)
> > +{
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +
> > +    spapr->create_default_phb =3D value;
> > +}
> > +
> >  static void spapr_machine_initfn(Object *obj)
> >  {
> >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > =20
> >      spapr->htab_fd =3D -1;
> >      spapr->use_hotplug_event_source =3D true;
> > +    spapr->create_default_phb =3D true;
> >      object_property_add_str(obj, "kvm-type",
> >                              spapr_get_kvm_type, spapr_set_kvm_type, NU=
LL);
> >      object_property_set_description(obj, "kvm-type",
> > @@ -2568,6 +2587,14 @@ static void spapr_machine_initfn(Object *obj)
> >      ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compat_=
pvr,
> >                              "Maximum permitted CPU compatibility mode",
> >                              &error_fatal);
> > +
> > +    object_property_add_bool(obj, "create-default-phb",
> > +                            spapr_get_create_default_phb,
> > +                            spapr_set_create_default_phb,
> > +                            NULL);
> > +    object_property_set_description(obj, "create-default-phb",
> > +                                    "Create a default PCI Host Bridge",
> > +                                    NULL);
> >  }
> > =20
> >  static void spapr_machine_finalizefn(Object *obj)
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index a184ffab0ebc..6ee914764807 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -93,6 +93,8 @@ struct sPAPRMachineState {
> >      bool use_hotplug_event_source;
> >      sPAPREventSource *event_sources;
> > =20
> > +    bool create_default_phb;
> > +
> >      /* ibm,client-architecture-support option negotiation */
> >      bool cas_reboot;
> >      bool cas_legacy_guest_workaround;
> >  =20
>=20


--Sig_/g8qx0M7/OKZO2oZNR_nBd2f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllbVhoACgkQAvw66wEB28L2AQCfVFJjn1bIxBEcKkxKczAt3q4Z
DEgAoIjyx/OhS/G96lMVStJsV0PA/klo
=Obdc
-----END PGP SIGNATURE-----

--Sig_/g8qx0M7/OKZO2oZNR_nBd2f--
