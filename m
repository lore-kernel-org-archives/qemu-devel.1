Received: from eggs.gnu.org ([2001:4830:134:3::10]:59144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTD0h-000313-MZ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTD0g-00027V-Ii
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:32:07 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-3-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b1934b89-173d-9622-5cd6-4ec938fd011c@redhat.com>
Date: Mon, 16 Jan 2017 20:31:55 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xgLJUVnMHkiJAJrGOm8igSErv3HD8TVF7"
Subject: Re: [Qemu-devel] [PATCH v1 02/15] block: add ability to set a
 prefix for opt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xgLJUVnMHkiJAJrGOm8igSErv3HD8TVF7
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <b1934b89-173d-9622-5cd6-4ec938fd011c@redhat.com>
Subject: Re: [PATCH v1 02/15] block: add ability to set a prefix for opt names
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-3-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-3-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> When integrating the crypto support with qcow/qcow2, we don't
> want to use the bare LUKS option names "hash-alg", "key-secret",
> etc. We want to namespace them "luks-hash-alg", "luks-key-secret"
> so that they don't clash with any general qcow options at a later
> date.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++=
--------
>  block/crypto.h |  42 +++++++++++-----------
>  2 files changed, 118 insertions(+), 34 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index d281de6..1037c70 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c

[...]

> +static int block_crypto_copy_value(void *opaque, const char *name,
> +                                   const char *value, Error **errp)
> +{
> +    struct BlockCryptoCopyData *data =3D opaque;
> +
> +    if (g_str_has_prefix(name, data->prefix)) {
> +        Error *local_err =3D NULL;
> +        const char *newname =3D name + strlen(data->prefix);

strstart() would be shorter:

const char *newname;

if (strstart(name, data->prefix, &newname)) {
    /* ... */
}

> +
> +        qemu_opt_set(data->opts, newname, value, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return 1;

I'd prefer -1, because 0/1 looks more like false/true to me, which in
turn looks like failure/success.

Both optional suggestions, so either way:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +        }
> +    }
> +
> +    return 0;
> +}

[...]



--xgLJUVnMHkiJAJrGOm8igSErv3HD8TVF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh9H6sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AMfYIAIlRppIWUXuaNAn0J6Z5/t0A1KRZzEOR
KIufZCDBLWkZWUaQ0t21UaKBZu3P8ceY75mF2GPEBPW51EQsaCGKgoGQ/NPfF3Xw
w+NzxtldbRyg5lYeXjPIhaU5ssNjoTuq4xITMQrx7tZB+hgF4H12kx5aO7uVyiAN
h/ethn5qpZUZ6TPr9AcKWquRKe+jnZPCo1XYkyvog5R8cD2Az1+97SEdF95TSHVo
LuzDI5HjLnCZZXwsxT2uP8KcQdqx0idBn4zrAEf4miT0iX3US0Lg3//2KfeyMkjV
tlqV49bIQ4LNGYGRxg78kHSidoW8ogdM5LXQElSi39C25D0E/TNdbh8=
=VoH/
-----END PGP SIGNATURE-----

--xgLJUVnMHkiJAJrGOm8igSErv3HD8TVF7--
