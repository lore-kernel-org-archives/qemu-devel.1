Received: from eggs.gnu.org ([2001:4830:134:3::10]:55164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxyDU-0000kD-8I
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxyDM-0001QQ-G2
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:00:28 -0400
Date: Tue, 11 Apr 2017 16:59:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170411155958.GE5940@stefanha-x1.localdomain>
References: <1491912312-23393-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Content-Disposition: inline
In-Reply-To: <1491912312-23393-1-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v4] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com
Cc: qemu-devel@nongnu.org, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 08:05:12PM +0800, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>=20
> BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
> this maybe cause the qcow2 file size is bigger after migration.
> This patch check each cluster, use blk_pwrite_zeroes for each
> zero cluster.
>=20
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  migration/block.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/block.c b/migration/block.c
> index 7734ff7..5d0635a 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -885,6 +885,8 @@ static int block_load(QEMUFile *f, void *opaque, int =
version_id)
>      int64_t total_sectors =3D 0;
>      int nr_sectors;
>      int ret;
> +    BlockDriverInfo bdi;
> +    int cluster_size;
> =20
>      do {
>          addr =3D qemu_get_be64(f);
> @@ -919,6 +921,15 @@ static int block_load(QEMUFile *f, void *opaque, int=
 version_id)
>                      error_report_err(local_err);
>                      return -EINVAL;
>                  }
> +
> +                ret =3D bdrv_get_info(blk_bs(blk), &bdi);
> +                if (ret =3D=3D 0 && bdi.cluster_size > 0 &&
> +                    bdi.cluster_size <=3D BLOCK_SIZE &&
> +                    BLOCK_SIZE % bdi.cluster_size =3D=3D 0) {
> +                    cluster_size =3D bdi.cluster_size;
> +                } else {
> +                    cluster_size =3D BLOCK_SIZE;

This is a nice trick to unify code paths.  It has a disadvantage though:

If the "zero blocks" migration capability is enabled and the drive has
no cluster_size (e.g. raw files), then the source QEMU process has
already scanned for zeroes.  CPU is wasted scanning for zeroes in the
destination QEMU process.

Given that disk images can be large we should probably avoid unnecessary
scanning.  This is especially true because there's no other reason
(besides zero detection) to pollute the CPU cache with data from the
disk image.

In other words, we should only scan for zeroes when
!block_mig_state.zero_blocks || cluster_size < BLOCK_SIZE.

> +                }
>              }
> =20
>              if (total_sectors - addr < BDRV_SECTORS_PER_DIRTY_CHUNK) {
> @@ -932,10 +943,28 @@ static int block_load(QEMUFile *f, void *opaque, in=
t version_id)
>                                          nr_sectors * BDRV_SECTOR_SIZE,
>                                          BDRV_REQ_MAY_UNMAP);
>              } else {
> +                int i;
> +                int64_t cur_addr;
> +                uint8_t *cur_buf;
> +
>                  buf =3D g_malloc(BLOCK_SIZE);
>                  qemu_get_buffer(f, buf, BLOCK_SIZE);
> -                ret =3D blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
> -                                 nr_sectors * BDRV_SECTOR_SIZE, 0);
> +                for (i =3D 0; i < BLOCK_SIZE / cluster_size; i++) {
> +                    cur_addr =3D addr * BDRV_SECTOR_SIZE + i * cluster_s=
ize;
> +                    cur_buf =3D buf + i * cluster_size;
> +
> +                    if (buffer_is_zero(cur_buf, cluster_size)) {
> +                        ret =3D blk_pwrite_zeroes(blk, cur_addr,
> +                                                cluster_size,
> +                                                BDRV_REQ_MAY_UNMAP);
> +                    } else {
> +                        ret =3D blk_pwrite(blk, cur_addr, cur_buf,
> +                                         cluster_size, 0);
> +                    }
> +                    if (ret < 0) {
> +                        break;
> +                    }
> +                }
>                  g_free(buf);
>              }

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY7P1+AAoJEJykq7OBq3PIvEAIALKwLDoMmasWPZhU5aSmyKqP
dmGmNU76Pl+V5bXy/af+EjLAmbAiRi/v5FNM/BJQcQUqapetmK4wtpiUCwt0YKVJ
xP7D16XkDDeMdA63SwThCIrtgLlO034KYiVT7Tevh5O+BrLQWDtxonqo0ilRig2a
3vid2MPgLT8+f9yBxGYUsNuOcodU2ChyN6ufidI8nOGbjltKpH6xybW5s3y010fS
Azm/mEi0GAtESK9nTS6FA8w7mDkeazmP8vkFq5oFdxsDRCMUrbd5ep8yIfDZ+pSo
YGU9nsJ9dpe5lcezrajcypiDBTmy6F2GENlhUqibOgF036occt6DRUhgAd/9zFM=
=7jbw
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
