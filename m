Received: from eggs.gnu.org ([2001:4830:134:3::10]:33987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIe0h-0001XO-2E
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIe0g-0000Ur-1T
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:40:43 -0400
References: <20170601172734.9039-1-berrange@redhat.com>
	<20170601172734.9039-8-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bcff6607-5095-4b98-54ca-b65ecbac0474@redhat.com>
Date: Wed, 7 Jun 2017 18:40:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170601172734.9039-8-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IPVGQwoepVnLlfNv8wSv5wRmhDOFOOuOX"
Subject: Re: [Qemu-devel] [PATCH v8 07/20] block: deprecate "encryption=on"
 in favor of "encrypt.format=aes"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IPVGQwoepVnLlfNv8wSv5wRmhDOFOOuOX
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <bcff6607-5095-4b98-54ca-b65ecbac0474@redhat.com>
Subject: Re: [PATCH v8 07/20] block: deprecate "encryption=on" in favor of
 "encrypt.format=aes"
References: <20170601172734.9039-1-berrange@redhat.com>
 <20170601172734.9039-8-berrange@redhat.com>
In-Reply-To: <20170601172734.9039-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-01 19:27, Daniel P. Berrange wrote:
> Historically the qcow & qcow2 image formats supported a property
> "encryption=3Don" to enable their built-in AES encryption. We'll
> soon be supporting LUKS for qcow2, so need a more general purpose
> way to enable encryption, with a choice of formats.
>=20
> This introduces an "encrypt.format" option, which will later be
> joined by a number of other "encrypt.XXX" options. The use of
> a "encrypt." prefix instead of "encrypt-" is done to facilitate
> mapping to a nested QAPI schema at later date.
>=20
> e.g. the preferred syntax is now
>=20
>   qemu-img create -f qcow2 -o encrypt.format=3Daes demo.qcow2
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow.c               | 30 ++++++++++++++---
>  block/qcow2.c              | 33 +++++++++++++++----
>  include/block/block_int.h  |  2 +-
>  qemu-img.c                 |  4 ++-
>  tests/qemu-iotests/082.out | 81 ++++++++++++++++++++++++++++++--------=
--------
>  5 files changed, 110 insertions(+), 40 deletions(-)
>=20
> diff --git a/block/qcow.c b/block/qcow.c
> index 6738bc7..42f83b2 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c

[...]

> @@ -818,8 +818,16 @@ static int qcow_create(const char *filename, QemuO=
pts *opts, Error **errp)
>      }
> =20
>      backing_file =3D qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
> -    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
> -        flags |=3D BLOCK_FLAG_ENCRYPT;
> +    encryptfmt =3D qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
> +    if (encryptfmt) {
> +        if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {

You should probably just use qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT)
here, because otherwise you can do this:

$ ./qemu-img create -f qcow -o encryption=3Doff,encrypt.format=3Daes \
    foo.qcow 64M
Formatting 'foo.qcow', fmt=3Dqcow size=3D67108864 encryption=3Doff
encrypt.format=3Daes

> +            error_setg(errp, "Options " BLOCK_OPT_ENCRYPT " and "
> +                       BLOCK_OPT_ENCRYPT_FORMAT " are mutually exclusi=
ve");
> +            ret =3D -EINVAL;
> +            goto cleanup;
> +        }
> +    } else if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) =
{
> +        encryptfmt =3D "aes";
>      }
> =20
>      ret =3D bdrv_create_file(filename, opts, &local_err);

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index b3ba5da..19dfcd1 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -2366,8 +2373,16 @@ static int qcow2_create(const char *filename, Qe=
muOpts *opts, Error **errp)
>                      BDRV_SECTOR_SIZE);
>      backing_file =3D qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
>      backing_fmt =3D qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
> -    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
> -        flags |=3D BLOCK_FLAG_ENCRYPT;
> +    encryptfmt =3D qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
> +    if (encryptfmt) {
> +        if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {

Same here.

With these places fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +            error_setg(errp, "Options " BLOCK_OPT_ENCRYPT " and "
> +                       BLOCK_OPT_ENCRYPT_FORMAT " are mutually exclusi=
ve");
> +            ret =3D -EINVAL;
> +            goto finish;
> +        }
> +    } else if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) =
{
> +        encryptfmt =3D "aes";
>      }
>      cluster_size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZ=
E,
>                                           DEFAULT_CLUSTER_SIZE);


--IPVGQwoepVnLlfNv8wSv5wRmhDOFOOuOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZOCyBEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQMqZ
B/9C7HVMK7MWE7iMxmqrspzwnJBCrSk9bBjvJ2sUJ9f5bG5TrvnwIrgRhWjLmwDk
IIqszBa6fRdK2lcYVNfIOwPkP5eaC8ULI0pwkAD3GMudvS4ZVQJFRgMsg5D2kW1N
pmNFJ9m+aybTCU4DcZ7l0aXJye7Yw0xgd19xzKEGK4BE6SKuEuflaURKemIjwJFo
GdmIV/IK1ApxO0+4jU+fXhk3Yy5M9+MF6TQdiQMElpVS5outnD5DptTphlu/+okP
7YZXK+hvdzJ2cpv2HZAkiNBkQnZq3SNdKv1UdP/sQsUIP6jYdHHZYTRbGu60ZIJk
0Qr0u9OC9cKkU/9nkCCqCiVN
=0o9G
-----END PGP SIGNATURE-----

--IPVGQwoepVnLlfNv8wSv5wRmhDOFOOuOX--
