Received: from eggs.gnu.org ([2001:4830:134:3::10]:37767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoZDW-0002qE-L1
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoZDS-00083I-Pd
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:34:10 -0500
Date: Wed, 21 Feb 2018 19:33:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180221183355.GC353@localhost.localdomain>
References: <20180219145459.8143-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219145459.8143-1-berto@igalia.com>
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

Am 19.02.2018 um 15:54 hat Alberto Garcia geschrieben:
> This patch updates docs/qcow2-cache.txt explaining how to use the new
> l2-cache-entry-size parameter.
> 
> Here's a more detailed technical description of this feature:
> 
>    https://lists.gnu.org/archive/html/qemu-block/2017-09/msg00635.html
> 
> And here are some performance numbers:
> 
>    https://lists.gnu.org/archive/html/qemu-block/2017-12/msg00507.html
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.


While reviewing this, I read the whole document and stumbled across
these paragraphs:

> The reason for this 1/4 ratio is to ensure that both caches cover the
> same amount of disk space. Note however that this is only valid with
> the default value of refcount_bits (16). If you are using a different
> value you might want to calculate both cache sizes yourself since QEMU
> will always use the same 1/4 ratio.

Sounds like we should fix our defaults?

While we're at it, would l2-cache-entry-size = MIN(cluster_size, 64k)
make sense as a default?

> It's also worth mentioning that there's no strict need for both caches
> to cover the same amount of disk space. The refcount cache is used
> much less often than the L2 cache, so it's perfectly reasonable to
> keep it small.

More precisely, it is only used for cluster allocation, not for read or
for rewrites. Usually this means that it's indeed accessed a lot less,
though especially in benchmarks, this isn't necessarily less often.

However, the more important part is that even for allocating writes with
random I/O, the refcount cache is still accessed sequentially and we
don't really take advantage of having more than a single refcount block
in memory. This only stops being true as soon as you add something that
can free clusters (discards, overwriting compressed cluster, deleting
internal snapshots).

We have a minimum refcount block cache size of 4 clusters because of the
possible recursion during refcount table growth, which leaves some room
to hold the refcount block for an occasional discard (and subsequent
reallocation).

So should we default to this minimum on the grounds that for most
people, refcounts blocks are probably only accessed sequentially in
practice? The remaining memory of the total cache size seems to help the
average case more if it's added to the L2 cache instead.

Kevin
