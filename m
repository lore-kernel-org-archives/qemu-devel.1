Received: from eggs.gnu.org ([209.51.188.92]:47765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hKsN0-0000RF-MM
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 18:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hKsLj-00075I-Mo
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 18:32:45 -0400
References: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cd22d738-d09c-4e2f-5ec6-8d3d34e2b341@redhat.com>
Date: Mon, 29 Apr 2019 00:32:34 +0200
MIME-Version: 1.0
In-Reply-To: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6S5hCFRNsHRbRe9kOzQF3AWHoioq0dCDV"
Subject: Re: [Qemu-devel] [PATCH] [RFC] qcow2: add compression type feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6S5hCFRNsHRbRe9kOzQF3AWHoioq0dCDV
From: Max Reitz <mreitz@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 eblake@redhat.com
Message-ID: <cd22d738-d09c-4e2f-5ec6-8d3d34e2b341@redhat.com>
Subject: Re: [PATCH] [RFC] qcow2: add compression type feature
References: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.02.19 10:08, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type=

> feature into QCOW2 header that indicates that *all* compressed clusters=

> must be (de)compressed using a certain compression type.
>=20
> It is implied that the compression type is set on the image creation an=
d
> can be changed only later by image convertion, thus the only compressio=
n
> algorithm is used for the image.
>=20
> The plan is to add support for ZSTD and then may be something more effe=
ctive
> in the future.
>=20
> ZSDT compression algorithm consumes 3-5 times less CPU power with a
> comparable comression ratio with zlib. It would be wise to use it for
> data compression f.e. for backups.
>=20
> The default compression is ZLIB.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c | 25 +++++++++++++++++++++++++
>  block/qcow2.h | 26 ++++++++++++++++++++++----
>  2 files changed, 47 insertions(+), 4 deletions(-)

Are there plans to pursue this further?

[...]

> diff --git a/block/qcow2.h b/block/qcow2.h
> index 32cce9eee2..fdde5bbefd 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -112,6 +112,10 @@
>  #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
>  #define QCOW2_OPT_CACHE_CLEAN_INTERVAL "cache-clean-interval"
> =20
> +/* Compression types */
> +#define QCOW2_COMPRESSION_TYPE_ZLIB    0
> +#define QCOW2_COMPRESSION_TYPE_ZSTD    1

We probably want QAPI types anyway (qemu-img info should report the
compression type), so I think we could use them instead.

>  typedef struct QCowHeader {
>      uint32_t magic;
>      uint32_t version;
> @@ -197,10 +201,13 @@ enum {
> =20
>  /* Incompatible feature bits */
>  enum {
> -    QCOW2_INCOMPAT_DIRTY_BITNR   =3D 0,
> -    QCOW2_INCOMPAT_CORRUPT_BITNR =3D 1,
> -    QCOW2_INCOMPAT_DIRTY         =3D 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
> -    QCOW2_INCOMPAT_CORRUPT       =3D 1 << QCOW2_INCOMPAT_CORRUPT_BITNR=
,
> +    QCOW2_INCOMPAT_DIRTY_BITNR            =3D 0,
> +    QCOW2_INCOMPAT_CORRUPT_BITNR          =3D 1,
> +    QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR =3D 2,
> +    QCOW2_INCOMPAT_DIRTY                  =3D 1 << QCOW2_INCOMPAT_DIRT=
Y_BITNR,
> +    QCOW2_INCOMPAT_CORRUPT                =3D 1 << QCOW2_INCOMPAT_CORR=
UPT_BITNR,
> +    QCOW2_INCOMPAT_COMPRESSION_TYPE       =3D
> +                                    1 << QCOW2_INCOMPAT_COMPRESSION_TY=
PE_BITNR,
> =20
>      QCOW2_INCOMPAT_MASK          =3D QCOW2_INCOMPAT_DIRTY
>                                   | QCOW2_INCOMPAT_CORRUPT,

This mask needs to be expanded by QCOW2_INCOMPAT_COMPRESSION_TYPE.

> @@ -256,6 +263,10 @@ typedef struct Qcow2BitmapHeaderExt {
>      uint64_t bitmap_directory_offset;
>  } QEMU_PACKED Qcow2BitmapHeaderExt;
> =20
> +typedef struct Qcow2CompressionTypeExt {
> +    uint32_t compression_type;
> +} QEMU_PACKED Qcow2CompressionTypeExt;
> +
>  typedef struct BDRVQcow2State {
>      int cluster_bits;
>      int cluster_size;
> @@ -340,6 +351,13 @@ typedef struct BDRVQcow2State {
> =20
>      CoQueue compress_wait_queue;
>      int nb_compress_threads;
> +    /**
> +     * Compression type used for the image. Default: 0 - ZLIB
> +     * The image compression type is set on image creation.
> +     * The only way to change the compression type is to convert the i=
mage
> +     * with the desired compresion type set

*compression

And, well, ideally qemu-img amend could perform this operation, too.

Max

> +     */
> +    uint32_t compression_type;
>  } BDRVQcow2State;
> =20
>  typedef struct Qcow2COWRegion {
>=20



--6S5hCFRNsHRbRe9kOzQF3AWHoioq0dCDV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzGKgIACgkQ9AfbAGHV
z0B0/Qf/a9epd/IVJODcHCMTjUeoOlsFDEgxj4KIdlFk/Rjzse7P4nIFqr4QmY6l
WYPE/1lZOUBQ/3DIuosc2vktphIQoImjN7W0W7JEZdV0ptAL4vqFIeCraRI7BeVz
KQExc3Ozugq+LT/jYWwTlMOAaFvVwQy2Zm00kp5k1Ev3QRjzBiH5SSH+qLZBMeza
i6fS+U8k9RistuvJE1lyksbZqxUaLi7Zd+Be5fT4MV4hUKfsD10B+cmmUexlu6E1
Ts/Ahr7SjNyH7JAPFE3evWscj3DMl0Xvs/vGG0MLx6cTU4yJTgshubSHgdHHhr8y
gSRB9S12bIniXa2w98VERif97Dx3dg==
=j6ah
-----END PGP SIGNATURE-----

--6S5hCFRNsHRbRe9kOzQF3AWHoioq0dCDV--
