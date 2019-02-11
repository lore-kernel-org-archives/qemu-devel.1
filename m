Received: from eggs.gnu.org ([209.51.188.92]:45840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtJfy-0001FT-GS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 17:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtJfp-0003T2-Qc
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 17:03:35 -0500
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
	<20190211125601.86533-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dcf92fc1-21d9-ea3b-5267-6c76f747cbc0@redhat.com>
Date: Mon, 11 Feb 2019 16:02:42 -0600
MIME-Version: 1.0
In-Reply-To: <20190211125601.86533-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JJFlNLFuT1NesO4624NDF1e5G2lGgrckY"
Subject: Re: [Qemu-devel] [PATCH 4/4] block/nbd-client: use non-blocking io
 channel for nbd negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JJFlNLFuT1NesO4624NDF1e5G2lGgrckY
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <dcf92fc1-21d9-ea3b-5267-6c76f747cbc0@redhat.com>
Subject: Re: [PATCH 4/4] block/nbd-client: use non-blocking io channel for nbd
 negotiation
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
 <20190211125601.86533-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190211125601.86533-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 6:56 AM, Vladimir Sementsov-Ogievskiy wrote:
> Now negotiation is done in coroutine, so to take benefit of it let's
> use non-blocking model.
>=20
> Note that QIOChannel handle synchronous io calls correctly anyway, so

s/handle/handles/

> it's not a problem to send final NBD_CMD_DISC to non-blocking channel
> but using sync qio interface, even not in coroutine.

s/not in/when not in a/

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

This fixes qemu as NBD client for use in block devices, but what about
qemu as NBD client in qemu-nbd?  Does that need any updates?  Then
again, your observation about QIO doing the right thing for both
blocking (qemu-nbd) and non-blocking (block layer) channels seems to
cover that.

> @@ -1072,9 +1072,6 @@ static int nbd_client_connect(BlockDriverState *b=
s,
>          object_ref(OBJECT(client->ioc));
>      }
> =20
> -    /* Now that we're connected, set the socket to be non-blocking and=

> -     * kick the reply mechanism.  */
> -    qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
>      client->connection_co =3D qemu_coroutine_create(nbd_connection_ent=
ry, client);
>      nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
> =20
> @@ -1083,9 +1080,8 @@ static int nbd_client_connect(BlockDriverState *b=
s,
> =20
>   fail:
>      /*
> -     * We have connected, but must fail for other reasons. The
> -     * connection is still blocking; send NBD_CMD_DISC as a courtesy
> -     * to the server.
> +     * We have connected, but must fail for other reasons.
> +     * Send NBD_CMD_DISC as a courtesy to the server.
>       */
>      {
>          NBDRequest request =3D { .type =3D NBD_CMD_DISC };
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--JJFlNLFuT1NesO4624NDF1e5G2lGgrckY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxh8QIACgkQp6FrSiUn
Q2p0Kwf7BW6Y9RGUGz8uLjGVqfuJD/mnkg1HjKnromfJbMts5g+lpOxQx9xIqPnx
UmQekzczEavQ8UOPWJ2jr++yMPQx+30MOI6qIWMsbv2PVumzCd64NSdHQZJEbKBL
D3oVRKMr63FXK9nto+CnMzAHtATuTG9apZD7gfhrJ2Tsmj0qGIHz/q+MD/ttqTqE
ZwTu6lhHXc7GZ5ik4y83aVgovozsbK/1YNYc516+HWppVTzEeNlnvakILhkUjFvP
+SgxfHVfi4cQUGXF2EfRhAH3x302imrZmextiNu+Kn5rMyYuPfyZDhYqEs6nYVDT
t9xExspTyM3cJzwdWQ5aQLwJ/O6xuw==
=cnPq
-----END PGP SIGNATURE-----

--JJFlNLFuT1NesO4624NDF1e5G2lGgrckY--
