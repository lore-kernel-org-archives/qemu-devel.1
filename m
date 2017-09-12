Received: from eggs.gnu.org ([2001:4830:134:3::10]:35291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drcpS-0004fJ-Uk
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drcpP-0005O9-Qs
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:29:42 -0400
Date: Tue, 12 Sep 2017 14:01:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170912040104.GD2774@umbus.fritz.box>
References: <150516748034.6883.2205624415045931101.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <150516748034.6883.2205624415045931101.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] xics: fix several error leaks
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


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2017 at 12:04:40AM +0200, Greg Kurz wrote:
> If object_property_get_link() fails then it allocates an error, which
> must be freed before returning. The error_get_pretty() function is
> merely an accessor to the error message and doesn't free anything.
>=20
> The error.h header indicates how to do it right:
>=20
>  * Pass an existing error to the caller with the message modified:
>  *     error_propagate(errp, err);
>  *     error_prepend(errp, "Could not frobnicate '%s': ", name);
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
>  hw/intc/xics.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index a84ba51ad8ff..80c33be02e5e 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -306,8 +306,8 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
> =20
>      obj =3D object_property_get_link(OBJECT(dev), ICP_PROP_XICS, &err);
>      if (!obj) {
> -        error_setg(errp, "%s: required link '" ICP_PROP_XICS "' not foun=
d: %s",
> -                   __func__, error_get_pretty(err));
> +        error_propagate(errp, err);
> +        error_prepend(errp, "required link '" ICP_PROP_XICS "' not found=
: ");
>          return;
>      }
> =20
> @@ -315,8 +315,8 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
> =20
>      obj =3D object_property_get_link(OBJECT(dev), ICP_PROP_CPU, &err);
>      if (!obj) {
> -        error_setg(errp, "%s: required link '" ICP_PROP_CPU "' not found=
: %s",
> -                   __func__, error_get_pretty(err));
> +        error_propagate(errp, err);
> +        error_prepend(errp, "required link '" ICP_PROP_CPU "' not found:=
 ");
>          return;
>      }
> =20
> @@ -641,8 +641,8 @@ static void ics_base_realize(DeviceState *dev, Error =
**errp)
> =20
>      obj =3D object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &err);
>      if (!obj) {
> -        error_setg(errp, "%s: required link '" ICS_PROP_XICS "' not foun=
d: %s",
> -                   __func__, error_get_pretty(err));
> +        error_propagate(errp, err);
> +        error_prepend(errp, "required link '" ICS_PROP_XICS "' not found=
: ");
>          return;
>      }
>      ics->xics =3D XICS_FABRIC(obj);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm3XAAACgkQbDjKyiDZ
s5LgaA/7BDYQh3Yg+trtjeF5oogQXrUEP9A8TYpmQ1pxOvEvl0tI0O/2mJJYtYny
zw4eLlgxaOH+8VGOkAMZoeH11D+GNPqQQwwnuj/eV3JdY6g9jkJYvlNXVCmj8xh+
7kBADl5VRtfJPTa6cqp+pg6bZ3rr69lVSzX+9WykFdnD/Ew+/Nbl+qZYM7+n09qw
OjjXraSFpRn4ozAJHahjXKLNAx1hJeHras5cj4alG11PwARH+eckk3p0aJ/xxwgJ
9PHEu768gGTYQcEnVJUYyA8fQqhk6g3FgqaVUuHC5n3+6gl25HzjDp3rAp/lfbwI
FwkvQmrFh2TpvqdEw+6LavXh08ZXHCjiPuL2f1yRQiv8FgLkBhes+g3MHM/Oo+3D
RysJFwP5xKbeYnFlIgwEeDZNLxvDKuFBoMbnbAM3F+1maeYL9cL9TBbznxClTm8K
t/U2Z4FvOIOeaTjZlna6AQXDzFRyvaHb6wzIuad9lcQ7ALRKHTLf1O6Odja97ytU
BJGDp01inEfGJ2u3QG5hJ+pt9dV9R56EUXsk24R9FmhKI3OVcYaw4/VCCvjzs8oV
j8IHL2BxcPOiQCn52LITJKFe40p0qjvYuJ4NsD2I0FSeZVTjDWCcFqapnPMckLhx
chV3+pWwbPCKR1O3UmN8NsqdmLZTNu2XBT8736gUEBm5SUcxhMQ=
=dqHZ
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
