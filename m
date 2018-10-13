Received: from eggs.gnu.org ([2001:4830:134:3::10]:40813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gBKOT-0001Hm-F7
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 09:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gBKOS-0007qF-Mp
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 09:55:49 -0400
References: <20181009150006.10712-1-vsementsov@virtuozzo.com>
	<20181009150006.10712-2-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <25ab8194-078c-aee7-a9fa-ea1e5310621d@redhat.com>
Date: Sat, 13 Oct 2018 15:55:34 +0200
MIME-Version: 1.0
In-Reply-To: <20181009150006.10712-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jyM9PuByDMXVV17SjdohWWyszpGHXkGki"
Subject: Re: [Qemu-devel] [PATCH v4 1/3] qapi: add x-debug-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jyM9PuByDMXVV17SjdohWWyszpGHXkGki
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com,
 armbru@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <25ab8194-078c-aee7-a9fa-ea1e5310621d@redhat.com>
Subject: Re: [PATCH v4 1/3] qapi: add x-debug-query-block-graph
References: <20181009150006.10712-1-vsementsov@virtuozzo.com>
 <20181009150006.10712-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181009150006.10712-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.10.18 17:00, Vladimir Sementsov-Ogievskiy wrote:
> Add a new command, returning block nodes (and their users) graph.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json           | 108 ++++++++++++++++++++++++
>  include/block/block.h          |   1 +
>  include/sysemu/block-backend.h |   2 +
>  block.c                        | 146 +++++++++++++++++++++++++++++++++=

>  block/block-backend.c          |   5 ++
>  blockdev.c                     |   5 ++
>  6 files changed, 267 insertions(+)

[...]

> diff --git a/block.c b/block.c
> index 7710b399a3..90825f427f 100644
> --- a/block.c
> +++ b/block.c
> @@ -4047,6 +4047,152 @@ BlockDeviceInfoList *bdrv_named_nodes_list(Erro=
r **errp)

[...]

> +BlockGraph *bdrv_get_block_graph(Error **errp)
> +{
> +    BlockBackend *blk;
> +    BlockJob *job;
> +    BlockDriverState *bs;
> +    BdrvChild *child;
> +    BlockGraphConstructor *gr =3D dbg_graph_new();
> +
> +    for (blk =3D blk_all_next(NULL); blk; blk =3D blk_all_next(blk)) {=

> +        char *allocated_name =3D NULL;
> +        const char *name =3D blk_name(blk);
> +
> +        if (!name) {

blk_name() never returns NULL, so you need to check for !*name here.

The rest looks OK, although I realized that maybe we want to use the
QAPI type name "BlockGraph" for a non-debug command in the future.  But
I think that as long as it's only this command providing that structure,
we should be free to rename it should the need arise.

(And introspection doesn't care about structure names, I think.)

Max

> +            name =3D allocated_name =3D blk_get_attached_dev_id(blk);
> +        }
> +        dbg_graph_add_node(gr, blk, BLOCK_GRAPH_NODE_TYPE_BLOCK_BACKEN=
D, name);
> +        g_free(allocated_name);
> +        if (blk_root(blk)) {
> +            dbg_graph_add_edge(gr, blk, blk_root(blk));
> +        }
> +    }


--jyM9PuByDMXVV17SjdohWWyszpGHXkGki
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvB+VYACgkQ9AfbAGHV
z0A7MQf7BkdFdG+7063tYYKHpFt4bDLbYDgGO5eatun4pQ2jLPx2WXSiG9n5vCNf
lUbSnMahuaOK9TRFGQuBLDm4a4RXU/9eSCp4sUKgf++DlcjRYQnDYnlzeNMkpT8x
M9Ty1oLOl9maeadjtsbvVuaYchXBBXWwDW9BiP0SlsI+MoFLjk1IIsEwwjWyYvj4
8MXcavbxFAGBXBtoSW40ln7OMRzKmLBuaIQXPGkIUbyDpC+e6T9mMYkHn6vH8HTV
Jew4ROg9yPY7pLxjyemjBUZ2n/sWpKs8Z1A8ZF/cfayUW9jdJZiWbm/THfy93NeI
nDd8gd8aO+b5mPqmdq/eaON2gta2Yg==
=weOB
-----END PGP SIGNATURE-----

--jyM9PuByDMXVV17SjdohWWyszpGHXkGki--
