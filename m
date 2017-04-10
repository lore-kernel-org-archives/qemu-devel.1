Received: from eggs.gnu.org ([2001:4830:134:3::10]:53426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxbk7-00062F-Ty
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxbk6-0004Py-SL
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:00:39 -0400
Date: Mon, 10 Apr 2017 17:00:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170410160023.GG3214@stefanha-x1.localdomain>
References: <1491741460-10308-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <1491741460-10308-1-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v3] migration/block: use blk_pwrite_zeroes
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


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 09, 2017 at 08:37:40PM +0800, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>=20
> BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
> this maybe cause the qcow2 file size is bigger after migration.
> This patch check each cluster, use blk_pwrite_zeroes for each
> zero cluster.
>=20
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  migration/block.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/block.c b/migration/block.c
> index 7734ff7..fe613db 100644
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
> @@ -934,8 +936,40 @@ static int block_load(QEMUFile *f, void *opaque, int=
 version_id)
>              } else {
>                  buf =3D g_malloc(BLOCK_SIZE);
>                  qemu_get_buffer(f, buf, BLOCK_SIZE);
> -                ret =3D blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
> -                                 nr_sectors * BDRV_SECTOR_SIZE, 0);
> +
> +                ret =3D bdrv_get_info(blk_bs(blk), &bdi);
> +                cluster_size =3D bdi.cluster_size;
> +
> +                if (ret =3D=3D 0 && cluster_size > 0 &&
> +                    cluster_size <=3D BLOCK_SIZE &&
> +                    BLOCK_SIZE % cluster_size =3D=3D 0) {

How about:

  if (blk !=3D blk_prev) {
      blk_prev =3D blk;
      total_sectors =3D blk_nb_sectors(blk);
      if (total_sectors <=3D 0) {
          error_report("Error getting length of block device %s",
                       device_name);
          return -EINVAL;
      }

      blk_invalidate_cache(blk, &local_err);
      if (local_err) {
          error_report_err(local_err);
          return -EINVAL;
      }

+     ret =3D bdrv_get_info(blk_bs(blk), &bdi);
+     if (ret =3D=3D 0 && cluster_size > 0 && cluster_size <=3D BLOCK_SIZE =
&&
+         BLOCK_SIZE % cluster_size =3D=3D 0) {
+         zero_cluster_size =3D bdi.cluster_size;
+     } else {
+         zero_cluster_size =3D 0;
+     }
  }

That way we only fetch the cluster size once per device.

When processing a block we do without repeatedly fetching the cluster
size:

  if (zero_cluster_size) {
     ...detect zeroes...
  }

> +                    int i;
> +                    int64_t cur_addr;
> +                    uint8_t *cur_buf;
> +
> +                    for (i =3D 0; i < BLOCK_SIZE / cluster_size; i++) {
> +                        cur_addr =3D addr * BDRV_SECTOR_SIZE
> +                                        + i * cluster_size;
> +                        cur_buf =3D buf + i * cluster_size;
> +
> +                        if (buffer_is_zero(cur_buf, cluster_size)) {
> +                            ret =3D blk_pwrite_zeroes(blk, cur_addr,
> +                                                    cluster_size,
> +                                                    BDRV_REQ_MAY_UNMAP);
> +                        } else {
> +                             ret =3D blk_pwrite(blk, cur_addr, cur_buf,
> +                                              cluster_size, 0);

Indentation is off here.

> +                        }
> +
> +                        if (ret < 0) {
> +                            g_free(buf);
> +                            return ret;
> +                        }
> +                    }
> +                } else {
> +                    ret =3D blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
> +                                     nr_sectors * BDRV_SECTOR_SIZE, 0);
> +                }
>                  g_free(buf);
>              }
> =20
> --=20
> 1.8.3.1
>=20

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY66wXAAoJEJykq7OBq3PIdAoH/2Hi9eT3jHbkhSgxJYJXSa+p
U2GDc+Jb6A1MQzHXuY3Tm9u7n9836VwpdAE+3W/zml1gviCjOWFiWj525UfKHnyk
YmpdDjgIMqOCIj9QY7x2iIngoeRKTS8QyUMLoHkLr4Kj04oFR+CgN4FGp0IGYA5F
97gV5vm3fYzb4eIksH5IErxWcGeRE/X3uHmjhNqhsUCo13WkreB17OtCA7CngKz8
b/1g55JC1f/NDUgmwexq4kjS6FmkhhbsA3CPld73BgBYlzahAJojGnBy3+toeeYS
MNx61jwDtw6NOaaeYJ96L6v4zl1GvhkYFTM3ZfiEfpWGAV8RrSoBiXD40MEQ3tU=
=r+nC
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
