Received: from eggs.gnu.org ([2001:4830:134:3::10]:44481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT7qY-0006Xv-KB
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT7qX-0003Xn-HX
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:33:34 -0400
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-14-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b4fae9ff-ee50-c4b6-f3ee-2a3157c0fc6a@redhat.com>
Date: Thu, 6 Jul 2017 09:33:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170704220346.29244-14-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dWaLEvBlRxj1EAFk45jBcImsWlucNq1Oa"
Subject: Re: [Qemu-devel] [PATCH 13/35] nbd: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dWaLEvBlRxj1EAFk45jBcImsWlucNq1Oa
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b4fae9ff-ee50-c4b6-f3ee-2a3157c0fc6a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/35] nbd: mark coroutine_fn
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
 <20170704220346.29244-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-14-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/04/2017 05:03 PM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/nbd-client.h | 10 +++++-----
>  block/nbd-client.c | 24 ++++++++++++++++--------
>  block/nbd.c        |  3 ++-
>  nbd/server.c       |  3 ++-
>  4 files changed, 25 insertions(+), 15 deletions(-)
>=20

> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index 49636bc621..473d1f88fd 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -42,13 +42,13 @@ int nbd_client_init(BlockDriverState *bs,
>                      Error **errp);
>  void nbd_client_close(BlockDriverState *bs);
> =20
> -int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int b=
ytes);
> -int nbd_client_co_flush(BlockDriverState *bs);
> -int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
> +int coroutine_fn nbd_client_co_pdiscard(BlockDriverState *bs, int64_t =
offset, int bytes);
> +int coroutine_fn nbd_client_co_flush(BlockDriverState *bs);
> +int coroutine_fn nbd_client_co_pwritev(BlockDriverState *bs, uint64_t =
offset,
>                            uint64_t bytes, QEMUIOVector *qiov, int flag=
s);

Indentation is off.

> -int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
> +int coroutine_fn nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int=
64_t offset,
>                                  int bytes, BdrvRequestFlags flags);
> -int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
> +int coroutine_fn nbd_client_co_preadv(BlockDriverState *bs, uint64_t o=
ffset,
>                           uint64_t bytes, QEMUIOVector *qiov, int flags=
);
> =20

and some more

>  void nbd_client_detach_aio_context(BlockDriverState *bs);
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 02e928142e..63c0210c37 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -111,7 +111,8 @@ static coroutine_fn void nbd_read_reply_entry(void =
*opaque)
>      s->read_reply_co =3D NULL;
>  }
> =20
> -static int nbd_co_send_request(BlockDriverState *bs,
> +static int coroutine_fn
> +nbd_co_send_request(BlockDriverState *bs,
>                                 NBDRequest *request,
>                                 QEMUIOVector *qiov)
>  {

I know some project specifically like the newline between return type
and function name (it becomes easier to search for function
implementations if ALL function names start in the first column), but it
looks a bit odd compared to the usual qemu style.  I guess you did it
for line length reasons.  But once you do it, now the indentation is off
on the remaining parameters.

> @@ -158,7 +159,8 @@ static int nbd_co_send_request(BlockDriverState *bs=
,
>      return rc;
>  }
> =20
> -static void nbd_co_receive_reply(NBDClientSession *s,
> +static void coroutine_fn
> +nbd_co_receive_reply(NBDClientSession *s,
>                                   NBDRequest *request,
>                                   NBDReply *reply,
>                                   QEMUIOVector *qiov)

Recurring theme of whitespace.

> @@ -185,7 +187,8 @@ static void nbd_co_receive_reply(NBDClientSession *=
s,
>      }
>  }
> =20
> -static void nbd_coroutine_end(BlockDriverState *bs,
> +static void coroutine_fn
> +nbd_coroutine_end(BlockDriverState *bs,
>                                NBDRequest *request)

This even fits on one line now.

Whitespace fixes are trivial enough, so I'm still okay if you add:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dWaLEvBlRxj1EAFk45jBcImsWlucNq1Oa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXkovAAoJEKeha0olJ0NqHlQIAKgukiHv4EJCYqE8/FAZ4/ai
cHzApfCzEv+Qmwaqy+ez2EeI6bpWpeiIg6lpD1pyQAkKBD5NIsbIm1SHASZ+3VTz
h2xZF68u5t8S+x3HpG8MxqvjpNQaIbSiqU2EDj8WolQZbqRumy7xzMnpCgb5jEiQ
QB6d0dI3GkQmo6v8srU4g4AOJGow9d9cNX4EY7bGAElClLpchTwoawCURF9u9B57
LfozT0O9ZacpwdEXsswsmxS3NZ0IYqCO50EQLaLRRx0SnQbfqyQkC9OPrEwjpWOX
kUpXRd7s5IzNqo1jGwsgMWQkpGGRYk6mXEerAknCFFfelCBgVveGMm3DRAuS5zs=
=4x5f
-----END PGP SIGNATURE-----

--dWaLEvBlRxj1EAFk45jBcImsWlucNq1Oa--
