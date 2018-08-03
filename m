Received: from eggs.gnu.org ([2001:4830:134:3::10]:60016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flaHB-0006K8-HV
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 09:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flaH8-00021h-FN
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 09:37:53 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180730105522.GC3775@localhost.localdomain>
References: <20180729212744.23709-1-lbloch@janustech.com>
	<20180730105522.GC3775@localhost.localdomain>
Date: Fri, 03 Aug 2018 15:37:41 +0200
Message-ID: <w51600rlgey.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Kevin Wolf <kwolf@redhat.com>, Leonid Bloch <lbloch@janustech.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Mon 30 Jul 2018 12:55:22 PM CEST, Kevin Wolf wrote:
> I agree with changing the defaults, I would have proposed a change
> myself soon. We have been offering cache size options for a long time,
> and management tools are still ignoring them. So we need to do
> something in QEMU.

Indeed, there's been a bit of discussion in the mailing list and here:

   https://bugzilla.redhat.com/show_bug.cgi?id=1377735

There are some proposals but I haven't seen one that looks evidently
like the best choice yet.

> Now, what the exact defaults should be, is something to use a bit more
> thought on. You say "the memory overhead is very small", without going
> into details. Let's check.

Thanks for showing these numbers, Kevin. The memory overhead is
definitely not very small, and as a matter of fact a significant part of
the work that I've been doing in the past couple of years has the goal
of reducing that memory overhead, which is very significant if you have
large images and long backing chains.

> * Cap it at 32 MB (?) by default
> * Enable cache-clean-interval=30 (?) by default to compensate a bit for
>   the higher maximum memory usage

I think this seems like a reasonable approach. One question that I was
asked already was "Why is cache-clean-interval not enabled by default?".

I don't think the performance impact is a problem (unless the interval
is too low of course), the only thing that I could think of is that it
could make the memory usage more unpredictable.

> Another thing I just noticed while looking at the code is that
> cache-clean-interval only considers blocks that aren't dirty, but
> doesn't take measures to get dirty blocks written out, so we depend on
> the guest flushing the cache before we can get free the memory. Should
> we attempt to write unused dirty entries back? Berto?

I never thought about it, but sounds like worth exploring.

> Maybe the right interface with this in mind would be a boolean option
> that specifies whether the given cache sizes are exact values (old
> semantics) or maximum values, which are limited to what the actual
> images size requires. If you do want the "real" full mode, you'd set
> l2-cache-size=INT64_MAX and exact-cache-sizes=false (this could use a
> better name). The new default would be l2-cache-size=32M,
> exact-cache-sizes=false. The old default is cache-size=1M,
> exact-cache-sizes=true.

That sounds quite complicated ... plus with the current ("exact values")
semantics l2-cache-size already represents a "maximum" since cache
entries are only filled on demand. That is, you can set up a 128MB L2
cache but most of that memory won't be used unless you fill it up first.

So, if you have an 8GB qcow2 image, having a 1MB L2 cache (enough for
the whole image) or a 100MB one shouldn't be very different, because in
the latter case only the first MB is going to be used in practice.

The only actual difference is the overhead of having larger data
structures (Qcow2Cache.entries and Qcow2Cache.table_array).

And thinking about this, perhaps this could be the simplest approach of
them all: let the user pass any value to l2-cache-size but then in
read_cache_sizes() do something like

    if (l2_cache_size_set && *l2_cache_size > max_l2_cache) {
        *l2_cache_size = max_l2_cache;
    }

Then if the image is resized you can recalculate this.

This way the user can make l2-cache-size the hard maximum that they ever
are willing to use for an image's L2 cache, and QEMU guarantees that it
won't allocate that much memory if it can cover the whole image with
less.

How does that sound?

Berto
