Received: from eggs.gnu.org ([2001:4830:134:3::10]:33986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7m1b-0006Zd-5d
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7lso-0007tV-0l
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:28:26 -0400
References: <20181002230218.13949-1-jsnow@redhat.com>
	<20181002230218.13949-2-jsnow@redhat.com>
	<f803d9c8-90e0-56c7-320d-0c19d8b5b284@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <435f5820-c7fd-e1b0-b1d5-26e2a5de9c61@redhat.com>
Date: Wed, 3 Oct 2018 14:28:05 -0400
MIME-Version: 1.0
In-Reply-To: <f803d9c8-90e0-56c7-320d-0c19d8b5b284@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/6] block/dirty-bitmaps: add
 user_locked status checker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 10/03/2018 08:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> 03.10.2018 02:02, John Snow wrote:
>> Instead of both frozen and qmp_locked checks, wrap it into one check.
>> frozen implies the bitmap is split in two (for backup), and shouldn't
>> be modified. qmp_locked implies it's being used by another operation,
>> like being exported over NBD. In both cases it means we shouldn't allow
>> the user to modify it in any meaningful way.
>>
>> Replace any usages where we check both frozen and qmp_locked with the
>> new check.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/dirty-bitmap.c           |  6 ++++++
>>  blockdev.c                     | 29 ++++++++---------------------
>>  include/block/dirty-bitmap.h   |  1 +
>>  migration/block-dirty-bitmap.c | 10 ++--------
>>  4 files changed, 17 insertions(+), 29 deletions(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 8ac933cf1c..85bc668f6a 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -176,6 +176,12 @@ bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap)
>>      return bitmap->successor;
>>  }
>>  
>> +/* Both conditions disallow user-modification via QMP. */
>> +bool bdrv_dirty_bitmap_user_locked(BdrvDirtyBitmap *bitmap) {
>> +    return (bdrv_dirty_bitmap_frozen(bitmap) ||
>> +            bdrv_dirty_bitmap_qmp_locked(bitmap));
> 
> hmm, extra parentheses

I'm fond of them, but I'll take them out.

> 
>> +}
>> +
>>  void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked)
>>  {
>>      qemu_mutex_lock(bitmap->mutex);
> 
> [...]
> 
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -301,14 +301,8 @@ static int init_dirty_bitmap_migration(void)
>>                  goto fail;
>>              }
>>  
>> -            if (bdrv_dirty_bitmap_frozen(bitmap)) {
>> -                error_report("Can't migrate frozen dirty bitmap: '%s",
>> -                             bdrv_dirty_bitmap_name(bitmap));
>> -                goto fail;
>> -            }
>> -
>> -            if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
>> -                error_report("Can't migrate locked dirty bitmap: '%s",
>> +            if (bdrv_dirty_bitmap_user_locked(bitmap)) {
>> +                error_report("Can't migrate a bitmap that is in use: '%s'",
> 
> "by another operation" like in other cases?
> 

Oh, sure. Can't hurt.

>>                               bdrv_dirty_bitmap_name(bitmap));
>>                  goto fail;
>>              }
> 
> anyway,
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> -- 
> Best regards,
> Vladimir
> 

Thanks, I'll just make these edits and trust that Eric is fine with it
as well.

--js
