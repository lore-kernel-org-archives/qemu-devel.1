Received: from eggs.gnu.org ([2001:4830:134:3::10]:40319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elyPl-0007SK-Gt
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elyPk-0008Od-LO
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:52:05 -0500
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-20-eblake@redhat.com>
	<20180214130848.GC4766@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49c48f2e-1741-82e7-0456-2ad00a37f91c@redhat.com>
Date: Wed, 14 Feb 2018 08:51:56 -0600
MIME-Version: 1.0
In-Reply-To: <20180214130848.GC4766@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 19/21] vpc: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 02/14/2018 07:08 AM, Kevin Wolf wrote:
> Am 13.02.2018 um 21:26 hat Eric Blake geschrieben:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  Update the vpc driver accordingly.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>
>> ---

>> +    allocated = (image_offset != -1);
>>       *pnum = 0;
>>       ret = 0;
>>
>>       do {
>>           /* All sectors in a block are contiguous (without using the bitmap) */
>> -        n = ROUND_UP(sector_num + 1, s->block_size / BDRV_SECTOR_SIZE)
>> -          - sector_num;
>> -        n = MIN(n, nb_sectors);
>> +        n = ROUND_UP(offset + 1, s->block_size) - offset;
>> +        n = MIN(n, bytes);
>>
>>           *pnum += n;
>> -        sector_num += n;
>> -        nb_sectors -= n;
>> +        offset += n;
>> +        bytes -= n;
>>           /* *pnum can't be greater than one block for allocated
>>            * sectors since there is always a bitmap in between. */
>>           if (allocated) {
>>               *file = bs->file->bs;
>> -            ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | start;
>> +            *map = image_offset;
> 
> This does work, but only because the loop isn't actually looping for
> allocated == true. In the old code, it was obvious that start was
> assigned only once and never changed during the loop, but image_offset
> changes in each loop iteration.
> 
> It would probably be cleaner and more obviously correct to move the
> assignment of *map to before the loop.

Yes, that would be a bit nicer.

> 
> Kevin
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
