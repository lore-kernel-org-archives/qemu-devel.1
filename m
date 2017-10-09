Received: from eggs.gnu.org ([2001:4830:134:3::10]:39668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e1eL4-0008Ck-Kk
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 16:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e1eL3-0006GL-Nf
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 16:07:46 -0400
Date: Mon, 9 Oct 2017 16:07:36 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171009200736.GA5170@localhost.localdomain>
References: <20171004020048.26379-1-eblake@redhat.com>
	<20171004020048.26379-10-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171004020048.26379-10-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 09/23] block: Switch
 BdrvCoGetBlockStatusData to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Oct 03, 2017 at 09:00:34PM -0500, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Convert another internal
> type (no semantic change), and rename it to match the corresponding
> public function rename.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
> ---
> v4-v5: no change
> v3: rebase to context conflicts, simple enough to keep R-b
> v2: rebase to earlier changes
> ---
>  block/io.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index b879e26154..1857191187 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1744,17 +1744,17 @@ int bdrv_flush_all(void)
>  }
>=20
>=20
> -typedef struct BdrvCoGetBlockStatusData {
> +typedef struct BdrvCoBlockStatusData {
>      BlockDriverState *bs;
>      BlockDriverState *base;
>      BlockDriverState **file;
> -    int64_t sector_num;
> -    int nb_sectors;
> -    int *pnum;
> +    int64_t offset;
> +    int64_t bytes;
> +    int64_t *pnum;
>      int64_t ret;
>      bool mapping;
>      bool done;
> -} BdrvCoGetBlockStatusData;
> +} BdrvCoBlockStatusData;
>=20
>  int64_t coroutine_fn bdrv_co_get_block_status_from_file(BlockDriverSta=
te *bs,
>                                                          int64_t sector=
_num,
> @@ -1983,14 +1983,16 @@ static int64_t coroutine_fn bdrv_co_get_block_s=
tatus_above(BlockDriverState *bs,
>  /* Coroutine wrapper for bdrv_get_block_status_above() */
>  static void coroutine_fn bdrv_get_block_status_above_co_entry(void *op=
aque)
>  {
> -    BdrvCoGetBlockStatusData *data =3D opaque;
> +    BdrvCoBlockStatusData *data =3D opaque;
> +    int n;
>=20
>      data->ret =3D bdrv_co_get_block_status_above(data->bs, data->base,
>                                                 data->mapping,
> -                                               data->sector_num,
> -                                               data->nb_sectors,
> -                                               data->pnum,
> +                                               data->offset >> BDRV_SE=
CTOR_BITS,
> +                                               data->bytes >> BDRV_SEC=
TOR_BITS,
> +                                               &n,
>                                                 data->file);
> +    *data->pnum =3D n * BDRV_SECTOR_SIZE;

This throws a warning:

 block/io.c: In function =E2=80=98bdrv_get_block_status_above_co_entry=E2=
=80=99:
 block/io.c:1995:21: error: =E2=80=98n=E2=80=99 may be used uninitialized=
 in this function=20
       [-Werror=3Dmaybe-uninitialized] *data->pnum =3D n * BDRV_SECTOR_SI=
ZE;


It is fixed a couple patches from now, but it will still break git-bisect=
.


>      data->done =3D true;
>  }
>=20
> @@ -2007,13 +2009,14 @@ static int64_t bdrv_common_block_status_above(B=
lockDriverState *bs,
>                                                BlockDriverState **file)
>  {
>      Coroutine *co;
> -    BdrvCoGetBlockStatusData data =3D {
> +    int64_t n;
> +    BdrvCoBlockStatusData data =3D {
>          .bs =3D bs,
>          .base =3D base,
>          .file =3D file,
> -        .sector_num =3D sector_num,
> -        .nb_sectors =3D nb_sectors,
> -        .pnum =3D pnum,
> +        .offset =3D sector_num * BDRV_SECTOR_SIZE,
> +        .bytes =3D nb_sectors * BDRV_SECTOR_SIZE,
> +        .pnum =3D &n,
>          .mapping =3D mapping,
>          .done =3D false,
>      };
> @@ -2027,6 +2030,8 @@ static int64_t bdrv_common_block_status_above(Blo=
ckDriverState *bs,
>          bdrv_coroutine_enter(bs, co);
>          BDRV_POLL_WHILE(bs, !data.done);
>      }
> +    assert(data.ret < 0 || QEMU_IS_ALIGNED(n, BDRV_SECTOR_SIZE));
> +    *pnum =3D n >> BDRV_SECTOR_BITS;
>      return data.ret;
>  }
>=20
> --=20
> 2.13.6
>=20
>=20
