Received: from eggs.gnu.org ([2001:4830:134:3::10]:36648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du4ee-0004WX-1F
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du4ec-0000YR-SB
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:36:40 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f9ffc3d-02e1-fde8-67ac-0f62101f1204@redhat.com>
Date: Mon, 18 Sep 2017 17:36:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170918135935.255591-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Jx6KapD52Nik5VQ9veWRvHHxUvrRPPUOn"
Subject: Re: [Qemu-devel] [PATCH v2 7/7] block/nbd-client: do not yield from
 nbd_read_reply_entry
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
--Jx6KapD52Nik5VQ9veWRvHHxUvrRPPUOn
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <0f9ffc3d-02e1-fde8-67ac-0f62101f1204@redhat.com>
Subject: Re: [PATCH v2 7/7] block/nbd-client: do not yield from
 nbd_read_reply_entry
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
 <20170918135935.255591-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170918135935.255591-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 08:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> Refactor nbd client to not yield from nbd_read_reply_entry. It's
> possible now as all reading is done in nbd_read_reply_entry and
> all request-related data is stored in per-request s->requests[i].
>=20
> We need here some additional work with s->requests[i].ret and
> s->quit to not fail requests on normal disconnet and to not report
> reading errors on normal disconnect.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)

The diffstat may have merit, but I'm wondering:

>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index f80a4c5564..bf20d5d5e6 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -79,7 +79,11 @@ static coroutine_fn void nbd_read_reply_entry(void *=
opaque)
>      while (!s->quit) {
>          ret =3D nbd_receive_reply(s->ioc, &reply, &local_err);
>          if (ret < 0) {
> -            error_report_err(local_err);
> +            if (s->quit) {
> +                error_free(local_err);

This discards errors on all remaining coroutines after we detect an
early exit. Are we sure the coroutine that set s->quit will have
reported an appropriate error, and thus explaining why we can discard
all secondary errors?  A comment in the code would be helpful.

> +            } else {
> +                error_report_err(local_err);
> +            }
>          }

> @@ -210,7 +204,7 @@ static int nbd_co_receive_reply(NBDClientSession *s=
, NBDRequest *request)
>      s->requests[i].receiving =3D true;
>      qemu_coroutine_yield();
>      s->requests[i].receiving =3D false;
> -    if (!s->ioc || s->quit) {
> +    if (!s->ioc) {
>          ret =3D -EIO;

Why don't we need to check s->quit any more?  That was just added
earlier in the series; why the churn?

>      } else {
>          ret =3D s->requests[i].ret;
> @@ -218,11 +212,6 @@ static int nbd_co_receive_reply(NBDClientSession *=
s, NBDRequest *request)
> =20
>      s->requests[i].coroutine =3D NULL;
> =20
> -    /* Kick the read_reply_co to get the next reply.  */
> -    if (s->read_reply_co) {
> -        aio_co_wake(s->read_reply_co);
> -    }
> -
>      qemu_co_mutex_lock(&s->send_mutex);
>      s->in_flight--;
>      qemu_co_queue_next(&s->free_sema);
> @@ -364,6 +353,8 @@ void nbd_client_close(BlockDriverState *bs)
> =20
>      nbd_send_request(client->ioc, &request);
> =20
> +    client->quit =3D true;

Previously, client->quit was only set when detecting a broken server,
now it is also set for a clean exit.  Do we need to change any
documentation of the field?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Jx6KapD52Nik5VQ9veWRvHHxUvrRPPUOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnASm4ACgkQp6FrSiUn
Q2rRRAgAm+/XYlkCV/vwu9h0uethlpFRgAnkj62QBKfs9xKnDUNLb3DOiW0u/m0u
mFlBQFeqUrOor+t8JymJnzPPRBLg3NujyFJjMMtxVmtCAkPu1WOQQtEJ/tMs6rOa
PQu9UnQ/TEjkUTeFSZb0WikaywgDoRCaLse/irpQ4dvUPmkJbLlGtZSPA/D3aIoN
Obqnaqn9arF6VNVd+xitXvnFGMZusv9IZdlFSrrV5FeaFybyPCwrfr75bwCkRWr/
9qblmLityYxlKiC6NnRBFIml44Yg4Sz7TdaVrLkPetxAC4bWJ3BZPXyw+qvAuFHM
avctTCDO+uNDU3udpoXWGIm4x3k0OQ==
=ploP
-----END PGP SIGNATURE-----

--Jx6KapD52Nik5VQ9veWRvHHxUvrRPPUOn--
