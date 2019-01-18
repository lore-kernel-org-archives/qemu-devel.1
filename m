Received: from eggs.gnu.org ([209.51.188.92]:38149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gkVJ7-00042n-VK
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gkVJ6-0002r1-2M
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:39:41 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <c135eaae-adc1-a5e3-1376-61bbe703cdfb@virtuozzo.com>
References: <20190108170655.29766-1-vsementsov@virtuozzo.com>
	<20190108170655.29766-9-vsementsov@virtuozzo.com>
	<w51pnsuwaxj.fsf@maestria.local.igalia.com>
	<c135eaae-adc1-a5e3-1376-61bbe703cdfb@virtuozzo.com>
Date: Fri, 18 Jan 2019 15:39:21 +0100
Message-ID: <w51k1j2vxly.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 8/9] qcow2: bdrv_co_pwritev: move
 encryption code out of the lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On Fri 18 Jan 2019 12:37:42 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> 18.01.2019 12:51, Alberto Garcia wrote:
>> On Tue 08 Jan 2019 06:06:54 PM CET, Vladimir Sementsov-Ogievskiy wrote:
>>> Encryption will be done in threads, to take benefit of it, we should
>>> move it out of the lock first.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   block/qcow2.c | 35 +++++++++++++++++++++--------------
>>>   1 file changed, 21 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index d6ef606d89..76d3715350 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -2077,11 +2077,20 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>>>           ret = qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
>>>                                            &cluster_offset, &l2meta);
>>>           if (ret < 0) {
>>> -            goto fail;
>>> +            goto out_locked;
>>>           }
>>>   
>>>           assert((cluster_offset & 511) == 0);
>>>   
>>> +        ret = qcow2_pre_write_overlap_check(bs, 0,
>>> +                                            cluster_offset + offset_in_cluster,
>>> +                                            cur_bytes);
>>> +        if (ret < 0) {
>>> +            goto out_locked;
>>> +        }
>>> +
>>> +        qemu_co_mutex_unlock(&s->lock);
>> 
>> The usage of lock() and unlock() functions inside and outside of the
>> loop plus the two 'locked' and 'unlocked' exit paths is starting to make
>> things a bit more messy.
>> 
>> Having a look at the code it seems that there's only these three parts
>> in the whole function that need to have the lock held:
>> 
>> one:
>>     ret = qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
>>                                      &cluster_offset, &l2meta);
>>     /* ... */
>>     ret = qcow2_pre_write_overlap_check(bs, 0,
>>                                         cluster_offset +
>>                                         offset_in_cluster,
>>                                         cur_bytes);
>> 
>> two:
>> 
>>     ret = qcow2_handle_l2meta(bs, &l2meta, true);
>> 
>> 
>> three:
>>     qcow2_handle_l2meta(bs, &l2meta, false);
>> 
>> 
>> So I wonder if it's perhaps simpler to add lock/unlock calls around
>> those blocks?
>
> this means, that we'll unlock after qcow2_handle_l2meta and then
> immediately lock on next iteration before qcow2_alloc_cluster_offset,
> so current code avoids this extra unlock/lock..

I don't have a very strong opinion, but maybe it's worth having if it
makes the code easier to read and maintain.

Berto
