Received: from eggs.gnu.org ([2001:4830:134:3::10]:60815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyeRx-0004BO-53
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 09:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyeRv-0006pS-P7
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 09:06:13 -0400
Date: Thu, 13 Apr 2017 15:05:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170413130555.GC5095@noname.redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<2b915695-29b5-df8d-4d89-080eeaaaff13@openvz.org>
	<w51shlcv7sb.fsf@maestria.local.igalia.com>
	<565c1e1b-b9e1-e9c5-790e-283d04afc747@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565c1e1b-b9e1-e9c5-790e-283d04afc747@openvz.org>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 13.04.2017 um 14:44 hat Denis V. Lunev geschrieben:
> On 04/13/2017 02:58 PM, Alberto Garcia wrote:
> > On Wed 12 Apr 2017 06:54:50 PM CEST, Denis V. Lunev wrote:
> >> My opinion about this approach is very negative as the problem could
> >> be (partially) solved in a much better way.
> > Hmm... it seems to me that (some of) the problems you are describing are
> > different from the ones this proposal tries to address. Not that I
> > disagree with them! I think you are giving useful feedback :)
> >
> >> 1) current L2 cache management seems very wrong to me. Each cache
> >>     miss means that we have to read entire L2 cache block. This means
> >>     that in the worst case (when dataset of the test does not fit L2
> >>     cache size we read 64kb of L2 table for each 4 kb read).
> >>
> >>     The situation is MUCH worse once we are starting to increase
> >>     cluster size. For 1 Mb blocks we have to read 1 Mb on each cache
> >>     miss.
> >>
> >>     The situation can be cured immediately once we will start reading
> >>     L2 cache with 4 or 8kb chunks. We have patchset for this for our
> >>     downstream and preparing it for upstream.
> > Correct, although the impact of this depends on whether you are using
> > SDD or HDD.
> >
> > With an SSD what you want is to minimize is the number of unnecessary
> > reads, so reading small chunks will likely increase the performance when
> > there's a cache miss.
> >
> > With an HDD what you want is to minimize the number of seeks. Once you
> > have moved the disk head to the location where the cluster is, reading
> > the whole cluster is relatively inexpensive, so (leaving the memory
> > requirements aside) you generally want to read as much as possible.
> no! This greatly helps for HDD too!
> 
> The reason is that you cover areas of the virtual disk much more precise.
> There is very simple example. Let us assume that I have f.e. 1 TB virtual
> HDD with 1 MB block size. As far as I understand right now L2 cache
> for the case consists of 4 L2 clusters.
> 
> So, I can exhaust current cache only with 5 requests and each actual read
> will costs L2 table read. This is a read problem. This condition could
> happen on fragmented FS without a problem.
> 
> With my proposal the situation is MUCH better. All accesses will be taken
> from the cache after the first run.
> 
> >> 2) yet another terrible thing in cluster allocation is its allocation
> >>     strategy.
> >>     Current QCOW2 codebase implies that we need 5 (five) IOPSes to
> >>     complete COW operation. We are reading head, writing head, reading
> >>     tail, writing tail, writing actual data to be written. This could
> >>     be easily reduced to 3 IOPSes.
> > That sounds right, but I'm not sure if this is really incompatible with
> > my proposal :)
> the problem is code complexity, with is very complex right now.
> 
> 
> >>     Another problem is the amount of data written. We are writing
> >>     entire cluster in write operation and this is also insane. It is
> >>     possible to perform fallocate() and actual data write on normal
> >>     modern filesystem.
> > But that only works when filling the cluster with zeroes, doesn't it? If
> > there's a backing image you need to bring all the contents from there.
> 
> Yes. Backing images are problems. Though, even with sub-clusters, we
> will suffer exactly the same with the amount of IOPSes as even with
> that head and tail have to be read. If you are spoken about
> subclusters equals to FS block size and avoid COW at all, this would
> be terribly slow later on with sequential reading. In such an approach
> sequential reading will result in random read.
> 
> Guest OSes are written keeping in mind that adjacent LBAs are really
> adjacent and reading them sequentially is a very good idea. This
> invariant will be broken for the case of subclusters.

How that?

Given the same cluster size, subclustered and traditional images behave
_exactly_ the same regarding fragmentation. Subclusters only have an
effect on it (and a positive one) when you take them as a reason that
you can now afford to increase the cluster size.

I see subclusters and fragmentation as mostly independent topics.

> For nowadays SSD we are facing problems somewhere else. Right now I
> can achieve only 100k IOPSes on SSD capable of 350-550k. 1 Mb block
> with preallocation and fragmented L2 cache gives same 100k. Tests for
> initially empty image gives around 80k for us.

Preallocated images aren't particularly interesting to me. qcow2 is used
mainly for two reasons. One of them is sparseness (initially small file
size) mostly for desktop use cases with no serious I/O, so not that
interesting either. The other one is snapshots, i.e. backing files,
which doesn't work with preallocation (yet).

Actually, preallocation with backing files is something that subclusters
would automatically enable: You could already reserve the space for a
cluster, but still leave all subclusters marked as unallocated.

Kevin
