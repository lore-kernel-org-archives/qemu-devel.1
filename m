Received: from eggs.gnu.org ([2001:4830:134:3::10]:45354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTujj-0000mo-Kc
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTuji-00070J-1d
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:13:31 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-12-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f8f66036-e59d-2b37-bd5c-86f693fdf9f9@redhat.com>
Date: Wed, 18 Jan 2017 19:13:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-12-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AovEUfrfTW29PsA933MnaA7SoB83vLvBK"
Subject: Re: [Qemu-devel] [PATCH v1 11/15] qcow2: convert QCow2 to use
 QCryptoBlock for encryption
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
--AovEUfrfTW29PsA933MnaA7SoB83vLvBK
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <f8f66036-e59d-2b37-bd5c-86f693fdf9f9@redhat.com>
Subject: Re: [PATCH v1 11/15] qcow2: convert QCow2 to use QCryptoBlock for
 encryption
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-12-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-12-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> This converts the qcow2 driver to make use of the QCryptoBlock
> APIs for encrypting image content, using the legacyy QCow2 AES
> scheme.
>=20
> With this change it is now required to use the QCryptoSecret
> object for providing passwords, instead of the current block
> password APIs / interactive prompting.
>=20
>   $QEMU \
>     -object secret,id=3Dsec0,filename=3D/home/berrange/encrypted.pw \
>     -drive file=3D/home/berrange/encrypted.qcow2,aes-key-secret=3Dsec0
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow2-cluster.c      |  47 +----------
>  block/qcow2.c              | 190 +++++++++++++++++++++++++++++--------=
--------
>  block/qcow2.h              |   5 +-
>  qapi/block-core.json       |   7 +-
>  tests/qemu-iotests/049     |   2 +-
>  tests/qemu-iotests/049.out |   4 +-
>  tests/qemu-iotests/082.out |  27 +++++++
>  tests/qemu-iotests/087     |  28 ++++++-
>  tests/qemu-iotests/087.out |   6 +-
>  tests/qemu-iotests/134     |  18 +++--
>  tests/qemu-iotests/134.out |  10 +--
>  tests/qemu-iotests/158     |  19 +++--
>  tests/qemu-iotests/158.out |  14 +---
>  13 files changed, 219 insertions(+), 158 deletions(-)

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 3c14c86..5c9e196 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -1122,6 +1144,24 @@ static int qcow2_open(BlockDriverState *bs, QDic=
t *options, int flags,
>          goto fail;
>      }
> =20
> +    if (s->crypt_method_header =3D=3D QCOW_CRYPT_AES) {
> +        unsigned int cflags =3D 0;
> +        if (flags & BDRV_O_NO_IO) {
> +            cflags |=3D QCRYPTO_BLOCK_OPEN_NO_IO;
> +        }
> +        /* XXX how do we pass the same crypto opts down to the

I think a TODO instead of an XXX would have been sufficient, but it's
your call.

> +         * backing file by default, so we don't have to manually
> +         * provide the same key-secret property against the full
> +         * backing chain
> +         */
> +        s->crypto =3D qcrypto_block_open(s->crypto_opts, NULL, NULL,
> +                                       cflags, errp);
> +        if (!s->crypto) {
> +            ret =3D -EINVAL;
> +            goto fail;
> +        }

[...]

> @@ -2022,6 +2027,44 @@ static int qcow2_change_backing_file(BlockDriver=
State *bs,
>      return qcow2_update_header(bs);
>  }
> =20
> +
> +static int qcow2_change_encryption(BlockDriverState *bs, QemuOpts *opt=
s,
> +                                   Error **errp)

I think this name is not quite appropriate, since this doesn't change
the format of the file if it is already encrypted (and it will not
encrypt any existing data).

Maybe set_up instead of change?

(qcow2_change_backing_file()'s name is good because it will actually
work if there already is a different backing file.)

> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    QCryptoBlockCreateOptions *cryptoopts =3D NULL;
> +    QCryptoBlock *crypto =3D NULL;
> +    int ret =3D -EINVAL;

[...]

> diff --git a/block/qcow2.h b/block/qcow2.h
> index 033d8c0..f4cb171 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -25,7 +25,7 @@
>  #ifndef BLOCK_QCOW2_H
>  #define BLOCK_QCOW2_H
> =20
> -#include "crypto/cipher.h"
> +#include "crypto/block.h"
>  #include "qemu/coroutine.h"
> =20
>  //#define DEBUG_ALLOC
> @@ -256,7 +256,8 @@ typedef struct BDRVQcow2State {
> =20
>      CoMutex lock;
> =20
> -    QCryptoCipher *cipher; /* current cipher, NULL if no key yet */
> +    QCryptoBlockOpenOptions *crypto_opts; /* Disk encryption runtime o=
ptions */
> +    QCryptoBlock *crypto; /* Disk encryption format driver */
>      uint32_t crypt_method_header;
>      uint64_t snapshots_offset;
>      int snapshots_size;
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index c2b70e8..2ca5674 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1935,6 +1935,9 @@
>  # @cache-clean-interval:  #optional clean unused entries in the L2 and=
 refcount
>  #                         caches. The interval is in seconds. The defa=
ult value
>  #                         is 0 and it disables this feature (since 2.5=
)
> +# @aes-key-secret:        #optional the ID of a QCryptoSecret object p=
roviding
> +#                         the AES decryption key (since 2.9) Mandatory=
 except

Missing full stop after the closing parenthesis.

Also, it's mandatory only for encrypted images. I know it's obvious but
that's not what it says here.

> +#                         when doing a metadata-only probe of the imag=
e.
>  #
>  # Since: 1.7
>  ##
> @@ -1948,8 +1951,8 @@
>              '*cache-size': 'int',
>              '*l2-cache-size': 'int',
>              '*refcount-cache-size': 'int',
> -            '*cache-clean-interval': 'int' } }
> -
> +            '*cache-clean-interval': 'int',
> +            '*aes-key-secret': 'str' } }
> =20
>  ##
>  # @BlockdevOptionsArchipelago:
> diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
> index fff0760..7da4ac8 100755
> --- a/tests/qemu-iotests/049
> +++ b/tests/qemu-iotests/049
> @@ -106,7 +106,7 @@ test_qemu_img create -f $IMGFMT -o preallocation=3D=
1234 "$TEST_IMG" 64M
>  echo "=3D=3D Check encryption option =3D=3D"
>  echo
>  test_qemu_img create -f $IMGFMT -o encryption=3Doff "$TEST_IMG" 64M
> -test_qemu_img create -f $IMGFMT -o encryption=3Don "$TEST_IMG" 64M
> +test_qemu_img create -f $IMGFMT --object secret,id=3Dsec0,data=3D12345=
6 -o encryption=3Don,qcow-key-secret=3Dsec0 "$TEST_IMG" 64M

s/qcow-key-secret/aes-key-secret/

> =20
>  echo "=3D=3D Check lazy_refcounts option (only with v3) =3D=3D"
>  echo

[...]

> diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
> index 9de57dd..fe30383 100755
> --- a/tests/qemu-iotests/087
> +++ b/tests/qemu-iotests/087
> @@ -124,9 +124,18 @@ echo
>  echo =3D=3D=3D Encrypted image =3D=3D=3D
>  echo
> =20
> -_make_test_img -o encryption=3Don $size
> +_make_test_img --object secret,id=3Dsec0,data=3D123456 -o encryption=3D=
on,qcow-key-secret=3Dsec0 $size
>  run_qemu -S <<EOF
>  { "execute": "qmp_capabilities" }
> +{ "execute": "object-add",
> +  "arguments": {
> +      "qom-type": "secret",
> +      "id": "sec0",
> +      "props": {
> +          "data": "123456"
> +      }
> +  }
> +}
>  { "execute": "blockdev-add",
>    "arguments": {
>        "driver": "$IMGFMT",
> @@ -134,7 +143,8 @@ run_qemu -S <<EOF
>        "file": {
>            "driver": "file",
>            "filename": "$TEST_IMG"
> -      }
> +      },
> +      "qcow-key-secret": "sec0"

Same here,

>      }
>    }
>  { "execute": "quit" }
> @@ -142,6 +152,15 @@ EOF
> =20
>  run_qemu <<EOF
>  { "execute": "qmp_capabilities" }
> +{ "execute": "object-add",
> +  "arguments": {
> +      "qom-type": "secret",
> +      "id": "sec0",
> +      "props": {
> +          "data": "123456"
> +      }
> +  }
> +}
>  { "execute": "blockdev-add",
>    "arguments": {
>        "driver": "$IMGFMT",
> @@ -149,7 +168,8 @@ run_qemu <<EOF
>        "file": {
>            "driver": "file",
>            "filename": "$TEST_IMG"
> -      }
> +      },
> +      "qcow-key-secret": "sec0"

here,

>      }
>    }
>  { "execute": "quit" }
> @@ -159,7 +179,7 @@ echo
>  echo =3D=3D=3D Missing driver =3D=3D=3D
>  echo
> =20
> -_make_test_img -o encryption=3Don $size
> +_make_test_img --object secret,id=3Dsec0,data=3D123456 -o encryption=3D=
on,qcow-key-secret=3Dsec0 $size

here,

>  run_qemu -S <<EOF
>  { "execute": "qmp_capabilities" }
>  { "execute": "blockdev-add",

[...]

> diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
> index af618b8..c2458d8 100755
> --- a/tests/qemu-iotests/134
> +++ b/tests/qemu-iotests/134
> @@ -43,23 +43,31 @@ _supported_os Linux
> =20
> =20
>  size=3D128M
> -IMGOPTS=3D"encryption=3Don" _make_test_img $size
> +
> +SECRET=3D"secret,id=3Dsec0,data=3Dastrochicken"
> +SECRETALT=3D"secret,id=3Dsec0,data=3Dplatypus"
> +
> +_make_test_img --object $SECRET -o "encryption=3Don,qcow-key-secret=3D=
sec0" $size

here,

> +
> +IMGSPEC=3D"driver=3D$IMGFMT,file.filename=3D$TEST_IMG,qcow-key-secret=3D=
sec0"

here,

> +
> +QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT

[...]

> diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
> index a6cdd6d..2d1c015 100755
> --- a/tests/qemu-iotests/158
> +++ b/tests/qemu-iotests/158
> @@ -44,34 +44,39 @@ _supported_os Linux
> =20
>  size=3D128M
>  TEST_IMG_BASE=3D$TEST_IMG.base
> +SECRET=3D"secret,id=3Dsec0,data=3Dastrochicken"
> =20
>  TEST_IMG_SAVE=3D$TEST_IMG
>  TEST_IMG=3D$TEST_IMG_BASE
>  echo "=3D=3D create base =3D=3D"
> -IMGOPTS=3D"encryption=3Don" _make_test_img $size
> +_make_test_img --object $SECRET -o "encryption=3Don,qcow-key-secret=3D=
sec0" $size

here,

>  TEST_IMG=3D$TEST_IMG_SAVE
> =20
> +IMGSPECBASE=3D"driver=3D$IMGFMT,file.filename=3D$TEST_IMG_BASE,qcow-ke=
y-secret=3Dsec0"
> +IMGSPEC=3D"driver=3D$IMGFMT,file.filename=3D$TEST_IMG,backing.driver=3D=
$IMGFMT,backing.file.filename=3D$TEST_IMG_BASE,backing.qcow-key-secret=3D=
sec0,qcow-key-secret=3Dsec0"

and here.

Max

> +QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
> +

[...]


--AovEUfrfTW29PsA933MnaA7SoB83vLvBK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh/sD8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyJAH/1mZOAcVfmvz8M9OR3CEAk0nSTm0KzWd
aZE1wGV8uJiElpfx/khBN2QN4KHz2h7SuR1xZBkWuyqX7AZro1r+lXPCVa48Qkh9
Cis+eJ9vg9HjtarPMChOoca6BYtXcnpo2ZHQ8CCNKb4WLxks4rWhfK4g4VQYT0xC
UQkODReFQ7tdwVEWpjp/7+GbtZncSqhvo2R2gbPDNfalMjLhsv46bcoORUr+owoe
jMGU/iZrx2zSjrogtokmk8/DSy9av6CzwCBeeho2qZ+sC3l4vPaP3DtaSm1G7Nop
116VifGPxIZ5crazTk1SF3aTDSCy8esalIjCSxffmFpfqEj5abQ8SaE=
=eb27
-----END PGP SIGNATURE-----

--AovEUfrfTW29PsA933MnaA7SoB83vLvBK--
