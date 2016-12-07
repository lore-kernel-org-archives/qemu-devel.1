Received: from eggs.gnu.org ([2001:4830:134:3::10]:48658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEjLJ-0006sQ-EQ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 16:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEjLI-00014S-NG
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 16:01:33 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-12-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <61fd8b23-89af-0c50-e5c6-dd561c785414@redhat.com>
Date: Wed, 7 Dec 2016 22:01:18 +0100
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-12-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2TVch3owVaDnAfSDbP7oIwft0usWxeftO"
Subject: Re: [Qemu-devel] [PATCH 11/21] block: introduce persistent dirty
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2TVch3owVaDnAfSDbP7oIwft0usWxeftO
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <61fd8b23-89af-0c50-e5c6-dd561c785414@redhat.com>
Subject: Re: [PATCH 11/21] block: introduce persistent dirty bitmaps
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-12-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479835586-74394-12-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
> New field BdrvDirtyBitmap.persistent means, that bitmap should be saved=

> on bdrv_close, using format driver. Format driver should maintain bitma=
p
> storing.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                      | 31 +++++++++++++++++++++++++++++++
>  block/dirty-bitmap.c         | 26 ++++++++++++++++++++++++++
>  block/qcow2-bitmap.c         |  1 +
>  include/block/block.h        |  1 +
>  include/block/block_int.h    |  2 ++
>  include/block/dirty-bitmap.h |  6 ++++++
>  6 files changed, 67 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 450379c..4e1f16a 100644
> --- a/block.c
> +++ b/block.c
> @@ -2321,6 +2321,7 @@ void bdrv_reopen_abort(BDRVReopenState *reopen_st=
ate)
>  static void bdrv_close(BlockDriverState *bs)
>  {
>      BdrvAioNotifier *ban, *ban_next;
> +    Error *local_err =3D NULL;
> =20
>      assert(!bs->job);
>      assert(!bs->refcnt);
> @@ -2329,6 +2330,11 @@ static void bdrv_close(BlockDriverState *bs)
>      bdrv_flush(bs);
>      bdrv_drain(bs); /* in case flush left pending I/O */
> =20
> +    bdrv_store_persistent_dirty_bitmaps(bs, &local_err);
> +    if (local_err !=3D NULL) {
> +        error_report_err(local_err);
> +        error_report("Persistent bitmaps are lost");

:C

Reviewed-by: Max Reitz <mreitz@redhat.com>

But could you maybe add at least the node name to the error message?

Max

> +    }
>      bdrv_release_named_dirty_bitmaps(bs);
>      assert(QLIST_EMPTY(&bs->dirty_bitmaps));


--2TVch3owVaDnAfSDbP7oIwft0usWxeftO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhIeJ4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AmJgH/06huvbdDsnM6Fz2sLdS32v5YmuBdWpn
UAPiMkfQeN5UBld4kXgRbI5M27UCHihK03ZyLxMGBZiA1mp2Ba/C2CxUFkte3ZBM
tEaB9vkMOrqP9E9wb7RLGdpdYOtPcwClvyOGE3ojFKEcoAeFjMtyjMNcMwJuCkpv
qbcZ/Brwi8uqHv+WQn1zuWXvHA4ES7g0jUX0cCoBKfYqj+V/fWk9Dy3mIF7qFcEL
yL/GUnuIQuugVqdkvkJmBOT5QtIZc+3u+7JaD14ysh+q6NTWtcq++MnjWqi3d/xY
5s47RaAEyHU767SH12p//g2ijQzuRxOU3bz6HN+wYjjQlbV2CjzRoTA=
=H4jl
-----END PGP SIGNATURE-----

--2TVch3owVaDnAfSDbP7oIwft0usWxeftO--
