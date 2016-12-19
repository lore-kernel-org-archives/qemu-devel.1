Received: from eggs.gnu.org ([2001:4830:134:3::10]:54691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIz1m-0004LQ-N5
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIz1j-0007YH-L3
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:34:58 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cIz1j-0007Y3-EE
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:34:55 -0500
Received: by mail-wm0-x244.google.com with SMTP id a20so19034326wme.2
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 06:34:55 -0800 (PST)
Date: Mon, 19 Dec 2016 14:34:52 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161219143452.GG17374@stefanha-x1.localdomain>
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1482137486-9843-4-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Content-Disposition: inline
In-Reply-To: <1482137486-9843-4-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 3/4] block/qapi: acquire a reference
 instead of a lock during querying blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, famz@redhat.com, danpb@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2016 at 04:51:25PM +0800, Dou Liyang wrote:
> This patch works to improve the performance of the query requests.
>=20
> From the commit 13344f3a, it adds a lock to make query-blockstats
> safe by the aio_context_acquire(). the qmp_query_blockstats func
> requires/releases the AioContext lock, which takes some time and
> blocks the I/O processing. It affects the performance, especially
> in the multi-disks guests.
>=20
> As the low-level details of block statistics inside QEMU, we can
> acquire a reference instead of the lock.
>=20
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  block/qapi.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

This patch changes the locking rules for blk_get_stats() (this covers a
lot of fields), bdrv_get_node_name(), and blk_name().

You must document the new locking rules for these fields in
block-backend.h, block_int.h, etc.

> diff --git a/block/qapi.c b/block/qapi.c
> index bc622cd..2262918 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -457,17 +457,21 @@ static BlockStats *bdrv_query_bds_stats(const Block=
DriverState *bs,
>  }
> =20
>  static BlockStats *bdrv_query_stats(BlockBackend *blk,
> -                                    const BlockDriverState *bs,
> +                                    BlockDriverState *bs,
>                                      bool query_backing)
>  {
>      BlockStats *s;
> =20
> +    bdrv_ref(bs);
>      s =3D bdrv_query_bds_stats(bs, query_backing);
> +    bdrv_unref(bs);
> =20
>      if (blk) {
> +        blk_ref(blk);
>          s->has_device =3D true;
>          s->device =3D g_strdup(blk_name(blk));
>          bdrv_query_blk_stats(s->stats, blk);
> +        blk_unref(blk);

This does not look correct.  The caller passed in bs and blk so they
must already have a reference.  If not, then what protects bs and blk
=66rom deletion before/after this function is called?

>      }
> =20
>      return s;
> @@ -523,13 +527,8 @@ BlockStatsList *qmp_query_blockstats(bool has_query_=
nodes,
> =20
>      while (next_query_bds(&blk, &bs, query_nodes)) {
>          BlockStatsList *info =3D g_malloc0(sizeof(*info));
> -        AioContext *ctx =3D blk ? blk_get_aio_context(blk)
> -                              : bdrv_get_aio_context(bs);
> =20
> -        aio_context_acquire(ctx);
>          info->value =3D bdrv_query_stats(blk, bs, !query_nodes);
> -        aio_context_release(ctx);
> -
>          *p_next =3D info;
>          p_next =3D &info->next;
>      }
> --=20
> 2.5.5
>=20
>=20
>=20
>=20

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYV/AMAAoJEJykq7OBq3PIvhcH/RuwWEb4kQ0UYTIQvoDcdUt5
eGpcPL0S1J7qI2Pyp6/buXnPwGLqIbQdcL8LrMkXUDb6RmKef5oZ6F7oW1zzwoT+
V3m52CZRE5SW7XFeFeHQ479IGni9V8FsMjJVjbzFNZHJnrQDFHtYTvMGOJ3yqZn0
s0zYQyDkPncDc+4u5W9nn6BpTmtgxBA4zNX/pSMeuI9fFmwk/VLfXD/AXAUQ6iY6
/ylPNflQdIqTQUid6GDWddL67Ogew050SkuIosT+sMXlflHnORhfKUurBWCI2xWL
k6OXxjOTC9hqrR+jD7BQEtrl2AZkaWs/WD0vpGVw/61maYtk/Ck8CiSpDQxr4PI=
=Xrkb
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--
