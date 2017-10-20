Received: from eggs.gnu.org ([2001:4830:134:3::10]:39202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5ZJw-0006mb-QT
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5ZJv-00080M-Qn
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:34:48 -0400
Date: Fri, 20 Oct 2017 17:34:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171020153405.GB31112@localhost.localdomain>
References: <20171012034720.11947-1-eblake@redhat.com>
	<20171012034720.11947-13-eblake@redhat.com>
	<20171020150349.GC3667@localhost.localdomain>
	<2925d880-fe98-c70b-97d7-1019b1cba89f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <2925d880-fe98-c70b-97d7-1019b1cba89f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 12/24] block: Convert
 bdrv_get_block_status_above() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.10.2017 um 17:22 hat Eric Blake geschrieben:
> On 10/20/2017 10:03 AM, Kevin Wolf wrote:
> > Am 12.10.2017 um 05:47 hat Eric Blake geschrieben:
> >> We are gradually moving away from sector-based interfaces, towards
> >> byte-based.  In the common case, allocation is unlikely to ever use
> >> values that are not naturally sector-aligned, but it is possible
> >> that byte-based values will let us be more precise about allocation
> >> at the end of an unaligned file that can do byte-based access.
> >>
>=20
> >>  int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t b=
ytes,
> >>                        int64_t *pnum, int64_t *map, BlockDriverState *=
*file)
> >>  {
> >> -    int64_t ret;
> >> -    int n;
> >> -
> >> -    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
> >> -    assert(pnum);
> >> -    /*
> >> -     * The contract allows us to return pnum smaller than bytes, even
> >> -     * if the next query would see the same status; we truncate the
> >> -     * request to avoid overflowing the driver's 32-bit interface.
> >> -     */
> >> -    bytes =3D MIN(bytes, BDRV_REQUEST_MAX_BYTES);
> >=20
> > Is the limitation to BDRV_REQUEST_MAX_BYTES going away without being
> > replaced by a new one in bdrv_co_block_status()? What protects us now
> > from 32-bit truncation?
>=20
> As of this patch, we have this 64-bit-clean call chain:
> bdrv_block_status()
>   bdrv_block_status_above()
>     bdrv_common_block_status_above()
>       bdrv_block_status_above_co_entry()
>         bdrv_co_block_status_above()
>           bdrv_co_block_status()
>=20
> which in turn has:
>     /*
>      * The contract allows us to return pnum smaller than bytes, even
>      * if the next query would see the same status; we truncate the
>      * request to avoid overflowing the driver's 32-bit interface.
>      */
>     bytes =3D MIN(bytes, BDRV_REQUEST_MAX_BYTES);
>=20
> added earlier in 8/24.
>=20
> At the end of series 3, the truncation prevention is still in place when
> calling into the drivers, per the changes to bdrv_co_block_status() in
> 21/24.

I looked at the final state and missed it because now INT_MAX is used
rather than BDRV_REQUEST_MAX_BYTES. Anyway, seems to be okay then.

Kevin

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZ6hdtAAoJEH8JsnLIjy/WgOUQAMpp0syACj1Vb0T8WNVLeQ7X
qDN/+FqTXckirCI7L0G7ytZQEU5rLKjEdt+SDzpqS//6gtn0a5gmrEKt1bsG+b6i
xRwJM5+G3aAAoeYWJMy76k26o3q5pSV6ERH2piMcz/yY64eCJE7SMphVlKvZROnB
o0i69668twj4nq3/1QSQdrT/+ScEEvCH3k2oGi9m7a+66/gfxjz1am/N1qqd+e4n
PGP6DqrVjDbiNwzkn/3oERKK3cEfsFQV1OhVbtEwknXu+oJMeEx0GjfZx/hg2N3s
wzsVhVEbj3YKmnzxyAKIn3PbUmdflVi0RG5h2sS+fbw7fsXT2GoU4iTlfWZcFuYV
zQq/Y7xv22F1Pfye/xeLM5kjopUEM59f1i44n2JyHLMc9xaWM/Iro6Ybm8a4t/gp
YeTk/ERK3ipmknzOVXVPOSSJIUQu+2KYscg72lVO2KcRLxsgqo6vT6ooFKBOb920
b4yfA7IXVcObc8AVL6i8LeP1clSlsWJYqpcxCi8q35ZKRyz1uOpg4lh40UrI/6LC
ZUVXml1ivqyhNPgtXU//EwACUA1oS3louC6mGn/3Hjdb9Da7j+HDc6Hkl83F45lL
IOHiemH26Bk1latEcWFea6mTOdzEXCvO7D5sdcYLx8/a9PgpccK9dhE4gq80DvRS
Z3Ls1UxS8ja0TqlJeRUa
=I+UE
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
