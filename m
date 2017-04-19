Received: from eggs.gnu.org ([2001:4830:134:3::10]:46925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d0vPf-0006Qm-Oj
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d0vPe-0004eK-U3
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:37:15 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-17-eblake@redhat.com>
	<7cfbc72e-06e2-6b68-004b-0a898e1d36b5@redhat.com>
	<3059b242-fc42-6e57-6f4c-ff66997b8a36@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8cbf8c8c-8c21-27b3-280d-4fc6437176cd@redhat.com>
Date: Wed, 19 Apr 2017 15:37:00 -0400
MIME-Version: 1.0
In-Reply-To: <3059b242-fc42-6e57-6f4c-ff66997b8a36@redhat.com>
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



On 04/19/2017 01:54 PM, Eric Blake wrote:
> On 04/18/2017 05:15 PM, John Snow wrote:
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
>>
>> Hm, what's the story here, why are we rounding this up? If, in theory,
>> we have a partially allocated cluster won't we advance past that?
> 
> This is rounding to sectors, not clusters (that is, the code is supposed
> to advance cur_sector identically pre- and post-patch).  As to whether
> the overall algorithm makes sense, or could use some tweaking by
> converting migration/block.c to do everything by bytes instead of by
> sectors, I haven't yet given that any serious time.
> 

Err, right... temporary brain schism. DIV_ROUND_UP not ALIGN_UP, my mistake.

> 
