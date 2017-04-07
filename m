Received: from eggs.gnu.org ([2001:4830:134:3::10]:41332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cwVJC-0006Wu-KV
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cwVJ9-0004D8-Bp
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:56:18 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170407124121.GC4716@noname.redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
	<20170407124121.GC4716@noname.redhat.com>
Date: Fri, 07 Apr 2017 16:24:44 +0200
Message-ID: <w514ly0e1n7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri 07 Apr 2017 02:41:21 PM CEST, Kevin Wolf <kwolf@redhat.com> wrote:
>> 63    56 55    48 47    40 39    32 31    24 23    16 15     8 7      0
>> 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> **<----> <-----------------------------------------------><---------->*
>>   Rsrved              host cluster offset of data             Reserved
>>   (6 bits)                (44 bits)                           (11 bits)
>> 
>> where you have 17 bits plus the "all zeroes" bit to play with, thanks to
>> the three bits of host cluster offset that are now guaranteed to be zero
>> due to cluster size alignment (but you're also right that the "all
>> zeroes" bit is now redundant information with the 8 subcluster-is-zero
>> bits, so repurposing it does not hurt)
>> 
>> > 
>> >     * Pros:
>> >       + Simple. Few changes compared to the current qcow2 format.
>> > 
>> >     * Cons:
>> >       - Only 8 subclusters per cluster. We would not be making the
>> >         most of this feature.
>> > 
>> >       - No reserved bits left for the future.
>> 
>> I just argued you have at least one, and probably 2, bits left over for
>> future in-word expansion.
>
> I think only 8 subclusters is just too few. That the subcluster status
> would be split in two halves doesn't make me like this layout much
> better either.

I also agree that 8 are too few (splitting the subcluster field would
not be strictly necessary, but that's not so important).

>> > (2) Making L2 entries 128-bit wide.
>> > 
>> >     In this alternative we would double the size of L2 entries. The
>> >     first half would remain unchanged and the second one would store
>> >     the bitmap. That would leave us with 32 subclusters per cluster.
>> 
>> Although for smaller cluster sizes (such as 4k clusters), you'd still
>> want to restrict that subclusters are at least 512-byte sectors, so
>> you'd be using fewer than 32 of those subcluster positions until the
>> cluster size is large enough.
>> 
>> > 
>> >     * Pros:
>> >       + More subclusters per cluster. We could have images with
>> >         e.g. 128k clusters with 4k subclusters.
>> 
>> Could allow variable-sized subclusters (your choice of 32 subclusters of
>> 4k each, or 16 subclusters of 8k each)
>
> I don't think using less subclusters is desirable if it doesn't come
> with savings elsewhere. We already need to allocate two clusters for an
> L2 table now, so we want to use it.
>
> The more interesting kind of variable-sized subclusters would be if you
> could select any multiple of 32, meaning three or more clusters per L2
> table (with 192 bits or more per entry).

Yeah, I agree. I think it's worth considering. One more drawback that I
can think of is that if we make L2 entries wider and we have compressed
clusters we'd be wasting space in their entries.

>> >       - One more metadata structure to be updated for each
>> >         allocation. This would probably impact I/O negatively.
>> 
>> Having the subcluster table directly in the L2 means that updating
>> the L2 table is done with a single write. You are definitely right
>> that having the subcluster table as a bitmap in a separate cluster
>> means two writes instead of one, but as always, it's hard to predict
>> how much of an impact that is without benchmarks.
>
> Note that it's not just additional write requests, but that we can't
> update the L2 table entry and the bitmap atomically any more, so we
> have to worry about ordering. The ordering between L2 table and
> refcount blocks is already painful enough, I'm not sure if I would
> want to add a third type. Ordering also means disk flushes, which are
> a lot slower than just additional writes.

You're rightk, I think you just convinced me that this is a bad idea and
I'm also more inclined towards (2) now.

Berto
