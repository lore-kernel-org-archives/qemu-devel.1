Received: from eggs.gnu.org ([2001:4830:134:3::10]:49766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elcXN-0001ma-LC
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elcXM-0005as-Fe
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:30:29 -0500
Date: Tue, 13 Feb 2018 15:30:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180213153017.GS573@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
	<5cf19623-72ac-fb8b-2054-a60d42419ec6@redhat.com>
	<20180111130427.GG8326@redhat.com>
	<20180213105024.GC5083@localhost.localdomain>
	<20180213143001.GA2354@rkaganb.sw.ru>
	<20180213144310.GH5083@localhost.localdomain>
	<20180213145844.GP573@redhat.com>
	<20180213152321.GK5083@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213152321.GK5083@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block]  [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, Richard Palethorpe <richiejp@f-m.fm>, Qemu-block <qemu-block@nongnu.org>, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, rpalethorpe@suse.com, dgilbert@redhat.com, Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>

On Tue, Feb 13, 2018 at 04:23:21PM +0100, Kevin Wolf wrote:
> Am 13.02.2018 um 15:58 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Tue, Feb 13, 2018 at 03:43:10PM +0100, Kevin Wolf wrote:
> > > Am 13.02.2018 um 15:30 hat Roman Kagan geschrieben:
> > > > On Tue, Feb 13, 2018 at 11:50:24AM +0100, Kevin Wolf wrote:
> > > > > Am 11.01.2018 um 14:04 hat Daniel P. Berrange geschrieben:
> > > > > > Then you could just use the regular migrate QMP commands for =
loading
> > > > > > and saving snapshots.
> > > > >=20
> > > > > Yes, you could. I think for a proper implementation you would w=
ant to do
> > > > > better, though. Live migration provides just a stream, but that=
's not
> > > > > really well suited for snapshots. When a RAM page is dirtied, y=
ou just
> > > > > want to overwrite the old version of it in a snapshot [...]
> > > >=20
> > > > This means the point in time where the guest state is snapshotted=
 is not
> > > > when the command is issued, but any unpredictable amount of time =
later.
> > > >=20
> > > > I'm not sure this is what a user expects.
> > >=20
> > > I don't think it's necessarily a big problem as long as you set the
> > > expectations right, but good point anyway.
> > >=20
> > > > A better approach for the save part appears to be to stop the vcp=
us,
> > > > dump the device state, resume the vcpus, and save the memory cont=
ents
> > > > in the background, prioritizing the old copies of the pages that
> > > > change.
> > >=20
> > > So basically you would let the guest fault whenever it writes to a =
page
> > > that is not saved yet, and then save it first before you make the p=
age
> > > writable again? Essentially blockdev-backup, except for RAM.
> >=20
> > The page fault servicing will be delayed by however long it takes to
> > write the page to underling storage, which could be considerable with
> > non-SSD. So guest performance could be significantly impacted on slow
> > storage with high dirtying rate. On the flip side it gurantees a live
> > snapshot would complete in finite time which is good.
>=20
> You can just use a bounce buffer for writing out the old page. Then the
> VM is only stopped for the duration of a malloc() + memcpy().

The would allow QEMU memory usage to balloon up to x2  RAM, if there was
slow storage and very fast dirtying rate. I don't think that's viable
unless there was a cap on how much bounce buffering we would allow before
just blocking the page faults

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
