Received: from eggs.gnu.org ([209.51.188.92]:48021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gts4S-0004Zm-Ru
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gts4R-0001zs-VR
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:47:16 -0500
Date: Wed, 13 Feb 2019 11:46:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190213104656.GC994@localhost.localdomain>
References: <20190212214216.GA17279@homura.localdomain>
	<871s4ckyq7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s4ckyq7.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Combining -loadvm and -snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Drew DeVault <sir@cmpwn.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 13.02.2019 um 07:07 hat Markus Armbruster geschrieben:
> Cc'ing the QCOW2 folks.
> 
> Drew DeVault <sir@cmpwn.com> writes:
> 
> > I recently ran into an issue where I found I couldn't combine the
> > -loadvm and -snapshot flags, nor any conceivable combination of
> > alternate approaches like loadvm via the monitor. Independently, both
> > options work as expected, but together I get this error:
> >
> > qemu-system-x86_64: Device 'virtio0' does not have the requested snapshot 'base'
> >
> > The goal here is to resume the VM state from a snapshot, but to prevent
> > the guest from persisting writes to the underlying qcow2.
> >
> > I started digging into the code to understand this problem more, and I
> > was pretty deep in the weeds when I realized what the underlying problem
> > probably was and the kind of refactoring necessary to fix it - so I'm
> > here to touch base before moving any further.
> >
> > I believe this happens because -snapshot creates a temporary qcow2
> > overlaid on top of the disk you're using, and this overlay does not have
> > any snapshots copied, nor does any of the snapshot reading code (e.g.
> > qcow2_snapshot_list or qcow2_snapshot_goto) iterate over backing disks
> > to load their snapshots.
> >
> > At first I was going to adjust the qcow2 snapshot loading code (those
> > two functions in particular) to read through their backends, but I'm a
> > little unfamiliar with this code and the refactoring is not minor so I
> > would like to get feedback from some of the wiser folks on this mailing
> > list before I sink too much time into this.
> >
> > Thoughts?

Reading from the backing file would be correct in your special case
(because the overlay was only just created and doesn't contain data
yet), but generally speaking, this would make the disk content
inconsistent because it would mix newer data from the overlay with old
data from the snapshot in the backing file.

But before I make suggestions how this could be addressed (it's probably
not trivial), let me ask what your real goal is?

I'm asking because when you start a VM with '-loadvm foo', this means
that you already got a snapshot at this exact point. So the guest will
write to the qcow2 file, but when you start the VM the next time, and
again with '-loadvm foo', the newly written data will be discarded and
QEMU will revert to the snapshot 'foo' again. So you already got the
same functionality that -snapshot is supposed to provide, even without
using it.

Do you have other reasons why you want to use -snapshot?

Kevin
