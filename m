Received: from eggs.gnu.org ([2001:4830:134:3::10]:37623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erIbT-0008US-RJ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erIbS-0007TO-Do
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:26:11 -0500
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-10-eblake@redhat.com>
	<20180214120525.GB4766@localhost.localdomain>
	<afb56cfd-4f42-07e5-9a65-d929b2ea9916@redhat.com>
	<20180223170525.GF3470@localhost.localdomain>
	<010d7d4e-c6d1-f8fb-8c4c-7aa0b19a94b7@redhat.com>
	<20180226140518.GA5106@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1724b4e9-ff78-9725-286e-6886704f7f13@virtuozzo.com>
Date: Thu, 1 Mar 2018 10:25:55 +0300
MIME-Version: 1.0
In-Reply-To: <20180226140518.GA5106@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v8 09/21] null: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

26.02.2018 17:05, Kevin Wolf wrote:
> Am 24.02.2018 um 00:38 hat Eric Blake geschrieben:
>> On 02/23/2018 11:05 AM, Kevin Wolf wrote:
>>> Am 23.02.2018 um 17:43 hat Eric Blake geschrieben:
>>>>> OFFSET_VALID | DATA might be excusable because I can see that it's
>>>>> convenient that a protocol driver refers to itself as *file instead of
>>>>> returning NULL there and then the offset is valid (though it would be
>>>>> pointless to actually follow the file pointer), but OFFSET_VALID without
>>>>> DATA probably isn't.
>>>> So OFFSET_VALID | DATA for a protocol BDS is not just convenient, but
>>>> necessary to avoid breaking qemu-img map output.  But you are also right
>>>> that OFFSET_VALID without data makes little sense at a protocol layer. So
>>>> with that in mind, I'm auditing all of the protocol layers to make sure
>>>> OFFSET_VALID ends up as something sane.
>>> That's one way to look at it.
>>>
>>> The other way is that qemu-img map shouldn't ask the protocol layer for
>>> its offset because it already knows the offset (it is what it passes as
>>> a parameter to bdrv_co_block_status).
>>>
>>> Anyway, it's probably not worth changing the interface, we should just
>>> make sure that the return values of the individual drivers are
>>> consistent.
>> Yet another inconsistency, and it's making me scratch my head today.
>>
>> By the way, in my byte-based stuff that is now pending on your tree, I tried
>> hard to NOT change semantics or the set of flags returned by a given driver,
>> and we agreed that's why you'd accept the series as-is and make me do this
>> followup exercise.  But it's looking like my followups may end up touching a
>> lot of the same drivers again, now that I'm looking at what the semantics
>> SHOULD be (and whatever I do end up tweaking, I will at least make sure that
>> iotests is still happy with it).
> Hm, that's unfortunate, but I don't think we should hold up your first
> series just so we can touch the drivers only once.
>
>> First, let's read what states the NBD spec is proposing:
>>
>>> It defines the following flags for the flags field:
>>>
>>>      NBD_STATE_HOLE (bit 0): if set, the block represents a hole (and future writes to that area may cause fragmentation or encounter an ENOSPC error); if clear, the block is allocated or the server could not otherwise determine its status. Note that the use of NBD_CMD_TRIM is related to this status, but that the server MAY report a hole even where NBD_CMD_TRIM has not been requested, and also that a server MAY report that the block is allocated even where NBD_CMD_TRIM has been requested.
>>>      NBD_STATE_ZERO (bit 1): if set, the block contents read as all zeroes; if clear, the block contents are not known. Note that the use of NBD_CMD_WRITE_ZEROES is related to this status, but that the server MAY report zeroes even where NBD_CMD_WRITE_ZEROES has not been requested, and also that a server MAY report unknown content even where NBD_CMD_WRITE_ZEROES has been requested.
>>>
>>> It is not an error for a server to report that a region of the export has both NBD_STATE_HOLE set and NBD_STATE_ZERO clear. The contents of such an area are undefined, and a client reading such an area should make no assumption as to its contents or stability.
>> So here's how Vladimir proposed implementing it in his series (written
>> before my byte-based block status stuff went in to your tree):
>> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04038.html
>>
>> Server side (3/9):
>>
>> +        int ret = bdrv_block_status_above(bs, NULL, offset, tail_bytes,
>> &num,
>> +                                          NULL, NULL);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +
>> +        flags = (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
>> +                (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);
>>
>> Client side (6/9):
>>
>> +    *pnum = extent.length >> BDRV_SECTOR_BITS;
>> +    return (extent.flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_DATA) |
>> +           (extent.flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0);
>>
>> Does anything there strike you as odd?
> Two things I noticed while reading the above:
>
> 1. NBD doesn't consider backing files, so the definition of holes
>     becomes ambiguous. Is a hole any block that isn't allocated in the
>     top layer (may cause fragmentation or encounter an ENOSPC error) or
>     is it any block that isn't allocated anywhere in the whole backing
>     chain (may read as non-zero)?
>
>     Considering that there is a separate NBD_STATE_ZERO and nothing
>     forbids a state of NBD_STATE_HOLE without NBD_STATE_ZERO, maybe the
>     former is more useful. The code you quote implements the latter.
>
>     Maybe if we go with the former, we should add a note to the NBD spec
>     that explictly says that NBD_STATE_HOLE doesn't imply any specific
>     content that is returned on reads.
>
> 2. Using BDRV_BLOCK_ALLOCATED to determine NBD_STATE_HOLE seems wrong. A
>     (not preallocated) zero cluster in qcow2 returns BDRV_BLOCK_ALLOCATED
>     (because we don't fall through to the backing file) even though I
>     think it's a hole. BDRV_BLOCK_DATA should be used there (which makes
>     it consistent with the other direction).
>
>> In isolation, they seemed fine to
>> me, but side-by-side, I'm scratching my head: the server queries the block
>> layer, and turns BDRV_BLOCK_ALLOCATED into !NBD_STATE_HOLE; the client side
>> then takes the NBD protocol and tries to turn it back into information to
>> feed the block layer, where !NBD_STATE_HOLE now feeds BDRV_BLOCK_DATA.  Why
>> the different choice of bits?
> Which is actually consistent in the end, becaue BDRV_BLOCK_DATA implies
> BDRV_BLOCK_ALLOCATED.
>
> Essentially, assuming a simple backing chain 'base <- overlay', we got
> these combinations to represent in NBD (with my suggestion of the flags
> to use):
>
> 1. Cluster allocated in overlay
>     a. non-zero data                         0
>     b. explicit zeroes                       0 or ZERO
> 2. Cluster marked zero in overlay           HOLE | ZERO
> 3. Cluster preallocated/zero in overlay     ZERO
> 4. Cluster unallocated in overlay
>     a. Cluster allocated in base (non-zero)  HOLE
>     b. Cluster allocated in base (zero)      HOLE or HOLE | ZERO
>     c. Cluster marked zero in base           HOLE | ZERO
>     d. Cluster preallocated/zero in base     HOLE | ZERO
>     e. Cluster unallocated in base           HOLE | ZERO
>
> Instead of 'base' you can read 'anywhere in the backing chain' and the
> flags should stay the same.

I think only "anywhere in the backing chain" is valid here. Otherwise, 
semantics of bdrv_is_allocated would differ for NBD and for not-NBD. I 
think, if bdrv_is_allocated returns false, it means that we can skip 
this region in copying process, am I right?


>
> So !BDRV_BLOCK_ALLOCATED (i.e. falling through to the backing file) does
> indeed imply NBD_STATE_HOLE, but so does case 2, which is just !DATA.
>
>

-- 
Best regards,
Vladimir
