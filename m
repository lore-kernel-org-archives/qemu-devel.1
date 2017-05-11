Received: from eggs.gnu.org ([2001:4830:134:3::10]:56410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8swT-0006Bx-A8
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8swR-00080o-Qb
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:36:01 -0400
Date: Thu, 11 May 2017 14:35:49 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511183549.GA20777@stefanha-x1.localdomain>
References: <20170504105444.8940-1-daniel.kucera@gmail.com>
	<20170508203556.GA22634@stefanha-x1.localdomain>
	<c51044c8-edf6-c0a2-e543-0d9be1a61b29@openvz.org>
	<fac1ae33-dc7e-b513-d694-c8f8c1555baa@redhat.com>
	<20170509165254.GA26793@stefanha-x1.localdomain>
	<fc8b563b-5fb5-0a65-c883-32191b3c93e7@openvz.org>
	<20170510150016.GB19962@stefanha-x1.localdomain>
	<bf77cd41-3ae7-629f-6690-34913c7d78f0@openvz.org>
	<CAKVPjOaTYVAz3ek4uMq-XRt9UyEaquN30t2wg2VsoDgaA7=EyQ@mail.gmail.com>
	<26a943da-3487-8d39-85fd-6e176af054e0@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <26a943da-3487-8d39-85fd-6e176af054e0@openvz.org>
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
Cc: Daniel =?utf-8?Q?Ku=C4=8Dera?= <daniel.kucera@gmail.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:28:14PM +0200, Denis V. Lunev wrote:
> On 05/11/2017 04:16 PM, Daniel Ku=C4=8Dera wrote:
> >
> > 2017-05-10 17:05 GMT+02:00 Denis V. Lunev <den@openvz.org
> > <mailto:den@openvz.org>>:
> >
> >     On 05/10/2017 05:00 PM, Stefan Hajnoczi wrote:
> >     > On Wed, May 10, 2017 at 03:25:31PM +0200, Denis V. Lunev wrote:
> >     >> On 05/09/2017 06:52 PM, Stefan Hajnoczi wrote:
> >     >>> On Mon, May 08, 2017 at 05:07:18PM -0400, John Snow wrote:
> >     >>>> On 05/08/2017 05:02 PM, Denis V. Lunev wrote:
> >     >>>>> On 05/08/2017 10:35 PM, Stefan Hajnoczi wrote:
> >     >>>>>> On Thu, May 04, 2017 at 12:54:40PM +0200, Daniel Kucera wrot=
e:
> >     >>>>>>
> >     >>>>>> Seems like a logical extension along the same lines as the
> >     backup block
> >     >>>>>> job's dirty bitmap sync mode.
> >     >>>>>>
> >     >>>>>>> parameter bitmap chooses existing dirtymap instead of
> >     newly created
> >     >>>>>>> in mirror_start_job
> >     >>>>>>>
> >     >>>>>>> Signed-off-by: Daniel Kucera <daniel.kucera@gmail.com
> >     <mailto:daniel.kucera@gmail.com>>
> >     >>>>> Can you pls describe the use case pls in a bit more details.
> >     >>>>>
> >     >>>>> For now this could be a bit strange:
> >     >>>>> - dirty bitmap, which can be found via bdrv_create_dirty_bitm=
ap
> >     >>>>>   could be read-only or read-write, i.e. being modified by
> >     writes
> >     >>>>>   or be read-only, which should not be modified. Thus adding
> >     >>>>>   r/o bitmap to the mirror could result in interesting things.
> >     >>>>>
> >     >>>> This patch as it was submitted does not put the bitmap into a
> >     read-only
> >     >>>> mode; it leaves it RW and modifies it as it processes the
> >     mirror command.
> >     >>>>
> >     >>>> Though you do raise a good point; this bitmap is now in-use
> >     by a job and
> >     >>>> should not be allowed to be deleted by the user, but our exist=
ing
> >     >>>> mechanism treats a locked bitmap as one that is also in R/O
> >     mode. This
> >     >>>> would be a different use case.
> >     >>>>
> >     >>>>> Minimally we should prohibit usage of r/o bitmaps this way.
> >     >>>>>
> >     >>>>> So, why to use mirror, not backup for the case?
> >     >>>>>
> >     >>>> My guess is for pivot semantics.
> >     >>> Daniel posted his workflow in a previous revision of this serie=
s:
> >     >>>
> >     >>> He is doing a variation on non-shared storage migration with
> >     the mirror
> >     >>> block job, but using the ZFS send operation to transfer the
> >     initial copy
> >     >>> of the disk.
> >     >>>
> >     >>> Once ZFS send completes it's necessary to transfer all the
> >     blocks that
> >     >>> were dirtied while the transfer was taking place.
> >     >>>
> >     >>> 1. Create dirty bitmap and start tracking dirty blocks in QEMU.
> >     >>> 2. Snapshot and send ZFS volume.
> >     >>> 3. mirror sync=3Dbitmap after ZFS send completes.
> >     >>> 4. Live migrate.
> >     >>>
> >     >>> Stefan
> >     >> thank you very much. This is clear now.
> >     >>
> >     >> If I am not mistaken,  this can be very easy done with
> >     >> the current implementation without further QEMU modifications.
> >     >> Daniel just needs to start mirror and put it on pause for the
> >     >> duration of stage (2).
> >     >>
> >     >> Will this work?
> >     > I think it's a interesting idea but I'm not sure if sync=3Dnone +
> >     pause
> >     > can be done atomically.  Without atomicity a block might be sent
> >     to the
> >     > destination while the ZFS send is still in progress.
> >     >
> >     > Stefan
> >     Atomicity here is completely impossible.
> >
> >     The case is like this.
> >
> >     1) start the mirror
> >     2) pause the mirror
> >     3) snapshot + ZFS send
> >     4) resume mirror
> >     5) live migrate
> >
> >     The worst case problem - some additional blocks which
> >     would be send twice. This should not be very big deal.
> >     This is actually which backup always does. The amount
> >     of such blocks will not be really big.
> >
> >     Den
> >
> >
> > I guess it won't be possible to start mirror in 1) or it will
> > instantly fail because the block device on destination doesn't exist
> > at that moment, so it's not even possible to start nbd server.
> >
> > Or am I wrong?
> >
> good point, by I guess you can create empty volume of the
> proper size it at step 0, setup QEMU mirror and start to copy
> the data to that volume. I may be completely wrong here as
> I do not know ZFS management procedures and tools.
>=20
> Can you share the commands you are using to perform the
> op? May be we will be able to find suitable solution.

Daniel's proposed patch isn't large or invasive.  The QMP interface is
consistent with the backup block job's sync=3Dbitmap mode, it's a logical
extension.

If the concerns about the bitmap lifecycle are addressed and a test case
is included then I don't see anything preventing this patch from being
merged.

Stefan

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFK8FAAoJEJykq7OBq3PIoecH/1BdQ1k5XvHyyxchSkdDxKyj
ffdRutT5zAIzeklM3XKJGeMYICeJS5cONzoSLNUdFsSWp53RCEOm69d6Fb0r+0+b
obLdGlb4iWad1hQ9kcOdwfE9rlh8mrMARqtSv1lThRzmahjsP/4qVpqvdBk+e8lJ
Q4hkH9WhqfAcltFfvHSN/umz97K1Lp6EeMoXLEuYkb/QHTj421T2vv9vSVG+Veox
oli6mNBMZy7Q/j/5al++pzZ4FldX1AnvQGsZ1R7cUT8rknofdlE5N4rVBAQvBDL7
kC8NzjVzyVn7I8mFZ52lfQv3wgbQojNPTCLAZKU3y30QHnPW50ShkNprfZCIEB8=
=m1l4
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
