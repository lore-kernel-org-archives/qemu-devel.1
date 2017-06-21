Received: from eggs.gnu.org ([2001:4830:134:3::10]:41662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNbr7-0006uk-6Z
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNbr3-0003xn-VB
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:23:21 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:53532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNbr3-0003uG-MW
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:23:17 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 26327108643
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 11:23:16 +0200 (CEST)
Date: Wed, 21 Jun 2017 11:23:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170621112308.692ac0d4@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <149798664805.10485.16662705281385907661@loki>
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
	<20170620015332.13874-4-david@gibson.dropbear.id.au>
	<20170620185145.2673e759@bahia.lab.toulouse-stg.fr.ibm.com>
	<149798664805.10485.16662705281385907661@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_//h8AR_SB36gMyFP1rKUzkx5";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/5] spapr: Add DRC release method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, bharata@linux.vnet.ibm.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_//h8AR_SB36gMyFP1rKUzkx5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jun 2017 14:24:08 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Greg Kurz (2017-06-20 11:51:45)
> > On Tue, 20 Jun 2017 09:53:30 +0800
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > At the moment, spapr_drc_release() has an ugly switch on the DRC type=
 to
> > > call the right, device-specific release function.  This cleans it up =
by
> > > doing that via a proper QOM method.
> > >=20
> > > It's still arguably an abstraction violation for the DRC code to call=
 into
> > > the specific device code, but one mess at a time.
> > >  =20
> >=20
> > Maybe a second step would be to move DRC subclasses to spapr.c (CPU, LM=
B) and
> > spapr_pci.c (PCI) ? This would allow each device-specific release funct=
ion to
> > have local scope at least. =20
>=20
> I kind of prefer the proposed approach of registering a callback
> function via drc_new(). This would make it easier to implement
> unit tests without needing to rely on stub functions, and keeps the
> type-specific handling constrained to matters relating to the DRC
> itself and not the resources associated with them.
>=20

Yeah, this could work too and it would address David's concern about
abstraction violation in a clean way.

> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >  =20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/ppc/spapr_drc.c         | 22 ++++++----------------
> > >  include/hw/ppc/spapr_drc.h |  1 +
> > >  2 files changed, 7 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > index e5dff16..32e39f2 100644
> > > --- a/hw/ppc/spapr_drc.c
> > > +++ b/hw/ppc/spapr_drc.c
> > > @@ -370,22 +370,9 @@ void spapr_drc_attach(sPAPRDRConnector *drc, Dev=
iceState *d, void *fdt,
> > > =20
> > >  static void spapr_drc_release(sPAPRDRConnector *drc)
> > >  {
> > > -    /* Calling release callbacks based on spapr_drc_type(drc). */
> > > -    switch (spapr_drc_type(drc)) {
> > > -    case SPAPR_DR_CONNECTOR_TYPE_CPU:
> > > -        spapr_core_release(drc->dev);
> > > -        break;
> > > -    case SPAPR_DR_CONNECTOR_TYPE_PCI:
> > > -        spapr_phb_remove_pci_device_cb(drc->dev);
> > > -        break;
> > > -    case SPAPR_DR_CONNECTOR_TYPE_LMB:
> > > -        spapr_lmb_release(drc->dev);
> > > -        break;
> > > -    case SPAPR_DR_CONNECTOR_TYPE_PHB:
> > > -    case SPAPR_DR_CONNECTOR_TYPE_VIO:
> > > -    default:
> > > -        g_assert(false);
> > > -    }
> > > +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc=
);
> > > +
> > > +    drck->release(drc->dev);
> > > =20
> > >      drc->awaiting_release =3D false;
> > >      g_free(drc->fdt);
> > > @@ -629,6 +616,7 @@ static void spapr_drc_cpu_class_init(ObjectClass =
*k, void *data)
> > >      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_CPU;
> > >      drck->typename =3D "CPU";
> > >      drck->drc_name_prefix =3D "CPU ";
> > > +    drck->release =3D spapr_core_release;
> > >  }
> > > =20
> > >  static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
> > > @@ -638,6 +626,7 @@ static void spapr_drc_pci_class_init(ObjectClass =
*k, void *data)
> > >      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI;
> > >      drck->typename =3D "28";
> > >      drck->drc_name_prefix =3D "C";
> > > +    drck->release =3D spapr_phb_remove_pci_device_cb;
> > >  }
> > > =20
> > >  static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
> > > @@ -647,6 +636,7 @@ static void spapr_drc_lmb_class_init(ObjectClass =
*k, void *data)
> > >      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB;
> > >      drck->typename =3D "MEM";
> > >      drck->drc_name_prefix =3D "LMB ";
> > > +    drck->release =3D spapr_lmb_release;
> > >  }
> > > =20
> > >  static const TypeInfo spapr_dr_connector_info =3D {
> > > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > > index d9cacb3..6fd84d1 100644
> > > --- a/include/hw/ppc/spapr_drc.h
> > > +++ b/include/hw/ppc/spapr_drc.h
> > > @@ -217,6 +217,7 @@ typedef struct sPAPRDRConnectorClass {
> > >      sPAPRDREntitySense (*dr_entity_sense)(sPAPRDRConnector *drc);
> > >      uint32_t (*isolate)(sPAPRDRConnector *drc);
> > >      uint32_t (*unisolate)(sPAPRDRConnector *drc);
> > > +    void (*release)(DeviceState *dev);
> > > =20
> > >      /* QEMU interfaces for managing hotplug operations */
> > >      bool (*release_pending)(sPAPRDRConnector *drc); =20
> >  =20
>=20


--Sig_//h8AR_SB36gMyFP1rKUzkx5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllKOvwACgkQAvw66wEB28Kw+ACdE3y0aj5Fv6QXUPWWQBPPFS/7
01AAmwedQ+/FB1jgw6qjaIxLoZWfvZ2c
=e48C
-----END PGP SIGNATURE-----

--Sig_//h8AR_SB36gMyFP1rKUzkx5--
