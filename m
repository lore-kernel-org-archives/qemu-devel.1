Received: from eggs.gnu.org ([2001:4830:134:3::10]:56574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ds7E2-000731-96
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ds7Dz-0006ne-3T
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:57:06 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:49905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ds7Dy-0006m3-PQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:57:03 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 4E59CABCA9
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 14:57:01 +0200 (CEST)
Date: Wed, 13 Sep 2017 14:56:51 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170913145651.4032fb99@bahia.lan>
In-Reply-To: <20170913122329.GB3972@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100571083.27487.4628655387393519076.stgit@bahia>
	<20170728034925.GF3098@umbus.fritz.box>
	<20170728123035.70cdd434@bahia.lan>
	<20170731025825.GC2652@umbus.fritz.box>
	<20170906133209.0a497a2c@bahia>
	<20170913122329.GB3972@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/0RAI+Iz0dG=/slfbKztcTtC";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 18/26] spapr: create DR
 connectors for PHBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

--Sig_/0RAI+Iz0dG=/slfbKztcTtC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Sep 2017 22:23:29 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

[...snip...]
> > > > Also, if all PHBs are instanciated with index !=3D -1, we're limite=
d to 31.
> > > > Maybe this could be the default value for the machine property inst=
ead of
> > > > 256 then ?   =20
> > >=20
> > > Actually, if we're binding it back to index, which has a hard limit,
> > > then it no longer makes sense to have it as a property and we should
> > > go back to a constant (well, it could vary by machine type version). =
=20
>=20
> Sorry I've taken so long to reply.
>=20

Oh, don't mention it. :)

> > But I guess that the hard limit of 31 as described in the changelog of
> > commit 357d1e3bc7d2d80e5271bc4f3ac8537e30dc8046 still holds, doesn't
> > it ? =20
>=20
> That's right.  Note that that is a limit of *31* PHBs (numbered
> 0..30), not 32 PHBs numbered 0..31.
>=20

Yeah I saw that.

> >     Because some guest versions (including most current distro kernels)=
 can't
> >     access PCI MMIO above 64 TiB, we put all the PCI windows between 32=
 TiB and
> >     64 TiB.  This is broken into 1 TiB chunks.  The first 1 TiB contain=
s the
> >     PIO (64 kiB) and 32-bit MMIO (2 GiB) windows for all of the PHBs.  =
Each
> >     subsequent TiB chunk contains a naturally aligned 64-bit MMIO windo=
w for
> >     one PHB each.
> >    =20
> >     This reduces the number of allowed PHBs (without full manual config=
uration
> >     of all the windows) from 256 to 31, but this should still be plenty=
 in
> >     practice.
> >=20
> > Not sure why a machine type version would have a different limit. Can
> > you think of a use case ? =20
>=20
> Well, the older machine types had a different layout.  It allowed for
> more indexes, but had smaller windows, which meant certain cards (e.g.
> GPGPUs with huge BARs) didn't work properly.  It also had some weird
> alignments that meant we were a bit wasteful of address space.
>=20
> But we can't change the location of PHB windows on migration, so we
> had to maintain that old layout for old machine types.  That's why
> there's a different limit depending on machine type version.
>=20

Ok, so we *just* have 2 different maximum number of PHBs:
- 256 for pseries <=3D 2.7
- 31 for newer machine types

I sent a RFC patch last monday:

https://lists.nongnu.org/archive/html/qemu-ppc/2017-09/msg00203.html

> >  =20
> > > > > >  static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
> > > > > >                                    const char *type_ics,
> > > > > >                                    int nr_irqs, Error **errp)
> > > > > > @@ -2384,6 +2387,18 @@ static void ppc_spapr_init(MachineState =
*machine)
> > > > > > =20
> > > > > >      spapr->dr_phb_enabled =3D smc->dr_phb_enabled;
> > > > > > =20
> > > > > > +    /* Setup hotplug / dynamic-reconfiguration connectors. top=
-level
> > > > > > +     * connectors (described in root DT node's "ibm,drc-types"=
 property)
> > > > > > +     * are pre-initialized here. additional child connectors (=
such as
> > > > > > +     * connectors for a PHBs PCI slots) are added as needed du=
ring their
> > > > > > +     * parent's realization.
> > > > > > +     */
> > > > > > +    if (spapr->dr_phb_enabled) {
> > > > > > +        for (i =3D 0; i < SPAPR_DRC_MAX_PHB; i++) {
> > > > > > +            spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR=
_DRC_PHB, i);
> > > > > > +        }
> > > > > > +    }
> > > > > > +
> > > > > >      /* Set up PCI */
> > > > > >      spapr_pci_rtas_init();
> > > > > > =20
> > > > > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > > > > index eb8024d37c54..2e1049ce61c7 100644
> > > > > > --- a/hw/ppc/spapr_drc.c
> > > > > > +++ b/hw/ppc/spapr_drc.c
> > > > > > @@ -697,6 +697,15 @@ static void spapr_drc_lmb_class_init(Objec=
tClass *k, void *data)
> > > > > >      drck->release =3D spapr_lmb_release;
> > > > > >  }
> > > > > > =20
> > > > > > +static void spapr_drc_phb_class_init(ObjectClass *k, void *dat=
a)
> > > > > > +{
> > > > > > +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k=
);
> > > > > > +
> > > > > > +    drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
> > > > > > +    drck->typename =3D "PHB";
> > > > > > +    drck->drc_name_prefix =3D "PHB ";
> > > > > > +}
> > > > > > +
> > > > > >  static const TypeInfo spapr_dr_connector_info =3D {
> > > > > >      .name          =3D TYPE_SPAPR_DR_CONNECTOR,
> > > > > >      .parent        =3D TYPE_DEVICE,
> > > > > > @@ -740,6 +749,13 @@ static const TypeInfo spapr_drc_lmb_info =
=3D {
> > > > > >      .class_init    =3D spapr_drc_lmb_class_init,
> > > > > >  };
> > > > > > =20
> > > > > > +static const TypeInfo spapr_drc_phb_info =3D {
> > > > > > +    .name          =3D TYPE_SPAPR_DRC_PHB,
> > > > > > +    .parent        =3D TYPE_SPAPR_DRC_LOGICAL,     =20
> > > > >=20
> > > > > I thought PHB DRCs were physical..
> > > > >    =20
> > > >=20
> > > > My understanding is that only PCI IOAs need a physical DRC.
> > > >=20
> > > > From LoPAPR v1.1 (March 24, 2016):
> > > >=20
> > > > 13.7 Logical Resource Dynamic Reconfiguration (LRDR)
> > > >=20
> > > > The Logical Resource Dynamic Reconfiguration option allows a platfo=
rm to make available and recover platform re-
> > > > sources such as CPUs, Memory Regions, Processor Host Bridges, and I=
/O slots to/from its operating OS image(s).
> > > >=20
> > > > ...
> > > >=20
> > > > The device tree contains logical resource DR connectors for the max=
imum number of resources that the platform can
> > > > allocate to the specific OS. In some cases such as for processors a=
nd PHBs...
> > > >=20
> > > > and
> > > >=20
> > > > Table 240. Currently Defined DR Connector Types
> > > >=20
> > > > | PHB | Logical PCI Host Bridge |   =20
> > >=20
> > > Ah, my mistake.
> > >  =20
> > > >    =20
> > > > > > +    .instance_size =3D sizeof(sPAPRDRConnector),
> > > > > > +    .class_init    =3D spapr_drc_phb_class_init,
> > > > > > +};
> > > > > > +
> > > > > >  /* helper functions for external users */
> > > > > > =20
> > > > > >  sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
> > > > > > @@ -1179,6 +1195,7 @@ static void spapr_drc_register_types(void)
> > > > > >      type_register_static(&spapr_drc_cpu_info);
> > > > > >      type_register_static(&spapr_drc_pci_info);
> > > > > >      type_register_static(&spapr_drc_lmb_info);
> > > > > > +    type_register_static(&spapr_drc_phb_info);
> > > > > > =20
> > > > > >      spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
> > > > > >                          rtas_set_indicator);
> > > > > > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_=
drc.h
> > > > > > index a7958d0a8d14..535fc61b98a8 100644
> > > > > > --- a/include/hw/ppc/spapr_drc.h
> > > > > > +++ b/include/hw/ppc/spapr_drc.h
> > > > > > @@ -69,6 +69,14 @@
> > > > > >  #define SPAPR_DRC_LMB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj=
), \
> > > > > >                                          TYPE_SPAPR_DRC_LMB)
> > > > > > =20
> > > > > > +#define TYPE_SPAPR_DRC_PHB "spapr-drc-phb"
> > > > > > +#define SPAPR_DRC_PHB_GET_CLASS(obj) \
> > > > > > +        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAP=
R_DRC_PHB)
> > > > > > +#define SPAPR_DRC_PHB_CLASS(klass) \
> > > > > > +        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_=
SPAPR_DRC_PHB)
> > > > > > +#define SPAPR_DRC_PHB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj=
), \
> > > > > > +                                        TYPE_SPAPR_DRC_PHB)
> > > > > > +
> > > > > >  /*
> > > > > >   * Various hotplug types managed by sPAPRDRConnector
> > > > > >   *
> > > > > >      =20
> > > > >    =20
> > > >    =20
> > >=20
> > >=20
> > >  =20
> >  =20
>=20
>=20
>=20


--Sig_/0RAI+Iz0dG=/slfbKztcTtC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbkrEwAKCRAC/DrrAQHb
wp+eAJ4nEgNIvJv1LocC1Vz3+wvdW9+wBQCgjpndX1ZDFCAjeTtGnX+RlwKhnL0=
=lNzi
-----END PGP SIGNATURE-----

--Sig_/0RAI+Iz0dG=/slfbKztcTtC--
