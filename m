Received: from eggs.gnu.org ([2001:4830:134:3::10]:33823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eyHZ2-0005sA-So
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eyHZ1-000642-SG
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:44:32 -0400
References: <20180319090223.23336-1-vsementsov@virtuozzo.com>
	<20180319090223.23336-3-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <49811577-7ac5-6c39-b19e-3ec56313bc65@redhat.com>
Date: Tue, 20 Mar 2018 14:44:21 +0100
MIME-Version: 1.0
In-Reply-To: <20180319090223.23336-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5WL4G1eDcecxukdOIxX6hgJju8qgYKDTQ"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] qcow2: handle reopening bitmaps on
 bdrv_invalidate_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5WL4G1eDcecxukdOIxX6hgJju8qgYKDTQ
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <49811577-7ac5-6c39-b19e-3ec56313bc65@redhat.com>
Subject: Re: [PATCH v3 2/3] qcow2: handle reopening bitmaps on
 bdrv_invalidate_cache
References: <20180319090223.23336-1-vsementsov@virtuozzo.com>
 <20180319090223.23336-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180319090223.23336-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-19 10:02, Vladimir Sementsov-Ogievskiy wrote:
> Consider migration with shared storage. Persistent bitmaps are stored
> on bdrv_inactivate. Then, on destination
> process_incoming_migration_bh() calls bdrv_invalidate_cache_all() which=

> leads to qcow2_load_autoloading_dirty_bitmaps() which fails if bitmaps
> are already loaded on destination start. In this case we should call
> qcow2_reopen_bitmaps_rw instead.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  block/qcow2.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7472af6931..6219666d4a 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1480,7 +1480,13 @@ static int coroutine_fn qcow2_do_open(BlockDrive=
rState *bs, QDict *options,
>          s->autoclear_features &=3D QCOW2_AUTOCLEAR_MASK;
>      }
> =20
> -    if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
> +    if (bdrv_has_readonly_bitmaps(bs)) {

So if there are any read-only bitmaps, we'll skip
qcow2_load_dirty_bitmaps() altogether.  That doesn't seem so bad because
qcow2_load_dirty_bitmaps() seems to assume no bitmaps have been loaded ye=
t.

But if that's the case, shouldn't we skip that function if any bitmap
has been loaded already, RO or R/W?  (And we can call
qcow2_reopen_bitmaps_rw_hint() even if there aren't any RO bitmaps, it
just won't do anything then.)

This doesn't make this patch really wrong, I'm just wondering whether it
can do better.  (To add to that, I don't even know whether there is a
case where qcow2_do_open() would be called with any R/W bitmaps already
present.)

Max

> +        if (!bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_IN=
ACTIVE)) {
> +            bool header_updated =3D false;
> +            qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_e=
rr);
> +            update_header =3D update_header && !header_updated;
> +        }
> +    } else if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
>          update_header =3D false;
>      }
>      if (local_err !=3D NULL) {
>=20



--5WL4G1eDcecxukdOIxX6hgJju8qgYKDTQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqxEDUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AkJkH/Rn2UpWcKHUdM18NqGyrH0LjhOGRnWLL
CVIVYnrFl1skwEzHOTDGfMqsjH5aM8NBTLglSmPoHSNGUR1QLnwbvaYSbx7TgTPi
wxCqmkX+wci4irNmvouUb+xolME6Re9Xh5E12b9fP+LAsB5EVRqO/QkCkwmZojAe
oKz1HhpG5LEf3pKBrWqlVW+XwgFnzRx/BBkIbdSGZpKJCTZyQrlklkXNi2N+SOAe
aEKjIYIwQD5JWF/wHzdUGV6V+H4yZMGWyOqeyG+iYzrh0WQRDcQGktu5YUptoweV
KmpkZANzc/mrKmg59+c/scI/EYhuZP4COc/LSrEr7ZrB52lQhfxHW3s=
=eIUt
-----END PGP SIGNATURE-----

--5WL4G1eDcecxukdOIxX6hgJju8qgYKDTQ--
