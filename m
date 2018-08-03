Received: from eggs.gnu.org ([2001:4830:134:3::10]:51064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1flW6o-0008E1-4B
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1flW6m-0003Bw-U5
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:10:54 -0400
Date: Fri, 3 Aug 2018 10:10:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180803091034.GD2802@work-vm>
References: <20180801174005.GD2691@work-vm>
	<cbdecba1-925c-5f6e-bf3c-a27cc4d944da@openvz.org>
	<20180801185515.GE2691@work-vm>
	<6bfdc952-fb17-feae-f367-be710853d829@openvz.org>
	<20180802092907.GA2523@work-vm>
	<202065a2-f9d1-ce31-b12b-437d57095ac1@openvz.org>
	<20180802095056.GB2523@work-vm>
	<86304a35-efd8-a605-f684-2bd3fb3b9815@openvz.org>
	<20180803083343.GB2802@work-vm>
	<37953739-c697-2c61-3b83-b58a32710b15@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <37953739-c697-2c61-3b83-b58a32710b15@openvz.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] dirty-bitmaps: clean-up bitmaps
 loading and migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com, stefanha@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, Eric Blake <eblake@redhat.com>

* Denis V. Lunev (den@openvz.org) wrote:
> On 08/03/2018 11:33 AM, Dr. David Alan Gilbert wrote:
> > * Denis V. Lunev (den@openvz.org) wrote:
> >> On 08/02/2018 12:50 PM, Dr. David Alan Gilbert wrote:
> >>> * Denis V. Lunev (den@openvz.org) wrote:
> >>>
> >>>
> >>>>> I don't quite understand the last two paragraphs.
> >>>> we are thinking right now to eliminate delay on regular IO
> >>>> for migration. There is some thoughts and internal work in
> >>>> progress. That is why I am worrying.
> >>> What downtime are you typicaly seeing and what are you aiming for?
> >>>
> >>> It would be good if you could explain what you're planning to
> >>> fix there so we can get a feel for it nearer the start of it
> >>> rather than at the end of the reviewing!
> >>>
> >>> Dave
> >> The ultimate goal is to reliable reach 100 ms with ongoing IO and
> >> you are perfectly correct about reviewing :)
> > That would be neat.
> >
> >> Though the problem is that right now we are just trying to
> >> invent something suitable :(
> > OK, some brain-storm level ideas:
> >
> >   a) Throttle the write bandwidth at later stages of migration
> >      (I think that's been suggested before)
> yes
>=20
> >   b) Switch to some active-sync like behaviour where the writes
> >      are sent over the network as they happen to the destination
> >      (mreitz has some prototype code for that type of behaviour
> >      for postcopy)
> will not work. Even with the sync mirror (which we have submitted
> 2 years ago, but not accepted), usual downtime will be around 1 sec
> due to requests in flight.

I'm confused why it would be that high; are you saying that would be
longer than the downtime with the current writes near the end of
migration on the source?

> >   c) Write the writes into a buffer that gets migrated over the
> >     migration stream to get committed on the destination side.
> yes. this is an option but the buffer can be too big.

Combined with some throttling you should be able to bound the size;
especially since it should be done only for the very last part of the
migration.

> For the shared disk migration the options are the following:
> - without metadata updates writes could be just passed to finish, there
> =A0 is no need to wait. But completions should be reported to destinati=
on
> - metadata updates are not allowed, they should be transferred to the
> =A0 destination
>=20
> For non-shared disk migration we do not need to wait local IO, we just =
need
> to restart them on target. Alternatively these areas could be marked as
> blocked for IO and re-sync again once writes are completed.
>=20
> These are raw ideas, which should be improved and tweaked.

Nod; it needs some thinking about.

Dave

> Den
>=20
> > As I say, brainstorm level ideas only!
> >
> > Dave
> >
> >
> >> Den
> >>
> >>>>> However, coming back to my question; it was really saying that
> >>>>> normal guest IO during the end of the migration will cause
> >>>>> a delay; I'm expecting that to be fairly unrelated to the size
> >>>>> of the disk; more to do with workload; so I guess in your case
> >>>>> the worry is the case of big large disks giving big large
> >>>>> bitmaps.
> >>>> exactly!
> >>>>
> >>>> Den
> >>> --
> >>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
