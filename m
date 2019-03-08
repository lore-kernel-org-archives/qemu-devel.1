Received: from eggs.gnu.org ([209.51.188.92]:34692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2NhD-00019z-A1
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2NhC-0001xL-ED
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:10:27 -0500
References: <20190305234337.18353-1-jsnow@redhat.com>
	<20190305234337.18353-2-jsnow@redhat.com>
	<714826c3-13a8-75e0-fbc8-b98f72edd359@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a0bc9191-b9c3-aedf-bbd7-3b6a9e403a98@redhat.com>
Date: Fri, 8 Mar 2019 17:10:22 -0500
MIME-Version: 1.0
In-Reply-To: <714826c3-13a8-75e0-fbc8-b98f72edd359@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] block/qcow2-bitmap: Skip length check
 in some cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 3/6/19 11:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> 06.03.2019 2:43, John Snow wrote:
>> If we were to allow resizes, the length check that happens when we load
>> bitmap headers from disk when we read or store bitmaps would begin to
>> fail:
>>
>> Imagine the circumstance where we've resized bitmaps in memory, but they still
>> have the old values on-disk. The lengths will no longer match bdrv_getlength,
>> so we must allow this check to be skipped when flushing bitmaps to disk.
>>
>> Limit this to when we are about to overwrite the headers: we will verify the
>> outgoing headers, but we will skip verifying the known stale headers.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/qcow2-bitmap.c | 34 +++++++++++++++++++++-------------
>>   1 file changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index c3b210ede1..d02730004a 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -435,7 +435,8 @@ static inline Qcow2BitmapDirEntry *next_dir_entry(Qcow2BitmapDirEntry *entry)
>>       return (Qcow2BitmapDirEntry *)((uint8_t *)entry + dir_entry_size(entry));
>>   }
>>   
>> -static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *entry)
>> +static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *entry,
>> +                           bool allow_resize)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>>       uint64_t phys_bitmap_bytes;
>> @@ -462,8 +463,14 @@ static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *entry)
>>           return len;
>>       }
>>   
>> -    fail = (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) ||
>> -           (len > ((phys_bitmap_bytes * 8) << entry->granularity_bits));
>> +    if (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!allow_resize &&
>> +        (len > ((phys_bitmap_bytes * 8) << entry->granularity_bits))) {
>> +        return -EINVAL;
>> +    }
> 
> now I think, that we don't need additional parameter, but instead do this check only if
> ! entry->flags & BME_FLAG_IN_USE, which will correspond to:
> 
> 1. incoming: bitmap loaded from image
> 2. outgoing: bitmap stored to the image
> 

I can't tell if I like this or not, because we'd skip checking the image
on load if it was improperly stored. I guess that's... fine.

Though, it would mean we also skip the consistency check on subsequent
re-reads of the bitmap list, which I think we still want if only as a
sanity check on the code, right?

Further thoughts?

(Maybe this portion of the code is due for a refactor in 4.1 so we can
add better error messages to it, like Eric suggests.)
