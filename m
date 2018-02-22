Received: from eggs.gnu.org ([2001:4830:134:3::10]:48680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eorhM-00049k-LI
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eorhG-0002c7-VE
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:18:12 -0500
Date: Thu, 22 Feb 2018 15:17:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180222141757.GH4147@localhost.localdomain>
References: <20180219145459.8143-1-berto@igalia.com>
	<20180221183355.GC353@localhost.localdomain>
	<w51efld5g26.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51efld5g26.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH] docs: document how to use the
 l2-cache-entry-size parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "Denis V . Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>

Am 22.02.2018 um 14:06 hat Alberto Garcia geschrieben:
> On Wed 21 Feb 2018 07:33:55 PM CET, Kevin Wolf wrote:
> 
>  [docs/qcow2-cache.txt]
> > While reviewing this, I read the whole document and stumbled across
> > these paragraphs:
> >
> >> The reason for this 1/4 ratio is to ensure that both caches cover the
> >> same amount of disk space. Note however that this is only valid with
> >> the default value of refcount_bits (16). If you are using a different
> >> value you might want to calculate both cache sizes yourself since
> >> QEMU will always use the same 1/4 ratio.
> >
> > Sounds like we should fix our defaults?
> 
> We could do that, yes, we would be "breaking" compatibility with
> previous versions, but we're not talking about semantic changes here, so
> it's not a big deal in and on itself.

I don't think changing behaviour and breaking compatibility is the same
thing. If there is an option, you should expect that its default can
change in newer versions. If you want a specific setting, you should be
explicit.

> Of course this would be a problem if the new defaults make things work
> slower, but I don't think that's the case here.
> 
> Just to confirm: do you suggest reducing the refcount cache size
> (because it's not so necessary) or changing the formula so the number of
> refcount_bits is taken into account so that both caches cover the same
> amount of disk space in all cases?
> 
> I suppose it's the former based on what you write below.

I was first thinking to make the ratio dynamic based on the refcount
width, but then it occurred to me that a fixed absolute number probably
makes even more sense. Either way should be better than the current
default, though.

> > While we're at it, would l2-cache-entry-size = MIN(cluster_size, 64k)
> > make sense as a default?
> 
> Any reason why you choose 64k, or is it because it's the default cluster
> size?
> 
> In general I'd be cautious to reduce the default entry size
> unconditionally because with rotating HDDs it may even have a negative
> (although slight) effect on performance. But the larger the cluster, the
> larger the area mapped by L2 entries, so we need less metadata and it
> makes more sense to read less in general.
> 
> In summary: while I think it's probably a good idea, it would be good to
> make some tests before changing the default.

The exact value of 64k is more or less because it's the default cluster
size, yes. Not changing anything for the default cluster size makes it
a bit easier to justify.

What I really want to fix is the 2 MB entry size with the maximum
cluster size, because that's just unreasonably large. It's not
completely clear what the ideal size is, but when we increased the
default cluster size from 4k, the optimal values (on rotating hard
disks back then) were 64k or 128k. So I assume that it's somewhere
around these sizes that unnecessary I/O starts to hurt more than reading
one big chunk instead of two smaller ones helps.

Of course, guest I/O a few years ago and metadata I/O today aren't
exactly the same thing, so I agree that a change should be measured
first. But 64k-128k feels right as an educated guess where to start.

> >> It's also worth mentioning that there's no strict need for both
> >> caches to cover the same amount of disk space. The refcount cache is
> >> used much less often than the L2 cache, so it's perfectly reasonable
> >> to keep it small.
> >
> > More precisely, it is only used for cluster allocation, not for read
> > or for rewrites. Usually this means that it's indeed accessed a lot
> > less, though especially in benchmarks, this isn't necessarily less
> > often.
> >
> > However, the more important part is that even for allocating writes
> > with random I/O, the refcount cache is still accessed sequentially and
> > we don't really take advantage of having more than a single refcount
> > block in memory. This only stops being true as soon as you add
> > something that can free clusters (discards, overwriting compressed
> > cluster, deleting internal snapshots).
> >
> > We have a minimum refcount block cache size of 4 clusters because of
> > the possible recursion during refcount table growth, which leaves some
> > room to hold the refcount block for an occasional discard (and
> > subsequent reallocation).
> >
> > So should we default to this minimum on the grounds that for most
> > people, refcounts blocks are probably only accessed sequentially in
> > practice? The remaining memory of the total cache size seems to help
> > the average case more if it's added to the L2 cache instead.
> 
> That sounds like a good idea. We should double check that the minimum is
> indeed the required minimum, and run some tests, but otherwise I'm all
> for it.
> 
> I think I can take care of this if you want.

That would be good.

I'm pretty confident that the minimum is enough because it's also the
default for 64k clusters. Maybe it's too high if I miscalculated back
then, but I haven't seen a crash report related to running out of
refcount block cache entries.

Kevin
