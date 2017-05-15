Received: from eggs.gnu.org ([2001:4830:134:3::10]:48983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAEli-0001aQ-Na
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAElf-0006YB-J0
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:06:30 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:60019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAElf-0006Xz-CG
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:06:27 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id DEB641FD04
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 14:06:25 +0200 (CEST)
Date: Mon, 15 May 2017 14:06:18 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170515140618.22fad5fe@bahia>
In-Reply-To: <e962c484-f89f-8623-d66e-8a904e814359@kaod.org>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484838558.20089.5029926585755792842.stgit@bahia.lan>
	<e962c484-f89f-8623-d66e-8a904e814359@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/P0l61P2K_MV3qQUayII4MPp";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 4/6] spapr: sanitize error handling in
 spapr_ics_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/P0l61P2K_MV3qQUayII4MPp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 May 2017 13:59:33 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 05/15/2017 01:39 PM, Greg Kurz wrote:
> > The spapr_ics_create() function handles errors in a rather convoluted
> > way, with two local Error * variables. Moreover, failing to parent the
> > ICS object to the machine should be considered as a bug but it is
> > currently ignored. =20
>=20
> I am not sure what should be done for object_property_add_child()
> errors but QEMU generally uses NULL for 'Error **'. It might be=20
> wrong though.
>=20
> As for the local error handling, it is following what is described in=20
> qapi/error.h. Isn't it ?
>=20

Yes, it does follow the "Receive and accumulate multiple errors" recommanda=
tion,
but does it make sense to realize the ICS object if we failed to set nr-irq=
s ?

> Cheers,
>=20
> C.=20
>=20
> =20
> > This patch addresses both issues.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c |   19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 44f7dc7f40e9..c53989bb10b1 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -101,21 +101,26 @@ static ICSState *spapr_ics_create(sPAPRMachineSta=
te *spapr,
> >                                    const char *type_ics,
> >                                    int nr_irqs, Error **errp)
> >  {
> > -    Error *err =3D NULL, *local_err =3D NULL;
> > +    Error *local_err =3D NULL;
> >      Object *obj;
> > =20
> >      obj =3D object_new(type_ics);
> > -    object_property_add_child(OBJECT(spapr), "ics", obj, NULL);
> > +    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
> >      object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_=
abort);
> > -    object_property_set_int(obj, nr_irqs, "nr-irqs", &err);
> > +    object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
> > +    if (local_err) {
> > +        goto error;
> > +    }
> >      object_property_set_bool(obj, true, "realized", &local_err);
> > -    error_propagate(&err, local_err);
> > -    if (err) {
> > -        error_propagate(errp, err);
> > -        return NULL;
> > +    if (local_err) {
> > +        goto error;
> >      }
> > =20
> >      return ICS_SIMPLE(obj);
> > +
> > +error:
> > +    error_propagate(errp, local_err);
> > +    return NULL;
> >  }
> > =20
> >  static void xics_system_init(MachineState *machine, int nr_irqs, Error=
 **errp)
> >  =20
>=20


--Sig_/P0l61P2K_MV3qQUayII4MPp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkZmboACgkQAvw66wEB28JLVQCfbd2NvS+g4KmF/sJJnnf2lDyN
0YUAoKAEVApkuzm/XHxfY3RwTqKDE7HL
=DDuu
-----END PGP SIGNATURE-----

--Sig_/P0l61P2K_MV3qQUayII4MPp--
