Received: from eggs.gnu.org ([2001:4830:134:3::10]:44525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fmaFq-0001r6-23
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 03:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fmaFm-00032l-Vq
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 03:48:38 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180803145542.GF4380@localhost.localdomain>
References: <20180729212744.23709-1-lbloch@janustech.com>
	<20180730105522.GC3775@localhost.localdomain>
	<w51600rlgey.fsf@maestria.local.igalia.com>
	<20180803145542.GF4380@localhost.localdomain>
Date: Mon, 06 Aug 2018 09:47:51 +0200
Message-ID: <w51va8ondg8.fsf@maestria.local.igalia.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri 03 Aug 2018 04:55:42 PM CEST, Kevin Wolf wrote:
> By the way, weren't you working on subclusters a while ago? How did
> that go? Because I think those would enable us to use larger cluster
> sizes and therefore reduce the metadata sizes as well.

I had a working prototype, but the changes to both the code and the
on-disk format were not trivial. I would need to re-evaluate its
performance impact after all the changes that we have had since then,
and then see if it's worth trying again.

I suppose that the main benefit of having subclusters is that
allocations are much faster. Everything else remains more or less the
same, and in particular you can already use larger clusters if you want
to reduce the metadata sizes. Plus, with the l2-cache-entry-size option
you can already solve some of the problems of having large clusters.

>> > Another thing I just noticed while looking at the code is that
>> > cache-clean-interval only considers blocks that aren't dirty, but
>> > doesn't take measures to get dirty blocks written out, so we depend
>> > on the guest flushing the cache before we can get free the
>> > memory. Should we attempt to write unused dirty entries back?
>> > Berto?
>> 
>> I never thought about it, but sounds like worth exploring.
>
> Are you planning to do that or should I add it to my own todo list?

I can do that.

>> And thinking about this, perhaps this could be the simplest approach of
>> them all: let the user pass any value to l2-cache-size but then in
>> read_cache_sizes() do something like
>> 
>>     if (l2_cache_size_set && *l2_cache_size > max_l2_cache) {
>>         *l2_cache_size = max_l2_cache;
>>     }
>> 
>> Then if the image is resized you can recalculate this.
>> 
>> This way the user can make l2-cache-size the hard maximum that they ever
>> are willing to use for an image's L2 cache, and QEMU guarantees that it
>> won't allocate that much memory if it can cover the whole image with
>> less.
>> 
>> How does that sound?
>
> Yes. When you read the rest of the thread, you'll see that Leonid
> suggested the same and I agree. And if someone really wants cover the
> full image no matter how much memory it requires, they can just pass
> INT64_MAX and get the right thing.

I wonder why it took so long to think about this, it sounds rather
simple when you think about it...

Berto
