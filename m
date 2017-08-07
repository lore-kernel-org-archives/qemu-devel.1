Received: from eggs.gnu.org ([2001:4830:134:3::10]:38833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degQY-0008T9-2p
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degQS-0004BE-RR
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:42:30 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <484ffeb7-6571-af84-ee4b-0bfcb83df7ad@redhat.com>
Date: Mon, 7 Aug 2017 06:42:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GjxWKc8jb3lcafD6keEEvJVVuMtJw3jOJ"
Subject: Re: [Qemu-devel] [PATCH 02/17] nbd/client: refactor nbd_read_eof
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
--GjxWKc8jb3lcafD6keEEvJVVuMtJw3jOJ
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <484ffeb7-6571-af84-ee4b-0bfcb83df7ad@redhat.com>
Subject: Re: [PATCH 02/17] nbd/client: refactor nbd_read_eof
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Refactor nbd_read_eof to return 1 on success, 0 on eof, when no
> data was read and <0 for other cases, because returned size of
> read data is not actually used.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/nbd-internal.h         | 34 +++++++++++++++++++++++++---------
>  nbd/client.c               |  5 -----
>  tests/qemu-iotests/083.out |  4 ++--
>  3 files changed, 27 insertions(+), 16 deletions(-)
>=20
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index 396ddb4d3e..3fb0b6098a 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -77,21 +77,37 @@
>  #define NBD_ESHUTDOWN  108
> =20
>  /* nbd_read_eof
> - * Tries to read @size bytes from @ioc. Returns number of bytes actual=
ly read.
> - * May return a value >=3D 0 and < size only on EOF, i.e. when iterati=
vely called
> - * qio_channel_readv() returns 0. So, there is no need to call nbd_rea=
d_eof
> - * iteratively.
> + * Tries to read @size bytes from @ioc.
> + * Returns 1 on success
> + *         0 on eof, when no data was read (errp is not set)
> + *         -EINVAL on eof, when some data < @size was read until eof
> + *         < 0 on read fail

In general, mixing negative errno value and generic < 0 in the same
function is most likely ambiguous.

>   */
> -static inline ssize_t nbd_read_eof(QIOChannel *ioc, void *buffer, size=
_t size,
> -                                   Error **errp)
> +static inline int nbd_read_eof(QIOChannel *ioc, void *buffer, size_t s=
ize,
> +                               Error **errp)
>  {
>      struct iovec iov =3D { .iov_base =3D buffer, .iov_len =3D size };
> +    ssize_t ret;
> +
>      /* Sockets are kept in blocking mode in the negotiation phase.  Af=
ter
>       * that, a non-readable socket simply means that another thread st=
ole
>       * our request/reply.  Synchronization is done with recv_coroutine=
, so
>       * that this is coroutine-safe.
>       */
> -    return nbd_rwv(ioc, &iov, 1, size, true, errp);
> +
> +    assert(size > 0);

Effectively the same as assert(size !=3D 0).

> +
> +    ret =3D nbd_rwv(ioc, &iov, 1, size, true, errp);
> +    if (ret <=3D 0) {
> +        return ret;
> +    }

So this is a negative errno (or 0 on EOF),

> +
> +    if (ret !=3D size) {
> +        error_setg(errp, "End of file");
> +        return -EINVAL;

and so is this. Which makes the function documentation not quite
accurate; you aren't mixing a generic < 0.

> +    }
> +
> +    return 1;
>  }
> =20
>  /* nbd_read
> @@ -100,9 +116,9 @@ static inline ssize_t nbd_read_eof(QIOChannel *ioc,=
 void *buffer, size_t size,
>  static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,=

>                             Error **errp)
>  {
> -    ssize_t ret =3D nbd_read_eof(ioc, buffer, size, errp);
> +    int ret =3D nbd_read_eof(ioc, buffer, size, errp);
> =20
> -    if (ret >=3D 0 && ret !=3D size) {
> +    if (ret =3D=3D 0) {
>          ret =3D -EINVAL;
>          error_setg(errp, "End of file");

Why do we have to set errp here instead of in nbd_read_eof()? Is there
ever any case where hitting early EOF is not something that should be
treated as an error?

>      }
> diff --git a/nbd/client.c b/nbd/client.c
> index f1c16b588f..4556056daa 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -925,11 +925,6 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDRepl=
y *reply, Error **errp)
>          return ret;
>      }
> =20
> -    if (ret !=3D sizeof(buf)) {
> -        error_setg(errp, "read failed");
> -        return -EINVAL;
> -    }
> -
>      /* Reply
>         [ 0 ..  3]    magic   (NBD_REPLY_MAGIC)
>         [ 4 ..  7]    error   (0 =3D=3D no error)
> diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
> index a24c6bfece..d3bea1b2f5 100644
> --- a/tests/qemu-iotests/083.out
> +++ b/tests/qemu-iotests/083.out
> @@ -69,12 +69,12 @@ read failed: Input/output error
> =20
>  =3D=3D=3D Check disconnect 4 reply =3D=3D=3D
> =20
> -read failed
> +End of file
>  read failed: Input/output error

At least you tracked that your changes tweak the error message.  But I'm
not yet convinced whether this change simplifies anything.  Is there a
later patch that is easier to write with the new semantics which was not
possible with the pre-patch semantics?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GjxWKc8jb3lcafD6keEEvJVVuMtJw3jOJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIUhIACgkQp6FrSiUn
Q2pvmAgAlFupeFlYutQ0KmPEIngZQQvGWMmnjl+5YkO0yYbgO0pHY8GfQZYphKmO
I71QG/pByUnsrKRZvXBQuaeDG2vPdkx/c1QSNOuK6qEMOnQG1TkdMFUqFd2aDq2F
tXOLWt2YIKuw7pd57QjNRUEm+On5DLwl74a07iEWw+hTl6F/8ewXhSbZBkaaaj9m
S+3cG/P93s8DIhcv1juKQQi8iUb8Smm1QxSKSfNW/gjmINiTdd24GsTkQWcAF5Y5
knKKskuH0uVOBhiHdrimULKV6vJ+7QmpqAst51zTb4CZ0lAOhgeYsP8SlhmpxUHN
T+7GW1Et5UdO/jbsHsIMYAlS2S51Xg==
=6weO
-----END PGP SIGNATURE-----

--GjxWKc8jb3lcafD6keEEvJVVuMtJw3jOJ--
