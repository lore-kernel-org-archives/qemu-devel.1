Received: from eggs.gnu.org ([2001:4830:134:3::10]:35026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8T6K-0005ZH-Nh
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8T6G-0003nH-SD
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:00:28 -0400
Date: Wed, 10 May 2017 11:00:16 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170510150016.GB19962@stefanha-x1.localdomain>
References: <20170504105444.8940-1-daniel.kucera@gmail.com>
	<20170508203556.GA22634@stefanha-x1.localdomain>
	<c51044c8-edf6-c0a2-e543-0d9be1a61b29@openvz.org>
	<fac1ae33-dc7e-b513-d694-c8f8c1555baa@redhat.com>
	<20170509165254.GA26793@stefanha-x1.localdomain>
	<fc8b563b-5fb5-0a65-c883-32191b3c93e7@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <fc8b563b-5fb5-0a65-c883-32191b3c93e7@openvz.org>
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
To: "Denis V. Lunev" <den@openvz.org>
Cc: John Snow <jsnow@redhat.com>, Daniel Kucera <daniel.kucera@gmail.com>, Kevin Wolf <kwolf@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 03:25:31PM +0200, Denis V. Lunev wrote:
> On 05/09/2017 06:52 PM, Stefan Hajnoczi wrote:
> > On Mon, May 08, 2017 at 05:07:18PM -0400, John Snow wrote:
> >>
> >> On 05/08/2017 05:02 PM, Denis V. Lunev wrote:
> >>> On 05/08/2017 10:35 PM, Stefan Hajnoczi wrote:
> >>>> On Thu, May 04, 2017 at 12:54:40PM +0200, Daniel Kucera wrote:
> >>>>
> >>>> Seems like a logical extension along the same lines as the backup bl=
ock
> >>>> job's dirty bitmap sync mode.
> >>>>
> >>>>> parameter bitmap chooses existing dirtymap instead of newly created
> >>>>> in mirror_start_job
> >>>>>
> >>>>> Signed-off-by: Daniel Kucera <daniel.kucera@gmail.com>
> >>> Can you pls describe the use case pls in a bit more details.
> >>>
> >>> For now this could be a bit strange:
> >>> - dirty bitmap, which can be found via bdrv_create_dirty_bitmap
> >>>   could be read-only or read-write, i.e. being modified by writes
> >>>   or be read-only, which should not be modified. Thus adding
> >>>   r/o bitmap to the mirror could result in interesting things.
> >>>
> >> This patch as it was submitted does not put the bitmap into a read-only
> >> mode; it leaves it RW and modifies it as it processes the mirror comma=
nd.
> >>
> >> Though you do raise a good point; this bitmap is now in-use by a job a=
nd
> >> should not be allowed to be deleted by the user, but our existing
> >> mechanism treats a locked bitmap as one that is also in R/O mode. This
> >> would be a different use case.
> >>
> >>> Minimally we should prohibit usage of r/o bitmaps this way.
> >>>
> >>> So, why to use mirror, not backup for the case?
> >>>
> >> My guess is for pivot semantics.
> > Daniel posted his workflow in a previous revision of this series:
> >
> > He is doing a variation on non-shared storage migration with the mirror
> > block job, but using the ZFS send operation to transfer the initial copy
> > of the disk.
> >
> > Once ZFS send completes it's necessary to transfer all the blocks that
> > were dirtied while the transfer was taking place.
> >
> > 1. Create dirty bitmap and start tracking dirty blocks in QEMU.
> > 2. Snapshot and send ZFS volume.
> > 3. mirror sync=3Dbitmap after ZFS send completes.
> > 4. Live migrate.
> >
> > Stefan
> thank you very much. This is clear now.
>=20
> If I am not mistaken,  this can be very easy done with
> the current implementation without further QEMU modifications.
> Daniel just needs to start mirror and put it on pause for the
> duration of stage (2).
>=20
> Will this work?

I think it's a interesting idea but I'm not sure if sync=3Dnone + pause
can be done atomically.  Without atomicity a block might be sent to the
destination while the ZFS send is still in progress.

Stefan

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEysAAAoJEJykq7OBq3PIAEYIALZq2q8bUDY/mCEKt5UqZNOo
QVh34/t60VSYriR5iP2hexV1oWdUySs3T3Bi2MDB7aSjstsdMqkvBHHQH5v6X0wU
Q5C9wdKK3wMcxQgwFidSua69SfidWtSvxqygJfbDs53jNdd3XGsizO7vu5D4qDSg
K+JMSJDi5W8u6GgzY7H/osNF7qYlEIHuHs9Oejv7XeTSrU2aUOqDOOqsCB8nEtzP
BubdAKlhpth5adX7WYau+GrYRJWn8QWOLxv9cBhSmC0eMlb0xziFLbMFbV9/tWCr
V3whIqPTyHFyBMDXGPFJCdsmYy7azhCkqPL2DCQfkTyEsyGmxgWhw9oQDSso3C4=
=wmpp
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
