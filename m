Received: from eggs.gnu.org ([2001:4830:134:3::10]:38145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d4FsI-0000vV-6x
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 20:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d4FsG-0002L0-T8
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 20:04:34 -0400
References: <73ecd486-2d5c-e204-1588-a0b6324ba77b@virtuozzo.com>
	<a18117bb-bf65-1263-48f0-72a2696cdc0b@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <754114c9-9be5-f11b-571b-2cd1c2b5d98f@virtuozzo.com>
Date: Fri, 28 Apr 2017 22:35:16 +0300
MIME-Version: 1.0
In-Reply-To: <a18117bb-bf65-1263-48f0-72a2696cdc0b@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] RFC: some problems with bdrv_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, QEMU <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Stephane Chazelas <stephane.chazelas@gmail.com>

On 04/28/2017 09:31 PM, Eric Blake wrote:
> On 04/28/2017 11:17 AM, Denis V. Lunev wrote:
>> Hello, All!
>>
>> Recently we have experienced problems with very slow
>> bdrv_get_block_status call, which is massive called f.e.
>> from mirror_run().
>>
>> The problem was narrowed down to slow lseek64() system
>> call, which can take 1-2-3 seconds.
> I'm guessing you meant one-to-three (the range), not one-two-three
> (three separate digits), and just had an unfortunate abbreviation of
> 'to' turning into the phonetically-similar '2'.
>
from 1 to 3, you are correct


>> root@s158 ~]# strace -f -p 77048 -T  -e lseek
>> Process 77048 attached with 14 threads
>> [pid 77053] lseek(23, 6359613440, SEEK_DATA) = 6360276992 <1.250323>
> That sounds like a bug in your choice of filesystem.  It's been
> mentioned before that lseek has some pathetically poor behavior (I think
> tmpfs was one of the culprits), but I maintain that it is better to
> hammer on the kernel folks to fix the poor behavior than it is to have
> to implement user-space workarounds in every single affected program.
>
> That said, a workaround of being able to request the avoidance of lseek
> has been brought up on this list before.
>
>
>> The problem comes from this branch of the code
>>
>> bdrv_co_get_block_status
>>     .......
>>     if (bs->file &&
>>         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
>>         (ret & BDRV_BLOCK_OFFSET_VALID)) {
>>         int file_pnum;
>>
>>         ret2 = bdrv_co_get_block_status(bs->file, ret >> BDRV_SECTOR_BITS,
>>                                         *pnum, &file_pnum);
>>         if (ret2 >= 0) {
>>             /* Ignore errors.  This is just providing extra information, it
>>              * is useful but not necessary.
>>              */
>>             if (!file_pnum) {
>>                 /* !file_pnum indicates an offset at or beyond the EOF;
>> it is
>>                  * perfectly valid for the format block driver to point
>> to such
>>                  * offsets, so catch it and mark everything as zero */
>>                 ret |= BDRV_BLOCK_ZERO;
>>             } else {
>>                 /* Limit request to the range reported by the protocol
>> driver */
>>                 *pnum = file_pnum;
>>                 ret |= (ret2 & BDRV_BLOCK_ZERO);
>>             }
>>         }
>>     }
> I don't see anything wrong with this code. It's nice to know that we
> have data (qcow2 says we have allocated bytes due to this layer, so
> don't refer to the backing files), but when the underlying file can ALSO
> tell us that the underlying protocol is sparse and we are on a hole,
> then we know that we have BDRV_BLOCK_ZERO condition which can in turn
> enable other optimizations in quite a bit of the stack.  It IS valid to
> return BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO (we don't have to limit
> ourselves to BDRV_BLOCK_DATA), and we should probably do so any time
> that such computation is cheap.
>
> I agree with your analysis that on a poor filesystem where lseek()
> behavior sucks that it is no longer cheap to determine where the holes are.
>
> But the proper workaround for those filesystems should NOT be made by
> undoing this part of bdrv_co_get_block_status(), but should rather be
> fixed in file-posix.c by the addition of a user-controllable knob on
> whether to skip lseek().  In other words, if we're going to work around
> the poor filesystem performance, the workaround should live in
> file-posix.c, not in the generic block/io.c.  Once the workaround is
> enabled, the 'ret2 = bdrv_co_get_block_status()' nested call should be
> lightning fast (because file-posix.c would no longer be using lseek when
> you've requested the workaround).
>
>> Frankly speaking, this optimization should not give much.
>> If upper layer format (QCOW2) says that we have data
>> here, then nowadays in 99.9% we do have the data.
> You are correct that we have BDRV_BLOCK_DATA; but it IS useful to ALSO
> know if that data reads back as all zeros (so we can skip reading it).
> Just because qcow2 reports something as data does NOT rule out whether
> the data still reads as zeros.
>
>> Meanwhile this branch can cause problems. We would
>> need block cleared entirely to get the benefit for most
>> cases in mirror and backup operations.
>>
>> At my opinion it worth to drop this at all.
>>
>> Guys, do you have any opinion?
> Again, my opinion is to not change this part of block/io.c.  Rather,
> work should be expended on individual protocol drivers to quit wasting
> unnecessary time on reporting BDRV_BLOCK_ZERO if the time spent to
> determine that is not worth the effort (as it is when using lseek() on
> inefficient filesystems).  It is always safe for a protocol driver to
> report BDRV_BLOCK_DATA instead of BDRV_BLOCK_ZERO, if asking the
> question is too expensive (treating holes as data may pessimize other
> operations, but that's okay if the penalty for asking is worse than what
> optimizations are able to regain).
>
>> Den
>>
>> P.S. The kernel is one based on RedHat 3.10.0-514. The same
>>       problem was observed in 3.10.0-327 too.
> Red Hat is always two words (I'm allowed to point that out, as they
> employ me ;).  But if it really is a Red Hat kernel problem, be sure to
> use your support contract to point out the kernel developers that they
> really need to fix lseek() - and you'll need to give details on which
> filesystem you're using (as not all filesystems have that abysmal
> performance).
>
