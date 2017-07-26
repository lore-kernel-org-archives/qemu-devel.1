Received: from eggs.gnu.org ([2001:4830:134:3::10]:53499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daI6X-0008A4-VA
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daI6T-0002PD-26
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:55:42 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:52918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1daI6S-0002MZ-NR
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:55:36 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id E8BB6116B88
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 10:55:34 +0200 (CEST)
Date: Wed, 26 Jul 2017 10:55:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170726105524.11b41267@bahia.lan>
In-Reply-To: <f278e478-83a7-0842-5cfb-f0582aec3b5d@ozlabs.ru>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100549536.27487.11322702271540744350.stgit@bahia>
	<f278e478-83a7-0842-5cfb-f0582aec3b5d@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/35MNZ./myC_PQKsrrrN8PIM";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [for-2.11 PATCH 01/26] spapr: move
 spapr_create_phb() to core machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/35MNZ./myC_PQKsrrrN8PIM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2017 13:32:41 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 26/07/17 03:58, Greg Kurz wrote:
> > This function is only used when creating the default PHB. Let's rename
> > it and move it to the core machine code for clarity.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c              |   13 ++++++++++++-
> >  hw/ppc/spapr_pci.c          |   11 -----------
> >  include/hw/pci-host/spapr.h |    2 --
> >  3 files changed, 12 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 2a3e53d5d58c..53969315ac24 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2142,6 +2142,17 @@ static void spapr_init_cpus(sPAPRMachineState *s=
papr)
> >      g_free(type);
> >  }
> > =20
> > +static PCIHostState *spapr_create_default_phb(sPAPRMachineState *spapr=
) =20
>=20
>=20
> Nit: you could get rid of the *spapr here.
>=20

Heh you're right, I'll do that in the next spin.

> Anyway,
>=20
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
>=20
>=20
> > +{
> > +    DeviceState *dev;
> > +
> > +    dev =3D qdev_create(NULL, TYPE_SPAPR_PCI_HOST_BRIDGE);
> > +    qdev_prop_set_uint32(dev, "index", 0);
> > +    qdev_init_nofail(dev);
> > +
> > +    return PCI_HOST_BRIDGE(dev);
> > +}
> > +
> >  /* pSeries LPAR / sPAPR hardware init */
> >  static void ppc_spapr_init(MachineState *machine)
> >  {
> > @@ -2374,7 +2385,7 @@ static void ppc_spapr_init(MachineState *machine)
> >      /* Set up PCI */
> >      spapr_pci_rtas_init();
> > =20
> > -    phb =3D spapr_create_phb(spapr, 0);
> > +    phb =3D spapr_create_default_phb(spapr);
> > =20
> >      for (i =3D 0; i < nb_nics; i++) {
> >          NICInfo *nd =3D &nd_table[i];
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index d84abf1070a0..70a99a032267 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1982,17 +1982,6 @@ static const TypeInfo spapr_phb_info =3D {
> >      }
> >  };
> > =20
> > -PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index)
> > -{
> > -    DeviceState *dev;
> > -
> > -    dev =3D qdev_create(NULL, TYPE_SPAPR_PCI_HOST_BRIDGE);
> > -    qdev_prop_set_uint32(dev, "index", index);
> > -    qdev_init_nofail(dev);
> > -
> > -    return PCI_HOST_BRIDGE(dev);
> > -}
> > -
> >  typedef struct sPAPRFDT {
> >      void *fdt;
> >      int node_off;
> > diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> > index 38470b2f0e5c..5a4e9686d562 100644
> > --- a/include/hw/pci-host/spapr.h
> > +++ b/include/hw/pci-host/spapr.h
> > @@ -111,8 +111,6 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sP=
APRPHBState *phb, int pin)
> >      return xics_get_qirq(XICS_FABRIC(spapr), phb->lsi_table[pin].irq);
> >  }
> > =20
> > -PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index);
> > -
> >  int spapr_populate_pci_dt(sPAPRPHBState *phb,
> >                            uint32_t xics_phandle,
> >                            void *fdt);
> >=20
> >  =20
>=20
>=20


--Sig_/35MNZ./myC_PQKsrrrN8PIM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll4WPwACgkQAvw66wEB28J1hgCdE60KmzljLjY86OuWr7GK0z4Y
9QYAn0CtqB9zjZTyCjENr+vn86IKGLFM
=dXe7
-----END PGP SIGNATURE-----

--Sig_/35MNZ./myC_PQKsrrrN8PIM--
