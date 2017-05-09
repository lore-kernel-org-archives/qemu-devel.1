Received: from eggs.gnu.org ([2001:4830:134:3::10]:50388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d89Jk-0004KK-JG
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d89Jj-0002Y7-If
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:53:00 -0400
Date: Tue, 9 May 2017 12:52:54 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170509165254.GA26793@stefanha-x1.localdomain>
References: <20170504105444.8940-1-daniel.kucera@gmail.com>
	<20170508203556.GA22634@stefanha-x1.localdomain>
	<c51044c8-edf6-c0a2-e543-0d9be1a61b29@openvz.org>
	<fac1ae33-dc7e-b513-d694-c8f8c1555baa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <fac1ae33-dc7e-b513-d694-c8f8c1555baa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] mirror: add sync mode incremental to
 drive-mirror and blockdev-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, Daniel Kucera <daniel.kucera@gmail.com>, Kevin Wolf <kwolf@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 05:07:18PM -0400, John Snow wrote:
>=20
>=20
> On 05/08/2017 05:02 PM, Denis V. Lunev wrote:
> > On 05/08/2017 10:35 PM, Stefan Hajnoczi wrote:
> >> On Thu, May 04, 2017 at 12:54:40PM +0200, Daniel Kucera wrote:
> >>
> >> Seems like a logical extension along the same lines as the backup block
> >> job's dirty bitmap sync mode.
> >>
> >>> parameter bitmap chooses existing dirtymap instead of newly created
> >>> in mirror_start_job
> >>>
> >>> Signed-off-by: Daniel Kucera <daniel.kucera@gmail.com>
> > Can you pls describe the use case pls in a bit more details.
> >=20
> > For now this could be a bit strange:
> > - dirty bitmap, which can be found via bdrv_create_dirty_bitmap
> >   could be read-only or read-write, i.e. being modified by writes
> >   or be read-only, which should not be modified. Thus adding
> >   r/o bitmap to the mirror could result in interesting things.
> >=20
>=20
> This patch as it was submitted does not put the bitmap into a read-only
> mode; it leaves it RW and modifies it as it processes the mirror command.
>=20
> Though you do raise a good point; this bitmap is now in-use by a job and
> should not be allowed to be deleted by the user, but our existing
> mechanism treats a locked bitmap as one that is also in R/O mode. This
> would be a different use case.
>=20
> > Minimally we should prohibit usage of r/o bitmaps this way.
> >=20
> > So, why to use mirror, not backup for the case?
> >=20
>=20
> My guess is for pivot semantics.

Daniel posted his workflow in a previous revision of this series:

He is doing a variation on non-shared storage migration with the mirror
block job, but using the ZFS send operation to transfer the initial copy
of the disk.

Once ZFS send completes it's necessary to transfer all the blocks that
were dirtied while the transfer was taking place.

1. Create dirty bitmap and start tracking dirty blocks in QEMU.
2. Snapshot and send ZFS volume.
3. mirror sync=3Dbitmap after ZFS send completes.
4. Live migrate.

Stefan

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEfPmAAoJEJykq7OBq3PIGYUIALfx5y0bgXSiuArPIJYgTmhu
eMORlpqq1UsMQfz024UMpmbIDHoECZOgQUxgwHMlUyDL1b55Oou9hfuIsmTqPPT8
3wQpGV2zJ23Z05kyvAbZLN7OD1O/4WoWDv6ncRAyrOPn06vjwchY7TkEtymRRuUf
Ik/aJI7s6368g3gs/OLLmY1LV9JkmodBtNk7SsniANfrMQepv1XK1nadExqYeh/u
tWn37eG7ZAv9r9zsrp8LL0zfkE+Aq14PZ2jeKs40obwNpGUehSVgTPhShu2KEh97
p0TVOMdnjvzydAPdQZ1d/Lk9jLkW1kjDnAohZN0kjr9rRrPzmXfchy4919EX3d0=
=053c
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
