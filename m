Received: from eggs.gnu.org ([2001:4830:134:3::10]:50726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d3Ugq-0008Ps-H8
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 17:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d3Ugp-0000Oq-LJ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 17:41:36 -0400
References: <20170418013356.3578-1-eblake@redhat.com>
	<20170418013356.3578-2-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <09e20a54-07bd-bb46-d4e1-21a3e6db3d9e@redhat.com>
Date: Wed, 26 Apr 2017 17:41:22 -0400
MIME-Version: 1.0
In-Reply-To: <20170418013356.3578-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/31] block: Drop unused
 bdrv_round_sectors_to_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, kwolf@nongnu.org



On 04/17/2017 09:33 PM, Eric Blake wrote:
> Now that the last user [mirror_iteration()] has converted to using
> bytes, we no longer need a function to round sectors to clusters.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  include/block/block.h |  4 ----
>  block/io.c            | 21 ---------------------
>  2 files changed, 25 deletions(-)
>=20
> diff --git a/include/block/block.h b/include/block/block.h
> index 740cb86..86ad511 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -467,10 +467,6 @@ const char *bdrv_get_device_or_node_name(const Blo=
ckDriverState *bs);
>  int bdrv_get_flags(BlockDriverState *bs);
>  int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
>  ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs);
> -void bdrv_round_sectors_to_clusters(BlockDriverState *bs,
> -                                    int64_t sector_num, int nb_sectors=
,
> -                                    int64_t *cluster_sector_num,
> -                                    int *cluster_nb_sectors);
>  void bdrv_round_to_clusters(BlockDriverState *bs,
>                              int64_t offset, unsigned int bytes,
>                              int64_t *cluster_offset,
> diff --git a/block/io.c b/block/io.c
> index d22d35f..d61a906 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -419,27 +419,6 @@ static void mark_request_serialising(BdrvTrackedRe=
quest *req, uint64_t align)
>  }
>=20
>  /**
> - * Round a region to cluster boundaries (sector-based)
> - */
> -void bdrv_round_sectors_to_clusters(BlockDriverState *bs,
> -                                    int64_t sector_num, int nb_sectors=
,
> -                                    int64_t *cluster_sector_num,
> -                                    int *cluster_nb_sectors)
> -{
> -    BlockDriverInfo bdi;
> -
> -    if (bdrv_get_info(bs, &bdi) < 0 || bdi.cluster_size =3D=3D 0) {
> -        *cluster_sector_num =3D sector_num;
> -        *cluster_nb_sectors =3D nb_sectors;
> -    } else {
> -        int64_t c =3D bdi.cluster_size / BDRV_SECTOR_SIZE;
> -        *cluster_sector_num =3D QEMU_ALIGN_DOWN(sector_num, c);
> -        *cluster_nb_sectors =3D QEMU_ALIGN_UP(sector_num - *cluster_se=
ctor_num +
> -                                            nb_sectors, c);
> -    }
> -}
> -
> -/**
>   * Round a region to cluster boundaries
>   */
>  void bdrv_round_to_clusters(BlockDriverState *bs,
>=20

--=20
=E2=80=94js
