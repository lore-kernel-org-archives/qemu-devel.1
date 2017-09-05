Received: from eggs.gnu.org ([2001:4830:134:3::10]:44859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpDi1-0001eB-7l
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpDht-0002Qb-Ev
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:16:05 -0400
Date: Tue, 5 Sep 2017 15:15:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170905131519.GK4633@localhost.localdomain>
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<39bf15aa-70e0-45ad-e368-fb489ee30a7c@redhat.com>
	<6fd08a23-a4f1-527f-6665-d1dbeb51a64a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fd08a23-a4f1-527f-6665-d1dbeb51a64a@redhat.com>
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 23.08.2017 um 19:44 hat John Snow geschrieben:
> On 08/23/2017 01:31 PM, Max Reitz wrote:
> > On 2017-08-22 21:07, John Snow wrote:
> > 
> > [...]
> > 
> >> (3) Add either a new flag that turns qcow2's backing file into a full
> >> R/W backing file, or add a new extension to qcow2 entirely (bypassing
> >> the traditional backing file mechanism to avoid confusion for older
> >> tooling) that adds a new read-write backing file field.
> >>
> >> This RW backing file field will be used for all reads AND writes; the
> >> qcow2 in question becomes a metadata container on top of the BDS chain.
> >> We can re-use Vladimir's bitmap persistence extension to save bitmaps in
> >> a qcow2 shell.
> >>
> >> The qcow2 becomes effectively a metadata cache for a new (essentially)
> >> filter node that handles features such as bitmaps. This could also be
> >> used to provide allocation map data for RAW files and other goodies down
> >> the road.
> >>
> >> Hopefully this achieves our desire to not create new formats AND our
> >> desire to concentrate features (and debugging, testing, etc) into qcow2,
> >> while allowing users to "have bitmaps with raw files."
> >>
> >> Of course, in this scenario, users now have two files: a qcow2 wrapper
> >> and the actual raw file in question; but regardless of how we were going
> >> to solve this, a raw file necessitates an external file of some sort,
> >> else we give up the idea that it was a raw file.
> >>
> >>
> >> Sound good?
> > 
> > While I don't quite like the idea of R/W backing files, I guess "don't
> > quite like" is still rather good.
> 
> Yeah, it's not necessarily my first pick, but it might be the least bad.

As for backing files always being read-only, that ship has sailed long
ago. We really never had it because I think HMP 'commit' was introduced
at the same time as backing files, but at least it was still contained
in synchronous function protected by the BQL. But at latest since we
introduced live block jobs, it's not a reasonable assumption to make any
more.

At this point, I have no problems with adding more users of writable
backing files any more. We'll have to use op blockers to make it safe.

> If you have any suggestions or alternatives for a way to accomplish the
> same in a way that does not leave any, even faint, bad taste in your
> mouth you are more than welcome to suggest it.

Maybe one thing that I don't want to dismiss right away would be a
separate BlockDriver for passthrough qcow2 images so that we don't
clutter all functions with special cases. But I'm not compeltely
convinced of it either.

I think I once had a use case for clusters that are marked as
"read/write to backing file", but I can't seem to remember it now. If we
had such a per-cluster setting, then a separate BlockDriver wouldn't be
an option, obviously.

Kevin
