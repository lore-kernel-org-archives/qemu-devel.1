Received: from eggs.gnu.org ([2001:4830:134:3::10]:49221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6DVm-0005A9-Ve
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6DVm-0002jb-4M
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:57:27 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-16-pbonzini@redhat.com>
	<20170504075536.GB4725@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2edc4902-8698-369d-ec36-2e15c8186619@redhat.com>
Date: Thu, 4 May 2017 11:57:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170504075536.GB4725@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/17] block: introduce dirty_bitmap_mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 04/05/2017 09:55, Fam Zheng wrote:
> On Thu, 04/20 14:00, Paolo Bonzini wrote:
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 519737c..e13718e 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -52,6 +52,24 @@ struct BdrvDirtyBitmapIter {
>>      BdrvDirtyBitmap *bitmap;
>>  };
>>  
>> +static QemuMutex dirty_bitmap_mutex;
>> +
>> +static void __attribute__((__constructor__)) bdrv_dirty_bitmaps_init_lock(void)
>> +{
>> +    qemu_mutex_init(&dirty_bitmap_mutex);
>> +}
>> +
>> +static inline void bdrv_dirty_bitmaps_lock(BlockDriverState *bs)
>> +{
>> +    qemu_mutex_lock(&dirty_bitmap_mutex);
>> +}
>> +
>> +static inline void bdrv_dirty_bitmaps_unlock(BlockDriverState *bs)
>> +{
>> +    qemu_mutex_unlock(&dirty_bitmap_mutex);
>> +}
> 
> Why a global lock instead of a per-BDS one? The contention can be heavy if a
> block job is made to run on a different thread than the one processing guest
> I/O.

Yes, I'll introduce bs->dirty_bitmap_mutex in this patch already.

>> @@ -508,12 +550,19 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
>>                      int64_t nr_sectors)
>>  {
>>      BdrvDirtyBitmap *bitmap;
>> +
>> +    if (QLIST_EMPTY(&bs->dirty_bitmaps)) {
>> +        return;
>> +    }
> 
> Should this check be protected by lock/unlock? Or simply removed?

The check avoids taking the lock in the common case of having no dirty
bitmap.

Paolo

>> +
>> +    bdrv_dirty_bitmaps_lock(bs);
>>      QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
>>          if (!bdrv_dirty_bitmap_enabled(bitmap)) {
>>              continue;
>>          }
>>          hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
>>      }
>> +    bdrv_dirty_bitmaps_unlock(bs);
>>  }
>>  
>>  /**
> 
> Fam
> 
> 
