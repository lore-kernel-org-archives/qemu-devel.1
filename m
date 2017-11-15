Received: from eggs.gnu.org ([2001:4830:134:3::10]:46860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEzMP-000798-J6
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEzMJ-0003h9-HF
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:12:17 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-3-git-send-email-anton.nefedov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <97df2225-908c-e817-8364-2454f1451768@redhat.com>
Date: Wed, 15 Nov 2017 16:11:55 +0100
MIME-Version: 1.0
In-Reply-To: <1510654613-47868-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ei8MkJVTg235sgMW1kd0L7DMdarTx23I9"
Subject: Re: [Qemu-devel] [PATCH 2/5] qcow2: multiple clusters write
 compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, Pavel Butsykin <pbutsykin@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ei8MkJVTg235sgMW1kd0L7DMdarTx23I9
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com,
 Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <97df2225-908c-e817-8364-2454f1451768@redhat.com>
Subject: Re: [PATCH 2/5] qcow2: multiple clusters write compressed
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1510654613-47868-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1510654613-47868-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 11:16, Anton Nefedov wrote:
> From: Pavel Butsykin <pbutsykin@virtuozzo.com>
>=20
> At the moment, qcow2_co_pwritev_compressed can process the requests siz=
e
> less than or equal to one cluster. This patch added possibility to writ=
e
> compressed data in the QCOW2 more than one cluster. The implementation
> is simple, we just split large requests into separate clusters and writ=
e
> using existing functionality. For unaligned requests we use a workaroun=
d
> and do write data without compression.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/qcow2.c | 77 +++++++++++++++++++++++++++++++++++++++++++--------=
--------
>  1 file changed, 56 insertions(+), 21 deletions(-)

On one hand, it might be better to do this centrally somewhere in
block/io.c.  On the other, that would require more work because it would
probably mean having to introduce another field in BlockLimits, and it
wouldn't do much -- because qcow (v1) is, well, qcow v1...  And vmdk
seems to completely not care about this single cluster limitation.  So
for now we probably wouldn't even gain anything by doing this in block/io=
=2Ec.

So long story short, it's OK to do this locally in qcow2, yes.

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 45c5651..3d5f17d 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3325,11 +3325,9 @@ static int qcow2_truncate(BlockDriverState *bs, =
int64_t offset,
>      return 0;
>  }
> =20
> -/* XXX: put compressed sectors first, then all the cluster aligned
> -   tables to avoid losing bytes in alignment */
>  static coroutine_fn int
> -qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
> -                            uint64_t bytes, QEMUIOVector *qiov)
> +qcow2_co_pwritev_cluster_compressed(BlockDriverState *bs, uint64_t off=
set,
> +                                    uint64_t bytes, QEMUIOVector *qiov=
)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      QEMUIOVector hd_qiov;
> @@ -3339,25 +3337,12 @@ qcow2_co_pwritev_compressed(BlockDriverState *b=
s, uint64_t offset,
>      uint8_t *buf, *out_buf;
>      int64_t cluster_offset;
> =20
> -    if (bytes =3D=3D 0) {
> -        /* align end of file to a sector boundary to ease reading with=

> -           sector based I/Os */
> -        cluster_offset =3D bdrv_getlength(bs->file->bs);
> -        if (cluster_offset < 0) {
> -            return cluster_offset;
> -        }
> -        return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_O=
FF, NULL);
> -    }
> -
> -    if (offset_into_cluster(s, offset)) {
> -        return -EINVAL;
> -    }
> +    assert(bytes <=3D s->cluster_size);
> +    assert(!offset_into_cluster(s, offset));
> =20
>      buf =3D qemu_blockalign(bs, s->cluster_size);
> -    if (bytes !=3D s->cluster_size) {
> -        if (bytes > s->cluster_size ||
> -            offset + bytes !=3D bs->total_sectors << BDRV_SECTOR_BITS)=

> -        {
> +    if (bytes < s->cluster_size) {
> +        if (offset + bytes !=3D bs->total_sectors << BDRV_SECTOR_BITS)=
 {
>              qemu_vfree(buf);
>              return -EINVAL;
>          }
> @@ -3437,6 +3422,56 @@ fail:
>      return ret;
>  }
> =20
> +/* XXX: put compressed sectors first, then all the cluster aligned
> +   tables to avoid losing bytes in alignment */
> +static coroutine_fn int
> +qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
> +                            uint64_t bytes, QEMUIOVector *qiov)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    QEMUIOVector hd_qiov;
> +    uint64_t curr_off =3D 0;
> +    int ret;
> +
> +    if (bytes =3D=3D 0) {
> +        /* align end of file to a sector boundary to ease reading with=

> +           sector based I/Os */
> +        int64_t cluster_offset =3D bdrv_getlength(bs->file->bs);
> +        if (cluster_offset < 0) {
> +            return cluster_offset;
> +        }
> +        return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_O=
FF, NULL);
> +    }
> +
> +    if (offset_into_cluster(s, offset)) {
> +        return -EINVAL;
> +    }
> +
> +    qemu_iovec_init(&hd_qiov, qiov->niov);
> +    do {
> +        uint32_t chunk_size;
> +
> +        qemu_iovec_reset(&hd_qiov);
> +        chunk_size =3D MIN(bytes, s->cluster_size);
> +        qemu_iovec_concat(&hd_qiov, qiov, curr_off, chunk_size);
> +
> +        ret =3D qcow2_co_pwritev_cluster_compressed(bs, offset + curr_=
off,
> +                                                  chunk_size, &hd_qiov=
);
> +        if (ret =3D=3D -ENOTSUP) {

Why this?  I mean, I can see the appeal, but then we should probably
actually return -ENOTSUP somewhere (e.g. for unaligned clusters and the
like) -- and we should not abort if offset_into_cluster(s, cluster) is
true, but we should write the header uncompressed and compress the main
bulk.

Max

> +            ret =3D qcow2_co_pwritev(bs, offset + curr_off, chunk_size=
,
> +                                   &hd_qiov, 0);
> +        }
> +        if (ret < 0) {
> +            break;
> +        }
> +        curr_off +=3D chunk_size;
> +        bytes -=3D chunk_size;
> +    } while (bytes);
> +    qemu_iovec_destroy(&hd_qiov);
> +
> +    return ret;
> +}
> +
>  static int make_completely_empty(BlockDriverState *bs)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>=20



--ei8MkJVTg235sgMW1kd0L7DMdarTx23I9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMWTsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASNsH/2+OoL6cX1TPLwgwsW7nTYvvtPMdaOFo
17N+KUb9MUH4eKHf2e4d7TUkwUyXuTkDuPQNuwYeevH8vEtsPRG47cyl023XM1E0
x+TH/9ruAaiwCHQLrIMlWPNauucdcb8DqCuBNqNQmeelW726UkAl2+d0cQsXVIoB
9qyGFcQGCojHZz5v6EnWyMf+ks8tLusmQ8Ww3tiYpy339jIyStT1Ij576vagai1f
8YDeLbfxhRQz62/amCgvsrSe+D7Q0MKKHh4cTGqeFH9KlH6JQVBVuRrhhdhxeU60
LfhHosisusA1HSar8EIItW2NwVR8Gs/6ZQWa0iWvW9DAbISW4xMR9Cw=
=HQyP
-----END PGP SIGNATURE-----

--ei8MkJVTg235sgMW1kd0L7DMdarTx23I9--
