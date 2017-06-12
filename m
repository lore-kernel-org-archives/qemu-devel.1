Received: from eggs.gnu.org ([2001:4830:134:3::10]:48911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKQEO-0002zo-9M
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKQEK-0004tJ-6w
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:22:12 -0400
Date: Mon, 12 Jun 2017 22:15:46 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170612141546.GH18542@umbus>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692939833.12119.5229563110691809599.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <149692939833.12119.5229563110691809599.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v4 5/6] xics: directly register ICPState
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


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 03:43:18PM +0200, Greg Kurz wrote:
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

This is certainly an improvement.  You answered my query on the
previous version as to why this doesn't break migration, but that
information should go into the commit message.

So, ideally, we would use the XICS "server number" as the migration
key.  That's an architected part of the XICs state, since those values
are entered explicitly into the ICS.  We have a way to go from server
number to ICP at the moment, but not the reverse, but we can fix that.

Unfortunately I think those won't always match existing automatically
generated IDs, which makes things harder.

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

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPqIQAAoJEGw4ysog2bOSNNsP/iZ5d65DdnMKM5AtVUhrQWfS
vnpF5gP/oo3Y3kEX4/kLuvxJKqFYbUvfliFW3VShWoeO58/IKNgkujLHK7bY1fPU
B5OYQEsdFgo36OkhFeoGGXqLrHhbS5e/mKxNi0a/VqpGmRT5b6QS9FDdm5LtNSCw
09qP+rwul2oVq1zUEFbLjA3CQJQSRUPbWnV5OMkwtpHB8MjtppZIWSTVd/gW2CxF
VKXm+46LQ5HxsenSAAnotFAxcH8Al/Eucc+7dqWOK5SMMzHjocau8IjidbhWkW7h
pLVqOPFgAgQGDu/oBKSogzXxfNuOfRbflmElTlkoHA9bLP8jZDqX6eheT1ruTYNL
oIBECxCQjBJaystwCP+E9FJhu5L9bxlUgtOX60xmMuIoAB6hEVlwfnEs+ZQhN3Vd
R6qNAY4QTcXBDNeFaqvqYEUwlA6947zI5zzg1uXuM59zlUHAyLmRnb8jaVxpEGZE
hhVG16dTlVZbz/p/GpKg2CWmN1dTTcgq/HRz8+xgcqBLeOXO8fneCtJ9GgeWzzu3
fzoX/3s88Ij1BlgHyGZBm/q8JQed0/mla8VicsXOf7Nv9l8LeMjkgJaJz6zlOF2D
gvajbVh3zLSshCEacUNZ6mNGHp+NDMh517kR/MpAvO6qQiewuLf7s8amCFlJXWu4
cIk9rcsQMDTQtMOWkiCZ
=7SOE
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
