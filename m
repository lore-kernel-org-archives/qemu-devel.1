Received: from eggs.gnu.org ([209.51.188.92]:43275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvsIi-0003mH-2f
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvsGm-00077A-8O
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:24:16 -0500
References: <20190213232356.21034-1-jsnow@redhat.com>
	<20190213232356.21034-6-jsnow@redhat.com>
	<bfa23558-e7f3-cfc8-21a5-dd544ea56ad2@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <180f5bd2-8bcf-fef1-5b69-6e1d0aad2beb@redhat.com>
Date: Mon, 18 Feb 2019 18:24:07 -0500
MIME-Version: 1.0
In-Reply-To: <bfa23558-e7f3-cfc8-21a5-dd544ea56ad2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] block/dirty-bitmaps: unify
 qmp_locked and user_locked calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, "libvir-list@redhat.com" <libvir-list@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



On 2/18/19 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
> 14.02.2019 2:23, John Snow wrote:
>> These mean the same thing now. Unify them and rename the merged call
>> bdrv_dirty_bitmap_busy to indicate semantically what we are describing,
>> as well as help disambiguate from the various _locked and _unlocked
>> versions of bitmap helpers that refer to mutex locks.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   block/dirty-bitmap.c           | 41 +++++++++++++++-------------------
>>   blockdev.c                     | 18 +++++++--------
>>   include/block/dirty-bitmap.h   |  5 ++---
>>   migration/block-dirty-bitmap.c |  6 ++---
>>   nbd/server.c                   |  6 ++---
>>   5 files changed, 35 insertions(+), 41 deletions(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 2042c62602..8ab048385a 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -48,9 +48,9 @@ struct BdrvDirtyBitmap {
>>       QemuMutex *mutex;
>>       HBitmap *bitmap;            /* Dirty bitmap implementation */
>>       HBitmap *meta;              /* Meta dirty bitmap */
>> -    bool qmp_locked;            /* Bitmap is locked, it can't be modified
>> -                                   through QMP */
>> -    BdrvDirtyBitmap *successor; /* Anonymous child; implies user_locked state */
>> +    bool busy;                  /* Bitmap is busy, it can't be modified through
>> +                                   QMP */
> 
> better not "modified" but "used".. for example, export through NBD is not a modification.
> 

True.

>> +    BdrvDirtyBitmap *successor; /* Anonymous child, if any. */
> 
> hm this comment change about successor relates more to previous patch, but I don't really care.
> 

Oh, true.

>>       char *name;                 /* Optional non-empty unique ID */
>>       int64_t size;               /* Size of the bitmap, in bytes */
>>       bool disabled;              /* Bitmap is disabled. It ignores all writes to
>> @@ -188,22 +188,17 @@ bool bdrv_dirty_bitmap_has_successor(BdrvDirtyBitmap *bitmap)
>>       return bitmap->successor;
>>   }
>>   
> 
> 
> In comment for bdrv_dirty_bitmap_create_successor, there is "locked" word, which you forget to fix to "busy"
> with at least this fixed:

Good spot. Too many occurrences of the word "lock" to have looked for
them all.

> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> 
