Received: from eggs.gnu.org ([2001:4830:134:3::10]:49190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d8VOF-0003bk-PR
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d8VOF-0005NA-1j
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:27:07 -0400
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510143205.32013-5-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <17fd54d8-fba0-b44e-91ea-18e4e18e9f16@redhat.com>
Date: Wed, 10 May 2017 19:26:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170510143205.32013-5-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mvkEgFaGhBCjwDDKg0WVUMiiDRcMwHUa6"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/7] curl: split
 curl_find_state/curl_init_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mvkEgFaGhBCjwDDKg0WVUMiiDRcMwHUa6
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com
Message-ID: <17fd54d8-fba0-b44e-91ea-18e4e18e9f16@redhat.com>
Subject: Re: [Qemu-block] [PATCH 4/7] curl: split
 curl_find_state/curl_init_state
References: <20170510143205.32013-1-pbonzini@redhat.com>
 <20170510143205.32013-5-pbonzini@redhat.com>
In-Reply-To: <20170510143205.32013-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.05.2017 16:32, Paolo Bonzini wrote:
> If curl_easy_init fails, a CURLState is left with s->in_use =3D 1.  Spl=
it
> curl_init_state in two, so that we can distinguish the two failures and=

> call curl_clean_state if needed.
>=20
> While at it, simplify curl_find_state, removing a dummy loop.  The
> aio_poll loop is moved to the sole caller that needs it.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 52 ++++++++++++++++++++++++++++++----------------------=

>  1 file changed, 30 insertions(+), 22 deletions(-)
>=20
> diff --git a/block/curl.c b/block/curl.c
> index b18e79bf54..4b4d5a2389 100644
> --- a/block/curl.c
> +++ b/block/curl.c

[...]

> @@ -856,8 +854,18 @@ static void curl_readv_bh_cb(void *p)
>      }
> =20
>      // No cache found, so let's start a new request
> -    state =3D curl_init_state(acb->common.bs, s);
> -    if (!state) {
> +    for (;;) {
> +        state =3D curl_find_state(s);
> +        if (state) {
> +            break;
> +        }
> +        qemu_mutex_unlock(&s->mutex);
> +        aio_poll(bdrv_get_aio_context(bs), true);
> +        qemu_mutex_lock(&s->mutex);
> +    }
> +
> +    if (curl_init_state(s, state) < 0) {
> +        curl_clean_state(state);

We could also initialize state to NULL and call curl_clean_state() under
out: if state !=3D NULL. Then again, it would only save us two
curl_clean_state() instances...

So I'll leave it to you and unconditionally give a

Reviewed-by: Max Reitz <mreitz@redhat.com>

>          ret =3D -EIO;
>          goto out;
>      }
>=20



--mvkEgFaGhBCjwDDKg0WVUMiiDRcMwHUa6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkTTWESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Al8MH/1ikWAszV5UltW8lRo+MrxVPCWfgdQnp
VVuHwQ01uZphUtIKG5yJLaq/rDgzPDvCpULapn0Z7YFxo/SedWmcRZKa9/P7M/4f
ak/9hwBZxQfF+CHcpUcLG06sxsWO4w+zu8B3fmqY5cJ7SwOFmTk/NnyyGM2LcRR9
xGYxUEkEJ0ZQWThOtNmfIjlFQPWO2ifZeZBxN2fNCII7clU9oHsdGNzK+x8mY85w
hJj4rcnxg/KxHTIcYQM9vJlosSgsYGzkdskIkZxm+Ytn9FxNgvPoG+ciIJoUYgaw
fvvVR7h3mOqUJ69LYq+uSaQrgqr8+tG859YnVQEgzb255yYWCVNXlvc=
=G9I0
-----END PGP SIGNATURE-----

--mvkEgFaGhBCjwDDKg0WVUMiiDRcMwHUa6--
