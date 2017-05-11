Received: from eggs.gnu.org ([2001:4830:134:3::10]:46947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel.kucera@gmail.com>) id 1d8pSF-0002n3-27
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel.kucera@gmail.com>) id 1d8pSD-0001o2-8b
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:52:35 -0400
MIME-Version: 1.0
In-Reply-To: <26a943da-3487-8d39-85fd-6e176af054e0@openvz.org>
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
From: =?UTF-8?Q?Daniel_Ku=C4=8Dera?= <daniel.kucera@gmail.com>
Date: Thu, 11 May 2017 16:52:26 +0200
Message-ID: <CAKVPjObw3cTmeyKCHaFn9+nKwuB7boCfqhqyqCVxn3op17Do+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

2017-05-11 16:28 GMT+02:00 Denis V. Lunev <den@openvz.org>:

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
> >     >>>>>   r/o bitmap to the mirror could result in interesting things=
.
> >     >>>>>
> >     >>>> This patch as it was submitted does not put the bitmap into a
> >     read-only
> >     >>>> mode; it leaves it RW and modifies it as it processes the
> >     mirror command.
> >     >>>>
> >     >>>> Though you do raise a good point; this bitmap is now in-use
> >     by a job and
> >     >>>> should not be allowed to be deleted by the user, but our
> existing
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
>
> Can you share the commands you are using to perform the
> op? May be we will be able to find suitable solution.
>
> Den
>
>
the idea is following:

1) virsh qemu-monitor-command test-domain '{ "execute":
"block-dirty-bitmap-add", "arguments": {"node": "drive-scsi0-0-0", "name":
"migration", "granularity": 65536}}'

2) zfs snapshot zstore/test-volume@migration

3) zfs send -R zstore/test-volume@migration | ssh dest-host zfs recv
zstore/test-volume

4) virsh qemu-monitor-command test-domain '{ "execute": "drive-mirror",
"arguments": {"device": "drive-scsi0-0-0-0", "target": "nbd:IP:port",
"sync": "incremental" , "bitmap": "migration", "mode":"existing", "format":
"raw"}}'

5) virsh migrate test-domain --live ....

But your point with paused mirror is interesting. The solution could also
be to start the mirror (sync: none) as paused (with some new parameter
perhaps) so it would create its own dirty bitmap but not start mirroring
until resumed with "block-job-resume". In the meantime the ZFS volume would
be transfered and mirror resumed just after that.

This looks like a much cleaner solution though.

S pozdravom / Best regards
Daniel Kucera.
