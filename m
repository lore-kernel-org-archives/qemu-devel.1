Received: from eggs.gnu.org ([2001:4830:134:3::10]:56933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIol0-000513-GE
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIokx-0004tT-7H
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:09:14 -0400
Date: Thu, 8 Jun 2017 13:59:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608035921.GU13397@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685583778.12025.272004316108066026.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AUHDRRu7c4EIRU83"
Content-Disposition: inline
In-Reply-To: <149685583778.12025.272004316108066026.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3 4/5] xics: directly register ICPState
 objects to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--AUHDRRu7c4EIRU83
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 07:17:17PM +0200, Greg Kurz wrote:
> The ICPState objects are currently registered to vmstate as qdev objects.
> Their instance ids are hence computed automatically in the migration code,
> and thus depends on the order the CPU cores were plugged.
>=20
> If the destination had its CPU cores plugged in a different order than the
> source, then ICPState objects will have different instance_ids and load
> the wrong state.
>=20
> Since CPU objects have a reliable cpu_index which is already used as
> instance_id in vmstate, let's use it for ICPState as well.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xics.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

So, this is definitely a good idea w.r.t. future compatibility.  But,
won't it break migration compat as a once off, since the devices will
be found under their new id instead of the qdev id?

>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 330441ff7fe8..3d76b43876c5 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -348,10 +348,14 @@ static void icp_realize(DeviceState *dev, Error **e=
rrp)
>      }
> =20
>      qemu_register_reset(icp_reset, dev);
> +    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
>  }
> =20
>  static void icp_unrealize(DeviceState *dev, Error **errp)
>  {
> +    ICPState *icp =3D ICP(dev);
> +
> +    vmstate_unregister(NULL, &vmstate_icp_server, icp);
>      qemu_unregister_reset(icp_reset, dev);
>  }
> =20
> @@ -359,7 +363,6 @@ static void icp_class_init(ObjectClass *klass, void *=
data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    dc->vmsd =3D &vmstate_icp_server;
>      dc->realize =3D icp_realize;
>      dc->unrealize =3D icp_unrealize;
>  }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AUHDRRu7c4EIRU83
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOMuXAAoJEGw4ysog2bOSAbIP/33naInd9ViiI3uFPaOVS3n6
tzo3kYBDNJZXCqrcDtljV7GrPRb+ueREV6aBavycmZPoemoAvqVipdJkKX33REN6
62E1Tc6yf7GP5ddCbdm6pBmQ1Hsy4ugsnRg8W8w4TSZuAUfWRMUEcjnaLxUt+wDN
SqAM/WNRbyaZvbUlzPfR6k7yYQCbZTQWNOnZCPI3MLpTyokpADx2JSpUkzdXulCN
0ZS/y6LeOq3EtqZbS/nf0Sz7X0E+vdGJFk0LeyJBe0GqPPE60QiLky4c3dfSwslo
bygkLSDG3NCeojwFepWv9ahmKulWLNxNGjR5U8/MJi/+29pxNIUx3Bp6Lqf27ChM
riScDKB53I2SGOXrFGDx6BDK3whk4NFqrc9LUw9vQvbgM/mBPKFBhH4r2Lruzup1
/Ya0B5enxq7qowEvCVlrrxQQKaCjWr0Z9QhmT31ZlSLOhWZrQeKcqt67j4P/OSbv
642pD6UYPZmY1zeotPiBY2DTdHH8dPEdtwFWuF7rp9bbILyKw3shznubW9hQVvOj
xDdsCAgi/SGjttk35CD94uOpDJqiVdbphZQQ+XWlDXuvbZZ9kQKPbysg0sm6KfZc
3tNZOZR/Ey9nUzBMXtMSZ+fa5bgotWhJykzxCyQGjVsbx/biDXLyrYR1xL9bVTuv
onBVb2m9g6l/pSPeEpXF
=rmbm
-----END PGP SIGNATURE-----

--AUHDRRu7c4EIRU83--
