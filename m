Received: from eggs.gnu.org ([2001:4830:134:3::10]:55031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6alx-00024c-PS
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6alw-00021z-VN
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:47:41 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-17-pbonzini@redhat.com>
	<20170505103658.GB11350@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca446302-518f-63bc-9022-5b2f7182cb1a@redhat.com>
Date: Fri, 5 May 2017 12:47:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170505103658.GB11350@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 16/17] block: protect
 modification of dirty bitmaps with a mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 05/05/2017 12:36, Stefan Hajnoczi wrote:
> On Thu, Apr 20, 2017 at 02:00:57PM +0200, Paolo Bonzini wrote:
>> @@ -410,6 +442,18 @@ int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
>>      }
>>  }
>>  
>> +int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
>> +                   int64_t sector)
> 
> Is it a good idea to offer an unlocked bdrv_get_dirty() API?  It
> encourages non-atomic access to the bitmap, e.g.
> 
>   if (bdrv_get_dirty()) {
>       ...do something outside the lock...
>       bdrv_reset_dirty_bitmap();
>   }
> 
> The unlocked API should be test-and-set/clear instead so that callers
> automatically avoid race conditions.

I'm not sure it's possible to implement atomic test and clear for
HBitmap.  But I can look into removing unlocked bdrv_get_dirty, the only
user is block migration.

>> diff --git a/block/mirror.c b/block/mirror.c
>> index dc227a2..6a5b0f8 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -344,10 +344,12 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>>  
>>      sector_num = bdrv_dirty_iter_next(s->dbi);
>>      if (sector_num < 0) {
>> +        bdrv_dirty_bitmap_lock(s->dirty_bitmap);
> 
> bdrv_dirty_iter_next() is listed under "functions that require manual
> locking" but it's being called outside of the lock.

Thanks, will fix.

Paolo
