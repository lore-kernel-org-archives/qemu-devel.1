Received: from eggs.gnu.org ([209.51.188.92]:34967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go9Ou-0000s6-20
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go9Oo-0002dN-9m
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:04:42 -0500
References: <20190128151521.13875-1-antonkuchin@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9c6b6121-a071-58a3-942a-2f3909549782@redhat.com>
Date: Mon, 28 Jan 2019 17:04:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190128151521.13875-1-antonkuchin@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qmp: Deprecate query-nodes option of
 query-blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

On 2019-01-28 16:15, Anton Kuchin wrote:
> This option is broken since a6baa60807 in v2.9 and returns mostly
> zeroes instead of real stats because actual querring of BlockStats

s/querring/querying/

> that resides in blk is missing.
>=20
> And it makes no sense because with this option BlockDriverState-s
> are iterated but BlockAcctStats belong to BlockBackend and not BDS
> since 7f0e9da6f13 in v2.5
>=20
> Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
> ---
[...]
> @@ -577,21 +576,10 @@ BlockStatsList *qmp_query_blockstats(bool has_que=
ry_nodes,
>  {
>      BlockStatsList *head =3D NULL, **p_next =3D &head;
>      BlockBackend *blk;
> -    BlockDriverState *bs;
> =20
>      /* Just to be safe if query_nodes is not always initialized */
>      if (has_query_nodes && query_nodes) {
> -        for (bs =3D bdrv_next_node(NULL); bs; bs =3D bdrv_next_node(bs=
)) {
> -            BlockStatsList *info =3D g_malloc0(sizeof(*info));
> -            AioContext *ctx =3D bdrv_get_aio_context(bs);
> -
> -            aio_context_acquire(ctx);
> -            info->value =3D bdrv_query_bds_stats(bs, false);
> -            aio_context_release(ctx);
> -
> -            *p_next =3D info;
> -            p_next =3D &info->next;
> -        }
> +        error_setg(errp, "Option query_nodes is deprecated");

You don't only deprecate the option here, you completely disable it ...
that does not make too much sense IMHO. If it is really broken since
multiple releases already and nobody complained or tried to fix it so
far, I think it could be simply removed immediately. Otherwise, if it is
only partly broken, please leave it in the current state (if it is not
fixable), and only mark it as deprecated in the qemu-deprecated.texi and
block-core.json documentation.

>      } else {
>          for (blk =3D blk_all_next(NULL); blk; blk =3D blk_all_next(blk=
)) {
>              BlockStatsList *info;
> @@ -604,7 +592,7 @@ BlockStatsList *qmp_query_blockstats(bool has_query=
_nodes,
>              }
> =20
>              aio_context_acquire(ctx);
> -            s =3D bdrv_query_bds_stats(blk_bs(blk), true);
> +            s =3D bdrv_query_bds_stats(blk_bs(blk));
>              s->has_device =3D true;
>              s->device =3D g_strdup(blk_name(blk));
> =20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 91685be6c2..2dd5f6032c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -892,13 +892,7 @@
>  #
>  # Query the @BlockStats for all virtual block devices.
>  #
> -# @query-nodes: If true, the command will query all the block nodes
> -#               that have a node name, in a list which will include "p=
arent"
> -#               information, but not "backing".
> -#               If false or omitted, the behavior is as before - query=
 all the
> -#               device backends, recursively including their "parent" =
and
> -#               "backing". Filter nodes that were created implicitly a=
re
> -#               skipped over in this mode. (Since 2.3)
> +# @query-nodes: deprecated since 3.2
>  #
>  # Returns: A list of @BlockStats for each virtual block devices.
>  #
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 219206a836..e1e04ced7d 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -112,6 +112,11 @@ Use ``device_add'' for hotplugging vCPUs instead o=
f ``cpu-add''.  See
>  documentation of ``query-hotpluggable-cpus'' for additional
>  details.
> =20
> +@subsection query-blockstats (since 3.2)
> +
> +"query-nodes" parameter is not supported anymore because blockstats
> +are not a prorerty of node.

s/prorerty/property/

>  @section Human Monitor Protocol (HMP) commands
> =20
>  @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (=
since 3.1)
>=20

 Thomas
