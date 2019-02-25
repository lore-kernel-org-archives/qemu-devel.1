Received: from eggs.gnu.org ([209.51.188.92]:57313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyN0o-0004Ao-BM
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyN0n-0005Eg-Cq
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:38:06 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-8-jsnow@redhat.com>
	<ef3c7636-f920-7945-c8f8-0489580786ab@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b6fbdd44-7fbc-1482-e66f-2ac247d0781d@redhat.com>
Date: Mon, 25 Feb 2019 15:37:41 -0500
MIME-Version: 1.0
In-Reply-To: <ef3c7636-f920-7945-c8f8-0489580786ab@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/10] block/dirty-bitmaps: unify
 qmp_locked and user_locked calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>



On 2/25/19 7:03 AM, Vladimir Sementsov-Ogievskiy wrote:
> 23.02.2019 3:06, John Snow wrote:
>> These mean the same thing now. Unify them and rename the merged call
>> bdrv_dirty_bitmap_busy to indicate semantically what we are describing,
>> as well as help disambiguate from the various _locked and _unlocked
>> versions of bitmap helpers that refer to mutex locks.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> Hmm, and here, you directly fixed what I've noticed, so my r-b,
> of course, still applies.
> 

Sorry for not adding them. I didn't plan to merge the series until you
got a chance to review it, so I wasn't worried about missing it in the
long run. Sorry if it makes it harder to see which ones you'd like to
look at.

> Ha, but I noticed funny thing:
> 
>> ---
>>   block/dirty-bitmap.c           | 40 +++++++++++++++-------------------
>>   blockdev.c                     | 18 +++++++--------
>>   include/block/dirty-bitmap.h   |  5 ++---
>>   migration/block-dirty-bitmap.c |  6 ++---
>>   nbd/server.c                   |  6 ++---
>>   5 files changed, 34 insertions(+), 41 deletions(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index d92a269753..b3627b0d8c 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
> 
> [..]
> 
>> @@ -265,9 +259,9 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
>>       child->disabled = bitmap->disabled;
>>       bitmap->disabled = true;
>>   
>> -    /* Install the successor and lock the parent */
>> +    /* Install the successor and mark the parent as busy */
> 
> I asked you to fix comment for bdrv_dirty_bitmap_create_successor(), but I didn't
> noticed this one, I meant the comment to the whole function, placed above it, which
> now have
>   "Requires that the bitmap is not user_locked and has no successor."
> 
> So, it should be updated too.
> 
> and with it:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

Ha. OK, updated to "is not marked busy"

Thanks for the reviews!

>>       bitmap->successor = child;
>> -    bitmap->qmp_locked = true;
>> +    bitmap->busy = true;
>>       return 0;
>>   }
>>   
> 
