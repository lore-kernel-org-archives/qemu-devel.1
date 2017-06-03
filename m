Received: from eggs.gnu.org ([2001:4830:134:3::10]:44336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHGsb-0000JF-Eq
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 17:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHGsX-00049F-7Q
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 17:46:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHGsW-000479-U4
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 17:46:37 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-16-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eadf1060-4198-a5c4-f337-003a2ec0c917@redhat.com>
Date: Sat, 3 Jun 2017 16:46:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-16-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cet8NQpBFu5nJ41puk0fsr2vh6u3o56xP"
Subject: Re: [Qemu-devel] [PATCH 15/19] nbd/server: use errp instead of LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cet8NQpBFu5nJ41puk0fsr2vh6u3o56xP
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <eadf1060-4198-a5c4-f337-003a2ec0c917@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/19] nbd/server: use errp instead of LOG
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-16-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-16-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Move to modern errp scheme from just LOGging errors.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 257 ++++++++++++++++++++++++++++++++++-----------------=
--------
>  1 file changed, 150 insertions(+), 107 deletions(-)
>=20

> @@ -143,30 +143,30 @@ static int nbd_negotiate_send_rep_len(QIOChannel =
*ioc, uint32_t type,
>            type, opt, len);
> =20
>      magic =3D cpu_to_be64(NBD_REP_MAGIC);
> -    ret =3D write_sync(ioc, &magic, sizeof(magic), NULL);
> +    ret =3D write_sync(ioc, &magic, sizeof(magic), errp);
>      if (ret < 0) {
> -        LOG("write failed (rep magic)");
> +        error_prepend(errp, "write failed (rep magic): ");
>          return ret;
>      }

I'm wondering how much we really want to use error_prepend(), or if we
could just get away with using the original error message unchanged.
I'm not saying to rewrite the patch now that you've done the work, so
much as asking aloud whether the additional information in the error
messages will prove useful.

There are definitely some ripple effects from your v2 posting of the
first half of the series that will require you to rebase this, but the
overall idea is sound.

>  /* Send an error reply.
>   * Return -errno on error, 0 on success. */
> -static int GCC_FMT_ATTR(4, 5)
> +static int GCC_FMT_ATTR(5, 6)
>  nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
> -                           uint32_t opt, const char *fmt, ...)
> +                           uint32_t opt, Error **errp, const char *fmt=
, ...)

Having errp not be the last argument is unusual, but I don't see how you
can do any differently with the var-args nature of the call.

> @@ -505,26 +515,33 @@ static int nbd_negotiate_options(NBDClient *clien=
t)
>                   * disconnecting, but that we must also tolerate
>                   * guests that don't wait for our reply. */
>                  ret =3D nbd_negotiate_send_rep(client->ioc, NBD_REP_AC=
K,
> -                                             clientflags);
> -                return ret < 0 && ret !=3D -EPIPE ? ret : 1;
> +                                             clientflags, &local_err);=

> +
> +                if (ret < 0 && ret !=3D -EPIPE) {
> +                    error_propagate(errp, local_err);
> +                    return ret;
> +                }
> +
> +                error_free(local_err);
> +                return 1;

Of course, you'll have to simplify this portion.  This is probably the
one place where you actually DO want to use:

nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
                       clientflags, NULL)

because you truly do not care whether you had an error.

> @@ -1090,18 +1113,18 @@ static int nbd_co_receive_request(NBDRequestDat=
a *req, NBDRequest *request)
> =20
>      /* Sanity checks, part 2. */
>      if (request->from + request->len > client->exp->size) {
> -        LOG("operation past EOF; From: %" PRIu64 ", Len: %" PRIu32
> -            ", Size: %" PRIu64, request->from, request->len,
> -            (uint64_t)client->exp->size);
> +        error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: =
%" PRIu32
> +                   ", Size: %" PRIu64, request->from, request->len,
> +                   (uint64_t)client->exp->size);
>          return request->type =3D=3D NBD_CMD_WRITE ? -ENOSPC : -EINVAL;=


Question - now that we are consistently setting a decent errp, do we
have any callers that care about specific -errno return values, or could
we further simplify the functions by just returning -1 (instead of
worrying about -errno) on failures?


> @@ -1244,21 +1268,33 @@ static coroutine_fn void nbd_trip(void *opaque)=


> =20
>  reply:
> +    if (local_err) {
> +        error_report_err(local_err);
> +        local_err =3D NULL;
> +    }

This says that after we detect an error, we report it,

> +
> +    if (nbd_co_send_reply(req, &reply, reply_data_len) < 0) {
> +        error_setg(&local_err, "Failed to send reply");
> +        goto disconnect;
> +    }

=2E..but then blindly try to send the reply anyways, forgetting that we
ever detected the original error.  Is that going to bite us?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cet8NQpBFu5nJ41puk0fsr2vh6u3o56xP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMy43AAoJEKeha0olJ0NqkhcH/RgIwx/oZoPx0Dp6Ij2Rce0N
IJThHkGtCxoDATcKLO0cplXuz1nnq65jCZrg3PdJi2XM3Y8AItcyEDVkDsZ6uSgD
MAr6n98RqO89+OD1SLJNkdlMnXYAQtN78eKxgWBBBQbR++zkkcoxAj3mAdlyaj44
lzEJ+h2g87ZSBCl6rY7r6frGrszP3sU4NQ8cgjJl+eZb1cZmVIn+EbrAs2l7slsk
86vHrtFC5gLmczNhetcCa0a81jXR8S6YuRsZJQJcKykpq9UBXnvlGvN7g50CIx7t
2pHAv3V6D8+uT0NOdxEjiuBwUx9ElVnHQH/A7hlFxXOj6k7TTS+7czSJzIgxq4o=
=xM/s
-----END PGP SIGNATURE-----

--cet8NQpBFu5nJ41puk0fsr2vh6u3o56xP--
