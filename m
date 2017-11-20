Received: from eggs.gnu.org ([2001:4830:134:3::10]:44730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGnRn-0000B9-Mq
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGnRi-0006H1-QD
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:53:19 -0500
Date: Mon, 20 Nov 2017 14:53:11 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171120145311.GG4516@stefanha-x1.localdomain>
References: <1510851298-59922-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510851298-59922-2-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Content-Disposition: inline
In-Reply-To: <1510851298-59922-2-git-send-email-anton.nefedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qcow2: multiple clusters write
 compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>, mreitz@redhat.com, stefanha@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2017 at 07:54:55PM +0300, Anton Nefedov wrote:
> From: Pavel Butsykin <pbutsykin@virtuozzo.com>
>=20
> At the moment, qcow2_co_pwritev_compressed can process the requests size
> less than or equal to one cluster. This patch added possibility to write
> compressed data in the QCOW2 more than one cluster. The implementation
> is simple, we just split large requests into separate clusters and write
> using existing functionality.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/qcow2.c | 73 ++++++++++++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 52 insertions(+), 21 deletions(-)

Kevin: qcow2_alloc_compressed_cluster_offset() sets up an L2 table entry
before doing the compressed data write.  Can the following scenario
occur if there is another request racing with the compressed write?

1. Compressed cluster L2 table entry added to qcow2 in-memory cache
2. Another request forces cached L2 table to be written to disk
3. Power failure or crash before compressed data is written

Now there is an L2 table entry pointing to garbage data.  This violates
qcow2's data integrity model.

I'm not sure if compressed writes are safe...  It may have been okay for
qemu-img convert but the risk is increased when running a VM.

> diff --git a/block/qcow2.c b/block/qcow2.c
> index c276b24..f1e2759 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3332,11 +3332,9 @@ static int qcow2_truncate(BlockDriverState *bs, in=
t64_t offset,
>      return 0;
>  }
> =20
> -/* XXX: put compressed sectors first, then all the cluster aligned
> -   tables to avoid losing bytes in alignment */
>  static coroutine_fn int
> -qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
> -                            uint64_t bytes, QEMUIOVector *qiov)
> +qcow2_co_pwritev_cluster_compressed(BlockDriverState *bs, uint64_t offse=
t,
> +                                    uint64_t bytes, QEMUIOVector *qiov)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      QEMUIOVector hd_qiov;
> @@ -3346,25 +3344,12 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs,=
 uint64_t offset,
>      uint8_t *buf, *out_buf;
>      int64_t cluster_offset;
> =20
> -    if (bytes =3D=3D 0) {
> -        /* align end of file to a sector boundary to ease reading with
> -           sector based I/Os */
> -        cluster_offset =3D bdrv_getlength(bs->file->bs);
> -        if (cluster_offset < 0) {
> -            return cluster_offset;
> -        }
> -        return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF=
, NULL);
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
> -            offset + bytes !=3D bs->total_sectors << BDRV_SECTOR_BITS)
> -        {
> +    if (bytes < s->cluster_size) {
> +        if (offset + bytes !=3D bs->total_sectors << BDRV_SECTOR_BITS) {
>              qemu_vfree(buf);
>              return -EINVAL;
>          }
> @@ -3444,6 +3429,52 @@ fail:
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
> +        /* align end of file to a sector boundary to ease reading with
> +           sector based I/Os */
> +        int64_t cluster_offset =3D bdrv_getlength(bs->file->bs);
> +        if (cluster_offset < 0) {
> +            return cluster_offset;
> +        }
> +        return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF=
, NULL);
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
> +        ret =3D qcow2_co_pwritev_cluster_compressed(bs, offset + curr_of=
f,
> +                                                  chunk_size, &hd_qiov);
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
> --=20
> 2.7.4
>=20
>=20

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaEuxXAAoJEJykq7OBq3PIxdgH/jUm6b5nUcq083kO0VakUQO/
VSkcOX1A6nWuO7fMUXb6wbiwQOO+poj6Y3z1g4MnMRys+ZTVLoyXvPk3b5Fp1xdr
JczbCYr1qoTyc0si3VTJjCqBt8cMYl3mrrB4v9WyYO4pk5jRPiRweDnAmlo2kxas
lLsHJtcVET1TsClLVLqnqeokX968h0vCc5L5QHBV7ja0LdGB/UeaNO2rIHJjrGKV
emFoJz2Y8VHNTNp1K0R6brm/bOGRJmhX+pB7NNdJGRQ+EM6AksMgFXrp0k4YWy7/
14uhX3I1Lx4gC4dAMzf2dJV1HRyZeDJLp37t+PCyFf6lYw9ubMXUq+PGrJreMSU=
=zxM4
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--
