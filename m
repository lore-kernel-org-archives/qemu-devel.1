Received: from eggs.gnu.org ([2001:4830:134:3::10]:53929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dL9Ws-0004m0-Eq
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dL9Wo-00084F-Ee
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:44:18 -0400
Date: Wed, 14 Jun 2017 22:30:05 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170614143005.GA2614@umbus>
References: <149744692318.5507.14451686460325895979.stgit@bahia.lan>
	<149744695027.5507.7049830187351447969.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <149744695027.5507.7049830187351447969.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] xics: directly register ICPState
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
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 03:29:10PM +0200, Greg Kurz wrote:
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
> Please note that this doesn't break migration. Older machine types used to
> allocate and realize all ICPState objects at machine init time, for the w=
hole
> lifetime of the machine. The qdev instance ids are thus 0,1,2... nr_serve=
rs
> and happen to map to the vCPU indexes.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.10.

> ---
> v5: - explain why it doesn't break migration in the changelog
> ---
>  hw/intc/xics.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 7ccfb53c55a0..faa5c631f655 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -344,10 +344,14 @@ static void icp_realize(DeviceState *dev, Error **e=
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
> @@ -355,7 +359,6 @@ static void icp_class_init(ObjectClass *klass, void *=
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

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQUhrAAoJEGw4ysog2bOSZZkP/i8usS5ovOXp382CJ54fHTws
E9I6iu7oP8dY6PC/j2y/BJj8T9O5acQ014kT7IIHssMJW1lAV7+tOzRd0LOQsFTN
VzwZor71qhtvwE8h+X73BwHJwObLOpJGmwLgSs+ghsIzw6Qy7SGG40XWCjD7xqaP
ybnRrvCQgWok2Ee1IOpDYqLt8C43mvtOlr08+sf6qFzzEU7ebBfyAv2EJREu5yVU
l9TipCTg/ZP0P1xc2GynkpsZOwxFnQa8bUDU2plpMmALq4OsDXjMwcO9OkQHdCja
3SCVAXKZaxcC62FYT6EMNy4ehy+uIhlwLDF+UqSQpN0s6pLarwBSZMJyRB394PuG
wyYBnJ5aG8WsQxszgaZQ9RPE6Fa7sfqeanq14PBEG+4p1LGOTsGh0ZbnntzpUGG+
Hb/3JqAyAG7ZyirkxDQ3N6mLHLXl83z6rxrBBFMjNYx6nTj6tUcxU3XDxIdNLh/o
CHINSMTixz7ZF0KlkL7d7E72IUiXrGaXsKM0qYS9WA8DhRpkG+aiZ54EzHc/tnxr
ZC+2BSqH9r+eJk3eUoofWrMGXGz70tQc6eS2Djf7G8cawLbwNL5ENsVYDI7dbAjW
C2aWnIe8K3oq3HuKjU3fTPbpixs6qWyynwCPMbJGiUJhCKdZxAW3GXv+9dslikgp
T4SzL+gnRuRFWJYyVDLc
=k2Gu
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
