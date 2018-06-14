Received: from eggs.gnu.org ([2001:4830:134:3::10]:45319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTGeJ-0000xq-NF
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTGeG-0000NL-0c
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:02:03 -0400
Date: Thu, 14 Jun 2018 11:01:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614010143.GQ30690@umbus.fritz.box>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-3-david@gibson.dropbear.id.au>
	<20180613110939.28d30cf0@bahia.lab.toulouse-stg.fr.ibm.com>
	<e69b80c7-8334-cf7a-5b23-85c5e6c3517b@kaod.org>
	<20180613114207.32431053@bahia.lab.toulouse-stg.fr.ibm.com>
	<20180613095329.GG30690@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pMRnfHSWYEVtk438"
Content-Disposition: inline
In-Reply-To: <20180613095329.GG30690@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 2/7] pnv: Add missing error check during
 cpu realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--pMRnfHSWYEVtk438
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 07:53:29PM +1000, David Gibson wrote:
> On Wed, Jun 13, 2018 at 11:42:07AM +0200, Greg Kurz wrote:
> > On Wed, 13 Jun 2018 11:14:57 +0200
> > C=E9dric Le Goater <clg@kaod.org> wrote:
> >=20
> > > >> index 13ad7d9e04..efb68226bb 100644
> > > >> --- a/hw/ppc/pnv_core.c
> > > >> +++ b/hw/ppc/pnv_core.c
> > > >> @@ -173,6 +173,9 @@ static void pnv_core_realize(DeviceState *dev,=
 Error **errp)
> > > >> =20
> > > >>          snprintf(name, sizeof(name), "thread[%d]", i);
> > > >>          object_property_add_child(OBJECT(pc), name, obj, &local_e=
rr);
> > > >> +        if (local_err) {
> > > >> +            goto err;
> > > >> +        }
> > > >>          object_property_add_alias(obj, "core-pir", OBJECT(pc),
> > > >>                                    "pir", &local_err);
> > > >>          if (local_err) { =20
> > > >=20
> > > > Hmm... the current error path seems to assume failures to be
> > > > caused by object_property_add_child(). It hence unparents the
> > > > previously parented CPUs, but not the current one. So we'll
> > > > miss one call to object_unparent() if object_property_add_alias()
> > > > fails. =20
> > >=20
> > > yes, let's just put NULL or &error_abort instead.
> > >=20
> >=20
> > NULL means we really don't care if the call fails or succeeds.
> >=20
> > &error_abort means we consider a failure to be a unrecoverable bug.
> >=20
> > So I would rather pass &error_abort here.
> >=20
> > But if the guest is already running and functional, and we hit
> > the error during hotplug, does the guest really deserve to be
> > aborted or should we just fail the hotplug ?
>=20
> Ah, dammit, that's why it wasn't an abort in the first place.  Yeah,
> we'd better propagate the errors.

No.. thinking about this yet again, we should be ok with error_abort.
These really aren't things that should fail.  If they do something has
gone so horribly wrong, that I think an abort() is a reasonable
reaction, even on hotplug.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pMRnfHSWYEVtk438
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlshvnUACgkQbDjKyiDZ
s5LPZxAA4XuSi5+Ixqoo6bcGyYo1NNaHqy/bqXNBe3HRpN4HLS1IVwqvd9x4Ltvv
wXgOVV75OYOx/9UEyNce8/IN/f5T/OF3r3WjNnswxd+A+KzSC7NwmRqyTgUYK2V+
0SYgtQYHDxeEsI46n/ZRjzRUJH6owPXTwKmHfsAyTeEDZn8MWAr/K5IAh8joXWvw
PZS9U5Mtcw6Dqb9khS4Swa/tv6QYzySXpXv1zlBMwVAjkxSakcndAuWMlMpoCRqA
TJQ5knSZ85REuh6aivUksQ+MuDWD/x5aQnx9gLwtr18nwDWgG1JXXwPaIsOitVE8
jQmJoG7TPKKoErKIkBi3mYU42XT47hKMPC3sNboha17Vuv587mEjPk0fxkiwmruY
nEWWTq7DEfzaBQgCIgUC1iKJ3OyS8EYOIcQNpKRZRHa9Hm8Ogw24yrGsWUgHMZ1a
Akajy0QdaEgQONIef+/VA67LvRBHO1a2WgjsiVW9ZS++VpA/lVNXQcs/T9lb+ewB
tTgLbC0Y73ngS2In3fyYVq9O7zq9v5B/ymNOzcCpy8woaU2ukRg05/ro0v0UTAgx
CrCGRtqCSAWOPjjyDvSuV/eNLXoWv2obdcPwANn1m7kkh3dCP32ONaOQvUAIllBP
StkPWRlRV9Yu9dnpYPTC4QhMDi4C/kt7WARqYDZc9a1T4YMA3UI=
=ywVw
-----END PGP SIGNATURE-----

--pMRnfHSWYEVtk438--
