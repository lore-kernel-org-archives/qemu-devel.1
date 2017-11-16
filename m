Received: from eggs.gnu.org ([2001:4830:134:3::10]:40130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFF64-0007YJ-5V
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFF5u-0005OO-9H
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:00:28 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<20171113162053.58795-2-vsementsov@virtuozzo.com>
	<12463b01-41eb-4d17-65c0-a94de499e753@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <80297062-eb79-e3ac-7188-dcefe93e0f3e@virtuozzo.com>
Date: Thu, 16 Nov 2017 10:59:58 +0300
MIME-Version: 1.0
In-Reply-To: <12463b01-41eb-4d17-65c0-a94de499e753@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/4 for-2.11?] block/dirty-bitmap: add lock
 to bdrv_enable/disable_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, armbru@redhat.com, pbonzini@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

13.11.2017 20:50, Eric Blake wrote:
> On 11/13/2017 10:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Like other setters here these functions should take a lock.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/dirty-bitmap.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> Should this patch be in 2.11?


these functions are unused now, so, no, it's not necessary

>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index bd04e991b1..2a0bcd9e51 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -397,15 +397,19 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>   /* Called with BQL taken.  */
>>   void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>>   {
>> +    bdrv_dirty_bitmap_lock(bitmap);
>>       assert(!bdrv_dirty_bitmap_frozen(bitmap));
>>       bitmap->disabled = true;
>> +    bdrv_dirty_bitmap_unlock(bitmap);
> Why do we need this lock in addition to BQL?
>
>>   }
>>   
>>   /* Called with BQL taken.  */
>>   void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>>   {
>> +    bdrv_dirty_bitmap_lock(bitmap);
>>       assert(!bdrv_dirty_bitmap_frozen(bitmap));
>>       bitmap->disabled = false;
>> +    bdrv_dirty_bitmap_unlock(bitmap);
> Again, why do we need this in addition to BQL?
>
> The commit message needs more details about a scenario where our
> existing BQL lock is insufficient to prevent misuse of bitmap->disabled.
>


-- 
Best regards,
Vladimir
