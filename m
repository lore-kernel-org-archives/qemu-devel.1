Received: from eggs.gnu.org ([2001:4830:134:3::10]:58999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciLve-0004cH-4y
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciLvc-00081X-Pj
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:05:30 -0500
Date: Mon, 27 Feb 2017 15:05:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170227140521.GE6356@noname.redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-19-git-send-email-kwolf@redhat.com>
	<3a201ea1-81fe-e4f3-7474-364b7cc8f091@redhat.com>
	<20170227123302.GD6356@noname.redhat.com>
	<b735ce93-e4a3-5f25-f641-108d8f9cccc7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <b735ce93-e4a3-5f25-f641-108d8f9cccc7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/54] block: Default .bdrv_child_perm()
 for format drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 27.02.2017 um 13:34 hat Max Reitz geschrieben:
> On 27.02.2017 13:33, Kevin Wolf wrote:
> > Am 25.02.2017 um 12:57 hat Max Reitz geschrieben:
> >> On 21.02.2017 15:58, Kevin Wolf wrote:
> >>> Almost all format drivers have the same characteristics as far as
> >>> permissions are concerned: They have one or more children for storing
> >>> their own data and, more importantly, metadata (can be written to and
> >>> grow even without external write requests, must be protected against
> >>> other writers and present consistent data) and optionally a backing f=
ile
> >>> (this is just data, so like for a filter, it only depends on what the
> >>> parent nodes need).
> >>>
> >>> This provides a default implementation that can be shared by most of
> >>> our format drivers.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>  block.c                   | 42 +++++++++++++++++++++++++++++++++++++=
+++++
> >>>  include/block/block_int.h |  8 ++++++++
> >>>  2 files changed, 50 insertions(+)
> >>>
> >>> diff --git a/block.c b/block.c
> >>> index 523cbd3..f2e7178 100644
> >>> --- a/block.c
> >>> +++ b/block.c
> >>> @@ -1554,6 +1554,48 @@ void bdrv_filter_default_perms(BlockDriverStat=
e *bs, BdrvChild *c,
> >>>                 (c->shared_perm & DEFAULT_PERM_UNCHANGED);
> >>>  }
> >>> =20
> >>> +void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
> >>> +                               const BdrvChildRole *role,
> >>> +                               uint64_t perm, uint64_t shared,
> >>> +                               uint64_t *nperm, uint64_t *nshared)
> >>> +{
> >>> +    bool backing =3D (role =3D=3D &child_backing);
> >>> +    assert(role =3D=3D &child_backing || role =3D=3D &child_file);
> >>> +
> >>> +    if (!backing) {
> >>> +        /* Apart from the modifications below, the same permissions =
are
> >>> +         * forwarded and left alone as for filters */
> >>> +        bdrv_filter_default_perms(bs, c, role, perm, shared, &perm, =
&shared);
> >>> +
> >>> +        /* Format drivers may touch metadata even if the guest doesn=
't write */
> >>> +        if (!bdrv_is_read_only(bs)) {
> >>> +            perm |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
> >>> +        }
> >>> +
> >>> +        /* bs->file always needs to be consistent because of the met=
adata. We
> >>> +         * can never allow other users to resize or write to it. */
> >>> +        perm |=3D BLK_PERM_CONSISTENT_READ;
> >>> +        shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
> >>> +    } else {
> >>> +        /* We want consistent read from backing files if the parent =
needs it.
> >>> +         * No other operations are performed on backing files. */
> >>> +        perm &=3D BLK_PERM_CONSISTENT_READ;
> >>> +
> >>> +        /* If the parent can deal with changing data, we're okay wit=
h a
> >>> +         * writable and resizable backing file. */
> >>> +        if (shared & BLK_PERM_WRITE) {
> >>> +            shared =3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
> >>
> >> Wouldn't this break CONSISTENT_READ?
> >=20
> > WRITE (even for multiple users) and CONSISTENT_READ aren't mutually
> > exclusive. I was afraid that I didn't define CONSISTENT_READ right, but
> > it appears that the definition is fine:
> >=20
> >  * A user that has the "permission" of consistent reads is guaranteed t=
hat
> >  * their view of the contents of the block device is complete and
> >  * self-consistent, representing the contents of a disk at a specific
> >  * point.
>=20
> Right, but writes to the backing file at least to me appear to be a
> different matter. If those don't break CONSISTENT_READ, then I don't see
> how commit breaks CONSISTENT_READ for the intermediate nodes.

There's probably multiple ways to interpret such actions. You could
understand a commit job as writing the desired image to the base node
and at the same time it's a shared writer for the intermediate nodes
that happens to write garbage. The question is if this is a useful way
of seeing it when the job is to prevent accidental data corruption.

Note that we need writable backing files for commit, so taking away
BLK_PERM_WRITE from shared wouldn't work. We could probably make it
dependent on cleared CONSISTENT_READ (commit jobs don't require this
anyway), if you think that the current version is too permissive.

Kevin

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYtDIhAAoJEH8JsnLIjy/WCX4P/3t60By9KWbDi4apK3TX6/hL
WeK4MSEwQi/jxTrLetnwuF53+Dot/FMvvQDtdHqEF7vPQrnKu6wx5Ralkr4UD3cJ
07PforiuVXH/m7AJVBGGdJciGOw0tV9bowU0IOatnl+jxLgdB8D1id3b/peT9IZ6
VNdhGXj3wFf5WndS/FXG6lz6xgdlhFaFDQ743CXGnYlS39bXSO43DKdDVmwP9G7u
Czqd9OUyyu4pUkxbgklJQYNVDVGY/I+hHV/it0XVZKebTPYoe9iBtZWKksSHX+KG
seI58R2U6h3mklwDxpCitA0eTIrxVUZRHg9gS22ELrPmncHCTvns6K6tH77b0sNI
UDHZ9kQA5JT3RyY6QNWTBMARThMzIjWsGIzGH4HQI4UaAwqE+d7oq/3EsjynM4wS
WTpEBOmLPP034TSroVxv67Q8+Gp2lRVZwyFEmkDFqdcEAN/GZ7PbiveL4tr/4fSE
0gtn6/Z0kaz3Eoc6mUNYLvFp8BY34auXpVPTT6grBkgTQ+NRHAouQJ6DNWWTQM0Q
v53tXzB+G4itG1QpDF9R4hU5wbYqUz1Eb1VmIk1C9PbXmkxGpgPN8zueR9FUMTja
db5k1nK3PmmVQoMRqQ+1cg6q0tM9PK2GDttXFMT5nI5bw4Af3J/iEM38pEbHzGBK
gxBDcWsus8UtATk8OYLm
=CMH6
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
