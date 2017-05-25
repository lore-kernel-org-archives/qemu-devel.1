Received: from eggs.gnu.org ([2001:4830:134:3::10]:49616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDxMA-0001m8-GV
	for qemu-devel@nongnu.org; Thu, 25 May 2017 14:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDxM5-0000h7-EB
	for qemu-devel@nongnu.org; Thu, 25 May 2017 14:19:30 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:19789 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDxM4-0000gh-Tl
	for qemu-devel@nongnu.org; Thu, 25 May 2017 14:19:25 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-3-vsementsov@virtuozzo.com>
	<4d041d0a-ed17-4d72-fce2-e2500e9ec0fc@redhat.com>
	<245523c5-59fd-f585-291f-fe7fe64bb500@virtuozzo.com>
Message-ID: <6d16d9d2-cd5b-a71f-740d-0721845cca96@virtuozzo.com>
Date: Thu, 25 May 2017 21:19:18 +0300
MIME-Version: 1.0
In-Reply-To: <245523c5-59fd-f585-291f-fe7fe64bb500@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] block: add
 bdrv_get_format_allocated_size format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

25.05.2017 21:07, Vladimir Sementsov-Ogievskiy wrote:
> 25.05.2017 20:54, Eric Blake wrote:
>> On 05/25/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> The function should return actually used by top-level format driver
>> s/actually/the allocation actually/
>>
>>> space (in it's .file). It differs from bdrv_get_allocated_file_size,
>> s/it's/its/ (remember, "it's" is only appropriate if "it is" can be used
>> in its place)
>>
>>> which returns allocated on fs file size.
>> s/allocated on fs file size/the disk usage of the underlying file/
>>
>> So this is a measure of how many clusters a qcow2 image is currently
>> using (including metadata clusters, and regardless of whether those
>> clusters happen to point to a hole in the underlying protocol layer)?
>
> Hmm, interesting remark. Now it is realized exactly as you write.. But 
> this leads to the situation, when qcow2 allocates data amount > 
> bdrv_getlength(bs->file->bs) and we will have negative size of 
> unallocated area =). Denis what do you think? (Actually, we needed 
> this feature for non-sparce file system and this question was not 
> considered).

No, it will not be negative, all OK. I've mistaken. length of 
bs->file->bs will be positive anyway.

Actually, current approach is the following:

a. clusters allocated in qcow2 and after the end of bs->file: unallocated
b. clusters allocated in qcow2 and which are holes bs->file: allocated

(a) look inconsistent with b and with commit message and other things. 
But if I just account (a) clusters, it will lead to negative size of 
unallocated and will spoil the whole stat.. Something should be 
adjusted, at least at comment/commit-message level.


>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
>>> ---
>>>   block.c                   | 15 +++++++++++++++
>>>   include/block/block.h     |  1 +
>>>   include/block/block_int.h |  1 +
>>>   3 files changed, 17 insertions(+)
>>>
>>> diff --git a/block.c b/block.c
>>> index ba22fc0dfb..6e1a435490 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -3407,6 +3407,21 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
>>>   }
>>>   
>>>   /**
>>> + * Actually used by top-level format driver space (in it's .file) in bytes
>> s/it's/its/
>>
>> I think we can do better.  How about:
>>
>> Return the amount of space allocated by the format driver (including
>> metadata) in bytes, even if some of that space currently maps to holes
>> in the underlying protocol file.
>>
>
> -- 
> Best regards,
> Vladimir


-- 
Best regards,
Vladimir
