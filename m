Received: from eggs.gnu.org ([2001:4830:134:3::10]:46055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEvdD-0004Qx-88
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 05:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEvdA-0006XH-0d
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 05:08:51 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cEvd9-0006Wm-Nt
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 05:08:47 -0500
Received: by mail-wj0-f194.google.com with SMTP id xy5so53661653wjc.1
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 02:08:47 -0800 (PST)
Date: Thu, 8 Dec 2016 10:07:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161208100744.GF10780@stefanha-x1.localdomain>
References: <1481183802-31153-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hUH5gZbnpyIv7Mn4"
Content-Disposition: inline
In-Reply-To: <1481183802-31153-1-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [RFC PATCH] block/qapi: Optimize the query
 function of the blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, kwolf@redhat.com, danpb@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com


--hUH5gZbnpyIv7Mn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 03:56:42PM +0800, Dou Liyang wrote:

The commit message says "optimize" but I think the purpose of this patch
is to refactor qmp_query_blockstats() to make it easier to read?  Just
checking if you expect a change in performance.

Usually when I see "optimize" I think improving performance.  When I see
"refactor" I think improving the structure of the code.

> In the query function named qmp_query_blockstats, for each block/node,
> the process is as shown below:
> the 0 func determines which the lookup queue will be used by the 1 func,
> then gets the next object by the 1 func and calls the 2. The 2 func calls
> the 3 and 4 func. There are some judgement and work that is useless and
> repetitive.
>=20
> +--------------+      +---------------------+
>  | 1            |      | 4.                  |
>  |next_query_bds|      |bdrv_query_bds_stats +---+
>  |              |      |                     |   |
>  +--------^-----+      +-------------^-------+   |
>           |                          |           |
> +---------+----------+      +--------+-------+   |
> | 0.                 |      | 2.             |   |
> |qmp_query_blockstats+------>bdrv_query_stats<----
> |                    |      |                |
> +--------------------+      +--------+-------+
>                                      |
>                        +-------------v-------+
>                        | 3.                  |
>                        |bdrv_query_blk_stats |
>                        |                     |
>                        +---------------------+
>=20
> So, we think its logic is complex, and its readability is low.
> There is no need to do so. Just let the function do its own thing.
>=20
> Now, we optimize them make sure that:
> 1. the func named bdrv_query_bds_stats do the work for the BDS.
> 2. the func named bdrv_query_blk_stats do the work for the Blocks.
> 3. the query func just call what the want actually in need.
>                                     +--------------+
>                                     |              |
>                            +--------v-----------+  |
>                        +--->  3.                |  |
> +-------------------+  |   |bdrv_query_bds_stats+--+
> | 1.                +--+   |                    |
> |                   +      +--------------------+
> |qmp_query_blockstats--+
> |                   |  |
> +-------------------+  |   +--------------------+
>                        |   | 2.                 |
>                        +--->                    |
>                            |bdrv_query_blk_stats|
>                            |                    |
>                            +--------------------+
>=20
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  block/qapi.c | 106 +++++++++++++++++++++++++++++------------------------=
------
>  1 file changed, 53 insertions(+), 53 deletions(-)

It's not immediately obvious that this change improves code readability.
53 insertions vs 53 deletions does not suggest a simplification.  I
guess it depends whether you prefer helper functions or open coding.

I'll leave the review of this patch to the maintainers of block/qapi.c.

>=20
> diff --git a/block/qapi.c b/block/qapi.c
> index a62e862..090452b 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -357,14 +357,14 @@ static void bdrv_query_info(BlockBackend *blk, Bloc=
kInfo **p_info,
>      qapi_free_BlockInfo(info);
>  }
> =20
> -static BlockStats *bdrv_query_stats(BlockBackend *blk,
> -                                    const BlockDriverState *bs,
> -                                    bool query_backing);
> -
> -static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
> +static BlockStats *bdrv_query_blk_stats(BlockStats *s, BlockBackend *blk)
>  {
>      BlockAcctStats *stats =3D blk_get_stats(blk);
>      BlockAcctTimedStats *ts =3D NULL;
> +    BlockDeviceStats *ds =3D s->stats;
> +
> +    s->has_device =3D true;
> +    s->device =3D g_strdup(blk_name(blk));
> =20
>      ds->rd_bytes =3D stats->nr_bytes[BLOCK_ACCT_READ];
>      ds->wr_bytes =3D stats->nr_bytes[BLOCK_ACCT_WRITE];
> @@ -426,11 +426,24 @@ static void bdrv_query_blk_stats(BlockDeviceStats *=
ds, BlockBackend *blk)
>          dev_stats->avg_wr_queue_depth =3D
>              block_acct_queue_depth(ts, BLOCK_ACCT_WRITE);
>      }
> +
> +    return s;
>  }
> =20
> -static void bdrv_query_bds_stats(BlockStats *s, const BlockDriverState *=
bs,
> +static BlockStats *bdrv_query_bds_stats(BlockStats *s,
> +                                 const BlockDriverState *bs,
>                                   bool query_backing)
>  {
> +
> +    if (!s) {
> +        s =3D g_malloc0(sizeof(*s));
> +        s->stats =3D g_malloc0(sizeof(*s->stats));
> +    }
> +
> +    if (!bs) {
> +        return s;
> +    }
> +
>      if (bdrv_get_node_name(bs)[0]) {
>          s->has_node_name =3D true;
>          s->node_name =3D g_strdup(bdrv_get_node_name(bs));
> @@ -440,32 +453,12 @@ static void bdrv_query_bds_stats(BlockStats *s, con=
st BlockDriverState *bs,
> =20
>      if (bs->file) {
>          s->has_parent =3D true;
> -        s->parent =3D bdrv_query_stats(NULL, bs->file->bs, query_backing=
);
> +        s->parent =3D bdrv_query_bds_stats(NULL, bs->file->bs, query_bac=
king);
>      }
> =20
>      if (query_backing && bs->backing) {
>          s->has_backing =3D true;
> -        s->backing =3D bdrv_query_stats(NULL, bs->backing->bs, query_bac=
king);
> -    }
> -
> -}
> -
> -static BlockStats *bdrv_query_stats(BlockBackend *blk,
> -                                    const BlockDriverState *bs,
> -                                    bool query_backing)
> -{
> -    BlockStats *s;
> -
> -    s =3D g_malloc0(sizeof(*s));
> -    s->stats =3D g_malloc0(sizeof(*s->stats));
> -
> -    if (blk) {
> -        s->has_device =3D true;
> -        s->device =3D g_strdup(blk_name(blk));
> -        bdrv_query_blk_stats(s->stats, blk);
> -    }
> -    if (bs) {
> -        bdrv_query_bds_stats(s, bs, query_backing);
> +        s->backing =3D bdrv_query_bds_stats(NULL, bs->backing->bs, query=
_backing);
>      }
> =20
>      return s;
> @@ -494,42 +487,49 @@ BlockInfoList *qmp_query_block(Error **errp)
>      return head;
>  }
> =20
> -static bool next_query_bds(BlockBackend **blk, BlockDriverState **bs,
> -                           bool query_nodes)
> -{
> -    if (query_nodes) {
> -        *bs =3D bdrv_next_node(*bs);
> -        return !!*bs;
> -    }
> -
> -    *blk =3D blk_next(*blk);
> -    *bs =3D *blk ? blk_bs(*blk) : NULL;
> -
> -    return !!*blk;
> -}
> -
>  BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
>                                       bool query_nodes,
>                                       Error **errp)
>  {
>      BlockStatsList *head =3D NULL, **p_next =3D &head;
> -    BlockBackend *blk =3D NULL;
> +    BlockBackend *blk;
>      BlockDriverState *bs =3D NULL;
> =20
>      /* Just to be safe if query_nodes is not always initialized */
> -    query_nodes =3D has_query_nodes && query_nodes;
> +    if (has_query_nodes && query_nodes) {
> +        while ((bs =3D bdrv_next_node(bs))) {
> +            BlockStatsList *info =3D g_malloc0(sizeof(*info));
> +            AioContext *ctx =3D bdrv_get_aio_context(bs);
> +            BlockStats *s;
> =20
> -    while (next_query_bds(&blk, &bs, query_nodes)) {
> -        BlockStatsList *info =3D g_malloc0(sizeof(*info));
> -        AioContext *ctx =3D blk ? blk_get_aio_context(blk)
> -                              : bdrv_get_aio_context(bs);
> +            s =3D g_malloc0(sizeof(*s));
> +            s->stats =3D g_malloc0(sizeof(*s->stats));
> =20
> -        aio_context_acquire(ctx);
> -        info->value =3D bdrv_query_stats(blk, bs, !query_nodes);
> -        aio_context_release(ctx);
> +            aio_context_acquire(ctx);
> +            info->value =3D bdrv_query_bds_stats(s, bs, false);
> +            aio_context_release(ctx);
> =20
> -        *p_next =3D info;
> -        p_next =3D &info->next;
> +            *p_next =3D info;
> +             p_next =3D &info->next;
> +        }
> +    } else {
> +        for (blk =3D blk_next(NULL); blk; blk =3D blk_next(blk)) {
> +            BlockStatsList *info =3D g_malloc0(sizeof(*info));
> +            AioContext *ctx =3D blk_get_aio_context(blk);
> +            BlockStats *s;
> +
> +            s =3D g_malloc0(sizeof(*s));
> +            s->stats =3D g_malloc0(sizeof(*s->stats));
> +            bs =3D blk_bs(blk);
> +
> +            aio_context_acquire(ctx);
> +            s =3D bdrv_query_blk_stats(s, blk);
> +            info->value =3D bdrv_query_bds_stats(s, bs, true);
> +            aio_context_release(ctx);
> +
> +            *p_next =3D info;
> +            p_next =3D &info->next;
> +        }
>      }
> =20
>      return head;
> --=20
> 2.5.5
>=20
>=20
>=20

--hUH5gZbnpyIv7Mn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYSTDwAAoJEJykq7OBq3PIQ3AH/2XBwhftv7bBeEs0UpqBOFH8
Jg8RSR9uiCFeoY5d4Up5dzVNc4+ucOCzFaRqYOs15V8gwOWGUTlOUM4g5TsIeXgs
V/wADavAXxEsR3V6A0BQ+2+zyMsJEEAahv3tZrZS97EMkRqUhZdjb2fDKOPcj+Pl
FViHUz/GcVBXHjPjQxp8Yaiwzxxb7r9tnS8ogixJk4TB9I/qN5F3GR69T9hKJ5Qs
6BR6gq6WXfraPphMDx5R0KYb5j7Jb0AoFW52i+AZTOVvHMCycWKhDPd45qU8AJU3
QgsIujnDdYeoykZbHy/0y7v39CTaGQnMI6gr+zHjf48yxMivDdIGE5NDbDGV82k=
=bSWr
-----END PGP SIGNATURE-----

--hUH5gZbnpyIv7Mn4--
