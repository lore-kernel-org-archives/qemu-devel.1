Received: from eggs.gnu.org ([2001:4830:134:3::10]:44151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyfL8-0000Lp-K0
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyfL3-0004TD-LC
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:07:46 -0400
Date: Wed, 21 Mar 2018 16:07:28 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180321150728.GB3898@localhost.localdomain>
References: <20180321133852.3560-1-berto@igalia.com>
	<20180321135238.GA3898@localhost.localdomain>
	<w51k1u5ikp2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51k1u5ikp2.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] qcow2: Reset
 free_cluster_index when allocating a new refcount block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, jsnow@redhat.com

Am 21.03.2018 um 15:10 hat Alberto Garcia geschrieben:
> On Wed 21 Mar 2018 02:52:38 PM CET, Kevin Wolf wrote:
> 
> >>      qemu-img create -f qcow2 -o cluster_size=512 hd.qcow2 1M
> >>      qemu-io -c 'write 0 124k' hd.qcow2
> >>      qemu-io -c 'write 124k 512' hd.qcow2
> >
> > So if I understand correctly, this is what we get:
> >
> > 0x20000: free
> > 0x20200: refcount block
> > 0x20400: data cluster
> > 0x20600: potential next data cluster
> 
> Yes.
> 
> >> What this patch does is reset s->free_cluster_index to its previous
> >> value when alloc_refcount_block() returns -EAGAIN. This way the caller
> >> will try to allocate again the original clusters if they are still
> >> free.
> >
> > This is an improvement, because now we should avoid the unused cluster:
> >
> > 0x20000: data cluster
> > 0x20200: refcount block
> > 0x20400: potential next data cluster
> 
> That's correct.
> 
> > But now the data clusters are fragmented. Should we try to change the
> > logic so that already the refcount block allocation can make use of
> > the free space? That is:
> >
> > 0x20000: refcount block
> > 0x20200: data cluster
> > 0x20400: contiguous potential next data cluster
> 
> Well, the clusters before 0x20000 are also data clusters so there's
> going to be fragmentation anyway. Also, if you're writing more than 1
> data cluster in a single request when the refcount block allocation
> happens all those new data clusters are still going to be contiguous
> (before the new refcount block).

That's true.

I just remembered that when I looked at an image recently, I noticed
that the refcount block wasn't in the first cluster and I disliked it,
though mostly because it felt untidy rather than being a problem. There
was one effect that might count as an advantage, though: The first few
data clusters covered by the refcount block were corrupted before the
overlap check for the refcount block stopped it.

Not necessarily worth changing the logic, I just thought I'd bring it
up and see whether anyone else dislikes it.

> Another possibility that I considered was to make alloc_clusters_noref()
> return the offset but let free_cluster_index untouched until the
> refcounts are correct, but this requires more code and I fear that
> keeping free_cluster_index pointing to the clusters we're trying to
> allocate can lead to unexpected surprises.

Possibly. I think if I wanted to change the order, I'd consider
returning a hard error from update_refcount() when no refcount block is
available, and then the caller would have to call alloc_refcount_block()
manually before retrying update_refcount().

> The solution I chose is -I think- the simplest and easiest to audit.
> 
> On a related note, I'm using a script that I wrote myself to debug qcow2
> images. It prints the contents of the header and lists all host
> clusters, indicating the type of each one. I find it useful to debug
> problems like this one. If there's nothing similar already existing I
> can post it and we could put it in the scripts/ directory.

Having a qcow2 analysis script in the repo sounds like a good idea. John
has something, too. Maybe we can check whether the two things complement
each other and then check in a script that combines both (or if one
provides a superset of the other, just check in that one).

Kevin
