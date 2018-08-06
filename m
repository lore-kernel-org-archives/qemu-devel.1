Received: from eggs.gnu.org ([2001:4830:134:3::10]:47267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fmd1B-0003AE-H1
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fmd15-0005NL-NB
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:45:41 -0400
Date: Mon, 6 Aug 2018 12:45:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180806104520.GB4631@localhost.localdomain>
References: <20180729212744.23709-1-lbloch@janustech.com>
	<20180730105522.GC3775@localhost.localdomain>
	<w51600rlgey.fsf@maestria.local.igalia.com>
	<20180803145542.GF4380@localhost.localdomain>
	<w51va8ondg8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51va8ondg8.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] qcow2: Make the L2 cache cover the
 whole image by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 06.08.2018 um 09:47 hat Alberto Garcia geschrieben:
> On Fri 03 Aug 2018 04:55:42 PM CEST, Kevin Wolf wrote:
> > By the way, weren't you working on subclusters a while ago? How did
> > that go? Because I think those would enable us to use larger cluster
> > sizes and therefore reduce the metadata sizes as well.
> 
> I had a working prototype, but the changes to both the code and the
> on-disk format were not trivial. I would need to re-evaluate its
> performance impact after all the changes that we have had since then,
> and then see if it's worth trying again.
> 
> I suppose that the main benefit of having subclusters is that
> allocations are much faster. Everything else remains more or less the
> same, and in particular you can already use larger clusters if you want
> to reduce the metadata sizes. Plus, with the l2-cache-entry-size option
> you can already solve some of the problems of having large clusters.

Yes, indeed, subclusters are about making COW less painful (or getting
rid of it altogether). Doing COW for full 2 MB when the guest updates 4k
is just a bit over the top and I think it slows down initial writes
seriously. I haven't benchmarked things in a while, though.

While reasonable cache settings and potentially also avoiding
fragmentation are probably more important overall, I don't think we can
completely ignore initial writes. They are part of the cost of
snapshots, they are what people are seeing first and also what
benchmarks generally show.

Kevin
