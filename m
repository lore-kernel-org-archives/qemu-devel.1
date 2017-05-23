Received: from eggs.gnu.org ([2001:4830:134:3::10]:59177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dD5IX-0004nf-SX
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dD5IU-0003UH-Q4
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:36:09 -0400
Received: from mail-db5eur01on0102.outbound.protection.outlook.com
	([104.47.2.102]:62625
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dD5IU-0003T4-DH
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:36:06 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-3-git-send-email-anton.nefedov@virtuozzo.com>
	<7fbddc0e-298b-5973-8f0e-47b753ab41a8@redhat.com>
	<903458e3-c82e-67d5-85f6-e1b67b829ec7@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <4a7f7d3a-feb9-614f-cfaf-ce10342bf0b6@virtuozzo.com>
Date: Tue, 23 May 2017 11:35:58 +0300
MIME-Version: 1.0
In-Reply-To: <903458e3-c82e-67d5-85f6-e1b67b829ec7@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 02/13] qcow2: is_zero_sectors(): return
 true if area is outside of backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, mreitz@redhat.com



On 05/22/2017 10:14 PM, Eric Blake wrote:
> On 05/22/2017 02:12 PM, Eric Blake wrote:
>
>>> +++ b/block/qcow2.c
>>> @@ -2482,7 +2482,7 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
>>>      int64_t res;
>>>
>>>      if (start + count > bs->total_sectors) {
>>> -        count = bs->total_sectors - start;
>>> +        count = start < bs->total_sectors ? bs->total_sectors - start : 0;
>>>      }
>>>
>>>      if (!count) {
>>> @@ -2490,7 +2490,9 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
>>>      }
>>>      res = bdrv_get_block_status_above(bs, NULL, start, count,
>>>                                        &nr, &file);
>>> -    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == count;
>>> +    return res >= 0
>>> +        && (((res & BDRV_BLOCK_ZERO) && nr == count)
>>> +            || nr == 0);
>>
>> The logic makes sense to me, although the formatting is unusual (we tend
>> to split && and || with the operator at the tail of the previous line,
>> not the head of the new line).
>>
>> This quick check may make me revisit whether it is worth my my RFC
>> series about adding BDRV_BLOCK_EOF for more quickly tracking reads
>> beyond EOF (my solution in that series was able to make the same change
>> to test 154, but by doing it at the block layer instead of the qcow2.c
>> code).  https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01127.html
>
> Actually, re-reading my RFC - I was able to change 6 instances in test
> 154, while your tweak only affected 2 instances (you still left four
> instances that were allocating).  So my approach may still be more
> optimal in the long run.
>

Yes, looks like your approach is more general; let's drop this one then

/Anton
