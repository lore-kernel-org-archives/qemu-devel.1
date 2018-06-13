Received: from eggs.gnu.org ([2001:4830:134:3::10]:42387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2Y9-0005GI-1y
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2Y5-0008RW-TY
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:58:45 -0400
Date: Wed, 13 Jun 2018 19:53:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613095329.GG30690@umbus.fritz.box>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-3-david@gibson.dropbear.id.au>
	<20180613110939.28d30cf0@bahia.lab.toulouse-stg.fr.ibm.com>
	<e69b80c7-8334-cf7a-5b23-85c5e6c3517b@kaod.org>
	<20180613114207.32431053@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X0vpKvTpCy87tk9a"
Content-Disposition: inline
In-Reply-To: <20180613114207.32431053@bahia.lab.toulouse-stg.fr.ibm.com>
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


--X0vpKvTpCy87tk9a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 11:42:07AM +0200, Greg Kurz wrote:
> On Wed, 13 Jun 2018 11:14:57 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > >> index 13ad7d9e04..efb68226bb 100644
> > >> --- a/hw/ppc/pnv_core.c
> > >> +++ b/hw/ppc/pnv_core.c
> > >> @@ -173,6 +173,9 @@ static void pnv_core_realize(DeviceState *dev, E=
rror **errp)
> > >> =20
> > >>          snprintf(name, sizeof(name), "thread[%d]", i);
> > >>          object_property_add_child(OBJECT(pc), name, obj, &local_err=
);
> > >> +        if (local_err) {
> > >> +            goto err;
> > >> +        }
> > >>          object_property_add_alias(obj, "core-pir", OBJECT(pc),
> > >>                                    "pir", &local_err);
> > >>          if (local_err) { =20
> > >=20
> > > Hmm... the current error path seems to assume failures to be
> > > caused by object_property_add_child(). It hence unparents the
> > > previously parented CPUs, but not the current one. So we'll
> > > miss one call to object_unparent() if object_property_add_alias()
> > > fails. =20
> >=20
> > yes, let's just put NULL or &error_abort instead.
> >=20
>=20
> NULL means we really don't care if the call fails or succeeds.
>=20
> &error_abort means we consider a failure to be a unrecoverable bug.
>=20
> So I would rather pass &error_abort here.
>=20
> But if the guest is already running and functional, and we hit
> the error during hotplug, does the guest really deserve to be
> aborted or should we just fail the hotplug ?

Ah, dammit, that's why it wasn't an abort in the first place.  Yeah,
we'd better propagate the errors.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X0vpKvTpCy87tk9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsg6ZkACgkQbDjKyiDZ
s5IUaRAAuUsMp5VVmWrsR+PEtdL7LoKfOEVp7M5FzuUJHfZbSqr6ZcaOmBezBMzy
NEU7e5lKrxP+2ZA4YPwii4sijMdvoOuIsmtHAb7qp752ogdfKfQ4EOXfqHdxKcxp
MaBvMJxlkBZexBYsMhS8RK6Qg/ZjhUisW3k0ZSoQ3DGq04WofRtrLDQ6U4ENExQ4
B6pnd87AFPoF+EUCQgPAmoVAb0meq0G8R+yWQoDS2Xje0OouTMTIcbIdiCfVwzsT
8x9kr9os9Ecti7q4ZQoOdMQ750vCktmf8hSo4+WbB+sX+BnqRUwkwKwXe9ZZMiBS
9PwCaINGpbkrMzHDPhBi2v/OsjOfWrt2vbdRkb+Q/TNbRibCchdgSVHduRjRUZ9m
0tvpNy6VqkaXAxX4EGrM9swZowgkkpQlUB+w56y7rj0qR1+7lwzwvz8DMNeu0Me9
LQN4PE7mBhRNgJ+e0f70IIcpVte+fwQrPdV3EsIsOwKD4JSKWTuijTv7wsDqWwDF
XnyQgNu5/f9PS8I+LHbK3QuZWGl3XYAoA5xTpmvkZiYHHZHg8M0vsCbTXJLR4H6P
3UsZ/SOZmteXcaYNH4aFl6WLk1a8e/NdJruYgBKsGITIaAxwm+Xi/m1qj8+58Aqu
O/eXIbWei2ERjGfAjaz0ZSc2YfGA0Ps9dqcvt2ZuDVQXN+LqFlU=
=2Uyt
-----END PGP SIGNATURE-----

--X0vpKvTpCy87tk9a--
