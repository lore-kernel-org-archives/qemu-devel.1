Received: from eggs.gnu.org ([2001:4830:134:3::10]:35000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eotja-00016R-MH
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eotjV-0004OI-Si
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:28:38 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180222141757.GH4147@localhost.localdomain>
References: <20180219145459.8143-1-berto@igalia.com>
	<20180221183355.GC353@localhost.localdomain>
	<w51efld5g26.fsf@maestria.local.igalia.com>
	<20180222141757.GH4147@localhost.localdomain>
Date: Thu, 22 Feb 2018 17:28:31 +0100
Message-ID: <w51zi413s5s.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "Denis V . Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>

On Thu 22 Feb 2018 03:17:57 PM CET, Kevin Wolf wrote:
>> > While we're at it, would l2-cache-entry-size = MIN(cluster_size,
>> > 64k) make sense as a default?
>> 
>> Any reason why you choose 64k, or is it because it's the default
>> cluster size?
>> 
>> In general I'd be cautious to reduce the default entry size
>> unconditionally because with rotating HDDs it may even have a
>> negative (although slight) effect on performance. But the larger the
>> cluster, the larger the area mapped by L2 entries, so we need less
>> metadata and it makes more sense to read less in general.
>> 
>> In summary: while I think it's probably a good idea, it would be good
>> to make some tests before changing the default.
>
> The exact value of 64k is more or less because it's the default
> cluster size, yes. Not changing anything for the default cluster size
> makes it a bit easier to justify.
>
> What I really want to fix is the 2 MB entry size with the maximum
> cluster size, because that's just unreasonably large. It's not
> completely clear what the ideal size is, but when we increased the
> default cluster size from 4k, the optimal values (on rotating hard
> disks back then) were 64k or 128k. So I assume that it's somewhere
> around these sizes that unnecessary I/O starts to hurt more than
> reading one big chunk instead of two smaller ones helps.
>
> Of course, guest I/O a few years ago and metadata I/O today aren't
> exactly the same thing, so I agree that a change should be measured
> first. But 64k-128k feels right as an educated guess where to start.

Yes, I agree.

>> > So should we default to this minimum on the grounds that for most
>> > people, refcounts blocks are probably only accessed sequentially in
>> > practice? The remaining memory of the total cache size seems to
>> > help the average case more if it's added to the L2 cache instead.
>> 
>> That sounds like a good idea. We should double check that the minimum
>> is indeed the required minimum, and run some tests, but otherwise I'm
>> all for it.
>> 
>> I think I can take care of this if you want.
>
> That would be good.
>
> I'm pretty confident that the minimum is enough because it's also the
> default for 64k clusters. Maybe it's too high if I miscalculated back
> then, but I haven't seen a crash report related to running out of
> refcount block cache entries.

Ok, I'll take a look.

Berto
