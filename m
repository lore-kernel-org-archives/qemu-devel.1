Received: from eggs.gnu.org ([2001:4830:134:3::10]:35671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYlCF-0003pV-15
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 22:03:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYlCB-0002us-UW
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 22:02:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cYlCB-0002uD-Ma
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 22:02:55 -0500
References: <1484467275-27919-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1484467275-27919-3-git-send-email-douly.fnst@cn.fujitsu.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4cefe208-abf3-99ea-0c8b-a36b3c5e2e96@redhat.com>
Date: Wed, 1 Feb 2017 04:02:49 +0100
MIME-Version: 1.0
In-Reply-To: <1484467275-27919-3-git-send-email-douly.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5Cm48VlC0NW4Ft6GJBhOvPXE63JNUG0Q5"
Subject: Re: [Qemu-devel] [PATCH v4 2/2] block/qapi: reduce the execution
 time of qmp_query_blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Cm48VlC0NW4Ft6GJBhOvPXE63JNUG0Q5
From: Max Reitz <mreitz@redhat.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com,
 caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com
Message-ID: <4cefe208-abf3-99ea-0c8b-a36b3c5e2e96@redhat.com>
Subject: Re: [PATCH v4 2/2] block/qapi: reduce the execution time of
 qmp_query_blockstats
References: <1484467275-27919-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1484467275-27919-3-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1484467275-27919-3-git-send-email-douly.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 15.01.2017 09:01, Dou Liyang wrote:
> In order to reduce the execution time, this patch optimize
> the qmp_query_blockstats():
> Remove the next_query_bds function.
> Remove the bdrv_query_stats function.
> Remove some judgement sentence.
>=20
> The original qmp_query_blockstats calls next_query_bds to get
> the next objects in each loops. In the next_query_bds, it checks
> the query_nodes and blk. It also call bdrv_query_stats to get
> the stats, In the bdrv_query_stats, it checks blk and bs each
> times. This waste more times, which may stall the main loop a
> bit. And if the disk is too many and donot use the dataplane
> feature, this may affect the performance in main loop thread.
>=20
> This patch removes that two functions, and makes the structure
> clearly.
>=20
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  block/qapi.c | 73 ++++++++++++++++++++++++----------------------------=
--------
>  1 file changed, 29 insertions(+), 44 deletions(-)
>=20
> diff --git a/block/qapi.c b/block/qapi.c
> index bc622cd..45e9d47 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -456,23 +456,6 @@ static BlockStats *bdrv_query_bds_stats(const Bloc=
kDriverState *bs,
>      return s;
>  }
> =20
> -static BlockStats *bdrv_query_stats(BlockBackend *blk,
> -                                    const BlockDriverState *bs,
> -                                    bool query_backing)
> -{
> -    BlockStats *s;
> -
> -    s =3D bdrv_query_bds_stats(bs, query_backing);
> -
> -    if (blk) {
> -        s->has_device =3D true;
> -        s->device =3D g_strdup(blk_name(blk));
> -        bdrv_query_blk_stats(s->stats, blk);
> -    }
> -
> -    return s;
> -}
> -
>  BlockInfoList *qmp_query_block(Error **errp)
>  {
>      BlockInfoList *head =3D NULL, **p_next =3D &head;
> @@ -496,42 +479,44 @@ BlockInfoList *qmp_query_block(Error **errp)
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
> -    BlockDriverState *bs =3D NULL;
> +    BlockBackend *blk;
> +    BlockDriverState *bs;
> =20
>      /* Just to be safe if query_nodes is not always initialized */
> -    query_nodes =3D has_query_nodes && query_nodes;
> -
> -    while (next_query_bds(&blk, &bs, query_nodes)) {
> -        BlockStatsList *info =3D g_malloc0(sizeof(*info));
> -        AioContext *ctx =3D blk ? blk_get_aio_context(blk)
> -                              : bdrv_get_aio_context(bs);
> +    if (has_query_nodes && query_nodes) {
> +        for (bs =3D bdrv_next_node(NULL); bs; bs =3D bdrv_next_node(bs=
)) {
> +            BlockStatsList *info =3D g_malloc0(sizeof(*info));
> +            AioContext *ctx =3D bdrv_get_aio_context(bs);
> =20
> -        aio_context_acquire(ctx);
> -        info->value =3D bdrv_query_stats(blk, bs, !query_nodes);
> -        aio_context_release(ctx);
> +            aio_context_acquire(ctx);
> +            info->value =3D bdrv_query_bds_stats(bs, false);
> +            aio_context_release(ctx);
> =20
> -        *p_next =3D info;
> -        p_next =3D &info->next;
> +            *p_next =3D info;
> +            p_next =3D &info->next;
> +        }
> +    } else {
> +        for (blk =3D blk_next(NULL); blk; blk =3D blk_next(blk)) {
> +            BlockStatsList *info =3D g_malloc0(sizeof(*info));
> +            AioContext *ctx =3D blk_get_aio_context(blk);
> +            BlockStats *s;
> +
> +            aio_context_acquire(ctx);
> +            info->value =3D s =3D bdrv_query_bds_stats(blk_bs(blk), tr=
ue);

Superfluous assignment to info->value here...

> +            s->has_device =3D true;
> +            s->device =3D g_strdup(blk_name(blk));
> +            bdrv_query_blk_stats(s->stats, blk);
> +            aio_context_release(ctx);
> +
> +            info->value =3D s;

=2E..since it's written here anyway. I'll remove the first assignment whe=
n
applying the patch to my tree.

Max

> +            *p_next =3D info;
> +            p_next =3D &info->next;
> +        }
>      }
> =20
>      return head;
>=20



--5Cm48VlC0NW4Ft6GJBhOvPXE63JNUG0Q5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRT9oSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AqC4H/Axz+66inniM2mVH6unUTbUJXbKnrjvc
ixYVYPer5Q/UyjDEE0p7bZGMXyRAkcr51udrM5D6zkPGxZxz2oFwlXcnfq+tYwf4
M3YC8C/Ud3CHE9MGOVZBHOh+ywefEnJy/kahixLwhTeHzV+vZPvC65DWHaJsw6La
Vp2EA0XrpgcEMr/xJPA2Lt3np9yAH2/TOZ+dSmhL5nACZc+w2Y5xf6QsgWOUgsWt
gR0BTKNxQ3e8yLuK6od1ZhlihdHP3nfWzICTP5vKqA/oDfLaDkM9VYS/kaNENXeA
3nBrIPRA2kilbDsh/3t6ovNC4EOkFo23nqBG5LgncVFjWxQePkJqZ/c=
=GCLf
-----END PGP SIGNATURE-----

--5Cm48VlC0NW4Ft6GJBhOvPXE63JNUG0Q5--
