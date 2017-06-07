Received: from eggs.gnu.org ([2001:4830:134:3::10]:45798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIecQ-0003GV-IQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIecP-0001op-Aa
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:19:42 -0400
References: <20170601172734.9039-1-berrange@redhat.com>
	<20170601172734.9039-14-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a2a698c4-9169-100c-e2a7-eeb324d70818@redhat.com>
Date: Wed, 7 Jun 2017 19:19:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170601172734.9039-14-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jpcwfGajOp1qSd4ugBDP8velittVEwkNm"
Subject: Re: [Qemu-devel] [PATCH v8 13/20] qcow2: add support for LUKS
 encryption format
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
--jpcwfGajOp1qSd4ugBDP8velittVEwkNm
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <a2a698c4-9169-100c-e2a7-eeb324d70818@redhat.com>
Subject: Re: [PATCH v8 13/20] qcow2: add support for LUKS encryption format
References: <20170601172734.9039-1-berrange@redhat.com>
 <20170601172734.9039-14-berrange@redhat.com>
In-Reply-To: <20170601172734.9039-14-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-01 19:27, Daniel P. Berrange wrote:
> This adds support for using LUKS as an encryption format
> with the qcow2 file, using the new encrypt.format parameter
> to request "luks" format. e.g.
>=20
>   # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encrypt.format=3Dluks,encrypt.key-secret=3Dsec0 \
>        test.qcow2 10G
>=20
> The legacy "encryption=3Don" parameter still results in
> creation of the old qcow2 AES format (and is equivalent
> to the new 'encryption-format=3Daes'). e.g. the following are
> equivalent:
>=20
>   # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encryption=3Don,encrypt.key-secret=3Dsec0 \
>        test.qcow2 10G
>=20
>  # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encryption-format=3Daes,encrypt.key-secret=3Dsec0 \
>        test.qcow2 10G
>=20
> With the LUKS format it is necessary to store the LUKS
> partition header and key material in the QCow2 file. This
> data can be many MB in size, so cannot go into the QCow2
> header region directly. Thus the spec defines a FDE
> (Full Disk Encryption) header extension that specifies
> the offset of a set of clusters to hold the FDE headers,
> as well as the length of that region. The LUKS header is
> thus stored in these extra allocated clusters before the
> main image payload.
>=20
> Aside from all the cryptographic differences implied by
> use of the LUKS format, there is one further key difference
> between the use of legacy AES and LUKS encryption in qcow2.
> For LUKS, the initialiazation vectors are generated using
> the host physical sector as the input, rather than the
> guest virtual sector. This guarantees unique initialization
> vectors for all sectors when qcow2 internal snapshots are
> used, thus giving stronger protection against watermarking
> attacks.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow2-cluster.c      |   4 +-
>  block/qcow2-refcount.c     |  10 ++
>  block/qcow2.c              | 267 +++++++++++++++++++++++++++++++++++++=
+------
>  block/qcow2.h              |   9 ++
>  qapi/block-core.json       |   5 +-
>  tests/qemu-iotests/082.out | 270 ++++++++++++++++++++++++++++++++++++-=
--------
>  6 files changed, 477 insertions(+), 88 deletions(-)

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 38c0420..30d0343 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -2072,22 +2253,30 @@ static int qcow2_set_up_encryption(BlockDriverS=
tate *bs, const char *encryptfmt,
>      qdict_extract_subqdict(options, &encryptopts, "encrypt.");
>      QDECREF(options);
> =20
> -    if (!g_str_equal(encryptfmt, "aes")) {
> -        error_setg(errp, "Unknown encryption format '%s', expected 'ae=
s'",
> -                   encryptfmt);
> -        ret =3D -EINVAL;
> -        goto out;
> +    int fmt =3D qcow2_crypt_method_from_format(encryptfmt);

Because I love nit picking: Variable declarations should be at the start
of the surrounding block.

Max

> +
> +    switch (fmt) {
> +    case QCOW_CRYPT_LUKS:
> +        cryptoopts =3D block_crypto_create_opts_init(
> +            Q_CRYPTO_BLOCK_FORMAT_LUKS, encryptopts, errp);
> +        break;
> +    case QCOW_CRYPT_AES:
> +        cryptoopts =3D block_crypto_create_opts_init(
> +            Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, errp);
> +        break;
> +    default:
> +        error_setg(errp, "Unknown encryption format '%s'", encryptfmt)=
;
> +        break;
>      }
> -    cryptoopts =3D block_crypto_create_opts_init(
> -        Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, errp);
>      if (!cryptoopts) {
>          ret =3D -EINVAL;
>          goto out;
>      }
> -    s->crypt_method_header =3D QCOW_CRYPT_AES;
> +    s->crypt_method_header =3D fmt;
> =20
>      crypto =3D qcrypto_block_create(cryptoopts,
> -                                  NULL, NULL,
> +                                  qcow2_crypto_hdr_init_func,
> +                                  qcow2_crypto_hdr_write_func,
>                                    bs, errp);
>      if (!crypto) {
>          ret =3D -EINVAL;


--jpcwfGajOp1qSd4ugBDP8velittVEwkNm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZODWgEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJNn
B/4m7593HOSmcY+hqT9FzD3sW5z5LBckEJa07jP51NWT3pLYJKXQW+rdkZ8XtORg
Y/v4mutIgJYRDSUccJidGRb7XgFV3je5nKBbJrMPC2kJdj22awH/N5WZ+SuquXKp
PFFXa8eeputDgRkBUYB+EvG51aqcPEo5QAvXO+C8Upv4lBZ8PE+MuzQcTKGE5ZVE
6s+/GBkpgCkWIHhVYLxmpFBT+iIF2KD4zv7kExGMz4JpJulwScHblCT9eQI92YU9
55UCFEyCqLm1dpp49M0o5N2AgFPgHREfPK5jlYO2FPbG0eoZbMgI8SyBJEBJDSqi
2KPVUoeNZ3JO7LqdC9eJKp4U
=shyV
-----END PGP SIGNATURE-----

--jpcwfGajOp1qSd4ugBDP8velittVEwkNm--
