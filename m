Received: from eggs.gnu.org ([2001:4830:134:3::10]:41342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlJfv-0001ON-2V
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlJfu-0002ec-34
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:49:47 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <04916320-d8a4-80e2-d6b7-0fcd7b4a9cfa@redhat.com>
Date: Fri, 25 Aug 2017 13:49:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CPT59vQONXtDDJuUj0T5WCU9Oe57MdOb9"
Subject: Re: [Qemu-devel] [PATCH 07/17] block/nbd-client: refactor request
 send/receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CPT59vQONXtDDJuUj0T5WCU9Oe57MdOb9
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <04916320-d8a4-80e2-d6b7-0fcd7b4a9cfa@redhat.com>
Subject: Re: [PATCH 07/17] block/nbd-client: refactor request send/receive
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Move nbd_co_receive_reply and nbd_coroutine_end calls into
> nbd_co_send_request and rename the latter to just nbd_co_request.
>=20
> This removes code duplications in nbd_client_co_{pwrite,pread,...}
> functions. Also this is needed for further refactoring.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 89 ++++++++++++++++++++--------------------------=
--------
>  1 file changed, 33 insertions(+), 56 deletions(-)

The diffstat shows this is a nice improvement.
> +++ b/block/nbd-client.c
> @@ -112,12 +112,20 @@ static coroutine_fn void nbd_read_reply_entry(voi=
d *opaque)
>      s->read_reply_co =3D NULL;
>  }
> =20
> -static int nbd_co_send_request(BlockDriverState *bs,
> -                               NBDRequest *request,
> -                               QEMUIOVector *qiov)
> +static void nbd_co_receive_reply(NBDClientSession *s,
> +                                 NBDRequest *request,
> +                                 NBDReply *reply,
> +                                 QEMUIOVector *qiov);
> +static void nbd_coroutine_end(BlockDriverState *bs,
> +                              NBDRequest *request);

Is it possible to organize the functions in topological order so that we
don't need forward declarations of static functions?  (If there is
mutual recursion, you need the forward declaration; but other than that,
I like reading the building blocks first rather than skipping around)

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CPT59vQONXtDDJuUj0T5WCU9Oe57MdOb9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgcUAACgkQp6FrSiUn
Q2rLBAf9G7T/46KgSbK3CGOJlJc/kHnjfwYPiV0SaT2ofwOeV3vhQCOSvivi8F6N
3e1pzEBB2oWP+IGFYeQ+QtkxzvjR/mQ1a04cSxBKFpzxbJpHVVH/E2gggGpfAKDy
OxmIHvRblhfeVnEEcSzBYw7fUY7sl2B3U1pGMrS+R8HsdtCeUom0iTYeGS4p3Czz
b7mdaW5iXz9nfnQ1WZUkFpdHYimPQgK6W1i/yg+7a6b8HIQbeG2uQFMkb2IO5Ya8
APAXebhRcnJbskh8/D9AwY0+sY3YkvC3Je4FyFstBDk7vxBz4kJtsfSlf40r4TjK
DsMSAJxSbsrgcBI1RM58Zg3w6PUCJA==
=QTHR
-----END PGP SIGNATURE-----

--CPT59vQONXtDDJuUj0T5WCU9Oe57MdOb9--
