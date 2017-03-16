Received: from eggs.gnu.org ([2001:4830:134:3::10]:34970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coKfN-0001lZ-IF
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coKfK-0002hH-Fs
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:57:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1coKfK-0002gu-6X
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:57:22 -0400
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-6-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4db9211c-4136-335c-8d97-c0ec13da2aa3@redhat.com>
Date: Thu, 16 Mar 2017 02:57:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170315092940.1367-6-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QpwAO3FvVcIcGIrTcDOxenvcpPOekGKeh"
Subject: Re: [Qemu-devel] [RFC v2 5/8] qcow2: add bdrv_measure() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QpwAO3FvVcIcGIrTcDOxenvcpPOekGKeh
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <4db9211c-4136-335c-8d97-c0ec13da2aa3@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 5/8] qcow2: add bdrv_measure() support
References: <20170315092940.1367-1-stefanha@redhat.com>
 <20170315092940.1367-6-stefanha@redhat.com>
In-Reply-To: <20170315092940.1367-6-stefanha@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 15.03.2017 10:29, Stefan Hajnoczi wrote:
> Use qcow2_calc_prealloc_size() to get the required file size.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> TODO:
>  * Query block status and only count allocated clusters if in_bs !=3D N=
ULL
>  * Exclude backing file clusters if in_bs !=3D NULL and -o backing_file=
=3D
>    is given
> ---
>  block/qcow2.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++
>  1 file changed, 53 insertions(+)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 19be468..a4caf97 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2940,6 +2940,58 @@ static coroutine_fn int qcow2_co_flush_to_os(Blo=
ckDriverState *bs)
>      return 0;
>  }
> =20
> +static void qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
> +                          BlockMeasureInfo *info, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    uint64_t allocated_bytes =3D 0;
> +    uint64_t prealloc_size;
> +    uint64_t size;
> +    uint64_t refcount_bits;
> +    size_t cluster_size;
> +    int version;
> +
> +    size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> +                    BDRV_SECTOR_SIZE);
> +
> +    cluster_size =3D qcow2_opt_get_cluster_size_del(opts, &local_err);=

> +    if (local_err) {
> +        goto err;
> +    }
> +
> +    version =3D qcow2_opt_get_version_del(opts, &local_err);
> +    if (local_err) {
> +        goto err;
> +    }
> +
> +    refcount_bits =3D qcow2_opt_get_refcount_bits_del(opts, version, &=
local_err);
> +    if (local_err) {
> +        goto err;
> +    }
> +
> +    if (in_bs) {
> +        int64_t ssize =3D bdrv_getlength(in_bs);
> +        if (ssize < 0) {
> +            error_setg_errno(errp, -ssize, "Unable to get image size")=
;
> +            return;
> +        }
> +
> +        size =3D ssize;
> +
> +        /* TODO How many clusters are allocated modulo backing file in=
 opts? */
> +    }
> +
> +    prealloc_size =3D qcow2_calc_prealloc_size(size, cluster_size,
> +                                             ctz32(refcount_bits));
> +    info->required_bytes =3D prealloc_size - (align_offset(size, clust=
er_size) -
> +                                            allocated_bytes);

But what if @opts contains a preallocation option?

Max

> +    info->fully_allocated_bytes =3D prealloc_size;
> +    return;
> +
> +err:
> +    error_propagate(errp, local_err);
> +}
> +
>  static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
> @@ -3487,6 +3539,7 @@ BlockDriver bdrv_qcow2 =3D {
>      .bdrv_snapshot_delete   =3D qcow2_snapshot_delete,
>      .bdrv_snapshot_list     =3D qcow2_snapshot_list,
>      .bdrv_snapshot_load_tmp =3D qcow2_snapshot_load_tmp,
> +    .bdrv_measure           =3D qcow2_measure,
>      .bdrv_get_info          =3D qcow2_get_info,
>      .bdrv_get_specific_info =3D qcow2_get_specific_info,
> =20
>=20



--QpwAO3FvVcIcGIrTcDOxenvcpPOekGKeh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljJ8PkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATlMIAL4W8OaTTlkUdOOJLwCVuM4kVbFO2/lv
Z5wZsophv1S35mpbS44eTPjaZVBYB0XWYoanVk3ZZWhmHYzrv15KSqwyAahZOl3D
SayxiSrj8zVfhukWSukdxGlaq6BuZAvq7ZJ++bXq0aGTatj1TnTG5HRqbI2zOUKK
0+q6x53JHaEPXbELdwzpSb3oD0mKCiMk6O3afvIPZhQeSyC0DTRZYQpogd+A0aKu
9UlWHj7HUQaG2q5Zy3XtdEqOlA9p79WD6gmn4wxBnzAbDijXYqhejYtN3mm2cOI9
E23pHDHvjx1w4FJ0OtOknkiPFT582cpcD+k1QjSNwPmH94WIqr3b6vY=
=O4E1
-----END PGP SIGNATURE-----

--QpwAO3FvVcIcGIrTcDOxenvcpPOekGKeh--
