Received: from eggs.gnu.org ([2001:4830:134:3::10]:58062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d0xL5-0004NY-8i
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d0xL4-00076Z-4p
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:40:39 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-17-eblake@redhat.com>
	<18357712-90e8-c99e-a09b-52f0a3e164d6@redhat.com>
	<ce6c0c10-d9e3-2fd7-677e-838cd3f9e010@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2f38bef2-022b-881c-437c-7fb895214e4c@redhat.com>
Date: Wed, 19 Apr 2017 17:40:24 -0400
MIME-Version: 1.0
In-Reply-To: <ce6c0c10-d9e3-2fd7-677e-838cd3f9e010@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 16/17] block: Make
 bdrv_is_allocated() byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 04/19/2017 05:12 PM, Eric Blake wrote:
> On 04/19/2017 03:32 PM, John Snow wrote:
> 
>>> @@ -279,9 +280,9 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
>>>          /* Skip unallocated sectors; intentionally treats failure as
>>>           * an allocated sector */
>>>          while (cur_sector < total_sectors &&
>>> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
>>> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
>>> -            cur_sector += nr_sectors;
>>> +               !bdrv_is_allocated(blk_bs(bb), cur_sector * BDRV_SECTOR_SIZE,
>>> +                                  MAX_IS_ALLOCATED_SEARCH, &count)) {
>>> +            cur_sector += DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
>>>          }
>>
>> Let's try asking again with the right vocabulary:
>>
>> OK, so I guess the idea is that we definitely shouldn't ever have a
>> partially allocated sector; so I suppose this ROUND_UP is just a precaution?
> 
> For now, yes - but the part 3 series (bdrv_get_block_status) makes
> returning a sub-sector value possible.  For most drivers, it will only
> happen at end-of-file (as status doesn't change mid-sector unless your
> file is not a multiple of a sector size) - in fact, I found that I had
> to patch the block layer to round up and sub-sector return that
> coincides with end-of-file back to a round sector amount in order to
> avoid breaking other code that assumed everything is allocated in sectors.

I'm sorry, I'm having difficulty parsing your last sentence.

> 
>>
>> What would it mean if this actually DID round up? Would we miss
>> transmitting a fraction of a sector because we assumed it was unallocated?
> 
> In general, the only mid-sector transition I encountered in testing was
> at EOF, where the first half is allocated and the second half (beyond
> EOF) was an implicit hole.  But here, you are worried about the opposite
> case - can we ever have a hole that ends mid-sector, followed by actual
> data in the second half.  Probably not, but I can add an assertion to
> the generic block layer that mid-sector returns for an unallocated
> answer can only happen at end-of-file.
> 

Yeah, just curious about the implications from a naive-user point of
view, as it makes the algorithm in the caller look ugly now.

I agree with you that there is absolutely definitely no real problem
here right now, but I do secretly wonder if we'll invent a way to screw
ourselves over.

Presumably it will get converted at SOME point like everything else, and
it won't be a concern anymore.

Presumably Presumably that will even happen before we invent a way to
screw ourselves over.

>>
>> In other places, you scale down with X / BDRV_SECTOR_SIZE or an
>> equivalent bitshift, why does this receive a round *up* treatment?
> 
> Really? I thought I was being careful in this patch about ALWAYS
> preserving the same sector value - the only time I did a bitshift was if
> I already asserted the answer was aligned to sector boundaries to begin
> with, and when I wasn't sure, it should be a round up.
> 

You're probably right as I hadn't been paying perfectly close attention
to exactly how you'd been scaling the values, this is simply the only
one that stood out to me as slightly strange due to the DIV_ROUND_UP
macro so I had assumed it stood out, but maybe I'm misidentifying why.

>>
>> Are we considering a future in which this function might actually give
>> us some unaligned answers? Do we need to re-audit all of the callers at
>> that point to make sure they cope appropriately?
> 
> Yes, I've been trying to do that all along, but a second set of eyes
> never hurts.  Or, as I said, we can play it safe by guaranteeing that
> even when byte-based, the block layer enforces sector-aligned answers.
> 

Just making sure I'm clear that we expect this function to do so;
clearly we're (You're*) removing sector assumptions from as many places
as we (You) can.

Thanks for playing whack-a-mole with stupid questions, I think I'm
on-board now.

--js
