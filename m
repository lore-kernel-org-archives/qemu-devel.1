Received: from eggs.gnu.org ([2001:4830:134:3::10]:58364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQkcv-00025y-74
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQkcu-0001sS-6V
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:21:41 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-11-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <48d6c620-a33c-3495-20e9-996d3b2db8cd@redhat.com>
Date: Fri, 30 Jun 2017 03:21:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170628120530.31251-11-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9N5SmIXSojS2eIdk5Bo2VFn5XNcQD64bO"
Subject: Re: [Qemu-devel] [PATCH v22 10/30] block/dirty-bitmap: add readonly
 field to BdrvDirtyBitmap
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
--9N5SmIXSojS2eIdk5Bo2VFn5XNcQD64bO
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <48d6c620-a33c-3495-20e9-996d3b2db8cd@redhat.com>
Subject: Re: [PATCH v22 10/30] block/dirty-bitmap: add readonly field to
 BdrvDirtyBitmap
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
 <20170628120530.31251-11-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-28 14:05, Vladimir Sementsov-Ogievskiy wrote:
> It will be needed in following commits for persistent bitmaps.
> If bitmap is loaded from read-only storage (and we can't mark it
> "in use" in this storage) corresponding BdrvDirtyBitmap should be
> read-only.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         | 36 ++++++++++++++++++++++++++++++++++++=

>  block/io.c                   |  8 ++++++++
>  blockdev.c                   |  6 ++++++
>  include/block/dirty-bitmap.h |  4 ++++
>  4 files changed, 54 insertions(+)
>=20
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index a8fe149c4a..17d3068336 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c

[...]

> @@ -635,3 +646,28 @@ int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap =
*bitmap)
>  {
>      return hbitmap_count(bitmap->meta);
>  }
> +
> +bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap)
> +{
> +    return bitmap->readonly;
> +}
> +
> +/* Called with BQL taken. */
> +void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool valu=
e)
> +{
> +    qemu_mutex_lock(bitmap->mutex);
> +    bitmap->readonly =3D value;
> +    qemu_mutex_unlock(bitmap->mutex);
> +}

I find it a bit strange to acquire the mutex if this function is called
with the BQL taken (which I agree it should be) -- but Paolo has given
his OK and I don't think it does harm to acquire the mutex even under BQL=
=2E

Max

> +
> +bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
> +{
> +    BdrvDirtyBitmap *bm;
> +    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
> +        if (bm->readonly) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}


--9N5SmIXSojS2eIdk5Bo2VFn5XNcQD64bO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVaeREhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQDZf
B/9AqiubhOmXcN4kLuc6os2CN3ObQmdtBs/267CY971Jl9owendR+sfevpHbf+jC
BqNSnqjEDnkKHxjXHcZLitZrIsf+P0R8iZ9nrKQ7pyolmNmTwzZTbBYb3jIDMtTO
37leUbKr+OHyecMTdNomRcfOVAVUHen4fqNcf8f+BZFK8gXXjO5QKcBb7Z3FGVKU
FWXNpkxYW+TZAAmoAJcGJSFF8I0eIBRwY2Z3l9iy+nU6mZYEaScd7sJD7VCSzXCs
16DafMmptgplXut5cZfOTM77nZ0q7AQpguSSsGc/QR7TrWrnmk8Bom2QjRPldVyX
hfRvilAjq1ARVr0hrwC+NXwr
=or1o
-----END PGP SIGNATURE-----

--9N5SmIXSojS2eIdk5Bo2VFn5XNcQD64bO--
