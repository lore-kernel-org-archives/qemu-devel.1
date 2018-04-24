Received: from eggs.gnu.org ([2001:4830:134:3::10]:55094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB1XP-00046q-3A
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB1XN-0000xo-Mu
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:15:30 -0400
Date: Tue, 24 Apr 2018 19:15:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180424171524.GH4080@localhost.localdomain>
References: <20180215192829.9944-1-eblake@redhat.com>
	<20180215192829.9944-2-eblake@redhat.com>
	<20180424154026.GC4080@localhost.localdomain>
	<7e74c08c-9086-ac07-fac4-8a75fb716f29@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <7e74c08c-9086-ac07-fac4-8a75fb716f29@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] block: Support byte-based aio callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 24.04.2018 um 19:06 hat Eric Blake geschrieben:
> On 04/24/2018 10:40 AM, Kevin Wolf wrote:
> > Am 15.02.2018 um 20:28 hat Eric Blake geschrieben:
> >> We are gradually moving away from sector-based interfaces, towards
> >> byte-based.  Add new sector-based aio callbacks for read and write,
> >> to match the fact that bdrv_aio_pdiscard is already byte-based.
> >>
> >> Ideally, drivers should be converted to use coroutine callbacks
> >> rather than aio; but that is not quite as trivial (if we do that
> >> conversion, the null-aio driver will disappear), so for the
> >> short term, converting the signature but keeping things with aio
> >> is easier.  Once all drivers are converted, the sector-based aio
> >> callbacks will be removed.
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >> ---
> >>  include/block/block_int.h |  6 ++++++
> >>  block/io.c                | 37 +++++++++++++++++++++++++++----------
> >>  2 files changed, 33 insertions(+), 10 deletions(-)
> >>
>=20
> >> +++ b/block/io.c
> >> @@ -934,9 +934,11 @@ static int coroutine_fn bdrv_driver_preadv(BlockD=
riverState *bs,
> >>      sector_num =3D offset >> BDRV_SECTOR_BITS;
> >>      nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
> >>
> >> -    assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
> >> -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
> >> -    assert((bytes >> BDRV_SECTOR_BITS) <=3D BDRV_REQUEST_MAX_SECTORS);
> >> +    if (!drv->bdrv_aio_preadv) {
> >> +        assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
> >> +        assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
> >> +        assert((bytes >> BDRV_SECTOR_BITS) <=3D BDRV_REQUEST_MAX_SECT=
ORS);
> >> +    }
> >=20
> > Hm, this is kind of ugly. Previously, we handled everything byte-aligned
> > in the first section, now we mix both in the second section.
> >=20
> > I can see that you do this so you don't have to duplicate the acb and
> > coroutine yielding code below, but can we move things into the right
> > place in the final patch at least? That is, calculate sector_num and
> > nb_sectors only if all the byte-based interfaces weren't available.
>=20
> Yeah, that's easy enough to squash into patch 6:
>=20
> diff --git i/block/io.c w/block/io.c
> index ba767612931..49fabe8eeb1 100644
> --- i/block/io.c
> +++ w/block/io.c
> @@ -924,16 +924,13 @@ static int coroutine_fn
> bdrv_driver_preadv(BlockDriverState *bs,
>          return drv->bdrv_co_preadv(bs, offset, bytes, qiov, flags);
>      }
>=20
> -    sector_num =3D offset >> BDRV_SECTOR_BITS;
> -    nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
> -
> -    if (!drv->bdrv_aio_preadv) {
> -        assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
> -        assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
> -        assert((bytes >> BDRV_SECTOR_BITS) <=3D BDRV_REQUEST_MAX_SECTORS=
);
> -    }
> -
>      if (drv->bdrv_co_readv) {
> +        sector_num =3D offset >> BDRV_SECTOR_BITS;
> +        nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
> +
> +        assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
> +        assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
> +        assert((bytes >> BDRV_SECTOR_BITS) <=3D BDRV_REQUEST_MAX_SECTORS=
);
>          return drv->bdrv_co_readv(bs, sector_num, nb_sectors, qiov);
>      } else {
>          BlockAIOCB *acb;

Ah, yes. I thought of moving the code in the else block, but this works,
too. Maybe it's even a bit nicer.

Kevin

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa32YsAAoJEH8JsnLIjy/WbhIP/jgHH43pwdFcFidlb26Gb7UY
g5FBH2FHaai1Z5b4MoDROAw9MSAmaH7YTQg3nCqsRkvfLJELFeqhR5LTgfHEKkva
/or35iJDQ8uMGF7q7X/I4dQpmcw94zW19Pp8nsEkN0O9BnfHW1YsVq9VgolEdpnK
hFhood5IayFwu4RX2XgHAqf785HXQeRHxEkOgnKVWf+BL2pcX9jOfs0SXtFu3tRa
YrABnNCuLPYxw3k95xrUvZuKBTPAjvbY340AExgSJWrnnj70FcNp/M4ByDDDYE89
1bbHvqJ9ZQHVJ+jly/LNRLzX1CrZTqiN7v/3HKTnEnUDUpjwNefCFiNG1WpTcRal
AMkTj7FRAudEgeoEAxlJtz7AuSpY6aswISyjXgjSpdlXe8PRa7rxHFROyVISi2Qh
qsbAOZswzkqjKSynSe3+D7dsBIm161FxdOdsI7MaY/bjxxc092DaGxc5LccQ9tG+
uKiMclGOm0UY5/PS6UkUUBJgCFvIe3pq57rlj2EzRi0uKxP8n7HdsYQRtLTBh9ez
GJ3X5F/knMCd3wfwR9Ita2AXTaFPxF1TYFOwpK7Q2Vp5nc26G1y4hPxaceMokLeV
yJNivAvMzvak9OHkRjBbFx2NcHkuFw7yfNnd1Uh0hz+salNvnjTBmZpH1EHCJqJQ
3WoH8I1evIY2RoSvsVb6
=e3tZ
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
