Received: from eggs.gnu.org ([209.51.188.92]:35590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gte5D-00041n-Ds
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtdxz-00021B-Gw
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:43:41 -0500
References: <20190206170205.13061-1-jsnow@redhat.com>
	<ddc2f850-e7b9-e8f8-4fc1-a3b62a5164e5@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <aa68e74e-333b-9470-7a6c-29110cb186d6@redhat.com>
Date: Tue, 12 Feb 2019 14:43:35 -0500
MIME-Version: 1.0
In-Reply-To: <ddc2f850-e7b9-e8f8-4fc1-a3b62a5164e5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] blockdev: acquire aio_context for bitmap
 add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementsov@virtuozzo.com



On 2/12/19 2:36 PM, Eric Blake wrote:
> On 2/6/19 11:02 AM, John Snow wrote:
>> When bitmaps are persistent, they may incur a disk read or write when bitmaps
>> are added or removed. For configurations like virtio-dataplane, failing to
>> acquire this lock will abort QEMU when disk IO occurs.
>>
>> We used to acquire aio_context as part of the bitmap lookup, so re-introduce
>> the lock for just the cases that have an IO penalty.
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1672010
>> Reported-By: Aihua Liang <aliang@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  blockdev.c | 24 +++++++++++++++++++-----
>>  1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index fb18e9c975..ce458de037 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2820,6 +2820,7 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>>  {
>>      BlockDriverState *bs;
>>      BdrvDirtyBitmap *bitmap;
>> +    AioContext *aio_context = NULL;
>>  
>>      if (!name || name[0] == '\0') {
>>          error_setg(errp, "Bitmap name cannot be empty");
>> @@ -2854,10 +2855,12 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>>          disabled = false;
>>      }
>>  
>> -    if (persistent &&
>> -        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
>> -    {
>> -        return;
>> +    if (persistent) {
>> +        aio_context = bdrv_get_aio_context(bs);
>> +        aio_context_acquire(aio_context);
>> +        if (!bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp)) {
>> +            goto out;
>> +        }
>>      }
>>  
>>      bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
>     if (bitmap == NULL) {
>         return;
>     }
> 
> Oops - this early return fails to release the aio context.

Good spot, thanks! This would be awful to diagnose later.
