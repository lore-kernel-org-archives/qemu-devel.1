Received: from eggs.gnu.org ([2001:4830:134:3::10]:38557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cik3G-00081z-D4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cik3F-0001YJ-El
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:50:58 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-33-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <53b3e0fc-2368-8d8a-4ee0-ccc1fed774d1@redhat.com>
Date: Tue, 28 Feb 2017 16:50:47 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-33-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MF2NW7lelRl5L6PVfCaPX1gXgW899RmO9"
Subject: Re: [Qemu-devel] [PATCH v3 32/44] mirror: Use real permissions in
 mirror/active commit block job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MF2NW7lelRl5L6PVfCaPX1gXgW899RmO9
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <53b3e0fc-2368-8d8a-4ee0-ccc1fed774d1@redhat.com>
Subject: Re: [PATCH v3 32/44] mirror: Use real permissions in mirror/active
 commit block job
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-33-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-33-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:54, Kevin Wolf wrote:
> The mirror block job is mainly used for two different scenarios:
> Mirroring to an otherwise unused, independent target node, or for activ=
e
> commit where the target node is part of the backing chain of the source=
=2E
>=20
> Similarly to the commit block job patch, we need to insert a new filter=

> node to keep the permissions correct during active commit.
>=20
> Note that one change this implies is that job->blk points to
> mirror_top_bs as its root now, and mirror_top_bs (rather than the actua=
l
> source node) contains the bs->job pointer. This requires qemu-img commi=
t
> to get the job by name now rather than just taking bs->job.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c             | 216 +++++++++++++++++++++++++++++++++++++=
+-------
>  qemu-img.c                 |   6 +-
>  tests/qemu-iotests/141     |   2 +-
>  tests/qemu-iotests/141.out |   4 +-
>  4 files changed, 190 insertions(+), 38 deletions(-)

BTW, seeing this commit made me remember that the additional functions I
requested for the dummy block driver (flush etc.) were not meant to be
limited to mirror; the commit node would need get_block_status, too, of
course (not necessarily flush, discard, or write_zeroes, because the
commit node doesn't allow writing anyway). Can be fixed during freeze,
though.

> diff --git a/block/mirror.c b/block/mirror.c
> index beaac6f..a2f22e1 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c

[...]

> @@ -983,6 +1005,77 @@ static const BlockJobDriver commit_active_job_dri=
ver =3D {
>      .drain                  =3D mirror_drain,
>  };
> =20
> +static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
> +    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
> +{
> +    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
> +}
> +
> +static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
> +    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
> +{
> +    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
> +}
> +
> +static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
> +{
> +    return bdrv_co_flush(bs->backing->bs);
> +}
> +
> +static int64_t coroutine_fn bdrv_mirror_top_get_block_status(
> +    BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnu=
m,
> +    BlockDriverState **file)
> +{
> +    *pnum =3D nb_sectors;
> +    *file =3D bs->backing->bs;
> +    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA =
|

BDRV_BLOCK_RAW makes bdrv_co_get_block_status() fall through to
bs->file, though.

I'm willing to turn two blind eyes on this, though, and consider that to
be a bug in bdrv_co_get_block_status(); it should fall through to *file.

OTOH, as I said before, the bs->backing without bs->file thing also
breaks bdrv_refresh_filename(). We could fix that, too, by falling
through to bs->backing if there is no bs->file, but that would be a
hack. The other solution is to implement .bdrv_refresh_filename(), of
course.

Since I only have two eyes I can turn blind, I can't really give an R-b, =
so:

Acked-by: Max Reitz <mreitz@redhat.com>

> +           (sector_num << BDRV_SECTOR_BITS);
> +}


--MF2NW7lelRl5L6PVfCaPX1gXgW899RmO9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1nFgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AvNMH/1wIfr/N+9cmtuOlLD/ETt126ehiBvKM
v3HHBgxYgLUNva8H89jD+HJSOkCi5a9c2spi84l6roVRbvIwehnRhxUThoPr3o8F
GDrjz1tZEqOCv3rNjZO2PL9cVM3JKpKv6P+VTkuAlNdtwRODLbBCRLwqzlufGQir
IM/kEYT2eRIivBJV0iQuWKybEuBUrcti8jZE5HiX4F5lWNM6LKBUcPko15NN48bJ
os6vU7+yJri37uDncGU1qPFVzD9VOeYUobiaZlYRlFyHxZv5Pof7215Lawao14EQ
suRhEFsPvv8MnjcZlDN3D6TXPzl4/gW+GTiT2N8xBRHsgupKQ3xTtc0=
=7wjs
-----END PGP SIGNATURE-----

--MF2NW7lelRl5L6PVfCaPX1gXgW899RmO9--
