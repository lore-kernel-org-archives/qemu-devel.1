Received: from eggs.gnu.org ([2001:4830:134:3::10]:54213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzNfZ-0003Jh-Ar
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzNfW-0007Wu-7Z
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:00:05 -0400
References: <20180814121443.33114-1-vsementsov@virtuozzo.com>
	<20180814121443.33114-2-vsementsov@virtuozzo.com>
	<954db07e-d338-9cd4-341f-d8916470b89b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <647f800e-f5f6-598c-38f0-309ae2d80650@redhat.com>
Date: Mon, 10 Sep 2018 09:59:48 -0500
MIME-Version: 1.0
In-Reply-To: <954db07e-d338-9cd4-341f-d8916470b89b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/8] dirty-bitmap: improve
 bdrv_dirty_bitmap_next_zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org

On 9/7/18 4:49 PM, John Snow wrote:
> 
> 
> On 08/14/2018 08:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Add bytes parameter to the function, to limit searched range.
>>
> 
> I'm going to assume that Eric Blake has been through here and commented
> on the interface itself.

Actually, I haven't had time to look at this series in depth. Do you 
need me to?

> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/dirty-bitmap.h |  3 ++-
>>   include/qemu/hbitmap.h       | 10 ++++++++--
>>   block/backup.c               |  2 +-
>>   block/dirty-bitmap.c         |  5 +++--
>>   nbd/server.c                 |  2 +-
>>   tests/test-hbitmap.c         |  2 +-
>>   util/hbitmap.c               | 25 ++++++++++++++++++++-----
>>   7 files changed, 36 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
>> index 259bd27c40..27f5299c4e 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -98,7 +98,8 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
>>   BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>>                                           BdrvDirtyBitmap *bitmap);
>>   char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
>> -int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start);
>> +int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start,
>> +                                    int64_t end);

It's already seeming a bit odd to mix uint64_t AND int64_t for the two 
parameters.  Is the intent to allow -1 to mean "end of the bitmap 
instead of a specific end range"? But you can get that with UINT64_MAX 
just as easily, and still get away with spelling it -1 in the source.


>> + * the bitmap end.
>>    */
>> -int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start);
>> +int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, int64_t end);
>>   
> 
> The interface looks weird because we can define a 'start' that's beyond
> the 'end'.
> 
> I realize that you need a signed integer for 'end' to signify EOF...
> should we do a 'bytes' parameter instead? (Did you already do that in an
> earlier version and we changed it?)
> 
> Well, it's not a big deal to me personally.

It should always be possible to convert in either direction between 
[start,end) and [start,start+bytes); it boils down to a question of 
convenience (which form is easier for the majority of callers) and 
consistency (which form do we use more frequently in the block layer). I 
haven't checked closely, but I think start+bytes is more common than end 
in our public block layer APIs.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
