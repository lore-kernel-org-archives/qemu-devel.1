Received: from eggs.gnu.org ([2001:4830:134:3::10]:55200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFafu-0002Mi-Gk
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFaft-0004A6-Oi
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:30:38 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:13677 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFaft-00049v-DN
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:30:37 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-26-vsementsov@virtuozzo.com>
	<2329cfc4-d5b3-9fe2-668d-fd6ba1f5d316@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <48da970c-8400-346b-6ade-543e9f314197@virtuozzo.com>
Date: Tue, 30 May 2017 09:30:15 +0300
MIME-Version: 1.0
In-Reply-To: <2329cfc4-d5b3-9fe2-668d-fd6ba1f5d316@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 25/25] block: release persistent bitmaps on
 inactivate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

29.05.2017 20:54, Max Reitz wrote:
> On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
>> We should release them here to reload on invalidate cache.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block.c                      |  4 ++++
>>   block/dirty-bitmap.c         | 29 +++++++++++++++++++++++------
>>   include/block/dirty-bitmap.h |  1 +
>>   3 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 795d36bb64..14896c65fa 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -4001,6 +4001,10 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
>>       if (setting_flag) {
>>           bs->open_flags |= BDRV_O_INACTIVE;
>>       }
>> +
>> +    /* At this point persistent bitmaps should be stored by format driver */
> s/by format driver/by the format driver/
>
>> +    bdrv_release_persistent_dirty_bitmaps(bs);
> Also, as far as I can see, this doesn't store the bitmaps but just
> releases them (without storing them). I'm not sure whether that is
> right, but it definitely contradicts the comment above.

I mean they should be _already_ stored.. They actually are stored in  
qcow2_inactivate.

>
> Max
>
>> +
>>       return 0;
>>   }
>>

-- 
Best regards,
Vladimir
