Received: from eggs.gnu.org ([2001:4830:134:3::10]:36879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du23j-0006GP-9G
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 15:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du23i-0005vT-Bn
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 15:50:23 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <31b5ba0a-9041-7cbc-625c-e12905e56169@redhat.com>
Date: Mon, 18 Sep 2017 14:50:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170918135935.255591-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nc3Ata7phFTOMtCQ5O7Qu2ivBs48hwIWd"
Subject: Re: [Qemu-devel] [PATCH v2 2/7] block/nbd-client: exit
 reply-reading coroutine on incorrect handle
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
--nc3Ata7phFTOMtCQ5O7Qu2ivBs48hwIWd
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <31b5ba0a-9041-7cbc-625c-e12905e56169@redhat.com>
Subject: Re: [PATCH v2 2/7] block/nbd-client: exit reply-reading coroutine on
 incorrect handle
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
 <20170918135935.255591-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170918135935.255591-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 08:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> Check reply-handle =3D=3D request-handle in the same place, where
> recv coroutine number is calculated from reply->handle and it's
> correctness checked - in nbd_read_reply_entry.
>=20
> Also finish nbd_read_reply_entry in case of reply-handle !=3D
> request-handle in the same way as in case of incorrect reply-handle.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.h | 1 +
>  block/nbd-client.c | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

On second thought:

> +++ b/block/nbd-client.c
> @@ -92,7 +92,9 @@ static coroutine_fn void nbd_read_reply_entry(void *o=
paque)
>          i =3D HANDLE_TO_INDEX(s, s->reply.handle);
>          if (i >=3D MAX_NBD_REQUESTS ||
>              !s->requests[i].coroutine ||
> -            !s->requests[i].receiving) {
> +            !s->requests[i].receiving ||
> +            s->reply.handle !=3D s->requests[i].request->handle)

How can this condition ever be false?  s->reply.handle only ever
contains two values: 0 when it is being reused for the next iteration of
the loop, or the (munged) address of the request pointer.  But we are
careful that we never write s->reply.handle =3D 0 until after
s->requests[i].receiving is false.  So we will never see s->reply.handle
equal to 0 here.  (It may have been possible prior to the introduction
of reply.receiving, in commit 40f4a218, but I'm not seeing it now)

If I'm right, then this patch can be simplified - we don't need to track
s.requests[i].request, and can merely:

> @@ -189,9 +192,10 @@ static int nbd_co_receive_reply(NBDClientSession *=
s,
>      s->requests[i].receiving =3D true;
>      qemu_coroutine_yield();
>      s->requests[i].receiving =3D false;
> -    if (s->reply.handle !=3D request->handle || !s->ioc || s->quit) {

shorten this conditional to remove the now-dead condition.

> +    if (!s->ioc || s->quit) {
>          ret =3D -EIO;
>      } else {
> +        assert(s->reply.handle =3D=3D request->handle);
>          ret =3D -s->reply.error;
>          if (qiov && s->reply.error =3D=3D 0) {
>              assert(request->len =3D=3D iov_size(qiov->iov, qiov->niov)=
);
>=20

[Oh, and I just noticed HANDLE_TO_INDEX() and INDEX_TO_HANDLE() are
improperly parenthesized, although to no ill effect with current clients]=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nc3Ata7phFTOMtCQ5O7Qu2ivBs48hwIWd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnAI3UACgkQp6FrSiUn
Q2q7FAgAsLg0XWpSqnoozP9rGjsBDFAWo/09lGdjioA+KkBz3fVA7iz0mirLElZv
KBcCyncscdlUy7+fYMpmtfLcghUlEFK/cUKbYWU/rgwpLlPtqRXoDuUH+J9wkchz
QGisaQw/y2GXgcyLoQ8GiG0cS4PqDOd5SNc4CHgITqD5dBcMmOnBZmMRF0YMEtjQ
meAxHRfYNFIDM2SkmGSmqmVZz3FF8xGS3uAiZz7meNzJnjSDPyHEKzEgkHe5CWgC
yH7DHrMHrrWWJv22SWQDwe/5PWW+Sp15BFE643pwJspIjH44ICdglrbqOd7kiU1d
pfSx+lkS5Yfgadkt3WTbkJvF3dPJiw==
=97fr
-----END PGP SIGNATURE-----

--nc3Ata7phFTOMtCQ5O7Qu2ivBs48hwIWd--
