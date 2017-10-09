Received: from eggs.gnu.org ([2001:4830:134:3::10]:37626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1ZfH-0006lQ-3c
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1ZfB-0007jS-4X
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:08:19 -0400
References: <20171009144840.973-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8796fa81-4168-9931-1f29-a6331e40fc0e@redhat.com>
Date: Mon, 9 Oct 2017 17:07:56 +0200
MIME-Version: 1.0
In-Reply-To: <20171009144840.973-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3oVJNtto5HcaNGbPEVXh1w9CbDEuu59TR"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qcow2: Use BDRV_SECTOR_BITS
 instead of its literal value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3oVJNtto5HcaNGbPEVXh1w9CbDEuu59TR
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <8796fa81-4168-9931-1f29-a6331e40fc0e@redhat.com>
Subject: Re: [Qemu-block] [PATCH] qcow2: Use BDRV_SECTOR_BITS instead of its
 literal value
References: <20171009144840.973-1-berto@igalia.com>
In-Reply-To: <20171009144840.973-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-09 16:48, Alberto Garcia wrote:
> BDRV_SECTOR_BITS is defined to be 9 in block.h (and BDRV_SECTOR_SIZE
> is calculated from that), but there are still a few placed where we
> are using the literal value instead of the macro.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 6 +++---
>  block/qcow2.c         | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 0e5aec81cb..0a63604af6 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -748,8 +748,8 @@ uint64_t qcow2_alloc_compressed_cluster_offset(Bloc=
kDriverState *bs,
>          return 0;
>      }
> =20
> -    nb_csectors =3D ((cluster_offset + compressed_size - 1) >> 9) -
> -                  (cluster_offset >> 9);
> +    nb_csectors =3D ((cluster_offset + compressed_size - 1) >> BDRV_SE=
CTOR_BITS) -
> +                  (cluster_offset >> BDRV_SECTOR_BITS);

I'm not sure about this one, because technically this is not the block
layer's sector size but actually 512 bytes ("Compressed size of the
images in sectors of 512 bytes" as per the spec).

> =20
>      cluster_offset |=3D QCOW_OFLAG_COMPRESSED |
>                        ((uint64_t)nb_csectors << s->csize_shift);
> @@ -1582,7 +1582,7 @@ int qcow2_decompress_cluster(BlockDriverState *bs=
, uint64_t cluster_offset)
>          }
> =20
>          BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
> -        ret =3D bdrv_read(bs->file, coffset >> 9, s->cluster_data,
> +        ret =3D bdrv_read(bs->file, coffset >> BDRV_SECTOR_BITS, s->cl=
uster_data,
>                          nb_csectors);

Here it would probably be better to make it bdrv_pread() and then... Use
csize instead of nb_csectors, I guess...?

Max

>          if (ret < 0) {
>              return ret;
> diff --git a/block/qcow2.c b/block/qcow2.c
> index f63d1831f8..dff903e05c 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1139,7 +1139,7 @@ static int qcow2_do_open(BlockDriverState *bs, QD=
ict *options, int flags,
> =20
>      s->cluster_bits =3D header.cluster_bits;
>      s->cluster_size =3D 1 << s->cluster_bits;
> -    s->cluster_sectors =3D 1 << (s->cluster_bits - 9);
> +    s->cluster_sectors =3D 1 << (s->cluster_bits - BDRV_SECTOR_BITS);
> =20
>      /* Initialise version 3 header fields */
>      if (header.version =3D=3D 2) {
> @@ -1636,7 +1636,7 @@ static int64_t coroutine_fn qcow2_co_get_block_st=
atus(BlockDriverState *bs,
> =20
>      bytes =3D MIN(INT_MAX, nb_sectors * BDRV_SECTOR_SIZE);
>      qemu_co_mutex_lock(&s->lock);
> -    ret =3D qcow2_get_cluster_offset(bs, sector_num << 9, &bytes,
> +    ret =3D qcow2_get_cluster_offset(bs, sector_num << BDRV_SECTOR_BIT=
S, &bytes,
>                                     &cluster_offset);
>      qemu_co_mutex_unlock(&s->lock);
>      if (ret < 0) {
>=20



--3oVJNtto5HcaNGbPEVXh1w9CbDEuu59TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnbkMwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A5iQH/3GBeRt/9VYCbgrDK14gTIHjgntXxb0u
TFKQb1Uo3PDwFgnPS+xs1RX0Dfbn6h8UqXSBSRi2551mnYL1AOEK7pmoQA0pIq1Z
n9tSrQH3ZT539c/0YqbmA+2hh5nnuCTfebqPLjdW9a3m2v99uwXHcsJD0FARnHOU
9cVEUBo+GCW+sLeHeCpnmbRe+e+2kzZ9QuJ+ELPq9XjOqXEzZmnsMxMMw6FIT+dh
o6pD3Vue5pvAGLcjun0pN/QIifoF6HM31IzUYVBmtgF7lq2XENNi1Fivb+10v8pX
XQ8t05ldKQDDluDeLsre6os3Q6VlPINqzTvqcFs/jKK5kG4Y/Ag1ISo=
=xpdJ
-----END PGP SIGNATURE-----

--3oVJNtto5HcaNGbPEVXh1w9CbDEuu59TR--
