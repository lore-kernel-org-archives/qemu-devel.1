Received: from eggs.gnu.org ([2001:4830:134:3::10]:55985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daND7-0003rj-BM
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daND2-0000AC-EQ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:22:49 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:35287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1daND2-00009T-7m
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:22:44 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 84EE3113DC2
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 16:22:42 +0200 (CEST)
Date: Wed, 26 Jul 2017 16:22:33 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170726162233.792332e9@bahia.lan>
In-Reply-To: <20170726040629.GU8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100558414.27487.6550654617210440325.stgit@bahia>
	<20170726040629.GU8978@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/NSU/91o2CPOGYfm.JXrdk/o";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [for-2.11 PATCH 08/26] spapr_drc: add unrealize
 method to physical DRC class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

--Sig_/NSU/91o2CPOGYfm.JXrdk/o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2017 14:06:29 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jul 25, 2017 at 07:59:44PM +0200, Greg Kurz wrote:
> > When hot-unplugging a PHB, all its PCI DRC connectors get unrealized. T=
his
> > patch adds an unrealize method to the physical DRC class, in order to u=
ndo
> > registrations performed in realize_physical().
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Applied to ppc-for-2.11.  In a sense this is fix that could be applied
> to ppc-for-2.10, but unlike the last patch, AFAICT there's no way this
> bug can be triggered in the current code.
>=20

Correct. The current code won't unrealize DRCs.

> > ---
> >  hw/ppc/spapr_drc.c |   16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index d72453bcb42f..105ce85b6d04 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -626,12 +626,28 @@ static void realize_physical(DeviceState *d, Erro=
r **errp)
> >      qemu_register_reset(drc_physical_reset, drcp);
> >  }
> > =20
> > +static void unrealize_physical(DeviceState *d, Error **errp)
> > +{
> > +    sPAPRDRCPhysical *drcp =3D SPAPR_DRC_PHYSICAL(d);
> > +    Error *local_err =3D NULL;
> > +
> > +    unrealize(d, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    vmstate_unregister(DEVICE(drcp), &vmstate_spapr_drc_physical, drcp=
);
> > +    qemu_unregister_reset(drc_physical_reset, drcp);
> > +}
> > +
> >  static void spapr_drc_physical_class_init(ObjectClass *k, void *data)
> >  {
> >      DeviceClass *dk =3D DEVICE_CLASS(k);
> >      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> > =20
> >      dk->realize =3D realize_physical;
> > +    dk->unrealize =3D unrealize_physical;
> >      drck->dr_entity_sense =3D physical_entity_sense;
> >      drck->isolate =3D drc_isolate_physical;
> >      drck->unisolate =3D drc_unisolate_physical;
> >  =20
>=20


--Sig_/NSU/91o2CPOGYfm.JXrdk/o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll4pakACgkQAvw66wEB28KCMwCeLriK8XctCO4nnlrr/SBzwLlW
kikAn1QeZQPwSvVMVoJxF6TjdYs9168I
=z6bq
-----END PGP SIGNATURE-----

--Sig_/NSU/91o2CPOGYfm.JXrdk/o--
